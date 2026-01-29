use fancy_regex::Regex;
use image::ImageFormat;
use rayon::prelude::*;
use serde::Serialize;
use serde_json;
use std::io::Cursor;
use std::process::Command;

fn main() {
    // Execute 'clipvault list' and capture its output
    let output = Command::new("clipvault")
        .arg("list")
        .output()
        .expect("Failed to execute 'clipvault list'");

    // Convert the stdout (in bytes) to a string
    let stdout = String::from_utf8_lossy(&output.stdout);

    // Construct and pre-compile regex, which is thread-safe
    let pattern = r"^\d*\s*\[\[ binary data.*\]\]$";
    let re = Regex::new(pattern).unwrap();

    // Take the first 100 lines and collect them into a Vector.
    // We collect first because Rayon needs a collection to split work across threads.
    let lines: Vec<&str> = stdout.lines().take(100).collect();

    // Use rayon to process in parallel
    let data: Vec<PipeData> = lines
        .into_par_iter()
        .map(|line| {
            let mut title = None;
            let mut binary: Option<Vec<u8>> = None;
            let mut result = None;

            if let Some((id, t)) = line.split_once("\t") {
                title = Some(t.to_string());
                result = Some(id.to_string());

                if re.is_match(line).unwrap_or(false) {
                    // This command now runs in a separate thread
                    let decoded_output = Command::new("clipvault")
                        .arg("get")
                        .arg(id)
                        .output()
                        .expect("Failed to execute 'clipvault get'");

                    binary = Some(decoded_output.stdout);
                }
            }

            PipeData {
                title,
                result,
                binary,
                icon_size: Some(100),
            }
        })
        .collect(); // Rayon collects the results back in the correct order

    // Serialize to json and print
    let res = PipeResult::new(data);

    let json = serde_json::to_string(&res).expect("failed to serialize");
    print!("{}", json);
}

#[derive(Debug, Serialize, Clone)]
pub struct PipeData {
    pub title: Option<String>,
    pub result: Option<String>,
    pub binary: Option<Vec<u8>>,
    pub icon_size: Option<i32>,
}

#[derive(Debug, Serialize, Clone)]
pub struct PipeResult {
    settings: Vec<String>,
    elements: Vec<PipeData>,
}

impl PipeResult {
    fn new(data: Vec<PipeData>) -> Self {
        Self {
            settings: Vec::new(),
            elements: data,
        }
    }
}

use regex::Regex;
use serde::Serialize;
use serde_json;
// use std::io::Write;
use std::process::Command;
// use std::process::Stdio;

fn main() {
    // Execute 'clipvault list' and capture its output
    let output = Command::new("clipvault")
        .arg("list")
        .output()
        .expect("Failed to execute 'clipvault list'");

    // Convert the stdout (in bytes) to a string and then lines
    let stdout = String::from_utf8_lossy(&output.stdout);
    let lines = stdout.lines();

    // Construct regex
    let pattern =
        // r"\[\[.*\]\]|(?i)\bbinary\b|image/|video/|pdf|application/";
        r"^\d*\s*\[\[ binary data.*\]\]$";
    let re = Regex::new(pattern).unwrap();

    // let mut elements: Vec<PipeData> = Vec::with_capacity(64);

    // iterate through the lines and process
    let data: Vec<PipeData> = lines
        .take(20)
        .map(|line| {
            let mut title = None;
            let mut binary: Option<Vec<u8>> = None;
            let mut result = None;

            if let Some((id, t)) = line.split_once('\t') {
                title = Some(t.to_string());
                result = Some(id.to_string());

                // If the preview suggests binary/image/video/pdf/etc., fetch the raw data
                if re.is_match(line) {
                    // Use `clipvault get` and send the id on stdin (matches the pipe usage)
                    let decoded_output = Command::new("clipvault")
                        .arg("get")
                        .arg(id)
                        .output()
                        .expect("Failed to execute 'clipvault get'");

                    binary = Some(decoded_output.stdout);
                }
            }

            // Return a PipeData instance
            PipeData {
                title,
                result,
                binary,
                icon_size: Some(100),
            }
        })
        .collect();

    // Serialize to json and print
    let res = PipeResult::new(data);

    let json = serde_json::to_string(&res).expect("failed to serialize");
    print!("{}", json);
}

#[derive(Debug, Serialize, Clone)]
pub struct PipeData {
    pub title: Option<String>,
    pub result: Option<String>,
    pub binary: Option<Vec<u8>>, //Option<String>, base64 thumbnail
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

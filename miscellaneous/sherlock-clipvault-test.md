without /sherlock-thumbnails folder

hyperfine --warmup 3 \
  "./target/release/sherlock-clipvault" \
  "./target/release/sherlock-clipvault --shrink-images"

Test 1:

Benchmark 1: ./target/release/sherlock-clipvault
  Time (mean ± σ):     333.7 ms ±   8.1 ms    [User: 268.2 ms, System: 339.0 ms]
  Range (min … max):   322.3 ms … 346.5 ms    10 runs

Benchmark 2: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     326.4 ms ±   3.6 ms    [User: 266.9 ms, System: 312.7 ms]
  Range (min … max):   323.1 ms … 334.3 ms    10 runs

Summary
  ./target/release/sherlock-clipvault --shrink-images ran
    1.02 ± 0.03 times faster than ./target/release/sherlock-clipvault
    
Test 2:

Benchmark 1: ./target/release/sherlock-clipvault
  Time (mean ± σ):     320.5 ms ±   1.7 ms    [User: 265.0 ms, System: 309.4 ms]
  Range (min … max):   318.3 ms … 324.2 ms    10 runs

Benchmark 2: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     321.5 ms ±   1.4 ms    [User: 263.6 ms, System: 300.9 ms]
  Range (min … max):   319.4 ms … 323.3 ms    10 runs

Summary
  ./target/release/sherlock-clipvault ran
    1.00 ± 0.01 times faster than ./target/release/sherlock-clipvault --shrink-images
    
Test 3:

Benchmark 1: ./target/release/sherlock-clipvault
  Time (mean ± σ):     393.7 ms ±   4.5 ms    [User: 359.9 ms, System: 417.3 ms]
  Range (min … max):   382.7 ms … 398.8 ms    10 runs

Benchmark 2: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     392.7 ms ±   4.9 ms    [User: 345.2 ms, System: 424.0 ms]
  Range (min … max):   387.3 ms … 402.8 ms    10 runs

Summary
  ./target/release/sherlock-clipvault --shrink-images ran
    1.00 ± 0.02 times faster than ./target/release/sherlock-clipvault

hyperfine --prepare "rm -rf /tmp/sherlock-thumbnails/*" \
  "./target/release/sherlock-clipvault --shrink-images"

Test 1:

Benchmark 1: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     389.8 ms ±   2.7 ms    [User: 352.3 ms, System: 406.3 ms]
  Range (min … max):   384.1 ms … 393.6 ms    10 runs

Test 2:

Benchmark 1: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     394.6 ms ±   5.3 ms    [User: 354.7 ms, System: 436.6 ms]
  Range (min … max):   384.3 ms … 403.2 ms    10 runs
  
Test 3:

Benchmark 1: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     398.4 ms ±   5.2 ms    [User: 356.4 ms, System: 431.6 ms]
  Range (min … max):   388.2 ms … 404.4 ms    10 runs


sherlock-thumbnails folder created

hyperfine --warmup 3 \
  "./target/release/sherlock-clipvault" \
  "./target/release/sherlock-clipvault --shrink-images"

Test 1:

Benchmark 1: ./target/release/sherlock-clipvault
  Time (mean ± σ):     375.9 ms ±   8.8 ms    [User: 343.5 ms, System: 408.0 ms]
  Range (min … max):   361.3 ms … 389.2 ms    10 runs

Benchmark 2: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     367.8 ms ±   4.5 ms    [User: 332.8 ms, System: 400.3 ms]
  Range (min … max):   362.3 ms … 375.8 ms    10 runs

Summary
  ./target/release/sherlock-clipvault --shrink-images ran
    1.02 ± 0.03 times faster than ./target/release/sherlock-clipvault
    
Test 2:

Benchmark 1: ./target/release/sherlock-clipvault
  Time (mean ± σ):     373.6 ms ±   5.2 ms    [User: 340.4 ms, System: 418.2 ms]
  Range (min … max):   368.2 ms … 382.8 ms    10 runs

Benchmark 2: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     375.0 ms ±   8.4 ms    [User: 340.8 ms, System: 410.5 ms]
  Range (min … max):   364.2 ms … 390.7 ms    10 runs

Summary
  ./target/release/sherlock-clipvault ran
    1.00 ± 0.03 times faster than ./target/release/sherlock-clipvault --shrink-images
    
Test 3:

Benchmark 1: ./target/release/sherlock-clipvault
  Time (mean ± σ):     363.1 ms ±   3.0 ms    [User: 329.0 ms, System: 396.1 ms]
  Range (min … max):   359.3 ms … 370.3 ms    10 runs

Benchmark 2: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     378.5 ms ±   9.5 ms    [User: 342.3 ms, System: 422.4 ms]
  Range (min … max):   361.7 ms … 392.2 ms    10 runs

Summary
  ./target/release/sherlock-clipvault ran
    1.04 ± 0.03 times faster than ./target/release/sherlock-clipvault --shrink-images

hyperfine --prepare "rm -rf /tmp/sherlock-thumbnails/*" \
  "./target/release/sherlock-clipvault --shrink-images"

Test 1:

Benchmark 1: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     402.0 ms ±   3.7 ms    [User: 380.7 ms, System: 456.3 ms]
  Range (min … max):   392.5 ms … 406.0 ms    10 runs
  
Test 2:

Benchmark 1: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     414.9 ms ±  11.0 ms    [User: 393.1 ms, System: 495.7 ms]
  Range (min … max):   398.2 ms … 432.8 ms    10 runs
  
Test 3:

Benchmark 1: ./target/release/sherlock-clipvault --shrink-images
  Time (mean ± σ):     407.9 ms ±   8.7 ms    [User: 379.4 ms, System: 480.8 ms]
  Range (min … max):   395.8 ms … 422.2 ms    10 runs

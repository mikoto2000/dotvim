use std::str::FromStr;

let mut line{{_input_:lineNumber}} = String::new();
std::io::stdin().read_line(&mut line{{_input_:lineNumber}}).ok();
line{{_input_:lineNumber}} = line{{_input_:lineNumber}}.trim().parse::<String>().ok().unwrap();
let line{{_input_:lineNumber}}: Vec<&str> = line{{_input_:lineNumber}}.split_whitespace().collect();
let a: u32 = FromStr::from_str(&line{{_input_:lineNumber}}[0]).unwrap();
let b: u32 = FromStr::from_str(&line{{_input_:lineNumber}}[1]).unwrap();
let c: u32 = FromStr::from_str(&line{{_input_:lineNumber}}[2]).unwrap();

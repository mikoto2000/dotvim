let mut line2 = String::new();
std::io::stdin().read_line(&mut line2).ok();
line2 = line2.trim().parse::<String>().ok().unwrap();
let mut line2: Vec<u64> = line2.split_whitespace().map(|v| FromStr::from_str(&v).unwrap()).collect();

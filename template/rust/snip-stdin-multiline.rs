loop {

    let mut line1 = String::new();
    let stdin = std::io::stdin();
    let mut handle = stdin.lock();
    let read = handle.read_line(&mut line1).ok();
    if read == Some(0) {
        break;
    }
    line1 = line1.trim().parse::<String>().ok().unwrap();
    line1 = line1.to_lowercase();

    ${1:PROCESS}

}

// ファイルを読み込み、 Reader 化
let file_path = "${1:FILE_PATH}";
let file = File::open(file_path).unwrap();
let reader = BufReader::new(file);


use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    let f = File::open("input.txt").expect("Unable to open input file");
    let f = BufReader::new(f);
    let mut vec = Vec::new();

    for line in f.lines() {
        let line = line.expect("Unable to read line");
        vec.push(line);
    }
}

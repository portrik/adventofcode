use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    // Loads the input file line by line into a vector
    let f = BufReader::new(File::open("input.txt").expect("Unable to open input file"));
    let mut vec = Vec::new();
    for line in f.lines() {
        let line = line.expect("Unable to read line");
        vec.push(line);
    }
}

use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    let f = File::open("input.txt").expect("Unable to open input file");
    let f = BufReader::new(f);
    let mut vec = Vec::new();

    for line in f.lines() {
        let line = line.expect("Unable to read line");
        vec.push(line.trim().parse::<i32>().unwrap());
    }

    let (a, b) = find_addition(&vec, &2020).unwrap_or_default();
    println!("Result 1: {}", a * b);

    for num in &vec {
        let (c, d) = find_addition(&vec, &(2020 - num)).unwrap_or_default();

        if c > 0 && d > 0 {
            println!("Result 2: {}", num * c * d);
            break;
        }
    }
}

fn find_addition(source: &Vec<i32>, count: &i32) -> Option<(i32, i32)> {
    for num in source {
        let needed = count - num;

        if source.iter().any(|v| v == &needed) {
            return Some((*num, needed));
        }
    }

    None
}

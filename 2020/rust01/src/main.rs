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

    let (a, b) = find_addition(&vec, &2020);
    println!("Result 1: {}", a * b);

    for num in &vec {
        let (c, d) = find_addition(&vec, &(2020 - num));

        if c > 0 && d > 0 {
            println!("Result 2: {}", num * c * d);
            break;
        }
    }
}

fn find_addition(source: &Vec<i32>, count: &i32) -> (i32, i32) {
    let mut result_a: i32 = 0;
    let mut result_b: i32 = 0;

    for num in source {
        let needed = count - num;

        if source.iter().any(|v| v == &needed) {
            result_a = *num;
            result_b = needed;
            break;
        }
    }

    (result_a, result_b)
}

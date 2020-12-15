use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    // Loads the input file line by line into a vector
    let f = BufReader::new(File::open("input.txt").expect("Unable to open input file"));
    let mut vec = Vec::new();
    for line in f.lines() {
        vec.push(line.expect("Unable to read line"));
    }

    let mut numbers: Vec<u32> = vec[0]
        .split(",")
        .map(|n| n.parse().expect("Parse error"))
        .collect();

    for i in numbers.len()..2020 {
        let position = get_last_position(numbers[i - 1], &numbers);

        if position.is_some() {
            numbers.push(i as u32 - position.unwrap() - 1);
        } else {
            numbers.push(0);
        }
    }

    println!("Result 1: {}", numbers[numbers.len() - 1]);
}

fn get_last_position(num: u32, vec: &Vec<u32>) -> Option<u32> {
    for i in (0..vec.len() - 1).rev() {
        if num == vec[i] {
            return Some(i as u32);
        }
    }

    None
}

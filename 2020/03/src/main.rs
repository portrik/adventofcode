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

    let one_one = count_trees(&vec, 1, 1);
    let three_one = count_trees(&vec, 3, 1);
    let five_one = count_trees(&vec, 5, 1);
    let seven_one = count_trees(&vec, 7, 1);
    let one_two = count_trees(&vec, 1, 2);

    println!("Right 1, down 1: {}", one_one);
    println!("Right 3, down 1 (first result): {}", three_one);
    println!("Right 5, down 1: {}", five_one);
    println!("Right 7, down 1: {}", seven_one);
    println!("Right 1, down 2: {}", one_two);
    println!(
        "Multiplied together: {}",
        one_one * three_one * five_one * seven_one * one_two
    );
}

fn count_trees(slope: &Vec<String>, right: usize, down: usize) -> u64 {
    let mut position: usize = 0;
    let mut result: u64 = 0;
    let mut i: usize = 0;

    while i < slope.len() - down {
        position = (position + right) % slope[i].len();
        i += down;

        if slope[i].chars().collect::<Vec<char>>()[position] == '#' {
            result += 1;
        }
    }

    result
}

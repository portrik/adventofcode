use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    // Loads the input file line by line into a vector
    let f = BufReader::new(File::open("input.txt").expect("Unable to open input file"));
    let mut vec = Vec::new();
    for line in f.lines() {
        let line = line.expect("Unable to read line");
        vec.push(line.trim().chars().collect::<Vec<char>>());
    }

    let result1 = count_trees(&vec, 3, 1);
    println!("First Part: {}", result1);
    println!(
        "Second Part: {}",
        count_trees(&vec, 1, 1)
            * result1
            * count_trees(&vec, 5, 1)
            * count_trees(&vec, 7, 1)
            * count_trees(&vec, 1, 2)
    );
}

fn count_trees(slope: &Vec<Vec<char>>, right: usize, down: usize) -> u64 {
    let mut position: usize = 0;
    let mut i: usize = 0;
    let mut result: u64 = 0;

    while i < slope.len() - down {
        position = (position + right) % slope[i].len();
        i += down;

        if slope[i][position] == '#' {
            result += 1;
        }
    }

    result
}

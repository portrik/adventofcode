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

    let mut result1: u32 = 0;
    let mut passes: Vec<u32> = Vec::new();

    for pass in vec {
        let (row, column) = convert_pass(&pass);
        let seat_id: u32 = row * 8 + column;
        passes.push(seat_id);

        if seat_id > result1 {
            result1 = seat_id;
        }
    }
    println!("Result 1: {}", result1);
    
    // Ugly bruteforce solution
    passes.sort();
    let mut result2: u32 = 0;
    for i in 0..passes.len() - 1 {
        if passes[i + 1] != passes[i] + 1 {
            result2 = passes[i] + 1;
        }
    }
    println!("Result 2: {}", result2);
}

fn convert_pass(pass: &str) -> (u32, u32) {
    let mut row: u32 = 0;
    let mut column: u32 = 0;
    let pass_vec = pass.chars().collect::<Vec<char>>();

    for i in 0..7 {
        if pass_vec[i] == 'B' {
            row += (2 as u32).pow(6 - i as u32);
        }
    }

    for i in 7..10 {
        if pass_vec[i] == 'R' {
            column += (2 as u32).pow(9 - i as u32);
        }
    }

    (row, column)
}

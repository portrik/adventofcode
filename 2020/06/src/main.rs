use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

use std::collections::HashMap;

fn main() {
    // Loads the input file line by line into a vector
    let f = BufReader::new(File::open("input.txt").expect("Unable to open input file"));
    let mut vec = Vec::new();
    for line in f.lines() {
        vec.push(line.expect("Unable to read line"));
    }

    let mut i: usize = 0;
    let mut result1: u32 = 0;
    let mut result2: u32 = 0;

    while i < vec.len() {
        let mut declaration: Vec<&str> = Vec::new();
        let mut line = &vec[i];

        while line.trim().len() > 0 && i < vec.len() {
            declaration.push(&line);

            i += 1;
            if i < vec.len() {
                line = &vec[i];
            }
        }
        i += 1;

        result1 += count_answers(&declaration);
        result2 += count_common_answers(&declaration);
    }

    println!("Result 1: {}", result1);
    println!("Result 2: {}", result2);
}

fn count_answers(declaration: &Vec<&str>) -> u32 {
    let mut answers: Vec<char> = Vec::new();

    for line in declaration {
        for answer in line.chars().collect::<Vec<char>>() {
            if !answers.iter().any(|&i| i == answer) {
                answers.push(answer)
            }
        }
    }

    answers.len() as u32
}

fn count_common_answers(declaration: &Vec<&str>) -> u32 {
    let mut answers = HashMap::new();

    for line in declaration {
        for answer in line.chars().collect::<Vec<char>>() {
            // Pretty cool HashMap trick to insert new value
            // Or update existing one
            let count = answers.entry(answer).or_insert(0);
            *count += 1;
        }
    }

    let mut result: u32 = 0;

    for (_key, value) in &answers {
        if value == &declaration.len() {
            result += 1;
        }
    }

    result
}

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

    let mut result1 = 0;
    let mut result2 = 0;

    for i in &vec {
        let split = i.split(":").collect::<Vec<&str>>();
        let mut meta_data = split[0].split(" ").collect::<Vec<&str>>();
        let to_check = meta_data[1].trim().chars().next().unwrap();
        meta_data = meta_data[0].split("-").collect::<Vec<&str>>();
        let min = meta_data[0].trim().parse::<u32>().unwrap();
        let max = meta_data[1].trim().parse::<u32>().unwrap();
        let password = split[1].trim();

        let count = get_count(to_check, &password);
        if count >= min && count <= max {
            result1 += 1;
        }

        let second_check = password.chars().collect::<Vec<char>>();
        if (second_check[(min - 1) as usize] == to_check && second_check[(max - 1) as usize] != to_check)
            || (second_check[(min - 1) as usize] != to_check && second_check[(max - 1) as usize] == to_check)
        {
            result2 += 1;
        }
    }

    println!("Result 1: {}", result1);
    println!("Result 2: {}", result2);
}

fn get_count(to_find: char, source: &str) -> u32 {
    let mut result = 0;

    for i in source.chars() {
        if i == to_find {
            result += 1;
        }
    }

    result
}

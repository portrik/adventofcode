use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn calculate_fuel(mass: i32) -> i32 {
    return mass / 3 - 2;
}

fn main() {
    let f = File::open("input.txt").expect("Unable to open input file");
    let f = BufReader::new(f);
    let mut vec = Vec::new();
    let mut result1: i32 = 0;
    let mut result2: i32 = 0;

    for line in f.lines() {
        let line = line.expect("Unable to read line");
        vec.push(line.trim().parse::<i32>().unwrap());
    }

    for num in vec {
        let mut temp = calculate_fuel(num);
        result1 += temp;
        result2 += temp;

        while temp > 0 {
            temp = calculate_fuel(temp);
            if temp > 0 {
                result2 += temp;
            }
        }
    }

    println!("Part 1 result is {}", result1);
    println!("Part 2 result is {}", result2);
}

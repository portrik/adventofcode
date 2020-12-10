use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    // Loads the input file line by line into a vector
    let f = BufReader::new(File::open("test_input.txt").expect("Unable to open input file"));
    let mut vec = Vec::new();
    for line in f.lines() {
        vec.push(line.expect("Unable to read line").parse::<u32>().unwrap());
    }

    let wall = 0;
    vec.sort();

    let (valid, one_jolt, three_jolt) = get_highest_jolts(&vec, wall);

    println!("Result 1: {}", one_jolt * three_jolt);
    println!("Result 2: {}", calculate_permutations(&valid));
}

fn get_highest_jolts(adapters: &Vec<u32>, start: u32) -> (Vec<u32>, u32, u32) {
    let mut highest = start;
    let mut one_jolt = 0;
    let mut three_jolt = 1;
    let mut i = 0;
    let mut valid: Vec<u32> = Vec::new();

    while i < adapters.len() {
        if adapters[i] <= highest + 3 {
            if adapters[i] - highest == 3 {
                three_jolt += 1;
            } else if adapters[i] - highest == 1 {
                one_jolt += 1;
            }
            highest = adapters[i];
            valid.push(adapters[i]);
            i += 1;
        } else if i + 1 < adapters.len() && adapters[i + 1] <= highest + 3 {
            if adapters[i] - highest == 3 {
                three_jolt += 1;
            } else if adapters[i] - highest == 1 {
                one_jolt += 1;
            }

            highest = adapters[i + 1];
            valid.push(adapters[i + 1]);
            i += 1;
        } else if i + 2 < adapters.len() && adapters[i + 2] <= highest + 3 {
            if adapters[i] - highest == 3 {
                three_jolt += 1;
            } else if adapters[i] - highest == 1 {
                one_jolt += 1;
            }

            highest = adapters[i + 2];
            valid.push(adapters[i + 2]);
            i += 2;
        } else {
            i += adapters.len();
        }
    }

    (valid, one_jolt, three_jolt)
}

fn calculate_permutations(adapters: &Vec<u32>) -> u32 {
    let mut permutations: u32 = 1;
    let mut i = 0;

    while i < adapters.len() - 1 {
        let mut possibilities = 0;

        if i + 1 < adapters.len() && adapters[i] + 3 >= adapters[i + 1] {
            possibilities += 1;
        }
        if i + 2 < adapters.len() && adapters[i] + 3 >= adapters[i + 2] {
            possibilities += 1;
        }

        if i + 3 < adapters.len() && adapters[i] + 3 >= adapters[i + 3] {
            possibilities += 1;
        }

        println!("For {} are {}", adapters[i], factorial(possibilities) / factorial(3 - possibilities));
        permutations *= factorial(possibilities) / factorial(3 - possibilities);
        i += 1;
    }

    permutations
}

fn factorial(num: u32) -> u32 {
    match num {
        0 => 1,
        1 => 1,
        _ => factorial(num - 1) * num,
    }
}

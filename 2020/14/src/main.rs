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

    let result1 = count_memory(&vec);
    println!("Result 1: {}", result1);

    let result2 = count_advanced_memory(&vec);
    println!("Result 2: {}", result2);
}

fn count_memory(sequence: &Vec<String>) -> u128 {
    let mut memory: [u128; 65536] = [0; 65536];
    let mut mask: &str = "";

    for line in sequence {
        let split = line.split("=").collect::<Vec<&str>>();

        if split[0].trim() == "mask" {
            mask = split[1].trim();
        } else {
            let mut value = split[1].trim().parse::<u128>().unwrap();
            let address = split[0].split("[").collect::<Vec<&str>>()[1]
                .split("]")
                .collect::<Vec<&str>>()[0]
                .parse::<usize>()
                .unwrap();
            let chars = mask.chars().collect::<Vec<char>>();

            for i in 0..chars.len() {
                if chars[chars.len() - 1 - i] != 'X' {
                    if chars[chars.len() - 1 - i] == '1' {
                        value = value | ((2 as u128).pow(i as u32));
                    } else {
                        value = value & !((2 as u128).pow(i as u32));
                    }
                }
            }

            memory[address] = value;
        }
    }

    let mut count: u128 = 0;

    for mem in &memory {
        count += mem;
    }

    count
}

fn count_advanced_memory(sequence: &Vec<String>) -> u128 {
    let mut count: u128 = 0;
    let mut mask = "";
    let mut memory: HashMap<usize, u128> = HashMap::new();

    for inst in sequence {
        let split = inst.split("=").collect::<Vec<&str>>();

        if split[0].trim() == "mask" {
            mask = split[1].trim();
        } else {
            let value = split[1].trim().parse::<u128>().unwrap();
            let address = split[0].split("[").collect::<Vec<&str>>()[1]
                .split("]")
                .collect::<Vec<&str>>()[0]
                .parse::<usize>()
                .unwrap();

            let chars = mask.chars().collect::<Vec<char>>();
            let mut targets: Vec<usize> = Vec::new();

            for i in 0..chars.len() {
                if chars[chars.len() - 1 - i] != '0' {
                    if targets.len() < 1 {
                        targets.push(address);
                    }

                    if chars[chars.len() - 1 - i] == '1' {
                        for j in 0..targets.len() {
                            targets[j] = targets[j] | ((2 as usize).pow(i as u32));
                        }
                    } else {
                        let mut temp: Vec<usize> = Vec::new();

                        for target in &targets {
                            temp.push(target | ((2 as usize).pow(i as u32)));
                            temp.push(target & !((2 as usize).pow(i as u32)));
                        }

                        targets = temp;
                    }
                }
            }

            for target in &targets {
                memory.insert(*target, value);
            }
        }
    }

    for (_key, value) in memory {
        count += value;
    }

    count
}

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

    let (result1, _terminated_properly) = execute_code(&vec);
    println!("Result 1: {}", result1);

    // Ugly brutforce solution
    let mut result2 = 0;
    let mut i = 0;
    while i < vec.len() {
        let split = vec[i].split(" ").collect::<Vec<&str>>();

        if split[0] == "nop" {
            let mut tmp = vec.clone();
            tmp[i] = format!("{} {}", "jmp", split[1]);
            let (acc, terminated_properly) = execute_code(&tmp);

            if terminated_properly {
                result2 = acc;
                break;
            }
        } else if split[0] == "jmp" {
            let mut tmp = vec.clone();
            tmp[i] = format!("{} {}", "nop", split[1]);

            let (acc, terminated_properly) = execute_code(&tmp);

            if terminated_properly {
                result2 = acc;
                break;
            }
        }

        i += 1;
    }

    println!("Result 2: {}", result2);
}

fn execute_code(instructions: &Vec<String>) -> (i32, bool) {
    let mut acc: i32 = 0;
    let mut was_run: Vec<bool> = vec![false; instructions.len()];
    let mut i = 0;

    while i < instructions.len() {
        let split = instructions[i].trim().split(" ").collect::<Vec<&str>>();

        match split[0] {
            "nop" => {
                if was_run[i] {
                    return (acc, false);
                } else {
                    was_run[i] = true;
                    i += 1;
                }
            }
            "acc" => {
                if was_run[i] {
                    return (acc, false);
                } else {
                    was_run[i] = true;
                    acc += split[1].parse::<i32>().unwrap();
                    i += 1;
                }
            }
            "jmp" => {
                if was_run[i] {
                    return (acc, false);
                } else {
                    was_run[i] = true;
                    i = (i as i32 + split[1].parse::<i32>().unwrap()) as usize;
                }
            }
            _ => (),
        }
    }

    (acc, true)
}

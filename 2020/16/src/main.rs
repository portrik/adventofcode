use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

use std::collections::HashMap;

fn main() {
    // Loads the input file line by line into a vector
    let f = BufReader::new(File::open("test_input.txt").expect("Unable to open input file"));
    let mut vec = Vec::new();
    for line in f.lines() {
        vec.push(line.expect("Unable to read line"));
    }

    let mut rules: HashMap<&str, [u128; 4]> = HashMap::new();
    let mut i = 0;
    let mut line = &vec[i];

    while line.trim().len() > 0 {
        let (name, conditions) = parse_rule(&line);
        rules.insert(name, conditions);
        i += 1;
        line = &vec[i];
    }

    i += 2;

    let my_ticket = &vec[i]
        .split(",")
        .map(|t| t.trim().parse::<u128>().unwrap())
        .collect::<Vec<u128>>();

    i += 3;
    let mut result1: u128 = 0;
    while i < vec.len() {
        result1 += get_error_rate(&vec[i], &rules);

        i += 1;
    }

    println!("Result 1: {}", result1);
}

fn get_error_rate(ticket: &str, rules: &HashMap<&str, [u128; 4]>) -> u128 {
    let mut error_rate: u128 = 0;
    let fields = ticket
        .split(",")
        .map(|f| f.parse::<u128>().unwrap())
        .collect::<Vec<u128>>();

    for field in fields {
        let mut is_present = false;

        for (_key, value) in rules {
            if (field >= value[0] && field <= value[1]) || (field >= value[2] && field <= value[3])
            {
                is_present = true;
                break;
            }
        }

        if !is_present {
            error_rate += field;
        }
    }

    error_rate
}

fn parse_rule(source: &str) -> (&str, [u128; 4]) {
    let top_split = source.split(":").collect::<Vec<&str>>();
    let second_split = top_split[1].split(" or ").collect::<Vec<&str>>();
    let first_part = second_split[0].split("-").collect::<Vec<&str>>();
    let second_part = second_split[1].split("-").collect::<Vec<&str>>();

    let mut arr: [u128; 4] = [0; 4];
    arr[0] = first_part[0].trim().parse::<u128>().unwrap();
    arr[1] = first_part[1].trim().parse::<u128>().unwrap();
    arr[2] = second_part[0].trim().parse::<u128>().unwrap();
    arr[3] = second_part[1].trim().parse::<u128>().unwrap();

    (top_split[0], arr)
}

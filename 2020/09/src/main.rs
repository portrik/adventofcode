use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    // Loads the input file line by line into a vector
    let f = BufReader::new(File::open("input.txt").expect("Unable to open input file"));
    let mut vec = Vec::new();
    for line in f.lines() {
        vec.push(line.expect("Unable to read line").parse::<i64>().unwrap());
    }

    let preamble_size = 25;
    let mut result1: i64 = 0;

    for i in preamble_size..vec.len() - 1 {
        if !is_valid(&vec[i - preamble_size..i], vec[i]) {
            result1 = vec[i];
            break;
        }
    }

    println!("Result 1: {}", result1);
    let set = find_continuos_set(&vec, result1).unwrap();
    println!(
        "Result 2: {}",
        set.iter().max().unwrap() + set.iter().min().unwrap()
    );
}

fn is_valid(preamble: &[i64], target: i64) -> bool {
    for num in preamble {
        let to_be_found = target - num;

        if &to_be_found != num && preamble.contains(&to_be_found) {
            return true;
        }
    }

    false
}

fn find_continuos_set(source: &Vec<i64>, target: i64) -> Option<Vec<i64>> {
    for i in 0..source.len() - 1 {
        let mut cur_set: Vec<i64> = vec![source[i]];

        for j in i + 1..source.len() - 1 {
            cur_set.push(source[j]);
            let count = get_set_count(&cur_set);

            if count == target {
                return Some(cur_set);
            }

            if count > target {
                break;
            }
        }
    }

    None
}

fn get_set_count(set: &Vec<i64>) -> i64 {
    let mut count = 0;

    for num in set {
        count += num;
    }

    count
}

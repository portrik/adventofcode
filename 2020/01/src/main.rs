use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    // Loads the input file line by line into a vector
    let f = BufReader::new(File::open("input.txt").expect("Unable to open input file"));
    let mut vec = Vec::new();
    for line in f.lines() {
        let line = line.expect("Unable to read line");
        vec.push(line.trim().parse::<i32>().unwrap());
    }

    let (a, b) = find_addition(&vec, &2020).unwrap_or_default();
    println!("Result 1: {}", a * b);

    for num in &vec {
        let (c, d) = find_addition(&vec, &(2020 - num)).unwrap_or_default();

        if c > 0 && d > 0 {
            println!("Result 2: {}", num * c * d);
            break;
        }
    }
}

/// Finds a pair of numbers from vector that add up to specified count.
///
/// Example
/// ```
/// # use rust01::find_addition;
/// let (a, b) = find_addition(&vec![12, 2000, 20], &2020);
/// # assert_eq!(a, 2000);
/// # assert_eq!(b, 20);
/// ```
fn find_addition(source: &Vec<i32>, count: &i32) -> Option<(i32, i32)> {
    for num in source {
        let needed = count - num;

        if source.iter().any(|v| v == &needed) {
            return Some((*num, needed));
        }
    }

    None
}

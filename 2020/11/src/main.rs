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

    let mut prev = vec.to_vec();
    let mut next = simulate(&prev);

    while prev != next {
        prev = next.to_vec();
        next = simulate(&prev);
    }

    println!("Result 1: {}", count_seats(&next));
}

fn simulate(map: &Vec<String>) -> Vec<String> {
    let mut new_vec: Vec<String> = Vec::new();
    for i in 0..map.len() {
        let mut new_line: String = String::new();
        let chars = map[i].chars().collect::<Vec<char>>();
        let mut above: Vec<char> = Vec::new();
        let mut below: Vec<char> = Vec::new();

        if i > 0 {
            above = map[i - 1].chars().collect::<Vec<char>>();
        }

        if i < map.len() - 1 {
            below = map[i + 1].chars().collect::<Vec<char>>();
        }

        for j in 0..chars.len() {
            if chars[j] != '.' {
                let mut adjacent = 0;

                if j > 0 && chars[j - 1] == '#' {
                    adjacent += 1;
                }

                if j < chars.len() - 1 && chars[j + 1] == '#' {
                    adjacent += 1;
                }

                if i > 0 {
                    if j > 0 && above[j - 1] == '#' {
                        adjacent += 1;
                    }

                    if j < above.len() - 1 && above[j + 1] == '#' {
                        adjacent += 1;
                    }

                    if above[j] == '#' {
                        adjacent += 1;
                    }
                }

                if i < map.len() - 1 {
                    if j > 0 && below[j - 1] == '#' {
                        adjacent += 1;
                    }

                    if j < below.len() - 1 && below[j + 1] == '#' {
                        adjacent += 1;
                    }

                    if below[j] == '#' {
                        adjacent += 1;
                    }
                }

                if chars[j] == 'L' {
                    if adjacent > 0 {
                        new_line.push_str("L");
                    } else {
                        new_line.push_str("#");
                    }
                } else {
                    if adjacent >= 4 {
                        new_line.push_str("L");
                    } else {
                        new_line.push_str("#");
                    }
                }
            } else {
                new_line.push_str(".");
            }
        }

        new_vec.push(new_line);
    }

    new_vec
}

fn _print_vec(vec: &Vec<String>) {
    println!("==");
    for line in vec {
        println!("{}", line);
    }
}

fn count_seats(vec: &Vec<String>) -> u32 {
    let mut count = 0;

    for line in vec {
        for c in line.chars() {
            if c == '#' {
                count += 1;
            }
        }
    }

    count
}

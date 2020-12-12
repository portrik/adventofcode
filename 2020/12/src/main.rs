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

    let (x, y) = move_ship(&vec);

    println!("Result 1: {}", x.abs() + y.abs());

    let (x2, y2) = move_waypoint(&vec);

    println!("Result 2: {}", x2.abs() + y2.abs());
}

fn move_ship(instructions: &Vec<String>) -> (i32, i32) {
    let mut x: i32 = 0;
    let mut y: i32 = 0;
    let mut direction: i32 = 0;

    for line in instructions {
        let action = &line[0..1];
        let value = &line[1..].parse::<i32>().unwrap();

        match action {
            "N" => y += value,
            "S" => y -= value,
            "E" => x += value,
            "W" => x -= value,
            "L" => direction = (direction + value).abs() % 360,
            "R" => direction = (360 + direction - value).abs() % 360,
            "F" => match direction {
                0 => x += value,
                90 => y += value,
                180 => x -= value,
                270 => y -= value,
                _ => (),
            },
            _ => (),
        }
    }

    (x, y)
}

fn move_waypoint(instructions: &Vec<String>) -> (i32, i32) {
    let mut x: i32 = 10;
    let mut y: i32 = 1;
    let mut x_pos: i32 = 0;
    let mut y_pos: i32 = 0;

    for line in instructions {
        let action = &line[..1];
        let value = &line[1..].parse::<i32>().unwrap();

        match action {
            "N" => y += value,
            "S" => y -= value,
            "E" => x += value,
            "W" => x -= value,
            "L" => match value {
                90 => {
                    let tmp = x;
                    x = -y;
                    y = tmp;
                }
                180 => {
                    x = -x;
                    y = -y;
                }
                270 => {
                    let tmp = x;
                    x = y;
                    y = -tmp;
                }
                _ => (),
            },
            "R" => match value {
                90 => {
                    let tmp = x;
                    x = y;
                    y = -tmp;
                }
                180 => {
                    x = -x;
                    y = -y;
                }
                270 => {
                    let tmp = x;
                    x = -y;
                    y = tmp;
                }
                _ => (),
            },
            "F" => {
                x_pos += x * value;
                y_pos += y * value;
            }
            _ => (),
        }
    }

    (x_pos, y_pos)
}

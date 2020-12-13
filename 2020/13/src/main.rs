use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    // Loads the input file line by line into a vector
    let f = BufReader::new(File::open("test_input.txt").expect("Unable to open input file"));
    let mut vec = Vec::new();
    for line in f.lines() {
        vec.push(line.expect("Unable to read line"));
    }

    let timestamp: u32 = vec[0].parse::<u32>().unwrap();
    let buses = vec[1].split(",").collect::<Vec<&str>>();
    let (result1_bus, result1_time) = get_departure(timestamp, &buses);
    println!("Bus {}, time {}", result1_bus, result1_time);
    println!("Result 1: {}", result1_bus * (result1_time - timestamp));
}

fn get_departure(time: u32, buses: &Vec<&str>) -> (u32, u32) {
    let mut target_bus = 0;
    let mut target_time = u32::MAX;

    for bus in buses {
        let id = bus.parse::<u32>();

        match id {
            Ok(v) => {
                if time % v == 0 {
                    target_time = 0;
                    target_bus = v;
                } else {
                    let temp = ((time / v) + 1) * v;

                    if temp < target_time {
                        target_time = temp;
                        target_bus = v;
                    }
                }
            }
            Err(_e) => (),
        }
    }

    (target_bus, target_time)
}

fn find_offset_departures(buses: &Vec<&str>) -> u64 {
    let timestamp = u64::MAX;



    timestamp
}
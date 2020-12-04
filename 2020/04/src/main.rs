use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    // Loads the input file line by line into a vector
    let f = BufReader::new(File::open("input.txt").expect("Unable to open input file"));
    let mut vec = Vec::new();
    for line in f.lines() {
        let line = line.expect("Unable to read line");
        vec.push(line);
    }

    let mut i = 0;
    let mut result1 = 0;
    let mut result2 = 0;

    while i < vec.len() - 1 {
        let mut passport: Vec<&str> = Vec::new();

        let mut line = &vec[i];

        while line.trim().len() > 0 && i < vec.len() - 1 {
            passport.push(&line);
            i += 1;
            line = &vec[i];
        }

        if validate_passport(&passport) {
            result1 += 1;
        }

        if validate_passport_advanced(&passport) {
            result2 += 1;
        }

        i += 1;
    }

    println!("Result 1: {}", result1);
    println!("Result 2: {}", result2);
}

fn validate_passport(values: &Vec<&str>) -> bool {
    let mut present_values = vec!["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"];

    for line in values {
        let values = line.split(" ");

        for value in values {
            let id = value.split(":").collect::<Vec<&str>>()[0];
            let index = present_values.iter().position(|i| *i == id).unwrap();

            present_values.remove(index);
        }
    }

    present_values.len() < 1 || (present_values.len() == 1 && present_values[0] == "cid")
}

fn validate_passport_advanced(values: &Vec<&str>) -> bool {
    let mut present_values = vec!["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"];

    for line in values {
        let values = line.split(" ");

        for value in values {
            let pair = value.split(":").collect::<Vec<&str>>();
            let id = pair[0];
            let val = pair[1].trim().to_string();
            let mut index: usize = 99;

            match id {
                "byr" => {
                    if val.len() == 4 {
                        let num = val.parse::<u32>().unwrap();

                        if num >= 1920 && num <= 2002 {
                            index = present_values
                                .iter()
                                .position(|i| *i == "byr")
                                .unwrap_or(99);
                        }
                    }
                }
                "iyr" => {
                    if val.len() == 4 {
                        let num = val.parse::<u32>().unwrap_or(99);

                        if num >= 2010 && num <= 2020 {
                            index = present_values
                                .iter()
                                .position(|i| *i == "iyr")
                                .unwrap_or(99);
                        }
                    }
                }
                "eyr" => {
                    if val.len() == 4 {
                        let num = val.parse::<u32>().unwrap();

                        if num >= 2020 && num <= 2030 {
                            index = present_values
                                .iter()
                                .position(|i| *i == "eyr")
                                .unwrap_or(99);
                        }
                    }
                }
                "hgt" => {
                    if val.len() > 3 {
                        let units: String = val.chars().skip(val.len() - 2).take(2).collect();
                        let num: u32 = val
                            .chars()
                            .take(val.len() - 2)
                            .collect::<String>()
                            .parse::<u32>()
                            .unwrap_or(99);

                        if (units == "cm" && num >= 150 && num <= 193)
                            || (units == "in" && num >= 59 && num <= 76)
                        {
                            index = present_values
                                .iter()
                                .position(|i| *i == "hgt")
                                .unwrap_or(99);
                        }
                    }
                }
                "hcl" => {
                    if val.chars().collect::<Vec<char>>()[0] == '#'
                        && val.chars().skip(1).collect::<String>().len() == 6
                    {
                        index = present_values
                            .iter()
                            .position(|i| *i == "hcl")
                            .unwrap_or(99);
                    }
                }
                "ecl" => {
                    let colors = vec!["amb", "blu", "brn", "gry", "grn", "hzl", "oth"];
                    let ind = colors.iter().position(|i| *i == val).unwrap_or(99);

                    if ind != 99 {
                        index = present_values
                            .iter()
                            .position(|i| *i == "ecl")
                            .unwrap_or(99);
                    }
                }
                "pid" => {
                    let num = val.parse::<u32>().unwrap_or(99);

                    if val.len() == 9 && num != 99 {
                        index = present_values
                            .iter()
                            .position(|i| *i == "pid")
                            .unwrap_or(99);
                    }
                }
                _ => (),
            }

            if index != 99 {
                present_values.remove(index);
            }
        }
    }

    present_values.len() < 1
}

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

    let mut bag_rules: HashMap<&str, Vec<&str>> = HashMap::new();

    for line in &vec {
        let split = line.split(" bags contain ").collect::<Vec<&str>>();
        let rules = split[1].split(",").collect::<Vec<&str>>();

        bag_rules.insert(split[0].clone(), rules.clone());
    }

    let keys = bag_rules.keys().clone();
    let mut result1: u32 = 0;

    for key in keys {
        let rules = get_rules(&bag_rules, key);

        if rules.get("shiny gold").unwrap_or(&99999) < &99999 {
            result1 += 1;
        }
    }

    println!("Result 1: {}", result1);
    println!("Result 2: {}", get_count(&bag_rules, &"shiny gold"));
}

fn get_rules(rules: &HashMap<&str, Vec<&str>>, rule: &str) -> HashMap<String, u32> {
    let mut final_rules: HashMap<String, u32> = HashMap::new();
    let start_rules = rules.get(rule).unwrap();

    if start_rules.len() > 0 && start_rules[0] != "no other bags." {
        for r in start_rules {
            let split = r.trim().split(" ").collect::<Vec<&str>>();
            let sub_rule = format!("{} {}", split[1], split[2]);
            let sub_rules = get_rules(rules, &sub_rule);
            final_rules.insert(sub_rule, split[0].parse::<u32>().unwrap());
            for (key, value) in sub_rules {
                final_rules.insert(key, value);
            }
        }
    }

    final_rules
}

fn get_count(rules: &HashMap<&str, Vec<&str>>, rule: &str) -> u32 {
    let mut result: u32 = 0;
    let start_rules = rules.get(rule).unwrap();

    if start_rules.len() > 0 && start_rules[0] != "no other bags." {
        for r in start_rules {
            let split = r.trim().split(" ").collect::<Vec<&str>>();
            let sub_rule = format!("{} {}", split[1], split[2]);
            result += split[0].parse::<u32>().unwrap();
            result += get_count(rules, &sub_rule) * split[0].parse::<u32>().unwrap();
        }
    }

    result
}

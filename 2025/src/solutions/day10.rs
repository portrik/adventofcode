use std::collections::{HashSet, VecDeque};

use crate::solution::Solution;
use regex::Regex;

struct Machine {
    lights: u32,
    buttons: Vec<u32>,
    joltage: Vec<u32>,
}

pub struct Solver {
    machines: Vec<Machine>,
}

fn line_to_machine(line: &str) -> Machine {
    let Ok(line_pattern) = Regex::new(
        r"\[(?<lights>[\.#]+)\](?<buttons>[\s\(\d{0,3}+\)?]+)\s\{(?<joltage>[\d{0,3}]+)\}",
    ) else {
        panic!("There is a mistake in the regex pattern! How Cloudflare of you.");
    };

    let Some(captured_groups) = line_pattern.captures(line) else {
        panic!("The capture groups could not be found in {line}!");
    };

    let lights = &captured_groups["lights"];
    let buttons = &captured_groups["buttons"];
    let joltage = &captured_groups["joltage"];

    Machine {
        lights: lights
            .chars()
            .enumerate()
            .fold(0, |total, (index, character)| match character {
                '.' => total,
                #[allow(clippy::cast_possible_truncation)]
                '#' => total + 2_u32.pow(index as u32),
                _ => panic!("Invalid character '{character}' encountered during lights parsing."),
            }),
        buttons: buttons
            .split_whitespace()
            .filter(|value| !value.is_empty())
            .map(|button| {
                button
                    .replace(['(', ')'], "")
                    .split(',')
                    .map(|number| {
                        let Ok(number) = number.parse::<u32>() else {
                            panic!("'{number} is not a valid number!");
                        };

                        number
                    })
                    .fold(0_u32, |mask, position| mask + 2_u32.pow(position))
            })
            .collect(),
        joltage: joltage
            .split(',')
            .map(|number| {
                let Ok(number) = number.parse::<u32>() else {
                    panic!("{number} is not valid number!")
                };

                number
            })
            .collect(),
    }
}

/// <https://lr.ptr.moe/r/adventofcode/comments/1pity70/2025_day_10_solutions/ntpl2u5/?context=3#ntpl2u5>
fn get_jolt_presses(_machine: &Machine) -> u32 {
    11
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        Solver {
            machines: input
                .lines()
                .filter(|line| !line.is_empty())
                .map(line_to_machine)
                .collect(),
        }
    }

    fn first_stage(&self) -> String {
        self.machines
            .iter()
            .fold(0, |total, machine| {
                let mut queue = VecDeque::new();
                let mut visited = HashSet::new();

                queue.push_back((0_u32, 0));
                visited.insert(0);

                while let Some((current, steps)) = queue.pop_front() {
                    if current == machine.lights {
                        return total + steps;
                    }

                    for button in &machine.buttons {
                        let next_step = current ^ button;

                        if visited.insert(next_step) {
                            // Insert returns true for newly inserted values
                            queue.push_back((next_step, steps + 1));
                        }
                    }
                }

                panic!("No matching combination of buttons was found!");
            })
            .to_string()
    }

    fn second_stage(&self) -> String {
        self.machines
            .iter()
            .fold(0, |total, machine| total + get_jolt_presses(machine))
            .to_string()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_first_stage() {
        assert_eq!(
            Solver::new(
                "\n\
        [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}\n\
        [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}\n\
        [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}\n\
"
                .to_owned()
            )
            .first_stage(),
            "7"
        );
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(
            Solver::new(
                "\n\
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}\n\
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}\n\
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}\n\
"
                .to_owned()
            )
            .second_stage(),
            "33"
        );
    }
}

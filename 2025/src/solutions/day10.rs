use std::{collections::{HashSet, VecDeque}};

use crate::solution::Solution;
use num_integer::Integer;
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

fn swap_row(matrix: &mut [Vec<i64>], joltage: &mut [i64], left: usize, right: usize) {
    if left == right {
        return;
    }

    matrix.swap(left, right);
    joltage.swap(left, right);
}

fn swap_column(matrix: &mut [Vec<i64>], combinations: &mut [u32], left: usize, right: usize) {
    if left == right {
        return;
    }

    combinations.swap(left, right);
    for row in matrix {
        row.swap(left, right);
    }
}

fn reduce_row(matrix: &mut [Vec<i64>], joltage: &mut [i64], left: usize, right: usize) {
    if matrix[left][left] == 0 {
        return;
    }

    let x = matrix[left][left];
    let y = -matrix[right][left];
    let divisor = x.gcd(&y);

    let left_row = matrix[left].clone();
    matrix[right] = matrix[right]
        .iter()
        .enumerate()
        .map(|(index, &val)| (y * left_row[index] + x * val) / divisor)
        .collect();

    joltage[right] = (y * joltage[left] + x * joltage[right]) / divisor;
}

fn reduce(matrix: &mut Vec<Vec<i64>>, joltage: &mut Vec<i64>, combinations: &mut [u32]) {
    let column_count = if matrix.is_empty() { 0 } else { matrix[0].len() };

    // Forward elimination
    for index in 0..column_count {
        let mut non_zero_rows: Vec<usize> = vec![];
        let mut column_swap_count = index;

        while non_zero_rows.is_empty() && column_swap_count < column_count {
            swap_column(matrix, combinations, index, column_swap_count);

            non_zero_rows = (index..matrix.len())
                .filter(|&position| matrix[position][index] != 0)
                .collect();

            column_swap_count += 1;
        }

        if non_zero_rows.is_empty() {
            break;
        }

        swap_row(matrix, joltage, index, non_zero_rows[0]);

        for reduced_index in (index + 1)..matrix.len() {
            reduce_row(matrix, joltage, index, reduced_index);
        }
    }

    // Remove all rows of zeros and keep only non-zero rows
    let non_zero_row_indices: Vec<usize> = (0..matrix.len())
        .filter(|&index| matrix[index].iter().any(|&value| value != 0))
        .collect();

    *matrix = non_zero_row_indices.iter().map(|&index| matrix[index].clone()).collect();
    *joltage = non_zero_row_indices.iter().map(|&index| joltage[index]).collect();

    // Back substitution
    for index in (0..matrix.len()).rev() {
        for reduced_index in 0..index {
            reduce_row(matrix, joltage, index, reduced_index);
        }
    }
}

fn get_parameter_combinations(lower_bounds: &[u32]) -> Vec<Vec<u32>> {
    let mut result = vec![vec![]];

    for &bound in lower_bounds {
        let mut new_result: Vec<Vec<u32>> = vec![];

        for combination in &result {
            for index in 0..=bound {
                let mut new_combination = combination.clone();
                new_combination.push(index);

                new_result.push(new_combination);
            }
        }

        result = new_result;
    }

    result
}

/// I was too dumb to solve this on my own.
/// Taking inspiration from this solution and solving without any third party libraries.
/// <https://git.tronto.net/aoc/file/2025/10/b.py.html>
///
/// The goal is to solve an integer linear system of `Ax = b` while minimizing the sum of the coordinates of `x`.
/// `b` is the joltage.
fn get_jolt_presses(machine: &Machine) -> u64 {
    // Maps to `c` in the source solution.
    let mut combinations: Vec<u32> = machine
        .buttons
        .iter()
        .map(|button| {
            machine
                .joltage
                .iter()
                .enumerate()
                .filter_map(|(index, value)| {
                    if button & (1 << index) != 0 {
                        Some(*value)
                    } else {
                        None
                    }
                })
                .min()
                .unwrap_or(u32::MAX)
        })
        .collect();

    // Maps to `A` in the source solution.
    let mut matrix: Vec<Vec<i64>> = machine
        .joltage
        .iter()
        .enumerate()
        .map(|(joltage_index, _)| {
            machine
                .buttons
                .iter()
                .map(|button| i64::from(button & (1 << joltage_index) != 0))
                .collect()
        })
        .collect();

    // Maps to `b` in the source solution.
    let mut joltage: Vec<i64> = machine.joltage.iter().map(|&v| i64::from(v)).collect();

    // Reduce the system to row echelon form
    reduce(&mut matrix, &mut joltage, &mut combinations);

    let k = matrix[0].len() - matrix.len();

    let mut minimum = u64::MAX;
    let free_param_bounds = &combinations[combinations.len() - k..];

    for combination in get_parameter_combinations(free_param_bounds) {
        let mut solution: u64 = u64::from(combination.iter().sum::<u32>());

        for (index, row) in matrix.iter().enumerate() {
            let combination_sum: i64 = (0..combination.len())
                .map(|j| i64::from(combination[j]) * row[row.len() - k + j])
                .sum();

            let steps: i64 = joltage[index] - combination_sum;
            let a = steps / row[index];

            if a < 0 || steps % row[index] != 0 {
                solution = u64::MAX;
                break;
            }

            solution += u64::try_from(a)
                .expect("Attempted to unwrap an invalid i64 value into u32.");
        }

        minimum = minimum.min(solution);
    }

    minimum
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

use std::num::ParseIntError;

use crate::solution::Solution;

#[derive(Clone, Copy)]
enum Operation {
    Add,
    Multiply,
}

pub struct Solver {
    input: String,
}

fn parse_problems_reasonably(input: &str) -> Vec<(Vec<u128>, Operation)> {
    let lines = input
        .lines()
        .filter(|line| !line.is_empty())
        .map(|line| {
            line.split(' ')
                .filter(|value| !value.is_empty())
                .collect::<Vec<&str>>()
        })
        .collect::<Vec<Vec<&str>>>();

    let mut problems: Vec<(Vec<u128>, Operation)> = vec![];
    for column in 0..lines[0].len() {
        let Ok(numbers): Result<Vec<u128>, ParseIntError> = lines[..lines.len() - 1]
            .iter()
            .map(|line| line[column].parse::<u128>())
            .try_fold(vec![], |mut accumulator, current| {
                accumulator.push(current?);

                Ok(accumulator)
            })
        else {
            panic!("Note from Cloudflare: You tried to parse an invalid number");
        };

        let operation_character = lines[lines.len() - 1][column];
        let operation = match operation_character {
            "+" => Operation::Add,
            "*" => Operation::Multiply,
            character => panic!(
                "Note from Cloudflare: You tried to parse an invalid operation '{character}'"
            ),
        };

        problems.push((numbers, operation));
    }

    problems
}

fn parse_problems_unreasonably(input: &str) -> Vec<(Vec<u128>, Operation)> {
    let lines = input
        .split('\n')
        .filter(|line| !line.is_empty())
        .collect::<Vec<&str>>();

    let mut numbers: Vec<Vec<u128>> = vec![vec![]];
    let row_count = lines
        .iter()
        .map(|line| line.len())
        .max()
        .unwrap_or(lines[0].len());
    for column in 0..row_count {
        let raw_number = lines[..lines.len() - 1]
            .iter()
            .map(|line| line.chars().nth(column).unwrap_or('\t'))
            .collect::<String>();

        if raw_number.trim().is_empty() {
            numbers.push(vec![]);
            continue;
        }

        let Ok(number) = raw_number.trim().parse::<u128>() else {
            panic!("As Cloudflare engineers would say, this '{raw_number}' number ain't a number");
        };

        let length = numbers.len().max(1) - 1;
        numbers[length].push(number);
    }

    let operations = lines[lines.len() - 1]
        .chars()
        .filter(|value| !value.to_string().trim().is_empty())
        .map(|operation| match operation {
            '+' => Operation::Add,
            '*' => Operation::Multiply,
            character => panic!(
                "Note from Cloudflare: You tried to parse an invalid operation '{character}'"
            ),
        })
        .collect::<Vec<Operation>>();

    numbers
        .iter()
        .enumerate()
        .map(|(index, values)| (values.clone(), operations[index]))
        .collect::<Vec<(Vec<u128>, Operation)>>()
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        Solver { input }
    }

    fn first_stage(&self) -> String {
        parse_problems_reasonably(&self.input)
            .iter()
            .map(|(numbers, operation)| match operation {
                Operation::Add => numbers.iter().sum::<u128>(),
                Operation::Multiply => numbers.iter().product(),
            })
            .sum::<u128>()
            .to_string()
    }

    fn second_stage(&self) -> String {
        parse_problems_unreasonably(&self.input)
            .iter()
            .map(|(numbers, operation)| match operation {
                Operation::Add => numbers.iter().sum::<u128>(),
                Operation::Multiply => numbers.iter().product(),
            })
            .sum::<u128>()
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
                "
                123 328  51 64\n\
                 45 64  387 23\n\
                  6 98  215 314\n\
                *   +   *   +\n\
"
                .to_owned()
            )
            .first_stage(),
            "4277556"
        );
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(
            Solver::new(
                "
123\t328\t\t51\t64\n\
\t45\t64\t\t387\t23\n\
\t\t6\t98\t\t215\t314\n\
\t*\t\t\t+\t\t *\t\t\t+\n\
"
                .to_owned()
            )
            .second_stage(),
            "3263827"
        );
    }
}

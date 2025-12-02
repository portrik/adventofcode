use std::num::ParseIntError;

use crate::solution::Solution;

pub struct Solver {
    ranges: Vec<(i64, i64)>,
}

fn parse_ids(source: &str) -> (i64, i64) {
    let split: Result<Vec<i64>, ParseIntError> = source
        .trim()
        .split('-')
        .map(str::parse::<i64>)
        .try_fold(vec![], |mut acc, current| {
            acc.push(current?);

            Ok(acc)
        });

    let Ok(numbers) = split else {
        panic!("Invalid ID source encountered: '{source}'")
    };

    match numbers.as_slice() {
        [start, end] => (start.to_owned(), end.to_owned()),
        _ => panic!("Invalid number pattern detected: '{source}'"),
    }
}

fn is_repeated_once(value: i64) -> bool {
    let value_as_string = value.to_string();
    let (left, right) = value_as_string.split_at(value_as_string.len() / 2);

    left == right
}

fn is_repeated(value: i64) -> bool {
    let value_as_string = value.to_string();
    let length = value_as_string.len();

    for prefix_length in 1..=(length / 2) {
        if !length.is_multiple_of(prefix_length) {
            continue;
        }

        let repeat_count = length / prefix_length;
        let repeated = value_as_string[..prefix_length].repeat(repeat_count);
        if repeated == value_as_string {
            return true;
        }
    }

    false
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        let ranges = input.split(',').map(parse_ids).collect::<Vec<(i64, i64)>>();

        Solver { ranges }
    }

    fn first_stage(&self) -> String {
        self.ranges
            .iter()
            .flat_map(|(start, end)| std::ops::Range {
                start: *start,
                end: *end + 1,
            })
            .filter(|value| is_repeated_once(*value))
            .sum::<i64>()
            .to_string()
    }

    fn second_stage(&self) -> String {
        self.ranges
            .iter()
            .flat_map(|(start, end)| std::ops::Range {
                start: *start,
                end: *end + 1,
            })
            .filter(|value| is_repeated(*value))
            .sum::<i64>()
            .to_string()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_first_stage() {
        let input = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124";

        assert_eq!(Solver::new(input.to_owned()).first_stage(), "1227775554");
    }

    #[test]
    fn test_second_stage() {
        let input = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124";

        assert_eq!(Solver::new(input.to_owned()).second_stage(), "4174379265");
    }
}

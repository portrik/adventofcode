use std::num::ParseIntError;

use crate::solution::Solution;

pub struct Solver {
    ranges: Vec<(u128, u128)>,
    ids: Vec<u128>,
}

fn parse_input(input: &str) -> (Vec<(u128, u128)>, Vec<u128>) {
    let mut line_iterator = input.trim().lines();

    let ranges = line_iterator
        .by_ref()
        .take_while(|line| !line.is_empty())
        .map(|range| {
            let values = range
                .split('-')
                .map(str::parse::<u128>)
                .collect::<Vec<Result<u128, ParseIntError>>>();

            match values.as_slice() {
                [Ok(left), Ok(right)] => (*left, *right),
                _ => panic!("Invalid range line encountered! '{range}'"), // I feel like I work for Cloudflare
            }
        })
        .collect::<Vec<(u128, u128)>>();

    let Ok(ids): Result<Vec<u128>, ParseIntError> = line_iterator
        .by_ref()
        .skip_while(|line| line.is_empty())
        .map(str::parse::<u128>)
        .try_fold(vec![], |mut accumulator, current| {
            accumulator.push(current?);

            Ok(accumulator)
        })
    else {
        panic!("Some of the ID values are invalid!") // I feel like I work for Cloudflare
    };

    (ranges, ids)
}

fn construct_ranges(source_ranges: &[(u128, u128)]) -> Vec<(u128, u128)> {
    let mut ranges: Vec<(u128, u128)> = vec![];

    for (left, right) in source_ranges {
        let left_positions = ranges
            .iter()
            .by_ref()
            .enumerate()
            .filter(|(_index, (old_left, old_right))| {
                (*left >= *old_left && *left <= *old_right)
                    || (*old_left >= *left && *old_left <= *right)
            })
            .map(|(index, &range)| (index, range))
            .collect::<Vec<(usize, (u128, u128))>>();

        let right_positions = ranges
            .iter()
            .by_ref()
            .enumerate()
            .filter(|(_index, (old_left, old_right))| {
                (*right >= *old_left && *right <= *old_right)
                    || (*old_right >= *left && *old_right <= *right)
            })
            .map(|(index, &range)| (index, range))
            .collect::<Vec<(usize, (u128, u128))>>();

        let mut indexes_to_remove: Vec<usize> = vec![];
        for (index, _) in &left_positions {
            if !indexes_to_remove.contains(index) {
                indexes_to_remove.push(*index);
            }
        }

        for (index, _) in &right_positions {
            if !indexes_to_remove.contains(index) {
                indexes_to_remove.push(*index);
            }
        }

        indexes_to_remove.sort_by(|a, b| b.cmp(a));
        for index in &indexes_to_remove {
            ranges.remove(*index);
        }

        let mut new_left = [*left].to_vec();
        let mut new_right = [*right].to_vec();
        for (_index, (old_left, old_right)) in &left_positions {
            new_left.push(*old_left);
            new_right.push(*old_right);
        }

        for (_index, (old_left, old_right)) in &right_positions {
            new_left.push(*old_left);
            new_right.push(*old_right);
        }

        ranges.push((
            *new_left.iter().min().unwrap_or(left),
            *new_right.iter().max().unwrap_or(right),
        ));
    }

    ranges
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        let (ranges, ids) = parse_input(&input);

        Solver { ranges, ids }
    }

    fn first_stage(&self) -> String {
        self.ids
            .iter()
            .filter(|id| {
                self.ranges
                    .iter()
                    .any(|(left, right)| **id >= *left && **id <= *right)
            })
            .collect::<Vec<&u128>>()
            .len()
            .to_string()
    }

    fn second_stage(&self) -> String {
        construct_ranges(&self.ranges)
            .iter()
            .map(|(left, right)| (right + 1) - left) // Right is included
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
                "\n\
		        3-5\n\
		        10-14\n\
		        16-20\n\
		        12-18\n\
		        	\n\
		        1\n\
		        5\n\
		        8\n\
		        11\n\
		        17\n\
		        32
			"
                .to_owned()
            )
            .first_stage(),
            "3"
        );
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(
            Solver::new(
                "\n\
				3-5\n\
				10-14\n\
				16-20\n\
				12-18\n\
				9-21\n\
				\n\
				1\n\
				5\n\
				8\n\
				11\n\
				17\n\
				32
			"
                .to_owned()
            )
            .second_stage(),
            "16"
        );
    }
}

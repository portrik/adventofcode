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

fn ranges_overlap(
    (left_left, left_right): &(u128, u128),
    (right_left, right_right): &(u128, u128),
) -> bool {
    (left_left >= right_left && left_left <= right_right)
        || (right_left >= left_left && right_left <= left_right)
        || (right_right >= left_left && right_right <= left_right)
        || (left_right >= right_left && left_right <= right_right)
}

fn construct_ranges(source_ranges: &[(u128, u128)]) -> Vec<(u128, u128)> {
    let mut ranges: Vec<(u128, u128)> = vec![];

    for (left, right) in source_ranges {
        let overlaps = ranges
            .iter()
            .by_ref()
            .enumerate()
            .filter(|(_index, range)| ranges_overlap(range, &(*left, *right)))
            .map(|(index, &range)| (index, range))
            .collect::<Vec<(usize, (u128, u128))>>();

        let mut indexes_to_remove = overlaps
            .iter()
            .by_ref()
            .map(|(index, _range)| *index)
            .collect::<Vec<usize>>();
        indexes_to_remove.sort_by(|a, b| b.cmp(a));
        for index in &indexes_to_remove {
            ranges.remove(*index);
        }

        let new_left = overlaps
            .iter()
            .by_ref()
            .map(|(_index, (left, _right))| *left)
            .min()
            .map_or(*left, |value| value.min(*left));
        let new_right = overlaps
            .iter()
            .by_ref()
            .map(|(_index, (_left, right))| *right)
            .max()
            .map_or(*right, |value| value.max(*right));

        ranges.push((new_left, new_right));
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

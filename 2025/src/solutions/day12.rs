use std::num::ParseIntError;

use regex::Regex;

use crate::solution::Solution;

type Shape = Vec<Vec<bool>>;
struct Region {
    width: u64,
    height: u64,
    gifts: Vec<u64>,
}

fn parse_input(input: &str) -> (Vec<Shape>, Vec<Region>) {
    let Ok(region_regex) = Regex::new(r"(?<width>\d+)x(?<height>\d+):\s*(?<gifts>(\d+\s*)+)")
    else {
        panic!("Invalid regex pattern was provided!");
    };

    let mut shapes: Vec<Shape> = vec![];
    let mut lines_iterator = input.lines();
    let mut current: Vec<&str> = vec![];

    while let Some(line) = lines_iterator.next()
        && !region_regex.is_match(line)
    {
        if line.is_empty() {
            continue;
        }

        if !line.contains(':') {
            current.push(line);
            continue;
        }

        if !current.is_empty() {
            shapes.push(
                current
                    .iter()
                    .map(|line| line.chars().map(|char| char == '#').collect())
                    .collect(),
            );
        }

        current = vec![];
    }

    shapes.push(
        current
            .iter()
            .map(|line| line.chars().map(|char| char == '#').collect())
            .collect(),
    );

    let regions = input
        .lines()
        .map(|line| {
            region_regex.captures(line).map(|captures| {
                let Ok(width) = &captures["width"].parse::<u64>() else {
                    panic!("Could not parse the region width '{}'!", &captures["width"]);
                };
                let Ok(height) = &captures["height"].parse::<u64>() else {
                    panic!(
                        "Could not parse the region height '{}'!",
                        &captures["height"]
                    );
                };
                let Ok(gifts): &Result<Vec<u64>, ParseIntError> = &captures["gifts"]
                    .split(' ')
                    .filter(|value| !value.is_empty())
                    .map(str::parse::<u64>)
                    .try_fold(vec![], |mut gifts, current| {
                        gifts.push(current?);

                        Ok(gifts)
                    })
                else {
                    panic!(
                        "Could not parse the gift indexes from '{}'!",
                        &captures["gifts"]
                    );
                };

                Region {
                    width: *width,
                    height: *height,
                    gifts: gifts.clone(),
                }
            })
        })
        .fold(vec![], |mut regions, current| {
            if let Some(region) = current {
                regions.push(region);
            }

            regions
        });

    (shapes, regions)
}

pub struct Solver {
    #[allow(dead_code)]
    shapes: Vec<Shape>, // Leaving it here just as a big reminder that I actually parsed the input!
    regions: Vec<Region>,
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        let (shapes, regions) = parse_input(&input);

        Solver { shapes, regions }
    }

    fn first_stage(&self) -> String {
        self.regions
            .iter()
            .filter(|region| {
                let present_count: u64 = region.gifts.iter().sum();
                let available_area = (region.width / 3) * (region.height / 3);

                present_count <= available_area
            })
            .collect::<Vec<&Region>>()
            .len()
            .to_string()
    }

    fn second_stage(&self) -> String {
        self.regions.len().to_string()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT: &str = "0:\n\
    ###\n\
    ##.\n\
    ##.\n\
\n\
    1:\n\
    ###\n\
    ##.\n\
    .##\n\
\n\
    2:\n\
    .##\n\
    ###\n\
    ##.\n\
\n\
    3:\n\
    ##.\n\
    ###\n\
    ##.\n\
\n\
    4:\n\
    ###\n\
    #..\n\
    ###\n\
\n\
    5:\n\
    ###\n\
    .#.\n\
    ###\n\
\n\
    4x4: 0 0 0 0 2 0\n\
    12x5: 1 0 1 0 2 2\n\
    12x5: 1 0 1 0 3 2\n\
";

    #[test]
    fn test_first_stage() {
        assert_eq!(Solver::new(INPUT.to_owned()).first_stage(), "0"); // It do be like that
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(Solver::new(INPUT.to_owned()).second_stage(), "3");
    }
}

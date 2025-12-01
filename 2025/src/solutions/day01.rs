use crate::solution::Solution;

enum Direction {
    Left,
    Right,
}

pub struct Solver {
    instructions: Vec<i32>,
}

fn parse_line(line: &&str) -> i32 {
    let split = line.split_at_checked(1);

    // Normally, the panics would not be ideal and should have been turned into Results.
    // But AoC is very nice when it comes to the correctly formatted input.
    // However, for simplicity, it is easier to fail here directly instead of pretty printing a properly handled error result.
    let Some((start, end)) = split else {
        panic!("Unexpected line format found during instruction parsing {line}");
    };

    let direction: Direction = match start {
        "L" => Direction::Left,
        "R" => Direction::Right,
        _ => panic!("Unexpected direction found during instruction parsing {line}"),
    };

    let Ok(distance) = end.trim().parse::<i32>() else {
        panic!("Unexpected distance found during instruction parsing {line}");
    };

    match direction {
        Direction::Left => -distance,
        Direction::Right => distance,
    }
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        let lines = input
            .split('\n')
            .filter(|line| !line.is_empty())
            .collect::<Vec<&str>>();

        Solver {
            instructions: lines.iter().map(parse_line).collect::<Vec<i32>>(),
        }
    }

    fn first_stage(&self) -> String {
        let mut position: i32 = 50;
        let mut zero_positions_encountered: i32 = 0;

        for instruction in &self.instructions {
            position = (position + instruction).rem_euclid(100); // '%' keeps the negativity, while rem_euclid works as expected for modulus

            if position == 0 {
                zero_positions_encountered += 1;
            }
        }

        zero_positions_encountered.to_string()
    }

    fn second_stage(&self) -> String {
        let mut position: i32 = 50;
        let mut zero_position_encountered: i32 = 0;

        for instruction in &self.instructions {
            match instruction {
                direction if direction >= &0 => {
                    zero_position_encountered += (position + instruction) / 100;
                }

                direction if direction < &0 => {
                    let reversed = (100 - position) % 100; // Handles the issue where crossing into negative numbers > -100 does not get counted.
                    zero_position_encountered += (reversed - instruction) / 100;
                }

                _ => panic!("Number that is neither >= 0 or < 0 encountered!"), // Haha
            }

            position = (position + instruction).rem_euclid(100).abs(); // % keeps the negativity, while rem_euclid works as expected for modulus
        }

        zero_position_encountered.to_string()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_first_stage() {
        let input = "\n\
    L68\n\
    L30\n\
    R48\n\
    L5\n\
    R60\n\
    L55\n\
    L1\n\
    L99\n\
    R14\n\
    L82";

        assert_eq!(Solver::new(input.to_owned()).first_stage(), "3");
    }

    #[test]
    fn test_second_stage() {
        let input = "\n\
L68\n\
L30\n\
R48\n\
L5\n\
R60\n\
L55\n\
L1\n\
L99\n\
R14\n\
L82";
        assert_eq!(Solver::new(input.to_owned()).second_stage(), "6");
    }
}

use crate::solution::Solution;

pub struct Solver {
    battery_packs: Vec<Vec<i128>>,
}

fn parse_battery_pack(line: &str) -> Vec<i128> {
    line.chars()
        .map(|character| character.to_digit(10))
        .fold(vec![], |mut accumulator, current| match current {
            Some(value) => {
                accumulator.push(i128::from(value));

                accumulator
            }
            _ => panic!("Invalid number encountered!"),
        })
}

fn get_largest_number_from_digits(digits: &[i128], length: usize) -> i128 {
    let mut selected: Vec<i128> = vec![];
    let mut start_index = 0;

    for step in (0..length).rev() {
        let mut current_digit = 0;
        let mut current_index = start_index;

        (start_index..(digits.len() - step)).for_each(|index| {
            if digits[index] > current_digit {
                current_digit = digits[index];
                current_index = index;
            }
        });

        selected.push(current_digit);
        start_index = current_index + 1;
    }

    let Ok(result) = selected
        .iter()
        .map(i128::to_string)
        .collect::<String>()
        .parse::<i128>()
    else {
        let number = selected.iter().map(i128::to_string).collect::<String>();

        panic!("Constructed invalid integer of {number}"); // This line is a Cloudflare tribute
    };

    result
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        let battery_packs = input
            .split('\n')
            .map(str::trim)
            .filter(|line| !line.is_empty())
            .map(parse_battery_pack)
            .collect::<Vec<Vec<i128>>>();

        Solver { battery_packs }
    }

    fn first_stage(&self) -> String {
        self.battery_packs
            .iter()
            .map(|pack| get_largest_number_from_digits(pack, 2))
            .sum::<i128>()
            .to_string()
    }

    fn second_stage(&self) -> String {
        self.battery_packs
            .iter()
            .map(|pack| get_largest_number_from_digits(pack, 12))
            .sum::<i128>()
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
                "987654321111111\n\
                 811111111111119\n\
                 234234234234278\n\
                 818181911112111"
                    .to_owned()
            )
            .first_stage(),
            "357"
        );
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(
            Solver::new(
                "987654321111111\n\
             811111111111119\n\
             234234234234278\n\
             818181911112111"
                    .to_owned()
            )
            .second_stage(),
            "3121910778619"
        );
    }
}

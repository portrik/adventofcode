use crate::solution::Solution;

pub struct Solver {
    input: String,
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        Solver { input }
    }

    fn first_stage(&self) -> String {
        let lines: Vec<&str> = self.input.lines().collect();
        let mut laser_positions: Vec<usize> = lines[0]
            .chars()
            .enumerate()
            .filter(|(_index, character)| *character == 'S')
            .map(|(index, _value)| index)
            .collect();

        let mut split_count = 0;
        for line in lines[1..]
            .iter()
            .map(|line| line.chars().collect::<Vec<char>>())
        {
            laser_positions = laser_positions
                .iter()
                .flat_map(|position| match line.get(*position) {
                    Some('^') => {
                        split_count += 1;
                        vec![position - 1, position + 1]
                    }
                    _ => vec![*position],
                })
                .fold(vec![], |mut accumulator, current| {
                    if !accumulator.contains(&current) {
                        accumulator.push(current);
                    }

                    accumulator
                });
        }

        split_count.to_string()
    }

    fn second_stage(&self) -> String {
        let lines: Vec<&str> = self.input.lines().collect();
        let mut laser_positions: Vec<(usize, u64)> = lines[0]
            .chars()
            .enumerate()
            .filter(|(_index, character)| *character == 'S')
            .map(|(index, _value)| (index, 1))
            .collect();

        for line in lines[1..]
            .iter()
            .map(|line| line.chars().collect::<Vec<char>>())
        {
            laser_positions = laser_positions
                .iter()
                .flat_map(|(position, timelines)| match line.get(*position) {
                    Some('^') => vec![(position - 1, *timelines), (position + 1, *timelines)],
                    _ => vec![(*position, *timelines)],
                })
                .fold(vec![], |mut accumulator, (position, timelines)| {
                    let existing = accumulator
                        .iter()
                        .enumerate()
                        .find(|(_index, (searched_position, _))| *searched_position == position)
                        .map(|(index, (_, existing_timelines))| (index, *existing_timelines));

                    match existing {
                        Some((index, existing_timelines)) => {
                            accumulator.remove(index);
                            accumulator.push((position, existing_timelines + timelines));
                        }
                        None => accumulator.push((position, timelines)),
                    }

                    accumulator
                });
        }

        laser_positions
            .iter()
            .map(|(_, timelines)| timelines)
            .sum::<u64>()
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
                ".......S.......\n\
        ...............\n\
        .......^.......\n\
        ...............\n\
        ......^.^......\n\
        ...............\n\
        .....^.^.^.....\n\
        ...............\n\
        ....^.^...^....\n\
        ...............\n\
        ...^.^...^.^...\n\
        ...............\n\
        ..^...^.....^..\n\
        ...............\n\
        .^.^.^.^.^...^.\n\
        ...............\n\
"
                .to_owned()
            )
            .first_stage(),
            "21"
        );
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(
            Solver::new(
                ".......S.......\n\
...............\n\
.......^.......\n\
...............\n\
......^.^......\n\
...............\n\
.....^.^.^.....\n\
...............\n\
....^.^...^....\n\
...............\n\
...^.^...^.^...\n\
...............\n\
..^...^.....^..\n\
...............\n\
.^.^.^.^.^...^.\n\
...............\n\
"
                .to_owned()
            )
            .second_stage(),
            "40"
        );
    }
}

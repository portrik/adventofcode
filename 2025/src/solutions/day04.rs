use crate::solution::Solution;

#[derive(PartialEq, Eq, Clone)]
enum Item {
    ToiletPaperRoll,
    Empty,
}

pub struct Solver {
    warehouse: Vec<Vec<Item>>,
}

fn parse_line(line: &str) -> Vec<Item> {
    line.trim()
        .chars()
        .map(|character| match character {
            '@' => Item::ToiletPaperRoll,
            '.' => Item::Empty,

            _ => panic!("Unexpected character '{character}' encountered in the input!"), // Haha, look at me, I am a software developer
        })
        .collect::<Vec<Item>>()
}

fn is_accessible(warehouse: &[Vec<Item>], column: usize, row: usize) -> bool {
    let start_column = usize::max(1, column) - 1;
    let start_row = usize::max(1, row) - 1;
    let end_column = usize::min(column + 1, warehouse.len() - 1);
    let end_row = usize::min(row + 1, warehouse[start_column].len() - 1);

    let surrounding_count = warehouse[start_column..=end_column]
        .iter()
        .flat_map(|column| &column[start_row..=end_row])
        .filter(|value| **value == Item::ToiletPaperRoll)
        .collect::<Vec<&Item>>()
        .len();

    surrounding_count < 5 // 4 + the source roll itself
}

fn remove_accessible(warehouse: &mut [Vec<Item>]) -> u64 {
    let mut removed_count = 0;
    let old_warehouse = warehouse.to_vec();

    for (column_index, column) in old_warehouse.iter().enumerate() {
        for (row_index, row) in column.iter().enumerate() {
            if *row == Item::ToiletPaperRoll
                && is_accessible(&old_warehouse, column_index, row_index)
            {
                removed_count += 1;
                warehouse[column_index][row_index] = Item::Empty;
            }
        }
    }

    removed_count.to_owned()
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        let warehouse = input
            .split('\n')
            .filter(|line| !line.is_empty())
            .map(parse_line)
            .collect::<Vec<Vec<Item>>>();

        Solver { warehouse }
    }

    fn first_stage(&self) -> String {
        (0..self.warehouse.len())
            .flat_map(|column| (0..self.warehouse[column].len()).map(move |row| (column, row)))
            .map(|(column, row)| {
                self.warehouse[column][row] == Item::ToiletPaperRoll
                    && is_accessible(&self.warehouse, column, row)
            })
            .filter(|value| *value)
            .collect::<Vec<bool>>()
            .len()
            .to_string()
    }

    fn second_stage(&self) -> String {
        let mut removed = 0;
        let mut warehouse = self.warehouse.clone();

        let mut current_remove_count = remove_accessible(&mut warehouse);
        while current_remove_count > 0 {
            removed += current_remove_count;
            current_remove_count = remove_accessible(&mut warehouse);
        }

        (removed + current_remove_count).to_string()
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
        ..@@.@@@@.\n\
        @@@.@.@.@@\n\
        @@@@@.@.@@\n\
        @.@@@@..@.\n\
        @@.@@@@.@@\n\
        .@@@@@@@.@\n\
        .@.@.@.@@@\n\
        @.@@@.@@@@\n\
        .@@@@@@@@.\n\
        @.@.@@@.@."
                    .to_owned()
            )
            .first_stage(),
            "13"
        );
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(
            Solver::new(
                "\n\
		..@@.@@@@.\n\
		@@@.@.@.@@\n\
		@@@@@.@.@@\n\
		@.@@@@..@.\n\
		@@.@@@@.@@\n\
		.@@@@@@@.@\n\
		.@.@.@.@@@\n\
		@.@@@.@@@@\n\
		.@@@@@@@@.\n\
		@.@.@@@.@."
                    .to_owned()
            )
            .second_stage(),
            "43"
        );
    }
}

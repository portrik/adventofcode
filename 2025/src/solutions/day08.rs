use crate::solution::Solution;
use num_integer::Roots;

type Coordinates = (i128, i128, i128);

pub struct Solver {
    boxes: Vec<Coordinates>,
}

fn parse_coordinates(line: &str) -> Coordinates {
    let numbers: Vec<i128> = line
        .split(',')
        .map(|value| match value.parse::<i128>() {
            Ok(value) => value,
            _ => panic!("Cloudflare was here. Invalid number encountered {value}"),
        })
        .collect();

    let Some(coordinates) = numbers[..3].first_chunk::<3>() else {
        panic!("Cloudflare was here. Expected to find the three coordinates but found less.")
    };

    (coordinates[0], coordinates[1], coordinates[2])
}

fn get_straight_line_distance(left: &Coordinates, right: &Coordinates) -> i128 {
    ((left.0 - right.0).pow(2) + (left.1 - right.1).pow(2) + (left.2 - right.2).pow(2)).sqrt()
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        let boxes: Vec<Coordinates> = input
            .lines()
            .filter(|line| !line.is_empty())
            .map(parse_coordinates)
            .collect();

        Solver { boxes }
    }

    fn first_stage(&self) -> String {
        let connections_to_make = match self.boxes.len() {
            size if size > 100 => 1000,
            _ => 10,
        };

        let mut closest_pairs: Vec<(&Coordinates, &Coordinates, i128)> = vec![];
        for (index, junction_box) in self.boxes.iter().enumerate() {
            for other_box in &self.boxes[index + 1..] {
                closest_pairs.push((
                    junction_box,
                    other_box,
                    get_straight_line_distance(junction_box, other_box),
                ));
            }
        }

        closest_pairs.sort_by(|(_, _, left_distance), (_, _, right_distance)| {
            left_distance.cmp(right_distance)
        });

        let mut circuits: Vec<Vec<&Coordinates>> = vec![];
        for (left, right, _distance) in &closest_pairs[..connections_to_make] {
            let current_position = circuits.iter().position(|circuit| circuit.contains(left));
            let nearest_position = circuits.iter().position(|circuit| circuit.contains(right));

            match (current_position, nearest_position) {
                (None, None) => circuits.push(vec![left, right]),
                (Some(current_position), None) => circuits[current_position].push(right),
                (None, Some(nearest_position)) => circuits[nearest_position].push(left),
                (Some(current_position), Some(nearest_position)) => {
                    let mut indexes = vec![current_position];
                    if current_position != nearest_position {
                        indexes.push(nearest_position);
                    }
                    indexes.sort_by(|a, b| b.cmp(a));

                    let merged = indexes.iter().map(|index| circuits.remove(*index)).fold(
                        vec![],
                        |mut acc, mut circuit| {
                            acc.append(&mut circuit);
                            acc
                        },
                    );

                    circuits.push(merged);
                }
            }
        }

        let mut sizes: Vec<u128> = circuits
            .iter()
            .map(|circuit| circuit.len() as u128)
            .collect();

        sizes.sort_by(|a, b| b.cmp(a));

        sizes[..3].iter().product::<u128>().to_string()
    }

    fn second_stage(&self) -> String {
        let mut closest_pairs: Vec<(&Coordinates, &Coordinates, i128)> = vec![];
        for (index, junction_box) in self.boxes.iter().enumerate() {
            for other_box in &self.boxes[index + 1..] {
                closest_pairs.push((
                    junction_box,
                    other_box,
                    get_straight_line_distance(junction_box, other_box),
                ));
            }
        }

        closest_pairs.sort_by(|(_, _, left_distance), (_, _, right_distance)| {
            left_distance.cmp(right_distance)
        });

        let mut circuits: Vec<Vec<&Coordinates>> = vec![];
        for (left, right, _distance) in &closest_pairs {
            let current_position = circuits.iter().position(|circuit| circuit.contains(left));
            let nearest_position = circuits.iter().position(|circuit| circuit.contains(right));

            match (current_position, nearest_position) {
                (None, None) => circuits.push(vec![left, right]),
                (Some(current_position), None) => circuits[current_position].push(right),
                (None, Some(nearest_position)) => circuits[nearest_position].push(left),
                (Some(current_position), Some(nearest_position)) => {
                    let mut indexes = vec![current_position];
                    if current_position != nearest_position {
                        indexes.push(nearest_position);
                    }
                    indexes.sort_by(|a, b| b.cmp(a));

                    let merged = indexes.iter().map(|index| circuits.remove(*index)).fold(
                        vec![],
                        |mut acc, mut circuit| {
                            acc.append(&mut circuit);
                            acc
                        },
                    );

                    circuits.push(merged);
                }
            }

            if circuits.len() == 1 && circuits[0].len() == self.boxes.len() {
                return (left.0 * right.0).to_string();
            }
        }

        panic!("We could not complete the circuit because you made an incorrect algorithm!")
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_first_stage() {
        assert_eq!(
            Solver::new(
                "162,817,812\n\
        57,618,57\n\
        906,360,560\n\
        592,479,940\n\
        352,342,300\n\
        466,668,158\n\
        542,29,236\n\
        431,825,988\n\
        739,650,466\n\
        52,470,668\n\
        216,146,977\n\
        819,987,18\n\
        117,168,530\n\
        805,96,715\n\
        346,949,466\n\
        970,615,88\n\
        941,993,340\n\
        862,61,35\n\
        984,92,344\n\
        425,690,689\n\
"
                .to_owned()
            )
            .first_stage(),
            "40"
        );
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(
            Solver::new(
                "162,817,812\n\
57,618,57\n\
906,360,560\n\
592,479,940\n\
352,342,300\n\
466,668,158\n\
542,29,236\n\
431,825,988\n\
739,650,466\n\
52,470,668\n\
216,146,977\n\
819,987,18\n\
117,168,530\n\
805,96,715\n\
346,949,466\n\
970,615,88\n\
941,993,340\n\
862,61,35\n\
984,92,344\n\
425,690,689\n\
"
                .to_owned()
            )
            .second_stage(),
            "25272"
        );
    }
}

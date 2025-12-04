mod solution;
mod solutions;

use std::{env, fs, path::Path, path::PathBuf, process::exit};

use crate::solution::Solution;

enum Day {
    Day00,
    Day01,
    Day02,
    Day03,
    Day04,
}

fn run_solution<Solver: Solution>(solver: &Solver) -> (String, String) {
    (solver.first_stage(), solver.second_stage())
}

fn main() {
    let arguments: Vec<String> = env::args().collect();
    let Some(day_argument) = arguments.get(1).map(std::string::String::as_str) else {
        eprintln!("Day number argument is required!");

        exit(1);
    };

    let Ok(day_number) = day_argument.parse::<i32>() else {
        eprintln!("Invalid day number provided! '{day_argument}' is not a valid number.");

        exit(1);
    };

    let parsed_day: Option<Day> = match day_number {
        0 => Some(Day::Day00),
        1 => Some(Day::Day01),
        2 => Some(Day::Day02),
        3 => Some(Day::Day03),
        4 => Some(Day::Day04),
        _ => None,
    };

    let Some(day) = parsed_day else {
        eprintln!("The day under the specified number ({day_number}) is not implemented.");

        exit(1);
    };

    let input_path_string = PathBuf::from(format!("./input/day{day_number:0>2}.txt"));
    let input_path: &Path = Path::new(&input_path_string);

    let Ok(input) = fs::read_to_string(input_path) else {
        eprintln!("The input file for the day {day_number} could not be loaded. Is it present?");

        exit(1);
    };

    let (first_stage, second_stage) = match day {
        Day::Day00 => run_solution(&solutions::day00::Solver::new(input)),
        Day::Day01 => run_solution(&solutions::day01::Solver::new(input)),
        Day::Day02 => run_solution(&solutions::day02::Solver::new(input)),
        Day::Day03 => run_solution(&solutions::day03::Solver::new(input)),
        Day::Day04 => run_solution(&solutions::day04::Solver::new(input)),
    };

    println!("First stage: {first_stage}");
    println!("Second stage: {second_stage}");
}

module main

import os
import cli { Command, Flag }
import day_01
import day_02
import day_03

fn solve_day(command Command) {
	day := command.flags.get_string('day') or { panic('No day was provided!') }

	input_file := os.join_path(os.getwd(), 'day_$day', 'input.txt')
	input := os.read_file(input_file) or {
		panic('Unknown file path $input_file')
		return
	}

	match day {
		'01' {
			println(day_01.solve_first(input))
			println(day_01.solve_second(input))
		}
		'02' {
			println(day_02.solve_first(input))
			println(day_02.solve_second(input))
		}
		'03' {
			println(day_03.solve_first(input))
			println(day_03.solve_second(input))
		}
		else {
			panic('Selected day ($day) is not implemened!')
		}
	}
}

fn main() {
	mut cmd := Command{
		name: 'aoc_2022'
		description: 'Advent of Code 2022 Solutions'
		version: '0.2.0'
		execute: solve_day
	}

	cmd.add_flag(Flag{
		flag: .string
		required: true
		name: 'day'
		abbrev: 'd'
		description: 'Day to solve'
	})

	cmd.setup()
	cmd.parse(os.args)
}

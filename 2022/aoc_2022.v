module main

import os
import cli { Command, Flag }
import day_01
import day_02

fn solve_day(input Command) {
	day := input.flags.get_string('day') or { panic('No day was provided!') }

	match day {
		'01' {
			day_01.solve()
		}
		'02' {
			day_02.solve()
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

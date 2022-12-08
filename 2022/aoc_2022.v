module main

import os
import cli { Command, Flag }
import day_01
import day_02
import day_03
import day_04
import day_05
import day_06
import day_07
import day_08

fn solve_day(command Command)! {
	day := command.flags.get_string('day') or { panic('No day was provided!') }

	input_file := os.join_path(os.getwd(), 'day_$day', 'input.txt')
	input := os.read_file(input_file) or {
		panic('Unknown file path $input_file')
		return
	}

	mut first := "Not implemented!"
	mut second := "Not implemented!"

	match day {
		'01' {
			first = day_01.solve_first(input).str()
			second = day_01.solve_second(input).str()
		}
		'02' {
			first = day_02.solve_first(input).str()
			second = day_02.solve_second(input).str()
		}
		'03' {
			first = day_03.solve_first(input).str()
			second = day_03.solve_second(input).str()
		}
		'04' {
			first = day_04.solve_first(input).str()
			second = day_04.solve_second(input).str()
		}
		'05' {
			first = day_05.solve_first(input).str()
			second = day_05.solve_second(input).str()
		}
		'06' {
			first = day_06.solve_first(input).str()
			second = day_06.solve_second(input).str()
		}
		'07' {
			first = day_07.solve_first(input).str()
			second = day_07.solve_second(input).str()
		}
		'08' {
			first = day_08.solve_first(input).str()
			second = day_08.solve_second(input).str()
		}
		else {
			panic('Selected day ($day) is not implemened!')
		}
	}

	println('First solution:\t$first')
	println('Second soluton:\t$second')
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

module day_01

import os

fn solve_first(input []string) int {
	mut max := 0
	mut current := 0

	for line in input {
		if line.len > 0 {
			current += line.int()
			continue
		}

		if current > max {
			max = current
		}

		current = 0
	}

	return max
}

fn solve_second(input []string) int {
	mut values := []int{}
	mut current := 0

	for line in input {
		if line.len > 0 {
			current += line.int()
			continue
		}

		values << current
		current = 0
	}

	values.sort()
	return values[values.len - 1] + values[values.len - 2] + values[values.len - 3]
}

pub fn solve() {
	filename := os.join_path(os.getwd(), 'day_01', 'input.txt')
	data := os.read_file(filename) or {
		panic('error reading file $filename')
		return
	}
	lines := data.split('\n')

	println(solve_first(lines))
	println(solve_second(lines))
}

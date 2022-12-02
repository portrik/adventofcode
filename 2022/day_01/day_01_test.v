module day_01

import os

fn test_solve_first() {
	filename := os.join_path(os.getwd(), 'day_01', 'test.txt')
	data := os.read_file(filename) or {
		panic('error reading file $filename')
		return
	}
	lines := data.split('\n')

	assert solve_first(lines) == 24000
}

fn test_solve_second() {
	filename := os.join_path(os.getwd(), 'day_01', 'test.txt')
	data := os.read_file(filename) or {
		panic('error reading file $filename')
		return
	}
	lines := data.split('\n')

	assert solve_second(lines) == 45000
}

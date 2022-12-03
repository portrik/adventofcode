module day_01

import os

fn test_solve_first() {
	filename := os.join_path(os.getwd(), 'day_01', 'test.txt')
	data := os.read_file(filename) or {
		panic('error reading file $filename')
		return
	}

	assert solve_first(data) == 24000
}

fn test_solve_second() {
	filename := os.join_path(os.getwd(), 'day_01', 'test.txt')
	data := os.read_file(filename) or {
		panic('error reading file $filename')
		return
	}

	assert solve_second(data) == 45000
}

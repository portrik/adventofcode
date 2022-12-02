module main

import os

fn test_solve_first() {
	filename := './02/test.txt'
	data := os.read_file(filename) or {
		panic('Could not read test file $filename')
		return
	}
	lines := data.split('\n').filter(it.len > 0)

	assert solve_first(lines) == 15
}

fn test_solve_second() {
	filename := './02/test.txt'
	data := os.read_file(filename) or {
		panic('Could not read test file $filename')
		return
	}
	lines := data.split('\n').filter(it.len > 0)

	assert solve_second(lines) == 12
}

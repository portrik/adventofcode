module day_06

import os

fn test_solve_first() {
	filename := os.join_path(os.getwd(), 'day_06', 'test.txt')
	data := os.read_file(filename) or {
		panic('Could not read test file $filename')
		return
	}
	lines := data.split('\n').filter(it.len > 0)
	expected := [7, 5, 6, 10, 11]

	for i := 0; i < expected.len; i++ {
		assert solve_first(lines[i]) == expected[i]
	}
}

fn test_solve_second() {
	filename := os.join_path(os.getwd(), 'day_06', 'test.txt')
	data := os.read_file(filename) or {
		panic('Could not read test file $filename')
		return
	}
	lines := data.split('\n').filter(it.len > 0)
	expected := [19, 23, 23, 29, 26]

	for i := 0; i < expected.len; i++ {
		assert solve_second(lines[i]) == expected[i]
	}
}

module day_10

import os

fn test_solve_first() {
	filename := os.join_path(os.getwd(), 'day_10', 'test.txt')
	data := os.read_file(filename) or {
		panic('Could not read test file ${filename}')
		return
	}

	assert solve_first(data) == 13140
}

fn test_solve_second() {
	filename := os.join_path(os.getwd(), 'day_10', 'test.txt')
	data := os.read_file(filename) or {
		panic('Could not read test file ${filename}')
		return
	}

	assert solve_second(data) == ['##..##..##..##..##..##..##..##..##..##..',
		'###...###...###...###...###...###...###.', '####....####....####....####....####....',
		'#####.....#####.....#####.....#####.....', '######......######......######......####',
		'#######.......#######.......#######.....'].join('\n')
}

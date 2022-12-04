module day_04

fn pair_line_to_array(line string) []int {
	pair := line.split(',')
	left := pair[0].split('-')
	right := pair[1].split('-')

	return [left[0].int(), left[1].int(), right[0].int(), right[1].int()]
}

pub fn solve_first(input string) int {
	return input.split('\n').filter(it.len > 0).map(pair_line_to_array(it)).map(fn (pair []int) bool {
		return (pair[0] <= pair[2] && pair[1] >= pair[3])
			|| (pair[2] <= pair[0] && pair[3] >= pair[1])
	}).filter(it).len
}

pub fn solve_second(input string) int {
	return input.split('\n').filter(it.len > 0).map(pair_line_to_array(it)).map(fn (pair []int) bool {
		return (pair[0] <= pair[2] && pair[1] >= pair[2])
			|| (pair[0] <= pair[3] && pair[1] >= pair[3])
			|| (pair[2] <= pair[0] && pair[3] >= pair[0])
			|| (pair[2] <= pair[1] && pair[3] >= pair[1])
	}).filter(it).len
}

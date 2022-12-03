module day_01

pub fn solve_first(input string) int {
	mut max := 0
	mut current := 0

	for line in input.split('\n') {
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

pub fn solve_second(input string) int {
	mut values := []int{}
	mut current := 0

	for line in input.split('\n') {
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

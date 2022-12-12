module day_10

import math

pub fn solve_first(input string) int {
	operations := input.split('\n').filter(it.len > 0)

	mut register_x := 1
	mut cycle := 0
	mut result := 0

	for operation in operations {
		mut value := 0
		mut jump := 1

		if operation != 'noop' {
			value = operation.split(' ')[1].int()
			jump = 2
		}

		cycle += jump

		for i := jump - 1; i >= 0; i-- {
			if (cycle - i) % 40 == 20 {
				result += register_x * (cycle - i)
				break
			}
		}

		register_x += value
	}

	return result
}

pub fn solve_second(input string) string {
	operations := input.split('\n').filter(it.len > 0)

	mut sprite_position := 1
	mut cycle := 0
	mut result := [][]string{len: 6, init: []string{len: 40, init: '.'}}

	for operation in operations {
		mut value := 0
		mut jump := 1

		if operation != 'noop' {
			value = operation.split(' ')[1].int()
			jump = 2
		}

		cycle += jump

		for i := jump - 1; i >= 0; i-- {
			position := cycle - i - 1

			if math.abs(sprite_position % 40 - position % 40) < 2 {
				result[position / 40][position % 40] = '#'
			}
		}

		sprite_position += value
	}

	return result.map(it.join('')).join('\n')
}

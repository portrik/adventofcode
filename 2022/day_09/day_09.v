module day_09

import math

fn get_move(direction string) []int {
	match direction {
		'U' {
			return [0, 1]
		}
		'D' {
			return [0, -1]
		}
		'R' {
			return [1, 0]
		}
		'L' {
			return [-1, 0]
		}
		else {
			panic('Unknonw direction ${direction}!')
		}
	}
}

pub fn solve_first(input string) int {
	moves := input.split('\n').filter(it.len > 0).map(it.split(' '))

	mut paths := map[string]bool{}
	mut head := [0, 0]
	mut tail := [0, 0]

	for move in moves {
		change := get_move(move[0])
		distance := move[1].int()

		for _ in 0 .. distance {
			head[0] += change[0]
			head[1] += change[1]

			x_difference := head[0] - tail[0]
			y_difference := head[1] - tail[1]

			if math.abs(x_difference) > 1 || math.abs(y_difference) > 1 {
				tail[0] += if x_difference != 0 { math.signi(x_difference) } else { 0 }
				tail[1] += if y_difference != 0 { math.signi(y_difference) } else { 0 }
			}

			paths['${tail[0]},${tail[1]}'] = true
		}
	}

	return paths.keys().len
}

pub fn solve_second(input string) int {
	moves := input.split('\n').filter(it.len > 0).map(it.split(' '))

	mut paths := map[string]bool{}
	mut ropes := [][]int{len: 10, init: [0, 0]}

	for move in moves {
		change := get_move(move[0])
		distance := move[1].int()

		for _ in 0 .. distance {
			ropes[0][0] += change[0]
			ropes[0][1] += change[1]

			for i in 1 .. ropes.len {
				x_difference := ropes[i - 1][0] - ropes[i][0]
				y_difference := ropes[i - 1][1] - ropes[i][1]

				if math.abs(x_difference) > 1 || math.abs(y_difference) > 1 {
					ropes[i][0] += if x_difference != 0 { math.signi(x_difference) } else { 0 }
					ropes[i][1] += if y_difference != 0 { math.signi(y_difference) } else { 0 }
				}
			}

			paths['${ropes[ropes.len - 1][0]},${ropes[ropes.len - 1][1]}'] = true
		}
	}

	return paths.keys().len
}

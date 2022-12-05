module day_05

import math
import arrays


fn parse_move_line(line string) []int {
	split := line.split(' ')

	return [split[1].int(), split[3].int() - 1, split[5].int() - 1]
}

fn parse_columns(lines [][]rune) [][]rune {
	count := int(math.round(lines[0].len / 4))
	mut columns := [][]rune{len: count + 1, init: []rune{}}

	for line in lines {
		for j := 1; j < line.len - 1; j += 4 {
			if line[j] != ` ` {
				columns[j / 4] << line[j]
			}
		}
	}

	return columns.map(it.reverse())
}

pub fn solve_first(input string) string {
	lines := input.split('\n')
	delimiter := lines.index('')

	mut columns := parse_columns(lines[..delimiter - 1].map(it.runes()))
	moves := lines[delimiter + 1..].filter(it.len > 0).map(parse_move_line(it))

	for move in moves {
		for _ in 0 .. move[0] {
			element := columns[move[1]].pop()
			columns[move[2]] << element
		}
	}

	return arrays.fold(columns.map(it[it.len - 1]), '', fn (acc string, element rune) string {
		return '$acc$element'
	})
}

pub fn solve_second(input string) string {
	lines := input.split('\n')
	delimiter := lines.index('')

	mut columns := parse_columns(lines[..delimiter - 1].map(it.runes()))
	moves := lines[delimiter + 1..].filter(it.len > 0).map(parse_move_line(it))

	for move in moves {
		mut elements := []rune{}
		for _ in 0 .. move[0] {
			elements << columns[move[1]].pop()
		}

		for element in elements.reverse() {
			columns[move[2]] << element
		}
	}

	return arrays.fold(columns.map(it[it.len - 1]), '', fn (acc string, element rune) string {
		return '$acc$element'
	})
}

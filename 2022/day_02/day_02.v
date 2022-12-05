module day_02

import arrays

enum Choice {
	rock = 1
	paper = 2
	scissors = 3
}

enum Result {
	win = 6
	draw = 3
	lose = 0
}

fn match_choice(choice string) Choice {
	match choice {
		'X' {
			return Choice.rock
		}
		'A' {
			return Choice.rock
		}
		'Y' {
			return Choice.paper
		}
		'B' {
			return Choice.paper
		}
		'Z' {
			return Choice.scissors
		}
		'C' {
			return Choice.scissors
		}
		else {
			panic('Unknown choice type $choice')
		}
	}
}

fn match_result(result string) Result {
	match result {
		'X' {
			return Result.lose
		}
		'Y' {
			return Result.draw
		}
		'Z' {
			return Result.win
		}
		else {
			panic('Unknown result type $result')
		}
	}
}

pub fn solve_first(input string) int {
	return arrays.fold(input.split('\n').filter(it.len > 0).map(it.split(' ')).map(fn (round []string) int {
		choice := match_choice(round[1])
		oponent := match_choice(round[0])

		mut score := int(choice)

		if (oponent == Choice.rock && choice == Choice.paper)
			|| (oponent == Choice.paper && choice == Choice.scissors)
			|| (oponent == Choice.scissors && choice == Choice.rock) {
			score += int(Result.win)
		} else if (oponent == Choice.rock && choice == Choice.rock)
			|| (oponent == Choice.paper && choice == Choice.paper)
			|| (oponent == Choice.scissors && choice == Choice.scissors) {
			score += int(Result.draw)
		}

		return score
	}), 0, fn (acc int, elem int) int {
		return acc + elem
	})
}

pub fn solve_second(input string) int {
	return arrays.fold(input.split('\n').filter(it.len > 0).map(it.split(' ')).map(fn (round []string) int {
		oponent := match_choice(round[0])
		result := match_result(round[1])

		mut score := int(result)

		if result == Result.win {
			if oponent == Choice.rock {
				score += int(Choice.paper)
			} else if oponent == Choice.paper {
				score += int(Choice.scissors)
			} else {
				score += int(Choice.rock)
			}
		} else if result == Result.draw {
			score += int(oponent)
		} else {
			if oponent == Choice.rock {
				score += int(Choice.scissors)
			} else if oponent == Choice.paper {
				score += int(Choice.rock)
			} else {
				score += int(Choice.paper)
			}
		}

		return score
	}), 0, fn (acc int, elem int) int {
		return acc + elem
	})
}

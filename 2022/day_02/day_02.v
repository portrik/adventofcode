module day_02

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
	mut score := 0

	for line in input.split('\n') {
		if line.len < 1 {
			continue
		}

		round := line.split(' ')
		choice := match_choice(round[1])
		oponent := match_choice(round[0])

		score += int(choice)

		if (oponent == Choice.rock && choice == Choice.paper)
			|| (oponent == Choice.paper && choice == Choice.scissors)
			|| (oponent == Choice.scissors && choice == Choice.rock) {
			score += int(Result.win)
		} else if (oponent == Choice.rock && choice == Choice.rock)
			|| (oponent == Choice.paper && choice == Choice.paper)
			|| (oponent == Choice.scissors && choice == Choice.scissors) {
			score += int(Result.draw)
		}
	}

	return score
}

pub fn solve_second(input string) int {
	mut score := 0

	for line in input.split('\n') {
		if line.len < 1 {
			continue
		}

		round := line.split(' ')
		oponent := match_choice(round[0])
		result := match_result(round[1])

		score += int(result)

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
	}

	return score
}

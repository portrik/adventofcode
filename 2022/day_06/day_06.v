module day_06

fn is_unique(tested []rune) bool {
	for item in tested {
		mut count := 0

		for i := 0; i < tested.len; i++ {
			if tested[i] == item {
				count++
			}
		}

		if count > 1 {
			return false
		}
	}

	return true
}

fn get_first_unique_occurrence(tested []rune, size int) int {
	for i := size; i < tested.len; i++ {
		if is_unique(tested[i - size .. i]) {
			return i
		}
	}

	return - 1
}

pub fn solve_first(input string) int {
	return get_first_unique_occurrence(input.runes(), 4)
}

pub fn solve_second(input string) int {
	return get_first_unique_occurrence(input.runes(), 14)
}

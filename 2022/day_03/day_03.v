module day_03

fn add_char(char rune) int {
	if u8(char) >= 96 {
		return u8(char) - 96
	}

	return u8(char) - 38
}

pub fn solve_first(input string) int {
	mut result := 0
	rucksacks := input.split('\n').map(fn (rucksack string) [][]rune {
		return [rucksack[..rucksack.len / 2].runes(), rucksack[rucksack.len / 2..].runes()]
	})

	for rucksack in rucksacks {
		for value in rucksack[0] {
			if rucksack[1].index(value) >= 0 {
				result += add_char(value)
				break
			}
		}
	}

	return result
}

pub fn solve_second(input string) int {
	mut result := 0
	rucksacks := input.split('\n').map(it.runes())

	for i := 0; i < rucksacks.len; i += 3 {
		for value in rucksacks[i] {
			in_second := rucksacks[i + 1].index(value) >= 0
			in_third := rucksacks[i + 2].index(value) >= 0

			if in_second && in_third {
				result += add_char(value)
				break
			}
		}
	}

	return result
}

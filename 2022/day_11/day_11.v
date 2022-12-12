module day_11

import math

struct Monkey {
	operation    []string
	test         i64
	true_target  int
	false_target int
mut:
	items       []i64
	inspections i64
}

pub fn solve_first(input string) i64 {
	lines := input.split('\n')
	mut monkeys := []Monkey{}

	for i := 0; i < lines.len; i += 7 {
		monkeys << Monkey{
			items: lines[i + 1].split(': ')[1].split(',').filter(it.len > 0).map(it.trim(' ').i64())
			operation: lines[i + 2].split(': ')[1].split(' = ')[1].split(' ').filter(it.len > 0).map(it.trim(' '))
			test: lines[i + 3].split(' by ')[1].i64()
			true_target: lines[i + 4].split(' monkey ')[1].int()
			false_target: lines[i + 5].split(' monkey ')[1].int()
		}
	}

	for _ in 0 .. 20 {
		for i := 0; i < monkeys.len; i++ {
			for item in monkeys[i].items {
				mut worry_level := item

				mut left := if monkeys[i].operation[0] == 'old' {
					item
				} else {
					monkeys[i].operation[0].i64()
				}
				mut right := if monkeys[i].operation[2] == 'old' {
					item
				} else {
					monkeys[i].operation[2].i64()
				}

				if monkeys[i].operation[1] == '*' {
					worry_level = left * right
				} else {
					worry_level = left + right
				}

				worry_level /= 3

				if worry_level % monkeys[i].test == 0 {
					monkeys[monkeys[i].true_target].items << worry_level
				} else {
					monkeys[monkeys[i].false_target].items << worry_level
				}

				monkeys[i].inspections++
			}

			monkeys[i].items = []
		}
	}

	mut inspections := monkeys.map(it.inspections)
	inspections.sort()

	return inspections[inspections.len - 1] * inspections[inspections.len - 2]
}

pub fn solve_second(input string) i64 {
	lines := input.split('\n')
	mut monkeys := []Monkey{}

	for i := 0; i < lines.len; i += 7 {
		monkeys << Monkey{
			items: lines[i + 1].split(': ')[1].split(',').filter(it.len > 0).map(it.trim(' ').i64())
			operation: lines[i + 2].split(': ')[1].split(' = ')[1].split(' ').filter(it.len > 0).map(it.trim(' '))
			test: lines[i + 3].split(' by ')[1].int()
			true_target: lines[i + 4].split(' monkey ')[1].int()
			false_target: lines[i + 5].split(' monkey ')[1].int()
		}
	}

	mut divisor := math.lcm(monkeys[0].test, monkeys[1].test)
	for i in 2 .. monkeys.len {
		divisor = math.lcm(divisor, monkeys[i].test)
	}

	for _ in 0 .. 10000 {
		for i := 0; i < monkeys.len; i++ {
			for item in monkeys[i].items {
				left := if monkeys[i].operation[0] == 'old' {
					item
				} else {
					monkeys[i].operation[0].i64()
				}
				right := if monkeys[i].operation[2] == 'old' {
					item
				} else {
					monkeys[i].operation[2].i64()
				}

				mut worry_level := if monkeys[i].operation[1] == '*' {
					left * right
				} else {
					left + right
				}

				worry_level %= divisor

				if worry_level % monkeys[i].test == 0 {
					monkeys[monkeys[i].true_target].items << worry_level
				} else {
					monkeys[monkeys[i].false_target].items << worry_level
				}

				monkeys[i].inspections++
			}

			monkeys[i].items = []
		}
	}

	mut inspections := monkeys.map(it.inspections)
	inspections.sort()

	return inspections[inspections.len - 1] * inspections[inspections.len - 2]
}

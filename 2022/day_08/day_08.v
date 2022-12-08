module day_08

import arrays

struct Tree {
	value int
mut:
	visible  bool
}

pub fn solve_first(input string) int {
	mut grid := input.split('\n').filter(it.len > 0).map(it.split('').map(Tree{
		value: it.int()
		visible: false
	}))

	// Checks rows
	for x := 0; x < grid.len; x++ {
		mut highest_visible := grid[x][0].value
		grid[x][0].visible = true

		for y := 0; y < grid[x].len; y++ {
			if grid[x][y].value > highest_visible {
				grid[x][y].visible = true
				highest_visible = grid[x][y].value
			}
		}

		highest_visible = grid[x][grid[x].len - 1].value
		grid[x][grid[x].len - 1].visible = true

		for y := grid[x].len - 1; y > -1; y-- {
			if grid[x][y].value > highest_visible {
				grid[x][y].visible = true
				highest_visible = grid[x][y].value
			}
		}
	}

	for y := 0; y < grid[0].len; y++ {
		mut highest_visible := grid[0][y].value
		grid[0][y].visible = true

		for x := 0; x < grid.len; x++ {
			if grid[x][y].value > highest_visible {
				grid[x][y].visible = true
				highest_visible = grid[x][y].value
			}
		}

		highest_visible = grid[grid.len - 1][y].value
		grid[grid.len - 1][y].visible = true

		for x := grid.len - 1; x > -1; x-- {
			if grid[x][y].value > highest_visible {
				grid[x][y].visible = true
				highest_visible = grid[x][y].value
			}
		}
	}

	return arrays.fold(grid, 0, fn (acc int, element []Tree) int {
		return acc + arrays.fold(element, 0, fn (acc int, element Tree) int {
			if !element.visible {
				return acc
			}

			return acc + 1
		})
	})
}

pub fn solve_second(input string) int {
	mut grid := input.split('\n').filter(it.len > 0).map(it.split('').map(Tree{
		value: it.int()
		visible: false
	}))
	mut highest := 0

	for x := 0; x < grid.len; x++ {
		for y := 0; y < grid[x].len; y++ {
			mut top := 0
			mut bottom := 0
			mut right := 0
			mut left := 0

			for i := x - 1; i > -1; i-- {
				top++

				if grid[i][y].value >= grid[x][y].value {
					break
				}
			}

			for i := x + 1; i < grid.len; i++ {
				bottom++

				if grid[i][y].value >= grid[x][y].value {
					break
				}
			}

			for i := y - 1; i > -1; i-- {
				left++

				if grid[x][i].value >= grid[x][y].value {
					break
				}
			}

			for i := y + 1; i < grid[x].len; i++ {
				right++

				if grid[x][i].value >= grid[x][y].value {
					break
				}
			}

			if top * bottom * right * left > highest {
				highest = top * bottom * right * left
			}
		}
	}

	return highest
}

module day_07

type ParentDirectory = ?Directory

struct Directory {
	name string
mut:
	files       []int        = []
	directories []&Directory = []
	parent      []&Directory = []
}

fn (d Directory) get_size() int {
	mut sum := 0

	for file in d.files {
		sum += file
	}

	for directory in d.directories {
		sum += directory.get_size()
	}

	return sum
}

fn create_structure(input string) Directory {
	mut root := Directory{
		name: '/'
	}
	mut current := &root

	for line in input.split('\n').filter(it.len > 0)[2..] {
		split := line.split(' ')

		if split[1] == 'cd' {
			if split[2] == '..' {
				if current.parent.len < 1 {
					panic('Trying to cd out of root!')
					return root
				}

				current = current.parent[0]
			} else {
				current = current.directories.filter(it.name == split[2])[0]
			}
		} else if split[0] == 'dir' {
			current.directories << &Directory{
				name: split[1]
				parent: [current]
			}
		} else {
			current.files << split[0].int()
		}
	}

	return root
}

pub fn solve_first(input string) int {
	root := create_structure(input)

	mut total := 0
	mut dirs := [&root]
	mut index := 0
	for index < dirs.len {
		dirs << dirs[index].directories
		size := dirs[index].get_size()

		if size <= 100000 {
			total += size
		}

		index++
	}

	return total
}

pub fn solve_second(input string) int {
	root := create_structure(input)

	mut sizes := []int{}
	mut dirs := [&root]
	mut index := 0
	for index < dirs.len {
		dirs << dirs[index].directories
		sizes << dirs[index].get_size()
		index++
	}


	sizes.sort()

	target := 30000000 - (70000000 - root.get_size())
	for size in sizes {
		if size >= target {
			return size
		}
	}

	return -1
}

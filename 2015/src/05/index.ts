import { readFileSync } from 'fs';
import { join } from 'path';

// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { BaseSolution } from '../index';

export class Solution implements BaseSolution {
	lines: string[] = [];

	constructor() {
		if (process.env.NODE_ENV !== 'test') {
			this.lines = readFileSync(join(__dirname, 'input.txt'), 'utf-8').split(
				'\n'
			).filter((line) => line.trim().length > 0);
		}
	}

	first = (): number => {
		return this.lines.filter((line) => this.isNice(line)).length;
	};

	second = (): number => {
		return this.lines.filter((line) => this.isNice2(line)).length;
	};

	isNice = (tested: string): boolean => {
		const invalid = ['ab', 'cd', 'pq', 'xy'];
		for (const sub of invalid) {
			if (tested.includes(sub)) {
				return false;
			}
		}

		const vowelCount = [...tested.matchAll(/a|e|i|o|u/g)].length;
		if (vowelCount < 3) {
			return false;
		}

		for (let i = 0; i < tested.length - 1; ++i) {
			if (tested[i] === tested[i + 1]) {
				return true;
			}
		}

		return false;
	};

	isNice2 = (tested: string): boolean => {
		let hasMirror = false;

		for (let i = 1; i < tested.length - 1; ++i) {
			if (tested[i - 1] === tested[i + 1]) {
				hasMirror = true;
				break;
			}
		}

		if (!hasMirror) {
			return false;
		}

		for (let i = 0; i < tested.length - 1; ++i) {
			if (tested.indexOf(tested.substring(i, i + 2), i + 2) > -1) {
				return true;
			}
		}

		return false;
	};
}

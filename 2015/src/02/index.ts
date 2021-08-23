import { readFileSync } from 'fs';
import { join } from 'path';

// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { BaseSolution } from '../index';
export class Solution implements BaseSolution {
	lines: string[] = [];

	constructor() {
		if (process.env.NODE_ENV !== 'test') {
			this.lines = readFileSync(join(__dirname, 'input.txt'), 'utf-8')
				.split('\n')
				.filter((line) => line.length > 0);
		}
	}

	first = (): number => {
		return this.lines
			.map((line) => {
				const split = line.split('x');

				return this.bow(Number(split[0]), Number(split[1]), Number(split[2]));
			})
			.reduce((acc, cur) => (acc += cur), 0);
	};

	second = (): number => {
		return this.lines
			.map((line) => {
				const split = line.split('x');

				return this.paper(Number(split[0]), Number(split[1]), Number(split[2]));
			})
			.reduce((acc, cur) => (acc += cur), 0);
	};

	bow = (length: number, width: number, height: number): number => {
		const values = [length, width, height].sort((a, b) => b - a);
		values.splice(0, 1);
		const base = values.reduce((acc, val) => (acc += 2 * val), 0);
		const extra = length * width * height;

		return base + extra;
	};

	paper = (length: number, width: number, height: number): number => {
		const lw = length * width;
		const wh = width * height;
		const hl = height * length;
		const extra = Math.min(lw, wh, hl);

		return 2 * lw + 2 * wh + 2 * hl + extra;
	};
}

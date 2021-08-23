import { readFileSync } from 'fs';
import { resolve } from 'path';

// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { BaseSolution } from '../index';

export class Solution implements BaseSolution {
	lines = '';

	constructor() {
		if (process.env.NODE_ENV !== 'test') {
			this.lines = readFileSync(resolve(__dirname, 'input.txt'), 'utf-8');
		}
	}

	first = (): number => {
		return this.move(this.lines);
	};

	second = (): number => {
		return this.basement(this.lines);
	};

	move = (instructions: string): number => {
		return instructions
			.split('')
			.map((step) => (step === '(' ? 1 : -1))
			.reduce((acc, val) => (acc += val), 0);
	};

	basement = (instructions: string): number => {
		let position = 0;
		const steps = instructions.split('');

		for (let i = 0; i < steps.length; ++i) {
			position += steps[i] === '(' ? 1 : -1;

			if (position < 0) {
				return i + 1;
			}
		}

		return -1;
	};
}

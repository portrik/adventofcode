import { join } from 'path';
import { readFileSync } from 'fs';

// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { BaseSolution } from '../index';

export class Solution implements BaseSolution {
	lines = '';

	constructor() {
		if (process.env.NODE_ENV !== 'test') {
			this.lines = readFileSync(join(__dirname, 'input.txt'), 'utf-8');
		}
	}

	first = (): number => {
		return this.movement(this.lines);
	};

	second = (): number => {
		return this.robotMovement(this.lines);
	};

	movement = (instructions: string): number => {
		const houses = new Map<string, number>();
		houses.set('0-0', 1);

		let x = 0;
		let y = 0;

		for (const step of instructions.split('')) {
			switch (step) {
			case '>':
				++x;
				break;
			case '<':
				--x;
				break;
			case '^':
				++y;
				break;
			case 'v':
				--y;
				break;
			}

			houses.set(`${x}-${y}`, 1);
		}

		return houses.size;
	};

	robotMovement = (instructions: string): number => {
		const houses = new Map<string, number>();
		houses.set('0-0', 2);

		let x = 0;
		let y = 0;
		let robotX = 0;
		let robotY = 0;
		let robot = false;

		for (const step of instructions.split('')) {
			switch (step) {
			case '>':
				robot ? ++robotX : ++x;
				break;
			case '<':
				robot ? --robotX : --x;
				break;
			case '^':
				robot ? ++robotY : ++y;
				break;
			case 'v':
				robot ? --robotY : --y;
				break;
			}

			houses.set(`${x}-${y}`, 1);
			houses.set(`${robotX}-${robotY}`, 1);

			robot = !robot;
		}

		return houses.size;
	};
}

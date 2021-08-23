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
				.filter((line) => line.trim().length > 0);
		}
	}

	first = (): number => {
		const lights: boolean[][] = Array.from({ length: 1000 }, () =>
			Array.from({ length: 1000 }, () => false)
		);

		for (const instruction of this.lines) {
			this.controlLights(this.parseInstruction(instruction), lights);
		}

		return lights
			.flat()
			.map((val) => (val ? 1 : 0) as number)
			.reduce((acc, val) => (acc += val), 0);
	};

	second = (): number => {
		const lightsBrightness: number[][] = Array.from({ length: 1000 }, () =>
			Array.from({ length: 1000 }, () => 0)
		);

		for (const instruction of this.lines) {
			this.controlLightsBrightness(
				this.parseInstruction(instruction),
				lightsBrightness
			);
		}

		return lightsBrightness.flat().reduce((acc, val) => (acc += val), 0);
	};

	controlLights = (instruction: Instruction, lights: boolean[][]): void => {
		for (let i = instruction.start.y; i <= instruction.end.y; ++i) {
			for (let j = instruction.start.x; j <= instruction.end.x; ++j) {
				lights[i][j] =
					instruction.command === 'toggle'
						? !lights[i][j]
						: instruction.command;
			}
		}
	};

	controlLightsBrightness = (
		instruction: Instruction,
		lights: number[][]
	): void => {
		for (let i = instruction.start.y; i <= instruction.end.y; ++i) {
			for (let j = instruction.start.x; j <= instruction.end.x; ++j) {
				let value = lights[i][j];

				if (instruction.command === 'toggle') {
					value += 2;
				} else if (instruction.command) {
					value += 1;
				} else {
					value = value < 1 ? 0 : value - 1;
				}

				lights[i][j] = value;
			}
		}
	};

	parseInstruction = (instruction: string): Instruction => {
		const result: Instruction = {
			start: {
				x: 0,
				y: 0,
			},
			end: {
				x: 999,
				y: 999,
			},
			command: 'toggle',
		};

		const split = instruction.split(' ');

		if (split[0] === 'toggle') {
			result.command = 'toggle';
			split.splice(0, 1);
		} else {
			result.command = split[1] === 'on';
			split.splice(0, 2);
		}

		const tmp1 = split[0].split(',');
		result.start = {
			x: Number(tmp1[0]),
			y: Number(tmp1[1]),
		};

		const tmp2 = split[2].split(',');
		result.end = {
			x: Number(tmp2[0]),
			y: Number(tmp2[1]),
		};

		return result;
	};
}

interface Instruction {
	start: {
		x: number;
		y: number;
	};
	end: {
		x: number;
		y: number;
	};
	command: boolean | 'toggle';
}

import { readFileSync } from 'fs';
import { resolve } from 'path';

export function move(instructions: string): number {
	return instructions
		.split('')
		.map((step) => (step === '(' ? 1 : -1))
		.reduce((acc, val) => (acc += val), 0);
}

export function basement(instructions: string): number {
	let position = 0;
	const steps = instructions.split('');

	for (let i = 0; i < steps.length; ++i) {
		position += steps[i] === '(' ? 1 : -1;

		if (position < 0) {
			return i + 1;
		}
	}

	return -1;
}

export function results01(): void {
	const instructions = readFileSync(resolve(__dirname, 'input.txt'), 'utf-8');

	console.log(`01: First result is:\t ${move(instructions)}`);
	console.log(`01: Second result is:\t ${basement(instructions)}\n`);
}

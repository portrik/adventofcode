import { readFileSync } from 'fs';
import { join } from 'path';

export function paper(length: number, width: number, height: number): number {
	const lw = length * width;
	const wh = width * height;
	const hl = height * length;
	const extra = Math.min(lw, wh, hl);

	return 2 * lw + 2 * wh + 2 * hl + extra;
}

export function bow(length: number, width: number, height: number): number {
	const values = [length, width, height].sort((a, b) => b - a);
	values.splice(0, 1);
	const base = values.reduce((acc, val) => (acc += 2 * val), 0);
	const extra = length * width * height;

	return base + extra;
}

export function results02(): void {
	const values = readFileSync(join(__dirname, 'input.txt'), 'utf-8');

	let result1 = 0;
	let result2 = 0;

	for (const line of values.split('\n')) {
		const tmp = line.split('x');

		if (tmp.length === 3) {
			result1 += paper(Number(tmp[0]), Number(tmp[1]), Number(tmp[2]));
			result2 += bow(Number(tmp[0]), Number(tmp[1]), Number(tmp[2]));
		}
	}

	console.log(`02: First result is:\t ${result1}`);
	console.log(`02: Second result is:\t ${result2}\n`);
}

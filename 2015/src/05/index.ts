import { readFileSync } from 'fs';
import { join } from 'path';

export function isNice(tested: string): boolean {
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
}

export function isNice2(tested: string): boolean {
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
}

export function results05(): void {
	const strings = readFileSync(join(__dirname, 'input.txt'), 'utf-8');

	console.log(
		`05: First result is:\t ${
			strings.split('\n').filter((str) => isNice(str)).length
		}`
	);
	console.log(
		`05: Second result is:\t ${
			strings.split('\n').filter((str) => isNice2(str)).length
		}`
	);
}

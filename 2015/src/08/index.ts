import { readFileSync } from 'fs';
import { join } from 'path';

import { Results } from '../index';

export class Result08 implements Results {
	lines: string[] = [];

	constructor() {
		if (process.env.NODE_ENV !== 'test') {
			this.lines = readFileSync(join(__dirname, 'input.txt'), 'utf-8')
				.split('\n')
				.filter((line) => line.trim().length > 1);
		}
	}

	first = (): number => {
		const totalLength = this.lines
			.map((line) => line.length)
			.reduce((acc, cur) => (acc += cur), 0);
		const dataLength = this.lines
			.map((line) => this.countCharacters(line))
			.reduce((acc, cur) => (acc += cur), 0);

		return totalLength - dataLength;
	};

	second = (): number => {
		const startingLength = this.lines
			.map((line) => line.length)
			.reduce((acc, cur) => (acc += cur), 0);
		const encodedLength = this.lines
			.map((line) => this.encodeCharacters(line))
			.reduce((acc, cur) => (acc += cur), 0);

		return encodedLength - startingLength;
	};

	/**
	 * Counts the length of data in a line
	 *
	 * @param inputLine	Line to count data characters in
	 *
	 * @returns 		Length of data in the input line
	 */
	countCharacters = (inputLine: string): number => {
		return String.raw`${inputLine}`
			.slice(1, inputLine.length - 1) // Removes quotes on each side
			.replace(/\\x[\dA-F]{2}/gi, (match) =>
				String.fromCharCode(
					parseInt(match.slice(match.length - 2, match.length), 16)
				)
			) // Replaces ASCII characters (\x00) with their corresponding character
			.replace(/\\"/g, '1') // Replaces escaped quote with a 1
			.replace(/\\{2}/g, '1').length; // Replaces double slash with a 1
	};

	/**
	 * Counts the length of encoded data line
	 *
	 * @param inputLine Line to encode data and count characters in
	 *
	 * @returns 		Encodes line of data and counts total characters
	 */
	encodeCharacters = (inputLine: string): number => {
		// Using string literal to get the raw string data
		// Otherwise ASCII is decoded and \\ omitted to one
		return JSON.stringify(String.raw`${inputLine}`).length;
	};
}

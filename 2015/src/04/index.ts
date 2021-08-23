import md5 from 'md5';

// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { BaseSolution } from '../index';
export class Solution implements BaseSolution {
	line = 'bgvyzdsv';

	first = (): number => {
		return this.fiveZeroes(this.line);
	};

	second = (): number => {
		return this.sixZeroes(this.line);
	};

	fiveZeroes = (secret: string): number => {
		let i = 0;
		let hash = md5(`${secret}${i}`);

		while (hash.substring(0, 5) !== '00000') {
			++i;
			hash = md5(`${secret}${i}`);
		}

		return i;
	};

	sixZeroes = (secret: string): number => {
		let i = 0;
		let hash = md5(`${secret}${i}`);

		while (hash.substring(0, 6) !== '000000') {
			++i;
			hash = md5(`${secret}${i}`);
		}

		return i;
	};
}

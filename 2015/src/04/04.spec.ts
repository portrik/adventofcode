import { fiveZeroes, sixZeroes } from './index';

describe('05', () => {
	test.each([
		['abcdef', 609043],
		['pqrstuv', 1048970],
	])('%s Should Reach Five Zeroes with %i', (secret, result) => {
		expect(fiveZeroes(secret)).toBe(result);
	});

	test('bgvyzdsv Should Reach Six Zeroes with 1038736', () => {
		expect(sixZeroes('bgvyzdsv')).toBe(1038736);
	});
});

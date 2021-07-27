import { bow, paper } from './index';

describe('02', () => {
	test.each([
		[2, 3, 4, 58],
		[1, 1, 10, 43],
	])(
		'%ix%ix%i Should Calculate Paper to %i',
		(length, width, height, result) => {
			expect(paper(length, width, height)).toBe(result);
		}
	);

	test.each([
		[2, 3, 4, 34],
		[1, 1, 10, 14],
	])('%ix%ix%i Should Calculate Bow to %i', (length, width, height, result) => {
		expect(bow(length, width, height)).toBe(result);
	});
});

import { Solution } from './index';

describe('01', () => {
	test.each([
		['()()', 0],
		['(()(()(', 3],
		[')())())', -3],
	])('%s Should Move to Floor #%i', (instructions, floor) => {
		expect(new Solution().move(instructions)).toBe(floor);
	});

	test.each([
		[')', 1],
		['()())', 5],
	])('%s Should Reach Basement at Step #%i', (instructions, step) => {
		expect(new Solution().basement(instructions)).toBe(step);
	});
});

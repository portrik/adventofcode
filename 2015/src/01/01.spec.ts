import { move, basement } from './index';

describe('01', () => {
	test.each([
		['()()', 0],
		['(()(()(', 3],
		[')())())', -3],
	])('%s Should Move to Floor #%i', (instructions, floor) => {
		expect(move(instructions)).toBe(floor);
	});

	test.each([
		[')', 1],
		['()())', 5],
	])('%s Should Reach Basement at Step #%i', (instructions, step) => {
		expect(basement(instructions)).toBe(step);
	});
});

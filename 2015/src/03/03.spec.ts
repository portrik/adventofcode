import { movement, robotMovement } from './index';

describe('03', () => {
	test.each([
		['>', 2],
		['^>v<', 4],
		['^v^v^v^v^v', 2],
	])('%s Should Deliver to %i Houses', (instructions, result) => {
		expect(movement(instructions)).toBe(result);
	});

	test.each([
		['^v', 3],
		['^>v<', 3],
		['^v^v^v^v^v', 11],
	])('%s Should Deliver to %i Houses', (instructions, result) => {
		expect(robotMovement(instructions)).toBe(result);
	});
});

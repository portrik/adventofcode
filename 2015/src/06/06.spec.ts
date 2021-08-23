import { Solution } from './index';

describe('06', () => {
	test.each([
		{
			instruction: 'turn on 0,0 through 999,999',
			expected: {
				start: { x: 0, y: 0 },
				end: { x: 999, y: 999 },
				command: true,
			},
		},
		{
			instruction: 'toggle 0,0 through 999,0',
			expected: {
				start: { x: 0, y: 0 },
				end: { x: 999, y: 0 },
				command: 'toggle',
			},
		},
		{
			instruction: 'turn off 499,499 through 500,500',
			expected: {
				start: { x: 499, y: 499 },
				end: { x: 500, y: 500 },
				command: false,
			},
		},
	])('$instruction Should Be Parsed Properly', ({ instruction, expected }) => {
		expect(new Solution().parseInstruction(instruction)).toEqual(expected);
	});

	test.each([
		{ instruction: 'turn on 499,499 through 500,500', expected: 4 },
		{ instruction: 'turn on 0,0 through 999,999', expected: 1000000 },
		{ instruction: 'toggle 0,0 through 999,0', expected: 1000 },
	])(
		'$instruction Should Leave $expected Lights On',
		({ instruction, expected }) => {
			const lights: boolean[][] = Array.from({ length: 1000 }, () =>
				Array.from({ length: 1000 }, () => false)
			);

			const solution = new Solution();

			solution.controlLights(solution.parseInstruction(instruction), lights);
			const result = lights
				.flat()
				.map((val) => (val ? 1 : 0) as number)
				.reduce((acc, val) => (acc += val), 0);

			expect(result).toBe(expected);
		}
	);

	test.each([
		{ instruction: 'turn on 0,0 through 0,0', expected: 1 },
		{ instruction: 'toggle 0,0 through 999,999', expected: 2000000 },
	])(
		'$instruction Should Leave $expected Brightness',
		({ instruction, expected }) => {
			const lights: number[][] = Array.from({ length: 1000 }, () =>
				Array.from({ length: 1000 }, () => 0)
			);

			const solution = new Solution();

			solution.controlLightsBrightness(
				solution.parseInstruction(instruction),
				lights
			);
			const result = lights.flat().reduce((acc, val) => (acc += val), 0);

			expect(result).toBe(expected);
		}
	);
});

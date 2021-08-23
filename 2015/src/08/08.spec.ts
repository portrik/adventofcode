import { Solution } from './index';

describe('08', () => {
	test.each([
		{
			tested: '""',
			expected: 0,
		},
		{
			tested: '"abc"',
			expected: 3,
		},
		{
			tested: '"aaa"aaa"',
			expected: 7,
		},
		{
			tested: '"\x27"',
			expected: 1,
		},
		{
			tested: '"eambmxt\\dxagoogl\\zapfwwlmk"',
			expected: 26,
		},
	])('$tested Should Have Data Length of $expected', ({ tested, expected }) => {
		expect(new Solution().countCharacters(tested)).toEqual(expected);
	});

	test.each([
		{
			tested: '""',
			expected: 6,
		},
		{
			tested: '"abc"',
			expected: 9,
		},
		{
			tested: '"aaa"aaaa"',
			expected: 15,
		},
	])('$tested Should Have Encoded Length $expected', ({ tested, expected }) => {
		expect(new Solution().encodeCharacters(tested)).toEqual(expected);
	});
});

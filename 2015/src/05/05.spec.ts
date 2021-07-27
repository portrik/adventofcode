import { isNice, isNice2 } from './index';

describe('05', () => {
	test.each([
		['ugknbfddgicrmopn', true],
		['aaa', true],
		['jchzalrnumimnmhp', false],
		['haegwjzuvuyypxyu', false],
		['dvszwmarrgswjxmb', false],
	])('%s Should Be Nice: %s', (tested, result) => {
		expect(isNice(tested)).toBe(result);
	});

	test.each([
		['qjhvhtzxzqqjkmpb', true],
		['xxyxx', true],
		['uurcxstgmygtbstg', false],
		['ieodomkazucvgmuy', false],
		['aabcdefgaa', false],
		['aaa', false],
		['abcdefeghi', false],
	])('%s Should Be Nice: %s', (tested, result) => {
		expect(isNice2(tested)).toBe(result);
	});
});

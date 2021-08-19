import { parseInstruction, Connection, Gate } from './index';

describe('07', () => {
	test.each([
		{
			line: '123 -> x',
			connection: new Connection('x', Gate.CONSTANT, [], 123),
		},
		{
			line: 'x AND y -> d',
			connection: new Connection('d', 'AND' as Gate, ['x', 'y']),
		},
		{
			line: 'x OR y -> e',
			connection: new Connection('e', Gate.OR, ['x', 'y']),
		},
		{
			line: 'x LSHIFT 2 -> f',
			connection: new Connection('f', Gate.LSHIFT, ['x', '2']),
		},
		{
			line: 'y RSHIFT 2 -> g',
			connection: new Connection('g', 'RSHIFT' as Gate, ['y', '2']),
		},
		{
			line: 'NOT x -> h',
			connection: new Connection('h', Gate.NOT, ['x']),
		},
	])('$line Should Create a Connection', ({ line, connection }) => {
		expect(parseInstruction(line)).toEqual(connection);
	});

	test('Connections Should Be Evaluated Correctly', () => {
		const connections = [
			new Connection('x', Gate.CONSTANT, ['123']),
			new Connection('y', Gate.CONSTANT, ['456']),
			new Connection('d', 'AND' as Gate, ['x', 'y']),
			new Connection('e', 'OR' as Gate, ['x', 'y']),
			new Connection('f', Gate.LSHIFT, ['x', '2']),
			new Connection('g', 'RSHIFT' as Gate, ['y', '2']),
			new Connection('h', Gate.NOT, ['x']),
			new Connection('i', Gate.NOT, ['y']),
		];

		const result: { [key: string]: number } = {};

		for (const connection of connections) {
			result[connection.name] = connection.evaluate(connections);
		}

		expect(result).toEqual({
			d: 72,
			e: 507,
			f: 492,
			g: 114,
			h: 65412,
			i: 65079,
			x: 123,
			y: 456,
		});
	});
});

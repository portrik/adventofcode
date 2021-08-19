import { readFileSync } from 'fs';
import { join } from 'path';

export enum Gate {
	AND = 'AND',
	OR = 'OR',
	NOT = 'NOT',
	RSHIFT = 'RSHIFT',
	LSHIFT = 'LSHIFT',
	CONSTANT = 'CONSTANT',
}

export class Connection {
	name: string;
	gate: Gate;
	sources: string[];

	value?: number;

	constructor(name: string, gate: Gate, sources: string[]) {
		this.name = name;
		this.gate = gate;
		this.sources = sources;
	}

	evaluate(connections: Connection[]): number {
		if (this.value !== undefined) {
			return this.value;
		}

		let left: number;

		if (isNaN(Number(this.sources[0]))) {
			left = (
				connections.find((con) => con.name === this.sources[0]) as Connection
			).evaluate(connections);
		} else {
			left = Number(this.sources[0]);
		}

		if (this.gate === Gate.NOT) {
			this.value = 65535 - left;

			return this.value;
		} else if (this.gate === Gate.CONSTANT) {
			this.value = left;

			return this.value;
		} else {
			let right;

			if (isNaN(Number(this.sources[1]))) {
				right = (
					connections.find((con) => con.name === this.sources[1]) as Connection
				).evaluate(connections);
			} else {
				right = Number(this.sources[1]);
			}

			switch (this.gate) {
			case Gate.AND:
				this.value = left & right;
				break;
			case Gate.OR:
				this.value = left | right;
				break;
			case Gate.RSHIFT:
				this.value = left >> right;
				break;
			case Gate.LSHIFT:
				this.value = left << right;
				break;
			}

			return this.value as number;
		}
	}
}

export function parseInstruction(instruction: string): Connection {
	const split = instruction.split(' ');

	if (split[1] === '->') {
		return new Connection(split[2], Gate.CONSTANT, [split[0]]);
	} else if (split[0] === 'NOT') {
		return new Connection(split[3], Gate.NOT, [split[1]]);
	} else {
		return new Connection(split[4], split[1] as Gate, [split[0], split[2]]);
	}
}

export function results07(): void {
	const instructions = readFileSync(join(__dirname, 'input.txt'), 'utf-8')
		.split('\n')
		.filter((line) => line.trim().length > 1)
		.map((line) => parseInstruction(line));

	const result: { [key: string]: number } = {};

	for (const connection of instructions) {
		result[connection.name] = connection.evaluate(instructions);
	}

	console.log(`07: First result is:\t ${result['a']}`);

	instructions.forEach((con) => (con.value = undefined));
	const wireB = instructions.find((con) => con.name === 'b') as Connection;
	wireB.gate = Gate.CONSTANT;
	wireB.value = 3176;

	for (const connection of instructions) {
		result[connection.name] = connection.evaluate(instructions);
	}

	console.log(`07: Second result is:\t ${result['a']}`);
}

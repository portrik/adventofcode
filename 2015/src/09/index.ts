import { readFileSync } from 'fs';
import { join } from 'path';

// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { BaseSolution } from '../index';

export class Solution implements BaseSolution {
	lines: string[] = [];

	constructor() {
		if (process.env.NODE_ENV !== 'test') {
			this.lines = readFileSync(join(__dirname, 'input.txt'), 'utf-8')
				.split('\n')
				.filter((line) => line.length > 0);
		}
	}

	first = (): number => {
		return 0;
	};

	second = (): number => {
		return 0;
	};

	findShortest = (cities: City[]): number => {
		const permutations: { distance: number; cities: City[] }[] = [];

		return permutations
			.map((permutation) => permutation.distance)
			.sort((a, b) => a - b)[0];
	};

	mapDistances = (lines: string[]): City[] => {
		const cities: City[] = [];

		for (const line of lines) {
			const split = line.split(' ');

			let leftCity = cities.find((city) => city.name === split[0]);
			let rightCity = cities.find((city) => city.name === split[2]);

			if (!leftCity) {
				leftCity = new City(split[0]);
				cities.push(leftCity);
			}

			if (!rightCity) {
				rightCity = new City(split[2]);
				cities.push(rightCity);
			}

			leftCity.distances.push({
				name: rightCity.name,
				distance: Number(split[4]),
			});

			rightCity.distances.push({
				name: leftCity.name,
				distance: Number(split[4]),
			});
		}

		return cities;
	};
}

class City {
	name: string;

	distances: { name: string; distance: number }[];

	constructor(name: string) {
		this.name = name;
		this.distances = [];
	}
}

import { Solution as Solution01 } from './01';
import { Solution as Solution02 } from './02';
import { Solution as Solution03 } from './03';
import { Solution as Solution04 } from './04';
import { Solution as Solution05 } from './05';
import { Solution as Solution06 } from './06';
import { Solution as Solution07 } from './07';
import { Solution as Solution08 } from './08';

export interface BaseSolution {
	first: () => number;
	second: () => number;
}

const part = process.argv[2];
let solution: BaseSolution;

switch (part) {
case '01':
	solution = new Solution01();
	break;
case '02':
	solution = new Solution02();
	break;
case '03':
	solution = new Solution03();
	break;
case '04':
	solution = new Solution04();
	break;
case '05':
	solution = new Solution05();
	break;
case '06':
	solution = new Solution06();
	break;
case '07':
	solution = new Solution07();
	break;
case '08':
	solution = new Solution08();
	break;
default:
	throw new Error(`"${part}" is not a recognized problem!`);
}

console.log(`${part}: First result is:\t${solution.first()}`);
console.log(`${part}: Second result is:\t${solution.second()}`);

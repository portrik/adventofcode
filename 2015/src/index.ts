import { results01 } from './01';
import { results02 } from './02';
import { results03 } from './03';
import { results04 } from './04';
import { results05 } from './05';
import { results06 } from './06';
import { results07 } from './07';
import { Result08 } from './08';

export interface Results {
	first: () => number;
	second: () => number;
}

const part = process.argv[2];

switch (part) {
case '01':
	results01();
	break;
case '02':
	results02();
	break;
case '03':
	results03();
	break;
case '04':
	results04();
	break;
case '05':
	results05();
	break;
case '06':
	results06();
	break;
case '07':
	results07();
	break;
case '08':
	{
		const result = new Result08();

		console.log(`08: First result is:\t ${result.first()}`);
		console.log(`08: Second result is:\t ${result.second()}`);
	}
	break;
default:
	throw new Error(`"${part}" is not a recognized problem!`);
}

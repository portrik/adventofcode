import md5 from 'md5';

export function fiveZeroes(secret: string): number {
	let i = 0;
	let hash = md5(`${secret}${i}`);

	while (hash.substring(0, 5) !== '00000') {
		++i;
		hash = md5(`${secret}${i}`);
	}

	return i;
}

export function sixZeroes(secret: string): number {
	let i = 0;
	let hash = md5(`${secret}${i}`);

	while (hash.substring(0, 6) !== '000000') {
		++i;
		hash = md5(`${secret}${i}`);
	}

	return i;
}

export function results04(): void {
	console.log(`04: First result is:\t ${fiveZeroes('bgvyzdsv')}`);
	console.log(`04: Second result is:\t ${sixZeroes('bgvyzdsv')}\n`);
}

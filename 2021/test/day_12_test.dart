import 'package:test/test.dart';

import 'package:aoc2021/day_12.dart';

void main() {
  group('12', () {
    test('First Solver', () {
      final day = Day12();

      expect(
          day.paths([
            'start-A',
            'start-b',
            'A-c',
            'A-b',
            'b-d',
            'A-end',
            'b-end'
          ]).length,
          10);

      expect(
          day.paths([
            'dc-end',
            'HN-start',
            'start-kj',
            'dc-start',
            'dc-HN',
            'LN-dc',
            'HN-end',
            'kj-sa',
            'kj-HN',
            'kj-dc'
          ]).length,
          19);

      expect(
          day.paths([
            'fs-end',
            'he-DX',
            'fs-he',
            'start-DX',
            'pj-DX',
            'end-zg',
            'zg-sl',
            'zg-pj',
            'pj-he',
            'RW-he',
            'fs-DX',
            'pj-RW',
            'zg-RW',
            'start-pj',
            'he-WI',
            'zg-he',
            'pj-fs',
            'start-RW',
          ]).length,
          226);
    });

    test('Second Solver', () {
      final day = Day12();

      expect(
          day.doublePath([
            'start-A',
            'start-b',
            'A-c',
            'A-b',
            'b-d',
            'A-end',
            'b-end'
          ]).length,
          36);

      expect(
          day.doublePath([
            'dc-end',
            'HN-start',
            'start-kj',
            'dc-start',
            'dc-HN',
            'LN-dc',
            'HN-end',
            'kj-sa',
            'kj-HN',
            'kj-dc'
          ]).length,
          103);

      expect(
          day.doublePath([
            'fs-end',
            'he-DX',
            'fs-he',
            'start-DX',
            'pj-DX',
            'end-zg',
            'zg-sl',
            'zg-pj',
            'pj-he',
            'RW-he',
            'fs-DX',
            'pj-RW',
            'zg-RW',
            'start-pj',
            'he-WI',
            'zg-he',
            'pj-fs',
            'start-RW',
          ]).length,
          3509);
    });
  });
}

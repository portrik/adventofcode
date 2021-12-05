import 'package:test/test.dart';

import 'package:aoc2021/02/day_02.dart';

void main() {
  group('02', () {
    test('First Solver', () {
      final day = Day02();

      var result = day.moveSubmarine([
        'forward 5',
        'down 5',
        'forward 8',
        'up 3',
        'down 8',
        'forward 2',
      ]);

      expect(result, 150);
    });

    test('Secod Solver', () {
      final day = Day02();

      var result = day.aimSubmarine([
        'forward 5',
        'down 5',
        'forward 8',
        'up 3',
        'down 8',
        'forward 2',
      ]);

      expect(result, 900);
    });
  });
}

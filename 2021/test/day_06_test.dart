import 'package:test/test.dart';

import 'package:aoc2021/day_06.dart';

void main() {
  group('06', () {
    test('First Solver', () {
      final day = Day06();

      var result = day.simulateFish([3, 4, 3, 1, 2], 80);

      expect(result, 5934);
    });

    test('Second Solver', () {
      final day = Day06();

      var result = day.simulateFish([3, 4, 3, 1, 2], 256);

      expect(result, 26984457539);
    });
  });
}

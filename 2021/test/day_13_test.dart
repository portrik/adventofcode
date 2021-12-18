import 'package:test/test.dart';

import 'package:aoc2021/day_13.dart';

void main() {
  group('13', () {
    test('First Solver', () {
      final day = Day13();

      var result = day.firstFold([
        '6,10',
        '0,14',
        '9,10',
        '0,3',
        '10,4',
        '4,11',
        '6,0',
        '6,12',
        '4,1',
        '0,13',
        '10,12',
        '3,4',
        '3,0',
        '8,4',
        '1,10',
        '2,14',
        '8,10',
        '9,0',
        'fold along y=7',
      ]);

      expect(
          result
              .expand((element) => element)
              .where((element) => element)
              .length,
          17);

      result = day.fold(result, 5, true);

      expect(
          result
              .expand((element) => element)
              .where((element) => element)
              .length,
          16);
    });
  });
}

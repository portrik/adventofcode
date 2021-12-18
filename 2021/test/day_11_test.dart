import 'package:test/test.dart';

import 'package:aoc2021/day_11.dart';

void main() {
  group('11', () {
    test('First Solver', () {
      final day = Day11();

      var input = [
        '5483143223',
        '2745854711',
        '5264556173',
        '6141336146',
        '6357385478',
        '4167524645',
        '2176841721',
        '6882881134',
        '4846848554',
        '5283751526'
      ].map((e) => e.split('').map(int.parse).toList()).toList();

      var result = day.flash(input, 100);
      expect(result, 1656);
    });

    test('Second Solver', () {
      final day = Day11();

      var input = [
        '5483143223',
        '2745854711',
        '5264556173',
        '6141336146',
        '6357385478',
        '4167524645',
        '2176841721',
        '6882881134',
        '4846848554',
        '5283751526'
      ].map((e) => e.split('').map(int.parse).toList()).toList();

      var result = day.simultaneousFlash(input);
      expect(result, 195);
    });
  });
}

import 'package:test/test.dart';

import '../../bin/03/day_03.dart';

void main() {
  group('03', () {
    test('First Solver', () {
      final day = Day03();

      var result = day.calculatePowerConsumption([
        '00100',
        '11110',
        '10110',
        '10111',
        '10101',
        '01111',
        '00111',
        '11100',
        '10000',
        '11001',
        '00010',
        '01010',
      ]);

      expect(result, 198);
    });

    test('Second Solver', () {
      final day = Day03();

      var oxygen = day.rating([
        '00100',
        '11110',
        '10110',
        '10111',
        '10101',
        '01111',
        '00111',
        '11100',
        '10000',
        '11001',
        '00010',
        '01010',
      ], 'up');
      expect(oxygen, 23);

      var co2 = day.rating([
        '00100',
        '11110',
        '10110',
        '10111',
        '10101',
        '01111',
        '00111',
        '11100',
        '10000',
        '11001',
        '00010',
        '01010',
      ], 'down');

      expect(co2, 10);

      expect(oxygen * co2, 230);
    });
  });
}

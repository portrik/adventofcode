import 'package:test/test.dart';

import 'package:aoc2021/14/day_14.dart';

void main() {
  group('14', () {
    test('First Solver', () {
      final day = Day14();

      var split = [
        'CH -> B',
        'HH -> N',
        'CB -> H',
        'NH -> C',
        'HB -> C',
        'HC -> B',
        'HN -> C',
        'NN -> C',
        'BH -> H',
        'NC -> B',
        'NB -> B',
        'BN -> B',
        'BB -> N',
        'BC -> B',
        'CC -> N',
        'CN -> C'
      ];
      Map<String, String> rules = {};

      for (var i = 0; i < split.length; ++i) {
        var tmp = split[i].split(' ');
        rules[tmp[0]] = tmp[2];
      }

      var result = day.constructPolymer('NNCB', rules);
      expect(result, 'NCNBCHB');

      result = day.constructPolymer(result, rules);
      expect(result, 'NBCCNBBBCBHCB');

      result = day.constructPolymer(result, rules);
      expect(result, 'NBBBCNCCNBBNBNBBCHBHHBCHB');

      for (var i = 3; i < 10; ++i) {
        result = day.constructPolymer(result, rules);
      }

      expect(result.length, 3073);

      var occurences = day.occurrences(result);
      expect(occurences['B'], 1749);
      expect(occurences['H'], 161);
    });
  });
}

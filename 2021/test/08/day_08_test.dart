import 'package:test/test.dart';

import 'package:aoc2021/08/day_08.dart';

void main() {
  group('08', () {
    test('First Solver', () {
      final day = Day08();

      var result = day.decode([
        'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
        'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
        'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
        'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
        'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
        'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
        'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
        'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
        'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
        'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce'
      ]);

      expect(result, 26);
    });

    test('Second Solver', () {
      final day = Day08();

      var result = day.parse([
        'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
        'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
        'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
        'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
        'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
        'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
        'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
        'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
        'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
        'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce'
      ]);

      expect(result, 61229);
    });

    test('Keys', () {
      final day = Day08();

      var result = day.buildKey(
          'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab'
              .split(' ')
              .toList());

      var source = {
        0: 'cagedb'.split('').toList(),
        1: 'ab'.split('').toList(),
        2: 'gcdfa'.split('').toList(),
        3: 'fbcad'.split('').toList(),
        4: 'eafb'.split('').toList(),
        5: 'cdfbe'.split('').toList(),
        6: 'cdfgeb'.split('').toList(),
        7: 'dab'.split('').toList(),
        8: 'acedgfb'.split('').toList(),
        9: 'cefabd'.split('').toList(),
      };

      Map<int, String> expected = {};
      for (var i = 0; i < source.keys.length; ++i) {
        source[i]!.sort();
        expected[i] = source[i]!.join('');
      }

      expect(result, expected);
    });
  });
}

import 'package:aoc2021/solution.dart';

class Day14 implements Solution {
  @override
  Future<String> first(String input) async {
    var split =
        input.split('\n').where((element) => element.isNotEmpty).toList();
    var result = split[0];
    Map<String, String> rules = {};

    for (var i = 1; i < split.length; ++i) {
      var tmp = split[i].split(' ');
      rules[tmp[0]] = tmp[2];
    }

    for (var i = 0; i < 10; ++i) {
      result = constructPolymer(result, rules);
    }

    var occ = occurrences(result);
    var values = occ.values.toList();
    values.sort();

    return (values.last - values.first).toString();
  }

  String constructPolymer(String input, Map<String, String> rules) {
    var result = input;
    Map<int, String> changes = {};

    for (final rule in rules.keys) {
      var index = result.indexOf(rule);

      while (index > -1) {
        changes[index] = rules[rule] as String;
        index = result.indexOf(rule, index + 1);
      }
    }

    var keys = changes.keys.toList();
    keys.sort((b, a) => a.compareTo(b));

    for (final index in keys) {
      result =
          '${result.substring(0, index + 1)}${changes[index]}${result.substring(index + 1)}';
    }

    return result;
  }

  Map<String, int> occurrences(String input) {
    Map<String, int> result = {};
    var letters = input.split('').toSet();

    for (final letter in letters) {
      result[letter] = letter.allMatches(input).length;
    }

    return result;
  }

  @override
  Future<String> second(String input) async {
    var split =
        input.split('\n').where((element) => element.isNotEmpty).toList();
    var result = split[0];
    Map<String, String> rules = {};

    for (var i = 1; i < split.length; ++i) {
      var tmp = split[i].split(' ');
      rules[tmp[0]] = tmp[2];
    }

    for (var i = 0; i < 40; ++i) {
      result = constructPolymer(result, rules);
    }

    var occ = occurrences(result);
    var values = occ.values.toList();
    values.sort();

    return (values.last - values.first).toString();
  }
}

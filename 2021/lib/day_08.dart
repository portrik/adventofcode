import 'package:aoc2021/solution.dart';

class Day08 implements Solution {
  @override
  Future<String> first(String input) async {
    return decode(
            input.split('\n').where((element) => element.isNotEmpty).toList())
        .toString();
  }

  int decode(List<String> input) {
    Map<int, int> result = {};
    for (var i = 0; i < 10; ++i) {
      result[i] = 0;
    }

    var outputs = input
        .map((e) => e.split('|')[1])
        .where((element) => element.isNotEmpty)
        .map((e) => e.split(' '))
        .where((element) => element.isNotEmpty)
        .expand((element) => element)
        .where((element) => element.isNotEmpty)
        .toList();

    result[1] = outputs.where((element) => element.length == 2).toList().length;
    result[4] = outputs.where((element) => element.length == 4).toList().length;
    result[7] = outputs.where((element) => element.length == 3).toList().length;
    result[8] = outputs.where((element) => element.length == 7).toList().length;

    return result.values.reduce((value, element) => value + element);
  }

  @override
  Future<String> second(String input) async {
    return parse(
            input.split('\n').where((element) => element.isNotEmpty).toList())
        .toString();
  }

  int parse(List<String> input) {
    var result = 0;

    for (final line in input) {
      var keys = buildKey(line
          .split('|')[0]
          .split(' ')
          .where((element) => element.isNotEmpty)
          .toList());

      var code = line
          .split('|')[1]
          .split(' ')
          .where((element) => element.isNotEmpty)
          .toList();

      var number = '';
      for (final digit in code) {
        var tmp = digit.split('').toList();
        tmp.sort();
        var comp = tmp.join('');

        var index = keys.values.toList().indexOf(comp);
        number += keys.keys.toList()[index].toString();
      }

      result += int.parse(number);
    }

    return result;
  }

  Map<int, String> buildKey(List<String> keys) {
    Map<int, List<String>> key = {};
    key[1] = keys.where((element) => element.length == 2).toList()[0].split('');
    key[4] = keys.where((element) => element.length == 4).toList()[0].split('');
    key[7] = keys.where((element) => element.length == 3).toList()[0].split('');
    key[8] = keys.where((element) => element.length == 7).toList()[0].split('');

    key[6] = keys
        .where((element) =>
            element.length == 6 &&
            key[1]!.where((e) => element.contains(e)).toList().length == 1)
        .toList()[0]
        .split('');
    key[0] = keys
        .where((element) =>
            element.length == 6 &&
            key[4]!.where((e) => element.contains(e)).toList().length == 3 &&
            key[6]!.where((e) => element.contains(e)).length == 5)
        .toList()[0]
        .split('');
    key[9] = keys
        .where((element) =>
            element.length == 6 &&
            key[0]!.where((e) => element.contains(e)).toList().length == 5 &&
            key[6]!.where((e) => element.contains(e)).toList().length == 5)
        .toList()[0]
        .split('');

    key[2] = keys
        .where((element) =>
            element.length == 5 &&
            key[1]!.where((e) => element.contains(e)).toList().length == 1 &&
            key[9]!.where((e) => element.contains(e)).toList().length == 4)
        .toList()[0]
        .split('');
    key[3] = keys
        .where((element) =>
            element.length == 5 &&
            key[1]!.where((e) => element.contains(e)).toList().length == 2 &&
            key[9]!.where((e) => element.contains(e)).toList().length == 5)
        .toList()[0]
        .split('');
    key[5] = keys
        .where((element) =>
            element.length == 5 &&
            key[1]!.where((e) => element.contains(e)).toList().length == 1 &&
            key[9]!.where((e) => element.contains(e)).toList().length == 5)
        .toList()[0]
        .split('');

    Map<int, String> sortedKey = {};
    for (var i = 0; i < key.keys.length; ++i) {
      key[i]!.sort();
      sortedKey[i] = key[i]!.join('');
    }

    return sortedKey;
  }
}

import 'dart:async';

import '../solution.dart';

class Day03 implements Solution {
  @override
  Future<String> first(String input) async {
    var values = input
        .split('\n')
        .where((element) => element.trim().isNotEmpty)
        .toList();
    var result = calculatePowerConsumption(values);

    return result.toString();
  }

  int calculatePowerConsumption(List<String> values) {
    var gamma = '';
    var epsilon = '';

    for (var i = 0; i < values[0].length; ++i) {
      var count = values.fold(
          0,
          (previousValue, element) =>
              (previousValue as int) + (element[i] == '1' ? 1 : 0));

      gamma += count >= values.length / 2 ? '1' : '0';
      epsilon += count > values.length / 2 ? '0' : '1';
    }

    return int.parse(gamma, radix: 2) * int.parse(epsilon, radix: 2);
  }

  @override
  Future<String> second(String input) async {
    var values = input
        .split('\n')
        .where((element) => element.trim().isNotEmpty)
        .toList();

    var oxygen = rating(values, 'up');
    var co2 = rating(values, 'down');

    return (oxygen * co2).toString();
  }

  int rating(List<String> values, String direction) {
    var remaining = values;

    for (var i = 0; i < values[0].length && remaining.length > 1; ++i) {
      var count = remaining.fold(
          0,
          (previousValue, element) =>
              (previousValue as int) + (element[i] == '1' ? 1 : 0));

      String driver;
      if ((direction == 'up' && count >= remaining.length / 2) ||
          (direction == 'down' && count < remaining.length / 2)) {
        driver = '1';
      } else {
        driver = '0';
      }

      remaining = remaining.where((element) => element[i] == driver).toList();
    }

    return int.parse(remaining[0], radix: 2);
  }
}

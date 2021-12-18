import 'package:aoc2021/solution.dart';

class Day12 implements Solution {
  @override
  Future<String> first(String input) async {
    return paths(
            input.split('\n').where((element) => element.isNotEmpty).toList())
        .length
        .toString();
  }

  List<String> paths(List<String> map) {
    Map<String, Set<String>> nodes = {};

    for (final path in map) {
      var split = path.split('-').map((e) => e.trim()).toList();
      nodes.putIfAbsent(split[0], () => <String>{});
      nodes.putIfAbsent(split[1], () => <String>{});

      nodes[split[0]]!.add(split[1]);
      nodes[split[1]]!.add(split[0]);
    }

    var paths = <String>{};
    var possible = <List<String>>[];
    possible.add(['start']);

    while (possible.isNotEmpty) {
      var path = possible.removeAt(0);

      if (path.last == 'end') {
        paths.add(path.join(','));
        continue;
      }

      var routes = nodes[path.last] as Set<String>;
      for (final route in routes) {
        if ((route.toLowerCase() == route && !path.contains(route)) ||
            route == route.toUpperCase()) {
          possible.add([...path, route]);
        }
      }
    }

    return paths.toList();
  }

  @override
  Future<String> second(String input) async {
    return doublePath(
            input.split('\n').where((element) => element.isNotEmpty).toList())
        .length
        .toString();
  }

  List<String> doublePath(List<String> map) {
    Map<String, Set<String>> nodes = {};

    for (final path in map) {
      var split = path.split('-').map((e) => e.trim()).toList();
      nodes.putIfAbsent(split[0], () => <String>{});
      nodes.putIfAbsent(split[1], () => <String>{});

      nodes[split[0]]!.add(split[1]);
      nodes[split[1]]!.add(split[0]);
    }

    var paths = <String>{};
    var possible = <List<String>>[];
    possible.add(['start']);

    while (possible.isNotEmpty) {
      var candidate = possible.removeAt(0);

      if (candidate.last == 'end') {
        paths.add(candidate.join(','));
        continue;
      }

      var isDoubled = candidate.contains('DOUBLED');

      var routes = nodes[candidate.last] as Set<String>;
      for (final route in routes) {
        if (route == 'start') {
          continue;
        }

        var isBig = route.toUpperCase() == route;
        var isVisited = candidate.contains(route);

        if (isBig || (isVisited && !isDoubled) || !isVisited) {
          var toAdd = [...candidate, route];

          if (candidate.contains(route) && !isBig) {
            toAdd.insert(0, 'DOUBLED');
          }

          possible.add(toAdd);
        }
      }
    }

    return paths.toList();
  }
}

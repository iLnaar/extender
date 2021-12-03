import 'package:yaml/yaml.dart';

///
/// YamlMap extension
///
extension YamlExt on YamlMap {
  ///
  /// Recursive method for converting nodes
  ///
  dynamic _convertNode(dynamic node) {
    if (node is YamlMap) {
      return node.toMap();
    } else if (node is YamlList) {
      final list = <dynamic>[];
      for (var item in node) {
        list.add(_convertNode(item));
      }
      return list;
    }
    return node;
  }

  ///
  /// Converting a string in the "yaml" format to Map
  ///
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    nodes.forEach((key, node) {
      map[(key as YamlScalar).value.toString()] = _convertNode(node.value);
    });
    return map;
  }
}
import 'package:yaml/yaml.dart';

import '../model/model.dart';
import 'json_deserializer.dart';

/// Deserializes analysis results from YAML format.
class YamlDeserializer {
  static AnalysisResult decode(String source) {
    final yaml = loadYaml(source);
    if (yaml is! YamlMap) {
      throw const FormatException('Invalid YAML: expected a map at the root.');
    }
    final normalized = _normalize(yaml);
    if (normalized is! Map<String, dynamic>) {
      throw const FormatException('Invalid YAML: root map structure not supported.');
    }
    return JsonDeserializer.fromMap(normalized);
  }
}

Object? _normalize(Object? value) {
  if (value is YamlMap) {
    return value.keys.cast<Object?>().fold<Map<String, dynamic>>({}, (map, key) {
      final keyString = key?.toString() ?? '';
      map[keyString] = _normalize(value[key]);
      return map;
    });
  }
  if (value is YamlList) {
    return value.map(_normalize).toList();
  }
  if (value is Map) {
    return value.map((key, value) => MapEntry(key.toString(), _normalize(value)));
  }
  if (value is List) {
    return value.map(_normalize).toList();
  }
  return value;
}

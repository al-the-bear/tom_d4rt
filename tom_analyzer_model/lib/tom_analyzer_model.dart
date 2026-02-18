/// Tom Analyzer Model - Object model and serialization for code analysis results.
///
/// This package contains the data model classes, serialization/deserialization
/// logic, and configuration for tom_analyzer analysis results. It has no
/// dependency on the Dart analyzer package.
library;

// Model
export 'src/model/model.dart';

// Serialization
export 'src/serialization/json_serializer.dart';
export 'src/serialization/json_deserializer.dart';
export 'src/serialization/yaml_serializer.dart';
export 'src/serialization/yaml_deserializer.dart';
export 'src/serialization/analysis_result_validator.dart';
export 'src/serialization/id_generator.dart';

// Configuration
export 'src/config/configuration.dart';

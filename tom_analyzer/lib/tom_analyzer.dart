export 'src/analyzer/analyzer_runner.dart';
export 'src/analyzer/analyzer_context_builder.dart';
export 'src/analyzer/annotation_parser.dart';
export 'src/analyzer/barrel_analyzer.dart';
export 'src/analyzer/element_visitor.dart';
export 'src/analyzer/type_resolver.dart';

// Re-export model, serialization, and config from tom_analyzer_model
export 'package:tom_analyzer_model/tom_analyzer_model.dart';

export 'src/reflection/reflection_model.dart';
export 'src/reflection/reflection_generator.dart';
export 'src/reflection/runtime_reflection.dart';
export 'src/reflection/generator/entry_point_analyzer.dart'
    hide AnnotationInfo, AnnotatedElementInfo;
export 'src/reflection/generator/reflection_config.dart';
export 'src/reflection/generator/source_info.dart';

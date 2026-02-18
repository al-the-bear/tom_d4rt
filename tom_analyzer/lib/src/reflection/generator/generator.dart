/// Reflection code generator module.
///
/// This module provides the code generator that produces `.r.dart` files
/// containing reflection data structures and invokers.
library;

export 'entry_point_analyzer.dart'
    show ReflectionAnalysisResult, EntryPointAnalyzer;
export 'filter_matcher.dart'
    show
        AnnotationPattern,
        DefaultsMatcher,
        FilterMatcher,
        GlobMatcher,
        InclusionResolver;
export 'multi_entry_generator.dart' show MultiEntryGenerator, MultiEntryResult;
export 'reflection_config.dart';
export 'reflection_generator.dart' show ReflectionGenerator;
export 'source_info.dart';

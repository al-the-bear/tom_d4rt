/// Public API for the tom_d4rt_flutter library.
///
/// Exports [SourceFlutterD4rt] — a source-based D4rt interpreter with the full
/// Flutter Material bridge surface registered — for use by the HTTP test app,
/// the demo/test application, and any other consumer that needs to render
/// interpreted Dart UI against real Flutter widgets.
///
/// Also exports the sample-source loading types ([SampleProgram],
/// [SampleSource], [createSampleSource], …) used to discover and load
/// multi-file sample apps; `SourceFlutterD4rt.buildMultiFile` builds these
/// directly.
library;

export 'src/source_flutter_d4rt.dart';
export 'src/sample_source.dart';
export 'src/profiling_metrics.dart';

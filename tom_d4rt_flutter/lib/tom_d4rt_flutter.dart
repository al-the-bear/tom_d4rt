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

// Interpreter diagnostics, surfaced so embedders can profile/inspect
// interpretation without a direct tom_d4rt dependency. [D4rtProfile] gives an
// opt-in per-phase timing breakdown of each interpret call (the dominant cost
// is import resolution, not parse or widget-tree complexity); [D4rtDiag]
// exposes the always-on call/allocation counters.
export 'package:tom_d4rt/d4rt.dart' show D4rtProfile, D4rtDiag;

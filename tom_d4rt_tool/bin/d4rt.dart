/// D4rt - DartScript Interactive REPL
/// 
/// Entry point for the D4rt REPL with full Tom Framework bridges.
/// For the base dcli-only version, use `dcli` from tom_d4rt_dcli instead.
library;

import 'package:tom_dartscript_bridges/src/cli/d4rt_repl.dart';

Future<void> main(List<String> arguments) async {
  await d4rtMain(arguments);
}

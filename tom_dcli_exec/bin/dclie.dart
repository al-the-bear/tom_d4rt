/// DCLIE - D4rt Command Line Interface (Exec)
///
/// Entry point for the dcli_exec REPL with dcli package bridges.
/// Uses the analyzer-free tom_d4rt_exec interpreter.
/// For the full D4rt tool with Tom Framework bridges, use `d4rt` instead.
library;

import 'package:tom_dcli_exec/tom_dcli_exec.dart';

Future<void> main(List<String> arguments) async {
  await DcliRepl().run(arguments);
}

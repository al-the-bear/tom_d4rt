/// DCLI - D4rt Command Line Interface
/// 
/// Entry point for the dcli REPL with dcli package bridges.
///
/// This is the surviving D4rt command-line tool. The header used to point at a
/// fuller `d4rt` binary "with Tom Framework bridges"; its source project
/// `tom_d4rt_tool` was deleted on 2026-02-25 and nothing in this workspace can
/// rebuild it, so that pointer sent readers to a February binary or to nothing
/// at all.
library;

import 'package:tom_d4rt_dcli/tom_d4rt_dcli.dart';

Future<void> main(List<String> arguments) async {
  await DcliRepl().run(arguments);
}

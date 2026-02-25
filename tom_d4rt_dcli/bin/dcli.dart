/// DCLI - D4rt Command Line Interface
/// 
/// Entry point for the dcli REPL with dcli package bridges.
/// For the full D4rt tool with Tom Framework bridges, use `d4rt` instead.
library;

import 'package:tom_d4rt_dcli/tom_d4rt_dcli.dart';

Future<void> main(List<String> arguments) async {
  await DcliRepl().run(arguments);
}

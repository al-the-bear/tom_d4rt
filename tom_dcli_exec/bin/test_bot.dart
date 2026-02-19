/// Test Bot Mode without bridge registration
/// 
/// This script tests the bot mode configuration loading and server startup
/// without registering all bridges (to avoid dcli duplicate class issues).
library;

import 'package:tom_d4rt_exec/tom_d4rt_exec.dart';
import 'package:tom_dcli_exec/src/cli/repl_base.dart';

class TestBotRepl extends D4rtReplBase {
  @override
  String get toolName => 'TestBot';
  
  @override
  String get toolVersion => '1.0.0';
  
  @override
  void registerBridges(D4rt d4rt) {
    // Skip bridge registration for testing
  }
  
  @override
  String getImportBlock() {
    return '''
import 'dart:core';
''';
  }
  
  @override
  String getBridgesHelp([D4rt? d4rt]) {
    return 'Test bot - no bridges registered.';
  }
}

Future<void> main(List<String> arguments) async {
  await TestBotRepl().run(['--bot-mode', ...arguments]);
}

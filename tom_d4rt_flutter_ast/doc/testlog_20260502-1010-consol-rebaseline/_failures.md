### tom_ast_generator
Failures (6):
  - Dart Overview Failures Round 2 G-DOV2-7: Extension on enum type resolution [2026-02-10 21:30] (OK) [dart_overview_failures2_test.dart]
  - DCli Bridge Gaps Class Method Callback Wrapping DCL-CLS-002: Class forEach callback uses InterpretedFunction [2026-02-11] (PASS) [dcli_bridge_gaps_test.dart]
  - Callback Wrapping Generation Simple Void Callbacks G-CB-2a: Void Function() callback correct wrapper. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
  - Callback Wrapping Generation Callbacks with Return Values G-CB-11: Bool Function(int) generates wrapper with return. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
  - Callback Wrapping Generation Callbacks with Return Values G-CB-12: String Function(String) generates wrapper with return. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
  - Callback Wrapping Generation Custom Typedef Resolution G-CB-7: Typedef with return value generates correct wrapper. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
Errors (1):
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-12: Error handling. [2026-02-13] (FAIL) [d4rt_tester_test.dart]

### tom_d4rt
Failures (9):
  - GEN-056: Extension on stdlib types GEN-056d: Extension on unknown type reports error. [2026-02-14] (PASS) [extension_on_stdlib_type_test.dart]
  - Export Tests I-MISC-40: Export conflict: local declaration vs. exported symbol. [2026-02-10 06:37] (PASS) [export_test.dart]
  - Export Tests I-MISC-41: Export conflict: two different exports define the same symbol. [2026-02-10 06:37] (PASS) [export_test.dart]
  - Introspection API - analyze() AnalysisResult API I-FILE-36: Should handle empty source. [2026-02-10 06:37] (PASS) [introspection_api_test.dart]
  - Introspection API - analyze() AnalysisResult API I-FILE-38: Should handle source with imports only. [2026-02-10 06:37] (PASS) [introspection_api_test.dart]
  - DCli Runtime Gaps DCL-RT-OPT: Optional callback parameters DCL-RT-OPT-02: Function reference as callback fails to receive args [2026-02-11] (FAILS) [dcli_runtime_gaps_test.dart]
  - Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL) [limitations_and_bugs_test.dart]
  - Fixed Bugs (SHOULD PASS) I-FILE-47: Lim-1: Extension types should work. [2026-02-10 06:37] (PASS) [limitations_and_bugs_test.dart]
  - Return Type Checking Tests I-MISC-212: Incorrect return type (null for Object). [2026-02-10 06:37] (PASS) [interpreter_test.dart]
Errors (1):
  - HashSet Tests I-COLL-25: Iterator basics and forEach. [2026-02-10 06:37] (PASS) [hash_set_test.dart]

### tom_d4rt_ast
Errors (2):
  - stdlib loading loads dart:math and makes math available [ast_module_loader_test.dart]
  - stdlib loading does not register same stdlib twice [ast_module_loader_test.dart]

### tom_d4rt_dcli
Failures (1):
  - VS Code Scripting API - Live Bridge Commands script can get active editor through bridge [vscode_scripting_api_bridges_test.dart]
Errors (1):
  - VS Code Scripting API - VSCodeWindow getActiveTextEditor returns editor info [vscode_scripting_api_bridges_test.dart]

### tom_d4rt_exec
Failures (25):
  - Export Tests I-MISC-40: Export conflict: local declaration vs. exported symbol. [2026-02-10 06:37] (PASS) [export_test.dart]
  - Export Tests I-MISC-41: Export conflict: two different exports define the same symbol. [2026-02-10 06:37] (PASS) [export_test.dart]
  - Dart Overview Failures Round 2 G-DOV2-7: Extension on enum type resolution [2026-02-10 21:30] (OK) [dart_overview_failures2_test.dart]
  - DCli Bridge Gaps Class Method Callback Wrapping DCL-CLS-002: Class forEach callback uses InterpretedFunction [2026-02-11] (PASS) [dcli_bridge_gaps_test.dart]
  - Callback Wrapping Generation Simple Void Callbacks G-CB-2a: Void Function() callback correct wrapper. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
  - Callback Wrapping Generation Callbacks with Return Values G-CB-11: Bool Function(int) generates wrapper with return. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
  - Callback Wrapping Generation Callbacks with Return Values G-CB-12: String Function(String) generates wrapper with return. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
  - Callback Wrapping Generation Custom Typedef Resolution G-CB-7: Typedef with return value generates correct wrapper. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
  - Introspection API - analyze() AnalysisResult API I-FILE-36: Should handle empty source. [2026-02-10 06:37] (PASS) [introspection_api_test.dart]
  - Introspection API - analyze() AnalysisResult API I-FILE-38: Should handle source with imports only. [2026-02-10 06:37] (PASS) [introspection_api_test.dart]
  - DCli Runtime Gaps DCL-RT-OPT: Optional callback parameters DCL-RT-OPT-02: Function reference as callback fails to receive args [2026-02-11] (FAILS) [dcli_runtime_gaps_test.dart]
  - Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL) [limitations_and_bugs_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-01: Hello world. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-02: StringAsProcess extension. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-03: Color output functions. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-04: File write/append. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-05: Progress class. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-06: Environment variables. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-07: Basic file operations. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-08: Command execution. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-10: Temporary files. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-11: Find function. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-12: Error handling. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-13: Cross-platform. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
  - D4rtTester end-to-end dcli_scripting_guide G-DCLI-14: Shell execution. [2026-02-13] (FAIL) [d4rt_tester_test.dart]
Errors (1):
  - HashSet Tests I-COLL-25: Iterator basics and forEach. [2026-02-10 06:37] (PASS) [hash_set_test.dart]

### tom_d4rt_generator
Failures (8):
  - Callback Wrapping Generation Callbacks with Return Values G-CB-11: Bool Function(int) generates wrapper with return. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
  - Callback Wrapping Generation Callbacks with Return Values G-CB-12: String Function(String) generates wrapper with return. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
  - Callback Wrapping Generation Custom Typedef Resolution G-CB-7: Typedef with return value generates correct wrapper. [2026-02-10 06:37] (PASS) [callback_wrapping_test.dart]
  - Dart Overview Failures Round 3 G-DOV3-1: Extension type getter access [2026-02-10] (FAIL) [dart_overview_failures3_test.dart]
  - Flutter Pattern Generation RC-8.2: Callback return type preservation G-FLP-16: Typedef callback return type Future<ConcreteType> is preserved in cast. [2026-02-26] (PASS) [flutter_patterns_test.dart]
  - Flutter Pattern Generation RC-8.6: Callback contravariance nullability G-FLP-28: Nullable callback arg Object? is preserved (not narrowed to Object). [2026-02-27] (FAIL) [flutter_patterns_test.dart]
  - Flutter Pattern Generation RC-6b: Generic callback return type preservation G-FLP-23: Nullable generic callback keeps <T> and return cast PageRouteLike<T>. [2026-02-26] (PASS) [flutter_patterns_test.dart]
  - Flutter Pattern Generation RC-4b: SDK type prefixing for clash-prone names G-FLP-30: Callback typedef return Point<double> is prefixed with dart:math alias. [2026-02-27] (FAIL) [flutter_patterns_test.dart]

### tom_dcli_exec
Failures (3):
  - DCli Project - tomexample (advanced) environment [dcli_example_test.dart]
  - DCli Project - tomexample (advanced) process_execution [dcli_example_test.dart]
  - DCli Project - standalone (advanced) redirect [dcli_example_test.dart]


// D4rt Test Suite - CLI API Classes
// Run with: dart run bin/d4rtrun.b.dart scripts/test_cli_api.dart

import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';

void main() {
  // ===========================================================================
  // Test: ExecuteResult (7 tests)
  // ===========================================================================

  var result = ExecuteResult.success('Hello from D4rt!');
  verifyNotNull(result, 'ExecuteResult.success created');
  verify(result.success, 'ExecuteResult should be success');
  verifyEquals(result.result, 'Hello from D4rt!', 'ExecuteResult result value');

  var failResult = ExecuteResult.failure('Something went wrong');
  verifyNotNull(failResult, 'ExecuteResult.failure created');
  verify(!failResult.success, 'ExecuteResult failure should not be success');
  verifyEquals(failResult.error, 'Something went wrong', 'ExecuteResult error message');

  // ===========================================================================
  // Test: SymbolKind Enum (6 tests)
  // ===========================================================================

  var classKind = SymbolKind.class_;
  verifyNotNull(classKind, 'SymbolKind.class_ exists');

  var enumKind = SymbolKind.enum_;
  verifyNotNull(enumKind, 'SymbolKind.enum_ exists');

  var methodKind = SymbolKind.method;
  verifyNotNull(methodKind, 'SymbolKind.method exists');

  var variableKind = SymbolKind.variable;
  verifyNotNull(variableKind, 'SymbolKind.variable exists');

  var importKind = SymbolKind.import_;
  verifyNotNull(importKind, 'SymbolKind.import_ exists');

  var packageKind = SymbolKind.package;
  verifyNotNull(packageKind, 'SymbolKind.package exists');

  // ===========================================================================
  // Test: SymbolInfo (5 tests)
  // ===========================================================================

  var sym = SymbolInfo(name: 'testMethod', kind: SymbolKind.method);
  verifyNotNull(sym, 'SymbolInfo created');
  verifyEquals(sym.name, 'testMethod', 'SymbolInfo name');
  verifyEquals(sym.kind, SymbolKind.method, 'SymbolInfo kind');

  var symWithDocs = SymbolInfo(
    name: 'MyClass',
    kind: SymbolKind.class_,
    documentation: 'A test class',
  );
  verifyNotNull(symWithDocs, 'SymbolInfo with docs created');
  verifyEquals(symWithDocs.documentation, 'A test class', 'SymbolInfo documentation');

  // ===========================================================================
  // Test: ImportInfo (5 tests)
  // ===========================================================================

  var imp = ImportInfo(
    path: 'package:tom_core_kernel/tom_core_kernel.dart',
    classes: ['TomException', 'TomLogger'],
    enums: ['TomLogLevel'],
    functions: [],
    variables: [],
  );
  verifyNotNull(imp, 'ImportInfo created');
  verifyEquals(imp.path, 'package:tom_core_kernel/tom_core_kernel.dart', 'ImportInfo path');
  verifyNotEmpty(imp.classes, 'ImportInfo has classes');
  verifyEquals(imp.classes.length, 2, 'ImportInfo has 2 classes');
  verifyNotEmpty(imp.enums, 'ImportInfo has enums');

  // ===========================================================================
  // Test: CliException Types (6 tests)
  // ===========================================================================

  var cliEx = CliException('Test CLI error');
  verifyNotNull(cliEx, 'CliException created');
  verifyContains(cliEx.toString(), 'Test CLI error', 'CliException toString');

  var fileNotFound = CliFileNotFoundException('/missing/file.dart');
  verifyNotNull(fileNotFound, 'CliFileNotFoundException created');

  var dirNotFound = DirectoryNotFoundException('/missing/dir');
  verifyNotNull(dirNotFound, 'DirectoryNotFoundException created');

  var execEx = ExecutionException('Execution failed');
  verifyNotNull(execEx, 'ExecutionException created');

  var nestingEx = MaxNestingDepthException(10);
  verifyNotNull(nestingEx, 'MaxNestingDepthException created');

  var notInitEx = CliNotInitializedException();
  verifyNotNull(notInitEx, 'CliNotInitializedException created');

  // ===========================================================================
  // Test: ExecutionContext and ContextStack (5 tests)
  // ===========================================================================

  var ctx = ExecutionContext(workingDirectory: '/tmp');
  verifyNotNull(ctx, 'ExecutionContext created');
  verifyEquals(ctx.workingDirectory, '/tmp', 'ExecutionContext workingDirectory');
  verify(ctx.isRoot, 'ExecutionContext isRoot');

  var stack = ContextStack('/tmp');
  verifyNotNull(stack, 'ContextStack created');
  verifyEquals(stack.cwd, '/tmp', 'ContextStack cwd');

  // ===========================================================================
  // Summary
  // ===========================================================================

  testSummary();
}

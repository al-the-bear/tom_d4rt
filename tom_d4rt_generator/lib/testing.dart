/// Test helpers for D4rt bridge generator issue reproduction.
///
/// This library provides infrastructure for end-to-end testing of bridge
/// generation issues. It creates temporary projects, generates bridges,
/// and optionally executes D4rt scripts to verify issue reproduction.
///
/// ## Usage
///
/// ```dart
/// import 'package:tom_d4rt_generator/testing.dart';
///
/// test('GEN-001: type erasure', () async {
///   final result = await runIssueTest(
///     issueId: 'GEN-001',
///     sourceFiles: {
///       'lib/src/my_class.dart': 'class MyClass<T> { ... }',
///     },
///     barrelContent: "export 'src/my_class.dart';",
///     d4rtScript: 'import "package:test_pkg/test_pkg.dart"; main() { ... }',
///   );
///   expect(result.generatedCode, contains('<dynamic>'));
/// });
/// ```
library;

export 'src/testing/d4rt_test_result.dart';
export 'src/testing/d4rt_tester.dart';
export 'src/testing/issue_test_helper.dart';

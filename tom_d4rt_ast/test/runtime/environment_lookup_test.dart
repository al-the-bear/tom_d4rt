/// Tests for the non-throwing [Environment.lookup] resolution path.
library;

/// `lookup` is the perf-critical sibling of the throwing [Environment.get].
/// The lexical → implicit-`this` fallback in
/// `InterpreterVisitor.visitSimpleIdentifier` runs on every bare-identifier
/// read, and for an instance-member reference (a bare field/getter that means
/// `this.<name>`) the lexical probe necessarily MISSES. The old throwing `get`
/// turned that routine miss into a thrown+caught `RuntimeD4rtException` with a
/// captured stack trace — thousands per second under an animation loop. These
/// tests pin the contract that makes the throw avoidable. Mirrors
/// `tom_d4rt/test/environment_lookup_test.dart`.
import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  group('Environment.lookup', () {
    late Environment env;

    setUp(() {
      env = Environment();
    });

    test('returns the bound value for a defined name', () {
      env.define('answer', 42);
      expect(env.lookup('answer'), 42);
    });

    test('returns kNotFound (without throwing) for an undefined name', () {
      expect(env.lookup('missing'), same(Environment.kNotFound));
      expect(() => env.lookup('missing'), returnsNormally);
    });

    test('distinguishes present-but-null from absent', () {
      env.define('maybe', null);
      expect(env.lookup('maybe'), isNull,
          reason: 'a binding to null resolves to null, not the sentinel');
      expect(env.lookup('maybe'), isNot(same(Environment.kNotFound)));
      expect(env.lookup('absent'), same(Environment.kNotFound));
    });

    test('walks the enclosing chain', () {
      env.define('outer', 'fromParent');
      final child = Environment(enclosing: env);
      expect(child.lookup('outer'), 'fromParent');
      expect(child.lookup('nope'), same(Environment.kNotFound));
    });

    test('kNotFound is a stable identity across calls', () {
      expect(env.lookup('x'), same(env.lookup('y')));
      final other = Environment();
      expect(other.lookup('z'), same(Environment.kNotFound));
    });
  });

  group('Environment.get parity', () {
    late Environment env;

    setUp(() {
      env = Environment();
    });

    test('returns the bound value for a defined name', () {
      env.define('answer', 42);
      expect(env.get('answer'), 42);
    });

    test('still throws RuntimeD4rtException on a miss', () {
      expect(
        () => env.get('missing'),
        throwsA(isA<RuntimeD4rtException>().having(
            (e) => e.message, 'message', contains('Undefined variable'))),
      );
    });

    test('returns null for a binding to null (does not throw)', () {
      env.define('maybe', null);
      expect(env.get('maybe'), isNull);
    });
  });
}

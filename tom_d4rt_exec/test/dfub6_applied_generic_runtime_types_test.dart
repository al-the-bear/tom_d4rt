// DFUB6 conformance (DGUB9): applied generic type arguments are preserved at
// runtime — verified against the ANALYZER-FREE interpreter.
//
// Mirror of tom_d4rt/test/dfub6_applied_generic_runtime_types_test.dart. The
// ast tree reaches the same behaviour by a different route: SAstNode has no
// parent references, so the applied return type is captured at declaration time
// onto `InterpretedFunction.declaredReturnTypeApplied` and checked in
// visitReturnStatement, rather than being read off the enclosing declaration at
// return time. This file is the guard that both routes agree.
//
// F-DFUB6-8 is the async exemption guard: an async function's declared
// `Future<T>` / `Stream<T>` / `Iterable<T>` return type wraps the returned inner
// value, so comparing the inner value's applied type against the wrapper's
// arguments would spuriously reject valid code.

import 'package:test/test.dart';
import 'interpreter_test.dart';

void main() {
  group('DFUB6 (exec): applied generic runtime types', () {
    test('F-DFUB6-EXEC-5: applied type args preserved for `is` [2026-07-27]',
        () {
      const code = '''
class Box<T> {
  final T value;
  Box(this.value);
}

List main() {
  var box = Box<int>(42);
  return [box is Box<int>, box is Box<num>, box is Box<String>];
}
''';
      expect(execute(code), equals([true, true, false]));
    });

    test(
        'F-DFUB6-EXEC-6b: generic return validation throws on mismatch '
        '[2026-07-27]', () {
      const code = '''
class Box<T> {
  final T value;
  Box(this.value);
}

Box<String> makeBox() {
  return Box<int>(42);
}

int main() {
  makeBox();
  return 0;
}
''';
      expect(() => execute(code), throwsRuntimeError(contains("can't be returned")));
    });

    test('F-DFUB6-EXEC-6c: matching generic return is allowed [2026-07-27]',
        () {
      const code = '''
class Box<T> {
  final T value;
  Box(this.value);
}

Box<int> makeBox() {
  return Box<int>(42);
}

int main() {
  var b = makeBox();
  return b.value;
}
''';
      expect(execute(code), equals(42));
    });

    test(
        'F-DFUB6-EXEC-7b: typed native collection return throws on mismatch '
        '[2026-07-27]', () {
      const code = '''
List<String> numbers() {
  return [1, 2, 3];
}

int main() {
  numbers();
  return 0;
}
''';
      expect(() => execute(code), throwsRuntimeError(contains("can't be returned")));
    });

    test(
        'F-DFUB6-EXEC-7c: matching typed native collection return is allowed '
        '[2026-07-27]', () {
      const code = '''
List<int> numbers() {
  return [1, 2, 3];
}

int main() {
  return numbers().length;
}
''';
      expect(execute(code), equals(3));
    });

    test(
        'F-DFUB6-EXEC-8: async return type wraps the inner value and is exempt '
        '[2026-07-27]', () async {
      const code = '''
Future<List<String>> load() async {
  return ['a', 'b'];
}

main() async {
  var r = await load();
  return r.length;
}
''';
      expect(await executeAsync(code), equals(2));
    });

    // Bound-constraint guard-rails (already pass — must stay passing).
    test(
        'F-DFUB6-EXEC-B1: class bound `T extends num` rejects String '
        '[2026-07-27]', () {
      const code = '''
class Box<T extends num> {
  final T value;
  Box(this.value);
}

int main() {
  var b = Box<String>('x');
  return 0;
}
''';
      expect(() => execute(code),
          throwsRuntimeError(contains('does not satisfy bound')));
    });

    test('F-DFUB6-EXEC-B2: class bound `T extends num` accepts int [2026-07-27]',
        () {
      const code = '''
class Box<T extends num> {
  final T value;
  Box(this.value);
}

int main() {
  var b = Box<int>(42);
  return b.value;
}
''';
      expect(execute(code), equals(42));
    });

    test('F-DFUB6-EXEC-B4: bound `T extends num` accepts double [2026-07-27]',
        () {
      const code = '''
class Box<T extends num> {
  final T value;
  Box(this.value);
}

double main() {
  var b = Box<double>(3.5);
  return b.value;
}
''';
      expect(execute(code), equals(3.5));
    });
  });
}

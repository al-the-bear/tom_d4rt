// DFUB6: preserve applied generic type arguments at runtime.
//
// Ports the applied-runtime-types half of upstream kodjodevf/d4rt 1042fff. The
// interpreter already stored `typeArguments` on an InterpretedInstance, but its
// `valueType` collapsed to the bare class, so `is Box<int>` ignored the type
// argument and generic/collection return-type checks compared the raw base type
// only. The fix adds `AppliedRuntimeType` (base + applied args, element-wise
// subtyping with dynamic/Object wildcards), makes `InterpretedInstance.valueType`
// applied, and validates applied generic returns + typed native-collection
// returns.
//
// The four BOUND-CONSTRAINT cases (`T extends num`) already pass on our fork via
// `_getValidatedTypeArguments` — they are kept here as green guard-rails so the
// dfub6 change does not regress them. The num-subtyping / TypeParameter-bound
// tightening half of 1042fff is the separate dfub7.
//
// THE TWO TREES REACH THIS BEHAVIOUR BY DIFFERENT ROUTES, which is why the twin
// of this file is worth running rather than assuming. An `SAstNode` carries no
// parent reference, so the analyzer-free interpreter cannot read the applied
// return type off the enclosing declaration at return time the way the
// analyzer-based one does; it captures the type at declaration time onto
// `InterpretedFunction.declaredReturnTypeApplied` and checks that in
// `visitReturnStatement`. Same answers, different mechanism — so a regression
// in one route would not show up in the other.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? execute(String code) {
  final d4rt = D4rt();
  return d4rt.execute(source: code);
}

void main() {
  group('DFUB6: applied generic runtime types', () {
    test(
      'F-DFUB6-5: applied type args preserved for `is` [2026-07-23] (RED)',
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
      },
    );

    test('F-DFUB6-6b: generic return validation throws on mismatch '
        '[2026-07-23] (RED)', () {
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
      expect(
        () => execute(code),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains("can't be returned"),
          ),
        ),
      );
    });

    test(
      'F-DFUB6-6c: matching generic return is allowed [2026-07-23] (RED)',
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
      },
    );

    test('F-DFUB6-7b: typed native collection return throws on mismatch '
        '[2026-07-23] (RED)', () {
      const code = '''
List<String> numbers() {
  return [1, 2, 3];
}

int main() {
  numbers();
  return 0;
}
''';
      expect(
        () => execute(code),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains("can't be returned"),
          ),
        ),
      );
    });

    test('F-DFUB6-7c: matching typed native collection return is allowed '
        '[2026-07-23] (RED)', () {
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

    // Bound-constraint guard-rails (already pass — must stay passing).
    test('F-DFUB6-B1: class bound `T extends num` rejects String '
        '[2026-07-23] (GREEN)', () {
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
      expect(
        () => execute(code),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains('does not satisfy bound'),
          ),
        ),
      );
    });

    test('F-DFUB6-B2: class bound `T extends num` accepts int '
        '[2026-07-23] (GREEN)', () {
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

    test('F-DFUB6-B3: nested bound `T extends num` rejects String '
        '[2026-07-23] (GREEN)', () {
      const code = '''
class Box<T extends num> {
  final T value;
  Box(this.value);
}

int main() {
  var b = Box<Box<String>>(null);
  return 0;
}
''';
      expect(() => execute(code), throwsA(isA<RuntimeD4rtException>()));
    });

    test('F-DFUB6-B4: bound `T extends num` accepts double '
        '[2026-07-23] (GREEN)', () {
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

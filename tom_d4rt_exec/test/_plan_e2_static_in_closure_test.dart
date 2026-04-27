/// Regression tests for Plan E2 — interpreted `static` helper accepting a
/// receiver argument and called from inside a closure that captures (or
/// receives) that receiver. The historic failure shape was
/// "Cannot invoke method '...' on null" — the receiver bound to the
/// static method's parameter became null when the helper was invoked
/// through a builder/closure boundary.
///
/// These tests use plain Dart constructs (no Flutter context types) but
/// reproduce the exact dispatch shape of `AppStateScope.watch(context)`
/// being called inside a `bodyBuilder: (context, _) { ... }` closure in
/// `widgets/inherited_widget_test.dart`.
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  test('static helper called from closure receiving the arg', () async {
    final d4rt = D4rt();
    final bundle = await d4rt.createBundleFromSource('''
class Ctx {
  final int value;
  const Ctx(this.value);
  int peek() => value;
}

class Scope {
  static int watch(Ctx context) {
    return context.peek();
  }
}

int run(int Function(Ctx) body) {
  final Ctx c = const Ctx(42);
  return body(c);
}

int main() {
  return run((ctx) => Scope.watch(ctx));
}
''');
    final runner = D4rtRunner();
    final result = runner.executeBundle(bundle);
    expect(result, 42);
  });

  test('static helper called from nested builder closure', () async {
    final d4rt = D4rt();
    final bundle = await d4rt.createBundleFromSource('''
class Ctx {
  final int value;
  const Ctx(this.value);
  int peek() => value;
}

class Scope {
  static int watch(Ctx context) {
    return context.peek();
  }
}

int useBuilder({required int Function(Ctx, int) bodyBuilder}) {
  final Ctx c = const Ctx(7);
  return bodyBuilder(c, 5);
}

int main() {
  return useBuilder(
    bodyBuilder: (context, builds) {
      final s = Scope.watch(context);
      return s + builds;
    },
  );
}
''');
    final runner = D4rtRunner();
    final result = runner.executeBundle(bundle);
    expect(result, 12);
  });

  test('static helper call on closure-captured receiver', () async {
    // Variant where the closure does not receive the receiver as an
    // argument but captures it from the enclosing scope.
    final d4rt = D4rt();
    final bundle = await d4rt.createBundleFromSource('''
class Ctx {
  final int value;
  const Ctx(this.value);
  int peek() => value;
}

class Scope {
  static int watch(Ctx context) {
    return context.peek();
  }
}

int run(int Function() body) => body();

int main() {
  final Ctx outer = const Ctx(99);
  return run(() => Scope.watch(outer));
}
''');
    final runner = D4rtRunner();
    final result = runner.executeBundle(bundle);
    expect(result, 99);
  });
}

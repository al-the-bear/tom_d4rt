/// Mirror of `tom_d4rt_exec/test/_plan_e2_static_in_closure_test.dart`
/// for the analyzer-based interpreter. Plan E2 — interpreted `static`
/// helper called from inside a closure that receives or captures the
/// receiver. Historic failure shape was "Cannot invoke method '...' on
/// null".
import 'package:test/test.dart';
import 'package:tom_d4rt_v2/d4rt.dart';

void main() {
  test('static helper called from closure receiving the arg', () {
    final d4rt = D4rt();
    final result = d4rt.execute(source: '''
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

main() {
  return run((ctx) => Scope.watch(ctx));
}
''');
    expect(result, 42);
  });

  test('static helper called from nested builder closure', () {
    final d4rt = D4rt();
    final result = d4rt.execute(source: '''
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

main() {
  return useBuilder(
    bodyBuilder: (context, builds) {
      final s = Scope.watch(context);
      return s + builds;
    },
  );
}
''');
    expect(result, 12);
  });

  test('static helper call on closure-captured receiver', () {
    final d4rt = D4rt();
    final result = d4rt.execute(source: '''
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

main() {
  final Ctx outer = const Ctx(99);
  return run(() => Scope.watch(outer));
}
''');
    expect(result, 99);
  });
}

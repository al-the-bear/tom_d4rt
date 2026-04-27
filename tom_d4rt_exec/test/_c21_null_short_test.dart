import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  test('AST runner: null-shorting through . after ?. simple', () async {
    final d4rt = D4rt();
    final bundle = await d4rt.createBundleFromSource('''
class Box {
  Size get size => Size(10, 20);
}
class Size {
  final double width;
  final double height;
  Size(this.width, this.height);
}
double main() {
  Box? a;
  return a?.size.height ?? -1.0;
}
''');
    final runner = D4rtRunner();
    final result = runner.executeBundle(bundle);
    expect(result, -1.0);
  });

  test('AST runner: null-shorting after method-returned null', () async {
    final d4rt = D4rt();
    final bundle = await d4rt.createBundleFromSource('''
class Box {
  Size get size => Size(10, 20);
}
class Size {
  final double width;
  final double height;
  Size(this.width, this.height);
}
Box? lookup() => null;
double main() {
  final Box? a = lookup();
  return a?.size.height ?? -1.0;
}
''');
    final runner = D4rtRunner();
    final result = runner.executeBundle(bundle);
    expect(result, -1.0);
  });
}

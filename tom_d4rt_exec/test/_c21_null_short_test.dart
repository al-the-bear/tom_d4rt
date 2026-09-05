import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:test/test.dart';

void main() {
  test('null-shorting through . after ?. simple', () {
    final d4rt = D4rt();
    final result = d4rt.execute(
      source: '''
      class Box {
        Size get size => Size(10, 20);
      }
      class Size {
        final double width;
        final double height;
        Size(this.width, this.height);
      }
      main() {
        Box? a;
        return a?.size.height ?? -1;
      }
    ''',
    );
    expect(result, -1);
  });
}

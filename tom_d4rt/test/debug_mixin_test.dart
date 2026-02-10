import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  test('debug bridged mixin [2026-02-10 06:37]', () async {
    final d4rt = D4rt();
    d4rt.setDebug(true);

    d4rt.registerBridgedClass(
      BridgedClass(
        nativeType: Object,
        name: 'TestMixin',
        canBeUsedAsMixin: true,
        methods: {
          'mixinMethod': (visitor, instance, positionalArgs, namedArgs, typeArgs) {
            return 'Mixin called';
          },
        },
      ),
      'package:test/mixin.dart',
    );

    const code = '''
      import 'package:test/mixin.dart';
      
      class MyClass with TestMixin {
        MyClass();
      }
      
      main() {
        return MyClass();
      }
    ''';

    final result = await d4rt.execute(
      library: 'package:test/main.dart',
      sources: {'package:test/main.dart': code},
    );

    print('Result: $result');
  });
}

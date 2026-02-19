import 'package:tom_d4rt_exec/tom_d4rt_exec.dart';
import 'test_helpers.dart';

void main() async {
  final d4rt = D4rt(parseSourceCallback: parseSource)..setDebug(true);

  const source = '''
    Future<String> main() async {
      await Future.delayed(Duration(milliseconds: 10));
      return "Done";
    }
  ''';

  print('=== Calling d4rt.execute ===');
  final result = d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': source},
  );
  print('=== Result type: ${result.runtimeType} ===');
  print('=== Result: $result ===');

  if (result is Future) {
    print('=== Awaiting Future ===');
    final awaited = await result;
    print('=== Awaited type: ${awaited.runtimeType} ===');
    print('=== Awaited: $awaited ===');
  }
}

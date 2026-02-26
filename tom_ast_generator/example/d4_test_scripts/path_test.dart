import 'dart:io';
void main() {
  final f = File('./shebang_test.dart');
  print('absolute.path: ${f.absolute.path}');
  print('resolveSymbolicLinksSync: ${f.resolveSymbolicLinksSync()}');
}

import 'package:tom_dcli_exec/tom_dcli_exec.dart';
import 'package:tom_dcli_exec/src/version.versioner.dart';
import 'package:test/test.dart';

void main() {
  test('version is defined', () {
    expect(DcliVersionInfo.versionShort, isNotEmpty);
  });

  test('TomD4rtDcliBridge registers without error', () {
    expect(() => TomD4rtDcliBridge.register(), returnsNormally);
  });
}

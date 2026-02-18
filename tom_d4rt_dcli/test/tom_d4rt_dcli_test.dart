import 'package:tom_d4rt_dcli/tom_d4rt_dcli.dart';
import 'package:tom_d4rt_dcli/src/version.versioner.dart';
import 'package:test/test.dart';

void main() {
  test('version is defined', () {
    expect(DcliVersionInfo.versionShort, isNotEmpty);
  });

  test('TomD4rtDcliBridge registers without error', () {
    expect(() => TomD4rtDcliBridge.register(), returnsNormally);
  });
}

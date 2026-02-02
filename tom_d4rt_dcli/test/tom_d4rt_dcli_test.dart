import 'package:tom_d4rt_dcli/tom_d4rt_dcli.dart';
import 'package:test/test.dart';

void main() {
  test('dcliVersion is defined', () {
    expect(dcliVersion, isNotEmpty);
  });

  test('TomD4rtDcliBridge registers without error', () {
    expect(() => TomD4rtDcliBridge.register(), returnsNormally);
  });
}

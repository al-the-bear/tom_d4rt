/// Tests for EnumInfo class in the bridge generator.
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  group('EnumInfo', () {
    test('G-ENM-20: Creates simple enum info. [2026-02-10 06:37] (PASS)', () {
      final info = EnumInfo(
        name: 'Status',
        values: ['pending', 'active', 'completed'],
        sourceFile: 'test.dart',
      );

      expect(info.name, equals('Status'));
      expect(info.values, equals(['pending', 'active', 'completed']));
      expect(info.sourceFile, equals('test.dart'));
      expect(info.hasMembers, isFalse);
    });

    test('G-ENM-17: Creates enum info with members. [2026-02-10 06:37] (PASS)', () {
      final info = EnumInfo(
        name: 'Color',
        values: ['red', 'green', 'blue'],
        sourceFile: 'colors.dart',
        hasMembers: true,
      );

      expect(info.name, equals('Color'));
      expect(info.hasMembers, isTrue);
    });

    test('G-ENM-18: Creates enum info with single value. [2026-02-10 06:37] (PASS)', () {
      final info = EnumInfo(
        name: 'Singleton',
        values: ['instance'],
        sourceFile: 'singleton.dart',
      );

      expect(info.values.length, equals(1));
      expect(info.values.first, equals('instance'));
    });

    test('G-ENM-19: Handles empty source file. [2026-02-10 06:37] (PASS)', () {
      final info = EnumInfo(
        name: 'Test',
        values: ['a', 'b'],
        sourceFile: '',
      );

      expect(info.sourceFile, isEmpty);
    });
  });
}

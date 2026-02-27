import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/file_generators.dart';

void main() {
  group('File generators', () {
    test(
      'G-FGEN-01: Barrel exports are relative to barrelPath directory. [2026-02-27] (FAIL)',
      () {
        final config = BridgeConfig(
          name: 'flutter_material_bridges',
          barrelPath: 'lib/src/bridges/flutter_bridges_barrel.b.dart',
          modules: const [
            ModuleConfig(
              name: 'flutter_painting',
              barrelFiles: ['package:flutter/painting.dart'],
              outputPath: 'lib/src/bridges/painting_bridges.b.dart',
            ),
            ModuleConfig(
              name: 'flutter_widgets',
              barrelFiles: ['package:flutter/widgets.dart'],
              outputPath: 'lib/src/bridges/widgets_bridges.b.dart',
            ),
          ],
        );

        final content = generateBarrelFileContent(config);

        expect(
          content,
          contains("export 'painting_bridges.b.dart';"),
          reason:
              'Exports must be relative to barrel file directory when barrelPath is nested in lib/src/bridges',
        );
        expect(
          content,
          contains("export 'widgets_bridges.b.dart';"),
          reason:
              'Exports must not duplicate src/bridges prefix from module output paths',
        );
        expect(content, isNot(contains("export 'src/bridges/")));
      },
    );
  });
}
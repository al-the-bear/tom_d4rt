import 'package:test/test.dart';
import 'package:tom_analyzer/tom_analyzer.dart';

import '../support/test_builders.dart';

void main() {
  test('LibraryInfo exposes source files', () {
    final package = TestModelBuilders.package();
    final mainFile = TestModelBuilders.file(packageInfo: package, path: 'lib/main.dart');
    final partFile = TestModelBuilders.file(packageInfo: package, path: 'lib/part.dart');

    final library = LibraryInfo(
      id: 'lib1',
      name: 'main',
      uri: Uri.parse('package:${package.name}/main.dart'),
      package: package,
      mainSourceFile: mainFile,
      partFiles: [partFile],
    );

    expect(library.sourceFiles, [mainFile, partFile]);
  });

  test('LibraryInfo aggregates type declarations', () {
    final library = TestModelBuilders.library();
    final classes = <ClassInfo>[TestModelBuilders.classInfo(libraryInfo: library)];
    final enums = <EnumInfo>[TestModelBuilders.enumInfo(libraryInfo: library)];
    final mixins = <MixinInfo>[TestModelBuilders.mixinInfo(libraryInfo: library)];

    final customLibrary = LibraryInfo(
      id: 'lib2',
      name: library.name,
      uri: library.uri,
      package: library.package,
      mainSourceFile: library.mainSourceFile,
      classes: classes,
      enums: enums,
      mixins: mixins,
    );

    expect(customLibrary.typeDeclarations.length, 3);
  });

  test('ImportInfo and ExportInfo track libraries', () {
    final library = TestModelBuilders.library();
    final other = TestModelBuilders.library(name: 'other');

    const show = ['A', 'B'];
    const hide = ['C'];

    final importInfo = ImportInfo(
      id: 'import1',
      importingLibrary: library,
      importedLibrary: other,
      prefix: 'prefix',
      isDeferred: true,
      show: show,
      hide: hide,
    );

    final exportInfo = ExportInfo(
      id: 'export1',
      exportingLibrary: library,
      exportedLibrary: other,
      show: show,
      hide: hide,
    );

    expect(importInfo.isDeferred, isTrue);
    expect(exportInfo.show, show);
  });
}

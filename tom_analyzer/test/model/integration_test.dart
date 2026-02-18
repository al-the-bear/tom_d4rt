import 'package:test/test.dart';
import 'package:tom_analyzer/tom_analyzer.dart';

import '../support/test_builders.dart';

void main() {
  test('analysis result navigates object graph', () {
    final libraries = <LibraryInfo>[];
    final package = TestModelBuilders.package(libraries: libraries);
    final file = TestModelBuilders.file(packageInfo: package, path: 'lib/full.dart');

    final classes = <ClassInfo>[];
    final methods = <MethodInfo>[];
    final fields = <FieldInfo>[];
    final getters = <GetterInfo>[];
    final setters = <SetterInfo>[];
    final constructors = <ConstructorInfo>[];

    final library = LibraryInfo(
      id: 'lib_full',
      name: 'full',
      uri: Uri.parse('package:${package.name}/full.dart'),
      package: package,
      mainSourceFile: file,
      classes: classes,
    );

    libraries.add(library);

    final classInfo = ClassInfo(
      id: 'class_full',
      name: 'Full',
      qualifiedName: '${library.uri}.Full',
      library: library,
      sourceFile: file,
      location: TestModelBuilders.location(),
      constructors: constructors,
      methods: methods,
      fields: fields,
      getters: getters,
      setters: setters,
    );

    classes.add(classInfo);

    methods.add(TestModelBuilders.methodInfo(declaringType: classInfo));
    fields.add(TestModelBuilders.fieldInfo(declaringType: classInfo));
    getters.add(TestModelBuilders.getterInfo(declaringType: classInfo));
    setters.add(TestModelBuilders.setterInfo(declaringType: classInfo));
    constructors.add(TestModelBuilders.constructorInfo(declaringType: classInfo));

    final result = AnalysisResult(
      id: 'analysis_full',
      timestamp: DateTime(2026, 1, 1),
      dartSdkVersion: '3.10.4',
      analyzerVersion: '7.7.1',
      schemaVersion: '1.0',
      rootPackage: package,
      packages: {package.name: package},
      libraries: {library.uri: library},
      files: {file.path: file},
    );

    expect(result.allClasses.length, 1);
    expect(result.allExecutables.length, greaterThan(0));
    expect(library.executables, isNotEmpty);
  });
}

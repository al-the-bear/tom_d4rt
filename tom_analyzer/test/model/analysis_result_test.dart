import 'package:test/test.dart';
import 'package:tom_analyzer/tom_analyzer.dart';

import '../support/test_builders.dart';

AnalysisResult _buildAnalysisResult() {
  final libraries = <LibraryInfo>[];
  final package = TestModelBuilders.package(libraries: libraries);
  final file = TestModelBuilders.file(packageInfo: package, path: 'lib/a.dart');

  final classes = <ClassInfo>[];
  final functions = <FunctionInfo>[];
  final getters = <GetterInfo>[];
  final setters = <SetterInfo>[];

  final library = LibraryInfo(
    id: 'lib_a',
    name: 'a',
    uri: Uri.parse('package:${package.name}/a.dart'),
    package: package,
    mainSourceFile: file,
    classes: classes,
    functions: functions,
    getters: getters,
    setters: setters,
  );

  libraries.add(library);

  final classInfo = ClassInfo(
    id: 'class_a',
    name: 'A',
    qualifiedName: '${library.uri}.A',
    library: library,
    sourceFile: file,
    location: TestModelBuilders.location(),
    annotations: [TestModelBuilders.annotation(name: 'sealed')],
  );

  classes.add(classInfo);

  final functionInfo = FunctionInfo(
    id: 'func_a',
    name: 'doThing',
    qualifiedName: '${library.uri}.doThing',
    library: library,
    sourceFile: file,
    location: TestModelBuilders.location(),
    returnType: TestModelBuilders.typeRef(name: 'void'),
    annotations: [TestModelBuilders.annotation(name: 'sealed')],
  );

  functions.add(functionInfo);
  getters.add(TestModelBuilders.getterInfo(owningLibrary: library));
  setters.add(TestModelBuilders.setterInfo(owningLibrary: library));

  return AnalysisResult(
    id: 'analysis_1',
    timestamp: DateTime(2026, 1, 1),
    dartSdkVersion: '3.10.4',
    analyzerVersion: '7.7.1',
    schemaVersion: '1.0',
    rootPackage: package,
    packages: {package.name: package},
    libraries: {library.uri: library},
    files: {file.path: file},
  );
}

void main() {
  test('query APIs find elements', () {
    final result = _buildAnalysisResult();

    expect(result.getClassOrThrow('A').name, 'A');
    expect(result.findClassInLibrary('A', result.libraries.keys.first)?.name, 'A');
    expect(result.findClassesWithAnnotation('sealed').length, 1);
    expect(result.findFunctionsWithAnnotation('sealed').length, 1);
  });

  test('getClassOrThrow throws not found', () {
    final result = _buildAnalysisResult();
    expect(
      () => result.getClassOrThrow('Missing'),
      throwsA(isA<ElementNotFoundException>()),
    );
  });

  test('getClassOrThrow throws on ambiguous', () {
    final result = _buildAnalysisResult();
    final library = result.libraries.values.first;

    final anotherClass = ClassInfo(
      id: 'class_b',
      name: 'A',
      qualifiedName: '${library.uri}.A2',
      library: library,
      sourceFile: library.mainSourceFile,
      location: TestModelBuilders.location(line: 2),
    );

    library.classes.add(anotherClass);

    expect(
      () => result.getClassOrThrow('A'),
      throwsA(isA<AmbiguousElementException>()),
    );
  });

  test('generic findElementsWithAnnotation finds classes', () {
    final result = _buildAnalysisResult();
    final matches = result.findElementsWithAnnotation<ClassInfo>('sealed');

    expect(matches.length, 1);
    expect(matches.first.name, 'A');
  });
}

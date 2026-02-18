import 'package:mocktail/mocktail.dart';
import 'package:tom_analyzer/tom_analyzer.dart';

class MockAnalysisResult extends Mock implements AnalysisResult {}

class TestModelBuilders {
  TestModelBuilders._();

  static int _counter = 0;

  static String _nextId(String prefix) => '${prefix}_${++_counter}';

  static SourceLocation location({int line = 1, int column = 1}) {
    return SourceLocation(line: line, column: column, offset: 0, length: 0);
  }

  static AnnotationInfo annotation({String name = 'Anno'}) {
    return AnnotationInfo(name: name, qualifiedName: name);
  }

  static TypeReference typeRef({String name = 'int'}) {
    return TypeReference(
      id: _nextId('type'),
      name: name,
      qualifiedName: name,
    );
  }

  static PackageInfo package({
    String name = 'pkg',
    List<LibraryInfo>? libraries,
  }) {
    final libs = libraries ?? <LibraryInfo>[];
    return PackageInfo(
      id: _nextId('pkg'),
      name: name,
      rootPath: '/tmp/$name',
      analysisResult: MockAnalysisResult(),
      libraries: libs,
    );
  }

  static FileInfo file({
    PackageInfo? packageInfo,
    LibraryInfo? library,
    String path = 'lib/source.dart',
  }) {
    final pkg = packageInfo ?? package();
    return FileInfo(
      id: _nextId('file'),
      path: path,
      package: pkg,
      library: library,
      isPart: false,
      lines: 1,
      contentHash: 'hash',
      modified: DateTime(2026, 1, 1),
    );
  }

  static LibraryInfo library({
    PackageInfo? packageInfo,
    FileInfo? sourceFile,
    String name = 'library',
    Uri? uri,
  }) {
    final pkg = packageInfo ?? package();
    final fileInfo = sourceFile ?? file(packageInfo: pkg);
    return LibraryInfo(
      id: _nextId('lib'),
      name: name,
      uri: uri ?? Uri.parse('package:${pkg.name}/$name.dart'),
      package: pkg,
      mainSourceFile: fileInfo,
    );
  }

  static ClassInfo classInfo({
    LibraryInfo? libraryInfo,
    String name = 'SampleClass',
  }) {
    final lib = libraryInfo ?? library();
    return ClassInfo(
      id: _nextId('class'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      library: lib,
      sourceFile: lib.mainSourceFile,
      location: location(),
    );
  }

  static EnumInfo enumInfo({
    LibraryInfo? libraryInfo,
    String name = 'SampleEnum',
  }) {
    final lib = libraryInfo ?? library();
    return EnumInfo(
      id: _nextId('enum'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      library: lib,
      sourceFile: lib.mainSourceFile,
      location: location(),
    );
  }

  static MixinInfo mixinInfo({
    LibraryInfo? libraryInfo,
    String name = 'SampleMixin',
  }) {
    final lib = libraryInfo ?? library();
    return MixinInfo(
      id: _nextId('mixin'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      library: lib,
      sourceFile: lib.mainSourceFile,
      location: location(),
    );
  }

  static ExtensionInfo extensionInfo({
    LibraryInfo? libraryInfo,
    String name = 'SampleExtension',
  }) {
    final lib = libraryInfo ?? library();
    return ExtensionInfo(
      id: _nextId('extension'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      library: lib,
      sourceFile: lib.mainSourceFile,
      location: location(),
      extendedType: typeRef(name: 'String'),
    );
  }

  static ExtensionTypeInfo extensionTypeInfo({
    LibraryInfo? libraryInfo,
    String name = 'SampleExtensionType',
  }) {
    final lib = libraryInfo ?? library();
    return ExtensionTypeInfo(
      id: _nextId('extensionType'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      library: lib,
      sourceFile: lib.mainSourceFile,
      location: location(),
      representationType: typeRef(name: 'int'),
    );
  }

  static TypeAliasInfo typeAliasInfo({
    LibraryInfo? libraryInfo,
    String name = 'SampleAlias',
  }) {
    final lib = libraryInfo ?? library();
    return TypeAliasInfo(
      id: _nextId('alias'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      library: lib,
      sourceFile: lib.mainSourceFile,
      location: location(),
      aliasedType: typeRef(name: 'String'),
    );
  }

  static FunctionInfo functionInfo({
    LibraryInfo? libraryInfo,
    String name = 'topLevelFunction',
  }) {
    final lib = libraryInfo ?? library();
    return FunctionInfo(
      id: _nextId('function'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      library: lib,
      sourceFile: lib.mainSourceFile,
      location: location(),
      returnType: typeRef(name: 'void'),
    );
  }

  static MethodInfo methodInfo({
    TypeDeclaration? declaringType,
    LibraryInfo? owningLibrary,
    String name = 'method',
  }) {
    final lib = owningLibrary ?? libraryInfoFromType(declaringType) ?? library();
    return MethodInfo(
      id: _nextId('method'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      declaringType: declaringType,
      owningLibrary: declaringType == null ? lib : null,
      sourceFile: lib.mainSourceFile,
      location: location(),
      returnType: typeRef(),
      isStatic: false,
    );
  }

  static ConstructorInfo constructorInfo({
    required TypeDeclaration declaringType,
    String name = '',
  }) {
    return ConstructorInfo(
      id: _nextId('ctor'),
      name: name,
      qualifiedName: '${declaringType.library.uri}.$name',
      declaringType: declaringType,
      sourceFile: declaringType.sourceFile,
      location: location(),
    );
  }

  static GetterInfo getterInfo({
    TypeDeclaration? declaringType,
    LibraryInfo? owningLibrary,
    String name = 'value',
  }) {
    final lib = owningLibrary ?? libraryInfoFromType(declaringType) ?? library();
    return GetterInfo(
      id: _nextId('getter'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      declaringType: declaringType,
      owningLibrary: declaringType == null ? lib : null,
      sourceFile: lib.mainSourceFile,
      location: location(),
      returnType: typeRef(),
    );
  }

  static SetterInfo setterInfo({
    TypeDeclaration? declaringType,
    LibraryInfo? owningLibrary,
    String name = 'value',
  }) {
    final lib = owningLibrary ?? libraryInfoFromType(declaringType) ?? library();
    return SetterInfo(
      id: _nextId('setter'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      declaringType: declaringType,
      owningLibrary: declaringType == null ? lib : null,
      sourceFile: lib.mainSourceFile,
      location: location(),
      parameter: ParameterInfo(
        id: _nextId('param'),
        name: 'value',
        type: typeRef(),
        isRequired: true,
        isNamed: false,
        isPositional: true,
        hasDefaultValue: false,
      ),
    );
  }

  static FieldInfo fieldInfo({
    TypeDeclaration? declaringType,
    LibraryInfo? owningLibrary,
    String name = 'field',
  }) {
    final lib = owningLibrary ?? libraryInfoFromType(declaringType) ?? library();
    return FieldInfo(
      id: _nextId('field'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      declaringType: declaringType,
      owningLibrary: declaringType == null ? lib : null,
      sourceFile: lib.mainSourceFile,
      location: location(),
      type: typeRef(),
    );
  }

  static VariableInfo variableInfo({
    LibraryInfo? owningLibrary,
    String name = 'variable',
  }) {
    final lib = owningLibrary ?? library();
    return VariableInfo(
      id: _nextId('variable'),
      name: name,
      qualifiedName: '${lib.uri}.$name',
      owningLibrary: lib,
      sourceFile: lib.mainSourceFile,
      location: location(),
      type: typeRef(),
    );
  }

  static LibraryInfo? libraryInfoFromType(TypeDeclaration? type) => type?.library;
}

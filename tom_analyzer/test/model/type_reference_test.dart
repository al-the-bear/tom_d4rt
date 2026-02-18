import 'package:test/test.dart';
import 'package:tom_analyzer/tom_analyzer.dart';

import '../support/test_builders.dart';

void main() {
  test('TypeReference resolves as class', () {
    final library = TestModelBuilders.library();
    final cls = TestModelBuilders.classInfo(libraryInfo: library, name: 'MyClass');

    final typeRef = TypeReference(
      id: 'type1',
      name: 'MyClass',
      qualifiedName: 'MyClass',
      resolvedElement: cls,
    );

    expect(typeRef.resolveAsClass(), cls);
    expect(typeRef.resolveAsEnum(), isNull);
    expect(typeRef.resolveAsTypeDeclaration(), cls);
  });

  test('TypeReference matchResolved selects branch', () {
    final library = TestModelBuilders.library();
    final mixinInfo = TestModelBuilders.mixinInfo(libraryInfo: library, name: 'MyMixin');

    final typeRef = TypeReference(
      id: 'type2',
      name: 'MyMixin',
      qualifiedName: 'MyMixin',
      resolvedElement: mixinInfo,
    );

    final result = typeRef.matchResolved<String>(
      onClass: (_) => 'class',
      onEnum: (_) => 'enum',
      onMixin: (_) => 'mixin',
      onExtension: (_) => 'extension',
      onTypeAlias: (_) => 'alias',
      onExtensionType: (_) => 'extensionType',
      onUnresolved: () => 'none',
    );

    expect(result, 'mixin');
  });

  test('TypeReference unresolved branch returns default', () {
    final typeRef = TypeReference(
      id: 'type3',
      name: 'Unknown',
      qualifiedName: 'Unknown',
    );

    final result = typeRef.matchResolved<String>(
      onClass: (_) => 'class',
      onEnum: (_) => 'enum',
      onMixin: (_) => 'mixin',
      onExtension: (_) => 'extension',
      onTypeAlias: (_) => 'alias',
      onExtensionType: (_) => 'extensionType',
      onUnresolved: () => 'none',
    );

    expect(result, 'none');
  });
}

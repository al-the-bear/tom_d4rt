/// Finds all annotations used in scanned packages and lists elements with them.
///
/// Run with: dart run tool/find_annotations.dart
/// For specific package: dart run tool/find_annotations.dart --package=tom_core_kernel
library;

import 'package:analyzer/dart/element/element.dart';
import 'package:tom_analyzer/src/reflection/generator/entry_point_analyzer.dart';
import 'package:tom_analyzer/src/reflection/generator/reflection_config.dart';

void main(List<String> args) async {
  final baseDir = '/Users/alexiskyaw/Desktop/Code/tom2';

  // Parse args for package filter
  String? packageFilter;
  for (final arg in args) {
    if (arg.startsWith('--package=')) {
      packageFilter = arg.substring('--package='.length);
    }
  }

  // Entry points from each tom_* package
  final entryPoints = [
    '$baseDir/uam/tom_uam_server/bin/aa_server_start.dart',
    '$baseDir/uam/tom_uam_codespec/lib/tom_uam_codespec.dart',
    '$baseDir/core/tom_core_kernel/lib/tom_core_kernel.dart',
    '$baseDir/xternal/tom_module_reflection/tom_reflection/lib/tom_reflection.dart',
    '$baseDir/xternal/tom_module_basics/tom_basics/lib/tom_basics.dart',
    '$baseDir/xternal/tom_module_crypto/tom_crypto/lib/tom_crypto.dart',
  ];

  print('Finding all annotations in tom_* packages...\n');

  // Create config with all entry points
  final config = ReflectionConfig.fromMap({
    'entry_points': entryPoints,
    'dependency_config': {
      'type_annotations': {
        'enabled': true,
        'transitive': true,
        'external': true,
        'include_argument_types': true,
        'scan_marked_types': true,
      },
    },
  });

  // Analyze
  final analyzer = EntryPointAnalyzer(config);
  final result = await analyzer.analyze();

  // Collect all annotations
  final annotationUsages = <String, AnnotationUsage>{};

  // Process classes
  for (final cls in result.classes) {
    _collectAnnotations(cls, 'class', annotationUsages, packageFilter);

    // Process class members
    for (final field in cls.fields) {
      _collectAnnotations(field, 'field', annotationUsages, packageFilter,
          parent: cls.name);
    }
    for (final method in cls.methods) {
      _collectAnnotations(method, 'method', annotationUsages, packageFilter,
          parent: cls.name);
    }
    for (final getter in cls.getters) {
      _collectAnnotations(getter, 'getter', annotationUsages, packageFilter,
          parent: cls.name);
    }
    for (final setter in cls.setters) {
      _collectAnnotations(setter, 'setter', annotationUsages, packageFilter,
          parent: cls.name);
    }
    for (final ctor in cls.constructors) {
      _collectAnnotations(ctor, 'constructor', annotationUsages, packageFilter,
          parent: cls.name);
    }
  }

  // Process enums
  for (final e in result.enums) {
    _collectAnnotations(e, 'enum', annotationUsages, packageFilter);
    for (final value in e.fields.where((f) => f.isEnumConstant)) {
      _collectAnnotations(value, 'enum value', annotationUsages, packageFilter,
          parent: e.name);
    }
  }

  // Process global functions
  for (final fn in result.globalFunctions) {
    _collectAnnotations(fn, 'function', annotationUsages, packageFilter);
  }

  // Process global variables
  for (final v in result.globalVariables) {
    _collectAnnotations(v, 'variable', annotationUsages, packageFilter);
  }

  // Print results
  print('═══════════════════════════════════════════════════════════════════════════════');
  print('ANNOTATIONS FOUND (${annotationUsages.length})');
  print('═══════════════════════════════════════════════════════════════════════════════');
  print('');

  // Sort by usage count
  final sortedAnnotations = annotationUsages.entries.toList()
    ..sort((a, b) => b.value.elements.length.compareTo(a.value.elements.length));

  for (final entry in sortedAnnotations) {
    final annotation = entry.key;
    final usage = entry.value;

    print('───────────────────────────────────────────────────────────────────────────────');
    print('@$annotation (${usage.elements.length} usages)');
    print('  Source: ${usage.sourceLibrary}');
    print('───────────────────────────────────────────────────────────────────────────────');

    // Group by element kind
    final byKind = <String, List<AnnotatedElement>>{};
    for (final elem in usage.elements) {
      byKind.putIfAbsent(elem.kind, () => []).add(elem);
    }

    for (final kind in byKind.keys.toList()..sort()) {
      final elements = byKind[kind]!;
      print('  $kind (${elements.length}):');
      for (final elem in elements.take(10)) {
        // Limit output
        print('    - ${elem.qualifiedName}');
      }
      if (elements.length > 10) {
        print('    ... and ${elements.length - 10} more');
      }
    }
    print('');
  }

  // Summary
  print('═══════════════════════════════════════════════════════════════════════════════');
  print('SUMMARY');
  print('═══════════════════════════════════════════════════════════════════════════════');
  print('Total annotations found: ${annotationUsages.length}');
  print('Total usages: ${annotationUsages.values.fold<int>(0, (sum, u) => sum + u.elements.length)}');

  // Top 10 most used
  print('');
  print('Top 10 most used annotations:');
  for (final entry in sortedAnnotations.take(10)) {
    print('  @${entry.key}: ${entry.value.elements.length} usages');
  }
}

void _collectAnnotations(
  Element element,
  String kind,
  Map<String, AnnotationUsage> usages,
  String? packageFilter, {
  String? parent,
}) {
  // Apply package filter
  if (packageFilter != null) {
    final lib = element.library;
    if (lib == null) return;
    final uri = lib.firstFragment.source.uri.toString();
    if (!uri.contains(packageFilter)) return;
  }

  for (final annotation in element.metadata.annotations) {
    final annotationElement = annotation.element;
    if (annotationElement == null) continue;

    String? annotationName;
    String? sourceLibrary;

    if (annotationElement is ConstructorElement) {
      // Class-based annotation like @TomComponent()
      final cls = annotationElement.enclosingElement;
      annotationName = cls.name;
      sourceLibrary = cls.library.firstFragment.source.uri.toString();
    } else if (annotationElement is PropertyAccessorElement) {
      // Const variable annotation like @override, @deprecated
      annotationName = annotationElement.name;
      sourceLibrary = annotationElement.library.firstFragment.source.uri.toString();
    }

    if (annotationName == null) continue;

    // Get or create usage record
    final usage = usages.putIfAbsent(
      annotationName,
      () => AnnotationUsage(
        name: annotationName!,
        sourceLibrary: sourceLibrary ?? 'unknown',
      ),
    );

    // Create qualified name
    final qualifiedName = parent != null ? '$parent.${element.name}' : element.name ?? '<unnamed>';

    usage.elements.add(AnnotatedElement(
      name: element.name ?? '<unnamed>',
      qualifiedName: qualifiedName,
      kind: kind,
      library: element.library?.firstFragment.source.uri.toString() ?? 'unknown',
    ));
  }
}

class AnnotationUsage {
  final String name;
  final String sourceLibrary;
  final List<AnnotatedElement> elements = [];

  AnnotationUsage({required this.name, required this.sourceLibrary});
}

class AnnotatedElement {
  final String name;
  final String qualifiedName;
  final String kind;
  final String library;

  AnnotatedElement({
    required this.name,
    required this.qualifiedName,
    required this.kind,
    required this.library,
  });
}

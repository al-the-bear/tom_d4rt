// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

/// Extracts the public API from the analyzer's AST library.
Future<void> main(List<String> args) async {
  // Find the analyzer package in pub cache
  final home = Platform.environment['HOME']!;
  final analyzerPath = '$home/.pub-cache/hosted/pub.dev/analyzer-8.4.1';
  final astFile = '$analyzerPath/lib/dart/ast/ast.dart';

  if (!File(astFile).existsSync()) {
    print('Error: Could not find analyzer AST file at $astFile');
    exit(1);
  }

  print('Analyzing: $astFile');

  final collection = AnalysisContextCollection(
    includedPaths: [analyzerPath],
    resourceProvider: PhysicalResourceProvider.INSTANCE,
  );

  final context = collection.contextFor(astFile);
  final result = await context.currentSession.getResolvedLibrary(astFile);

  if (result is! ResolvedLibraryResult) {
    print('Error: Could not resolve library');
    exit(1);
  }

  final library = result.element;

  // Collect all exported types from the library export namespace.
  final exportedTypes = <String, Map<String, dynamic>>{};
  final exportNamespace = library.exportNamespace;

  for (final entry in exportNamespace.definedNames2.entries) {
    final name = entry.key;
    final element = entry.value;
    if (name.isEmpty) continue;
    if (element is InterfaceElement) {
      // Skip implementation classes
      if (name.endsWith('Impl')) continue;

      exportedTypes[name] = _extractTypeInfo(element);
    }
  }

  // Sort by name
  final sortedTypes = Map.fromEntries(
    exportedTypes.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
  );

  // Output as JSON
  final output = {
    'totalTypes': sortedTypes.length,
    'types': sortedTypes,
  };

  final outputPath = args.isNotEmpty ? args[0] : '/tmp/analyzer_ast_api.json';
  await File(outputPath).writeAsString(
    const JsonEncoder.withIndent('  ').convert(output),
  );

  print('Extracted ${sortedTypes.length} types to $outputPath');

  // Print summary
  print('\nType counts by kind:');
  final abstractCount =
      sortedTypes.values.where((t) => t['isAbstract'] == true).length;
  final sealedCount =
      sortedTypes.values.where((t) => t['isSealed'] == true).length;
  final concreteCount = sortedTypes.values
      .where((t) => t['isAbstract'] != true && t['isSealed'] != true)
      .length;

  print('  Abstract: $abstractCount');
  print('  Sealed: $sealedCount');
  print('  Concrete: $concreteCount');
}

Map<String, dynamic> _extractTypeInfo(InterfaceElement element) {
  final info = <String, dynamic>{
    'name': element.name,
    'kind': element is ClassElement
        ? 'class'
        : element is MixinElement
            ? 'mixin'
            : element is EnumElement
                ? 'enum'
                : 'interface',
    'isAbstract': element is ClassElement && element.isAbstract,
    'isSealed': element is ClassElement && element.isSealed,
  };

  // Get superclass
  if (element is ClassElement && element.supertype != null) {
    final supertype = element.supertype!;
    final superName = supertype.element.name;
    if (superName != 'Object') {
      info['superclass'] = superName;
    }
  }

  // Get interfaces
  if (element.interfaces.isNotEmpty) {
    info['interfaces'] = element.interfaces
        .map((i) => i.element.name)
        .where((n) => n != 'Object')
        .toList();
  }

  // Get mixins
  if (element is ClassElement && element.mixins.isNotEmpty) {
    info['mixins'] =
        element.mixins.map((m) => m.element.name).whereType<String>().toList();
  }

  // Get type parameters
  if (element.typeParameters.isNotEmpty) {
    info['typeParameters'] = element.typeParameters.map((tp) {
      final result = <String, dynamic>{'name': tp.name};
      if (tp.bound != null) {
        result['bound'] = _typeToString(tp.bound!);
      }
      return result;
    }).toList();
  }

  // Get public getters
  final getters = element.getters
      .where((g) => g.isPublic)
      .map((g) => {
            'name': g.name,
            'type': _typeToString(g.returnType),
          })
      .toList();
  if (getters.isNotEmpty) {
    info['getters'] = getters;
  }

  // Get public setters
    final setters = element.setters
      .where((s) => s.isPublic)
      .map((s) => {
            'name': s.displayName.replaceAll('=', ''),
            'type': s.formalParameters.isNotEmpty
                ? _typeToString(s.formalParameters.first.type)
                : 'dynamic',
          })
      .toList();
  if (setters.isNotEmpty) {
    info['setters'] = setters;
  }

  // Get public methods
    final methods = element.methods
      .where((m) => m.isPublic && !m.isStatic)
      .map((m) => {
      'name': m.name,
            'returnType': _typeToString(m.returnType),
            'parameters': m.formalParameters.map((p) => {
        'name': p.name,
                  'type': _typeToString(p.type),
                  'isRequired': p.isRequired,
                  'isNamed': p.isNamed,
                }).toList(),
          })
      .toList();
  if (methods.isNotEmpty) {
    info['methods'] = methods;
  }

  return info;
}

String _typeToString(DartType type) {
  if (type is InterfaceType) {
    final name = type.element.name ?? 'dynamic';
    if (type.typeArguments.isEmpty) {
      return name;
    }
    final args = type.typeArguments.map(_typeToString).join(', ');
    return '$name<$args>';
  }
  if (type is TypeParameterType) {
    return type.element.name ?? 'T';
  }
  if (type is FunctionType) {
    final params =
        type.formalParameters.map((p) => _typeToString(p.type)).join(', ');
    return '${_typeToString(type.returnType)} Function($params)';
  }
  return type.getDisplayString();
}

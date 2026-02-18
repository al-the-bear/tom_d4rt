/// Extracts the element API from the analyzer package to document
/// all element types, their methods, getters, and properties.
///
/// This script uses the Dart analyzer to analyze the analyzer package itself
/// and extract information about its element.dart API.

library;

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as p;

void main(List<String> args) async {
  // Find the analyzer package location
  final pubCacheDir = Platform.environment['PUB_CACHE'] ?? 
      '${Platform.environment['HOME']}/.pub-cache';
  
  // Find the latest analyzer version
  final analyzerDir = Directory('$pubCacheDir/hosted/pub.dev');
  final analyzerPackages = analyzerDir
      .listSync()
      .whereType<Directory>()
      .where((d) => p.basename(d.path).startsWith('analyzer-8'))
      .toList();
  
  if (analyzerPackages.isEmpty) {
    print('Could not find analyzer 8.x package in pub cache');
    exit(1);
  }
  
  // Sort to get the latest version
  analyzerPackages.sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));
  final analyzerPackagePath = analyzerPackages.last.path;
  print('Using analyzer package at: $analyzerPackagePath');
  
  // Path to the element.dart file (the main API file)
  final elementDartPath = '$analyzerPackagePath/lib/dart/element/element.dart';
  
  if (!File(elementDartPath).existsSync()) {
    print('Could not find element.dart at: $elementDartPath');
    exit(1);
  }
  
  print('Analyzing: $elementDartPath');
  
  // Create analysis context
  final collection = AnalysisContextCollection(
    includedPaths: [analyzerPackagePath],
  );
  
  final context = collection.contextFor(elementDartPath);
  final session = context.currentSession;
  
  // Resolve the library
  final libraryResult = await session.getResolvedLibrary(elementDartPath);
  
  if (libraryResult is! ResolvedLibraryResult) {
    print('Failed to resolve element.dart');
    exit(1);
  }
  
  final library = libraryResult.element;
  print('Library: ${library.displayName}');
  print('URI: ${library.firstFragment.source.uri}');
  print('');
  
  // Collect all types
  final apiInfo = <String, ApiTypeInfo>{};
  
  // Process classes
  for (final classElement in library.classes) {
    apiInfo[classElement.displayName] = _extractClassInfo(classElement);
  }
  
  // Process mixins
  for (final mixinElement in library.mixins) {
    apiInfo[mixinElement.displayName] = _extractMixinInfo(mixinElement);
  }
  
  // Process enums
  for (final enumElement in library.enums) {
    apiInfo[enumElement.displayName] = _extractEnumInfo(enumElement);
  }
  
  // Process extension types
  for (final extensionType in library.extensionTypes) {
    apiInfo[extensionType.displayName] = _extractExtensionTypeInfo(extensionType);
  }
  
  // Sort by type name
  final sortedNames = apiInfo.keys.toList()..sort();
  
  // Print summary
  print('=== ANALYZER ELEMENT API SUMMARY ===');
  print('Total types: ${apiInfo.length}');
  print('');
  
  // Categorize types
  final elements = <String>[];
  final fragments = <String>[];
  final visitors = <String>[];
  final others = <String>[];
  
  for (final name in sortedNames) {
    if (name.endsWith('Element')) {
      elements.add(name);
    } else if (name.endsWith('Fragment')) {
      fragments.add(name);
    } else if (name.contains('Visitor')) {
      visitors.add(name);
    } else {
      others.add(name);
    }
  }
  
  print('Element types: ${elements.length}');
  print('Fragment types: ${fragments.length}');
  print('Visitor types: ${visitors.length}');
  print('Other types: ${others.length}');
  print('');
  
  // Output detailed API
  final buffer = StringBuffer();
  buffer.writeln('# Dart Analyzer 8.x Element API');
  buffer.writeln('');
  buffer.writeln('Extracted from: ${library.firstFragment.source.uri}');
  buffer.writeln('');
  buffer.writeln('## Summary');
  buffer.writeln('');
  buffer.writeln('- Total types: ${apiInfo.length}');
  buffer.writeln('- Element types: ${elements.length}');
  buffer.writeln('- Fragment types: ${fragments.length}');
  buffer.writeln('- Visitor types: ${visitors.length}');
  buffer.writeln('- Other types: ${others.length}');
  buffer.writeln('');
  
  // Element types
  buffer.writeln('## Element Types');
  buffer.writeln('');
  for (final name in elements) {
    _writeTypeInfo(buffer, name, apiInfo[name]!);
  }
  
  // Fragment types
  buffer.writeln('## Fragment Types');
  buffer.writeln('');
  for (final name in fragments) {
    _writeTypeInfo(buffer, name, apiInfo[name]!);
  }
  
  // Visitor types
  buffer.writeln('## Visitor Types');
  buffer.writeln('');
  for (final name in visitors) {
    _writeTypeInfo(buffer, name, apiInfo[name]!);
  }
  
  // Other types
  buffer.writeln('## Other Types');
  buffer.writeln('');
  for (final name in others) {
    _writeTypeInfo(buffer, name, apiInfo[name]!);
  }
  
  // Write to file
  final outputPath = p.join(
    p.dirname(p.dirname(Platform.script.toFilePath())),
    'doc',
    'analyzer_element_api.md',
  );
  
  File(outputPath).writeAsStringSync(buffer.toString());
  print('Wrote API documentation to: $outputPath');
  
  // Also output a JSON summary
  final jsonBuffer = StringBuffer();
  jsonBuffer.writeln('{');
  jsonBuffer.writeln('  "totalTypes": ${apiInfo.length},');
  jsonBuffer.writeln('  "elements": ${elements.length},');
  jsonBuffer.writeln('  "fragments": ${fragments.length},');
  jsonBuffer.writeln('  "visitors": ${visitors.length},');
  jsonBuffer.writeln('  "others": ${others.length},');
  jsonBuffer.writeln('  "types": {');
  
  var first = true;
  for (final name in sortedNames) {
    if (!first) jsonBuffer.writeln(',');
    first = false;
    final info = apiInfo[name]!;
    jsonBuffer.write('    "$name": {');
    jsonBuffer.write('"kind": "${info.kind}", ');
    jsonBuffer.write('"methods": ${info.methods.length}, ');
    jsonBuffer.write('"getters": ${info.getters.length}, ');
    jsonBuffer.write('"fields": ${info.fields.length}');
    jsonBuffer.write('}');
  }
  
  jsonBuffer.writeln('');
  jsonBuffer.writeln('  }');
  jsonBuffer.writeln('}');
  
  final jsonOutputPath = p.join(
    p.dirname(p.dirname(Platform.script.toFilePath())),
    'doc',
    'analyzer_element_api.json',
  );
  
  File(jsonOutputPath).writeAsStringSync(jsonBuffer.toString());
  print('Wrote API summary to: $jsonOutputPath');
}

void _writeTypeInfo(StringBuffer buffer, String name, ApiTypeInfo info) {
  buffer.writeln('### $name');
  buffer.writeln('');
  buffer.writeln('**Kind:** ${info.kind}');
  if (info.superclass != null) {
    buffer.writeln('**Superclass:** ${info.superclass}');
  }
  if (info.interfaces.isNotEmpty) {
    buffer.writeln('**Implements:** ${info.interfaces.join(', ')}');
  }
  if (info.mixins.isNotEmpty) {
    buffer.writeln('**With:** ${info.mixins.join(', ')}');
  }
  buffer.writeln('');
  
  if (info.fields.isNotEmpty) {
    buffer.writeln('**Fields:**');
    for (final field in info.fields) {
      buffer.writeln('- `$field`');
    }
    buffer.writeln('');
  }
  
  if (info.getters.isNotEmpty) {
    buffer.writeln('**Getters:**');
    for (final getter in info.getters) {
      buffer.writeln('- `$getter`');
    }
    buffer.writeln('');
  }
  
  if (info.setters.isNotEmpty) {
    buffer.writeln('**Setters:**');
    for (final setter in info.setters) {
      buffer.writeln('- `$setter`');
    }
    buffer.writeln('');
  }
  
  if (info.methods.isNotEmpty) {
    buffer.writeln('**Methods:**');
    for (final method in info.methods) {
      buffer.writeln('- `$method`');
    }
    buffer.writeln('');
  }
  
  buffer.writeln('---');
  buffer.writeln('');
}

ApiTypeInfo _extractClassInfo(ClassElement element) {
  return ApiTypeInfo(
    kind: element.isAbstract ? 'abstract class' : 'class',
    superclass: element.supertype?.element.displayName,
    interfaces: element.interfaces.map((i) => i.element.displayName).toList(),
    mixins: element.mixins.map((m) => m.element.displayName).toList(),
    fields: _extractFields(element),
    getters: _extractGetters(element),
    setters: _extractSetters(element),
    methods: _extractMethods(element),
  );
}

ApiTypeInfo _extractMixinInfo(MixinElement element) {
  return ApiTypeInfo(
    kind: 'mixin',
    superclass: null,
    interfaces: element.interfaces.map((i) => i.element.displayName).toList(),
    mixins: [],
    fields: _extractMixinFields(element),
    getters: _extractMixinGetters(element),
    setters: _extractMixinSetters(element),
    methods: _extractMixinMethods(element),
  );
}

ApiTypeInfo _extractEnumInfo(EnumElement element) {
  return ApiTypeInfo(
    kind: 'enum',
    superclass: null,
    interfaces: element.interfaces.map((i) => i.element.displayName).toList(),
    mixins: element.mixins.map((m) => m.element.displayName).toList(),
    fields: element.fields.where((f) => f.isEnumConstant).map((f) => f.displayName).toList(),
    getters: _extractEnumGetters(element),
    setters: [],
    methods: _extractEnumMethods(element),
  );
}

ApiTypeInfo _extractExtensionTypeInfo(ExtensionTypeElement element) {
  return ApiTypeInfo(
    kind: 'extension type',
    superclass: null,
    interfaces: element.interfaces.map((i) => i.element.displayName).toList(),
    mixins: [],
    fields: element.fields.map((f) => '${f.type.getDisplayString()} ${f.displayName}').toList(),
    getters: element.getters.map((g) => '${g.returnType.getDisplayString()} get ${g.displayName}').toList(),
    setters: element.setters.map((s) => 'set ${s.displayName}').toList(),
    methods: element.methods.map((m) => _formatMethod(m)).toList(),
  );
}

List<String> _extractFields(ClassElement element) {
  return element.fields
      .where((f) => !f.isStatic && !f.isSynthetic)
      .map((f) => '${f.type.getDisplayString()} ${f.displayName}')
      .toList();
}

List<String> _extractGetters(ClassElement element) {
  return element.getters
      .where((g) => !g.isStatic && !g.isSynthetic)
      .map((g) => '${g.returnType.getDisplayString()} get ${g.displayName}')
      .toList();
}

List<String> _extractSetters(ClassElement element) {
  return element.setters
      .where((s) => !s.isStatic && !s.isSynthetic)
      .map((s) => 'set ${s.displayName}')
      .toList();
}

List<String> _extractMethods(ClassElement element) {
  return element.methods
      .where((m) => !m.isStatic && !m.isSynthetic)
      .map((m) => _formatMethod(m))
      .toList();
}

List<String> _extractMixinFields(MixinElement element) {
  return element.fields
      .where((f) => !f.isStatic && !f.isSynthetic)
      .map((f) => '${f.type.getDisplayString()} ${f.displayName}')
      .toList();
}

List<String> _extractMixinGetters(MixinElement element) {
  return element.getters
      .where((g) => !g.isStatic && !g.isSynthetic)
      .map((g) => '${g.returnType.getDisplayString()} get ${g.displayName}')
      .toList();
}

List<String> _extractMixinSetters(MixinElement element) {
  return element.setters
      .where((s) => !s.isStatic && !s.isSynthetic)
      .map((s) => 'set ${s.displayName}')
      .toList();
}

List<String> _extractMixinMethods(MixinElement element) {
  return element.methods
      .where((m) => !m.isStatic && !m.isSynthetic)
      .map((m) => _formatMethod(m))
      .toList();
}

List<String> _extractEnumGetters(EnumElement element) {
  return element.getters
      .where((g) => !g.isStatic && !g.isSynthetic)
      .map((g) => '${g.returnType.getDisplayString()} get ${g.displayName}')
      .toList();
}

List<String> _extractEnumMethods(EnumElement element) {
  return element.methods
      .where((m) => !m.isStatic && !m.isSynthetic)
      .map((m) => _formatMethod(m))
      .toList();
}

String _formatMethod(MethodElement method) {
  final params = method.formalParameters.map((p) {
    final type = p.type.getDisplayString();
    final name = p.displayName;
    if (p.isNamed) {
      if (p.isRequired) {
        return 'required $type $name';
      }
      return '$type $name';
    }
    return '$type $name';
  }).join(', ');
  
  final returnType = method.returnType.getDisplayString();
  return '$returnType ${method.displayName}($params)';
}

class ApiTypeInfo {
  final String kind;
  final String? superclass;
  final List<String> interfaces;
  final List<String> mixins;
  final List<String> fields;
  final List<String> getters;
  final List<String> setters;
  final List<String> methods;
  
  ApiTypeInfo({
    required this.kind,
    this.superclass,
    required this.interfaces,
    required this.mixins,
    required this.fields,
    required this.getters,
    required this.setters,
    required this.methods,
  });
}

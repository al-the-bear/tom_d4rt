/// Script to run the reflection generator on tom_uam_server and all tom_* dependencies.
///
/// Run with: dart run tool/run_uam_reflection.dart
/// For tabular output: dart run tool/run_uam_reflection.dart --tabular
library;

import 'dart:io';

import 'package:tom_analyzer/src/reflection/generator/reflection_generator.dart';
import 'package:tom_analyzer/src/reflection/generator/reflection_config.dart';

void main(List<String> args) async {
  final tabularMode = args.contains('--tabular');
  final saveCode = args.contains('--save');
  final baseDir = '/Users/alexiskyaw/Desktop/Code/tom2';

  // Entry points from each tom_* package - same as analyze_uam_full.dart
  final entryPoints = [
    '$baseDir/uam/tom_uam_server/bin/aa_server_start.dart',
    '$baseDir/uam/tom_uam_codespec/lib/tom_uam_codespec.dart',
    '$baseDir/core/tom_core_kernel/lib/tom_core_kernel.dart',
    '$baseDir/xternal/tom_module_reflection/tom_reflection/lib/tom_reflection.dart',
    '$baseDir/xternal/tom_module_basics/tom_basics/lib/tom_basics.dart',
    '$baseDir/xternal/tom_module_basics/tom_crypto/lib/tom_crypto.dart',
  ];

  if (!tabularMode) {
    print('Running reflection generator on tom_uam_server and all tom_* dependencies...\n');
  }

  // Create config with all entry points and enhanced dependency tracking
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
      'marker_annotations': {
        'enabled': true,
        'marker_annotations': ['tomReflection', 'TomReflectionInfo'],
        'follow_annotation_chains': true,
      },
    },
  });

  // Run the reflection generator
  final generator = ReflectionGenerator(config);
  final analysisResult = await generator.analyze();
  
  if (!tabularMode) {
    print('Analysis complete.');
    print('  Classes: ${analysisResult.classes.length}');
    print('  Enums: ${analysisResult.enums.length}');
    print('  Mixins: ${analysisResult.mixins.length}');
    print('  Extensions: ${analysisResult.extensions.length}');
    print('  Global functions: ${analysisResult.globalFunctions.length}');
    print('  Global variables: ${analysisResult.globalVariables.length}');
    print('');
    print('Generating reflection code...');
  }
  
  final generatedCode = await generator.generate();
  
  if (!tabularMode) {
    print('Generation complete.');
    print('  Generated code size: ${generatedCode.length} characters');
    print('  Generated code lines: ${generatedCode.split('\n').length}');
  }
  
  // Save the generated code if requested
  if (saveCode) {
    final outFile = File('$baseDir/xternal/tom_module_basics/tom_analyzer/doc/uam_generated.r.dart');
    await outFile.writeAsString(generatedCode);
    if (!tabularMode) {
      print('  Saved to: ${outFile.path}');
    }
  }
  
  // Use analysisResult for the tabular output
  final result = analysisResult;

  if (!tabularMode) {
    print('Reflection generation complete.\n');
    print('Found:');
    print('  Classes: ${result.classes.length}');
    print('  Enums: ${result.enums.length}');
    print('  Mixins: ${result.mixins.length}');
    print('  Extensions: ${result.extensions.length}');
    print('  Global functions: ${result.globalFunctions.length}');
    print('  Global variables: ${result.globalVariables.length}');
    print('');
  }

  // Print tabular output
  // Global Functions
  print('');
  print('GLOBAL FUNCTIONS (${result.globalFunctions.length})');
  for (final fn in result.globalFunctions) {
    print(fn.name);
  }

  // Global Variables
  print('');
  print('GLOBAL VARIABLES (${result.globalVariables.length})');
  for (final v in result.globalVariables) {
    final mods = <String>[];
    if (v.isFinal) mods.add('final');
    if (v.isConst) mods.add('const');
    final modStr = mods.isNotEmpty ? ' [${mods.join(', ')}]' : '';
    print('${v.name}$modStr');
  }

  // Enums
  print('');
  print('ENUMS (${result.enums.length})');
  for (final e in result.enums) {
    print(e.name);
  }

  // Mixins
  print('');
  print('MIXINS (${result.mixins.length})');
  for (final m in result.mixins) {
    print(m.name);
  }

  // Extensions
  print('');
  print('EXTENSIONS (${result.extensions.length})');
  for (final ext in result.extensions) {
    print(ext.name);
  }

  // Classes
  print('');
  print('CLASSES (${result.classes.length})');
  print('name,constructors,methods,fields,getters,setters');
  for (final cls in result.classes) {
    final ctors = cls.constructors.length;
    final methods = cls.methods.length;
    final fields = cls.fields.length;
    final getters = cls.getters.length;
    final setters = cls.setters.length;
    print('${cls.name},$ctors,$methods,$fields,$getters,$setters');
  }
}

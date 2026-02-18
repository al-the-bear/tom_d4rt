/// Script to generate reflection and print cross-reference.
///
/// Run with: dart run tool/run_cross_reference.dart
/// For tabular output: dart run tool/run_cross_reference.dart --tabular
library;

import 'package:tom_analyzer/src/reflection/generator/entry_point_analyzer.dart';
import 'package:tom_analyzer/src/reflection/generator/reflection_config.dart';

void main(List<String> args) async {
  final tabularMode = args.contains('--tabular');

  if (!tabularMode) {
    print('Analyzing tom_uam_server with annotation discovery...\n');
  }

  // Create config for tom_uam_server with enhanced dependency tracking
  final config = ReflectionConfig.fromMap({
    'entry_points': [
      '/Users/alexiskyaw/Desktop/Code/tom2/uam/tom_uam_server/bin/aa_server_start.dart'
    ],
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

  // Analyze
  final analyzer = EntryPointAnalyzer(config);
  final result = await analyzer.analyze();

  // Tabular mode: simple one-line-per-element output
  if (tabularMode) {
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
      final className = cls.name ?? '<unnamed>';
      final ctors = cls.constructors.length;
      final methods = cls.methods.length;
      final fields = cls.fields.length;
      final getters = cls.getters.length;
      final setters = cls.setters.length;
      print('$className,$ctors,$methods,$fields,$getters,$setters');
    }
    return;
  }

  print('Analysis complete.');
  print('  Classes: ${result.classes.length}');
  print('  Enums: ${result.enums.length}');
  print('  Mixins: ${result.mixins.length}');
  print('  Extensions: ${result.extensions.length}');
  print('  Global functions: ${result.globalFunctions.length}');
  print('  Global variables: ${result.globalVariables.length}');
  print('');

  // Print cross-reference
  print('╔══════════════════════════════════════════════════════════════════════════════╗');
  print('║                     REFLECTION CROSS-REFERENCE                              ║');
  print('║                  (from EntryPointAnalyzer results)                          ║');
  print('╚══════════════════════════════════════════════════════════════════════════════╝');
  print('');

  // Global Members
  print('┌──────────────────────────────────────────────────────────────────────────────┐');
  print('│ GLOBAL MEMBERS                                                              │');
  print('└──────────────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Global Functions (${result.globalFunctions.length}):');
  for (final fn in result.globalFunctions) {
    print('  • ${fn.name}');
  }
  print('');

  print('Global Variables (${result.globalVariables.length}):');
  for (final v in result.globalVariables) {
    final mods = <String>[];
    if (v.isFinal) mods.add('final');
    if (v.isConst) mods.add('const');
    final modStr = mods.isNotEmpty ? ' [${mods.join(', ')}]' : '';
    print('  • ${v.name}$modStr');
  }
  print('');

  // Classes
  print('┌──────────────────────────────────────────────────────────────────────────────┐');
  print('│ CLASSES                                                                     │');
  print('└──────────────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Class Summary (${result.classes.length} total):');
  print('');
  print('  ${'Class Name'.padRight(25)} │ Ctors │ Meth  │ Flds  │ Gets  │ Sets');
  print('  ${'─' * 25}─┼───────┼───────┼───────┼───────┼───────');

  int totalCtors = 0;
  int totalMethods = 0;
  int totalFields = 0;
  int totalGetters = 0;
  int totalSetters = 0;

  for (final cls in result.classes) {
    final className = cls.name ?? '<unnamed>';
    final ctors = cls.constructors.length;
    final methods = cls.methods.length;
    final fields = cls.fields.length;
    final getters = cls.getters.length;
    final setters = cls.setters.length;

    totalCtors += ctors;
    totalMethods += methods;
    totalFields += fields;
    totalGetters += getters;
    totalSetters += setters;

    final name = className.length > 25
      ? '${className.substring(0, 22)}...'
      : className;

    print(
        '  ${name.padRight(25)} │ ${ctors.toString().padLeft(5)} │ ${methods.toString().padLeft(5)} │ ${fields.toString().padLeft(5)} │ ${getters.toString().padLeft(5)} │ ${setters.toString().padLeft(5)}');
  }
  print('  ${'─' * 25}─┼───────┼───────┼───────┼───────┼───────');
  print(
      '  ${'TOTAL'.padRight(25)} │ ${totalCtors.toString().padLeft(5)} │ ${totalMethods.toString().padLeft(5)} │ ${totalFields.toString().padLeft(5)} │ ${totalGetters.toString().padLeft(5)} │ ${totalSetters.toString().padLeft(5)}');
  print('');

  // Class details
  for (final cls in result.classes) {
    final modifiers = <String>[];
    if (cls.isAbstract) modifiers.add('abstract');
    final modStr = modifiers.isNotEmpty ? '(${modifiers.join(', ')}) ' : '';

    print('  $modStr${cls.name}:');

    if (cls.constructors.isNotEmpty) {
      print(
          '    Constructors: ${cls.constructors.map((c) => (c.name?.isEmpty ?? true) ? '(default)' : c.name).join(', ')}');
    }
    if (cls.methods.isNotEmpty) {
      print('    Methods: ${cls.methods.map((m) => m.name).join(', ')}');
    }
    if (cls.fields.isNotEmpty) {
      print('    Fields: ${cls.fields.map((f) => f.name).join(', ')}');
    }
    final getterNames = cls.getters.map((g) => g.name);
    if (getterNames.isNotEmpty) {
      print('    Getters: ${getterNames.join(', ')}');
    }
    print('');
  }

  // Enums
  print('┌──────────────────────────────────────────────────────────────────────────────┐');
  print('│ ENUMS                                                                       │');
  print('└──────────────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Enums (${result.enums.length} total):');
  for (final enm in result.enums) {
    final values = enm.fields.where((f) => f.isEnumConstant).map((f) => f.name);
    print('  • ${enm.name}: ${values.join(', ')}');
  }
  print('');

  // Mixins
  print('┌──────────────────────────────────────────────────────────────────────────────┐');
  print('│ MIXINS                                                                      │');
  print('└──────────────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Mixins (${result.mixins.length} total):');
  for (final mixin in result.mixins) {
    print('  • ${mixin.name}');
    if (mixin.methods.isNotEmpty) {
      print('    Methods: ${mixin.methods.map((m) => m.name).join(', ')}');
    }
    if (mixin.fields.isNotEmpty) {
      print('    Fields: ${mixin.fields.map((f) => f.name).join(', ')}');
    }
  }
  print('');

  // Extensions
  print('┌──────────────────────────────────────────────────────────────────────────────┐');
  print('│ EXTENSIONS                                                                  │');
  print('└──────────────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Extensions (${result.extensions.length} total):');
  for (final ext in result.extensions) {
    final onType = ext.extendedType;
    print('  • ${ext.name ?? '(unnamed)'} on $onType');
    if (ext.methods.isNotEmpty) {
      print('    Methods: ${ext.methods.map((m) => m.name).join(', ')}');
    }
    final getterNames = ext.getters.map((g) => g.name);
    if (getterNames.isNotEmpty) {
      print('    Getters: ${getterNames.join(', ')}');
    }
  }
  print('');

  // Grand totals
  print('╔══════════════════════════════════════════════════════════════════════════════╗');
  print('║                              GRAND TOTALS                                   ║');
  print('╚══════════════════════════════════════════════════════════════════════════════╝');
  print('');

  final totalTypes = result.classes.length +
      result.enums.length +
      result.mixins.length +
      result.extensions.length;

  print('Types:');
  print('  • Classes:    ${result.classes.length}');
  print('  • Enums:      ${result.enums.length}');
  print('  • Mixins:     ${result.mixins.length}');
  print('  • Extensions: ${result.extensions.length}');
  print('  ─────────────────────────');
  print('  TOTAL TYPES:  $totalTypes');
  print('');

  print('Global Members:');
  print('  • Functions:  ${result.globalFunctions.length}');
  print('  • Variables:  ${result.globalVariables.length}');
  print('');

  print('Class Members (across all classes):');
  print('  • Constructors: $totalCtors');
  print('  • Methods:      $totalMethods');
  print('  • Fields:       $totalFields');
  print('  • Getters:      $totalGetters');
  print('  • Setters:      $totalSetters');
  print('  ─────────────────────────');
  print(
      '  TOTAL:          ${totalCtors + totalMethods + totalFields + totalGetters + totalSetters}');
  print('');

  final grandTotal = totalTypes +
      result.globalFunctions.length +
      result.globalVariables.length +
      totalCtors +
      totalMethods +
      totalFields +
      totalGetters +
      totalSetters;

  print('═══════════════════════════════════════════════════════════════════════════════');
  print('                    GRAND TOTAL ELEMENTS: $grandTotal');
  print('═══════════════════════════════════════════════════════════════════════════════');
}

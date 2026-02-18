/// Cross-reference utility for ReflectionAPI.
///
/// Prints a comprehensive summary of all types and members
/// found in a generated reflection file.
library;

import 'package:tom_analyzer/reflection_runtime.dart';

/// Print a cross-reference of the ReflectionAPI's content.
///
/// Lists all types and members with counts.
void printReflectionCrossReference(ReflectionApi api) {
  final buffer = StringBuffer();

  // Gather totals
  int totalClasses = 0;
  int totalEnums = 0;
  int totalMixins = 0;
  int totalExtensions = 0;
  int totalExtensionTypes = 0;
  int totalTypeAliases = 0;
  int totalGlobalMethods = 0;
  int totalGlobalFields = 0;
  int totalGlobalGetters = 0;
  int totalGlobalSetters = 0;

  // Aggregate class member counts
  int totalInstanceMethods = 0;
  int totalStaticMethods = 0;
  int totalInstanceFields = 0;
  int totalStaticFields = 0;
  int totalConstructors = 0;

  buffer.writeln(
    '╔══════════════════════════════════════════════════════════════════════════════╗',
  );
  buffer.writeln(
    '║                     REFLECTION API CROSS-REFERENCE                          ║',
  );
  buffer.writeln(
    '╚══════════════════════════════════════════════════════════════════════════════╝',
  );
  buffer.writeln();

  // ═══════════════════════════════════════════════════════════════════════════
  // GLOBAL MEMBERS
  // ═══════════════════════════════════════════════════════════════════════════
  buffer.writeln(
    '┌──────────────────────────────────────────────────────────────────────────────┐',
  );
  buffer.writeln(
    '│ GLOBAL MEMBERS                                                              │',
  );
  buffer.writeln(
    '└──────────────────────────────────────────────────────────────────────────────┘',
  );
  buffer.writeln();

  // Global methods
  final globalMethods = api.allGlobalMethods;
  totalGlobalMethods = globalMethods.length;
  buffer.writeln('Global Functions ($totalGlobalMethods):');
  if (globalMethods.isNotEmpty) {
    for (final method in globalMethods) {
      buffer.writeln('  • ${method.name}');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // Global fields
  final globalFields = api.allGlobalFields;
  totalGlobalFields = globalFields.length;
  buffer.writeln('Global Fields ($totalGlobalFields):');
  if (globalFields.isNotEmpty) {
    for (final field in globalFields) {
      final mods = <String>[];
      if (field.isFinal) mods.add('final');
      if (field.isConst) mods.add('const');
      final modStr = mods.isNotEmpty ? ' [${mods.join(', ')}]' : '';
      buffer.writeln('  • ${field.name}$modStr');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // Global getters
  final globalGetters = api.allGlobalGetters;
  totalGlobalGetters = globalGetters.length;
  buffer.writeln('Global Getters ($totalGlobalGetters):');
  if (globalGetters.isNotEmpty) {
    for (final getter in globalGetters) {
      buffer.writeln('  • ${getter.name}');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // Global setters
  final globalSetters = api.allGlobalSetters;
  totalGlobalSetters = globalSetters.length;
  buffer.writeln('Global Setters ($totalGlobalSetters):');
  if (globalSetters.isNotEmpty) {
    for (final setter in globalSetters) {
      buffer.writeln('  • ${setter.name}');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // ═══════════════════════════════════════════════════════════════════════════
  // CLASSES
  // ═══════════════════════════════════════════════════════════════════════════
  buffer.writeln(
    '┌──────────────────────────────────────────────────────────────────────────────┐',
  );
  buffer.writeln(
    '│ CLASSES                                                                     │',
  );
  buffer.writeln(
    '└──────────────────────────────────────────────────────────────────────────────┘',
  );
  buffer.writeln();

  final classes = api.allClasses;
  totalClasses = classes.length;

  // Class summary table
  buffer.writeln('Class Summary ($totalClasses total):');
  buffer.writeln('');
  buffer.writeln(
    '  ${'Class Name'.padRight(40)} │ Ctors │ iMeth │ sMeth │ iFld  │ sFld',
  );
  buffer.writeln('  ${'─' * 40}─┼───────┼───────┼───────┼───────┼───────');

  for (final cls in classes) {
    final name = cls.name.length > 40
        ? '${cls.name.substring(0, 37)}...'
        : cls.name;

    final ctorCount = cls.constructors.length;
    final instMethodCount = cls.instanceMethods.length;
    final staticMethodCount = cls.staticMethods.length;
    final instFieldCount = cls.instanceFields.length;
    final staticFieldCount = cls.staticFields.length;

    totalConstructors += ctorCount;
    totalInstanceMethods += instMethodCount;
    totalStaticMethods += staticMethodCount;
    totalInstanceFields += instFieldCount;
    totalStaticFields += staticFieldCount;

    buffer.writeln(
      '  ${name.padRight(40)} │ ${ctorCount.toString().padLeft(5)} │ ${instMethodCount.toString().padLeft(5)} │ ${staticMethodCount.toString().padLeft(5)} │ ${instFieldCount.toString().padLeft(5)} │ ${staticFieldCount.toString().padLeft(5)}',
    );
  }
  buffer.writeln('  ${'─' * 40}─┼───────┼───────┼───────┼───────┼───────');
  buffer.writeln(
    '  ${'TOTAL'.padRight(40)} │ ${totalConstructors.toString().padLeft(5)} │ ${totalInstanceMethods.toString().padLeft(5)} │ ${totalStaticMethods.toString().padLeft(5)} │ ${totalInstanceFields.toString().padLeft(5)} │ ${totalStaticFields.toString().padLeft(5)}',
  );
  buffer.writeln();

  // ═══════════════════════════════════════════════════════════════════════════
  // ENUMS
  // ═══════════════════════════════════════════════════════════════════════════
  buffer.writeln(
    '┌──────────────────────────────────────────────────────────────────────────────┐',
  );
  buffer.writeln(
    '│ ENUMS                                                                       │',
  );
  buffer.writeln(
    '└──────────────────────────────────────────────────────────────────────────────┘',
  );
  buffer.writeln();

  final enums = api.allEnums;
  totalEnums = enums.length;

  buffer.writeln('Enums ($totalEnums total):');
  if (enums.isNotEmpty) {
    for (final enm in enums) {
      buffer.writeln('  • ${enm.name}');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // ═══════════════════════════════════════════════════════════════════════════
  // MIXINS
  // ═══════════════════════════════════════════════════════════════════════════
  buffer.writeln(
    '┌──────────────────────────────────────────────────────────────────────────────┐',
  );
  buffer.writeln(
    '│ MIXINS                                                                      │',
  );
  buffer.writeln(
    '└──────────────────────────────────────────────────────────────────────────────┘',
  );
  buffer.writeln();

  final mixins = api.allMixins;
  totalMixins = mixins.length;

  buffer.writeln('Mixins ($totalMixins total):');
  if (mixins.isNotEmpty) {
    for (final mixin in mixins) {
      buffer.writeln('  • ${mixin.name}');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // ═══════════════════════════════════════════════════════════════════════════
  // EXTENSIONS
  // ═══════════════════════════════════════════════════════════════════════════
  buffer.writeln(
    '┌──────────────────────────────────────────────────────────────────────────────┐',
  );
  buffer.writeln(
    '│ EXTENSIONS                                                                  │',
  );
  buffer.writeln(
    '└──────────────────────────────────────────────────────────────────────────────┘',
  );
  buffer.writeln();

  final extensions = api.allExtensions;
  totalExtensions = extensions.length;

  buffer.writeln('Extensions ($totalExtensions total):');
  if (extensions.isNotEmpty) {
    for (final ext in extensions) {
      buffer.writeln('  • ${ext.name}');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // ═══════════════════════════════════════════════════════════════════════════
  // EXTENSION TYPES
  // ═══════════════════════════════════════════════════════════════════════════
  buffer.writeln(
    '┌──────────────────────────────────────────────────────────────────────────────┐',
  );
  buffer.writeln(
    '│ EXTENSION TYPES                                                             │',
  );
  buffer.writeln(
    '└──────────────────────────────────────────────────────────────────────────────┘',
  );
  buffer.writeln();

  final extensionTypes = api.allExtensionTypes;
  totalExtensionTypes = extensionTypes.length;

  buffer.writeln('Extension Types ($totalExtensionTypes total):');
  if (extensionTypes.isNotEmpty) {
    for (final extType in extensionTypes) {
      buffer.writeln('  • ${extType.name}');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // ═══════════════════════════════════════════════════════════════════════════
  // TYPE ALIASES
  // ═══════════════════════════════════════════════════════════════════════════
  buffer.writeln(
    '┌──────────────────────────────────────────────────────────────────────────────┐',
  );
  buffer.writeln(
    '│ TYPE ALIASES                                                                │',
  );
  buffer.writeln(
    '└──────────────────────────────────────────────────────────────────────────────┘',
  );
  buffer.writeln();

  final typeAliases = api.allTypeAliases;
  totalTypeAliases = typeAliases.length;

  buffer.writeln('Type Aliases ($totalTypeAliases total):');
  if (typeAliases.isNotEmpty) {
    for (final alias in typeAliases) {
      buffer.writeln('  • ${alias.name}');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // ═══════════════════════════════════════════════════════════════════════════
  // PACKAGES & LIBRARIES
  // ═══════════════════════════════════════════════════════════════════════════
  buffer.writeln(
    '┌──────────────────────────────────────────────────────────────────────────────┐',
  );
  buffer.writeln(
    '│ PACKAGES & LIBRARIES                                                        │',
  );
  buffer.writeln(
    '└──────────────────────────────────────────────────────────────────────────────┘',
  );
  buffer.writeln();

  final packages = api.packages;
  buffer.writeln('Packages (${packages.length} total):');
  if (packages.isNotEmpty) {
    for (final pkg in packages) {
      buffer.writeln('  • $pkg');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  final libraries = api.libraries;
  buffer.writeln('Libraries (${libraries.length} total):');
  if (libraries.isNotEmpty) {
    for (final lib in libraries) {
      buffer.writeln('  • $lib');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // ═══════════════════════════════════════════════════════════════════════════
  // GRAND TOTALS
  // ═══════════════════════════════════════════════════════════════════════════
  buffer.writeln(
    '╔══════════════════════════════════════════════════════════════════════════════╗',
  );
  buffer.writeln(
    '║                              GRAND TOTALS                                   ║',
  );
  buffer.writeln(
    '╚══════════════════════════════════════════════════════════════════════════════╝',
  );
  buffer.writeln();

  final totalTypes =
      totalClasses +
      totalEnums +
      totalMixins +
      totalExtensions +
      totalExtensionTypes +
      totalTypeAliases;
  final totalGlobalMembers =
      totalGlobalMethods +
      totalGlobalFields +
      totalGlobalGetters +
      totalGlobalSetters;
  final totalClassMembers =
      totalConstructors +
      totalInstanceMethods +
      totalStaticMethods +
      totalInstanceFields +
      totalStaticFields;

  buffer.writeln('Types:');
  buffer.writeln('  • Classes:         $totalClasses');
  buffer.writeln('  • Enums:           $totalEnums');
  buffer.writeln('  • Mixins:          $totalMixins');
  buffer.writeln('  • Extensions:      $totalExtensions');
  buffer.writeln('  • Extension Types: $totalExtensionTypes');
  buffer.writeln('  • Type Aliases:    $totalTypeAliases');
  buffer.writeln('  ─────────────────────────────');
  buffer.writeln('  TOTAL TYPES:       $totalTypes');
  buffer.writeln();

  buffer.writeln('Global Members:');
  buffer.writeln('  • Functions:       $totalGlobalMethods');
  buffer.writeln('  • Fields:          $totalGlobalFields');
  buffer.writeln('  • Getters:         $totalGlobalGetters');
  buffer.writeln('  • Setters:         $totalGlobalSetters');
  buffer.writeln('  ─────────────────────────────');
  buffer.writeln('  TOTAL GLOBAL:      $totalGlobalMembers');
  buffer.writeln();

  buffer.writeln('Class Members (across all classes):');
  buffer.writeln('  • Constructors:    $totalConstructors');
  buffer.writeln('  • Instance Methods: $totalInstanceMethods');
  buffer.writeln('  • Static Methods:  $totalStaticMethods');
  buffer.writeln('  • Instance Fields: $totalInstanceFields');
  buffer.writeln('  • Static Fields:   $totalStaticFields');
  buffer.writeln('  ─────────────────────────────');
  buffer.writeln('  TOTAL CLASS MEMBERS: $totalClassMembers');
  buffer.writeln();

  buffer.writeln('Packages:            ${packages.length}');
  buffer.writeln('Libraries:           ${libraries.length}');
  buffer.writeln();

  buffer.writeln(
    '═══════════════════════════════════════════════════════════════════════════════',
  );
  buffer.writeln(
    '                      GRAND TOTAL ELEMENTS: ${totalTypes + totalGlobalMembers + totalClassMembers}',
  );
  buffer.writeln(
    '═══════════════════════════════════════════════════════════════════════════════',
  );

  print(buffer.toString());
}

/// Print detailed class information.
void printClassDetails(ReflectionApi api, String className) {
  final cls = api.findClassByName(className);
  if (cls == null) {
    print('Class "$className" not found.');
    return;
  }

  final buffer = StringBuffer();
  buffer.writeln(
    '╔══════════════════════════════════════════════════════════════════════════════╗',
  );
  buffer.writeln('║ CLASS: ${cls.name.padRight(68)} ║');
  buffer.writeln(
    '╚══════════════════════════════════════════════════════════════════════════════╝',
  );
  buffer.writeln();

  buffer.writeln('Full Name: ${cls.qualifiedName}');
  if (cls.superclass != null) {
    buffer.writeln('Superclass: ${cls.superclass!.name}');
  }
  buffer.writeln();

  // Modifiers
  final modifiers = <String>[];
  if (cls.isAbstract) modifiers.add('abstract');
  if (cls.isSealed) modifiers.add('sealed');
  if (cls.isFinal) modifiers.add('final');
  if (cls.isBase) modifiers.add('base');
  if (cls.isInterface) modifiers.add('interface');
  if (cls.isMixinClass) modifiers.add('mixin class');
  if (modifiers.isNotEmpty) {
    buffer.writeln('Modifiers: ${modifiers.join(', ')}');
    buffer.writeln();
  }

  // Interfaces
  final interfaces = cls.interfaces;
  if (interfaces.isNotEmpty) {
    buffer.writeln('Implements (${interfaces.length}):');
    for (final intf in interfaces) {
      buffer.writeln('  • ${intf.name}');
    }
    buffer.writeln();
  }

  // Mixins
  final mixins = cls.mixins;
  if (mixins.isNotEmpty) {
    buffer.writeln('With (${mixins.length}):');
    for (final mixin in mixins) {
      buffer.writeln('  • ${mixin.name}');
    }
    buffer.writeln();
  }

  // Constructors
  final ctors = cls.constructors;
  buffer.writeln('Constructors (${ctors.length}):');
  if (ctors.isNotEmpty) {
    for (final entry in ctors.entries) {
      final ctor = entry.value;
      final name = ctor.name.isEmpty ? '(unnamed)' : ctor.name;
      final mods = <String>[];
      if (ctor.isFactory) mods.add('factory');
      if (ctor.isConst) mods.add('const');
      final modStr = mods.isNotEmpty ? ' [${mods.join(', ')}]' : '';
      buffer.writeln('  • $name$modStr');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // Instance methods
  final instMethods = cls.instanceMethods;
  buffer.writeln('Instance Methods (${instMethods.length}):');
  if (instMethods.isNotEmpty) {
    for (final entry in instMethods.entries) {
      buffer.writeln('  • ${entry.key}');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // Static methods
  final staticMethods = cls.staticMethods;
  buffer.writeln('Static Methods (${staticMethods.length}):');
  if (staticMethods.isNotEmpty) {
    for (final entry in staticMethods.entries) {
      buffer.writeln('  • ${entry.key}');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // Instance fields
  final instFields = cls.instanceFields;
  buffer.writeln('Instance Fields (${instFields.length}):');
  if (instFields.isNotEmpty) {
    for (final entry in instFields.entries) {
      final field = entry.value;
      final mods = <String>[];
      if (field.isFinal) mods.add('final');
      if (field.isLate) mods.add('late');
      final modStr = mods.isNotEmpty ? ' [${mods.join(', ')}]' : '';
      buffer.writeln('  • ${entry.key}$modStr');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  // Static fields
  final staticFields = cls.staticFields;
  buffer.writeln('Static Fields (${staticFields.length}):');
  if (staticFields.isNotEmpty) {
    for (final entry in staticFields.entries) {
      final field = entry.value;
      final mods = <String>[];
      if (field.isFinal) mods.add('final');
      if (field.isConst) mods.add('const');
      if (field.isLate) mods.add('late');
      final modStr = mods.isNotEmpty ? ' [${mods.join(', ')}]' : '';
      buffer.writeln('  • ${entry.key}$modStr');
    }
  } else {
    buffer.writeln('  (none)');
  }
  buffer.writeln();

  print(buffer.toString());
}

/// Export cross-reference as a structured report.
class ReflectionCrossReference {
  final ReflectionApi api;

  ReflectionCrossReference(this.api);

  /// Get a summary map suitable for JSON serialization.
  Map<String, dynamic> toSummaryMap() {
    final classes = api.allClasses;
    final classDetails = <Map<String, dynamic>>[];

    int totalConstructors = 0;
    int totalInstanceMethods = 0;
    int totalStaticMethods = 0;
    int totalInstanceFields = 0;
    int totalStaticFields = 0;

    for (final cls in classes) {
      final ctorCount = cls.constructors.length;
      final instMethodCount = cls.instanceMethods.length;
      final staticMethodCount = cls.staticMethods.length;
      final instFieldCount = cls.instanceFields.length;
      final staticFieldCount = cls.staticFields.length;

      totalConstructors += ctorCount;
      totalInstanceMethods += instMethodCount;
      totalStaticMethods += staticMethodCount;
      totalInstanceFields += instFieldCount;
      totalStaticFields += staticFieldCount;

      classDetails.add({
        'name': cls.name,
        'qualifiedName': cls.qualifiedName,
        'isAbstract': cls.isAbstract,
        'constructors': ctorCount,
        'instanceMethods': instMethodCount,
        'staticMethods': staticMethodCount,
        'instanceFields': instFieldCount,
        'staticFields': staticFieldCount,
      });
    }

    return {
      'summary': {
        'types': {
          'classes': api.allClasses.length,
          'enums': api.allEnums.length,
          'mixins': api.allMixins.length,
          'extensions': api.allExtensions.length,
          'extensionTypes': api.allExtensionTypes.length,
          'typeAliases': api.allTypeAliases.length,
        },
        'globalMembers': {
          'functions': api.allGlobalMethods.length,
          'fields': api.allGlobalFields.length,
          'getters': api.allGlobalGetters.length,
          'setters': api.allGlobalSetters.length,
        },
        'classMembers': {
          'constructors': totalConstructors,
          'instanceMethods': totalInstanceMethods,
          'staticMethods': totalStaticMethods,
          'instanceFields': totalInstanceFields,
          'staticFields': totalStaticFields,
        },
        'packages': api.packages.length,
        'libraries': api.libraries.length,
      },
      'classes': classDetails,
      'enums': api.allEnums.map((e) => e.name).toList(),
      'mixins': api.allMixins.map((m) => m.name).toList(),
      'extensions': api.allExtensions.map((e) => e.name).toList(),
      'globalFunctions': api.allGlobalMethods.map((m) => m.name).toList(),
      'globalFields': api.allGlobalFields.map((f) => f.name).toList(),
      'packages': api.packages,
      'libraries': api.libraries,
    };
  }
}

/// Print a CSV list of all classes with member counts.
///
/// Format: name,constructors,instanceMethods,staticMethods,instanceFields,staticFields
void printClassListCsv(ReflectionApi api) {
  print('name,constructors,instanceMethods,staticMethods,instanceFields,staticFields');
  for (final cls in api.allClasses) {
    final ctorCount = cls.constructors.length;
    final instMethodCount = cls.instanceMethods.length;
    final staticMethodCount = cls.staticMethods.length;
    final instFieldCount = cls.instanceFields.length;
    final staticFieldCount = cls.staticFields.length;
    print(
      '${cls.name},$ctorCount,$instMethodCount,$staticMethodCount,$instFieldCount,$staticFieldCount',
    );
  }
}

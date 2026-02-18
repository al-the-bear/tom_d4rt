// Example: Bridging Enums
// From: doc/BRIDGING_GUIDE.md - Bridging Enums
//
// This example demonstrates how to bridge native Dart enums to D4rt,
// including basic enums and advanced enums with getters and methods.

import 'package:tom_d4rt_exec/d4rt.dart';

// Native Dart enums to bridge
enum Color { red, green, blue }

enum Priority {
  low('Low Priority', 1),
  medium('Medium Priority', 2),
  high('High Priority', 3);

  final String description;
  final int level;
  const Priority(this.description, this.level);

  String get info => '$description (level $level)';
  bool isHigherThan(Priority other) => level > other.level;
}

void main() {
  final d4rt = D4rt();

  // Basic enum bridging
  print('=== Basic Enum ===');
  final colorDefinition = BridgedEnumDefinition<Color>(
    name: 'Color', // How the enum will be known in the script
    values: Color.values, // Provide the native enum's values
  );
  d4rt.registerBridgedEnum(colorDefinition, 'package:myapp/types.dart');

  // Advanced enum with getters and methods
  print('=== Advanced Enum ===');
  final priorityDefinition = BridgedEnumDefinition<Priority>(
    name: 'Priority',
    values: Priority.values,
    getters: {
      'description': (visitor, target) => (target as Priority).description,
      'level': (visitor, target) => (target as Priority).level,
      'info': (visitor, target) => (target as Priority).info,
    },
    methods: {
      // BridgedMethodAdapter signature:
      // (visitor, target, positionalArgs, namedArgs, typeArgs)
      'isHigherThan': (visitor, target, positionalArgs, namedArgs, typeArgs) {
        if (target is Priority &&
            positionalArgs.length == 1 &&
            positionalArgs[0] is Priority) {
          return target.isHigherThan(positionalArgs[0] as Priority);
        }
        throw ArgumentError('Invalid arguments for isHigherThan');
      },
    },
  );
  d4rt.registerBridgedEnum(priorityDefinition, 'package:myapp/types.dart');

  // Use the bridged enums in a script
  final result = d4rt.execute(
    source: '''
      import 'package:myapp/types.dart';
      
      main() {
        // Basic enum usage
        var myColor = Color.green;
        print('Color: \${myColor.name}');
        print('Index: \${myColor.index}');
        
        // Advanced enum with methods
        var p1 = Priority.high;
        var p2 = Priority.low;
        
        print('Priority info: \${p1.info}');
        print('High > Low: \${p1.isHigherThan(p2)}');
        
        return p1.description;
      }
    ''',
  );

  print('Result: $result');
}

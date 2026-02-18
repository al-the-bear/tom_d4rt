// Example: Bridging Classes
// From: doc/BRIDGING_GUIDE.md - Bridging Classes
//
// This example demonstrates how to bridge native Dart classes to D4rt,
// including constructors, static members, instance members, and operators.

import 'package:tom_d4rt_exec/d4rt.dart';

// Native Dart class to bridge
class Counter {
  static int instanceCount = 0;

  String id;
  int _value;

  Counter(this._value, this.id) {
    instanceCount++;
  }

  Counter.withDefault()
      : _value = 0,
        id = 'default' {
    instanceCount++;
  }

  // Using getter/setter to demonstrate bridging pattern
  // ignore: unnecessary_getters_setters
  int get value => _value;
  // ignore: unnecessary_getters_setters
  set value(int v) => _value = v;

  void increment([int amount = 1]) {
    _value += amount;
  }

  void decrement([int amount = 1]) {
    _value -= amount;
  }

  static void resetInstanceCount() {
    instanceCount = 0;
  }

  static int getInstanceCount() => instanceCount;
}

void main() {
  final d4rt = D4rt();

  // Define the bridge
  final counterBridge = BridgedClass(
    nativeType: Counter,
    name: 'Counter',

    // Constructors
    constructors: {
      // Default constructor
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length == 2 &&
            positionalArgs[0] is int &&
            positionalArgs[1] is String) {
          return Counter(positionalArgs[0] as int, positionalArgs[1] as String);
        }
        throw ArgumentError('Counter expects (int, String)');
      },
      // Named constructor
      'withDefault': (visitor, positionalArgs, namedArgs) {
        return Counter.withDefault();
      },
    },

    // Static getters
    staticGetters: {
      'instanceCount': (visitor) => Counter.instanceCount,
    },

    // Static setters
    staticSetters: {
      'instanceCount': (visitor, value) {
        if (value is! int) throw ArgumentError('instanceCount requires an int');
        Counter.instanceCount = value;
      },
    },

    // Static methods
    staticMethods: {
      'resetInstanceCount': (visitor, positionalArgs, namedArgs, typeArgs) {
        Counter.resetInstanceCount();
        return null;
      },
      'getInstanceCount': (visitor, positionalArgs, namedArgs, typeArgs) {
        return Counter.getInstanceCount();
      },
    },

    // Instance getters
    getters: {
      'value': (visitor, target) => (target as Counter).value,
      'id': (visitor, target) => (target as Counter).id,
    },

    // Instance setters
    setters: {
      'value': (visitor, target, value) {
        if (value is! int) throw ArgumentError('value requires an int');
        (target as Counter).value = value;
      },
    },

    // Instance methods
    methods: {
      'increment': (visitor, target, positionalArgs, namedArgs, typeArgs) {
        final counter = target as Counter;
        if (positionalArgs.isEmpty) {
          counter.increment();
        } else if (positionalArgs.length == 1 && positionalArgs[0] is int) {
          counter.increment(positionalArgs[0] as int);
        } else {
          throw ArgumentError('increment expects 0 or 1 int argument');
        }
        return null;
      },
      'decrement': (visitor, target, positionalArgs, namedArgs, typeArgs) {
        final counter = target as Counter;
        if (positionalArgs.isEmpty) {
          counter.decrement();
        } else if (positionalArgs.length == 1 && positionalArgs[0] is int) {
          counter.decrement(positionalArgs[0] as int);
        } else {
          throw ArgumentError('decrement expects 0 or 1 int argument');
        }
        return null;
      },
    },
  );

  d4rt.registerBridgedClass(counterBridge, 'package:myapp/counter.dart');

  // Use the bridged class in a script
  final result = d4rt.execute(
    source: '''
      import 'package:myapp/counter.dart';
      
      main() {
        // Create instances
        var c1 = Counter(10, 'first');
        var c2 = Counter.withDefault();
        
        // Use instance methods
        c1.increment(5);
        c2.increment();
        
        // Access properties
        print('c1 value: \${c1.value}');  // 15
        print('c2 value: \${c2.value}');  // 1
        
        // Use setters
        c1.value = 100;
        print('c1 after set: \${c1.value}');  // 100
        
        // Access static members
        print('Instance count: \${Counter.instanceCount}');  // 2
        
        Counter.resetInstanceCount();
        print('After reset: \${Counter.getInstanceCount()}');  // 0
        
        return c1.value;
      }
    ''',
  );

  print('Result: $result');
}

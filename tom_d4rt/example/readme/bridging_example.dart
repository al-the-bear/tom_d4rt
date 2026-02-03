// Example: Exposing Native Code (Bridging)
// From: README.md - Exposing Native Code (Bridging)
//
// Demonstrates registering and using bridged classes.

import 'package:tom_d4rt/d4rt.dart';

// Simple native class to bridge
class Counter {
  int value;
  Counter(this.value);
  void increment() => value++;
}

void main() {
  final d4rt = D4rt();

  // Create bridge for Counter
  final counterBridge = BridgedClass(
    nativeType: Counter,
    name: 'Counter',
    constructors: {
      '': (visitor, positionalArgs, namedArgs) =>
          Counter(positionalArgs[0] as int),
    },
    getters: {
      'value': (visitor, target) => (target as Counter).value,
    },
    methods: {
      'increment': (visitor, target, positionalArgs, namedArgs, typeArgs) {
        (target as Counter).increment();
        return null;
      },
    },
  );

  // Register bridges before execution
  d4rt.registerBridgedClass(counterBridge, 'package:my_app/types.dart');

  // Scripts import and use them
  final result = d4rt.execute(
    source: '''
      import 'package:my_app/types.dart';
      
      int main() {
        final counter = Counter(10);
        counter.increment();
        counter.increment();
        return counter.value;
      }
    ''',
  );

  print('Counter value: $result'); // 12
}

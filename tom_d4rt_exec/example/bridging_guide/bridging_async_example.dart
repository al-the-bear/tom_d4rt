// Example: Bridging Async Methods
// From: doc/BRIDGING_GUIDE.md - Bridging Asynchronous Methods
//
// This example demonstrates how to bridge async methods that return Futures.
// D4rt handles Futures correctly, allowing await in scripts.

import 'package:tom_d4rt_exec/d4rt.dart';

// Native async service class
class DataService {
  Future<String> fetchData(String id) async {
    await Future.delayed(Duration(milliseconds: 50));
    return 'Data for $id';
  }

  Future<List<int>> fetchNumbers(int count) async {
    await Future.delayed(Duration(milliseconds: 30));
    return List.generate(count, (i) => i * 10);
  }

  Future<void> logMessage(String message) async {
    await Future.delayed(Duration(milliseconds: 10));
    print('[LOG] $message');
  }
}

void main() async {
  final d4rt = D4rt();

  // Bridge the async service
  final serviceBridge = BridgedClass(
    nativeType: DataService,
    name: 'DataService',
    constructors: {
      '': (visitor, positionalArgs, namedArgs) => DataService(),
    },
    methods: {
      'fetchData': (visitor, target, positionalArgs, namedArgs, typeArgs) {
        if (positionalArgs.length == 1 && positionalArgs[0] is String) {
          // Return the Future directly - D4rt handles it
          return (target as DataService).fetchData(positionalArgs[0] as String);
        }
        throw ArgumentError('fetchData expects a String');
      },
      'fetchNumbers': (visitor, target, positionalArgs, namedArgs, typeArgs) {
        if (positionalArgs.length == 1 && positionalArgs[0] is int) {
          return (target as DataService).fetchNumbers(positionalArgs[0] as int);
        }
        throw ArgumentError('fetchNumbers expects an int');
      },
      'logMessage': (visitor, target, positionalArgs, namedArgs, typeArgs) {
        if (positionalArgs.length == 1 && positionalArgs[0] is String) {
          return (target as DataService).logMessage(positionalArgs[0] as String);
        }
        throw ArgumentError('logMessage expects a String');
      },
    },
  );

  d4rt.registerBridgedClass(serviceBridge, 'package:myapp/services.dart');

  // Execute async script
  print('=== Async Method Bridging ===');
  final result = await d4rt.execute(
    source: '''
      import 'package:myapp/services.dart';
      
      main() async {
        var service = DataService();
        
        // Await async methods
        var data = await service.fetchData('user123');
        print('Fetched: \$data');
        
        var numbers = await service.fetchNumbers(5);
        print('Numbers: \$numbers');
        
        await service.logMessage('All done!');
        
        return data;
      }
    ''',
  );

  print('Final result: $result');
}

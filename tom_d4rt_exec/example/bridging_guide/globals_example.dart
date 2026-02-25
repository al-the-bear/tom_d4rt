// Example: Global Variables and Getters
// From: doc/BRIDGING_GUIDE.md - Global Variables and Getters
//
// This example demonstrates how to register global variables and getters
// that can be accessed from D4rt scripts.

import 'package:tom_d4rt_exec/d4rt.dart';

// Sample application configuration
class AppConfig {
  final String environment;
  final bool debug;

  AppConfig(this.environment, this.debug);

  @override
  String toString() => 'AppConfig($environment, debug=$debug)';
}

// Singleton pattern (common in Dart apps)
class Logger {
  static Logger? _instance;
  static Logger get instance => _instance!;

  static void initialize() {
    _instance = Logger._();
    print('Logger initialized');
  }

  Logger._();

  void log(String message) => print('[LOG] $message');
}

void main() {
  final d4rt = D4rt();

  // Register a constant value (evaluated at registration time)
  d4rt.registerGlobalVariable(
    'appVersion',
    '1.0.0',
    'package:myapp/globals.dart',
  );

  // Register an object
  final config = AppConfig('production', false);
  d4rt.registerGlobalVariable(
    'config',
    config,
    'package:myapp/globals.dart',
  );

  // Register a global getter (evaluated lazily each time it's accessed)
  // This is essential for singletons that may not be initialized at registration
  d4rt.registerGlobalGetter(
    'logger',
    () => Logger.instance,
    'package:myapp/globals.dart',
  );

  // Register a dynamic value getter (evaluated fresh each access)
  d4rt.registerGlobalGetter(
    'currentTime',
    () => DateTime.now().toString(),
    'package:myapp/globals.dart',
  );

  // Register a top-level function
  // NativeFunctionImpl signature: (visitor, args, namedArgs, typeArgs)
  d4rt.registertopLevelFunction(
    'formatMessage',
    (visitor, args, namedArgs, typeArgs) => '[${args[0]}] ${args[1]}',
    'package:myapp/globals.dart',
  );

  // Initialize the singleton AFTER registering the getter
  // This works because registerGlobalGetter is lazy!
  Logger.initialize();

  // Execute script that uses globals
  print('=== Using Global Variables and Getters ===');
  d4rt.execute(
    source: '''
      import 'package:myapp/globals.dart';
      
      main() {
        // Access constant
        print('Version: \$appVersion');
        
        // Access object
        print('Config: \$config');
        
        // Access singleton via getter
        logger.log('Hello from script!');
        
        // Access dynamic value
        print('Time: \$currentTime');
        
        // Call top-level function
        print(formatMessage('INFO', 'Script running'));
      }
    ''',
  );
}

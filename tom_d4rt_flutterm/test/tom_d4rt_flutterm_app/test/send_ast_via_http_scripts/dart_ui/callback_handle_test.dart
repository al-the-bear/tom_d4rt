// D4rt test script: Tests CallbackHandle from dart:ui
// CallbackHandle enables passing Dart callbacks to native code/isolates
// Used for background processing, plugins, and platform channel callbacks
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                 CallbackHandle - Deep Demo                         ║');
  print('║       Handle for Registering Dart Callbacks with Native Code       ║');
  print('╚════════════════════════════════════════════════════════════════════╝');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CallbackHandle Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: CallbackHandle Fundamentals                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('CallbackHandle is a mechanism for passing Dart function references');
  print('to native code through an opaque integer handle.');
  print('');
  print('Key concepts:');
  print('  - Represents a Dart top-level or static function');
  print('  - Used for background isolate callbacks');
  print('  - Enables native code to call back into Dart');
  print('  - Essential for plugins and platform channels');
  print('');
  print('Package: dart:ui');
  print('Related: PluginUtilities, Isolate, PlatformDispatcher');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Creating CallbackHandle
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: Creating CallbackHandle                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Method 1: PluginUtilities.getCallbackHandle()');
  print('  // Define a top-level function');
  print('  void myCallback() {');
  print('    print("Callback invoked!");');
  print('  }');
  print('');
  print('  // Get its handle');
  print('  final handle = PluginUtilities.getCallbackHandle(myCallback);');
  print('  print(handle?.toRawHandle()); // e.g., 12345');
  print('');
  print('Method 2: CallbackHandle.fromRawHandle()');
  print('  // Recreate from raw handle value');
  print('  final handle = CallbackHandle.fromRawHandle(12345);');

  // Demonstrate fromRawHandle
  print('');
  print('Live demonstration:');
  final handle1 = ui.CallbackHandle.fromRawHandle(12345);
  print('  Created handle from raw 12345: ${handle1.runtimeType}');
  print('  toRawHandle(): ${handle1.toRawHandle()}');

  final handle2 = ui.CallbackHandle.fromRawHandle(67890);
  print('  Created handle from raw 67890: ${handle2.runtimeType}');
  print('  toRawHandle(): ${handle2.toRawHandle()}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CallbackHandle.fromRawHandle()
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: CallbackHandle.fromRawHandle()                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('The factory constructor fromRawHandle:');
  print('');
  print('Signature:');
  print('  factory CallbackHandle.fromRawHandle(int rawHandle)');
  print('');
  print('Purpose:');
  print('  - Reconstructs a CallbackHandle from its raw integer form');
  print('  - Used when receiving handle back from native code');
  print('  - Essential for isolate communication');
  print('');
  print('Example:');
  print('  // In main isolate - get handle');
  print('  final handle = PluginUtilities.getCallbackHandle(myCallback);');
  print('  final rawValue = handle!.toRawHandle();');
  print('  // Send rawValue to native via platform channel');
  print('');
  print('  // In native code - receive and store rawValue');
  print('  // Later, in a background isolate:');
  print('  final handle = CallbackHandle.fromRawHandle(rawValue);');
  print('  final callback = PluginUtilities.getCallbackFromHandle(handle);');
  print('  callback!(); // Invokes myCallback');

  // Show various raw handles
  print('');
  print('Creating various handles:');
  final handles = [0, 1, 100, 999999, 2147483647];
  for (final raw in handles) {
    final h = ui.CallbackHandle.fromRawHandle(raw);
    print('  fromRawHandle($raw) → toRawHandle(): ${h.toRawHandle()}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: toRawHandle() Method
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: toRawHandle() Method                                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('The toRawHandle() method:');
  print('');
  print('Signature:');
  print('  int toRawHandle()');
  print('');
  print('Purpose:');
  print('  - Converts CallbackHandle to transmittable integer');
  print('  - Allows sending via platform channels');
  print('  - Enables storing in native code');
  print('');
  print('Properties:');
  print('  - Returns consistent value for same handle');
  print('  - Value is opaque (no meaning without Dart runtime)');
  print('  - Valid only within same Dart execution context');
  print('');
  print('Demonstration:');
  final demo = ui.CallbackHandle.fromRawHandle(54321);
  print('  Handle created: $demo');
  print('  toRawHandle() call 1: ${demo.toRawHandle()}');
  print('  toRawHandle() call 2: ${demo.toRawHandle()}');
  print('  toRawHandle() call 3: ${demo.toRawHandle()}');
  print('  (All calls return same value)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Equality and HashCode
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: Equality and HashCode                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('CallbackHandle equality:');
  print('');
  final h1 = ui.CallbackHandle.fromRawHandle(12345);
  final h2 = ui.CallbackHandle.fromRawHandle(12345);
  final h3 = ui.CallbackHandle.fromRawHandle(67890);
  print('  h1 = fromRawHandle(12345)');
  print('  h2 = fromRawHandle(12345)');
  print('  h3 = fromRawHandle(67890)');
  print('');
  print('Equality tests:');
  print('  h1 == h2 (same raw): ${h1 == h2}');
  print('  h1 == h3 (different raw): ${h1 == h3}');
  print('  identical(h1, h2): ${identical(h1, h2)}');
  print('');
  print('HashCode:');
  print('  h1.hashCode: ${h1.hashCode}');
  print('  h2.hashCode: ${h2.hashCode}');
  print('  h3.hashCode: ${h3.hashCode}');
  print('  h1.hashCode == h2.hashCode: ${h1.hashCode == h2.hashCode}');
  print('');
  print('Can use in collections:');
  print('  Set<CallbackHandle> - deduplicates by raw handle');
  print('  Map<CallbackHandle, dynamic> - keys by handle');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: PluginUtilities Integration
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: PluginUtilities Integration                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('PluginUtilities provides the main API:');
  print('');
  print('1. Getting a handle from a function:');
  print('  CallbackHandle? PluginUtilities.getCallbackHandle(');
  print('    Function callback');
  print('  )');
  print('');
  print('  Requirements:');
  print('  - callback must be top-level or static');
  print('  - Cannot be a closure or instance method');
  print('  - Returns null if function cannot be registered');
  print('');
  print('2. Getting a function from a handle:');
  print('  Function? PluginUtilities.getCallbackFromHandle(');
  print('    CallbackHandle handle');
  print('  )');
  print('');
  print('  Returns:');
  print('  - The original Dart function');
  print('  - null if handle is invalid');
  print('');
  print('Example workflow:');
  print('  // Sender side');
  print('  @pragma("vm:entry-point")');
  print('  static void backgroundTask() { ... }');
  print('');
  print('  final handle = PluginUtilities.getCallbackHandle(backgroundTask);');
  print('  final raw = handle!.toRawHandle();');
  print('');
  print('  // Receiver side (in isolate)');
  print('  final handle = CallbackHandle.fromRawHandle(raw);');
  print('  final fn = PluginUtilities.getCallbackFromHandle(handle);');
  print('  fn!();');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Background Isolate Use Case
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: Background Isolate Use Case                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('CallbackHandle is essential for Flutter plugins using isolates:');
  print('');
  print('Scenario: Background processing (e.g., workmanager, firebase_messaging)');
  print('');
  print('1. Register callback in main isolate:');
  print('');
  print('  @pragma("vm:entry-point")');
  print('  void callbackDispatcher() {');
  print('    // This runs in background isolate');
  print('    Workmanager().executeTask((task, data) {');
  print('      // Process background task');
  print('      return Future.value(true);');
  print('    });');
  print('  }');
  print('');
  print('  void main() {');
  print('    Workmanager().initialize(callbackDispatcher);');
  print('  }');
  print('');
  print('2. Behind the scenes:');
  print('  - getCallbackHandle(callbackDispatcher)');
  print('  - toRawHandle() sent to native');
  print('  - Native stores the raw handle');
  print('  - When background work needed:');
  print('    - Native spawns new isolate');
  print('    - Passes raw handle to isolate');
  print('    - Isolate uses fromRawHandle + getCallbackFromHandle');
  print('    - Invokes callbackDispatcher');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Platform Channel Example
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: Platform Channel Example                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Using CallbackHandle with platform channels:');
  print('');
  print('Dart side:');
  print('  @pragma("vm:entry-point")');
  print('  static void onLocationUpdate(Map<String, dynamic> location) {');
  print('    print("Location: \${location["lat"]}, \${location["lng"]}");');
  print('  }');
  print('');
  print('  Future<void> startLocationTracking() async {');
  print('    final handle = PluginUtilities.getCallbackHandle(onLocationUpdate);');
  print('    await _channel.invokeMethod("startTracking", {');
  print('      "callbackHandle": handle!.toRawHandle(),');
  print('    });');
  print('  }');
  print('');
  print('Native side (Kotlin):');
  print('  val callbackHandle = call.argument<Long>("callbackHandle")');
  print('  // Store callbackHandle');
  print('  // When location updates:');
  print('  FlutterEngineCache.getInstance()');
  print('    .get(ENGINE_ID)');
  print('    ?.dartExecutor');
  print('    ?.executeDartCallback(callbackHandle, locationData)');
  print('');
  print('Note: Actual implementation varies by plugin architecture');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: @pragma("vm:entry-point")
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: @pragma("vm:entry-point")                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('The @pragma annotation is critical for callback functions:');
  print('');
  print('Why it\'s needed:');
  print('  - Prevents tree shaking from removing the function');
  print('  - Ensures function is available at runtime');
  print('  - Required for all CallbackHandle targets');
  print('');
  print('Correct usage:');
  print('  @pragma("vm:entry-point")');
  print('  void myCallback() {');
  print('    // Callback implementation');
  print('  }');
  print('');
  print('  @pragma("vm:entry-point")');
  print('  class MyService {');
  print('    @pragma("vm:entry-point")');
  print('    static void serviceCallback() { }');
  print('  }');
  print('');
  print('Without @pragma:');
  print('  - In release builds, function may be removed');
  print('  - getCallbackHandle may return null');
  print('  - getCallbackFromHandle may fail');
  print('');
  print('Debug vs Release:');
  print('  - Debug: Usually works without @pragma');
  print('  - Release: @pragma required for AOT compilation');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Constraints and Limitations
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: Constraints and Limitations                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('CallbackHandle has important constraints:');
  print('');
  print('1. Function type requirements:');
  print('   ✓ Top-level functions');
  print('   ✓ Static methods');
  print('   ✗ Instance methods');
  print('   ✗ Closures');
  print('   ✗ Anonymous functions');
  print('   ✗ Local functions');
  print('');
  print('  // Works:');
  print('  void topLevel() { }');
  print('  class C { static void staticMethod() { } }');
  print('');
  print('  // Does NOT work:');
  print('  class C { void instanceMethod() { } }');
  print('  final closure = () { };');
  print('');
  print('2. State limitations:');
  print('  - No closure state (no captured variables)');
  print('  - Must be self-contained');
  print('  - Use isolate ports for state communication');
  print('');
  print('3. Platform limitations:');
  print('  - Handle only valid within same app execution');
  print('  - Cannot persist handles across app restarts');
  print('  - Handle values may differ between runs');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Debugging CallbackHandle Issues
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 11: Debugging CallbackHandle Issues                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Common issues and solutions:');
  print('');
  print('1. getCallbackHandle returns null:');
  print('   - Check: Is function top-level or static?');
  print('   - Check: Added @pragma("vm:entry-point")?');
  print('   - Check: Not a closure?');
  print('');
  print('2. getCallbackFromHandle returns null:');
  print('   - Check: Is handle from same Dart runtime?');
  print('   - Check: Was function compiled into binary?');
  print('   - Check: Correct raw handle value?');
  print('');
  print('3. Callback not invoked:');
  print('   - Check: Is isolate properly initialized?');
  print('   - Check: FlutterEngine running in background?');
  print('   - Check: Platform-specific lifecycle');
  print('');
  print('4. Works in debug, fails in release:');
  print('   - Solution: Add @pragma("vm:entry-point")');
  print('   - Rebuild in release mode');
  print('');
  print('Debugging strategy:');
  print('  @pragma("vm:entry-point")');
  print('  void myCallback() {');
  print('    print("Callback invoked at: \${DateTime.now()}");');
  print('    // Rest of implementation');
  print('  }');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Common Patterns
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 12: Common Patterns                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Pattern 1: Workmanager-style registration');
  print('');
  print('  @pragma("vm:entry-point")');
  print('  void callbackDispatcher() {');
  print('    // Initialize services');
  print('    WidgetsFlutterBinding.ensureInitialized();');
  print('    // Handle background work');
  print('  }');
  print('');
  print('  void main() {');
  print('    WidgetsFlutterBinding.ensureInitialized();');
  print('    Workmanager().initialize(callbackDispatcher);');
  print('    runApp(MyApp());');
  print('  }');
  print('');
  print('Pattern 2: Firebase background handler');
  print('');
  print('  @pragma("vm:entry-point")');
  print('  Future<void> firebaseMessagingBackgroundHandler(');
  print('    RemoteMessage message');
  print('  ) async {');
  print('    // Handle background message');
  print('  }');
  print('');
  print('  void main() async {');
  print('    WidgetsFlutterBinding.ensureInitialized();');
  print('    FirebaseMessaging.onBackgroundMessage(');
  print('      firebaseMessagingBackgroundHandler');
  print('    );');
  print('    runApp(MyApp());');
  print('  }');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Alternative Approaches
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 13: Alternative Approaches                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('When CallbackHandle constraints are too limiting:');
  print('');
  print('1. Isolate with SendPort/ReceivePort:');
  print('  - More flexible communication');
  print('  - Can send arbitrary data');
  print('  - More complex setup');
  print('');
  print('2. compute() function:');
  print('  - Simple background work');
  print('  - Single input/output');
  print('  - Limited to pure functions');
  print('');
  print('3. Platform channels directly:');
  print('  - Event channels for streams');
  print('  - Method channels for RPC');
  print('  - More control over lifecycle');
  print('');
  print('4. flutter_isolate package:');
  print('  - Simplifies isolate management');
  print('  - Helper utilities');
  print('');
  print('Choosing the right approach:');
  print('  - Background execution from native: CallbackHandle');
  print('  - Heavy computation: Isolate/compute');
  print('  - Plugin development: Platform channels');
  print('  - Simple async: Future/Stream');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Runtime Type Information
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 14: Runtime Type Information                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  final testHandle = ui.CallbackHandle.fromRawHandle(999);
  print('CallbackHandle runtime information:');
  print('');
  print('  runtimeType: ${testHandle.runtimeType}');
  print('  toString(): $testHandle');
  print('  toRawHandle(): ${testHandle.toRawHandle()}');
  print('');
  print('Type checks:');
  print('  is CallbackHandle: ${testHandle is ui.CallbackHandle}');
  print('  is Object: ${testHandle is Object}');
  print('');
  print('Null safety:');
  print('  - getCallbackHandle returns CallbackHandle?');
  print('  - fromRawHandle returns non-nullable CallbackHandle');
  print('  - Always check for null from getCallbackHandle');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 15: Summary                                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('CallbackHandle summary:');
  print('');
  print('┌──────────────────────┬─────────────────────────────────────────────┐');
  print('│ Feature              │ Description                                 │');
  print('├──────────────────────┼─────────────────────────────────────────────┤');
  print('│ fromRawHandle(int)   │ Create handle from raw integer              │');
  print('│ toRawHandle()        │ Get raw integer for transmission            │');
  print('│ == operator          │ Compares by raw handle value                │');
  print('│ hashCode             │ Consistent with equality                    │');
  print('└──────────────────────┴─────────────────────────────────────────────┘');
  print('');
  print('Key points:');
  print('  1. Used for native-to-Dart callback registration');
  print('  2. Only works with top-level/static functions');
  print('  3. Requires @pragma("vm:entry-point") for release');
  print('  4. Works with PluginUtilities');
  print('  5. Essential for background processing plugins');
  print('');
  print('Common use cases:');
  print('  - workmanager background tasks');
  print('  - firebase_messaging background handlers');
  print('  - Location tracking callbacks');
  print('  - Custom plugin isolate communication');
  print('');
  print('═══════════════════════════════════════════════════════════════════════');
  print('CallbackHandle deep demo completed');

  // Return visual UI
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.deepPurple.shade50, Colors.purple.shade50],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.sync_alt, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CallbackHandle',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Native-to-Dart Callback Registration',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        // Methods display
        Text(
          'API Surface',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MethodCard(
                name: 'fromRawHandle',
                signature: 'factory (int raw)',
                description: 'Create from integer',
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _MethodCard(
                name: 'toRawHandle',
                signature: 'int ()',
                description: 'Get integer value',
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),

        // Demo output
        Text(
          'Live Demo',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CodeLine('final h1 = CallbackHandle.fromRawHandle(12345);'),
              _CodeLine('final h2 = CallbackHandle.fromRawHandle(12345);'),
              _CodeLine('final h3 = CallbackHandle.fromRawHandle(67890);'),
              SizedBox(height: 8),
              _ResultLine('h1.toRawHandle(): ${h1.toRawHandle()}'),
              _ResultLine('h1 == h2: ${h1 == h2}'),
              _ResultLine('h1 == h3: ${h1 == h3}'),
              _ResultLine('h1.hashCode == h2.hashCode: ${h1.hashCode == h2.hashCode}'),
            ],
          ),
        ),
        SizedBox(height: 24),

        // Requirements
        Text(
          'Requirements for Callbacks',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _RequirementCard(
                icon: Icons.check_circle,
                title: 'Top-level/Static',
                description: 'Functions must be top-level or static methods',
                isPositive: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _RequirementCard(
                icon: Icons.code,
                title: '@pragma',
                description: '@pragma("vm:entry-point") for release builds',
                isPositive: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _RequirementCard(
                icon: Icons.cancel,
                title: 'No Closures',
                description: 'Instance methods and closures not supported',
                isPositive: false,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.deepPurple.shade600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Used by plugins like workmanager, firebase_messaging • Essential for background processing • Works with PluginUtilities',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget for method cards
class _MethodCard extends StatelessWidget {
  final String name;
  final String signature;
  final String description;
  final Color color;

  const _MethodCard({
    required this.name,
    required this.signature,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            signature,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: color.shade500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 11,
              color: color.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for code lines
class _CodeLine extends StatelessWidget {
  final String code;
  const _CodeLine(this.code);

  @override
  Widget build(BuildContext context) {
    return Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Colors.lightBlue.shade300,
      ),
    );
  }
}

// Helper widget for result lines
class _ResultLine extends StatelessWidget {
  final String result;
  const _ResultLine(this.result);

  @override
  Widget build(BuildContext context) {
    return Text(
      '// $result',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Colors.green.shade400,
      ),
    );
  }
}

// Helper widget for requirement cards
class _RequirementCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isPositive;

  const _RequirementCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? Colors.green : Colors.red;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 20),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 9,
              color: color.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

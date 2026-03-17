// D4rt test script: Tests ChannelBuffers from dart:ui
// ChannelBuffers manages message queuing for platform channels
// Used internally by Flutter's platform channel system
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                  ChannelBuffers - Deep Demo                        ║');
  print('║         Message Buffering for Platform Channel Communication       ║');
  print('╚════════════════════════════════════════════════════════════════════╝');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ChannelBuffers Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: ChannelBuffers Fundamentals                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ChannelBuffers manages message buffering for platform channels.');
  print('');
  print('Purpose:');
  print('  - Queue messages when handlers are not yet registered');
  print('  - Buffer incoming platform messages during initialization');
  print('  - Prevent message loss before Dart is ready');
  print('  - Control memory usage with buffer size limits');
  print('');
  print('Location in Flutter architecture:');
  print('  Native Platform → PlatformDispatcher → ChannelBuffers → Channel Handlers');
  print('');
  print('Package: dart:ui');
  print('Related: PlatformDispatcher, BinaryMessenger, MessageCodec');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Static Constants
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: Static Constants                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ChannelBuffers exposes important constants:');
  print('');
  print('kDefaultBufferSize:');
  print('  Value: ${ui.ChannelBuffers.kDefaultBufferSize}');
  print('  Purpose: Default number of messages buffered per channel');
  print('  Memory: Each message can vary in size');
  print('');
  print('kControlChannelName:');
  print('  Value: "${ui.ChannelBuffers.kControlChannelName}"');
  print('  Purpose: Special channel for buffer control commands');
  print('  Usage: resize, allowOverflow commands');
  print('');
  print('Design considerations:');
  print('  - Small default buffer prevents memory exhaustion');
  print('  - Individual channels can be resized as needed');
  print('  - Control channel allows runtime configuration');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Creating ChannelBuffers Instance
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: Creating ChannelBuffers Instance                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Creating a ChannelBuffers instance:');
  print('');
  print('  final buffers = ChannelBuffers();');
  print('');
  final buffers = ui.ChannelBuffers();
  print('Instance created:');
  print('  Type: ${buffers.runtimeType}');
  print('  toString: $buffers');
  print('');
  print('Usage context:');
  print('  - Flutter framework creates ONE global instance');
  print('  - Accessible via PlatformDispatcher.instance.channelBuffers');
  print('  - Apps typically don\'t need to create their own');
  print('');
  print('When to create custom instance:');
  print('  - Testing platform channel behavior');
  print('  - Custom message routing');
  print('  - Embedding Flutter in native apps');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: resize() Method
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: resize() Method                                        │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('The resize() method sets buffer capacity for a channel:');
  print('');
  print('Signature:');
  print('  void resize(String name, int newSize)');
  print('');
  print('Parameters:');
  print('  name: Channel name (e.g., "flutter/navigation")');
  print('  newSize: Maximum messages to buffer (0 = disable buffering)');
  print('');
  print('Demonstration:');
  buffers.resize('test_channel', 100);
  print('  buffers.resize("test_channel", 100) - Set to 100 messages');
  buffers.resize('navigation_channel', 50);
  print('  buffers.resize("navigation_channel", 50) - Set to 50 messages');
  buffers.resize('event_channel', 1000);
  print('  buffers.resize("event_channel", 1000) - Set to 1000 messages');
  print('');
  print('Common size recommendations:');
  print('  - Navigation: 10-50 (infrequent, important)');
  print('  - Events: 100-500 (frequent, order matters)');
  print('  - Sensor data: 1000+ (high frequency)');
  print('  - Keyboard: 100 (responsiveness critical)');
  print('');
  print('Special values:');
  print('  - 0: Disable buffering entirely');
  print('  - 1: Only most recent message');
  print('  - Large: Risk of memory issues');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: allowOverflow() Method
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: allowOverflow() Method                                 │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('The allowOverflow() method controls behavior when buffer is full:');
  print('');
  print('Signature:');
  print('  void allowOverflow(String name, bool allowed)');
  print('');
  print('Parameters:');
  print('  name: Channel name');
  print('  allowed: Whether to silently drop or throw on overflow');
  print('');
  print('Behavior:');
  print('  allowed = true:');
  print('    - Oldest messages are dropped when buffer full');
  print('    - No error thrown');
  print('    - Useful for non-critical, high-frequency data');
  print('');
  print('  allowed = false (default):');
  print('    - Error when trying to buffer beyond capacity');
  print('    - Ensures no message loss');
  print('    - Appropriate for critical messages');
  print('');
  print('Demonstration:');
  buffers.allowOverflow('test_channel', true);
  print('  buffers.allowOverflow("test_channel", true) - Allow dropping');
  buffers.allowOverflow('test_channel', false);
  print('  buffers.allowOverflow("test_channel", false) - Prevent overflow');
  print('');
  print('Use cases:');
  print('  allowOverflow(true): Sensor streams, frequent updates');
  print('  allowOverflow(false): Navigation, user actions, payments');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Buffer Lifecycle
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: Buffer Lifecycle                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Message flow through ChannelBuffers:');
  print('');
  print('1. Channel not registered:');
  print('   Native → ChannelBuffers (queued) → [waiting]');
  print('');
  print('2. Handler registered:');
  print('   - Buffered messages delivered in order');
  print('   - Future messages delivered directly');
  print('   ChannelBuffers → Handler');
  print('');
  print('3. Handler unregistered:');
  print('   - Returns to buffering mode');
  print('   - Previous configuration retained');
  print('');
  print('Timeline example:');
  print('');
  print('  T=0: Native sends "msg1" → Buffered (no handler)');
  print('  T=1: Native sends "msg2" → Buffered');
  print('  T=2: Handler registered  → "msg1", "msg2" delivered');
  print('  T=3: Native sends "msg3" → Delivered directly');
  print('');
  print('This is why platform channels work even during app startup.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Platform Channel Integration
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: Platform Channel Integration                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ChannelBuffers in the platform channel stack:');
  print('');
  print('High-level (what you usually use):');
  print('  MethodChannel, EventChannel, BasicMessageChannel');
  print('       ↓');
  print('  BinaryMessenger (encoding/decoding)');
  print('       ↓');
  print('  PlatformDispatcher');
  print('       ↓');
  print('  ChannelBuffers (queueing)');
  print('       ↓');
  print('  Native engine');
  print('');
  print('Why buffering matters:');
  print('  - Native might send messages during Dart initialization');
  print('  - Flutter widgets aren\'t available immediately');
  print('  - MethodCallHandler registration happens later');
  print('  - Buffering ensures no messages are lost');
  print('');
  print('Without buffering:');
  print('  - Early native messages would be dropped');
  print('  - Initialization data might be lost');
  print('  - App state could be inconsistent');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Control Channel
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: Control Channel                                        │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('The control channel for runtime configuration:');
  print('');
  print('Channel name: "${ui.ChannelBuffers.kControlChannelName}"');
  print('');
  print('Control commands (from native):');
  print('');
  print('1. Resize command:');
  print('   {');
  print('     "command": "resize",');
  print('     "channel": "my_channel",');
  print('     "size": 100');
  print('   }');
  print('');
  print('2. Overflow command:');
  print('   {');
  print('     "command": "overflow",');
  print('     "channel": "my_channel",');
  print('     "allowed": true');
  print('   }');
  print('');
  print('This allows native code to configure Dart buffers');
  print('before the Dart side is fully initialized.');
  print('');
  print('Use case:');
  print('  - Plugin configuration during engine startup');
  print('  - Native-driven buffer management');
  print('  - Emergency buffer expansion');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Memory Considerations
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: Memory Considerations                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Buffer memory usage:');
  print('');
  print('Calculation:');
  print('  Total memory ≈ Σ (buffer_size × avg_message_size) for all channels');
  print('');
  print('Message sizes vary by type:');
  print('  - Method calls: 100-1000 bytes typically');
  print('  - Event data: varies widely');
  print('  - Binary data: potentially very large');
  print('');
  print('Memory management strategies:');
  print('');
  print('1. Keep default for most channels:');
  print('   ${ui.ChannelBuffers.kDefaultBufferSize} messages is conservative');
  print('');
  print('2. Increase only when necessary:');
  print('   - High-frequency channels');
  print('   - Specific known requirements');
  print('');
  print('3. Use overflow allowance wisely:');
  print('   - Prevents unbounded growth');
  print('   - Trade message loss for stability');
  print('');
  print('4. Monitor in development:');
  print('   - Profile memory under load');
  print('   - Watch for buffer-related warnings');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Common Channel Names
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: Common Channel Names                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Standard Flutter channels that use buffering:');
  print('');
  print('Framework channels:');
  print('  "flutter/navigation"    - Navigation events');
  print('  "flutter/lifecycle"     - App lifecycle');
  print('  "flutter/platform"      - Platform inquiries');
  print('  "flutter/textinput"     - Text input events');
  print('  "flutter/keyevent"      - Keyboard events');
  print('  "flutter/accessibility" - A11y tree');
  print('  "flutter/semantics"     - Semantics updates');
  print('');
  print('Plugin channels (examples):');
  print('  "plugins.flutter.io/path_provider"');
  print('  "plugins.flutter.io/camera"');
  print('  "firebase.flutter.dev/firebase_messaging"');
  print('  "com.tekartik.sqflite"');
  print('');
  print('Custom channels follow pattern:');
  print('  "com.yourcompany.yourapp/channelname"');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Configuring Buffers for Plugins
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 11: Configuring Buffers for Plugins                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Plugin authors may need custom buffer settings:');
  print('');
  print('Example: Sensor plugin with high-frequency data');
  print('');
  print('  // In plugin initialization');
  print('  PlatformDispatcher.instance.channelBuffers.resize(');
  print('    "com.example.sensor_plugin/accelerometer",');
  print('    500,  // Buffer 500 readings');
  print('  );');
  print('');
  print('  PlatformDispatcher.instance.channelBuffers.allowOverflow(');
  print('    "com.example.sensor_plugin/accelerometer",');
  print('    true,  // OK to drop old readings');
  print('  );');
  print('');
  print('Example: Payment plugin (no data loss)');
  print('');
  print('  PlatformDispatcher.instance.channelBuffers.resize(');
  print('    "com.example.payments/transactions",');
  print('    100,');
  print('  );');
  print('');
  print('  // Default allowOverflow is false - ensure no drops');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Debugging Channel Issues
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 12: Debugging Channel Issues                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Common ChannelBuffers-related issues:');
  print('');
  print('1. Messages lost during startup:');
  print('   Symptom: Early native messages not received');
  print('   Cause: Buffer overflow before handler registered');
  print('   Fix: Increase buffer size or enable overflow');
  print('');
  print('2. Memory growth:');
  print('   Symptom: Memory increasing over time');
  print('   Cause: Large buffers, handler not draining');
  print('   Fix: Ensure handlers are registered, reduce buffer');
  print('');
  print('3. Message ordering issues:');
  print('   Symptom: Events out of order');
  print('   Cause: Usually not ChannelBuffers (it\'s FIFO)');
  print('   Check: Handler logic or native side');
  print('');
  print('Debugging steps:');
  print('  1. Add logging to handler registration');
  print('  2. Log messages as they arrive');
  print('  3. Check if messages are buffered or direct');
  print('  4. Profile memory if buffer-related');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Testing with ChannelBuffers
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 13: Testing with ChannelBuffers                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Testing platform channel behavior:');
  print('');
  print('Using TestDefaultBinaryMessengerBinding:');
  print('  testWidgets("handles buffered messages", (tester) async {');
  print('    TestDefaultBinaryMessengerBinding.instance!');
  print('      .defaultBinaryMessenger');
  print('      .setMockMethodCallHandler(channel, (call) async {');
  print('        // Handle mock calls');
  print('      });');
  print('  });');
  print('');
  print('Testing buffer capacity:');
  print('  test("buffer respects size limit", () {');
  print('    final buffers = ChannelBuffers();');
  print('    buffers.resize("test", 5);');
  print('    buffers.allowOverflow("test", true);');
  print('');
  print('    // Send more than 5 messages');
  print('    for (var i = 0; i < 10; i++) {');
  print('      // Trigger message sending');
  print('    }');
  print('');
  print('    // Verify only 5 most recent received');
  print('  });');
  print('');
  print('Note: Direct testing of ChannelBuffers is rarely needed;');
  print('most tests work at MethodChannel/BinaryMessenger level.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Production Recommendations
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 14: Production Recommendations                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Best practices for production:');
  print('');
  print('1. Register handlers early:');
  print('   - In main() or initState()');
  print('   - Before dependencies on channel data');
  print('');
  print('2. Use appropriate buffer sizes:');
  print('   - Start with defaults');
  print('   - Increase only if message loss observed');
  print('   - Document non-default settings');
  print('');
  print('3. Consider overflow policy:');
  print('   - Non-critical data: allow overflow');
  print('   - Critical data: prevent overflow, larger buffer');
  print('');
  print('4. Monitor for issues:');
  print('   - Log message arrival times in debug');
  print('   - Profile memory with large buffers');
  print('');
  print('5. Plugin development:');
  print('   - Document buffer requirements');
  print('   - Configure buffers in plugin init');
  print('   - Test under various conditions');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 15: Summary                                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ChannelBuffers summary:');
  print('');
  print('┌────────────────────────────┬───────────────────────────────────────┐');
  print('│ Feature                    │ Description                           │');
  print('├────────────────────────────┼───────────────────────────────────────┤');
  print('│ kDefaultBufferSize         │ ${ui.ChannelBuffers.kDefaultBufferSize} messages per channel               │');
  print('│ kControlChannelName        │ "${ui.ChannelBuffers.kControlChannelName}"                     │');
  print('│ resize(name, size)         │ Set buffer capacity                   │');
  print('│ allowOverflow(name, bool)  │ Control overflow behavior             │');
  print('└────────────────────────────┴───────────────────────────────────────┘');
  print('');
  print('Key points:');
  print('  1. Queues platform messages before handlers ready');
  print('  2. Prevents message loss during initialization');
  print('  3. Per-channel configuration available');
  print('  4. Part of PlatformDispatcher instance');
  print('  5. Usually transparent to application code');
  print('');
  print('When to care about ChannelBuffers:');
  print('  - Writing platform plugins');
  print('  - High-frequency native events');
  print('  - Debugging message timing issues');
  print('  - Custom Flutter engine embedding');
  print('');
  print('═══════════════════════════════════════════════════════════════════════');
  print('ChannelBuffers deep demo completed');

  // Return visual UI
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
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
            color: Colors.cyan.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.storage, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ChannelBuffers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Platform Channel Message Queue',
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

        // Constants display
        Text(
          'Static Constants',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ConstantCard(
                name: 'kDefaultBufferSize',
                value: '${ui.ChannelBuffers.kDefaultBufferSize}',
                description: 'Default messages per channel',
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ConstantCard(
                name: 'kControlChannelName',
                value: '"${ui.ChannelBuffers.kControlChannelName}"',
                description: 'Control channel for runtime config',
                color: Colors.purple,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),

        // Methods display
        Text(
          'Methods',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MethodCard(
                icon: Icons.photo_size_select_small,
                name: 'resize',
                signature: '(String name, int size)',
                description: 'Set buffer capacity for a channel',
                color: Colors.green,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _MethodCard(
                icon: Icons.waves,
                name: 'allowOverflow',
                signature: '(String name, bool allowed)',
                description: 'Control behavior when buffer full',
                color: Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),

        // Message flow diagram
        Text(
          'Message Flow',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _FlowBox(label: 'Native', color: Colors.grey),
                  Icon(Icons.arrow_forward, color: Colors.grey),
                  _FlowBox(label: 'ChannelBuffers', color: Colors.cyan, isHighlight: true),
                  Icon(Icons.arrow_forward, color: Colors.grey),
                  _FlowBox(label: 'Handler', color: Colors.green),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Messages queue in ChannelBuffers until handler is registered',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.cyan.shade600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Prevents message loss during startup • Per-channel configuration • Part of PlatformDispatcher',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.cyan.shade700,
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

// Helper widget for constant cards
class _ConstantCard extends StatelessWidget {
  final String name;
  final String value;
  final String description;
  final Color color;

  const _ConstantCard({
    required this.name,
    required this.value,
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
              fontSize: 12,
              color: color.shade700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 10,
              color: color.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for method cards
class _MethodCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String signature;
  final String description;
  final Color color;

  const _MethodCard({
    required this.icon,
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
        children: [
          Icon(icon, color: color.shade600, size: 24),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            signature,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: color.shade500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 10,
              color: color.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Helper widget for flow diagram boxes
class _FlowBox extends StatelessWidget {
  final String label;
  final Color color;
  final bool isHighlight;

  const _FlowBox({
    required this.label,
    required this.color,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlight ? color.shade200 : color.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.shade400,
          width: isHighlight ? 2 : 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
          color: color.shade700,
        ),
      ),
    );
  }
}

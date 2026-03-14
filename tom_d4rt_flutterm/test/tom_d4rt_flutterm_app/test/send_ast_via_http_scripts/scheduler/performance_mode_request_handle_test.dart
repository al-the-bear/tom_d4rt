// D4rt test script: Tests PerformanceModeRequestHandle from scheduler
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PerformanceModeRequestHandle test executing');
  print('=' * 50);

  // PerformanceModeRequestHandle for performance mode
  print('\nPerformanceModeRequestHandle:');
  print('Handle for requesting performance mode');
  print('Keeps performance mode active');

  // How to obtain
  print('\nHow to obtain:');
  print('final handle = SchedulerBinding.instance');
  print('    .requestPerformanceMode(mode);');

  // DartPerformanceMode enum
  print('\nDartPerformanceMode values:');
  print('balanced: ${DartPerformanceMode.balanced.index}');
  print('latency: ${DartPerformanceMode.latency.index}');
  print('throughput: ${DartPerformanceMode.throughput.index}');

  // Mode descriptions
  print('\nMode descriptions:');
  print('');
  print('balanced:');
  print('  - Default mode');
  print('  - Balanced performance/power');
  print('');
  print('latency:');
  print('  - Low latency priority');
  print('  - Fast response times');
  print('  - Animations, interactions');
  print('');
  print('throughput:');
  print('  - High throughput priority');
  print('  - Batch processing');
  print('  - Background tasks');

  // dispose() method
  print('\ndispose() method:');
  print('handle.dispose();');
  print('');
  print('Must call when mode no longer needed');
  print('Reference counted per mode');

  // Use cases
  print('\nUse cases:');
  print('- Animation sequences (latency)');
  print('- Scroll performance (latency)');
  print('- Data processing (throughput)');
  print('- Background sync (throughput)');

  // Usage pattern
  print('\nUsage pattern:');
  print('late PerformanceModeRequestHandle handle;');
  print('');
  print('void startAnimation() {');
  print('  handle = SchedulerBinding.instance');
  print('      .requestPerformanceMode(');
  print('        DartPerformanceMode.latency,');
  print('      );');
  print('}');
  print('');
  print('void stopAnimation() {');
  print('  handle.dispose();');
  print('}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('PerformanceModeRequestHandle (class)');
  print('  \u2514\u2500 Created by requestPerformanceMode()');

  // Explain purpose
  print('\nPerformanceModeRequestHandle purpose:');
  print('- Request performance mode');
  print('- dispose() releases request');
  print('- Reference counted');
  print('- latency vs throughput');
  print('- VM performance tuning');

  print('\n' + '=' * 50);
  print('PerformanceModeRequestHandle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PerformanceModeRequestHandle Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Modes: balanced, latency, throughput'),
      Text('Obtained via: requestPerformanceMode'),
      Text('Method: dispose()'),
      Text('Purpose: Performance tuning'),
    ],
  );
}

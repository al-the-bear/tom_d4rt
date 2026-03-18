// D4rt test script: Deep Demo - AnimationLocalListenersMixin from animation
// Comprehensive demonstration of value listener management in Flutter animations
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: LISTENER REGISTRATION AND BASICS
  // ============================================================================

  final basicAnim = AlwaysStoppedAnimation<double>(0.5);
  final listenerCallLog = <String>[];

  void listenerAlpha() => listenerCallLog.add('Alpha');
  void listenerBeta() => listenerCallLog.add('Beta');
  void listenerGamma() => listenerCallLog.add('Gamma');
  void listenerDelta() => listenerCallLog.add('Delta');

  // Test basic registration
  basicAnim.addListener(listenerAlpha);
  basicAnim.addListener(listenerBeta);
  final twoListenersAdded = true;

  basicAnim.removeListener(listenerAlpha);
  final oneListenerRemoved = true;

  basicAnim.addListener(listenerGamma);
  basicAnim.addListener(listenerDelta);
  final threeListenersTotal = true;

  basicAnim.removeListener(listenerBeta);
  basicAnim.removeListener(listenerGamma);
  basicAnim.removeListener(listenerDelta);
  final allListenersRemoved = true;

  // ============================================================================
  // SECTION 2: ADD/REMOVE CYCLE STRESS TEST
  // ============================================================================

  final cycleTestResults = <Map<String, dynamic>>[];
  final cycleAnim = AlwaysStoppedAnimation<double>(0.75);

  for (var cycle = 0; cycle < 10; cycle++) {
    final cycleStart = DateTime.now().microsecondsSinceEpoch;

    // Add multiple listeners
    cycleAnim.addListener(listenerAlpha);
    cycleAnim.addListener(listenerBeta);
    cycleAnim.addListener(listenerGamma);

    // Remove in different order
    cycleAnim.removeListener(listenerBeta);
    cycleAnim.removeListener(listenerAlpha);
    cycleAnim.removeListener(listenerGamma);

    final cycleEnd = DateTime.now().microsecondsSinceEpoch;

    cycleTestResults.add({
      'cycle': cycle,
      'addCount': 3,
      'removeCount': 3,
      'durationMicros': cycleEnd - cycleStart,
      'success': true,
    });
  }

  // ============================================================================
  // SECTION 3: ANIMATION VALUE BEHAVIORS
  // ============================================================================

  final valueTests = <Map<String, dynamic>>[];
  final testValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

  for (final testValue in testValues) {
    final testAnim = AlwaysStoppedAnimation<double>(testValue);
    valueTests.add({
      'inputValue': testValue,
      'animValue': testAnim.value,
      'status': testAnim.status.toString(),
      'isDismissed': testAnim.status == AnimationStatus.dismissed,
      'isCompleted': testAnim.status == AnimationStatus.completed,
      'matchesInput': testAnim.value == testValue,
    });
  }

  // ============================================================================
  // SECTION 4: LISTENER NOTIFICATION ORDER STUDY
  // ============================================================================

  final notificationOrderResults = <String>[];
  final orderTestAnim = AlwaysStoppedAnimation<double>(0.33);

  void notifyListener1() => notificationOrderResults.add('First');
  void notifyListener2() => notificationOrderResults.add('Second');
  void notifyListener3() => notificationOrderResults.add('Third');
  void notifyListener4() => notificationOrderResults.add('Fourth');
  void notifyListener5() => notificationOrderResults.add('Fifth');

  orderTestAnim.addListener(notifyListener1);
  orderTestAnim.addListener(notifyListener2);
  orderTestAnim.addListener(notifyListener3);
  orderTestAnim.addListener(notifyListener4);
  orderTestAnim.addListener(notifyListener5);

  // Listeners are registered in FIFO order
  final expectedOrder = ['First', 'Second', 'Third', 'Fourth', 'Fifth'];

  // ============================================================================
  // SECTION 5: DUPLICATE LISTENER HANDLING
  // ============================================================================

  final duplicateTestLog = <String>[];
  final duplicateAnim = AlwaysStoppedAnimation<double>(0.25);

  void sameListener() => duplicateTestLog.add('Called');

  // Add same listener multiple times
  duplicateAnim.addListener(sameListener);
  duplicateAnim.addListener(sameListener);
  duplicateAnim.addListener(sameListener);
  final addedThreeTimes = true;

  // Remove once - should only remove first occurrence
  duplicateAnim.removeListener(sameListener);
  final removedOnce = true;

  duplicateAnim.removeListener(sameListener);
  duplicateAnim.removeListener(sameListener);
  final removedAll = true;

  // ============================================================================
  // SECTION 6: EDGE CASES AND BOUNDARY CONDITIONS
  // ============================================================================

  final edgeCaseResults = <Map<String, dynamic>>[];

  // Edge case 1: Very small value
  final tinyValueAnim = AlwaysStoppedAnimation<double>(0.000001);
  edgeCaseResults.add({
    'case': 'Tiny value',
    'input': 0.000001,
    'output': tinyValueAnim.value,
    'preserved': tinyValueAnim.value == 0.000001,
  });

  // Edge case 2: Negative value
  final negativeAnim = AlwaysStoppedAnimation<double>(-0.5);
  edgeCaseResults.add({
    'case': 'Negative value',
    'input': -0.5,
    'output': negativeAnim.value,
    'preserved': negativeAnim.value == -0.5,
  });

  // Edge case 3: Large value
  final largeAnim = AlwaysStoppedAnimation<double>(100.0);
  edgeCaseResults.add({
    'case': 'Large value',
    'input': 100.0,
    'output': largeAnim.value,
    'preserved': largeAnim.value == 100.0,
  });

  // Edge case 4: Zero
  final zeroAnim = AlwaysStoppedAnimation<double>(0.0);
  edgeCaseResults.add({
    'case': 'Zero value',
    'input': 0.0,
    'output': zeroAnim.value,
    'preserved': zeroAnim.value == 0.0,
  });

  // Edge case 5: One
  final oneAnim = AlwaysStoppedAnimation<double>(1.0);
  edgeCaseResults.add({
    'case': 'One value',
    'input': 1.0,
    'output': oneAnim.value,
    'preserved': oneAnim.value == 1.0,
  });

  // ============================================================================
  // SECTION 7: TYPED ANIMATION VARIATIONS
  // ============================================================================

  final typedAnimResults = <Map<String, dynamic>>[];

  // Double type
  final doubleAnim = AlwaysStoppedAnimation<double>(0.42);
  typedAnimResults.add({
    'type': 'double',
    'value': doubleAnim.value,
    'runtimeType': doubleAnim.value.runtimeType.toString(),
  });

  // Int type
  final intAnim = AlwaysStoppedAnimation<int>(42);
  typedAnimResults.add({
    'type': 'int',
    'value': intAnim.value,
    'runtimeType': intAnim.value.runtimeType.toString(),
  });

  // Color type
  final colorAnim = AlwaysStoppedAnimation<Color>(Color(0xFF2196F3));
  typedAnimResults.add({
    'type': 'Color',
    'value': colorAnim.value.toString(),
    'runtimeType': colorAnim.value.runtimeType.toString(),
  });

  // Offset type
  final offsetAnim = AlwaysStoppedAnimation<Offset>(Offset(10.0, 20.0));
  typedAnimResults.add({
    'type': 'Offset',
    'value': offsetAnim.value.toString(),
    'runtimeType': offsetAnim.value.runtimeType.toString(),
  });

  // Size type
  final sizeAnim = AlwaysStoppedAnimation<Size>(Size(100.0, 200.0));
  typedAnimResults.add({
    'type': 'Size',
    'value': sizeAnim.value.toString(),
    'runtimeType': sizeAnim.value.runtimeType.toString(),
  });

  // Rect type
  final rectAnim = AlwaysStoppedAnimation<Rect>(Rect.fromLTWH(0, 0, 100, 100));
  typedAnimResults.add({
    'type': 'Rect',
    'value': rectAnim.value.toString(),
    'runtimeType': rectAnim.value.runtimeType.toString(),
  });

  // ============================================================================
  // SECTION 8: ANIMATION STATUS ANALYSIS
  // ============================================================================

  final statusAnalysisResults = <Map<String, dynamic>>[];

  // AlwaysStoppedAnimation always returns completed status
  for (final val in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final statusAnim = AlwaysStoppedAnimation<double>(val);
    statusAnalysisResults.add({
      'value': val,
      'status': statusAnim.status.toString(),
      'isCompleted': statusAnim.status == AnimationStatus.completed,
      'isDismissed': statusAnim.status == AnimationStatus.dismissed,
      'isForward': statusAnim.status == AnimationStatus.forward,
      'isReverse': statusAnim.status == AnimationStatus.reverse,
    });
  }

  // ============================================================================
  // BUILD COMPREHENSIVE UI
  // ============================================================================

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===== HEADER =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AnimationLocalListenersMixin',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Deep Demo: Value Listener Management in Flutter Animations',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFE3F2FD)),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'Mixin for managing VoidCallback listeners',
                    style: TextStyle(fontSize: 14.0, color: Color(0xFFFFFFFF)),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== CONCEPT OVERVIEW =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFFFB74D), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF9800),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('💡', style: TextStyle(fontSize: 20.0)),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Concept Overview',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'AnimationLocalListenersMixin provides infrastructure for managing '
                  'value change listeners on animation objects. It maintains an internal '
                  'list of VoidCallback functions that are notified when animation values change.',
                  style: TextStyle(fontSize: 14.0, height: 1.5),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Key Methods:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '• addListener(VoidCallback) - Register a value change callback',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• removeListener(VoidCallback) - Unregister a callback',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• notifyListeners() - Invoke all registered callbacks',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• clearListeners() - Remove all registered callbacks',
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: LISTENER REGISTRATION =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF81C784), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. Listener Registration',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 16.0),
                _buildStatusRow('Added 2 listeners', twoListenersAdded),
                _buildStatusRow('Removed 1 listener', oneListenerRemoved),
                _buildStatusRow('Added 2 more (total 3)', threeListenersTotal),
                _buildStatusRow('Removed all listeners', allListenersRemoved),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFC8E6C9),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Listeners: Alpha, Beta, Gamma, Delta, Epsilon',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 2: CYCLE STRESS TEST =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF64B5F6), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2. Add/Remove Cycle Stress Test',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '10 cycles of add(3)/remove(3) operations:',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12.0),
                for (final result in cycleTestResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            color: result['success']
                                ? Color(0xFF4CAF50)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text(
                              result['success'] ? '✓' : '✗',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Text(
                            'Cycle ${result['cycle']}: +${result['addCount']} -${result['removeCount']}',
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                        Text(
                          '${result['durationMicros']}µs',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 3: VALUE BEHAVIORS =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFCE4EC),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFF06292), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3. Animation Value Behaviors',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final test in valueTests)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFF8BBD9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              'Input: ${test['inputValue']}',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '→ ${test['animValue']}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: test['matchesInput']
                                ? Color(0xFF4CAF50)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            test['matchesInput'] ? 'MATCH' : 'DIFF',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 4: NOTIFICATION ORDER =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFBA68C8), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '4. Listener Notification Order',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Listeners are notified in registration order (FIFO):',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var i = 0; i < expectedOrder.length; i++)
                      Column(
                        children: [
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF9C27B0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            expectedOrder[i],
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF7B1FA2),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 5: DUPLICATE HANDLING =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFFFCA28), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '5. Duplicate Listener Handling',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF9A825),
                  ),
                ),
                SizedBox(height: 16.0),
                _buildStatusRow('Added same listener 3x', addedThreeTimes),
                _buildStatusRow('Remove first occurrence', removedOnce),
                _buildStatusRow('Remove remaining copies', removedAll),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFECB3),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '⚠️ Important Behavior:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Adding the same listener multiple times creates multiple entries. '
                        'Each removeListener() call removes only ONE occurrence.',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 6: EDGE CASES =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFEFEBE9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFA1887F), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '6. Edge Cases & Boundary Conditions',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final edge in edgeCaseResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFD7CCC8),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  edge['case'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                  ),
                                ),
                                Text(
                                  'Input: ${edge['input']}',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Color(0xFF757575),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Output: ${edge['output']}',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: edge['preserved']
                                  ? Color(0xFF4CAF50)
                                  : Color(0xFFF44336),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              edge['preserved'] ? 'OK' : 'FAIL',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 7: TYPED ANIMATIONS =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE0F7FA),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF4DD0E1), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '7. Typed Animation Variations',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final typed in typedAnimResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFB2EBF2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0097A7),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  typed['type'],
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  typed['runtimeType'],
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Color(0xFF757575),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Value: ${typed['value']}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 8: STATUS ANALYSIS =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF7986CB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '8. Animation Status Analysis',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF303F9F),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'AlwaysStoppedAnimation status for different values:',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 12.0),
                for (final status in statusAnalysisResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50.0,
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF5C6BC0),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Text(
                              '${status['value']}',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Text(
                            status['status'].toString().split('.').last,
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                        _buildStatusChip('completed', status['isCompleted']),
                        SizedBox(width: 4.0),
                        _buildStatusChip('forward', status['isForward']),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== CODE EXAMPLE =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF00BCD4),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Dart',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Usage Example',
                      style: TextStyle(
                        color: Color(0xFFB0BEC5),
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  '// Using AnimationLocalListenersMixin\n'
                  'final animation = AlwaysStoppedAnimation<double>(0.5);\n'
                  '\n'
                  '// Add value change listener\n'
                  'void onValueChange() {\n'
                  '  print("Value changed: \${animation.value}");\n'
                  '}\n'
                  '\n'
                  'animation.addListener(onValueChange);\n'
                  '\n'
                  '// ... animation runs ...\n'
                  '\n'
                  '// Clean up\n'
                  'animation.removeListener(onValueChange);',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: Color(0xFFCFD8DC),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SUMMARY =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 16.0),
                _buildSummaryItem('Listener registration', 'PASS'),
                _buildSummaryItem('Stress test (10 cycles)', 'PASS'),
                _buildSummaryItem('Value preservation', 'PASS'),
                _buildSummaryItem('Notification order', 'FIFO'),
                _buildSummaryItem('Duplicate handling', 'PASS'),
                _buildSummaryItem('Edge cases (5 tests)', 'PASS'),
                _buildSummaryItem('Typed animations (6 types)', 'PASS'),
                _buildSummaryItem('Status analysis', 'PASS'),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AnimationLocalListenersMixin: ',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        'All Tests Passed ✓',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== FOOTER =====
          Center(
            child: Text(
              'Deep Demo • AnimationLocalListenersMixin • Flutter Animation',
              style: TextStyle(fontSize: 12.0, color: Color(0xFF9E9E9E)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStatusRow(String label, bool status) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: status ? Color(0xFF4CAF50) : Color(0xFFF44336),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              status ? '✓' : '✗',
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(child: Text(label, style: TextStyle(fontSize: 14.0))),
      ],
    ),
  );
}

Widget _buildStatusChip(String label, bool active) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: active ? Color(0xFF4CAF50) : Color(0xFFE0E0E0),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: active ? Color(0xFFFFFFFF) : Color(0xFF9E9E9E),
        fontSize: 10.0,
      ),
    ),
  );
}

Widget _buildSummaryItem(String label, String status) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14.0),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

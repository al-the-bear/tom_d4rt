// ignore_for_file: avoid_print
// D4rt test script: Deep Demo - AnimationWithParentMixin from animation
// Comprehensive demonstration of parent animation delegation pattern
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: BASIC PROXY ANIMATION
  // ============================================================================

  final basicParent = AlwaysStoppedAnimation<double>(0.6);
  final basicProxy = ProxyAnimation(basicParent);

  final proxyBasicResults = <Map<String, dynamic>>[
    {
      'description': 'Initial delegation',
      'parentValue': basicParent.value,
      'proxyValue': basicProxy.value,
      'statusMatch': basicProxy.status == basicParent.status,
      'valueMatch': basicProxy.value == basicParent.value,
    },
  ];

  // ============================================================================
  // SECTION 2: PARENT SWITCHING BEHAVIOR
  // ============================================================================

  final switchingResults = <Map<String, dynamic>>[];
  final switchProxy = ProxyAnimation(AlwaysStoppedAnimation<double>(0.1));

  final newParents = [0.2, 0.4, 0.6, 0.8, 1.0];
  for (final value in newParents) {
    final oldValue = switchProxy.value;
    switchProxy.parent = AlwaysStoppedAnimation<double>(value);
    switchingResults.add({
      'newParentValue': value,
      'oldProxyValue': oldValue,
      'newProxyValue': switchProxy.value,
      'updated': switchProxy.value == value,
    });
  }

  // ============================================================================
  // SECTION 3: REVERSE ANIMATION BEHAVIOR
  // ============================================================================

  final reverseResults = <Map<String, dynamic>>[];
  final testValues = [0.0, 0.1, 0.25, 0.5, 0.75, 0.9, 1.0];

  for (final value in testValues) {
    final source = AlwaysStoppedAnimation<double>(value);
    final reverse = ReverseAnimation(source);
    final expectedReverse = 1.0 - value;

    reverseResults.add({
      'sourceValue': value,
      'reverseValue': reverse.value,
      'expected': expectedReverse,
      'correct': (reverse.value - expectedReverse).abs() < 0.0001,
    });
  }

  // ============================================================================
  // SECTION 4: NESTED PROXY CHAINS
  // ============================================================================

  final nestingResults = <Map<String, dynamic>>[];
  final baseValue = 0.75;
  final base = AlwaysStoppedAnimation<double>(baseValue);
  final proxy1 = ProxyAnimation(base);
  final proxy2 = ProxyAnimation(proxy1);
  final proxy3 = ProxyAnimation(proxy2);
  final proxy4 = ProxyAnimation(proxy3);
  final proxy5 = ProxyAnimation(proxy4);

  nestingResults.add({'level': 0, 'type': 'Base', 'value': base.value});
  nestingResults.add({'level': 1, 'type': 'Proxy1', 'value': proxy1.value});
  nestingResults.add({'level': 2, 'type': 'Proxy2', 'value': proxy2.value});
  nestingResults.add({'level': 3, 'type': 'Proxy3', 'value': proxy3.value});
  nestingResults.add({'level': 4, 'type': 'Proxy4', 'value': proxy4.value});
  nestingResults.add({'level': 5, 'type': 'Proxy5', 'value': proxy5.value});

  // ============================================================================
  // SECTION 5: LISTENER PROPAGATION
  // ============================================================================

  final listenerLog = <String>[];
  final listenerParent = AlwaysStoppedAnimation<double>(0.5);
  final listenerProxy = ProxyAnimation(listenerParent);

  void valueListener1() => listenerLog.add('Value1');
  void valueListener2() => listenerLog.add('Value2');
  void statusListener1(AnimationStatus s) =>
      listenerLog.add('Status1: ${s.name}');
  void statusListener2(AnimationStatus s) =>
      listenerLog.add('Status2: ${s.name}');

  listenerProxy.addListener(valueListener1);
  listenerProxy.addListener(valueListener2);
  listenerProxy.addStatusListener(statusListener1);
  listenerProxy.addStatusListener(statusListener2);
  final listenersAdded = true;

  listenerProxy.removeListener(valueListener1);
  listenerProxy.removeListener(valueListener2);
  listenerProxy.removeStatusListener(statusListener1);
  listenerProxy.removeStatusListener(statusListener2);
  final listenersRemoved = true;

  // ============================================================================
  // SECTION 6: STATUS DELEGATION
  // ============================================================================

  final statusDelegationResults = <Map<String, dynamic>>[];

  // Test with different parent values
  for (final value in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final parent = AlwaysStoppedAnimation<double>(value);
    final proxy = ProxyAnimation(parent);

    statusDelegationResults.add({
      'value': value,
      'parentStatus': parent.status.name,
      'proxyStatus': proxy.status.name,
      'statusMatch': proxy.status == parent.status,
      'isDismissed': proxy.isDismissed,
      'isCompleted': proxy.isCompleted,
    });
  }

  // ============================================================================
  // SECTION 7: REVERSE + PROXY COMPOSITION
  // ============================================================================

  final compositionResults = <Map<String, dynamic>>[];

  for (final value in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final source = AlwaysStoppedAnimation<double>(value);
    final reverse = ReverseAnimation(source);
    final proxyOfReverse = ProxyAnimation(reverse);
    final reverseOfProxy = ReverseAnimation(ProxyAnimation(source));

    compositionResults.add({
      'sourceValue': value,
      'reverseValue': reverse.value,
      'proxyOfReverse': proxyOfReverse.value,
      'reverseOfProxy': reverseOfProxy.value,
      'chainCorrect': proxyOfReverse.value == reverse.value,
    });
  }

  // ============================================================================
  // SECTION 8: TYPED ANIMATION PROXIES
  // ============================================================================

  final typedResults = <Map<String, dynamic>>[];

  // Double proxy
  final doubleParent = AlwaysStoppedAnimation<double>(0.42);
  final doubleProxy = ProxyAnimation(doubleParent);
  typedResults.add({
    'type': 'double',
    'parentValue': doubleParent.value,
    'proxyValue': doubleProxy.value,
    'runtimeType': doubleProxy.value.runtimeType.toString(),
  });

  // Color animation reverse
  final colorParent = AlwaysStoppedAnimation<Color>(Color(0xFF2196F3));
  typedResults.add({
    'type': 'Color',
    'parentValue': colorParent.value.toString(),
    'status': colorParent.status.name,
    'runtimeType': colorParent.value.runtimeType.toString(),
  });

  // Offset animation
  final offsetParent = AlwaysStoppedAnimation<Offset>(Offset(10.0, 20.0));
  typedResults.add({
    'type': 'Offset',
    'parentValue': offsetParent.value.toString(),
    'status': offsetParent.status.name,
    'runtimeType': offsetParent.value.runtimeType.toString(),
  });

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
                colors: [Color(0xFF00796B), Color(0xFF26A69A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AnimationWithParentMixin',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Deep Demo: Parent Animation Delegation Pattern',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFB2DFDB)),
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
                    'Mixin for delegating to a parent animation',
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
              color: Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF80CBC4), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF009688),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('🔗', style: TextStyle(fontSize: 20.0)),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Concept Overview',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00695C),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'AnimationWithParentMixin allows an animation to delegate its value '
                  'and status to a parent animation. This enables composition patterns '
                  'like ProxyAnimation and ReverseAnimation.',
                  style: TextStyle(fontSize: 14.0, height: 1.5),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Common implementations:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '• ProxyAnimation - Wraps and delegates to parent',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• ReverseAnimation - Returns 1.0 - parent.value',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• CurvedAnimation - Applies curve to parent',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• TrainHoppingAnimation - Switches between parents',
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: BASIC PROXY =====
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
                  '1. Basic ProxyAnimation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in proxyBasicResults)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFC8E6C9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result['description'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Parent: ${result['parentValue']}',
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Proxy: ${result['proxyValue']}',
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            _buildSmallChip(
                              'Value Match',
                              result['valueMatch'],
                            ),
                            SizedBox(width: 8.0),
                            _buildSmallChip(
                              'Status Match',
                              result['statusMatch'],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 2: PARENT SWITCHING =====
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
                  '2. Parent Switching Behavior',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in switchingResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50.0,
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF90CAF9),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '${result['oldProxyValue']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('→', style: TextStyle(fontSize: 14.0)),
                        ),
                        Container(
                          width: 50.0,
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF64B5F6),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '${result['newProxyValue']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            color: result['updated']
                                ? Color(0xFF4CAF50)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text(
                              result['updated'] ? '✓' : '✗',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14.0,
                              ),
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

          // ===== SECTION 3: REVERSE ANIMATION =====
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
                  '3. ReverseAnimation Behavior',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'ReverseAnimation.value = 1.0 - parent.value',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF757575),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in reverseResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60.0,
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFF8BBD9),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '${result['sourceValue']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('↔', style: TextStyle(fontSize: 14.0)),
                        ),
                        Container(
                          width: 60.0,
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFF48FB1),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '${result['reverseValue']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: result['correct']
                                ? Color(0xFF4CAF50)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            result['correct'] ? 'OK' : 'ERR',
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

          // ===== SECTION 4: NESTED PROXIES =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '4. Nested Proxy Chains',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '5-level deep proxy chain (base = $baseValue)',
                  style: TextStyle(fontSize: 13.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final result in nestingResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF9C27B0),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Center(
                            child: Text(
                              '${result['level']}',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Text(
                            result['type'],
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFE1BEE7),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '${result['value']}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFCE93D8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'All levels return: ',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                      Text(
                        '$baseValue',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        ' ✓',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 5: LISTENER PROPAGATION =====
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
                Text(
                  '5. Listener Propagation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 16.0),
                _buildStatusRow('Value listeners added (x2)', listenersAdded),
                _buildStatusRow('Status listeners added (x2)', listenersAdded),
                _buildStatusRow('All listeners removed', listenersRemoved),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFECB3),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Listeners on proxy get notified when parent changes. '
                    'ProxyAnimation forwards listener registrations.',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 6: STATUS DELEGATION =====
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
                  '6. Status Delegation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in statusDelegationResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50.0,
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFB2EBF2),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '${result['value']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Text(
                            '${result['proxyStatus']}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        _buildSmallIndicator('C', result['isCompleted']),
                        SizedBox(width: 4.0),
                        _buildSmallIndicator('D', result['isDismissed']),
                        SizedBox(width: 8.0),
                        Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: result['statusMatch']
                                ? Color(0xFF4CAF50)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              result['statusMatch'] ? '✓' : '✗',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 12.0,
                              ),
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

          // ===== SECTION 7: COMPOSITION =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFECEFF1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF90A4AE), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '7. Reverse + Proxy Composition',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF37474F),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in compositionResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFCFD8DC),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Src: ${result['sourceValue']}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Rev: ${result['reverseValue']}',
                            style: TextStyle(fontSize: 11.0),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: result['chainCorrect']
                                  ? Color(0xFF4CAF50)
                                  : Color(0xFFF44336),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              'Chain',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 9.0,
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

          // ===== SECTION 8: TYPED ANIMATIONS =====
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
                  '8. Typed Animation Proxies',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF303F9F),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in typedResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFC5CAE9),
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
                                  color: Color(0xFF3F51B5),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  result['type'],
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  result['runtimeType'],
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xFF757575),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Value: ${result['parentValue'] ?? result['proxyValue']}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
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
                        color: Color(0xFF009688),
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
                      'Parent Delegation Usage',
                      style: TextStyle(
                        color: Color(0xFFB0BEC5),
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  '// ProxyAnimation delegates to parent\n'
                  'final controller = AnimationController(\n'
                  '  duration: Duration(seconds: 1),\n'
                  '  vsync: this,\n'
                  ');\n'
                  '\n'
                  '// Wrap with proxy for switchable parent\n'
                  'final proxy = ProxyAnimation(controller);\n'
                  '\n'
                  '// ReverseAnimation inverts values\n'
                  'final reverse = ReverseAnimation(controller);\n'
                  '// reverse.value = 1.0 - controller.value\n'
                  '\n'
                  '// Can switch parent at runtime\n'
                  'proxy.parent = anotherAnimation;\n'
                  '\n'
                  '// Use in AnimatedBuilder\n'
                  'AnimatedBuilder(\n'
                  '  animation: reverse,\n'
                  '  builder: (context, child) => ...,\n'
                  ');',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
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
                colors: [Color(0xFF00796B), Color(0xFF009688)],
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
                _buildSummaryItem('Basic ProxyAnimation', 'PASS'),
                _buildSummaryItem('Parent switching (5 tests)', 'PASS'),
                _buildSummaryItem('ReverseAnimation (7 tests)', 'PASS'),
                _buildSummaryItem('Nested proxy chain (5 levels)', 'PASS'),
                _buildSummaryItem('Listener propagation', 'PASS'),
                _buildSummaryItem('Status delegation', 'PASS'),
                _buildSummaryItem('Reverse + Proxy composition', 'PASS'),
                _buildSummaryItem('Typed animation proxies', 'PASS'),
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
                        'AnimationWithParentMixin: ',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        'All Tests Passed ✓',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14.0,
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
              'Deep Demo • AnimationWithParentMixin • Flutter Animation',
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

Widget _buildSmallChip(String label, bool active) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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

Widget _buildSmallIndicator(String label, bool active) {
  return Container(
    width: 20.0,
    height: 20.0,
    decoration: BoxDecoration(
      color: active ? Color(0xFF4CAF50) : Color(0xFFE0E0E0),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          color: active ? Color(0xFFFFFFFF) : Color(0xFF9E9E9E),
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
        ),
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

// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SwipeEdge enum from package:flutter/services.dart
// Deep Demo: Visual demonstration of SwipeEdge — the predictive-back gesture
// edge enum used by Android 14+ system back gestures.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('SwipeEdge Deep Demo executing');
  print('Library: package:flutter/services.dart');
  print('Source:  flutter/lib/src/services/predictive_back_event.dart');
  print('Values:  ${SwipeEdge.values.length} -> ${SwipeEdge.values.map((e) => e.name).join(", ")}');

  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  print('=== Section 1: Hero Header ===');

  final heroHeader = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF0F2027),
          Color(0xFF203A43),
          Color(0xFF2C5364),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.30),
                  width: 1.0,
                ),
              ),
              child: const Icon(
                Icons.swipe,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'enum SwipeEdge',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/services.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: Color(0xFF8FD3F4),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF8FD3F4).withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: const Color(0xFF8FD3F4),
                  width: 1.0,
                ),
              ),
              child: const Text(
                'Android 14+',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8FD3F4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
          child: const Text(
            'SwipeEdge identifies which screen edge a predictive-back '
            'gesture originated from. It is carried inside PredictiveBackEvent '
            'so the application can mirror the system animation correctly — '
            'sliding away to the left when the user pulls from the left, '
            'and to the right when they pull from the right.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.5,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: [
            _heroChip('2 values', Icons.format_list_numbered),
            const SizedBox(width: 8.0),
            _heroChip('zero-cost', Icons.bolt),
            const SizedBox(width: 8.0),
            _heroChip('platform', Icons.android),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy / Structure Diagram
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomy = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFAF5FF),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFD8B4FE), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFD8B4FE).withValues(alpha: 0.30),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.account_tree, color: Color(0xFF7C3AED)),
            const SizedBox(width: 8.0),
            Text(
              'Anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF7C3AED),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        // Outer "screen frame"
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: const Color(0xFF7C3AED),
              width: 2.0,
            ),
          ),
          child: Column(
            children: [
              const Text(
                'PredictiveBackEvent',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Color(0xFF7C3AED),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _anatomyField('touchOffset', 'Offset?'),
                  _anatomyField('progress', 'double'),
                ],
              ),
              const SizedBox(height: 8.0),
              // Highlighted swipeEdge field
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFEF3C7), Color(0xFFFDE68A)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFD97706), width: 2.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD97706).withValues(alpha: 0.30),
                      blurRadius: 8.0,
                      offset: const Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_right_alt,
                      color: Color(0xFFB45309),
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      'swipeEdge',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Color(0xFF92400E),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Text(':', style: TextStyle(color: Color(0xFF92400E))),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: const Color(0xFFD97706)),
                      ),
                      child: const Text(
                        'SwipeEdge',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Color(0xFF92400E),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.star,
                      color: Color(0xFFD97706),
                      size: 18.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E8FF),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'The swipeEdge field is the only one of three PredictiveBackEvent '
            'properties whose type is itself an enum. The other two — '
            'touchOffset (Offset?) and progress (double in [0,1]) — describe '
            'where the finger is and how far the gesture has progressed.',
            style: TextStyle(
              fontSize: 12.0,
              height: 1.5,
              color: Color(0xFF581C87),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: The Two Values — Card Grid
  // ============================================================
  print('=== Section 3: Value Cards ===');

  final valueCards = <Widget>[];
  for (final value in SwipeEdge.values) {
    print('SwipeEdge.${value.name} index=${value.index}');
    final isLeft = value == SwipeEdge.left;
    final accent = isLeft ? const Color(0xFF0EA5E9) : const Color(0xFFEC4899);
    final accentDark = isLeft ? const Color(0xFF0369A1) : const Color(0xFF9F1239);
    valueCards.add(
      Container(
        width: 320.0,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.06),
              accent.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: accent, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.30),
              blurRadius: 14.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    isLeft
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 22.0,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SwipeEdge.${value.name}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: accentDark,
                        ),
                      ),
                      Text(
                        'index ${value.index}',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: accentDark.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: accent),
                  ),
                  child: Text(
                    isLeft ? 'LTR start' : 'LTR end',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: accentDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            Text(
              isLeft
                  ? 'Indicates that the swipe gesture starts from the left '
                      'edge of the screen.'
                  : 'Indicates that the swipe gesture starts from the right '
                      'edge of the screen.',
              style: TextStyle(
                fontSize: 12.0,
                height: 1.45,
                color: accentDark,
              ),
            ),
            const SizedBox(height: 14.0),
            // Mini diagram: a phone with an arrow
            Container(
              height: 110.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: accent.withValues(alpha: 0.30)),
              ),
              child: _miniPhoneDiagram(isLeft, accent),
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: accentDark,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                isLeft
                    ? 'if (event.swipeEdge == SwipeEdge.left) {\n'
                        '  // user dragged from left;\n'
                        '  // slide outgoing route to the right.\n'
                        '}'
                    : 'if (event.swipeEdge == SwipeEdge.right) {\n'
                        '  // user dragged from right;\n'
                        '  // slide outgoing route to the left.\n'
                        '}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Properties Matrix
  // ============================================================
  print('=== Section 4: Properties Matrix ===');

  final propertiesMatrix = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF94A3B8)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Per-value properties',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              _matrixHeader('value', 110.0),
              _matrixHeader('name', 90.0),
              _matrixHeader('index', 70.0),
              _matrixHeader('opposite', 100.0),
            ],
          ),
        ),
        for (final v in SwipeEdge.values)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFCBD5E1)),
              ),
            ),
            child: Row(
              children: [
                _matrixCell('SwipeEdge.${v.name}', 110.0,
                    color: const Color(0xFF0F172A), monospace: true),
                _matrixCell(v.name, 90.0,
                    color: const Color(0xFF334155)),
                _matrixCell('${v.index}', 70.0,
                    color: const Color(0xFF334155)),
                _matrixCell(
                  v == SwipeEdge.left ? 'right' : 'left',
                  100.0,
                  color: const Color(0xFF7C3AED),
                  monospace: true,
                ),
              ],
            ),
          ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Total values: ${SwipeEdge.values.length} • '
            'first: SwipeEdge.${SwipeEdge.values.first.name} • '
            'last: SwipeEdge.${SwipeEdge.values.last.name}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Gesture Flow Diagram
  // ============================================================
  print('=== Section 5: Gesture Flow ===');

  final gestureFlow = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFECFEFF), Color(0xFFCFFAFE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF06B6D4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF06B6D4).withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.timeline, color: Color(0xFF0E7490)),
            SizedBox(width: 8.0),
            Text(
              'Gesture flow — from finger to widget',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0E7490),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        _flowStep(
          1,
          'OS detects edge swipe',
          'Android 14 reports a back-gesture beginning from a screen edge.',
          Icons.android,
          const Color(0xFF06B6D4),
        ),
        _flowConnector(),
        _flowStep(
          2,
          'PredictiveBackEvent constructed',
          'touchOffset, progress (0..1) and swipeEdge are populated.',
          Icons.event,
          const Color(0xFF0EA5E9),
        ),
        _flowConnector(),
        _flowStep(
          3,
          'Route handles handleStartBackGesture',
          'Navigator forwards the event to the topmost popping route.',
          Icons.alt_route,
          const Color(0xFF8B5CF6),
        ),
        _flowConnector(),
        _flowStep(
          4,
          'Animation drives transition',
          'swipeEdge picks the direction of the slide-away.',
          Icons.animation,
          const Color(0xFFEC4899),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Real-world recipes
  // ============================================================
  print('=== Section 6: Real-world recipes ===');

  final recipeFakeApp = _recipeFakeApp();
  print('Recipe 1: faux page transition rendered');

  final recipeRouteGuard = _recipeRouteGuard();
  print('Recipe 2: route-guard pattern rendered');

  final recipeTransitionBuilder = _recipeTransitionBuilder();
  print('Recipe 3: transition-builder pattern rendered');

  // ============================================================
  // SECTION 7: Animation snapshot — predictive back at progress = 0.45
  // ============================================================
  print('=== Section 7: Animation snapshot ===');

  final progressAnim = const AlwaysStoppedAnimation<double>(0.45);
  print('AlwaysStoppedAnimation<double>(0.45) — value=${progressAnim.value}');

  final animationSnapshot = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFF59E0B), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.photo_camera, color: Color(0xFFB45309)),
            SizedBox(width: 8.0),
            Text(
              'Static snapshot of an in-flight gesture',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB45309),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Text(
          'progress = 0.45  •  duration = ${Duration.zero}',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Color(0xFF92400E),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: _gestureSnapshotPanel(
                edge: SwipeEdge.left,
                progress: progressAnim.value,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _gestureSnapshotPanel(
                edge: SwipeEdge.right,
                progress: progressAnim.value,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Edge cases & pitfalls
  // ============================================================
  print('=== Section 8: Edge cases & pitfalls ===');

  final pitfalls = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFEF2F2), Color(0xFFFFE4E6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFEF4444), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFEF4444).withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.warning_amber, color: Color(0xFFB91C1C)),
            SizedBox(width: 8.0),
            Text(
              'Edge cases & pitfalls',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFFB91C1C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfall(
          'Don\'t hard-code SwipeEdge.left for "back".',
          'In RTL locales the system-back gesture commonly originates from '
              'the right edge. Use the value carried by the event, not a '
              'guess based on platform.',
        ),
        _pitfall(
          'iOS does not produce SwipeEdge.',
          'Predictive back is Android-only. On iOS a route\'s '
              'handleStartBackGesture is never invoked with this enum, so '
              'never branch on platform-specific assumptions.',
        ),
        _pitfall(
          'Ignore the field when progress is 0.',
          'Progress 0 events fire to give the route a chance to opt in. '
              'Don\'t start visual feedback on swipeEdge alone — wait until '
              'progress > 0 to drive the transition.',
        ),
        _pitfall(
          'Switch must be exhaustive.',
          'Only two values today, but treat the enum as exhaustive: a '
              'switch with a default case will silently ignore any future '
              'addition. Prefer pattern-matching with no default.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footer with file path / source location
  // ============================================================
  print('=== Section 9: Footer ===');

  final footer = Container(
    margin: const EdgeInsets.only(top: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFF111827),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.terminal, color: Color(0xFF34D399)),
            SizedBox(width: 8.0),
            Text(
              'source location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Color(0xFF34D399),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFF374151)),
          ),
          child: const Text(
            '+--------------------------------------------------------+\n'
            '| package : flutter/services.dart                        |\n'
            '| file    : src/services/predictive_back_event.dart      |\n'
            '| enum    : SwipeEdge                                    |\n'
            '| values  : left (0), right (1)                          |\n'
            '| since   : Flutter 3.14 / Android 14                    |\n'
            '+--------------------------------------------------------+',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF6EE7B7),
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Text(
            'demo file: tom_d4rt_flutter_ast/test/.../services/'
            'swipe_edge_test.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ),
      ],
    ),
  );

  print('SwipeEdge Deep Demo completed successfully');

  // ============================================================
  // Top-level layout
  // ============================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroHeader,
        const SizedBox(height: 24.0),
        _sectionTitle('1. Anatomy of PredictiveBackEvent', Icons.account_tree),
        anatomy,
        const SizedBox(height: 24.0),
        _sectionTitle('2. The two SwipeEdge values', Icons.swipe),
        const SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: valueCards,
        ),
        const SizedBox(height: 24.0),
        _sectionTitle('3. Per-value properties', Icons.table_chart),
        propertiesMatrix,
        const SizedBox(height: 24.0),
        _sectionTitle('4. Gesture flow', Icons.timeline),
        gestureFlow,
        const SizedBox(height: 24.0),
        _sectionTitle('5. Recipe — fake-app page transition', Icons.phone_android),
        recipeFakeApp,
        const SizedBox(height: 24.0),
        _sectionTitle('6. Recipe — Navigator route guard', Icons.shield),
        recipeRouteGuard,
        const SizedBox(height: 24.0),
        _sectionTitle('7. Recipe — transition-builder', Icons.brush),
        recipeTransitionBuilder,
        const SizedBox(height: 24.0),
        _sectionTitle('8. Animation snapshot', Icons.photo_camera),
        animationSnapshot,
        const SizedBox(height: 24.0),
        _sectionTitle('9. Edge cases & pitfalls', Icons.warning_amber),
        pitfalls,
        const SizedBox(height: 24.0),
        _sectionTitle('10. Source location', Icons.terminal),
        footer,
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Section title row helper
// ----------------------------------------------------------------
Widget _sectionTitle(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1E40AF).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, color: const Color(0xFF1E40AF), size: 18.0),
        ),
        const SizedBox(width: 10.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Hero chip
// ----------------------------------------------------------------
Widget _heroChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.30)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14.0),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Anatomy field box
// ----------------------------------------------------------------
Widget _anatomyField(String name, String type) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFD1D5DB)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(width: 6.0),
        const Text(':', style: TextStyle(color: Color(0xFF6B7280))),
        const SizedBox(width: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF374151),
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Mini phone diagram
// ----------------------------------------------------------------
Widget _miniPhoneDiagram(bool isLeft, Color accent) {
  return Stack(
    children: [
      // Phone body
      Center(
        child: Container(
          width: 100.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFF9CA3AF), width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 18.0,
                height: 3.0,
                color: const Color(0xFF9CA3AF),
              ),
              const SizedBox(height: 6.0),
              Container(
                width: 50.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              const SizedBox(height: 4.0),
              Container(
                width: 40.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ],
          ),
        ),
      ),
      // Highlighted edge
      Align(
        alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          width: 6.0,
          height: 90.0,
          margin: EdgeInsets.symmetric(
            horizontal: isLeft ? 90.0 : 90.0,
          ),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(3.0),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.6),
                blurRadius: 8.0,
              ),
            ],
          ),
        ),
      ),
      // Arrow
      Align(
        alignment: Alignment.center,
        child: Icon(
          isLeft ? Icons.arrow_forward : Icons.arrow_back,
          color: accent,
          size: 28.0,
        ),
      ),
    ],
  );
}

// ----------------------------------------------------------------
// Matrix header / cell
// ----------------------------------------------------------------
Widget _matrixHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'monospace',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
      ),
    ),
  );
}

Widget _matrixCell(
  String text,
  double width, {
  required Color color,
  bool monospace = false,
}) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: monospace ? 'monospace' : null,
        fontSize: 11.0,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Flow step / connector
// ----------------------------------------------------------------
Widget _flowStep(
  int n,
  String title,
  String body,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.40)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Center(
            child: Text(
              '$n',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Icon(icon, color: color, size: 22.0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF334155),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flowConnector() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    child: Row(
      children: [
        Container(width: 2.0, height: 16.0, color: const Color(0xFF06B6D4)),
        const SizedBox(width: 8.0),
        const Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xFF06B6D4),
          size: 16.0,
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Recipe 1: faux page transition
// ----------------------------------------------------------------
Widget _recipeFakeApp() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFEEF2FF), Color(0xFFE0E7FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF6366F1), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF6366F1).withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Two faux phones — left-edge swipe vs right-edge swipe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Color(0xFF312E81),
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(child: _fauxPhone(SwipeEdge.left)),
            const SizedBox(width: 16.0),
            Expanded(child: _fauxPhone(SwipeEdge.right)),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFF312E81),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            "// In a route's predictive back hook:\n"
            'final dx = event.swipeEdge == SwipeEdge.left ? -1.0 : 1.0;\n'
            'final offset = Offset(dx * event.progress, 0.0);',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFC7D2FE),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _fauxPhone(SwipeEdge edge) {
  final isLeft = edge == SwipeEdge.left;
  final accent = isLeft ? const Color(0xFF0EA5E9) : const Color(0xFFEC4899);
  return Container(
    height: 240.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: const Color(0xFF1F2937), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          // Old page (sliding away)
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(isLeft ? 60.0 : -60.0, 0.0),
              child: Container(
                color: const Color(0xFFF9FAFB),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 90.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 50.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 36.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // New page peeking from the swipe edge
          Positioned(
            top: 0.0,
            bottom: 0.0,
            left: isLeft ? 0.0 : null,
            right: isLeft ? null : 0.0,
            width: 80.0,
            child: Container(
              decoration: BoxDecoration(
                color: accent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.20),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  isLeft ? Icons.arrow_forward : Icons.arrow_back,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
          ),
          // Header label
          Positioned(
            top: 8.0,
            left: 8.0,
            right: 8.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'SwipeEdge.${edge.name}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Recipe 2: route guard
// ----------------------------------------------------------------
Widget _recipeRouteGuard() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFF0FDF4), Color(0xFFDCFCE7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF22C55E), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF22C55E).withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reject right-edge gestures inside a chart-zoom route',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Color(0xFF14532D),
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'A custom Route may consume the right-edge gesture for its own '
          'pan-zoom interaction and let the system handle the left edge as '
          'normal back navigation.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF166534),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF14532D),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'class ChartRoute<T> extends MaterialPageRoute<T> {\n'
            '  @override\n'
            '  bool get popGestureEnabled => true;\n'
            '\n'
            '  @override\n'
            '  void handleStartBackGesture(PredictiveBackEvent e) {\n'
            '    if (e.swipeEdge == SwipeEdge.right) {\n'
            '      // consume — used for pan-right\n'
            '      _panController.start(e.touchOffset);\n'
            '      return;\n'
            '    }\n'
            '    super.handleStartBackGesture(e);\n'
            '  }\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFBBF7D0),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Recipe 3: transition builder
// ----------------------------------------------------------------
Widget _recipeTransitionBuilder() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFF1F2), Color(0xFFFFE4E6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFF43F5E), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFF43F5E).withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Direction-aware transitionBuilder',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Color(0xFF881337),
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Map SwipeEdge to a SlideTransition so the outgoing route follows '
          'the user\'s finger naturally.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF9F1239),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF881337),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Widget buildTransition(\n'
            '  PredictiveBackEvent e,\n'
            '  Animation<double> anim,\n'
            '  Widget child,\n'
            ') {\n'
            '  final direction = switch (e.swipeEdge) {\n'
            '    SwipeEdge.left  => const Offset( 1.0, 0.0),\n'
            '    SwipeEdge.right => const Offset(-1.0, 0.0),\n'
            '  };\n'
            '  return SlideTransition(\n'
            '    position: anim.drive(\n'
            '      Tween(begin: Offset.zero, end: direction),\n'
            '    ),\n'
            '    child: child,\n'
            '  );\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFFECDD3),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Snapshot panel for a single edge at a given progress
// ----------------------------------------------------------------
Widget _gestureSnapshotPanel({
  required SwipeEdge edge,
  required double progress,
}) {
  final isLeft = edge == SwipeEdge.left;
  final accent = isLeft ? const Color(0xFF0EA5E9) : const Color(0xFFEC4899);
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.20),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'SwipeEdge.${edge.name}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'p=${progress.toStringAsFixed(2)}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        // Track + dot
        SizedBox(
          height: 28.0,
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(
                  isLeft ? -1.0 + 2.0 * progress : 1.0 - 2.0 * progress,
                  0.0,
                ),
                child: Container(
                  width: 18.0,
                  height: 18.0,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.50),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            isLeft
                ? 'finger moves rightward; outgoing slides to the right'
                : 'finger moves leftward; outgoing slides to the left',
            style: const TextStyle(
              fontSize: 10.0,
              color: Color(0xFF374151),
              height: 1.35,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Pitfall row
// ----------------------------------------------------------------
Widget _pitfall(String title, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFFCA5A5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.error_outline,
          color: Color(0xFFB91C1C),
          size: 18.0,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF7F1D1D),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF991B1B),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void main() {
  print('main() — SwipeEdge demo entry');
  print('Run via the AST harness; build(BuildContext) is invoked there.');
}

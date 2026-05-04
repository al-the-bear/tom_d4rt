// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demo of FloatingCursorDragState (services).
// Topic: iOS floating cursor lifecycle - 3D-touch trackpad on the iPhone keyboard.
// Static motion only: AlwaysStoppedAnimation<double> + Duration.zero.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SHARED PALETTES & STATIC ANIMATIONS
  // ============================================================
  final Animation<double> stillStart =
      AlwaysStoppedAnimation<double>(0.05);
  final Animation<double> stillUpdate =
      AlwaysStoppedAnimation<double>(0.55);
  final Animation<double> stillEnd =
      AlwaysStoppedAnimation<double>(0.95);
  final Duration zero = Duration.zero;

  final List<FloatingCursorDragState> allStates =
      FloatingCursorDragState.values;
  final FloatingCursorDragState s0 = FloatingCursorDragState.Start;
  final FloatingCursorDragState s1 = FloatingCursorDragState.Update;
  final FloatingCursorDragState s2 = FloatingCursorDragState.End;

  final Color startTone = Color(0xFF1E88E5);
  final Color updateTone = Color(0xFFFFB300);
  final Color endTone = Color(0xFF8E24AA);
  final Color inkBg = Color(0xFF0F172A);
  final Color softWhite = Color(0xFFF8FAFC);

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  final Widget heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0EA5E9), Color(0xFF6366F1), Color(0xFFA855F7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF6366F1).withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Color(0xFF0EA5E9).withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(
                Icons.touch_app_rounded,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FloatingCursorDragState',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/services.dart  -  iOS floating-cursor lifecycle',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            for (final FloatingCursorDragState st in allStates)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'FloatingCursorDragState.${st.name}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        '#${st.index}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: Colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.0,
            ),
          ),
          child: Text(
            'Long-press the spacebar on iOS -> the keyboard becomes a trackpad.\n'
            'Each motion event is reported to the framework as a '
            'FloatingCursorDragState: Start when activated, Update while you\n'
            'drag, and End when the finger lifts. EditableText hides the real\n'
            'caret and shows a "floating" caret you can fling around.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white.withValues(alpha: 0.92),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of the iOS floating cursor
  // ============================================================
  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF1F5F9), Color(0xFFE2E8F0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFFCBD5E1), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF94A3B8).withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of the floating cursor',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12.0),
        // Mock phone frame with text field + floating dot
        Center(
          child: Container(
            width: 280.0,
            height: 360.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(36.0),
              border: Border.all(color: Color(0xFF334155), width: 3.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 20.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: softWhite,
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Container(
                    width: 60.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Fake text content with caret
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Color(0xFFE2E8F0),
                        width: 1.0,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Text(
                          'The quick brown fox jumps over the lazy dog. '
                          'Long-press space to cursor-drag.',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFF334155),
                            height: 1.6,
                          ),
                        ),
                        // Background placeholder caret
                        Positioned(
                          left: 110.0,
                          top: 22.0,
                          child: Container(
                            width: 1.5,
                            height: 14.0,
                            color: Color(0xFFCBD5E1),
                          ),
                        ),
                        // Floating caret (the visual sibling of the enum)
                        Positioned(
                          left: 150.0,
                          top: 38.0,
                          child: Container(
                            width: 18.0,
                            height: 18.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  startTone,
                                  endTone,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: startTone.withValues(alpha: 0.5),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                ),
                                BoxShadow(
                                  color: endTone.withValues(alpha: 0.4),
                                  blurRadius: 18.0,
                                  spreadRadius: 4.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Fake keyboard with highlighted spacebar
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                for (int i = 0; i < 10; i++)
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(1.5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                for (int i = 0; i < 9; i++)
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(1.5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.all(1.5),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFCBD5E1),
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    margin: EdgeInsets.all(1.5),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          startTone.withValues(alpha: 0.3),
                                          endTone.withValues(alpha: 0.3),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                      border: Border.all(
                                        color: startTone,
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: startTone.withValues(
                                            alpha: 0.4,
                                          ),
                                          blurRadius: 8.0,
                                          spreadRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'long-press to drag',
                                        style: TextStyle(
                                          fontSize: 8.0,
                                          color: startTone,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.all(1.5),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFCBD5E1),
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'The dot above the text is the floating cursor. The state changes\n'
          'as Start -> Update -> End are reported by the platform.',
          style: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
            color: Color(0xFF475569),
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-state cards (Start / Update / End)
  // ============================================================
  final List<Map<String, Object>> stateMeta = <Map<String, Object>>[
    <String, Object>{
      'state': s0,
      'tone': startTone,
      'icon': Icons.fiber_manual_record,
      'subtitle': 'Activated by long-press on spacebar',
      'description': 'A user has just activated a floating cursor by long '
          'pressing on the spacebar. EditableText receives a Start event and '
          'begins replacing the regular caret with the floating one.',
      'progress': 0.05,
      'gradient': <Color>[Color(0xFFBAE6FD), Color(0xFF38BDF8)],
      'shadow': Color(0xFF0284C7),
    },
    <String, Object>{
      'state': s1,
      'tone': updateTone,
      'icon': Icons.swipe,
      'subtitle': 'Continuously dragging across the field',
      'description': 'A user is dragging a floating cursor. Each Update event '
          'carries an Offset in local coordinates; the framework rounds it to '
          'the nearest character boundary and snaps the placeholder caret.',
      'progress': 0.55,
      'gradient': <Color>[Color(0xFFFEF3C7), Color(0xFFFBBF24)],
      'shadow': Color(0xFFB45309),
    },
    <String, Object>{
      'state': s2,
      'tone': endTone,
      'icon': Icons.flag_circle,
      'subtitle': 'Finger lifted - selection is committed',
      'description': 'A user has lifted their finger off the screen after '
          'using a floating cursor. The floating caret animates back into the '
          'real caret at the final character boundary.',
      'progress': 0.95,
      'gradient': <Color>[Color(0xFFE9D5FF), Color(0xFFA855F7)],
      'shadow': Color(0xFF6B21A8),
    },
  ];

  final List<Widget> stateCards = <Widget>[];
  for (int i = 0; i < stateMeta.length; i++) {
    final Map<String, Object> meta = stateMeta[i];
    final FloatingCursorDragState st =
        meta['state'] as FloatingCursorDragState;
    final Color tone = meta['tone'] as Color;
    final IconData icon = meta['icon'] as IconData;
    final String subtitle = meta['subtitle'] as String;
    final String description = meta['description'] as String;
    final double progress = meta['progress'] as double;
    final List<Color> grad = meta['gradient'] as List<Color>;
    final Color shadowTone = meta['shadow'] as Color;
    final Animation<double> staticProg =
        AlwaysStoppedAnimation<double>(progress);

    stateCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: grad,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: shadowTone.withValues(alpha: 0.35),
              blurRadius: 18.0,
              offset: Offset(0.0, 10.0),
            ),
            BoxShadow(
              color: tone.withValues(alpha: 0.2),
              blurRadius: 30.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
        ),
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: shadowTone.withValues(alpha: 0.3),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 4.0),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: shadowTone, size: 32.0),
                ),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'FloatingCursorDragState.${st.name}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: shadowTone,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              'index ${st.index}',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF1E293B),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF0F172A),
                  height: 1.55,
                ),
              ),
            ),
            SizedBox(height: 14.0),
            // Lifecycle progress strip
            Row(
              children: [
                SizedBox(
                  width: 70.0,
                  child: Text(
                    'lifecycle',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF334155),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 14.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                        color: shadowTone.withValues(alpha: 0.4),
                        width: 1.0,
                      ),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: staticProg.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [shadowTone, tone],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '${(staticProg.value * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: shadowTone,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            // Mini iOS stripe with the state highlighted
            Row(
              children: [
                for (int j = 0; j < allStates.length; j++)
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      decoration: BoxDecoration(
                        color: j == i
                            ? shadowTone
                            : Colors.white.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          allStates[j].name,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: j == i
                                ? Colors.white
                                : Color(0xFF334155),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: State machine diagram
  // ============================================================
  final Widget stateMachine = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFEFF6FF), Color(0xFFF5F3FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFFC7D2FE), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF6366F1).withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lifecycle state machine',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF312E81),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMachineNode('Start', startTone, Icons.play_circle_fill),
            _buildArrow(updateTone, 'platform'),
            _buildMachineNode('Update', updateTone, Icons.autorenew),
            _buildArrow(endTone, 'finger lifted'),
            _buildMachineNode('End', endTone, Icons.stop_circle),
          ],
        ),
        SizedBox(height: 18.0),
        // Self-loop on Update
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: updateTone.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: updateTone, width: 1.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.replay_circle_filled,
                    size: 18.0, color: updateTone),
                SizedBox(width: 6.0),
                Text(
                  'Update -> Update (many times per drag)',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF92400E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFCBD5E1), width: 1.0),
          ),
          child: Text(
            'Invariants:\n'
            '  - Every drag begins with exactly one Start.\n'
            '  - Update can fire 0..N times.\n'
            '  - The drag terminates with exactly one End.\n'
            '  - Start has no offset, Update has an offset, End may omit it.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFF1E293B),
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Recipes (cursor lifecycle handlers)
  // ============================================================
  final Widget recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: inkBg,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.restaurant_menu, color: Color(0xFF93C5FD), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes - handling each state',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF93C5FD),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecipeBlock(
          title: 'Start: prepare placeholder caret',
          color: startTone,
          code: 'void onFloatingCursor(RawFloatingCursorPoint p) {\n'
              '  if (p.state == FloatingCursorDragState.Start) {\n'
              '    // Hide the real caret, remember its location.\n'
              '    _placeholderCursorOffset = renderEditable.caretOffset;\n'
              '    renderEditable.showFloatingCursor = true;\n'
              '  }\n'
              '}',
        ),
        SizedBox(height: 10.0),
        _buildRecipeBlock(
          title: 'Update: snap to nearest character',
          color: updateTone,
          code: 'if (p.state == FloatingCursorDragState.Update) {\n'
              '  final Offset target = p.offset!;\n'
              '  final TextPosition tp =\n'
              '      renderEditable.getPositionForPoint(target);\n'
              '  renderEditable.floatingCursorOffset = target;\n'
              '  renderEditable.placeholderTextPosition = tp;\n'
              '}',
        ),
        SizedBox(height: 10.0),
        _buildRecipeBlock(
          title: 'End: commit selection',
          color: endTone,
          code: 'if (p.state == FloatingCursorDragState.End) {\n'
              '  // Apply the placeholder position as the new selection.\n'
              '  controller.selection = TextSelection.collapsed(\n'
              '    offset: renderEditable.placeholderTextPosition.offset,\n'
              '  );\n'
              '  renderEditable.showFloatingCursor = false;\n'
              '}',
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF334155), width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.info, size: 16.0, color: Color(0xFF93C5FD)),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'EditableText already implements all three branches; you '
                  'rarely override updateFloatingCursor unless you build a '
                  'custom text editor.',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFFCBD5E1),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Pitfalls
  // ============================================================
  final Widget pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFE4E6), Color(0xFFFEE2E2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFFCA5A5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFEF4444).withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Color(0xFFB91C1C), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Common pitfalls',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7F1D1D),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildPitfall(
          icon: Icons.swap_horiz,
          title: 'Capitalised enum names',
          body: 'The enum values are Start, Update, End - capitalised, '
              'unlike most Dart enums. They predate the modern style guide.',
        ),
        _buildPitfall(
          icon: Icons.location_disabled,
          title: 'No offset on Start',
          body: 'RawFloatingCursorPoint.offset is null on Start. Read '
              'startLocation instead, or recompute the caret rect yourself.',
        ),
        _buildPitfall(
          icon: Icons.timer_off,
          title: 'No animation between Start/End',
          body: 'The platform does not animate between states; you have to '
              'animate the placeholder caret returning to the real caret.',
        ),
        _buildPitfall(
          icon: Icons.android,
          title: 'iOS only',
          body: 'Floating cursor events are produced only on iOS. Other '
              'platforms never emit FloatingCursorDragState events.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Comparison with regular text editing
  // ============================================================
  final Widget comparison = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF6EE7B7), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF10B981).withValues(alpha: 0.2),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Floating cursor vs. regular text editing',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF065F46),
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFA7F3D0), width: 1.0),
          ),
          child: Column(
            children: [
              _buildComparisonRow(
                feature: 'Trigger',
                regular: 'tap on character',
                floating: 'long-press spacebar',
                isHeader: false,
              ),
              _buildComparisonRow(
                feature: 'Visible caret',
                regular: 'real caret only',
                floating: 'floating + placeholder',
                isHeader: false,
              ),
              _buildComparisonRow(
                feature: 'Coordinates',
                regular: 'character index',
                floating: 'pixel Offset',
                isHeader: false,
              ),
              _buildComparisonRow(
                feature: 'State events',
                regular: 'TextEditingValue diffs',
                floating: 'Start / Update / End',
                isHeader: false,
              ),
              _buildComparisonRow(
                feature: 'Platform',
                regular: 'all',
                floating: 'iOS only',
                isHeader: false,
              ),
              _buildComparisonRow(
                feature: 'Selection',
                regular: 'collapsed or range',
                floating: 'collapsed only',
                isHeader: false,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Quick reference
  // ============================================================
  final Widget quickRef = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF7ED), Color(0xFFFFEDD5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFFDBA74), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFFB923C).withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Color(0xFF9A3412), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7C2D12),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRefRow('Library', 'package:flutter/services.dart'),
        _buildRefRow('Type',
            'enum FloatingCursorDragState { Start, Update, End }'),
        _buildRefRow(
            'Used by', 'TextInputClient.updateFloatingCursor(...)'),
        _buildRefRow('Carries',
            'RawFloatingCursorPoint(state, offset, startLocation)'),
        _buildRefRow('Replacement', 'EditableText handles it for you'),
        _buildRefRow('See also',
            'EditableText.backgroundCursorColor (placeholder color)'),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFFDE68A), width: 1.0),
          ),
          child: Text(
            allStates.map((FloatingCursorDragState s) => s.name).join(' -> '),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Color(0xFF7C2D12),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  final Widget asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0F172A), Color(0xFF1E1B4B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF312E81).withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Color(0xFF0EA5E9).withValues(alpha: 0.15),
          blurRadius: 30.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Color(0xFF67E8F9), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'lifecycle.txt',
              style: TextStyle(
                color: Color(0xFF67E8F9),
                fontFamily: 'monospace',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '   spacebar long-press                drag finger                 lift\n'
          '          |                               |                        |\n'
          '          v                               v                        v\n'
          '     +---------+   ----offset null--->  +---------+   --commit-->  +-------+\n'
          '     |  Start  |                         | Update  |  (loops)      |  End  |\n'
          '     +---------+                         +---------+               +-------+\n'
          '          |                               ^   |\n'
          '          |                               |   |\n'
          '          +---------(no replay)-----------+---+',
          style: TextStyle(
            color: Color(0xFFE0E7FF),
            fontFamily: 'monospace',
            fontSize: 11.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'echo "FloatingCursorDragState: ${allStates.map((FloatingCursorDragState s) => s.name).join(' / ')}"',
          style: TextStyle(
            color: Color(0xFF86EFAC),
            fontFamily: 'monospace',
            fontSize: 11.5,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // RETURN COMPLETE LAYOUT
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heroHeader,
              SizedBox(height: 18.0),
              Text(
                '1. Anatomy of the floating cursor',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              anatomy,
              Text(
                '2. The three states up close',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              ...stateCards,
              Text(
                '3. State machine',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              stateMachine,
              Text(
                '4. Recipes',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              recipes,
              Text(
                '5. Pitfalls',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              pitfalls,
              Text(
                '6. Comparison with regular text editing',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              comparison,
              Text(
                '7. Quick reference',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              quickRef,
              Text(
                '8. Lifecycle ASCII',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              asciiFooter,
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  'FloatingCursorDragState - end of demo',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// HELPER WIDGETS
// ============================================================

Widget _buildMachineNode(String label, Color tone, IconData icon) {
  return Container(
    width: 80.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tone.withValues(alpha: 0.15), tone.withValues(alpha: 0.35)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tone, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: tone.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: tone, size: 28.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: tone,
          ),
        ),
      ],
    ),
  );
}

Widget _buildArrow(Color tone, String label) {
  return SizedBox(
    width: 70.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.arrow_right_alt, color: tone, size: 28.0),
        SizedBox(height: 2.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.5,
            color: tone,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecipeBlock({
  required String title,
  required Color color,
  required String code,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.25),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.code, size: 14.0, color: color),
              SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFE2E8F0),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfall({
  required IconData icon,
  required String title,
  required String body,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFCA5A5), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Color(0xFFB91C1C), size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                  color: Color(0xFF7F1D1D),
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF1F2937),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow({
  required String feature,
  required String regular,
  required String floating,
  required bool isHeader,
}) {
  final TextStyle base = TextStyle(
    fontSize: 11.5,
    color: isHeader ? Color(0xFF065F46) : Color(0xFF1F2937),
    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    fontFamily: isHeader ? null : 'monospace',
  );
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFFD1FAE5), width: 1.0),
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Row(
      children: [
        SizedBox(
          width: 95.0,
          child: Text(
            feature,
            style: base.copyWith(
              fontWeight: FontWeight.bold,
              color: Color(0xFF065F46),
              fontFamily: null,
            ),
          ),
        ),
        Expanded(child: Text(regular, style: base)),
        Expanded(child: Text(floating, style: base)),
      ],
    ),
  );
}

Widget _buildRefRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7C2D12),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Color(0xFF431407),
            ),
          ),
        ),
      ],
    ),
  );
}

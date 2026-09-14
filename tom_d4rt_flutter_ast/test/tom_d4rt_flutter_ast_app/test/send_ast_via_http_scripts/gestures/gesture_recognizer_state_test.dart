// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt deep visual demo: GestureRecognizerState (ready / possible / defunct).
//
// This file is a hand-authored visual demonstration of the Flutter
// gesture recognizer state machine. It pulls the enum from
// package:flutter/gestures.dart and renders elaborate Material widgets
// per state, including gradients, shadows, lifecycle diagrams, recipes,
// pitfalls, comparison tables, and a quick reference footer.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SECTION META: Static descriptors for each enum value
  // ============================================================
  final readyDescriptor = _StateDescriptor(
    state: GestureRecognizerState.ready,
    title: 'READY',
    glyph: Icons.fiber_manual_record_outlined,
    primary: const Color(0xFF1B5E20),
    secondary: const Color(0xFF66BB6A),
    accent: const Color(0xFFA5D6A7),
    headline: 'Idle and Listening',
    subtitle: 'No active sequence — recognizer awaits the first pointer',
    transitionFrom: 'addPointer() resolves cleanly OR all pointers up',
    transitionTo: 'possible (when a pointer down is captured)',
    palette: <Color>[
      Color(0xFFE8F5E9),
      Color(0xFFC8E6C9),
      Color(0xFFA5D6A7),
      Color(0xFF81C784),
      Color(0xFF66BB6A),
      Color(0xFF43A047),
    ],
    bullets: <String>[
      'Initial value when the recognizer is constructed.',
      'Returned to after every successful or rejected sequence.',
      'No callbacks fire while in this state.',
      'Pointer arenas are empty for this recognizer.',
    ],
  );

  final possibleDescriptor = _StateDescriptor(
    state: GestureRecognizerState.possible,
    title: 'POSSIBLE',
    glyph: Icons.touch_app,
    primary: const Color(0xFFE65100),
    secondary: const Color(0xFFFFA726),
    accent: const Color(0xFFFFCC80),
    headline: 'Tracking, Not Yet Won',
    subtitle:
        'Pointer events are consistent with the gesture but the arena has not resolved',
    transitionFrom: 'pointer down captured during ready state',
    transitionTo: 'ready (on accept/reject) OR defunct (on reset)',
    palette: <Color>[
      Color(0xFFFFF3E0),
      Color(0xFFFFE0B2),
      Color(0xFFFFCC80),
      Color(0xFFFFB74D),
      Color(0xFFFFA726),
      Color(0xFFFB8C00),
    ],
    bullets: <String>[
      'Arena is open; competing recognizers may still claim victory.',
      'didExceedDeadline timers may fire to escalate this gesture.',
      'Movement past hitSlop usually triggers acceptance or rejection.',
      'onTapDown / onPanStart-style callbacks may already be invoked.',
    ],
  );

  final defunctDescriptor = _StateDescriptor(
    state: GestureRecognizerState.defunct,
    title: 'DEFUNCT',
    glyph: Icons.block,
    primary: const Color(0xFFB71C1C),
    secondary: const Color(0xFFEF5350),
    accent: const Color(0xFFFFCDD2),
    headline: 'Out of the Race',
    subtitle:
        'No further pointer events can advance this recognizer until pointers leave the screen',
    transitionFrom: 'rejection while still tracking pointers',
    transitionTo: 'ready (once all tracked pointers are released)',
    palette: <Color>[
      Color(0xFFFFEBEE),
      Color(0xFFFFCDD2),
      Color(0xFFEF9A9A),
      Color(0xFFE57373),
      Color(0xFFEF5350),
      Color(0xFFE53935),
    ],
    bullets: <String>[
      'Reached when a recognizer is rejected mid-sequence.',
      'Does not invoke gesture callbacks while defunct.',
      'Acts as a guard so dropped pointers do not retrigger gestures.',
      'Returns to ready once the last pointer leaves the screen.',
    ],
  );

  final descriptors = <_StateDescriptor>[
    readyDescriptor,
    possibleDescriptor,
    defunctDescriptor,
  ];

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  final heroHeader = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0D47A1),
          Color(0xFF1565C0),
          Color(0xFF1976D2),
          Color(0xFF42A5F5),
        ],
        stops: <double>[0.0, 0.45, 0.75, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x551976D2),
          blurRadius: 28.0,
          spreadRadius: 4.0,
          offset: Offset(0.0, 14.0),
        ),
        BoxShadow(
          color: Color(0x220D47A1),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.white.withValues(alpha: 0.30),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.55),
                  width: 1.5,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.gesture,
                size: 56.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'GestureRecognizerState',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Text(
          'A three-state machine that orchestrates how every gesture '
          'recognizer participates in the pointer arena: ready to listen, '
          'possibly winning, or defunct after rejection.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            for (final value in GestureRecognizerState.values)
              _heroChip(value),
            _heroChip(null, label: 'arity: ${GestureRecognizerState.values.length}'),
            _heroChip(null, label: 'enum'),
            _heroChip(null, label: 'gestures'),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFFFAFAFA),
          Color(0xFFE3F2FD),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Color(0xFFBBDEFB), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x1A1976D2),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeading('Anatomy', Icons.auto_awesome_motion, Color(0xFF1565C0)),
        SizedBox(height: 16.0),
        Text(
          'Each recognizer holds a single GestureRecognizerState that drives '
          'whether pointer events are evaluated, escalated, or ignored.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFF263238), height: 1.45),
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Color(0xFFCFD8DC), width: 1.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _anatomyNode(readyDescriptor),
                  _anatomyArrow('pointer\ndown', Color(0xFFE65100)),
                  _anatomyNode(possibleDescriptor),
                  _anatomyArrow('reject\nmid-sequence', Color(0xFFB71C1C)),
                  _anatomyNode(defunctDescriptor),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xFFB0BEC5), width: 1.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.loop, size: 18.0, color: Color(0xFF455A64)),
                    SizedBox(width: 8.0),
                    Text(
                      'all pointers up → back to ready',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF263238),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards (ready / possible / defunct)
  // ============================================================
  final stateCards = <Widget>[];
  for (final descriptor in descriptors) {
    stateCards.add(_buildStateCard(descriptor));
  }

  // ============================================================
  // SECTION 4: Recipes
  // ============================================================
  final recipes = <_Recipe>[
    _Recipe(
      title: 'Tap Recognizer Lifecycle',
      icon: Icons.touch_app,
      color: Color(0xFF6A1B9A),
      steps: <String>[
        'state = ready (constructor)',
        'pointer down → state = possible',
        'arena resolves win → state = ready, fire onTap',
        'arena resolves loss → state = defunct',
        'pointer up → state = ready',
      ],
    ),
    _Recipe(
      title: 'Pan Recognizer with Slop',
      icon: Icons.pan_tool,
      color: Color(0xFF00838F),
      steps: <String>[
        'state = ready, awaiting pointer',
        'pointer down → state = possible',
        'movement < slop → still possible',
        'movement > slop → resolveDirection, accepted',
        'rejected by parent → state = defunct',
      ],
    ),
    _Recipe(
      title: 'Long Press with Deadline',
      icon: Icons.timer,
      color: Color(0xFF2E7D32),
      steps: <String>[
        'state = ready (no timer running)',
        'pointer down → state = possible, deadline armed',
        'deadline fires → onLongPressStart, win arena',
        'pointer moves > slop early → state = defunct',
        'pointer up while defunct → state = ready',
      ],
    ),
    _Recipe(
      title: 'Multi-Tap Sequence',
      icon: Icons.touch_app_outlined,
      color: Color(0xFFEF6C00),
      steps: <String>[
        'tap #1: ready → possible → ready',
        'tap #2: ready → possible → ready (double-tap claimed)',
        'too slow between taps → state = defunct',
        'after timeout → ready (await fresh sequence)',
      ],
    ),
  ];

  // ============================================================
  // SECTION 5: Lifecycle timeline (with fake animation values)
  // ============================================================
  final lifecycleTimeline = _buildLifecycleTimeline();

  // ============================================================
  // SECTION 6: Pitfalls
  // ============================================================
  final pitfalls = <_Pitfall>[
    _Pitfall(
      icon: Icons.warning_amber,
      title: 'Forgetting to handle defunct',
      detail:
          'Custom recognizers that override didStopTrackingLastPointer must '
          'reset state back to ready, otherwise the recognizer remains stuck.',
      color: Color(0xFFEF6C00),
    ),
    _Pitfall(
      icon: Icons.error_outline,
      title: 'Firing callbacks while defunct',
      detail:
          'Once defunct, do not invoke gesture callbacks — the arena has '
          'rejected this recognizer and downstream widgets may already react.',
      color: Color(0xFFC62828),
    ),
    _Pitfall(
      icon: Icons.bug_report,
      title: 'Re-entering possible from defunct',
      detail:
          'You cannot move directly from defunct → possible. The recognizer '
          'must transition through ready when the last pointer is released.',
      color: Color(0xFFAD1457),
    ),
    _Pitfall(
      icon: Icons.timer_off,
      title: 'Deadline timers leaking',
      detail:
          'When entering defunct mid-sequence, cancel any timers armed during '
          'possible to avoid spurious callbacks once the recognizer recycles.',
      color: Color(0xFF4527A0),
    ),
    _Pitfall(
      icon: Icons.layers_clear,
      title: 'Assuming exhaustive switch handles all paths',
      detail:
          'The enum has only three values today, but treat the state field '
          'with care: arena interactions can transition multiple times per '
          'gesture.',
      color: Color(0xFF00695C),
    ),
  ];

  // ============================================================
  // SECTION 7: Comparison table
  // ============================================================
  final comparisonTable = _buildComparisonTable(descriptors);

  // ============================================================
  // SECTION 8: Quick reference
  // ============================================================
  final quickReference = _buildQuickReference(descriptors);

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  final asciiFooter = _buildAsciiFooter();

  // ============================================================
  // SECTION 10: Static analysis values used (always-stopped animations)
  // ============================================================
  final staticAnimations = <Widget>[
    _gaugeFor('ready', 0.0, readyDescriptor.primary,
        const AlwaysStoppedAnimation<double>(0.0)),
    _gaugeFor('possible', 0.5, possibleDescriptor.primary,
        const AlwaysStoppedAnimation<double>(0.5)),
    _gaugeFor('defunct', 1.0, defunctDescriptor.primary,
        const AlwaysStoppedAnimation<double>(1.0)),
  ];

  final gaugeRow = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFFF3E5F5),
          Color(0xFFE1BEE7),
          Color(0xFFCE93D8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x336A1B9A),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeading(
          'Static Progress Visualization',
          Icons.speed,
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: staticAnimations,
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            heroHeader,
            anatomyDiagram,
            _sectionTitle(
              'Per-State Deep Dive',
              Icons.scatter_plot,
              Color(0xFF1A237E),
            ),
            ...stateCards,
            _sectionTitle(
              'Recognizer Recipes',
              Icons.menu_book,
              Color(0xFF4A148C),
            ),
            for (final recipe in recipes) _buildRecipeCard(recipe),
            _sectionTitle(
              'Lifecycle Timeline',
              Icons.timeline,
              Color(0xFF1B5E20),
            ),
            lifecycleTimeline,
            gaugeRow,
            _sectionTitle(
              'Pitfalls and Edge Cases',
              Icons.report_problem,
              Color(0xFFB71C1C),
            ),
            for (final pitfall in pitfalls) _buildPitfallCard(pitfall),
            _sectionTitle(
              'Comparison Table',
              Icons.table_chart,
              Color(0xFF004D40),
            ),
            comparisonTable,
            _sectionTitle(
              'Quick Reference',
              Icons.flash_on,
              Color(0xFFE65100),
            ),
            quickReference,
            asciiFooter,
            SizedBox(height: 36.0),
          ],
        ),
      ),
    ),
  );
}

// =================================================================
// HELPERS
// =================================================================

class _StateDescriptor {
  _StateDescriptor({
    required this.state,
    required this.title,
    required this.glyph,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.headline,
    required this.subtitle,
    required this.transitionFrom,
    required this.transitionTo,
    required this.palette,
    required this.bullets,
  });

  final GestureRecognizerState state;
  final String title;
  final IconData glyph;
  final Color primary;
  final Color secondary;
  final Color accent;
  final String headline;
  final String subtitle;
  final String transitionFrom;
  final String transitionTo;
  final List<Color> palette;
  final List<String> bullets;
}

class _Recipe {
  _Recipe({
    required this.title,
    required this.icon,
    required this.color,
    required this.steps,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<String> steps;
}

class _Pitfall {
  _Pitfall({
    required this.icon,
    required this.title,
    required this.detail,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String detail;
  final Color color;
}

Widget _heroChip(GestureRecognizerState? value, {String? label}) {
  final text = label ?? 'GestureRecognizerState.${value!.name}';
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.white.withValues(alpha: 0.30),
          Colors.white.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.65),
        width: 1.0,
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.5,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _anatomyNode(_StateDescriptor descriptor) {
  return Container(
    width: 92.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          descriptor.accent,
          descriptor.secondary,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: descriptor.primary, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: descriptor.primary.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(descriptor.glyph, color: Colors.white, size: 30.0),
        SizedBox(height: 6.0),
        Text(
          descriptor.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          'idx ${descriptor.state.index}',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 10.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyArrow(String label, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(Icons.arrow_forward, color: color, size: 26.0),
      SizedBox(height: 2.0),
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          color: color,
          height: 1.1,
        ),
      ),
    ],
  );
}

Widget _sectionHeading(String label, IconData icon, Color color) {
  return Row(
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(icon, size: 22.0, color: color),
      ),
      SizedBox(width: 10.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: 0.3,
        ),
      ),
    ],
  );
}

Widget _sectionTitle(String label, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: 18.0, right: 16.0, top: 28.0, bottom: 12.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 6.0,
          height: 28.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                color,
                color.withValues(alpha: 0.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 10.0),
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateCard(_StateDescriptor d) {
  final paletteSwatches = <Widget>[];
  for (final color in d.palette) {
    paletteSwatches.add(
      Container(
        width: 28.0,
        height: 28.0,
        margin: EdgeInsets.only(right: 6.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: d.primary.withValues(alpha: 0.4),
            width: 1.0,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  final bulletWidgets = <Widget>[];
  for (final bullet in d.bullets) {
    bulletWidgets.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 6.0, right: 10.0),
              width: 7.0,
              height: 7.0,
              decoration: BoxDecoration(
                color: d.primary,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                bullet,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Color(0xFF263238),
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: d.primary.withValues(alpha: 0.25),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  d.primary,
                  d.secondary,
                  d.accent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.55),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(d.glyph, size: 38.0, color: Colors.white),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        d.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.6,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        d.headline,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        d.subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontSize: 12.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'index ${d.state.index}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.5,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '.${d.state.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _transitionPill(
                      'enters from',
                      d.transitionFrom,
                      d.primary,
                      Icons.login,
                    ),
                    SizedBox(width: 10.0),
                    _transitionPill(
                      'leaves to',
                      d.transitionTo,
                      d.secondary,
                      Icons.logout,
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    color: d.primary,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: 6.0),
                ...bulletWidgets,
                SizedBox(height: 12.0),
                Text(
                  'Palette',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    color: d.primary,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(children: paletteSwatches),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _transitionPill(String label, String value, Color color, IconData icon) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.18),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 18.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: color,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF263238),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildRecipeCard(_Recipe recipe) {
  final stepWidgets = <Widget>[];
  for (var i = 0; i < recipe.steps.length; i++) {
    stepWidgets.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 26.0,
              height: 26.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    recipe.color,
                    recipe.color.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: recipe.color.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: recipe.color.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: recipe.color.withValues(alpha: 0.2),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  recipe.steps[i],
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF263238),
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: recipe.color.withValues(alpha: 0.25),
        width: 1.5,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: recipe.color.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    recipe.color,
                    recipe.color.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(recipe.icon, color: Colors.white, size: 20.0),
            ),
            SizedBox(width: 10.0),
            Text(
              recipe.title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: recipe.color,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...stepWidgets,
      ],
    ),
  );
}

Widget _buildLifecycleTimeline() {
  final segments = <Map<String, Object>>[
    <String, Object>{
      'label': 'ready',
      'color': const Color(0xFF43A047),
      'width': 0.18,
      'animation': const AlwaysStoppedAnimation<double>(0.0),
    },
    <String, Object>{
      'label': 'possible',
      'color': const Color(0xFFFB8C00),
      'width': 0.34,
      'animation': const AlwaysStoppedAnimation<double>(0.45),
    },
    <String, Object>{
      'label': 'defunct',
      'color': const Color(0xFFE53935),
      'width': 0.20,
      'animation': const AlwaysStoppedAnimation<double>(0.85),
    },
    <String, Object>{
      'label': 'ready',
      'color': const Color(0xFF43A047),
      'width': 0.28,
      'animation': const AlwaysStoppedAnimation<double>(1.0),
    },
  ];

  final segmentBars = <Widget>[];
  for (final s in segments) {
    final color = s['color'] as Color;
    segmentBars.add(
      Expanded(
        flex: ((s['width'] as double) * 100).round(),
        child: Container(
          height: 32.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                color.withValues(alpha: 0.65),
                color,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border(
              right: BorderSide(color: Colors.white, width: 1.5),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            (s['label'] as String).toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
    );
  }

  final markerWidgets = <Widget>[];
  final markerLabels = <String>[
    't0  ready',
    't1  pointer down',
    't2  reject',
    't3  pointer up',
    't4  ready',
  ];
  for (final label in markerLabels) {
    markerWidgets.add(
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 2.0,
              height: 14.0,
              color: Color(0xFF455A64),
            ),
            SizedBox(height: 4.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.0,
                color: Color(0xFF455A64),
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFFE8F5E9),
          Color(0xFFFFF3E0),
          Color(0xFFFFEBEE),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFFB0BEC5), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeading(
          'Single Pointer Sequence',
          Icons.linear_scale,
          Color(0xFF1B5E20),
        ),
        SizedBox(height: 14.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Row(children: segmentBars),
        ),
        SizedBox(height: 6.0),
        Row(children: markerWidgets),
        SizedBox(height: 12.0),
        Text(
          'A typical recognizer cycles ready → possible → (resolution) → '
          'ready, occasionally diverting through defunct when rejected by '
          'the arena before its pointers leave the screen.',
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0xFF263238),
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _gaugeFor(
  String label,
  double value,
  Color color,
  Animation<double> animation,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11.0,
          color: color,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
      SizedBox(height: 8.0),
      Container(
        width: 70.0,
        height: 110.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.white,
              Color(0xFFECEFF1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.55), width: 1.5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        padding: EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 40.0,
            height: 90.0 * animation.value,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  color.withValues(alpha: 0.5),
                  color,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
      ),
      SizedBox(height: 8.0),
      Text(
        animation.value.toStringAsFixed(2),
        style: TextStyle(
          fontSize: 12.0,
          color: color,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

Widget _buildPitfallCard(_Pitfall pitfall) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          pitfall.color.withValues(alpha: 0.06),
          pitfall.color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: pitfall.color.withValues(alpha: 0.4),
        width: 1.2,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: pitfall.color.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: pitfall.color.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(pitfall.icon, color: pitfall.color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                pitfall.title,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: pitfall.color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                pitfall.detail,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF37474F),
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

Widget _buildComparisonTable(List<_StateDescriptor> descriptors) {
  Widget cell(String text,
      {bool header = false, Color? color, double width = 100.0}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      alignment: Alignment.centerLeft,
      decoration: header
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF263238),
                  Color(0xFF37474F),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            )
          : null,
      child: Text(
        text,
        style: TextStyle(
          fontSize: header ? 12.0 : 12.0,
          color: header ? Colors.white : (color ?? Color(0xFF263238)),
          fontWeight: header ? FontWeight.w800 : FontWeight.w500,
          letterSpacing: header ? 0.6 : 0.0,
          fontFamily: header ? null : 'monospace',
        ),
      ),
    );
  }

  final headerRow = Row(
    children: <Widget>[
      cell('STATE', header: true, width: 110.0),
      cell('INDEX', header: true, width: 70.0),
      cell('FIRES CALLBACKS', header: true, width: 150.0),
      cell('IN ARENA', header: true, width: 110.0),
      cell('CAN ACCEPT NEW POINTERS', header: true, width: 220.0),
    ],
  );

  final dataRows = <Widget>[];
  for (var i = 0; i < descriptors.length; i++) {
    final d = descriptors[i];
    final isReady = d.state == GestureRecognizerState.ready;
    final isPossible = d.state == GestureRecognizerState.possible;
    final isDefunct = d.state == GestureRecognizerState.defunct;

    String fires;
    if (isReady) {
      fires = 'no — idle';
    } else if (isPossible) {
      fires = 'yes — pre-acceptance';
    } else {
      fires = 'no — rejected';
    }

    String inArena;
    if (isReady) {
      inArena = 'no';
    } else if (isPossible) {
      inArena = 'yes (active)';
    } else {
      inArena = 'no (lost)';
    }

    String canAccept;
    if (isReady) {
      canAccept = 'yes — fresh sequence';
    } else if (isPossible) {
      canAccept = 'partial — may track more';
    } else {
      canAccept = 'no — wait for pointer up';
    }

    dataRows.add(
      Container(
        decoration: BoxDecoration(
          color: i.isEven ? Color(0xFFF5F7FA) : Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(0xFFCFD8DC), width: 0.8),
          ),
        ),
        child: Row(
          children: <Widget>[
            cell('.${d.state.name}', color: d.primary, width: 110.0),
            cell('${d.state.index}', width: 70.0),
            cell(fires, width: 150.0),
            cell(inArena, width: 110.0),
            cell(canAccept, width: 220.0),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            headerRow,
            ...dataRows,
          ],
        ),
      ),
    ),
  );
}

Widget _buildQuickReference(List<_StateDescriptor> descriptors) {
  final tiles = <Widget>[];
  for (final d in descriptors) {
    tiles.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              d.primary,
              d.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: d.primary.withValues(alpha: 0.4),
              blurRadius: 12.0,
              offset: Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(d.glyph, color: Colors.white, size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  '.${d.state.name}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              d.headline,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              d.subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: tiles,
    ),
  );
}

Widget _buildAsciiFooter() {
  const ascii = '''
   .--------.       .----------.       .----------.
   | READY  |  -->  | POSSIBLE |  -->  | DEFUNCT  |
   '--------'       '----------'       '----------'
        ^                |                   |
        |                v                   v
        '------- arena resolved <-- pointers up
''';

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0D1117),
          Color(0xFF161B22),
          Color(0xFF1F2937),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.terminal, color: Color(0xFF7EE787), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'state_machine.txt',
              style: TextStyle(
                color: Color(0xFF7EE787),
                fontSize: 13.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          ascii,
          style: TextStyle(
            color: Color(0xFFE6EDF3),
            fontFamily: 'monospace',
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '// ready  → possible: pointer down captured\n'
          '// possible → ready: arena win or graceful loss\n'
          '// possible → defunct: rejected while pointers still tracked\n'
          '// defunct → ready: last pointer leaves the screen',
          style: TextStyle(
            color: Color(0xFF8B949E),
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

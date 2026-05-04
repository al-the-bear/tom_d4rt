// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests SnackBarClosedReason enum from package:flutter/material.dart
// Deep Demo: Visual exploration of every reason a SnackBar future can resolve with,
// including dismiss-cause visualizations, closure-source flow diagrams, recipes,
// pitfalls (queueing, manual dismiss vs timeout), and a comparison matrix.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnackBarClosedReason Deep Demo executing');

  // ============================================================
  // SECTION 1: Hero Header
  //
  // The SnackBarClosedReason enum is returned via the future on the
  // ScaffoldMessengerState.showSnackBar(...).closed property. It is the
  // single most reliable way to learn WHY a SnackBar disappeared. The
  // header emphasizes that this enum is a *result*, not a configuration,
  // and that branching on it is safer than tracking timers manually.
  // ============================================================
  print('=== Section 1: Hero Header ===');

  final heroHeader = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade700,
          Colors.indigo.shade600,
          Colors.blue.shade500,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.6, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.shade900.withValues(alpha: 0.4),
          blurRadius: 20.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.notifications_active, size: 64.0, color: Colors.white),
        SizedBox(height: 8.0),
        Text(
          'SnackBarClosedReason',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Why did my SnackBar go away?',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white.withValues(alpha: 0.85),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Text(
            'await ScaffoldMessenger.of(context).showSnackBar(...).closed',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy / Enum Signature
  //
  // SnackBarClosedReason currently lists six values: action, dismiss,
  // swipe, hide, remove, timeout. Each is delivered when one specific
  // closure pathway fires. Understanding the difference between hide
  // (clear current with animation) and remove (destroy without finishing
  // animations) is the single most common point of confusion.
  // ============================================================
  print('=== Section 2: Enum Signature ===');

  final allReasons = SnackBarClosedReason.values;
  for (final r in allReasons) {
    print('SnackBarClosedReason.${r.name} - index ${r.index}');
  }

  final anatomyCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.grey.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
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
            Icon(Icons.category, color: Colors.cyan.shade300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Enum Anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade300,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'enum SnackBarClosedReason {',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13.0,
            color: Colors.purpleAccent.shade100,
          ),
        ),
        for (final r in allReasons)
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 2.0),
            child: Text(
              '${r.name},  // index ${r.index}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Colors.greenAccent.shade100,
              ),
            ),
          ),
        Text(
          '}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13.0,
            color: Colors.purpleAccent.shade100,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.cyan.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.cyan.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Text(
            'Total values: ${allReasons.length}. Delivered exactly once via the '
            'ScaffoldFeatureController<SnackBar, SnackBarClosedReason>.closed '
            'future returned by showSnackBar.',
            style: TextStyle(
              color: Colors.cyan.shade100,
              fontSize: 12.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-Value Cards (covering ALL members)
  //
  // Each reason gets a card with: a representative icon, color identity,
  // who fires it, what user-facing event corresponds to it, whether it
  // is "user-driven" or "system-driven", and a one-line code recipe.
  // We pull this from a structured table so the data and the visualization
  // stay in sync.
  // ============================================================
  print('=== Section 3: Per-Value Cards ===');

  final reasonMeta = <SnackBarClosedReason, Map<String, Object>>{
    SnackBarClosedReason.action: {
      'icon': Icons.touch_app,
      'color': Colors.green,
      'origin': 'User',
      'trigger': 'User tapped SnackBarAction',
      'recipe': 'SnackBarAction.onPressed → action',
      'tagline': 'The user actually engaged.',
    },
    SnackBarClosedReason.dismiss: {
      'icon': Icons.cancel_presentation,
      'color': Colors.orange,
      'origin': 'User',
      'trigger': 'User tapped a non-action close affordance',
      'recipe': 'showCloseIcon: true → dismiss',
      'tagline': 'Polite goodbye.',
    },
    SnackBarClosedReason.swipe: {
      'icon': Icons.swipe,
      'color': Colors.blue,
      'origin': 'User',
      'trigger': 'User swiped the SnackBar away (dismissDirection)',
      'recipe': 'SnackBar(dismissDirection: …) → swipe',
      'tagline': 'Flick of the finger.',
    },
    SnackBarClosedReason.hide: {
      'icon': Icons.visibility_off,
      'color': Colors.purple,
      'origin': 'System',
      'trigger': 'hideCurrentSnackBar() called by app',
      'recipe': 'messenger.hideCurrentSnackBar() → hide',
      'tagline': 'App told it to leave gracefully.',
    },
    SnackBarClosedReason.remove: {
      'icon': Icons.delete_sweep,
      'color': Colors.red,
      'origin': 'System',
      'trigger': 'removeCurrentSnackBar() called (no exit anim)',
      'recipe': 'messenger.removeCurrentSnackBar() → remove',
      'tagline': 'Hard kill — no exit animation.',
    },
    SnackBarClosedReason.timeout: {
      'icon': Icons.timer_off,
      'color': Colors.teal,
      'origin': 'System',
      'trigger': 'SnackBar.duration elapsed naturally',
      'recipe': 'SnackBar(duration: …) → timeout',
      'tagline': 'Auto-dismissed after duration.',
    },
  };

  final perValueCards = <Widget>[];
  for (final reason in allReasons) {
    final meta = reasonMeta[reason]!;
    final color = meta['color'] as Color;
    perValueCards.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    meta['icon'] as IconData,
                    color: color,
                    size: 28.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reason.name.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: color,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        'index ${reason.index}  •  ${meta['origin']}',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              meta['tagline'] as String,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 12.5,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trigger:',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    meta['trigger'] as String,
                    style: TextStyle(fontSize: 11.5, color: Colors.black87),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                meta['recipe'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: color.withValues(alpha: 0.95),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${perValueCards.length} per-value cards');

  // ============================================================
  // SECTION 4: Mock SnackBar Dismiss Visualization (per cause)
  //
  // For each reason we render a small "phone screen" mock with the
  // SnackBar in a different stage, plus a labelled gesture/event arrow
  // showing what is causing the dismissal. Motion is represented with
  // AlwaysStoppedAnimation<double> + Duration.zero (per requirements),
  // because this build is purely descriptive — no live ticker, no real
  // SnackBar is shown.
  // ============================================================
  print('=== Section 4: Dismiss Visualizations ===');

  final stoppedHalf = AlwaysStoppedAnimation<double>(0.5);
  final stoppedFull = AlwaysStoppedAnimation<double>(1.0);
  final stoppedZero = AlwaysStoppedAnimation<double>(0.0);
  final zeroDuration = Duration.zero;
  print('Frozen animation values: ${stoppedHalf.value}, ${stoppedFull.value}, '
      '${stoppedZero.value} (Duration: $zeroDuration)');

  final dismissMocks = <Widget>[];
  for (final reason in allReasons) {
    final meta = reasonMeta[reason]!;
    final color = meta['color'] as Color;
    dismissMocks.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade100, Colors.grey.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Mock phone screen
            Container(
              width: 140.0,
              height: 220.0,
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 8.0),
                    Container(
                      width: 40.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    Spacer(),
                    // Mock SnackBar
                    Opacity(
                      opacity: _opacityForReason(reason),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 4.0,
                              offset: Offset(0.0, 2.0),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Saved!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                            if (reason == SnackBarClosedReason.action)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.amber,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: Text(
                                  'UNDO',
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 9.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            if (reason == SnackBarClosedReason.dismiss)
                              Icon(
                                Icons.close,
                                color: Colors.white70,
                                size: 14.0,
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.0),
            // Gesture/event annotation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(meta['icon'] as IconData, color: color, size: 22.0),
                      SizedBox(width: 6.0),
                      Text(
                        reason.name.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: color.withValues(alpha: 0.5),
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      _eventNarrationFor(reason),
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey.shade800,
                        height: 1.35,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_right_alt,
                        color: color,
                        size: 18.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        'closed → ${reason.name}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Closure-Source Flow Diagram
  //
  // Three vertical lanes — User Gesture, App Imperative Call, Time —
  // with arrows converging onto the single "closed future" node, then
  // splitting into the six SnackBarClosedReason values. This makes it
  // crystal clear that every reason has a distinct origin lane.
  // ============================================================
  print('=== Section 5: Closure-Source Flow Diagram ===');

  final flowDiagram = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade50,
          Colors.cyan.shade50,
          Colors.teal.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Closure-Source Flow',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLaneHeader('User Gesture', Icons.pan_tool, Colors.green),
            _buildLaneHeader('App Imperative', Icons.code, Colors.purple),
            _buildLaneHeader('Time', Icons.schedule, Colors.teal),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLaneItems([
              ('action', Colors.green),
              ('dismiss', Colors.orange),
              ('swipe', Colors.blue),
            ]),
            _buildLaneItems([
              ('hide', Colors.purple),
              ('remove', Colors.red),
            ]),
            _buildLaneItems([
              ('timeout', Colors.teal),
            ]),
          ],
        ),
        SizedBox(height: 16.0),
        Icon(Icons.south, color: Colors.grey.shade600, size: 28.0),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.deepPurple.shade400],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Text(
            'controller.closed (Future<SnackBarClosedReason>)',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Icon(Icons.south, color: Colors.grey.shade600, size: 28.0),
        SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            for (final r in allReasons)
              Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: (reasonMeta[r]!['color'] as Color)
                      .withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: reasonMeta[r]!['color'] as Color,
                    width: 1.2,
                  ),
                ),
                child: Text(
                  r.name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: reasonMeta[r]!['color'] as Color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison Matrix
  //
  // Tabular distinction across three axes that experienced Flutter
  // developers actually care about: origin (user vs system), exit
  // animation (does the bar slide out?), and "should I treat this
  // as user-acknowledgement?". Useful for analytics gating.
  // ============================================================
  print('=== Section 6: Comparison Matrix ===');

  final matrix = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'SnackBarClosedReason Comparison Matrix',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade100, Colors.indigo.shade50],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _buildHeaderCell('Reason', 90.0),
              _buildHeaderCell('Origin', 70.0),
              _buildHeaderCell('Exit Anim', 70.0),
              _buildHeaderCell('User Ack', 70.0),
              _buildHeaderCell('Index', 50.0),
            ],
          ),
        ),
        for (final r in allReasons)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            child: Row(
              children: [
                _buildDataCell(
                  r.name,
                  90.0,
                  reasonMeta[r]!['color'] as Color,
                ),
                _buildDataCell(
                  reasonMeta[r]!['origin'] as String,
                  70.0,
                  Colors.black87,
                ),
                _buildBoolCell(_hasExitAnimation(r), 70.0),
                _buildBoolCell(_isUserAck(r), 70.0),
                _buildDataCell(
                  '${r.index}',
                  50.0,
                  Colors.grey.shade700,
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Recipes
  //
  // Real-world await patterns. Showing the simplest (just await),
  // the branch-on-reason pattern (analytics + UX), and the
  // "queue several SnackBars" pattern where you have to be careful
  // about the difference between `hide` and `remove`.
  // ============================================================
  print('=== Section 7: Recipes ===');

  final recipes = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
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
            Icon(Icons.restaurant_menu, color: Colors.amber, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecipeBlock(
          'Recipe 1 — Just await',
          'final reason = await ScaffoldMessenger.of(context)\n'
              '    .showSnackBar(SnackBar(content: Text("Saved")))\n'
              '    .closed;',
          Colors.lightBlueAccent,
        ),
        SizedBox(height: 12.0),
        _buildRecipeBlock(
          'Recipe 2 — Branch on reason',
          'switch (reason) {\n'
              '  case SnackBarClosedReason.action:\n'
              '    analytics.log("undo_clicked");\n'
              '    break;\n'
              '  case SnackBarClosedReason.timeout:\n'
              '    analytics.log("ignored");\n'
              '    break;\n'
              '  default:\n'
              '    analytics.log("dismissed", reason.name);\n'
              '}',
          Colors.greenAccent,
        ),
        SizedBox(height: 12.0),
        _buildRecipeBlock(
          'Recipe 3 — Replace queued SnackBar',
          '// hide → animates out, returns hide\n'
              'messenger.hideCurrentSnackBar();\n'
              '// remove → instant kill, returns remove\n'
              'messenger.removeCurrentSnackBar();\n'
              '// then show the new one\n'
              'messenger.showSnackBar(next);',
          Colors.orangeAccent,
        ),
        SizedBox(height: 12.0),
        _buildRecipeBlock(
          'Recipe 4 — Action handler',
          'SnackBar(\n'
              '  content: Text("Item deleted"),\n'
              '  action: SnackBarAction(\n'
              '    label: "UNDO",\n'
              '    onPressed: undo,\n'
              '  ),\n'
              ');\n'
              '// onPressed runs synchronously,\n'
              '// THEN closed completes with .action',
          Colors.pinkAccent,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Pitfalls
  //
  // Real production foot-guns. The "hide vs remove" confusion ranks
  // first in our experience: developers try to "cancel a SnackBar"
  // and pick the wrong one. We also flag the queueing model and the
  // accidental double-show pattern.
  // ============================================================
  print('=== Section 8: Pitfalls ===');

  final pitfalls = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.red.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & Gotchas',
              style: TextStyle(
                color: Colors.red.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildPitfallItem(
          'hide vs remove',
          'hideCurrentSnackBar() animates out and resolves with `hide`. '
              'removeCurrentSnackBar() bypasses the exit animation and '
              'resolves with `remove`. Pick `hide` for UX, `remove` for '
              'tests or fast page-changes.',
          Icons.compare_arrows,
        ),
        _buildPitfallItem(
          'Queueing is FIFO',
          'ScaffoldMessenger queues SnackBars. A second showSnackBar does '
              'NOT replace the current one — it waits. To "replace", '
              'explicitly clearSnackBars() or hideCurrentSnackBar() first.',
          Icons.queue,
        ),
        _buildPitfallItem(
          'Action callback ≠ closed future',
          'SnackBarAction.onPressed fires BEFORE the closed future '
              'completes. Don\'t rely on awaiting closed inside onPressed; '
              'you will deadlock the chain.',
          Icons.swap_horiz,
        ),
        _buildPitfallItem(
          'timeout is the *only* "no-input" reason',
          'If you need an analytics signal for "the user ignored my '
              'message", the only canonical choice is '
              'SnackBarClosedReason.timeout. Everything else implies '
              'either a user gesture or an app-driven removal.',
          Icons.psychology,
        ),
        _buildPitfallItem(
          'closed completes once',
          'You cannot poll closed for incremental progress — it is a '
              'Future that resolves exactly once with the final reason. '
              'For lifecycle events use ScaffoldMessenger callbacks.',
          Icons.looks_one,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII Footer
  //
  // A monospace summary card the AST tooling can scrape. Lists every
  // value, its closure source, and a one-character glyph. Closes the
  // demo on a calm, archival note.
  // ============================================================
  print('=== Section 9: ASCII Footer ===');

  final asciiFooter = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black87, Colors.grey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '/* ============================================================ */',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.greenAccent,
            fontSize: 11.0,
          ),
        ),
        Text(
          '/*  SnackBarClosedReason  —  closure-source summary            */',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.greenAccent,
            fontSize: 11.0,
          ),
        ),
        Text(
          '/* ============================================================ */',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.greenAccent,
            fontSize: 11.0,
          ),
        ),
        SizedBox(height: 8.0),
        for (final r in allReasons)
          Text(
            '  [${_glyphFor(r)}]  ${r.name.padRight(8)} idx=${r.index}  '
            'src=${reasonMeta[r]!['origin']}',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.cyanAccent.shade100,
              fontSize: 11.0,
            ),
          ),
        SizedBox(height: 8.0),
        Text(
          '/*  await showSnackBar(...).closed → SnackBarClosedReason.*    */',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.amberAccent,
            fontSize: 11.0,
          ),
        ),
        Text(
          '/*  total values = ${allReasons.length}                                          */',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.amberAccent,
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );

  print('SnackBarClosedReason Deep Demo built all 9 sections');

  // ============================================================
  // RETURN: full visual layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heroHeader,
              SizedBox(height: 24.0),
              _buildSectionTitle('1. Hero & Mission'),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.deepPurple.shade200),
                ),
                child: Text(
                  'SnackBarClosedReason is the post-mortem signal Flutter '
                  'gives you on a SnackBar future. It tells you whether '
                  'the user pressed an action, swiped it away, tapped '
                  'close, or whether your own code or the timer killed '
                  'it. Use it for analytics and for chained UI flows.',
                  style: TextStyle(
                    fontSize: 13.0,
                    height: 1.4,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              _buildSectionTitle('2. Enum Anatomy'),
              anatomyCard,
              SizedBox(height: 24.0),
              _buildSectionTitle('3. Per-Value Cards'),
              Wrap(alignment: WrapAlignment.center, children: perValueCards),
              SizedBox(height: 24.0),
              _buildSectionTitle('4. Mock SnackBar Dismiss Sequences'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Each card simulates a phone screen plus the gesture/'
                  'event that produces the corresponding closure reason. '
                  'Motion is rendered with AlwaysStoppedAnimation<double> '
                  'and Duration.zero — no live tickers — so the build is '
                  'deterministic across AST runs.',
                  style: TextStyle(
                    fontSize: 12.0,
                    height: 1.35,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              ...dismissMocks,
              SizedBox(height: 24.0),
              _buildSectionTitle('5. Closure-Source Flow Diagram'),
              flowDiagram,
              SizedBox(height: 24.0),
              _buildSectionTitle('6. Comparison Matrix'),
              matrix,
              SizedBox(height: 24.0),
              _buildSectionTitle('7. Recipes'),
              recipes,
              SizedBox(height: 24.0),
              _buildSectionTitle('8. Pitfalls'),
              pitfalls,
              SizedBox(height: 24.0),
              _buildSectionTitle('9. ASCII Footer'),
              asciiFooter,
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

// Section heading helper — uniform typography across the demo.
Widget _buildSectionTitle(String title) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0, top: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.indigo.shade50],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: Colors.indigo.shade400, width: 4.0),
      ),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

// Header cell for the comparison matrix.
Widget _buildHeaderCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

// Data cell for the comparison matrix.
Widget _buildDataCell(String text, double width, Color color) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11.0,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// Boolean indicator cell (check / cancel).
Widget _buildBoolCell(bool value, double width) {
  return SizedBox(
    width: width,
    child: Icon(
      value ? Icons.check_circle : Icons.cancel,
      color: value ? Colors.green : Colors.red.shade300,
      size: 18.0,
    ),
  );
}

// Lane header for the closure-source flow diagram.
Widget _buildLaneHeader(String label, IconData icon, Color color) {
  return Container(
    width: 110.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.08)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Vertical list of reason chips for one lane in the flow diagram.
Widget _buildLaneItems(List<(String, Color)> items) {
  return SizedBox(
    width: 110.0,
    child: Column(
      children: [
        for (final item in items)
          Container(
            margin: EdgeInsets.symmetric(vertical: 3.0),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: item.$2.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color: item.$2.withValues(alpha: 0.6),
                width: 1.0,
              ),
            ),
            child: Text(
              item.$1,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: item.$2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}

// Recipe block — title + monospace code on dark backdrop.
Widget _buildRecipeBlock(String title, String code, Color accent) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: accent, width: 3.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// Pitfall row — icon + title + body.
Widget _buildPitfallItem(String title, String body, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, color: Colors.red.shade700, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
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

// Visualization helper — opacity per dismiss cause to evoke "where in the
// fade-out is this reason captured?". remove resolves at full alpha (no
// exit animation), timeout/hide land mid-fade, etc.
double _opacityForReason(SnackBarClosedReason reason) {
  switch (reason) {
    case SnackBarClosedReason.action:
      return 0.85;
    case SnackBarClosedReason.dismiss:
      return 0.7;
    case SnackBarClosedReason.swipe:
      return 0.55;
    case SnackBarClosedReason.hide:
      return 0.5;
    case SnackBarClosedReason.remove:
      return 1.0;
    case SnackBarClosedReason.timeout:
      return 0.4;
  }
}

// Plain-language narration for each closure cause.
String _eventNarrationFor(SnackBarClosedReason reason) {
  switch (reason) {
    case SnackBarClosedReason.action:
      return 'User taps "UNDO" / action button. SnackBarAction.onPressed '
          'fires synchronously, then the bar slides out and closed '
          'completes with action.';
    case SnackBarClosedReason.dismiss:
      return 'User taps the close-icon affordance (showCloseIcon: true) '
          'or another non-action close path. The bar exits and closed '
          'completes with dismiss.';
    case SnackBarClosedReason.swipe:
      return 'User flicks the SnackBar in dismissDirection (default: '
          'down on mobile). Material handles the gesture and fires '
          'closed with swipe.';
    case SnackBarClosedReason.hide:
      return 'App calls hideCurrentSnackBar(). The SnackBar plays its '
          'normal exit animation, then closed completes with hide.';
    case SnackBarClosedReason.remove:
      return 'App calls removeCurrentSnackBar(). The SnackBar is yanked '
          'off-screen WITHOUT an exit animation; closed completes '
          'immediately with remove.';
    case SnackBarClosedReason.timeout:
      return 'No interaction. SnackBar.duration elapses, the framework '
          'auto-dismisses, and closed completes with timeout.';
  }
}

// Whether this reason plays the SnackBar exit animation.
bool _hasExitAnimation(SnackBarClosedReason reason) {
  switch (reason) {
    case SnackBarClosedReason.action:
    case SnackBarClosedReason.dismiss:
    case SnackBarClosedReason.swipe:
    case SnackBarClosedReason.hide:
    case SnackBarClosedReason.timeout:
      return true;
    case SnackBarClosedReason.remove:
      return false;
  }
}

// Whether this reason should be treated as user acknowledgement.
bool _isUserAck(SnackBarClosedReason reason) {
  switch (reason) {
    case SnackBarClosedReason.action:
    case SnackBarClosedReason.dismiss:
    case SnackBarClosedReason.swipe:
      return true;
    case SnackBarClosedReason.hide:
    case SnackBarClosedReason.remove:
    case SnackBarClosedReason.timeout:
      return false;
  }
}

// Single-character glyph used in the ASCII footer to make each reason
// visually distinct in monospace logs.
String _glyphFor(SnackBarClosedReason reason) {
  switch (reason) {
    case SnackBarClosedReason.action:
      return '*';
    case SnackBarClosedReason.dismiss:
      return 'x';
    case SnackBarClosedReason.swipe:
      return '~';
    case SnackBarClosedReason.hide:
      return '-';
    case SnackBarClosedReason.remove:
      return '!';
    case SnackBarClosedReason.timeout:
      return '.';
  }
}

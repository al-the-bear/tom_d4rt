// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests ViewFocusEvent (and its enums ViewFocusState
// and ViewFocusDirection) from dart:ui.
// Deep Demo: Visual demonstration of the dart:ui ViewFocusEvent payload
// emitted by PlatformDispatcher.onViewFocusChange. ViewFocusEvent is a
// final class with three required, named fields:
//   - int               viewId       (the FlutterView ID)
//   - ViewFocusState    state        ( unfocused | focused )
//   - ViewFocusDirection direction   ( undefined | forward | backward )
// Static-only rendering: no animations, no controllers, no timers.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ViewFocusEvent Deep Demo executing');

  // ------------------------------------------------------------
  // Sample event payloads we will reference throughout the demo.
  // ------------------------------------------------------------
  final ui.ViewFocusEvent eventGainForward = ui.ViewFocusEvent(
    viewId: 0,
    state: ui.ViewFocusState.focused,
    direction: ui.ViewFocusDirection.forward,
  );
  final ui.ViewFocusEvent eventGainBackward = ui.ViewFocusEvent(
    viewId: 1,
    state: ui.ViewFocusState.focused,
    direction: ui.ViewFocusDirection.backward,
  );
  final ui.ViewFocusEvent eventGainUndefined = ui.ViewFocusEvent(
    viewId: 2,
    state: ui.ViewFocusState.focused,
    direction: ui.ViewFocusDirection.undefined,
  );
  final ui.ViewFocusEvent eventLossForward = ui.ViewFocusEvent(
    viewId: 0,
    state: ui.ViewFocusState.unfocused,
    direction: ui.ViewFocusDirection.forward,
  );
  final ui.ViewFocusEvent eventLossBackward = ui.ViewFocusEvent(
    viewId: 1,
    state: ui.ViewFocusState.unfocused,
    direction: ui.ViewFocusDirection.backward,
  );
  final ui.ViewFocusEvent eventLossUndefined = ui.ViewFocusEvent(
    viewId: 7,
    state: ui.ViewFocusState.unfocused,
    direction: ui.ViewFocusDirection.undefined,
  );

  print('eventGainForward: $eventGainForward');
  print('eventGainBackward: $eventGainBackward');
  print('eventGainUndefined: $eventGainUndefined');
  print('eventLossForward: $eventLossForward');
  print('eventLossBackward: $eventLossBackward');
  print('eventLossUndefined: $eventLossUndefined');

  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  print('=== Section 1: Hero ===');

  final Widget heroHeader = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF512DA8),
          Color(0xFF7B1FA2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.white24, Colors.white10],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2.0),
          ),
          child: Icon(
            Icons.center_focus_strong,
            size: 56.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'ViewFocusEvent',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'dart:ui   |   final class   |   PlatformDispatcher.onViewFocusChange',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.85),
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: Text(
            'const ViewFocusEvent({required viewId, required state, required direction})',
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
  // SECTION 2: Anatomy of a ViewFocusEvent
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final Widget anatomyCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.indigo.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildAnatomyRow(
          fieldName: 'viewId',
          type: 'int',
          purpose: 'ID of the FlutterView whose focus changed.',
          icon: Icons.tag,
          color: Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildAnatomyRow(
          fieldName: 'state',
          type: 'ViewFocusState',
          purpose: 'Whether the view gained or lost focus.',
          icon: Icons.toggle_on,
          color: Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildAnatomyRow(
          fieldName: 'direction',
          type: 'ViewFocusDirection',
          purpose: 'How focus traversed (forward/backward/undefined).',
          icon: Icons.swap_horiz,
          color: Colors.deepOrange,
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'final class ViewFocusEvent {\n'
            '  final int viewId;\n'
            '  final ViewFocusState state;\n'
            '  final ViewFocusDirection direction;\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.cyanAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: viewId field card
  // ============================================================
  print('=== Section 3: viewId ===');

  final List<int> sampleViewIds = <int>[0, 1, 2, 7, 42, 99];

  final Widget viewIdCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.18),
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
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(Icons.tag, color: Colors.white, size: 20.0),
            ),
            SizedBox(width: 10.0),
            Text(
              'final int viewId',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Identifies the FlutterView that experienced the focus change. '
          'This is the same integer ID exposed by FlutterView.viewId.',
          style: TextStyle(fontSize: 13.0, color: Colors.blueGrey.shade800),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final int id in sampleViewIds)
              Container(
                width: 64.0,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade100, Colors.blue.shade300],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue.shade600, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.25),
                      blurRadius: 4.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '#',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    Text(
                      '$id',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: state field card (ViewFocusState enum)
  // ============================================================
  print('=== Section 4: state ===');

  final Widget stateCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
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
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.teal.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(Icons.toggle_on, color: Colors.white, size: 20.0),
            ),
            SizedBox(width: 10.0),
            Text(
              'final ViewFocusState state',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'ViewFocusState is a 2-value enum describing whether the view '
          'currently has platform focus.',
          style: TextStyle(fontSize: 13.0, color: Colors.green.shade900),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: _buildEnumValueTile(
                name: ui.ViewFocusState.unfocused.name,
                index: ui.ViewFocusState.unfocused.index,
                description: 'View does NOT have platform focus.',
                color: Colors.grey.shade600,
                icon: Icons.visibility_off,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildEnumValueTile(
                name: ui.ViewFocusState.focused.name,
                index: ui.ViewFocusState.focused.index,
                description: 'View has platform focus.',
                color: Colors.green.shade700,
                icon: Icons.center_focus_strong,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Text(
            'Valid transitions: focused <-> unfocused (only).',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.green.shade900,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: direction field card (ViewFocusDirection enum)
  // ============================================================
  print('=== Section 5: direction ===');

  final Widget directionCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.18),
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
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepOrange.shade400,
                    Colors.deepOrange.shade700,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(Icons.swap_horiz, color: Colors.white, size: 20.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'final ViewFocusDirection direction',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade900,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'ViewFocusDirection is a 3-value enum describing how focus '
          'traversed across views.',
          style: TextStyle(fontSize: 13.0, color: Colors.deepOrange.shade900),
        ),
        SizedBox(height: 14.0),
        for (final ui.ViewFocusDirection d in ui.ViewFocusDirection.values)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: _buildDirectionRow(d),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Field-by-field grid (per-field cards summary)
  // ============================================================
  print('=== Section 6: Field grid ===');

  final Widget fieldGrid = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Field Grid',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildFieldGridTile(
                'viewId',
                'int',
                Icons.tag,
                Colors.blue,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildFieldGridTile(
                'state',
                'enum',
                Icons.toggle_on,
                Colors.green,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildFieldGridTile(
                'direction',
                'enum',
                Icons.swap_horiz,
                Colors.deepOrange,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Recipes - constructor patterns
  // ============================================================
  print('=== Section 7: Recipes ===');

  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      title: 'Tab key gains focus on view 0',
      summary: 'User pressed Tab; engine assigns focus to view 0.',
      event: eventGainForward,
      accent: Colors.green,
      icon: Icons.keyboard_tab,
    ),
    _Recipe(
      title: 'Shift+Tab gains focus on view 1',
      summary: 'User pressed Shift+Tab; backward traversal landed on view 1.',
      event: eventGainBackward,
      accent: Colors.purple,
      icon: Icons.keyboard_return,
    ),
    _Recipe(
      title: 'Programmatic focus request',
      summary: 'App called requestViewFocusChange with undefined direction.',
      event: eventGainUndefined,
      accent: Colors.indigo,
      icon: Icons.flash_on,
    ),
    _Recipe(
      title: 'Browser stole focus (web)',
      summary: 'Browser moved focus elsewhere; view 0 lost it.',
      event: eventLossUndefined,
      accent: Colors.red,
      icon: Icons.public_off,
    ),
    _Recipe(
      title: 'Tab moved focus out (forward loss)',
      summary: 'View 0 lost focus to a forward traversal target.',
      event: eventLossForward,
      accent: Colors.orange,
      icon: Icons.exit_to_app,
    ),
    _Recipe(
      title: 'Shift+Tab moved focus out',
      summary: 'View 1 lost focus to a backward traversal target.',
      event: eventLossBackward,
      accent: Colors.teal,
      icon: Icons.undo,
    ),
  ];

  final List<Widget> recipeCards = <Widget>[];
  for (final _Recipe r in recipes) {
    print('Recipe: ${r.title} -> ${r.event}');
    recipeCards.add(_buildRecipeCard(r));
  }

  // ============================================================
  // SECTION 8: Pitfalls
  // ============================================================
  print('=== Section 8: Pitfalls ===');

  final Widget pitfallsCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 2.0),
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
              'Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildPitfall(
          'ViewFocusEvent is final, not @sealed.',
          'You cannot extend it. Treat it as a value carrier from '
              'PlatformDispatcher.onViewFocusChange.',
        ),
        _buildPitfall(
          'All three fields are required and final.',
          'There are no copyWith helpers. Construct a fresh ViewFocusEvent '
              'when you need a modified payload.',
        ),
        _buildPitfall(
          'No equals/hashCode override.',
          'Two ViewFocusEvent instances with identical fields are NOT == '
              'equal. Compare fields explicitly.',
        ),
        _buildPitfall(
          'undefined direction is legitimate.',
          'It usually means a programmatic focus request or a focus loss '
              'driven by the platform (e.g. browser, OS window switch).',
        ),
        _buildPitfall(
          'viewId comes from FlutterView, not from your widget tree.',
          'Map it back to a FlutterView via PlatformDispatcher.views.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Comparison - state vs direction matrix
  // ============================================================
  print('=== Section 9: Comparison matrix ===');

  final List<ui.ViewFocusState> states = ui.ViewFocusState.values;
  final List<ui.ViewFocusDirection> dirs = ui.ViewFocusDirection.values;

  final Widget comparisonMatrix = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade100, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'state x direction matrix',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'All 6 valid combinations of (state, direction) for ViewFocusEvent.',
          style: TextStyle(fontSize: 12.0, color: Colors.brown.shade700),
        ),
        SizedBox(height: 14.0),
        // Header row
        Row(
          children: [
            SizedBox(width: 110.0),
            for (final ui.ViewFocusDirection d in dirs)
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepOrange.shade300,
                        Colors.deepOrange.shade500,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    d.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 6.0),
        for (final ui.ViewFocusState s in states)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                SizedBox(
                  width: 110.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: s == ui.ViewFocusState.focused
                            ? [Colors.green.shade300, Colors.green.shade500]
                            : [Colors.grey.shade400, Colors.grey.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      s.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                for (final ui.ViewFocusDirection d in dirs)
                  Expanded(
                    child: _buildMatrixCell(s, d),
                  ),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Quick Reference card (toString preview + indices)
  // ============================================================
  print('=== Section 10: Quick reference ===');

  final List<ui.ViewFocusEvent> allEvents = <ui.ViewFocusEvent>[
    eventGainForward,
    eventGainBackward,
    eventGainUndefined,
    eventLossForward,
    eventLossBackward,
    eventLossUndefined,
  ];

  final Widget quickRef = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
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
            Icon(Icons.flash_on, color: Colors.cyanAccent.shade100, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Quick Reference',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent.shade100,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final ui.ViewFocusEvent e in allEvents)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: Colors.cyanAccent.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                e.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.greenAccent.shade100,
                ),
              ),
            ),
          ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'enum indices:\n'
            '  ViewFocusState.unfocused      = ${ui.ViewFocusState.unfocused.index}\n'
            '  ViewFocusState.focused        = ${ui.ViewFocusState.focused.index}\n'
            '  ViewFocusDirection.undefined  = ${ui.ViewFocusDirection.undefined.index}\n'
            '  ViewFocusDirection.forward    = ${ui.ViewFocusDirection.forward.index}\n'
            '  ViewFocusDirection.backward   = ${ui.ViewFocusDirection.backward.index}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amberAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Lifecycle ribbon (extra section)
  // ============================================================
  print('=== Section 11: Lifecycle ===');

  final Widget lifecycleRibbon = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade100, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Event Lifecycle',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How a ViewFocusEvent reaches your app from the platform.',
          style: TextStyle(fontSize: 12.0, color: Colors.teal.shade800),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            _buildLifecycleStep('1', 'Platform', Icons.computer, Colors.indigo),
            _buildLifecycleArrow(),
            _buildLifecycleStep(
                '2', 'Engine', Icons.developer_board, Colors.purple),
            _buildLifecycleArrow(),
            _buildLifecycleStep(
                '3', 'Dispatcher', Icons.podcasts, Colors.deepOrange),
            _buildLifecycleArrow(),
            _buildLifecycleStep('4', 'Callback', Icons.call, Colors.green),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.teal.shade300),
          ),
          child: Text(
            'PlatformDispatcher.instance.onViewFocusChange = (ViewFocusEvent e) {\n'
            "  debugPrint('view \${e.viewId} -> \${e.state.name} (\${e.direction.name})');\n"
            '};',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.teal.shade900,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: ASCII footer
  // ============================================================
  print('=== Section 12: ASCII footer ===');

  const String asciiArt =
      '+----------------------------------------------------------+\n'
      '|              ViewFocusEvent  (dart:ui)                   |\n'
      '+----------------------------------------------------------+\n'
      '|  viewId    : int                                         |\n'
      '|  state     : ViewFocusState   { unfocused, focused }     |\n'
      '|  direction : ViewFocusDirection                          |\n'
      '|              { undefined, forward, backward }            |\n'
      '+----------------------------------------------------------+\n'
      '|  Delivered via PlatformDispatcher.onViewFocusChange      |\n'
      '+----------------------------------------------------------+';

  final Widget asciiFooter = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.grey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.greenAccent.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.greenAccent.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Text(
      asciiArt,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Colors.greenAccent.shade100,
        height: 1.25,
      ),
    ),
  );

  print('ViewFocusEvent Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ViewFocusEvent Deep Demo',
    home: Scaffold(
      backgroundColor: Color(0xFFF6F7FB),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            heroHeader,
            SizedBox(height: 8.0),
            _sectionLabel('1. Anatomy'),
            anatomyCard,
            SizedBox(height: 16.0),
            _sectionLabel('2. Field: viewId'),
            viewIdCard,
            SizedBox(height: 16.0),
            _sectionLabel('3. Field: state'),
            stateCard,
            SizedBox(height: 16.0),
            _sectionLabel('4. Field: direction'),
            directionCard,
            SizedBox(height: 16.0),
            _sectionLabel('5. Field grid'),
            fieldGrid,
            SizedBox(height: 16.0),
            _sectionLabel('6. Recipes'),
            ...recipeCards,
            SizedBox(height: 16.0),
            _sectionLabel('7. Pitfalls'),
            pitfallsCard,
            SizedBox(height: 16.0),
            _sectionLabel('8. Comparison: state x direction'),
            comparisonMatrix,
            SizedBox(height: 16.0),
            _sectionLabel('9. Quick Reference'),
            quickRef,
            SizedBox(height: 16.0),
            _sectionLabel('10. Event Lifecycle'),
            lifecycleRibbon,
            SizedBox(height: 16.0),
            _sectionLabel('11. ASCII summary'),
            asciiFooter,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

class _Recipe {
  _Recipe({
    required this.title,
    required this.summary,
    required this.event,
    required this.accent,
    required this.icon,
  });

  final String title;
  final String summary;
  final ui.ViewFocusEvent event;
  final Color accent;
  final IconData icon;
}

Widget _sectionLabel(String text) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 8.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _buildAnatomyRow({
  required String fieldName,
  required String type,
  required String purpose,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
    ),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.6), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.white, size: 20.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    fieldName,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.0,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.0),
              Text(
                purpose,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildEnumValueTile({
  required String name,
  required int index,
  required String description,
  required Color color,
  required IconData icon,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.12),
          color.withValues(alpha: 0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 32.0),
        SizedBox(height: 6.0),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          'index: $index',
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
        ),
      ],
    ),
  );
}

Widget _buildDirectionRow(ui.ViewFocusDirection d) {
  IconData icon;
  Color color;
  String description;
  switch (d) {
    case ui.ViewFocusDirection.undefined:
      icon = Icons.help_outline;
      color = Colors.grey.shade700;
      description = 'No direction (programmatic / focus loss).';
      break;
    case ui.ViewFocusDirection.forward:
      icon = Icons.arrow_forward;
      color = Colors.green.shade700;
      description = 'Forward traversal (e.g. Tab key).';
      break;
    case ui.ViewFocusDirection.backward:
      icon = Icons.arrow_back;
      color = Colors.red.shade700;
      description = 'Backward traversal (e.g. Shift+Tab).';
      break;
  }
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.2),
    ),
    child: Row(
      children: [
        Container(
          width: 34.0,
          height: 34.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    d.name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    'index ${d.index}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFieldGridTile(
  String name,
  String type,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.1),
          color.withValues(alpha: 0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.0,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecipeCard(_Recipe r) {
  final ui.ViewFocusEvent e = r.event;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          r.accent.withValues(alpha: 0.08),
          r.accent.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: r.accent.withValues(alpha: 0.5), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: r.accent.withValues(alpha: 0.18),
          blurRadius: 8.0,
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
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    r.accent.withValues(alpha: 0.7),
                    r.accent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(r.icon, color: Colors.white, size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                r.title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: r.accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          r.summary,
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            _buildBadge('viewId', '${e.viewId}', Colors.blue),
            SizedBox(width: 6.0),
            _buildBadge('state', e.state.name, Colors.green),
            SizedBox(width: 6.0),
            Flexible(
              child: _buildBadge(
                'direction',
                e.direction.name,
                Colors.deepOrange,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'ViewFocusEvent(\n'
            '  viewId: ${e.viewId},\n'
            '  state: ViewFocusState.${e.state.name},\n'
            '  direction: ViewFocusDirection.${e.direction.name},\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBadge(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: color,
          ),
        ),
        SizedBox(width: 4.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfall(String headline, String detail) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.error_outline, size: 18.0, color: Colors.red.shade700),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headline,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.red.shade900.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMatrixCell(ui.ViewFocusState s, ui.ViewFocusDirection d) {
  final bool gain = s == ui.ViewFocusState.focused;
  final MaterialColor base = gain ? Colors.green : Colors.grey;
  String label;
  IconData icon;
  if (gain) {
    switch (d) {
      case ui.ViewFocusDirection.forward:
        label = 'Tab in';
        icon = Icons.arrow_forward;
        break;
      case ui.ViewFocusDirection.backward:
        label = 'Sh+Tab in';
        icon = Icons.arrow_back;
        break;
      case ui.ViewFocusDirection.undefined:
        label = 'Programmatic';
        icon = Icons.flash_on;
        break;
    }
  } else {
    switch (d) {
      case ui.ViewFocusDirection.forward:
        label = 'Tab out';
        icon = Icons.exit_to_app;
        break;
      case ui.ViewFocusDirection.backward:
        label = 'Sh+Tab out';
        icon = Icons.undo;
        break;
      case ui.ViewFocusDirection.undefined:
        label = 'Platform took it';
        icon = Icons.public_off;
        break;
    }
  }
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          base.withValues(alpha: 0.15),
          base.withValues(alpha: 0.35),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: base.withValues(alpha: 0.6)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: base.shade800, size: 16.0),
        SizedBox(height: 2.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            color: base.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleStep(
  String index,
  String label,
  IconData icon,
  Color color,
) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.38),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 24.0,
            height: 24.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Text(
              index,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Icon(icon, color: color, size: 22.0),
          SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildLifecycleArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(
      Icons.chevron_right,
      color: Colors.teal.shade700,
      size: 24.0,
    ),
  );
}

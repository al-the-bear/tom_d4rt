// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TraversalEdgeBehavior from widgets
// Deep Demo: Visual demonstration of focus traversal edge behavior and policies
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TraversalEdgeBehavior Deep Demo executing');

  // ============================================================
  // SECTION 1: Enum Value Cards
  // ============================================================
  print('=== Section 1: TraversalEdgeBehavior Enum Values ===');

  final enumCards = <Widget>[];

  // Card 1: closedLoop
  enumCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.loop, size: 28.0, color: Colors.blue.shade700),
              SizedBox(width: 8.0),
              Text(
                'closedLoop',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Wrap focus back to the start when reaching the end of the group.',
            style: TextStyle(fontSize: 12.0, color: Colors.blue.shade800),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'Use: modal dialogs, focus traps',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Card 2: leaveFlutterView
  enumCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.purple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.exit_to_app, size: 28.0, color: Colors.purple.shade700),
              SizedBox(width: 8.0),
              Text(
                'leaveFlutterView',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Allow focus to leave the Flutter view entirely toward native controls.',
            style: TextStyle(fontSize: 12.0, color: Colors.purple.shade800),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'Use: hybrid hosts, embedded views',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.purple.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Card 3: parentScope
  enumCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.teal.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.unfold_more, size: 28.0, color: Colors.green.shade700),
              SizedBox(width: 8.0),
              Text(
                'parentScope',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Delegate edge traversal to the parent focus scope above this group.',
            style: TextStyle(fontSize: 12.0, color: Colors.green.shade800),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'Use: nested forms, sectioned UI',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.green.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Card 4: stop
  enumCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade50, Colors.orange.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.red.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.block, size: 28.0, color: Colors.red.shade700),
              SizedBox(width: 8.0),
              Text(
                'stop',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Stop traversal at the edge — focus remains on the last item.',
            style: TextStyle(fontSize: 12.0, color: Colors.red.shade800),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'Use: bounded toolbars, fixed lists',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.red.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Built ${enumCards.length} enum value cards');

  // ============================================================
  // SECTION 2: Traversal Flow Diagrams
  // ============================================================
  print('=== Section 2: Traversal Flow Diagrams ===');

  // Each diagram shows a row of focus targets with arrows
  // illustrating the edge behavior. The active node is highlighted.
  final flowDiagrams = <Widget>[];

  // Diagram for closedLoop
  flowDiagrams.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blue.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.loop, size: 20.0, color: Colors.blue.shade700),
              SizedBox(width: 8.0),
              Text(
                'closedLoop — tab wraps to first',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFocusNode('A', Colors.blue, active: true),
              _buildArrow(Colors.blue.shade400),
              _buildFocusNode('B', Colors.blue),
              _buildArrow(Colors.blue.shade400),
              _buildFocusNode('C', Colors.blue),
              _buildArrow(Colors.blue.shade400),
              _buildFocusNode('D', Colors.blue),
            ],
          ),
          SizedBox(height: 6.0),
          Center(
            child: Text(
              '↩ wrap edge ↩',
              style: TextStyle(
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
                color: Colors.blue.shade600,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Diagram for leaveFlutterView
  flowDiagrams.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.purple.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.exit_to_app, size: 20.0, color: Colors.purple.shade700),
              SizedBox(width: 8.0),
              Text(
                'leaveFlutterView — tab escapes to host',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFocusNode('A', Colors.purple),
              _buildArrow(Colors.purple.shade400),
              _buildFocusNode('B', Colors.purple),
              _buildArrow(Colors.purple.shade400),
              _buildFocusNode('C', Colors.purple, active: true),
              _buildArrow(Colors.purple.shade400),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: Colors.purple.shade400,
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  'host',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.purple.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // Diagram for parentScope
  flowDiagrams.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.green.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.subdirectory_arrow_left,
                size: 20.0,
                color: Colors.green.shade700,
              ),
              SizedBox(width: 8.0),
              Text(
                'parentScope — delegates beyond local group',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.green.shade400, width: 1.0),
            ),
            child: Column(
              children: [
                Text(
                  'parent scope',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.0),
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildFocusNode('A', Colors.green),
                      _buildArrow(Colors.green.shade400),
                      _buildFocusNode('B', Colors.green, active: true),
                      _buildArrow(Colors.green.shade400),
                      _buildFocusNode('C', Colors.green),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.0),
          Center(
            child: Text(
              '⤴ edge bubbles up to parent ⤴',
              style: TextStyle(
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
                color: Colors.green.shade600,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Diagram for stop
  flowDiagrams.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.red.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.block, size: 20.0, color: Colors.red.shade700),
              SizedBox(width: 8.0),
              Text(
                'stop — focus halts at the edge',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFocusNode('A', Colors.red),
              _buildArrow(Colors.red.shade400),
              _buildFocusNode('B', Colors.red),
              _buildArrow(Colors.red.shade400),
              _buildFocusNode('C', Colors.red),
              _buildArrow(Colors.red.shade400),
              _buildFocusNode('D', Colors.red, active: true),
              SizedBox(width: 6.0),
              Icon(Icons.close, color: Colors.red.shade700, size: 18.0),
            ],
          ),
          SizedBox(height: 6.0),
          Center(
            child: Text(
              '✋ no further movement ✋',
              style: TextStyle(
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
                color: Colors.red.shade600,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Built ${flowDiagrams.length} flow diagrams');

  // ============================================================
  // SECTION 3: Policy Comparison Cards
  // ============================================================
  print('=== Section 3: Policy Comparison Cards ===');

  final policies = <Map<String, dynamic>>[
    {
      'name': 'ReadingOrderTraversalPolicy',
      'icon': Icons.menu_book,
      'color': Colors.indigo,
      'desc':
          'Traverses focus nodes in reading order — left-to-right, top-to-bottom (or RTL equivalent).',
      'best': 'Forms, articles, generic content',
    },
    {
      'name': 'OrderedTraversalPolicy',
      'icon': Icons.format_list_numbered,
      'color': Colors.deepOrange,
      'desc':
          'Uses explicit FocusTraversalOrder widgets to define a precise tab order.',
      'best': 'Custom layouts, wizards',
    },
    {
      'name': 'WidgetOrderTraversalPolicy',
      'icon': Icons.account_tree,
      'color': Colors.teal,
      'desc':
          'Traverses in the order widgets appear in the tree, independent of visual position.',
      'best': 'Code-driven flows, debugging',
    },
    {
      'name': 'DirectionalFocusTraversalPolicyMixin',
      'icon': Icons.gamepad,
      'color': Colors.brown,
      'desc':
          'Mixin enabling arrow-key directional navigation in 2D layouts (up/down/left/right).',
      'best': 'TV, gamepad, grids',
    },
  ];

  final policyCards = <Widget>[];
  for (final policy in policies) {
    final color = policy['color'] as Color;
    policyCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(policy['icon'] as IconData, color: color, size: 26.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    policy['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    policy['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'best for: ${policy['best']}',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
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

  print('Built ${policyCards.length} policy comparison cards');

  // ============================================================
  // SECTION 4: Real-World Scenarios
  // ============================================================
  print('=== Section 4: Real-World Scenarios ===');

  final scenarioWidgets = <Widget>[];

  // Scenario 1: Form
  scenarioWidgets.add(
    Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment, color: Colors.blue.shade700, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                'Scenario A — Login form',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.blueGrey.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Use ReadingOrderTraversalPolicy with parentScope edge behavior so '
            'Tab/Shift+Tab flow naturally between username, password, and submit.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
          ),
          SizedBox(height: 10.0),
          _buildFakeField('username'),
          SizedBox(height: 6.0),
          _buildFakeField('password'),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'submit',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        ],
      ),
    ),
  );

  // Scenario 2: Navigation rail
  scenarioWidgets.add(
    Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.teal.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.dashboard, color: Colors.teal.shade700, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                'Scenario B — Navigation rail + content',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.teal.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Group the rail with closedLoop and the content with parentScope. '
            'Arrow keys cycle within the rail; Tab moves into content.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Column(
                children: [
                  _buildRailIcon(Icons.home, Colors.teal),
                  _buildRailIcon(Icons.search, Colors.teal),
                  _buildRailIcon(Icons.settings, Colors.teal),
                ],
              ),
              SizedBox(width: 14.0),
              Expanded(
                child: Container(
                  height: 90.0,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'content area\n(parentScope)',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.teal.shade900,
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

  // Scenario 3: Popup menu
  scenarioWidgets.add(
    Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.more_vert,
                color: Colors.deepPurple.shade700,
                size: 22.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Scenario C — Popup menu trap',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Use closedLoop in the menu so up/down arrows wrap and Tab cannot '
            'escape until the menu is dismissed.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.deepPurple.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMenuItem('Cut', Icons.content_cut),
                _buildMenuItem('Copy', Icons.copy),
                _buildMenuItem('Paste', Icons.paste),
                _buildMenuItem('Delete', Icons.delete),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('Built ${scenarioWidgets.length} scenario widgets');

  // ============================================================
  // SECTION 5: Code Panels
  // ============================================================
  print('=== Section 5: Code Panels ===');

  final codePanels = <Widget>[];

  codePanels.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: Colors.cyan.shade400, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'FocusTraversalGroup with closedLoop',
                style: TextStyle(
                  color: Colors.cyan.shade300,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'FocusTraversalGroup(\n'
              '  policy: ReadingOrderTraversalPolicy(\n'
              '    requestFocusCallback: defaultRequestFocusCallback,\n'
              '  ),\n'
              '  edgeBehavior: TraversalEdgeBehavior.closedLoop,\n'
              '  child: Column(children: fields),\n'
              ');',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.green.shade300,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  codePanels.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: Colors.amber.shade400, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'OrderedTraversalPolicy with explicit order',
                style: TextStyle(
                  color: Colors.amber.shade300,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'FocusTraversalGroup(\n'
              '  policy: OrderedTraversalPolicy(),\n'
              '  edgeBehavior: TraversalEdgeBehavior.parentScope,\n'
              '  child: Column(children: [\n'
              '    FocusTraversalOrder(\n'
              '      order: NumericFocusOrder(1),\n'
              '      child: TextField(),\n'
              '    ),\n'
              '    FocusTraversalOrder(\n'
              '      order: NumericFocusOrder(2),\n'
              '      child: ElevatedButton(...),\n'
              '    ),\n'
              '  ]),\n'
              ');',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.orange.shade200,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  codePanels.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: Colors.pinkAccent, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'Custom DirectionalFocusTraversalPolicy',
                style: TextStyle(
                  color: Colors.pinkAccent.shade100,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'class GridPolicy extends FocusTraversalPolicy\n'
              '    with DirectionalFocusTraversalPolicyMixin {\n'
              '  // arrow-key 2D navigation comes from the mixin.\n'
              '  @override\n'
              '  Iterable<FocusNode> sortDescendants(\n'
              '    Iterable<FocusNode> descendants,\n'
              '    FocusNode currentNode,\n'
              '  ) {\n'
              '    return descendants;\n'
              '  }\n'
              '}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.pink.shade200,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Built ${codePanels.length} code panels');

  // ============================================================
  // SECTION 6: Comparison Table
  // ============================================================
  print('=== Section 6: Comparison Table ===');

  final tableHeader = Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade800,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Edge Behavior',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Stays?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Wraps?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Escapes?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );

  final tableRows = <Widget>[];
  final rows = <Map<String, dynamic>>[
    {
      'name': 'closedLoop',
      'stays': false,
      'wraps': true,
      'escapes': false,
      'color': Colors.blue,
    },
    {
      'name': 'leaveFlutterView',
      'stays': false,
      'wraps': false,
      'escapes': true,
      'color': Colors.purple,
    },
    {
      'name': 'parentScope',
      'stays': false,
      'wraps': false,
      'escapes': true,
      'color': Colors.green,
    },
    {
      'name': 'stop',
      'stays': true,
      'wraps': false,
      'escapes': false,
      'color': Colors.red,
    },
  ];

  for (int i = 0; i < rows.length; i++) {
    final row = rows[i];
    final color = row['color'] as Color;
    final isLast = i == rows.length - 1;
    tableRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.grey.shade50 : Colors.white,
          borderRadius: isLast
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                )
              : BorderRadius.zero,
          border: Border(
            bottom: BorderSide(
              color: isLast ? Colors.transparent : Colors.grey.shade300,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    row['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: _buildBoolIndicator(row['stays'] as bool),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: _buildBoolIndicator(row['wraps'] as bool),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: _buildBoolIndicator(row['escapes'] as bool),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [tableHeader, ...tableRows],
    ),
  );

  print('Built comparison table with ${tableRows.length} rows');

  // ============================================================
  // SECTION 7: Summary Panel
  // ============================================================
  print('=== Section 7: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.blue.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.loop,
          'closedLoop',
          'Trap focus within the group — wraps from last to first.',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.exit_to_app,
          'leaveFlutterView',
          'Let focus escape to the embedding host application.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.subdirectory_arrow_left,
          'parentScope',
          'Delegate edge transitions to the enclosing scope.',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.block,
          'stop',
          'Pin focus at the edge — no wrap, no escape.',
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.menu_book,
          'Pick the right policy',
          'Reading order for content, ordered for wizards, directional for grids.',
          Colors.indigo,
        ),
      ],
    ),
  );

  print('TraversalEdgeBehavior Deep Demo completed successfully');

  // ============================================================
  // Final composition
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.3),
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.keyboard_tab,
                    size: 56.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'TraversalEdgeBehavior',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Focus Traversal at Group Edges',
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1: Enum value cards
            Text(
              '1. Enum Values',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: enumCards),
            SizedBox(height: 32.0),

            // Section 2: Flow diagrams
            Text(
              '2. Traversal Flow Diagrams',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Column(children: flowDiagrams),
            SizedBox(height: 32.0),

            // Section 3: Policies
            Text(
              '3. Focus Traversal Policies',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Column(children: policyCards),
            SizedBox(height: 32.0),

            // Section 4: Scenarios
            Text(
              '4. Real-World Scenarios',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Column(children: scenarioWidgets),
            SizedBox(height: 32.0),

            // Section 5: Code panels
            Text(
              '5. Code Examples',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Column(children: codePanels),
            SizedBox(height: 32.0),

            // Section 6: Comparison table
            Text(
              '6. Comparison Table',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            comparisonTable,
            SizedBox(height: 32.0),

            // Section 7: Summary
            Text(
              '7. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
          ],
        ),
      ),
    ),
  );
}

// Helper: A focus node circle with optional active state
Widget _buildFocusNode(String label, MaterialColor color, {bool active = false}) {
  return Container(
    width: 36.0,
    height: 36.0,
    margin: EdgeInsets.symmetric(horizontal: 2.0),
    decoration: BoxDecoration(
      color: active ? color.shade600 : color.shade100,
      shape: BoxShape.circle,
      border: Border.all(
        color: active ? color.shade900 : color.shade400,
        width: active ? 2.5 : 1.5,
      ),
      boxShadow: active
          ? [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ]
          : null,
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
          color: active ? Colors.white : color.shade800,
        ),
      ),
    ),
  );
}

// Helper: Arrow between focus nodes
Widget _buildArrow(Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.0),
    child: Icon(Icons.arrow_forward, color: color, size: 16.0),
  );
}

// Helper: Fake input field display
Widget _buildFakeField(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Icon(Icons.edit, size: 14.0, color: Colors.grey.shade600),
        SizedBox(width: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// Helper: Navigation rail icon button
Widget _buildRailIcon(IconData icon, MaterialColor color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade300),
    ),
    child: Icon(icon, size: 20.0, color: color.shade800),
  );
}

// Helper: Popup menu item
Widget _buildMenuItem(String label, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
    child: Row(
      children: [
        Icon(icon, size: 16.0, color: Colors.deepPurple.shade700),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(fontSize: 12.0, color: Colors.deepPurple.shade900),
        ),
      ],
    ),
  );
}

// Helper: Yes/No indicator for the table
Widget _buildBoolIndicator(bool value) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: value ? Colors.green.shade100 : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          value ? Icons.check : Icons.close,
          size: 12.0,
          color: value ? Colors.green.shade800 : Colors.grey.shade600,
        ),
        SizedBox(width: 4.0),
        Text(
          value ? 'yes' : 'no',
          style: TextStyle(
            fontSize: 11.0,
            color: value ? Colors.green.shade800 : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build summary item (matches reference)
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RootBackButtonDispatcher
// Demonstrates RootBackButtonDispatcher — the top-level handler for
// system back button events on Android and web. It sits at the root
// of the Router hierarchy and delegates to child dispatchers, enabling
// modular navigation that responds correctly to back gestures.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RootBackButtonDispatcher Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is RootBackButtonDispatcher?
  // ============================================================
  print('=== Section 1: Concept ===');

  // RootBackButtonDispatcher is the entry point for system
  // back button events. When the user presses Android's back
  // button or the browser's back button:
  //
  //   1. The platform sends a "pop route" message
  //   2. RootBackButtonDispatcher receives it
  //   3. It walks its child callbacks in priority order
  //   4. The first callback that returns true "consumes" the event
  //   5. If no callback consumes it, the app may exit
  //
  // This enables nested navigators, drawers, modals, and other
  // UI elements to each register for back-button handling.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF2E7D32), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.arrow_back, size: 36.0, color: Color(0xFF2E7D32)),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'RootBackButtonDispatcher',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'The top-level handler for system back button events. '
          'When the user presses Android\'s back button or the '
          'browser\'s back button, this dispatcher receives the '
          'event and delegates it through a priority-based chain '
          'of child callbacks.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFF2E7D32)),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event flow:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF1B5E20),
                ),
              ),
              SizedBox(height: 8.0),
              _buildBackBullet(
                '1. Platform sends "pop route" message',
                Color(0xFF1565C0),
              ),
              _buildBackBullet(
                '2. RootBackButtonDispatcher receives it',
                Color(0xFF2E7D32),
              ),
              _buildBackBullet(
                '3. Walks child callbacks in priority order',
                Color(0xFFE65100),
              ),
              _buildBackBullet(
                '4. First callback returning true consumes event',
                Color(0xFF6A1B9A),
              ),
              _buildBackBullet(
                '5. If none consume → app may exit',
                Color(0xFFC62828),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Dispatch Hierarchy
  // ============================================================
  print('=== Section 2: Dispatch hierarchy ===');

  // Visualize how back button events flow through the
  // dispatcher tree: Root → ChildBackButtonDispatcher(s).

  Widget buildDispatchNode(
    String name,
    String priority,
    Color color,
    bool consumed,
    int indent,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.only(
        left: indent * 24.0,
        top: 4.0,
        bottom: 4.0,
        right: 8.0,
      ),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: consumed
            ? color.withValues(alpha: 0.2)
            : color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: color,
          width: consumed ? 2.0 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
                Text(
                  'Priority: $priority',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: consumed ? Color(0xFF2E7D32) : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              consumed ? 'CONSUMED' : 'PASS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final hierarchySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Back Button Dispatch Hierarchy',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Highest-priority child gets first chance to consume the event.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        // Scenario A: Modal consumes
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF2E7D32)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scenario A: Modal open — modal consumes back',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 8.0),
              buildDispatchNode(
                'RootBackButtonDispatcher',
                'root',
                Color(0xFF37474F),
                false,
                0,
                Icons.account_tree,
              ),
              buildDispatchNode(
                'ChildDispatcher: Navigator',
                'default (0)',
                Color(0xFF1565C0),
                false,
                1,
                Icons.navigation,
              ),
              buildDispatchNode(
                'ChildDispatcher: Modal',
                'high (10)',
                Color(0xFF2E7D32),
                true,
                1,
                Icons.layers,
              ),
            ],
          ),
        ),
        // Scenario B: No modal — navigator pops
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF1565C0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scenario B: No modal — navigator pops route',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Color(0xFF1565C0),
                ),
              ),
              SizedBox(height: 8.0),
              buildDispatchNode(
                'RootBackButtonDispatcher',
                'root',
                Color(0xFF37474F),
                false,
                0,
                Icons.account_tree,
              ),
              buildDispatchNode(
                'ChildDispatcher: Navigator',
                'default (0)',
                Color(0xFF1565C0),
                true,
                1,
                Icons.navigation,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Platform Differences
  // ============================================================
  print('=== Section 3: Platform differences ===');

  Widget buildPlatformCard(
    String name,
    IconData icon,
    Color color,
    String backMechanism,
    String behavior,
    bool hasPhysicalButton,
  ) {
    return Container(
      width: 180.0,
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24.0),
                SizedBox(width: 8.0),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      hasPhysicalButton
                          ? Icons.touch_app
                          : Icons.swipe,
                      color: Colors.grey.shade600,
                      size: 16.0,
                    ),
                    SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        backMechanism,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                Text(
                  behavior,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final platformSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Platform Differences',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How the system back action works on each platform.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildPlatformCard(
              'Android',
              Icons.android,
              Color(0xFF2E7D32),
              'Physical/gesture back',
              'RootBackButtonDispatcher receives '
                  'SystemNavigator.pop() — may call '
                  'handlePopRoute.',
              true,
            ),
            buildPlatformCard(
              'Web',
              Icons.web,
              Color(0xFF1565C0),
              'Browser back button',
              'Router hears history.back() and '
                  'dispatches through RootBackButton'
                  'Dispatcher.',
              true,
            ),
            buildPlatformCard(
              'iOS',
              Icons.apple,
              Color(0xFF37474F),
              'Edge swipe gesture',
              'iOS uses swipe-to-go-back — not '
                  'dispatched through this class. '
                  'Uses Navigator.pop() directly.',
              false,
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFF9A825)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  color: Color(0xFFF9A825), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'RootBackButtonDispatcher is most important on '
                  'Android and web where a system-level back action '
                  'exists. On iOS, navigation is gesture-driven.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF795548),
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
  // SECTION 4: Router Integration
  // ============================================================
  print('=== Section 4: Router integration ===');

  // Show how Router uses RootBackButtonDispatcher.

  final routerSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree,
                color: Color(0xFF6A1B9A), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Router Integration',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Code showing Router with back button dispatcher
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Router(\n'
            '  routerDelegate: myDelegate,\n'
            '  routeInformationParser: myParser,\n'
            '  backButtonDispatcher:\n'
            '      RootBackButtonDispatcher(),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // Flow diagram
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              _buildFlowStep(
                'System Back Press',
                Icons.touch_app,
                Color(0xFF37474F),
              ),
              _buildFlowArrow(),
              _buildFlowStep(
                'RootBackButtonDispatcher',
                Icons.account_tree,
                Color(0xFF2E7D32),
              ),
              _buildFlowArrow(),
              _buildFlowStep(
                'Router.backButtonDispatcher',
                Icons.router,
                Color(0xFF6A1B9A),
              ),
              _buildFlowArrow(),
              _buildFlowStep(
                'RouterDelegate.popRoute()',
                Icons.exit_to_app,
                Color(0xFF1565C0),
              ),
              _buildFlowArrow(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFlowOutcome('Pop page', Color(0xFF2E7D32)),
                  SizedBox(width: 16.0),
                  Text(
                    'or',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  _buildFlowOutcome('Exit app', Color(0xFFC62828)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Priority System
  // ============================================================
  print('=== Section 5: Priority system ===');

  Widget buildPriorityBar(
    String name,
    int priority,
    Color color,
    bool isWinner,
  ) {
    final barWidth = (priority + 1) * 30.0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 120.0,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
                color: isWinner ? color : Colors.grey.shade600,
              ),
            ),
          ),
          Container(
            width: barWidth.clamp(30.0, 200.0),
            height: 22.0,
            decoration: BoxDecoration(
              color: isWinner
                  ? color
                  : color.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Text(
                'P$priority',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: isWinner ? Colors.white : color,
                ),
              ),
            ),
          ),
          if (isWinner) ...[
            SizedBox(width: 8.0),
            Icon(Icons.check_circle, color: color, size: 16.0),
            SizedBox(width: 4.0),
            Text(
              'Wins',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ],
      ),
    );
  }

  final prioritySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority System',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Higher priority dispatchers get first chance to handle the event.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 16.0),
        // Example scenario
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Example: Drawer open over nested navigator',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 10.0),
              buildPriorityBar(
                'Drawer close',
                5,
                Color(0xFF2E7D32),
                true,
              ),
              buildPriorityBar(
                'Nested navigator',
                2,
                Color(0xFF1565C0),
                false,
              ),
              buildPriorityBar(
                'Root navigator',
                0,
                Color(0xFF795548),
                false,
              ),
              SizedBox(height: 8.0),
              Text(
                'Result: Drawer closes. Nested and root navigators '
                'are not affected because the event was consumed.',
                style: TextStyle(
                  fontSize: 10.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Example: No overlay — nested navigator pops',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 10.0),
              buildPriorityBar(
                'Nested navigator',
                2,
                Color(0xFF1565C0),
                true,
              ),
              buildPriorityBar(
                'Root navigator',
                0,
                Color(0xFF795548),
                false,
              ),
              SizedBox(height: 8.0),
              Text(
                'Result: Nested navigator pops its top route. '
                'Root navigator stays unchanged.',
                style: TextStyle(
                  fontSize: 10.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Common Patterns
  // ============================================================
  print('=== Section 6: Common patterns ===');

  Widget buildPatternCard(
    String title,
    String description,
    String codeSnippet,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF263238),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    codeSnippet,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: Color(0xFF80CBC4),
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

  final patternsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Common Patterns',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        buildPatternCard(
          'Confirmation Dialog',
          'Show a "discard changes?" dialog when the user presses '
              'back on a form with unsaved edits.',
          'PopScope(\n'
              '  canPop: !hasUnsavedChanges,\n'
              '  onPopInvokedWithResult: (didPop, _) {\n'
              '    if (!didPop) showDiscardDialog();\n'
              '  },\n'
              '  child: MyForm(),\n'
              ')',
          Icons.warning_amber,
          Color(0xFFE65100),
        ),
        buildPatternCard(
          'Nested Navigator',
          'A tab-based app where each tab has its own navigation '
              'stack. Back should pop within the current tab first.',
          'ChildBackButtonDispatcher(\n'
              '  parent: Router.of(context)\n'
              '      .backButtonDispatcher!,\n'
              ')..takePriority()',
          Icons.tab,
          Color(0xFF1565C0),
        ),
        buildPatternCard(
          'Drawer Close',
          'Close an open drawer before popping the current route. '
              'The drawer registers a high-priority callback.',
          'backDispatcher.addCallback(() {\n'
              '  if (scaffoldKey.currentState\n'
              '      ?.isDrawerOpen ?? false) {\n'
              '    Navigator.of(context).pop();\n'
              '    return Future.value(true);\n'
              '  }\n'
              '  return Future.value(false);\n'
              '});',
          Icons.menu_open,
          Color(0xFF2E7D32),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Lifecycle & Disposal
  // ============================================================
  print('=== Section 7: Lifecycle ===');

  Widget buildLifecycleStep(
    String phase,
    String description,
    Color color,
    IconData icon,
    bool isActive,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isActive
            ? color.withValues(alpha: 0.15)
            : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isActive ? color : Colors.grey.shade300,
          width: isActive ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18.0),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phase,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final lifecycleSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFF57C00)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Color(0xFFF57C00), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Callback Lifecycle',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        buildLifecycleStep(
          'Register',
          'addCallback() — adds a handler to the dispatcher',
          Color(0xFF2E7D32),
          Icons.add_circle,
          true,
        ),
        buildLifecycleStep(
          'Take Priority',
          'takePriority() — moves this callback to front of queue',
          Color(0xFF1565C0),
          Icons.priority_high,
          true,
        ),
        buildLifecycleStep(
          'Dispatch',
          'handlePopRoute() — walks callbacks in priority order',
          Color(0xFFE65100),
          Icons.play_arrow,
          true,
        ),
        buildLifecycleStep(
          'Remove',
          'removeCallback() — unregisters when no longer needed',
          Color(0xFFC62828),
          Icons.remove_circle,
          false,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF2E7D32), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFF2E7D32), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildBackSummaryItem(
          Icons.arrow_back,
          'System back handler',
          'Receives Android back button and browser back events',
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 8.0),
        _buildBackSummaryItem(
          Icons.sort,
          'Priority-based dispatch',
          'Highest-priority child callback gets first chance',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 8.0),
        _buildBackSummaryItem(
          Icons.account_tree,
          'Child dispatchers',
          'ChildBackButtonDispatcher for nested navigators',
          Color(0xFFE65100),
        ),
        SizedBox(height: 8.0),
        _buildBackSummaryItem(
          Icons.router,
          'Router integration',
          'Router.backButtonDispatcher uses RootBackButtonDispatcher',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 8.0),
        _buildBackSummaryItem(
          Icons.phone_android,
          'Android & web',
          'Most relevant on platforms with system back actions',
          Color(0xFF37474F),
        ),
      ],
    ),
  );

  print('RootBackButtonDispatcher Deep Demo complete');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1B5E20),
                Color(0xFF2E7D32),
                Color(0xFF388E3C),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.arrow_back, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'RootBackButtonDispatcher',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'System back button event handling',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        conceptCard,

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2. Dispatch Hierarchy',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        hierarchySection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. Platform Differences',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        platformSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Router Integration',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        routerSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. Priority System',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        prioritySection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Common Patterns',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        patternsSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. Callback Lifecycle',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        lifecycleSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. Summary',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        summaryPanel,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ================================================================
// Helpers
// ================================================================
Widget _buildBackBullet(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: color),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowStep(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
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
  );
}

Widget _buildFlowArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Icon(Icons.arrow_downward, color: Colors.grey.shade400, size: 16.0),
  );
}

Widget _buildFlowOutcome(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

Widget _buildBackSummaryItem(
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
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
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

// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DismissAction
// Demonstrates DismissAction — the built-in Action that responds
// to DismissIntent for closing dialogs, menus, drawers, tooltips,
// and other dismissible overlays. Covers the dismiss flow, keyboard
// escape integration, override patterns, and accessibility aspects.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DismissAction Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DismissAction?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.close,
      'title': 'The Universal Dismiss Handler',
      'body': 'DismissAction is a built-in Action that handles DismissIntent. '
          'When triggered, it attempts to dismiss the current "dismissible" '
          'context — typically a dialog, modal bottom sheet, popup menu, '
          'drawer, or any overlay that should close on Escape key press.',
      'accent': Colors.red[700]!,
    },
    {
      'icon': Icons.keyboard_return,
      'title': 'Escape Key = DismissIntent',
      'body': 'Flutter\'s default keyboard shortcuts map the Escape key '
          'to DismissIntent. Any widget registered as dismissible through '
          'the Actions system will respond to Escape automatically. This '
          'is the standard pattern for closing overlays.',
      'accent': Colors.deepOrange[600]!,
    },
    {
      'icon': Icons.layers_clear,
      'title': 'Popup Route Integration',
      'body': 'Many Flutter widgets install their own DismissAction '
          'in the widget tree. For example, showDialog() wraps the '
          'dialog in a route that registers a dismiss action which '
          'calls Navigator.pop(). Menus, dropdowns, and tooltips do '
          'the same.',
      'accent': Colors.red[600]!,
    },
    {
      'icon': Icons.settings_backup_restore,
      'title': 'Customizable Behavior',
      'body': 'You can override DismissAction at any point in the widget '
          'tree. Register a custom CallbackAction<DismissIntent> in an '
          'Actions widget to change what happens on dismiss — for example, '
          'showing a confirmation dialog before closing.',
      'accent': Colors.deepOrange[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: DismissIntent & DismissAction API
  // ============================================================
  print('=== Section 2: API ===');

  final apiProperties = <Map<String, dynamic>>[
    {
      'name': 'DismissIntent',
      'type': 'Intent (class)',
      'icon': Icons.send,
      'color': Colors.red[700]!,
      'description': 'A simple intent with no parameters. Represents the '
          'user\'s desire to dismiss the current overlay. Created by '
          'the Shortcuts system when the Escape key is pressed. Can also '
          'be invoked programmatically via Actions.invoke().',
    },
    {
      'name': 'DismissAction',
      'type': 'Action<DismissIntent>',
      'icon': Icons.close,
      'color': Colors.deepOrange[600]!,
      'description': 'The Action that handles DismissIntent. The default '
          'implementation calls ModalRoute.of(context)?.maybePop() to '
          'attempt to close the current route. If no route is found, '
          'the action is disabled.',
    },
    {
      'name': 'DismissMenuAction',
      'type': 'Action<DismissIntent>',
      'icon': Icons.menu_open,
      'color': Colors.red[600]!,
      'description': 'A specialized DismissAction variant used by menu '
          'widgets (PopupMenuButton, MenuAnchor, DropdownMenu). Instead '
          'of popping a route, it closes the open menu and returns '
          'focus to the menu anchor.',
    },
  ];

  print('  Prepared ${apiProperties.length} API items');

  // ============================================================
  // SECTION 3: Where Dismiss is Used
  // ============================================================
  print('=== Section 3: Usage Contexts ===');

  final usageContexts = <Map<String, dynamic>>[
    {
      'widget': 'showDialog / AlertDialog',
      'icon': Icons.web_asset,
      'color': Colors.red[700]!,
      'dismiss': 'Pops the dialog route. Returns null from the '
          'Future if the dialog was dismissed without a result.',
      'barrier': 'Barrier tap also dismisses (if barrierDismissible: true)',
    },
    {
      'widget': 'showModalBottomSheet',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.deepOrange[600]!,
      'dismiss': 'Closes the bottom sheet route. Equivalent to '
          'swiping down or tapping the barrier.',
      'barrier': 'Barrier tap + drag down + Escape all trigger dismiss',
    },
    {
      'widget': 'PopupMenuButton',
      'icon': Icons.more_vert,
      'color': Colors.red[600]!,
      'dismiss': 'Closes the popup menu without selecting an item. '
          'Uses DismissMenuAction specifically for menu semantics.',
      'barrier': 'Tapping outside the menu also dismisses',
    },
    {
      'widget': 'Drawer / EndDrawer',
      'icon': Icons.menu,
      'color': Colors.deepOrange[700]!,
      'dismiss': 'Closes the drawer. Scaffold registers an action '
          'that handles dismiss for the visible drawer.',
      'barrier': 'Barrier tap + swipe edge + Escape all trigger dismiss',
    },
    {
      'widget': 'Tooltip',
      'icon': Icons.info_outline,
      'color': Colors.red[500]!,
      'dismiss': 'Hides the tooltip overlay. Tooltips register their '
          'own dismiss handler to remove the overlay entry.',
      'barrier': 'Tapping anywhere or pressing Escape hides tooltip',
    },
    {
      'widget': 'DropdownMenu',
      'icon': Icons.arrow_drop_down_circle,
      'color': Colors.deepOrange[500]!,
      'dismiss': 'Closes the dropdown list without changing selection. '
          'Uses DismissMenuAction for proper focus restoration.',
      'barrier': 'Tapping outside dropdown also closes it',
    },
  ];

  print('  Prepared ${usageContexts.length} usage contexts');

  // ============================================================
  // SECTION 4: Dismiss Flow Visualization
  // ============================================================
  print('=== Section 4: Dismiss Flow ===');

  final flowSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'User presses Escape',
      'description': 'The keyboard event is captured by the Shortcuts '
          'widget. The default shortcut map converts the Escape key '
          'to a DismissIntent.',
      'color': Colors.red[700]!,
    },
    {
      'step': 2,
      'title': 'Actions dispatches Intent',
      'description': 'The Actions system walks up the widget tree from '
          'the focused widget, looking for an Action registered for '
          'DismissIntent. The first match handles it.',
      'color': Colors.deepOrange[600]!,
    },
    {
      'step': 3,
      'title': 'DismissAction.invoke() called',
      'description': 'The found DismissAction calls ModalRoute.of(context)'
          '?.maybePop(). For menus, DismissMenuAction closes the menu '
          'overlay instead.',
      'color': Colors.red[600]!,
    },
    {
      'step': 4,
      'title': 'Route / overlay closes',
      'description': 'maybePop() pops the top route if it can be popped. '
          'The dialog, sheet, or drawer closes with its exit animation. '
          'Focus returns to the previously focused widget.',
      'color': Colors.deepOrange[700]!,
    },
    {
      'step': 5,
      'title': 'Focus restored',
      'description': 'After the overlay is removed, focus returns to '
          'the widget that had focus before the overlay was shown. '
          'This ensures keyboard navigation continues seamlessly.',
      'color': Colors.red[500]!,
    },
  ];

  print('  Prepared ${flowSteps.length} flow steps');

  // ============================================================
  // SECTION 5: Escape Key & Platform Behavior
  // ============================================================
  print('=== Section 5: Platform Behavior ===');

  final platformBehaviors = <Map<String, dynamic>>[
    {
      'platform': 'Desktop (Windows/Linux/macOS)',
      'icon': Icons.desktop_mac,
      'color': Colors.red[700]!,
      'behavior': 'Escape key is the primary dismiss trigger. All dialogs, '
          'menus, and overlays respond to Escape via DismissIntent. This is '
          'the most important platform for DismissAction because desktop '
          'users rely heavily on keyboard navigation.',
    },
    {
      'platform': 'Web',
      'icon': Icons.language,
      'color': Colors.deepOrange[600]!,
      'behavior': 'Same as desktop — Escape key generates DismissIntent. '
          'Web Flutter apps behave identically to native desktop apps. '
          'Browser Escape key handling does NOT conflict because Flutter '
          'captures it at the engine level.',
    },
    {
      'platform': 'Android',
      'icon': Icons.android,
      'color': Colors.red[600]!,
      'behavior': 'The system Back button/gesture generates a PopRoute '
          'event, not DismissIntent. However, if a physical keyboard is '
          'attached, Escape still generates DismissIntent. Android\'s '
          'back navigation uses a separate mechanism (BackButtonDispatcher).',
    },
    {
      'platform': 'iOS',
      'icon': Icons.apple,
      'color': Colors.deepOrange[700]!,
      'behavior': 'iOS has no Escape key on touch devices. DismissAction '
          'is primarily relevant with external keyboards. iOS dismissal '
          'patterns rely on swipe-to-dismiss gestures handled by routes '
          'and the navigation system.',
    },
  ];

  print('  Prepared ${platformBehaviors.length} platform behaviors');

  // ============================================================
  // SECTION 6: Override Patterns
  // ============================================================
  print('=== Section 6: Override Patterns ===');

  final overridePatterns = <Map<String, dynamic>>[
    {
      'title': 'Confirmation Before Dismiss',
      'color': Colors.red[700]!,
      'code': '// Ask user before closing a dialog with\n'
          '// unsaved changes:\n'
          'Actions(\n'
          '  actions: {\n'
          '    DismissIntent: CallbackAction<DismissIntent>(\n'
          '      onInvoke: (intent) {\n'
          '        if (hasUnsavedChanges) {\n'
          '          showConfirmDialog(context);\n'
          '          return null;\n'
          '        }\n'
          '        Navigator.of(context).pop();\n'
          '        return null;\n'
          '      },\n'
          '    ),\n'
          '  },\n'
          '  child: MyDialogContent(),\n'
          ')',
    },
    {
      'title': 'Block Dismiss Entirely',
      'color': Colors.deepOrange[600]!,
      'code': '// Prevent Escape from closing a mandatory\n'
          '// dialog (e.g., terms acceptance):\n'
          'Actions(\n'
          '  actions: {\n'
          '    DismissIntent: CallbackAction<DismissIntent>(\n'
          '      onInvoke: (intent) {\n'
          '        // Do nothing — block dismiss\n'
          '        return null;\n'
          '      },\n'
          '    ),\n'
          '  },\n'
          '  child: MandatoryDialog(),\n'
          ')',
    },
    {
      'title': 'Custom Dismiss with Animation',
      'color': Colors.red[600]!,
      'code': '// Trigger a custom exit animation before\n'
          '// actually closing:\n'
          'Actions(\n'
          '  actions: {\n'
          '    DismissIntent: CallbackAction<DismissIntent>(\n'
          '      onInvoke: (intent) async {\n'
          '        await _animationController.reverse();\n'
          '        Navigator.of(context).pop();\n'
          '        return null;\n'
          '      },\n'
          '    ),\n'
          '  },\n'
          '  child: AnimatedDialogContent(),\n'
          ')',
    },
    {
      'title': 'Dismiss with Result',
      'color': Colors.deepOrange[700]!,
      'code': '// Return a specific value when dismissing:\n'
          'Actions(\n'
          '  actions: {\n'
          '    DismissIntent: CallbackAction<DismissIntent>(\n'
          '      onInvoke: (intent) {\n'
          '        Navigator.of(context).pop(\'dismissed\');\n'
          '        return null;\n'
          '      },\n'
          '    ),\n'
          '  },\n'
          '  child: SelectionDialog(),\n'
          ')\n'
          '\n'
          '// Caller receives:\n'
          '// final result = await showDialog(...);\n'
          '// if (result == \'dismissed\') { ... }',
    },
  ];

  print('  Prepared ${overridePatterns.length} override patterns');

  // ============================================================
  // SECTION 7: Dismiss vs Back vs Pop
  // ============================================================
  print('=== Section 7: Dismiss vs Back vs Pop ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Trigger',
      'dismiss': 'Escape key',
      'back': 'System back button/gesture',
      'pop': 'Navigator.pop()',
    },
    {
      'aspect': 'Intent',
      'dismiss': 'DismissIntent',
      'back': 'PopRoute / BackButton',
      'pop': 'N/A (direct call)',
    },
    {
      'aspect': 'Action',
      'dismiss': 'DismissAction',
      'back': 'BackButtonDispatcher',
      'pop': 'N/A',
    },
    {
      'aspect': 'Scope',
      'dismiss': 'Current overlay only',
      'back': 'System navigation stack',
      'pop': 'Navigator route stack',
    },
    {
      'aspect': 'Customizable',
      'dismiss': 'Yes (Actions system)',
      'back': 'Yes (WillPopScope / PopScope)',
      'pop': 'No (always pops)',
    },
    {
      'aspect': 'Platform',
      'dismiss': 'Desktop / Web',
      'back': 'Android / Web back btn',
      'pop': 'All platforms',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 8: Related Actions
  // ============================================================
  print('=== Section 8: Related Actions ===');

  final relatedActions = <Map<String, dynamic>>[
    {
      'name': 'DismissMenuAction',
      'icon': Icons.menu_open,
      'color': Colors.red[700]!,
      'description': 'Specialized DismissAction for menus. Closes the menu '
          'overlay and restores focus to the menu anchor widget. Used by '
          'PopupMenuButton, MenuAnchor, and DropdownMenu.',
    },
    {
      'name': 'ActivateAction',
      'icon': Icons.touch_app,
      'color': Colors.deepOrange[600]!,
      'description': 'The opposite gesture — activates/selects the currently '
          'focused widget (Enter/Space key). While DismissAction closes, '
          'ActivateAction confirms or triggers.',
    },
    {
      'name': 'ScrollAction',
      'icon': Icons.swap_vert,
      'color': Colors.red[600]!,
      'description': 'Handles scroll intents from keyboard (Page Up/Down, '
          'Home, End). Works alongside DismissAction in scroll views — '
          'Escape dismisses overlay, scroll keys navigate content.',
    },
    {
      'name': 'DirectionalFocusAction',
      'icon': Icons.arrow_circle_right,
      'color': Colors.deepOrange[700]!,
      'description': 'Moves focus directionally (arrow keys). Within '
          'overlays, directional focus navigates between items (e.g., '
          'menu items), while Escape via DismissAction closes the overlay.',
    },
  ];

  print('  Prepared ${relatedActions.length} related actions');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Automatic Registration',
      'body': 'DismissAction is automatically registered by MaterialApp/'
          'CupertinoApp. Dialog routes, bottom sheets, and menus each '
          'install their own dismiss handlers. You only need to register '
          'a custom one if you want different behavior.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'maybePop vs pop',
      'body': 'DismissAction uses maybePop(), not pop(). This means '
          'routes can decide NOT to pop (via PopScope / onPopInvoked). '
          'If you absolutely need to close, use Navigator.pop() instead '
          'of relying on DismissAction.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Testing Dismiss',
      'body': 'In widget tests, simulate Escape key press with '
          'tester.sendKeyEvent(LogicalKeyboardKey.escape). Verify '
          'that DismissAction is handling it by checking that the '
          'overlay is no longer in the widget tree after the key event.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Nested Overlays',
      'body': 'When overlays are nested (e.g., a dialog opens a dropdown), '
          'Escape dismisses the topmost overlay first. Each overlay has '
          'its own DismissAction in the tree, and the innermost one wins '
          'focus and handles the intent first.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'isActionEnabled Check',
      'body': 'DismissAction reports isEnabled: false if there is no '
          'ModalRoute in the current context. This means calling '
          'Actions.find<DismissIntent>(context) may return a disabled '
          'action if you\'re not inside a route or overlay.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine with WillPopScope Replacement',
      'body': 'Use PopScope (Flutter 3.16+) alongside DismissAction. '
          'PopScope handles both back button AND dismiss intent intercepts. '
          'Set canPop: false and use onPopInvokedWithResult to handle '
          'both dismiss vectors consistently.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('DismissAction'),
      backgroundColor: Colors.red[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red[700]!, Colors.deepOrange[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.close, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DismissAction',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The built-in Action for handling DismissIntent. '
                  'Closes dialogs, menus, drawers, and overlays when the '
                  'Escape key is pressed. Integrates with the Actions '
                  'and Shortcuts system for consistent dismiss behavior.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _daHead('1', 'What is DismissAction?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: API ──
          _daHead('2', 'DismissIntent & DismissAction API'),
          SizedBox(height: 12),
          ...apiProperties.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace')),
                        ),
                        _daTag(p['type'] as String, p['color'] as Color),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Usage Contexts ──
          _daHead('3', 'Where Dismiss Is Used'),
          SizedBox(height: 12),
          ...usageContexts.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: uc['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(uc['icon'] as IconData,
                            color: uc['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(uc['widget'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(uc['dismiss'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(children: [
                          Icon(Icons.info_outline,
                              size: 12, color: Colors.orange[700]),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(uc['barrier'] as String,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.orange[800])),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Dismiss Flow ──
          _daHead('4', 'Dismiss Flow Visualization'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(
              children: flowSteps.map((fs) {
                final isLast =
                    fs['step'] == flowSteps.last['step'];
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: fs['color'] as Color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text('${fs['step']}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 30,
                              color: Colors.grey[300],
                            ),
                        ]),
                        SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(fs['title'] as String,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: fs['color'] as Color)),
                                SizedBox(height: 3),
                                Text(fs['description'] as String,
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[700],
                                        height: 1.3)),
                                if (!isLast) SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 5: Platform Behavior ──
          _daHead('5', 'Escape Key & Platform Behavior'),
          SizedBox(height: 12),
          ...platformBehaviors.map((pb) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: pb['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(pb['icon'] as IconData,
                            color: pb['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(pb['platform'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(pb['behavior'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Override Patterns ──
          _daHead('6', 'Overriding Dismiss Behavior'),
          SizedBox(height: 12),
          ...overridePatterns.map((op) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: op['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(op['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(op['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.orange[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Comparison Table ──
          _daHead('7', 'Dismiss vs Back vs Pop'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 65,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('Dismiss',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('Back',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('Pop',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 5),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 65,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['dismiss'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.red[700]))),
                      Expanded(
                          child: Text(r['back'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['pop'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[700]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 8: Related Actions ──
          _daHead('8', 'Related Actions'),
          SizedBox(height: 12),
          ...relatedActions.map((ra) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ra['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ra['icon'] as IconData,
                            color: ra['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ra['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 12)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(ra['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _daHead('9', 'Tips & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),
          Center(
            child: Text(
              'End of DismissAction Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _daHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.red[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Tag badge for types
// ──────────────────────────────────────────────────────────
Widget _daTag(String text, Color color) {
  return Container(
    constraints: BoxConstraints(maxWidth: 160),
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: color,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}

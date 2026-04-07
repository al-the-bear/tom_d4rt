// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — WillPopScope
// Demonstrates WillPopScope, a widget that intercepts back-button and pop
// navigation. Covers the callback mechanism, common patterns, nesting,
// form guards, migration to PopScope, and advanced use cases.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WillPopScope Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.block,
      'title': 'What is WillPopScope?',
      'body': 'WillPopScope intercepts the system back button and '
          'Navigator.pop calls. It wraps a subtree and provides '
          'an onWillPop callback that returns true (allow pop) '
          'or false (block pop). This enables confirmation '
          'dialogs and unsaved-changes guards.',
      'accent': Colors.deepPurple,
    },
    {
      'icon': Icons.arrow_back,
      'title': 'Back Button Interception',
      'body': 'On Android, the physical/gesture back button triggers '
          'a pop on the Navigator. WillPopScope intercepts this '
          'before it reaches the Navigator, giving the app a '
          'chance to ask "Are you sure?" or save data first.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Deprecation Notice',
      'body': 'WillPopScope is deprecated in favor of PopScope. '
          'PopScope uses a synchronous canPop flag and an '
          'onPopInvokedWithResult callback, which integrates better '
          'with predictive back gestures on Android 14+.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'Migration Path',
      'body': 'Replace WillPopScope(onWillPop: callback) with '
          'PopScope(canPop: boolValue, onPopInvokedWithResult: '
          'callback). The new API separates the "can pop" decision '
          'from the "was popped" notification cleanly.',
      'accent': Colors.green,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final c = conceptItems[i];
    final accent = c['accent'] as Color;
    print('Concept ${i + 1}: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'onWillPop',
      'type': 'WillPopCallback?',
      'desc': 'An async callback called when the user tries to pop this '
          'route. Returns Future<bool>: true to allow the pop, '
          'false to prevent it. Can show dialogs, save data, or '
          'run any async logic before deciding.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The widget subtree that WillPopScope wraps. This is the '
          'content that is protected from unintentional back '
          'navigation. Only one WillPopScope per route is active.',
    },
    {
      'name': 'Route.willPop()',
      'type': 'Future<RoutePopDisposition>',
      'desc': 'Under the hood, WillPopScope registers with the '
          'ModalRoute. When pop is attempted, the route calls '
          'willPop on all registered callbacks. The innermost '
          'WillPopScope in the widget tree wins.',
    },
    {
      'name': 'ModalRoute.of(context)',
      'type': 'ModalRoute<T>?',
      'desc': 'Retrieves the current modal route. Useful for checking '
          'whether pop is in progress, accessing route settings, '
          'or manually triggering route-level operations.',
    },
    {
      'name': 'Navigator.maybePop()',
      'type': 'Future<bool>',
      'desc': 'Tries to pop the current route, respecting WillPopScope. '
          'Returns true if the route was popped, false if a '
          'WillPopScope callback blocked the pop.',
    },
    {
      'name': 'PopScope.canPop',
      'type': 'bool',
      'desc': 'The replacement in PopScope. A synchronous boolean that '
          'tells the system whether this route can be popped. '
          'Simpler than onWillPop\u0027s async Future<bool>.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.deepPurple.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Patterns
  // ============================================================
  print('=== Section 3: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Simple Block',
      'desc': 'Block all back navigation unconditionally. The user '
          'must use an explicit action (button, swipe) to leave.',
      'diagram': 'WillPopScope(\n'
          '  onWillPop: () async => false,\n'
          '  child: MyContent(),\n'
          ')',
      'color': Colors.deepPurple,
    },
    {
      'title': 'Confirmation Dialog',
      'desc': 'Show a dialog asking the user if they really want to '
          'leave. Return the dialog result as the pop decision.',
      'diagram': 'WillPopScope(\n'
          '  onWillPop: () async {\n'
          '    final ok = await showDialog(\n'
          '      context: ctx,\n'
          '      builder: (_) => AlertDialog(\n'
          '        title: Text("Leave?"),\n'
          '        actions: [\n'
          '          TextButton(\n'
          '            onPressed: () => pop(false),\n'
          '            child: Text("Stay"),\n'
          '          ),\n'
          '          TextButton(\n'
          '            onPressed: () => pop(true),\n'
          '            child: Text("Leave"),\n'
          '          ),\n'
          '        ],\n'
          '      ),\n'
          '    );\n'
          '    return ok ?? false;\n'
          '  },\n'
          '  child: FormPage(),\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'Conditional Guard',
      'desc': 'Only block when there are unsaved changes. Allow free '
          'navigation when the form is clean.',
      'diagram': 'WillPopScope(\n'
          '  onWillPop: () async {\n'
          '    if (!hasUnsavedChanges) return true;\n'
          '    return await showSaveDialog();\n'
          '  },\n'
          '  child: EditPage(),\n'
          ')',
      'color': Colors.green,
    },
    {
      'title': 'Double-Back Exit',
      'desc': 'On first back press show a snackbar "Press again to '
          'exit". On second press within 2 seconds, allow pop.',
      'diagram': 'DateTime? lastPress;\n'
          'WillPopScope(\n'
          '  onWillPop: () async {\n'
          '    final now = DateTime.now();\n'
          '    if (lastPress == null ||\n'
          '        now.difference(lastPress!)\n'
          '          > Duration(seconds: 2)) {\n'
          '      lastPress = now;\n'
          '      showSnackBar("Press again");\n'
          '      return false;\n'
          '    }\n'
          '    return true;\n'
          '  },\n'
          '  child: HomePage(),\n'
          ')',
      'color': Colors.orange,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patterns.length; i++) {
    final p = patterns[i];
    final pColor = p['color'] as Color;
    print('Pattern ${i + 1}: ${p['title']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: pColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                p['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  p['diagram'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Nesting
  // ============================================================
  print('=== Section 4: Nesting ===');

  final nestingTopics = <Map<String, dynamic>>[
    {
      'title': 'Single Active Callback',
      'desc': 'Only the innermost WillPopScope in the widget tree has '
          'its onWillPop callback called. Outer WillPopScope '
          'widgets are ignored when a deeper one exists.',
      'icon': Icons.filter_1,
      'color': Colors.deepPurple,
    },
    {
      'title': 'Registration Order',
      'desc': 'WillPopScope registers with the ModalRoute in '
          'initState. The last one to register (deepest in tree) '
          'takes priority. Removal in dispose restores the outer.',
      'icon': Icons.sort,
      'color': Colors.blue,
    },
    {
      'title': 'Modal Bottom Sheets',
      'desc': 'A modal bottom sheet creates a new ModalRoute. Placing '
          'WillPopScope inside it intercepts the sheet\u0027s back '
          'button, not the parent route\u0027s.',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.green,
    },
    {
      'title': 'Dialogs',
      'desc': 'Dialogs also create ModalRoutes. A WillPopScope inside '
          'a dialog controls whether the dialog can be dismissed '
          'by back button. The parent route is unaffected.',
      'icon': Icons.open_in_new,
      'color': Colors.orange,
    },
    {
      'title': 'Multiple Routes',
      'desc': 'Each route in the Navigator stack can have its own '
          'WillPopScope. When popping, only the top route\u0027s '
          'WillPopScope is consulted.',
      'icon': Icons.layers,
      'color': Colors.red,
    },
  ];

  final nestingWidgets = <Widget>[];
  for (var i = 0; i < nestingTopics.length; i++) {
    final nt = nestingTopics[i];
    final ntColor = nt['color'] as Color;
    print('Nesting ${i + 1}: ${nt['title']}');
    nestingWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ntColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ntColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ntColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(nt['icon'] as IconData, color: ntColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nt['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ntColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    nt['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
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

  // ============================================================
  // SECTION 5: Form Guard
  // ============================================================
  print('=== Section 5: Form Guard ===');

  final guardSteps = <Map<String, dynamic>>[
    {
      'step': '1. Wrap Form in WillPopScope',
      'desc': 'Place WillPopScope at the top of your form page. The '
          'onWillPop callback has access to form state.',
      'icon': Icons.wrap_text,
      'color': Colors.deepPurple,
    },
    {
      'step': '2. Track Dirty State',
      'desc': 'Maintain a boolean _isDirty that becomes true when the '
          'user modifies any field. Reset it after saving.',
      'icon': Icons.edit_note,
      'color': Colors.blue,
    },
    {
      'step': '3. Check on Pop',
      'desc': 'In onWillPop, if _isDirty is false, return true (allow '
          'pop). If true, show a confirmation dialog.',
      'icon': Icons.help_outline,
      'color': Colors.green,
    },
    {
      'step': '4. Offer Save or Discard',
      'desc': 'The dialog offers three options: Save (validate + save + '
          'pop), Discard (pop without saving), Cancel (stay on '
          'form). Return true for Save/Discard, false for Cancel.',
      'icon': Icons.save_alt,
      'color': Colors.orange,
    },
    {
      'step': '5. Handle Async Save',
      'desc': 'If save is async, await it in onWillPop. Show a loading '
          'indicator during the save. Return true only after '
          'successful save, or false if save fails.',
      'icon': Icons.cloud_upload,
      'color': Colors.red,
    },
  ];

  final guardWidgets = <Widget>[];
  for (var i = 0; i < guardSteps.length; i++) {
    final gs = guardSteps[i];
    final gsColor = gs['color'] as Color;
    print('Guard ${i + 1}: ${gs['step']}');
    guardWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: gsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    gs['icon'] as IconData,
                    color: gsColor,
                    size: 18,
                  ),
                ),
                if (i < guardSteps.length - 1)
                  Container(
                    width: 2,
                    height: 28,
                    color: gsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: gsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: gsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gs['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: gsColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      gs['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Migration
  // ============================================================
  print('=== Section 6: Migration ===');

  final migrationRows = <Map<String, dynamic>>[
    {
      'old': 'WillPopScope',
      'new': 'PopScope',
      'desc': 'The replacement widget. Available from Flutter 3.12+.',
      'color': Colors.deepPurple,
    },
    {
      'old': 'onWillPop: () async {\n  return false;\n}',
      'new': 'canPop: false',
      'desc': 'Simple "block pop" becomes a boolean flag.',
      'color': Colors.blue,
    },
    {
      'old': 'onWillPop: () async {\n  if (clean) return true;\n  return await ask();\n}',
      'new': 'canPop: clean,\nonPopInvokedWithResult:\n  (didPop, result) {\n  if (!didPop) ask();\n}',
      'desc': 'Conditional guard separates flag from callback.',
      'color': Colors.green,
    },
    {
      'old': 'Future<bool>',
      'new': 'void',
      'desc': 'The callback no longer returns a decision. canPop is '
          'checked synchronously before the callback fires.',
      'color': Colors.orange,
    },
    {
      'old': 'Navigator.maybePop()',
      'new': 'Navigator.maybePop()',
      'desc': 'Still works with PopScope. Checks canPop instead of '
          'calling the async callback.',
      'color': Colors.red,
    },
  ];

  final migrationWidgets = <Widget>[];
  for (var i = 0; i < migrationRows.length; i++) {
    final mr = migrationRows[i];
    final mrColor = mr['color'] as Color;
    print('Migration ${i + 1}: ${mr['old']} -> ${mr['new']}');
    migrationWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: mrColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: mrColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.red.withOpacity(0.15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Old',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            mr['old'] as String,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9,
                              color: Color(0xFF333333),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.arrow_forward,
                      color: mrColor,
                      size: 18,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.green.withOpacity(0.15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            mr['new'] as String,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9,
                              color: Color(0xFF333333),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                mr['desc'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Edge Cases
  // ============================================================
  print('=== Section 7: Edge Cases ===');

  final edgeCases = <Map<String, dynamic>>[
    {
      'title': 'System Back vs Navigator.pop',
      'desc': 'WillPopScope only intercepts user-initiated pops (back '
          'button, maybePop). Direct Navigator.pop() calls bypass '
          'WillPopScope entirely.',
      'severity': 'high',
      'color': Colors.red,
    },
    {
      'title': 'Async Dialog Race',
      'desc': 'If the user rapidly presses back while a dialog is '
          'showing, onWillPop may be called again. Guard against '
          'multiple dialogs with a _isDialogVisible flag.',
      'severity': 'medium',
      'color': Colors.orange,
    },
    {
      'title': 'Root Route',
      'desc': 'On the root route (no previous route), back button '
          'calls SystemNavigator.pop() which exits the app. '
          'WillPopScope can block this too.',
      'severity': 'low',
      'color': Colors.blue,
    },
    {
      'title': 'iOS Swipe Back',
      'desc': 'On iOS, the swipe-back gesture triggers a pop. '
          'WillPopScope interrupts it, but the gesture animation '
          'still starts. This can feel janky to users.',
      'severity': 'medium',
      'color': Colors.orange,
    },
    {
      'title': 'Predictive Back (Android 14+)',
      'desc': 'Android 14 shows a preview of the previous screen when '
          'swiping back. WillPopScope cannot participate in this '
          'preview. PopScope\u0027s canPop works correctly.',
      'severity': 'high',
      'color': Colors.red,
    },
  ];

  final edgeWidgets = <Widget>[];
  for (var i = 0; i < edgeCases.length; i++) {
    final ec = edgeCases[i];
    final ecColor = ec['color'] as Color;
    final sev = ec['severity'] as String;
    print('Edge ${i + 1}: ${ec['title']}');
    edgeWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: ecColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ecColor.withOpacity(0.25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: ecColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  sev.toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: ecColor,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ec['title'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: ecColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ec['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.block,
      'text': 'WillPopScope intercepts back-button and Navigator.pop '
          'to prevent unintentional navigation away from a page.',
    },
    {
      'icon': Icons.assignment_return,
      'text': 'onWillPop returns Future<bool>: true allows the pop, '
          'false blocks it. Can run async logic.',
    },
    {
      'icon': Icons.save,
      'text': 'Primary use case: form guards that ask "Save changes?" '
          'before leaving an unsaved form.',
    },
    {
      'icon': Icons.layers,
      'text': 'Only the innermost WillPopScope on the current route is '
          'active. Outer ones are ignored.',
    },
    {
      'icon': Icons.warning,
      'text': 'Deprecated in favor of PopScope. Migrate for Android 14 '
          'predictive back gesture support.',
    },
    {
      'icon': Icons.swap_vert,
      'text': 'PopScope separates canPop (sync bool) from '
          'onPopInvokedWithResult (notification callback).',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.deepPurple.shade800,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
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
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('WillPopScope'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
            Tab(icon: Icon(Icons.layers), text: 'Nesting'),
            Tab(icon: Icon(Icons.save), text: 'Form Guard'),
            Tab(icon: Icon(Icons.swap_horiz), text: 'Migration'),
            Tab(icon: Icon(Icons.warning_amber), text: 'Edge Cases'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'WillPopScope: intercept back navigation to guard '
                  'routes with confirmation dialogs.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'WillPopScope API and related navigation methods.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common usage patterns for WillPopScope.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
            ],
          ),
          // Tab 4
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Nesting behavior and route interactions.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...nestingWidgets,
            ],
          ),
          // Tab 5
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Protecting forms from accidental navigation.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...guardWidgets,
            ],
          ),
          // Tab 6
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Migrating from WillPopScope to PopScope.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...migrationWidgets,
            ],
          ),
          // Tab 7
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Edge cases and platform-specific behavior.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...edgeWidgets,
            ],
          ),
          // Tab 8
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple.withOpacity(0.12),
                      Colors.purple.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about WillPopScope.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}

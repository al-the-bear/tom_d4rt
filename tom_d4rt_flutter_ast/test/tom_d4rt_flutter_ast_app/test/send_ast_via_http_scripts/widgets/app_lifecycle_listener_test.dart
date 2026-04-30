// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — AppLifecycleListener
// Demonstrates AppLifecycleListener which listens to application lifecycle
// state changes. Covers all lifecycle states, callback registration,
// exit request handling, state transitions, and real-world use cases
// such as pausing media, saving data, and releasing resources.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AppLifecycleListener Deep Demo executing');

  // ============================================================
  // SECTION 1: What is AppLifecycleListener?
  // ============================================================
  print('=== Section 1: Core Concepts ===');

  final concepts = <Map<String, dynamic>>[
    {
      'icon': Icons.replay_circle_filled,
      'title': 'AppLifecycleListener',
      'body': 'AppLifecycleListener is a class that listens to changes '
          'in the application lifecycle. Unlike WidgetsBindingObserver, '
          'it provides individual named callbacks for each state '
          'transition instead of a single didChangeAppLifecycleState '
          'method with a switch statement.',
      'color': Colors.green,
    },
    {
      'icon': Icons.phone_android,
      'title': 'Lifecycle States',
      'body': 'Flutter apps move through states: resumed (foreground), '
          'inactive (partially visible), hidden (not visible), paused '
          '(background), detached (no view). AppLifecycleListener '
          'fires callbacks for each transition.',
      'color': Colors.blue,
    },
    {
      'icon': Icons.exit_to_app,
      'title': 'Exit Requests',
      'body': 'On desktop platforms, AppLifecycleListener can intercept '
          'window close requests via onExitRequested. Return '
          'AppExitResponse.exit to allow or AppExitResponse.cancel '
          'to prevent the close (e.g. unsaved changes dialog).',
      'color': Colors.red,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'vs WidgetsBindingObserver',
      'body': 'WidgetsBindingObserver requires a mixin on State and '
          'manual addObserver/removeObserver. AppLifecycleListener '
          'is a standalone object: construction starts listening, '
          'dispose() stops. Much simpler and less error-prone.',
      'color': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < concepts.length; i++) {
    final c = concepts[i];
    final color = c['color'] as Color;
    print('  Concept: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.02)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: color, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      c['body'] as String,
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: Colors.grey.shade800,
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
  // SECTION 2: Lifecycle States — Visual Flow
  // ============================================================
  print('=== Section 2: Lifecycle State Flow ===');

  final states = <Map<String, dynamic>>[
    {
      'state': 'resumed',
      'desc': 'App is in the foreground, fully visible, '
          'and responding to user input.',
      'icon': Icons.play_circle_fill,
      'color': Colors.green,
      'platform': 'All',
    },
    {
      'state': 'inactive',
      'desc': 'App is partially visible or in an unfocused '
          'state (e.g. phone call, split screen edge).',
      'icon': Icons.pause_circle,
      'color': Colors.amber,
      'platform': 'iOS, Android',
    },
    {
      'state': 'hidden',
      'desc': 'App is completely hidden but still running '
          '(transition state between inactive and paused).',
      'icon': Icons.visibility_off,
      'color': Colors.orange,
      'platform': 'All',
    },
    {
      'state': 'paused',
      'desc': 'App is in the background. May be killed by OS '
          'at any time without notification.',
      'icon': Icons.stop_circle,
      'color': Colors.red,
      'platform': 'All',
    },
    {
      'state': 'detached',
      'desc': 'Engine is running but no view is attached. '
          'Startup or shutdown transition state.',
      'icon': Icons.power_off,
      'color': Colors.grey,
      'platform': 'All',
    },
  ];

  final stateWidgets = <Widget>[];
  for (var i = 0; i < states.length; i++) {
    final s = states[i];
    final color = s['color'] as Color;
    print('  State: ${s['state']}');

    stateWidgets.add(
      Row(
        children: [
          // State circle
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(s['icon'] as IconData, color: color, size: 20),
                Text(
                  s['state'] as String,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'AppLifecycleState.${s['state']}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        s['platform'] as String,
                        style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  s['desc'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.3,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // Arrow between states
    if (i < states.length - 1) {
      stateWidgets.add(
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Column(
            children: [
              const SizedBox(height: 4),
              Icon(Icons.arrow_downward, size: 18, color: Colors.grey.shade400),
              const SizedBox(height: 4),
            ],
          ),
        ),
      );
    }
  }

  final stateFlowPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.green, size: 22),
            const SizedBox(width: 10),
            Text(
              'Lifecycle State Flow',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'States progress top to bottom when app goes to background, '
          'and reverse when returning to foreground:',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 16),
        ...stateWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Callback Registration
  // ============================================================
  print('=== Section 3: Callback Registration ===');

  final callbacks = <Map<String, dynamic>>[
    {
      'callback': 'onResume',
      'trigger': 'App returns to foreground (resumed)',
      'color': Colors.green,
    },
    {
      'callback': 'onInactive',
      'trigger': 'App becomes partially obscured (inactive)',
      'color': Colors.amber,
    },
    {
      'callback': 'onHide',
      'trigger': 'App becomes fully hidden (hidden)',
      'color': Colors.orange,
    },
    {
      'callback': 'onPause',
      'trigger': 'App enters background (paused)',
      'color': Colors.red,
    },
    {
      'callback': 'onDetach',
      'trigger': 'Engine loses all views (detached)',
      'color': Colors.grey,
    },
    {
      'callback': 'onRestart',
      'trigger': 'App returns from paused to inactive',
      'color': Colors.blue,
    },
    {
      'callback': 'onStateChange',
      'trigger': 'Any state change (receives AppLifecycleState)',
      'color': Colors.purple,
    },
    {
      'callback': 'onExitRequested',
      'trigger': 'Desktop: window close request (return exit/cancel)',
      'color': Colors.deepOrange,
    },
  ];

  final callbackRows = <Widget>[];
  for (var cb in callbacks) {
    final color = cb['color'] as Color;
    print('  Callback: ${cb['callback']}');
    callbackRows.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 120,
              child: Text(
                cb['callback'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Expanded(
              child: Text(
                cb['trigger'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final callbackPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.notifications_active, color: Colors.green, size: 22),
            const SizedBox(width: 10),
            Text(
              'Available Callbacks',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...callbackRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Usage Pattern — Code Example
  // ============================================================
  print('=== Section 4: Usage Pattern ===');

  final usagePanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.indigo, size: 22),
            const SizedBox(width: 10),
            Text(
              'Standard Usage Pattern',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'class _MyWidgetState extends State<MyWidget> {\n'
            '  late final AppLifecycleListener _listener;\n'
            '\n'
            '  @override\n'
            '  void initState() {\n'
            '    super.initState();\n'
            '    _listener = AppLifecycleListener(\n'
            '      onResume: () => print("Resumed!"),\n'
            '      onInactive: () => _saveProgress(),\n'
            '      onPause: () => _pauseMedia(),\n'
            '      onDetach: () => _releaseResources(),\n'
            '      onExitRequested: () async {\n'
            '        if (_hasUnsavedChanges) {\n'
            '          return AppExitResponse.cancel;\n'
            '        }\n'
            '        return AppExitResponse.exit;\n'
            '      },\n'
            '    );\n'
            '  }\n'
            '\n'
            '  @override\n'
            '  void dispose() {\n'
            '    _listener.dispose(); // CRITICAL!\n'
            '    super.dispose();\n'
            '  }\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              height: 1.5,
              color: Colors.greenAccent,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning, color: Colors.red, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Always call dispose() on the listener! Failing to '
                  'do so will cause memory leaks as the listener '
                  'keeps its binding registration alive.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: Colors.red.shade700,
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
  // SECTION 5: State Transitions — What Fires When
  // ============================================================
  print('=== Section 5: State Transitions ===');

  final transitionScenarios = <Map<String, dynamic>>[
    {
      'scenario': 'User presses Home',
      'sequence': ['onInactive', 'onHide', 'onPause'],
      'color': Colors.red,
      'icon': Icons.home,
    },
    {
      'scenario': 'User returns to app',
      'sequence': ['onRestart', 'onResume'],
      'color': Colors.green,
      'icon': Icons.open_in_new,
    },
    {
      'scenario': 'Phone call overlay (iOS)',
      'sequence': ['onInactive'],
      'color': Colors.amber,
      'icon': Icons.phone,
    },
    {
      'scenario': 'Call ends, app visible again',
      'sequence': ['onResume'],
      'color': Colors.green,
      'icon': Icons.phone_enabled,
    },
    {
      'scenario': 'App switcher opened',
      'sequence': ['onInactive'],
      'color': Colors.orange,
      'icon': Icons.swap_horiz,
    },
    {
      'scenario': 'Desktop window close',
      'sequence': ['onExitRequested', 'onDetach'],
      'color': Colors.deepOrange,
      'icon': Icons.close,
    },
  ];

  final transitionCards = <Widget>[];
  for (var ts in transitionScenarios) {
    final color = ts['color'] as Color;
    final sequence = ts['sequence'] as List<String>;
    print('  Scenario: ${ts['scenario']}');

    transitionCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(ts['icon'] as IconData, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ts['scenario'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      for (var i = 0; i < sequence.length; i++) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            sequence[i],
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                        if (i < sequence.length - 1)
                          Icon(
                            Icons.arrow_forward,
                            size: 12,
                            color: Colors.grey.shade400,
                          ),
                      ],
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

  final transitionPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_calls, color: Colors.blue, size: 22),
            const SizedBox(width: 10),
            Text(
              'What Fires When?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...transitionCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Exit Request Handling (Desktop)
  // ============================================================
  print('=== Section 6: Exit Request Handling ===');

  final exitPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.deepOrange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.exit_to_app, color: Colors.deepOrange, size: 22),
            const SizedBox(width: 10),
            Text(
              'Exit Request Handling (Desktop)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'On macOS, Windows, and Linux, applications can intercept '
          'the window close request. This enables "unsaved changes" '
          'dialogs and cleanup before exit.',
          style: TextStyle(fontSize: 12, height: 1.4, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 14),
        // Flow chart for exit handling
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.deepOrange.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.close, color: Colors.deepOrange, size: 28),
                    const SizedBox(height: 6),
                    Text(
                      'User clicks X',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.grey.shade400),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.question_mark, color: Colors.blue, size: 28),
                    const SizedBox(height: 6),
                    Text(
                      'onExitRequested\ncalled',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.grey.shade400),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check, color: Colors.green, size: 20),
                        Text(
                          '.exit',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.block, color: Colors.red, size: 20),
                        Text(
                          '.cancel',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
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
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'onExitRequested: () async {\n'
            '  final hasChanges = await _checkUnsavedChanges();\n'
            '  if (hasChanges) {\n'
            '    final confirmed = await showDialog<bool>(\n'
            '      context: context,\n'
            '      builder: (_) => AlertDialog(\n'
            '        title: Text("Unsaved Changes"),\n'
            '        content: Text("Discard changes?"),\n'
            '        actions: [\n'
            '          TextButton(\n'
            '            onPressed: () => Navigator.pop(_, false),\n'
            '            child: Text("Cancel"),\n'
            '          ),\n'
            '          TextButton(\n'
            '            onPressed: () => Navigator.pop(_, true),\n'
            '            child: Text("Discard"),\n'
            '          ),\n'
            '        ],\n'
            '      ),\n'
            '    );\n'
            '    return confirmed == true\n'
            '      ? AppExitResponse.exit\n'
            '      : AppExitResponse.cancel;\n'
            '  }\n'
            '  return AppExitResponse.exit;\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              height: 1.5,
              color: Colors.greenAccent,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Observer vs Listener Comparison
  // ============================================================
  print('=== Section 7: Observer vs Listener ===');

  final compRows = <Map<String, dynamic>>[
    {
      'aspect': 'Setup',
      'observer': 'Mixin + addObserver in initState',
      'listener': 'Construct in initState',
    },
    {
      'aspect': 'Teardown',
      'observer': 'removeObserver in dispose',
      'listener': 'listener.dispose()',
    },
    {
      'aspect': 'Callback style',
      'observer': 'Single method + switch',
      'listener': 'Named callbacks per state',
    },
    {
      'aspect': 'Exit handling',
      'observer': 'Not supported',
      'listener': 'onExitRequested callback',
    },
    {
      'aspect': 'Type safety',
      'observer': 'Enum matching required',
      'listener': 'Compile-time named params',
    },
    {
      'aspect': 'Introduced',
      'observer': 'Flutter 1.0',
      'listener': 'Flutter 3.13',
    },
  ];

  final compWidgets = <Widget>[];
  // Header row
  compWidgets.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('Aspect',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.green.shade900)),
          ),
          Expanded(
            flex: 3,
            child: Text('WidgetsBindingObserver',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.green.shade900)),
          ),
          Expanded(
            flex: 3,
            child: Text('AppLifecycleListener',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.green.shade900)),
          ),
        ],
      ),
    ),
  );

  for (var i = 0; i < compRows.length; i++) {
    final row = compRows[i];
    print('  Compare: ${row['aspect']}');
    compWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.grey.shade50 : Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                row['aspect'] as String,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                row['observer'] as String,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                row['listener'] as String,
                style: TextStyle(fontSize: 10, color: Colors.green.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final compPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(children: compWidgets),
  );

  // ============================================================
  // SECTION 8: Real-World Use Cases
  // ============================================================
  print('=== Section 8: Real-World Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Media Playback',
      'desc': 'Pause audio/video on onPause, resume on onResume. '
          'Prevents audio playing in background unexpectedly.',
      'icon': Icons.play_arrow,
      'color': Colors.red,
    },
    {
      'title': 'Auto-Save',
      'desc': 'Save draft/progress on onInactive or onPause so user '
          'data is preserved even if the OS kills the app.',
      'icon': Icons.save,
      'color': Colors.blue,
    },
    {
      'title': 'Location Tracking',
      'desc': 'Stop GPS polling on onPause to save battery. Restart '
          'tracking on onResume for accurate position.',
      'icon': Icons.location_on,
      'color': Colors.green,
    },
    {
      'title': 'WebSocket Reconnection',
      'desc': 'On onResume, check if the websocket connection dropped '
          'during background time and reconnect if needed.',
      'icon': Icons.wifi,
      'color': Colors.orange,
    },
    {
      'title': 'Analytics Sessions',
      'desc': 'Track active session duration. Start timer on onResume, '
          'pause on onPause. Report session length on onDetach.',
      'icon': Icons.analytics,
      'color': Colors.purple,
    },
    {
      'title': 'Desktop Unsaved Changes',
      'desc': 'Use onExitRequested to show "Save before closing?" '
          'dialog. Return AppExitResponse.cancel if user declines.',
      'icon': Icons.warning,
      'color': Colors.deepOrange,
    },
  ];

  final useCaseCards = <Widget>[];
  for (var uc in useCases) {
    final color = uc['color'] as Color;
    print('  Use case: ${uc['title']}');

    useCaseCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(uc['icon'] as IconData, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uc['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    uc['desc'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      color: Colors.grey.shade700,
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

  final useCasePanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.teal, size: 22),
            const SizedBox(width: 10),
            Text(
              'Real-World Use Cases',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...useCaseCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Summary
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryStats = [
    {'label': 'States', 'value': '${states.length}', 'color': Colors.green},
    {'label': 'Callbacks', 'value': '${callbacks.length}', 'color': Colors.blue},
    {'label': 'Scenarios', 'value': '${transitionScenarios.length}', 'color': Colors.orange},
    {'label': 'Use Cases', 'value': '${useCases.length}', 'color': Colors.purple},
  ];

  final statTiles = <Widget>[];
  for (var stat in summaryStats) {
    final color = stat['color'] as Color;
    statTiles.add(
      Container(
        width: 88,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Text(
              stat['value'] as String,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stat['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  final summaryPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.green.shade200, width: 2),
    ),
    child: Column(
      children: [
        Text(
          'AppLifecycleListener — Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(alignment: WrapAlignment.center, children: statTiles),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  print('=== Assembling final layout ===');

  return Scaffold(
    appBar: AppBar(
      title: const Text('AppLifecycleListener Deep Demo'),
      backgroundColor: Colors.green.shade700,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.green.shade50,
            child: Column(
              children: [
                Icon(Icons.replay_circle_filled, size: 48, color: Colors.green.shade700),
                const SizedBox(height: 10),
                Text(
                  'AppLifecycleListener',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Listen to application lifecycle state changes with '
                  'clean, named callbacks.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.green.shade600,
                  ),
                ),
              ],
            ),
          ),
          _lifecycleSectionHeader('1. Core Concepts'),
          ...conceptCards,
          _lifecycleSectionHeader('2. Lifecycle States'),
          stateFlowPanel,
          _lifecycleSectionHeader('3. Callbacks'),
          callbackPanel,
          _lifecycleSectionHeader('4. Usage Pattern'),
          usagePanel,
          _lifecycleSectionHeader('5. State Transitions'),
          transitionPanel,
          _lifecycleSectionHeader('6. Exit Request'),
          exitPanel,
          _lifecycleSectionHeader('7. Observer vs Listener'),
          compPanel,
          _lifecycleSectionHeader('8. Use Cases'),
          useCasePanel,
          _lifecycleSectionHeader('9. Summary'),
          summaryPanel,
          const SizedBox(height: 40),
        ],
      ),
    ),
  );
}

Widget _lifecycleSectionHeader(String title) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 20, 16, 4),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.green.shade700,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

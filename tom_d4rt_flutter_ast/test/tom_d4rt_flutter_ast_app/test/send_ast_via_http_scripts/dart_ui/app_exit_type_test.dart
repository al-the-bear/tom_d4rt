// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AppExitType from dart:ui / Flutter services
// Deep Demo: Visual demonstration of AppExitType enum and app exit handling
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AppExitType Deep Demo executing');

  // ============================================================
  // SECTION 1: AppExitType Enum Values
  // ============================================================
  print('=== Section 1: AppExitType Enum Values ===');

  final enumCards = <Widget>[];

  // Card 1: cancelable
  enumCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.lightGreen.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.green.shade400, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.25),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.cancel_outlined,
              size: 36.0,
              color: Colors.green.shade800,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'AppExitType.cancelable',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'index: 0',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.green.shade900,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'User-initiated exit that the app may veto. The listener can return AppExitResponse.cancel to keep the app running.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.green.shade800),
          ),
        ],
      ),
    ),
  );

  // Card 2: required
  enumCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade50, Colors.orange.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.red.shade400, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.25),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.power_settings_new,
              size: 36.0,
              color: Colors.red.shade800,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'AppExitType.required',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.red.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'index: 1',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.red.shade900,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Forced exit — the OS or system demands termination. Listeners cannot block it; only last-chance cleanup is possible.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.red.shade800),
          ),
        ],
      ),
    ),
  );
  print('Created ${enumCards.length} enum value cards');

  // ============================================================
  // SECTION 2: Real-World Scenarios
  // ============================================================
  print('=== Section 2: Real-World Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'title': 'Unsaved Document',
      'desc': 'User clicks close on an editor with unsaved changes.',
      'mapping': 'AppExitType.cancelable',
      'response': 'Show "Save changes?" dialog',
      'color': Colors.blue,
      'icon': Icons.edit_document,
      'exitType': 'cancelable',
    },
    {
      'title': 'User Logout',
      'desc': 'User chooses Sign Out and confirms in a dialog.',
      'mapping': 'AppExitType.cancelable',
      'response': 'Flush caches, release tokens, then allow exit',
      'color': Colors.indigo,
      'icon': Icons.logout,
      'exitType': 'cancelable',
    },
    {
      'title': 'OS Shutdown',
      'desc': 'System is rebooting; all apps must terminate.',
      'mapping': 'AppExitType.required',
      'response': 'Best-effort flush, then accept exit',
      'color': Colors.deepOrange,
      'icon': Icons.power,
      'exitType': 'required',
    },
    {
      'title': 'Force Quit',
      'desc': 'User invokes Task Manager / Force Quit / kill -9.',
      'mapping': 'AppExitType.required',
      'response': 'No reliable cleanup window — rely on prior saves',
      'color': Colors.red,
      'icon': Icons.dangerous,
      'exitType': 'required',
    },
    {
      'title': 'Update Restart',
      'desc': 'App is restarting to apply a critical update.',
      'mapping': 'AppExitType.cancelable',
      'response': 'Save state and call exitApplication(required)',
      'color': Colors.teal,
      'icon': Icons.system_update_alt,
      'exitType': 'cancelable',
    },
    {
      'title': 'Crash Recovery',
      'desc': 'Unhandled error triggers graceful shutdown.',
      'mapping': 'AppExitType.required',
      'response': 'Log crash, dump state, accept termination',
      'color': Colors.brown,
      'icon': Icons.bug_report,
      'exitType': 'required',
    },
  ];

  final scenarioWidgets = <Widget>[];
  for (final s in scenarios) {
    final color = s['color'] as Color;
    final isCancelable = s['exitType'] == 'cancelable';
    scenarioWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.08), Colors.white],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(s['icon'] as IconData, color: color, size: 26.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        s['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: color,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: isCancelable
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          isCancelable ? 'cancelable' : 'required',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: isCancelable
                                ? Colors.green.shade900
                                : Colors.red.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    s['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        size: 14.0,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          s['response'] as String,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade700,
                          ),
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
    print('Scenario: ${s['title']} -> ${s['mapping']}');
  }
  print('Created ${scenarioWidgets.length} scenario widgets');

  // ============================================================
  // SECTION 3: Decision Tree Diagram
  // ============================================================
  print('=== Section 3: Decision Tree ===');

  final decisionTree = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.blueGrey.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.5),
    ),
    child: Column(
      children: [
        // Root: Exit Request
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.3),
                blurRadius: 6.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.notification_important,
                color: Colors.white,
                size: 20.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Exit request received',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Icon(Icons.arrow_downward, color: Colors.blueGrey.shade400),
        SizedBox(height: 8.0),
        // Question: AppExitType?
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.purple.shade400, width: 2.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.help_outline,
                color: Colors.purple.shade700,
                size: 20.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'What AppExitType is it?',
                style: TextStyle(
                  color: Colors.purple.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Branches
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // cancelable branch
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'cancelable',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.green.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.green.shade400,
                    size: 18.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Decide to cancel?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade900,
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    'YES',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange.shade900,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'cancel',
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 10.0,
                                    color: Colors.orange.shade700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.shade100,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    'NO',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal.shade900,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'exit',
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 10.0,
                                    color: Colors.teal.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // required branch
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'required',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.red.shade400,
                    size: 18.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.red.shade300),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Last-chance cleanup',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900,
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Flush queues,\nthen accept exit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.red.shade800,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 3.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade200,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            'cannot cancel',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900,
                            ),
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
      ],
    ),
  );
  print('Created decision tree diagram');

  // ============================================================
  // SECTION 4: Comparison Table
  // ============================================================
  print('=== Section 4: Comparison Table ===');

  final comparisonRows = <Map<String, String>>[
    {'feature': 'Can listener veto?', 'cancelable': 'Yes', 'required': 'No'},
    {
      'feature': 'AppExitResponse honored?',
      'cancelable': 'Yes',
      'required': 'No (ignored)',
    },
    {
      'feature': 'Show user dialog?',
      'cancelable': 'Encouraged',
      'required': 'Discouraged',
    },
    {
      'feature': 'Async cleanup window',
      'cancelable': 'Full async OK',
      'required': 'Best-effort only',
    },
    {
      'feature': 'Typical trigger',
      'cancelable': 'User close action',
      'required': 'OS / shutdown / kill',
    },
    {
      'feature': 'Use exitApplication() with',
      'cancelable': 'For graceful flow',
      'required': 'For forced flow',
    },
    {
      'feature': 'Enum index',
      'cancelable': '0',
      'required': '1',
    },
  ];

  final comparisonTable = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        // Header row
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade100, Colors.deepPurple.shade100],
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Feature',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'cancelable',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'required',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        for (int i = 0; i < comparisonRows.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: i.isEven ? Colors.grey.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    comparisonRows[i]['feature']!,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    comparisonRows[i]['cancelable']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    comparisonRows[i]['required']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.red.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  print('Created comparison table with ${comparisonRows.length} rows');

  // ============================================================
  // SECTION 5: Platform Behavior Matrix
  // ============================================================
  print('=== Section 5: Platform Behavior Matrix ===');

  final platforms = <Map<String, dynamic>>[
    {
      'name': 'Android',
      'icon': Icons.android,
      'color': Colors.green,
      'cancelable': 'Back button via PopScope; system back triggers cancelable.',
      'required': 'OS low-memory kill or user "Force Stop" → required.',
      'notes': 'Activity lifecycle drives most exit signals.',
    },
    {
      'name': 'iOS',
      'icon': Icons.phone_iphone,
      'color': Colors.blueGrey,
      'cancelable': 'Limited — iOS apps generally do not block exit.',
      'required': 'Home/swipe-up sends app to background, OS may terminate.',
      'notes': 'AppExitType largely advisory on iOS.',
    },
    {
      'name': 'Windows',
      'icon': Icons.desktop_windows,
      'color': Colors.blue,
      'cancelable': 'WM_CLOSE on window X → cancelable; dialog OK.',
      'required': 'WM_ENDSESSION (shutdown) or Task Manager → required.',
      'notes': 'Desktop is where AppExitType matters most.',
    },
    {
      'name': 'macOS',
      'icon': Icons.laptop_mac,
      'color': Colors.grey,
      'cancelable': 'Cmd+Q / red close button → cancelable.',
      'required': 'Force Quit (Cmd+Opt+Esc) or shutdown → required.',
      'notes': 'Honors applicationShouldTerminate semantics.',
    },
    {
      'name': 'Linux',
      'icon': Icons.computer,
      'color': Colors.deepOrange,
      'cancelable': 'WM close button / SIGTERM → cancelable when supported.',
      'required': 'SIGKILL or session end → required.',
      'notes': 'WM-dependent; some setups bypass cancelable entirely.',
    },
    {
      'name': 'Web',
      'icon': Icons.public,
      'color': Colors.purple,
      'cancelable': 'beforeunload approximations only.',
      'required': 'Tab close, navigation away → required-like.',
      'notes': 'Browser sandboxing limits clean cooperation.',
    },
  ];

  final platformWidgets = <Widget>[];
  for (final p in platforms) {
    final color = p['color'] as Color;
    platformWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 4.0,
              offset: Offset(0, 2),
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
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    p['icon'] as IconData,
                    color: color,
                    size: 22.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  p['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'cancelable',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    p['cancelable'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'required',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade900,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    p['required'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 14.0,
                    color: Colors.amber.shade800,
                  ),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      p['notes'] as String,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.amber.shade900,
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
    print('Platform ${p['name']} documented');
  }
  print('Created ${platformWidgets.length} platform widgets');

  // ============================================================
  // SECTION 6: Code Examples
  // ============================================================
  print('=== Section 6: Code Examples ===');

  final codePanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Listening for exit requests',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// AppLifecycleListener exposes the exit request\n'
            'final listener = AppLifecycleListener(\n'
            '  onExitRequested: () async {\n'
            '    final ok = await _confirmSaveDialog();\n'
            '    return ok\n'
            '        ? AppExitResponse.exit\n'
            '        : AppExitResponse.cancel;\n'
            '  },\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Requesting exit with a specific AppExitType',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Graceful: gives the app a chance to veto\n'
            'await ServicesBinding.instance.exitApplication(\n'
            '  AppExitType.cancelable,\n'
            ');\n'
            '\n'
            '// Forced: app must terminate, no veto possible\n'
            'await ServicesBinding.instance.exitApplication(\n'
            '  AppExitType.required,\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.purple.shade300,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Switching on the enum',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Conceptual handler\n'
            'Future<void> handle(AppExitType type) async {\n'
            '  switch (type) {\n'
            '    case AppExitType.cancelable:\n'
            '      await maybeShowUnsavedDialog();\n'
            '      break;\n'
            '    case AppExitType.required:\n'
            '      await emergencyFlush();\n'
            '      break;\n'
            '  }\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.amber.shade200,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Iterating enum values',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// All AppExitType values\n'
            'for (final t in AppExitType.values) {\n'
            '  print("\${t.name} -> index \${t.index}");\n'
            '}\n'
            '// cancelable -> index 0\n'
            '// required   -> index 1',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.cyan.shade200,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code panel');

  // ============================================================
  // SECTION 7: Lifecycle Timeline
  // ============================================================
  print('=== Section 7: Lifecycle Timeline ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': 'User triggers close',
      'desc': 'Click X, Cmd+Q, system shutdown, etc.',
      'icon': Icons.touch_app,
      'color': Colors.blue,
    },
    {
      'step': 'Engine resolves AppExitType',
      'desc': 'OS signal mapped to cancelable or required.',
      'icon': Icons.compare_arrows,
      'color': Colors.indigo,
    },
    {
      'step': 'onExitRequested fires',
      'desc': 'Registered AppLifecycleListener is invoked.',
      'icon': Icons.notifications_active,
      'color': Colors.purple,
    },
    {
      'step': 'App returns AppExitResponse',
      'desc': 'cancel keeps app running (cancelable only).',
      'icon': Icons.reply,
      'color': Colors.teal,
    },
    {
      'step': 'Engine acts on response',
      'desc': 'Cancel honored only for AppExitType.cancelable.',
      'icon': Icons.settings_ethernet,
      'color': Colors.orange,
    },
    {
      'step': 'detached / terminate',
      'desc': 'Process tears down. State must be persisted.',
      'icon': Icons.power_off,
      'color': Colors.red,
    },
  ];

  final timelineWidgets = <Widget>[];
  for (int i = 0; i < lifecycleSteps.length; i++) {
    final step = lifecycleSteps[i];
    final color = step['color'] as Color;
    final isLast = i == lifecycleSteps.length - 1;
    timelineWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: Colors.white,
                  size: 22.0,
                ),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 36.0,
                  color: color.withValues(alpha: 0.5),
                ),
            ],
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 14.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          step['step'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  print('Created ${timelineWidgets.length} lifecycle steps');

  // ============================================================
  // SECTION 8: Summary Panel
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade100, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.summarize, color: Colors.orange.shade900, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Key Takeaways',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.cancel_outlined,
          'cancelable',
          'Listener may veto with AppExitResponse.cancel.',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.power_settings_new,
          'required',
          'Forced exit; cancel response is ignored.',
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.hearing,
          'AppLifecycleListener',
          'Use onExitRequested to handle requests.',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.outbox,
          'exitApplication',
          'ServicesBinding.instance.exitApplication(type).',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.devices,
          'Platform aware',
          'Desktop honors cancelable best; mobile/web less so.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.save,
          'Always persist early',
          'Required exits give no async cleanup guarantee.',
          Colors.brown,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('AppExitType Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header banner
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade600, Colors.deepOrange.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.withValues(alpha: 0.3),
                    blurRadius: 14.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.exit_to_app, size: 60.0, color: Colors.white),
                  SizedBox(height: 10.0),
                  Text(
                    'AppExitType',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Cancelable vs Required app-exit classification',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.95),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'dart:ui / flutter/services',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.0),

            // Section 1
            Text(
              '1. AppExitType Enum Values',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: enumCards,
            ),
            SizedBox(height: 28.0),

            // Section 2
            Text(
              '2. Real-World Scenarios',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...scenarioWidgets,
            SizedBox(height: 28.0),

            // Section 3
            Text(
              '3. Exit Decision Tree',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            decisionTree,
            SizedBox(height: 28.0),

            // Section 4
            Text(
              '4. Comparison: cancelable vs required',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            comparisonTable,
            SizedBox(height: 28.0),

            // Section 5
            Text(
              '5. Platform Behavior Matrix',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...platformWidgets,
            SizedBox(height: 28.0),

            // Section 6
            Text(
              '6. Code Examples',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            codePanel,
            SizedBox(height: 28.0),

            // Section 7
            Text(
              '7. Exit Request Lifecycle',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(children: timelineWidgets),
            ),
            SizedBox(height: 28.0),

            // Section 8
            Text(
              '8. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
            SizedBox(height: 24.0),

            // Footer pill
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.shade200,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'AppExitType Deep Demo',
                  style: TextStyle(
                    color: Colors.orange.shade900,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    ),
  );
}

// Helper: Build summary item row
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
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
              SizedBox(height: 2.0),
              Text(
                desc,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

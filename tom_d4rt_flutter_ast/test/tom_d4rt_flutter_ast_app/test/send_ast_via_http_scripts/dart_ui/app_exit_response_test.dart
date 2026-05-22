// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AppExitResponse from dart:ui
// Deep Demo: Visual exploration of AppExitResponse as the return value of
// AppLifecycleListener.onExitRequested. Focus is NOT on the enum mechanics
// (see app_exit_type_test.dart for AppExitType). Instead this script
// demonstrates *when* to return `exit` vs `cancel`, real-world scenarios,
// the request/response sequence and which platforms participate.
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AppExitResponse Deep Demo executing');

  // Verify the enum surface is what we expect — but only as a sanity check.
  final values = AppExitResponse.values;
  print('AppExitResponse has ${values.length} values:');
  for (final v in values) {
    print('  - ${v.name} (index ${v.index})');
  }

  // ============================================================
  // SECTION 1: Enum Value Cards (exit vs cancel)
  // ============================================================
  print('=== Section 1: Enum Value Cards ===');

  final exitCard = Container(
    margin: EdgeInsets.all(10.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade100],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AppExitResponse.exit',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                  Text(
                    'index: ${AppExitResponse.exit.index}',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Return this to allow the platform to proceed with shutting down '
          'the application. Use when there is nothing left to save, no '
          'pending background work, and no need to confirm with the user.',
          style: TextStyle(fontSize: 12.0, color: Colors.green.shade900),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.green.shade600,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Outcome: app closes',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  final cancelCard = Container(
    margin: EdgeInsets.all(10.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.deepOrange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepOrange.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.25),
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
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade600,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.block,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AppExitResponse.cancel',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange.shade900,
                    ),
                  ),
                  Text(
                    'index: ${AppExitResponse.cancel.index}',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.deepOrange.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Return this to veto the exit request. The platform will keep the '
          'app alive. Use when you need to prompt the user, save state, or '
          'finish critical background work before allowing close.',
          style: TextStyle(fontSize: 12.0, color: Colors.deepOrange.shade900),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade600,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Outcome: app keeps running',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created two enum value cards');

  // ============================================================
  // SECTION 2: Decision Tree
  // ============================================================
  print('=== Section 2: Decision Tree ===');

  final decisionNodes = <Widget>[];

  Widget buildDecisionNode({
    required String question,
    required String yesLabel,
    required AppExitResponse yesResponse,
    required String noLabel,
    required AppExitResponse noResponse,
    required Color accent,
  }) {
    Color colorFor(AppExitResponse r) =>
        r == AppExitResponse.exit ? Colors.green.shade600 : Colors.deepOrange.shade600;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: accent, size: 22.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: colorFor(yesResponse).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: colorFor(yesResponse),
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: colorFor(yesResponse),
                            size: 16.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            'YES',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: colorFor(yesResponse),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        yesLabel,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        '→ ${yesResponse.name}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: colorFor(yesResponse),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: colorFor(noResponse).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: colorFor(noResponse),
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.close,
                            color: colorFor(noResponse),
                            size: 16.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            'NO',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: colorFor(noResponse),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        noLabel,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        '→ ${noResponse.name}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: colorFor(noResponse),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  decisionNodes.add(
    buildDecisionNode(
      question: 'Are there unsaved changes in the document?',
      yesLabel: 'Show "save / discard" dialog first',
      yesResponse: AppExitResponse.cancel,
      noLabel: 'Nothing to lose — let the OS close us',
      noResponse: AppExitResponse.exit,
      accent: Colors.indigo,
    ),
  );

  decisionNodes.add(
    buildDecisionNode(
      question: 'Is a long-running upload / download in progress?',
      yesLabel: 'Veto so the transfer can finish',
      yesResponse: AppExitResponse.cancel,
      noLabel: 'Idle — safe to terminate immediately',
      noResponse: AppExitResponse.exit,
      accent: Colors.teal,
    ),
  );

  decisionNodes.add(
    buildDecisionNode(
      question: 'Did the user enable "confirm before quitting"?',
      yesLabel: 'Cancel and surface a confirm dialog',
      yesResponse: AppExitResponse.cancel,
      noLabel: 'No confirmation needed — close',
      noResponse: AppExitResponse.exit,
      accent: Colors.purple,
    ),
  );

  decisionNodes.add(
    buildDecisionNode(
      question: 'Are we exiting because of an unrecoverable error?',
      yesLabel: 'Tear down quickly, no prompt',
      yesResponse: AppExitResponse.exit,
      noLabel: 'Run normal cleanup pipeline',
      noResponse: AppExitResponse.exit,
      accent: Colors.brown,
    ),
  );
  print('Created ${decisionNodes.length} decision nodes');

  // ============================================================
  // SECTION 3: Real-world Scenarios
  // ============================================================
  print('=== Section 3: Real-world Scenarios ===');

  final scenarios = <Map<String, Object>>[
    {
      'title': 'Text editor with dirty buffer',
      'detail':
          'User has typed text but not pressed Save. Returning cancel '
          'lets you surface a "Save changes?" prompt before exit.',
      'response': AppExitResponse.cancel,
      'icon': Icons.edit_document,
      'tint': Colors.orange,
    },
    {
      'title': 'Read-only viewer, clean state',
      'detail':
          'Nothing mutated since launch. Return exit immediately so the '
          'OS does not show any "app is not responding" UI.',
      'response': AppExitResponse.exit,
      'icon': Icons.menu_book,
      'tint': Colors.green,
    },
    {
      'title': 'Upload in flight',
      'detail':
          'A multi-gigabyte upload is at 60%. Return cancel so the user '
          'is not surprised by a half-finished transfer.',
      'response': AppExitResponse.cancel,
      'icon': Icons.cloud_upload,
      'tint': Colors.blue,
    },
    {
      'title': 'Game with autosave',
      'detail':
          'Autosave just flushed to disk on this frame. Returning exit '
          'is safe — no progress will be lost.',
      'response': AppExitResponse.exit,
      'icon': Icons.videogame_asset,
      'tint': Colors.teal,
    },
    {
      'title': 'Settings preference: confirm quit',
      'detail':
          'User opted in to a confirm-on-exit prompt. Always return '
          'cancel and present the dialog yourself.',
      'response': AppExitResponse.cancel,
      'icon': Icons.shield,
      'tint': Colors.deepPurple,
    },
    {
      'title': 'Headless background daemon',
      'detail':
          'No UI to show, no work pending. Return exit so the platform '
          'reclaims memory without delay.',
      'response': AppExitResponse.exit,
      'icon': Icons.dns,
      'tint': Colors.indigo,
    },
  ];

  final scenarioWidgets = <Widget>[];
  for (final s in scenarios) {
    final title = s['title'] as String;
    final detail = s['detail'] as String;
    final response = s['response'] as AppExitResponse;
    final icon = s['icon'] as IconData;
    final tint = s['tint'] as Color;
    final responseColor = response == AppExitResponse.exit
        ? Colors.green.shade700
        : Colors.deepOrange.shade700;
    scenarioWidgets.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: tint.withValues(alpha: 0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: tint.withValues(alpha: 0.15),
              blurRadius: 6.0,
              offset: Offset(0, 3),
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
                    color: tint.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: tint, size: 22.0),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: tint,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              detail,
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.grey.shade800,
                height: 1.35,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: responseColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    response == AppExitResponse.exit
                        ? Icons.logout
                        : Icons.block,
                    color: Colors.white,
                    size: 14.0,
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    'returns ${response.name}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
  print('Created ${scenarioWidgets.length} scenario cards');

  // ============================================================
  // SECTION 4: Code Panels
  // ============================================================
  print('=== Section 4: Code Panels ===');

  Widget buildCodePanel(String title, String code, Color titleColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: titleColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: titleColor, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.green.shade200,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final codePanelExit = buildCodePanel(
    'Pattern A — always allow exit',
    'late final AppLifecycleListener _listener;\n'
        '\n'
        '@override\n'
        'void initState() {\n'
        '  super.initState();\n'
        '  _listener = AppLifecycleListener(\n'
        '    onExitRequested: () async {\n'
        '      // Nothing to clean up — let the OS proceed.\n'
        '      return AppExitResponse.exit;\n'
        '    },\n'
        '  );\n'
        '}',
    Colors.green.shade300,
  );

  final codePanelCancel = buildCodePanel(
    'Pattern B — veto exit while saving',
    'onExitRequested: () async {\n'
        '  if (!_documentDirty) {\n'
        '    return AppExitResponse.exit;\n'
        '  }\n'
        '  final shouldQuit = await showDialog<bool>(\n'
        '    context: context,\n'
        '    builder: (_) => UnsavedChangesDialog(),\n'
        '  );\n'
        '  return (shouldQuit ?? false)\n'
        '      ? AppExitResponse.exit\n'
        '      : AppExitResponse.cancel;\n'
        '},',
    Colors.orange.shade300,
  );

  final codePanelAwait = buildCodePanel(
    'Pattern C — wait for background work',
    'onExitRequested: () async {\n'
        '  if (_uploadInFlight.isCompleted) {\n'
        '    return AppExitResponse.exit;\n'
        '  }\n'
        '  // Tell the OS to keep us alive…\n'
        '  unawaited(_finishUpload());\n'
        '  return AppExitResponse.cancel;\n'
        '},',
    Colors.cyan.shade300,
  );

  final codePanelSwitch = buildCodePanel(
    'Pattern D — exhaustive switch',
    'String describe(AppExitResponse r) => switch (r) {\n'
        '  AppExitResponse.exit   => "platform proceeds with shutdown",\n'
        '  AppExitResponse.cancel => "app stays alive, no further action",\n'
        '};',
    Colors.purple.shade300,
  );
  print('Built 4 code panels');

  // ============================================================
  // SECTION 5: Sequence Diagram
  // ============================================================
  print('=== Section 5: Sequence Diagram ===');

  Widget buildSequenceLane(
    String actor,
    Color color,
    IconData icon,
  ) {
    return Container(
      width: 90.0,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 22.0),
          SizedBox(height: 4.0),
          Text(
            actor,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSequenceStep(
    int stepNumber,
    String from,
    String to,
    String message,
    Color tint, {
    bool isReturn = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: tint.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: tint,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      from,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: tint,
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Icon(
                      isReturn
                          ? Icons.arrow_back
                          : Icons.arrow_forward,
                      color: tint,
                      size: 14.0,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      to,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: tint,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 11.0,
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

  final sequenceLanes = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      buildSequenceLane('User', Colors.blueGrey, Icons.person),
      buildSequenceLane('Platform', Colors.indigo, Icons.computer),
      buildSequenceLane('Engine', Colors.purple, Icons.precision_manufacturing),
      buildSequenceLane('App code', Colors.teal, Icons.widgets),
    ],
  );

  final sequenceSteps = <Widget>[
    buildSequenceStep(
      1,
      'User',
      'Platform',
      'Click window close button / press ⌘Q',
      Colors.blueGrey,
    ),
    buildSequenceStep(
      2,
      'Platform',
      'Engine',
      'Native OS sends exit request to Flutter engine',
      Colors.indigo,
    ),
    buildSequenceStep(
      3,
      'Engine',
      'App code',
      'Engine calls onExitRequested on AppLifecycleListener',
      Colors.purple,
    ),
    buildSequenceStep(
      4,
      'App code',
      'Engine',
      'Future<AppExitResponse> resolves with .exit or .cancel',
      Colors.teal,
      isReturn: true,
    ),
    buildSequenceStep(
      5,
      'Engine',
      'Platform',
      'Engine forwards the response to the OS',
      Colors.purple,
      isReturn: true,
    ),
    buildSequenceStep(
      6,
      'Platform',
      'User',
      'If exit → process terminates. If cancel → window stays open.',
      Colors.indigo,
      isReturn: true,
    ),
  ];
  print('Created ${sequenceSteps.length} sequence steps');

  // ============================================================
  // SECTION 6: Comparison Table (exit vs cancel)
  // ============================================================
  print('=== Section 6: Comparison Table ===');

  Widget buildTableHeaderCell(String text, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        decoration: BoxDecoration(color: color),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget buildTableCell(String text, {bool bold = false, Color? color}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: color ?? Colors.grey.shade800,
          ),
        ),
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Row(
          children: [
            buildTableHeaderCell('Aspect', Colors.blueGrey.shade700),
            buildTableHeaderCell('exit', Colors.green.shade700),
            buildTableHeaderCell('cancel', Colors.deepOrange.shade700),
          ],
        ),
        Row(
          children: [
            buildTableCell('Index', bold: true),
            buildTableCell('${AppExitResponse.exit.index}'),
            buildTableCell('${AppExitResponse.cancel.index}'),
          ],
        ),
        Row(
          children: [
            buildTableCell('Effect on process', bold: true),
            buildTableCell('Terminates', color: Colors.green.shade800),
            buildTableCell('Keeps running', color: Colors.deepOrange.shade800),
          ],
        ),
        Row(
          children: [
            buildTableCell('Typical caller', bold: true),
            buildTableCell('Clean idle apps'),
            buildTableCell('Apps with dirty state'),
          ],
        ),
        Row(
          children: [
            buildTableCell('Follow-up action', bold: true),
            buildTableCell('None'),
            buildTableCell('Save / confirm / finish'),
          ],
        ),
        Row(
          children: [
            buildTableCell('Re-entrant?', bold: true),
            buildTableCell('No — app gone'),
            buildTableCell('Yes — OS may retry later'),
          ],
        ),
        Row(
          children: [
            buildTableCell('User perceives', bold: true),
            buildTableCell('Window closes'),
            buildTableCell('Dialog or no-op'),
          ],
        ),
      ],
    ),
  );
  print('Created comparison table');

  // ============================================================
  // SECTION 7: Platform Behavior Matrix
  // ============================================================
  print('=== Section 7: Platform Behavior Matrix ===');

  final platforms = <Map<String, Object>>[
    {
      'name': 'Windows',
      'icon': Icons.desktop_windows,
      'color': Colors.blue,
      'calls': true,
      'note': 'WM_CLOSE / system menu',
    },
    {
      'name': 'macOS',
      'icon': Icons.laptop_mac,
      'color': Colors.grey,
      'calls': true,
      'note': '⌘Q, dock quit, terminate:',
    },
    {
      'name': 'Linux',
      'icon': Icons.computer,
      'color': Colors.deepOrange,
      'calls': true,
      'note': 'GTK delete-event',
    },
    {
      'name': 'Android',
      'icon': Icons.phone_android,
      'color': Colors.green,
      'calls': false,
      'note': 'OS kills process freely',
    },
    {
      'name': 'iOS',
      'icon': Icons.phone_iphone,
      'color': Colors.purple,
      'calls': false,
      'note': 'No exit API for apps',
    },
    {
      'name': 'Web',
      'icon': Icons.web,
      'color': Colors.cyan,
      'calls': false,
      'note': 'Use beforeunload instead',
    },
  ];

  final platformTiles = <Widget>[];
  for (final p in platforms) {
    final name = p['name'] as String;
    final icon = p['icon'] as IconData;
    final color = p['color'] as Color;
    final calls = p['calls'] as bool;
    final note = p['note'] as String;
    platformTiles.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.15),
              color.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24.0),
                SizedBox(width: 8.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: calls
                    ? Colors.green.shade600
                    : Colors.grey.shade500,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    calls ? Icons.check : Icons.close,
                    color: Colors.white,
                    size: 12.0,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    calls
                        ? 'onExitRequested fires'
                        : 'never fires',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              note,
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${platformTiles.length} platform tiles');

  // ============================================================
  // SECTION 8: Summary Panel
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            'Key takeaways',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        _summaryRow(
          Icons.logout,
          'exit',
          'Two-value enum — there is no "maybe". Returning exit '
              'commits to letting the platform shut you down.',
          Colors.green.shade700,
        ),
        SizedBox(height: 8.0),
        _summaryRow(
          Icons.block,
          'cancel',
          'Veto only — the OS may ask again later. Use the breathing '
              'room to save state or ask the user.',
          Colors.deepOrange.shade700,
        ),
        SizedBox(height: 8.0),
        _summaryRow(
          Icons.api,
          'returned from',
          'AppLifecycleListener.onExitRequested → Future<AppExitResponse>',
          Colors.indigo.shade700,
        ),
        SizedBox(height: 8.0),
        _summaryRow(
          Icons.public_off,
          'platform reach',
          'Desktop only — mobile and web do not call onExitRequested.',
          Colors.brown.shade600,
        ),
        SizedBox(height: 8.0),
        _summaryRow(
          Icons.timer,
          'be quick',
          'The platform is waiting on this Future. Long awaits delay '
              'shutdown and may look like a hang.',
          Colors.purple.shade700,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('AppExitResponse Deep Demo build() returning widget tree');

  // ============================================================
  // Return: MaterialApp → Scaffold → SingleChildScrollView → Column
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF7F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Banner header
              Container(
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFD32F2F),
                      Color(0xFFFF7043),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.35),
                      blurRadius: 14.0,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      size: 56.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'AppExitResponse',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'The return value of AppLifecycleListener.onExitRequested',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white.withValues(alpha: 0.92),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.0),

              // Section 1 header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '1. The two values',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(child: exitCard),
                  Expanded(child: cancelCard),
                ],
              ),
              SizedBox(height: 28.0),

              // Section 2 header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '2. Decision tree',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              ...decisionNodes,
              SizedBox(height: 28.0),

              // Section 3 header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '3. Real-world scenarios',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: scenarioWidgets,
              ),
              SizedBox(height: 28.0),

              // Section 4 header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '4. onExitRequested patterns',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              codePanelExit,
              codePanelCancel,
              codePanelAwait,
              codePanelSwitch,
              SizedBox(height: 28.0),

              // Section 5 header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '5. Sequence diagram',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Color(0xFF1E2A3A),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Actors',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    sequenceLanes,
                    SizedBox(height: 14.0),
                    Container(
                      height: 1.0,
                      color: Colors.white24,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Messages',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(children: sequenceSteps),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.0),

              // Section 6 header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '6. Comparison table',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              comparisonTable,
              SizedBox(height: 28.0),

              // Section 7 header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '7. Platform behavior matrix',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: platformTiles,
              ),
              SizedBox(height: 28.0),

              // Section 8 header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '8. Summary',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              summaryPanel,

              // Footer
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: Center(
                  child: Text(
                    'Deep Demo • AppExitResponse • dart:ui',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Helper used by the summary panel — kept private and underscore-prefixed.
Widget _summaryRow(IconData icon, String title, String detail, Color color) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
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
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 12.5,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 11.0,
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

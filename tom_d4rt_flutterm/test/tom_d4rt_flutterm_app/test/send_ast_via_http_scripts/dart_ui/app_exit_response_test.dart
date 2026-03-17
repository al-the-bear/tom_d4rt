// D4rt test script: Deep Demo for AppExitResponse from dart:ui
// AppExitResponse represents the response to an app exit request
// Used to control whether an app should exit or cancel the exit
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║               APP EXIT RESPONSE DEEP DEMO                         ║',
  );
  print(
    '║        Application Exit Request Response Handling                 ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: APP EXIT RESPONSE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: APP EXIT RESPONSE FUNDAMENTALS                         │',
  );
  print(
    '│ Understanding app exit response types                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('AppExitResponse enum:');
  print('  • Controls app exit behavior');
  print('  • Response to exit request');
  print('  • Part of app lifecycle management');
  print('  • Used with ServicesBinding');
  print('');

  print('Exit request flow:');
  print('  System (close button, back gesture)');
  print('          │');
  print('          ▼');
  print('  App receives exit request');
  print('          │');
  print('          ▼');
  print('  App returns AppExitResponse');
  print('          │');
  print('          ▼');
  print('  exit / cancel');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: ALL ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: ALL ENUM VALUES                                        │',
  );
  print(
    '│ Complete list of exit response options                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final allValues = AppExitResponse.values;
  final valueResults = <Map<String, dynamic>>[];

  print('AppExitResponse enum values:');
  print(
    '┌──────────┬───────────────┬────────────────────────────────────────────┐',
  );
  print(
    '│  Index   │     Name      │   Description                              │',
  );
  print(
    '├──────────┼───────────────┼────────────────────────────────────────────┤',
  );

  for (final response in allValues) {
    String description;
    switch (response) {
      case AppExitResponse.exit:
        description = 'Allow app to exit';
        break;
      case AppExitResponse.cancel:
        description = 'Cancel exit request';
        break;
    }
    valueResults.add({
      'response': response,
      'index': response.index,
      'name': response.name,
      'description': description,
    });
    print(
      '│    ${response.index}     │ ${response.name.padRight(13)} │ ${description.padRight(42)} │',
    );
  }
  print(
    '└──────────┴───────────────┴────────────────────────────────────────────┘',
  );
  print('');
  print('Total values: ${allValues.length}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: EXIT RESPONSE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: EXIT RESPONSE ANALYSIS                                 │',
  );
  print(
    '│ AppExitResponse.exit - Allow exit                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final exitResponse = AppExitResponse.exit;
  print('AppExitResponse.exit properties:');
  print('  • name: ${exitResponse.name}');
  print('  • index: ${exitResponse.index}');
  print('  • toString: $exitResponse');
  print('');

  print('Behavior when returning exit:');
  print('  • App terminates normally');
  print('  • Cleanup code can run');
  print('  • System completes exit');
  print('');

  print('When to use exit:');
  print('  • No unsaved data');
  print('  • User confirmed save/discard');
  print('  • All tasks completed');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: CANCEL RESPONSE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: CANCEL RESPONSE ANALYSIS                               │',
  );
  print(
    '│ AppExitResponse.cancel - Prevent exit                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final cancelResponse = AppExitResponse.cancel;
  print('AppExitResponse.cancel properties:');
  print('  • name: ${cancelResponse.name}');
  print('  • index: ${cancelResponse.index}');
  print('  • toString: $cancelResponse');
  print('');

  print('Behavior when returning cancel:');
  print('  • App remains open');
  print('  • Exit request ignored');
  print('  • App can show dialog');
  print('');

  print('When to use cancel:');
  print('  • Unsaved changes present');
  print('  • Background task running');
  print('  • Confirmation dialog needed');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: COMPARISON                                             │',
  );
  print(
    '│ exit vs cancel behavior                                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Response comparison:');
  print(
    '┌───────────────────┬──────────────────────┬──────────────────────────┐',
  );
  print(
    '│     Feature       │        exit          │         cancel           │',
  );
  print(
    '├───────────────────┼──────────────────────┼──────────────────────────┤',
  );
  print(
    '│ App continues     │        No            │          Yes             │',
  );
  print(
    '│ Window closes     │        Yes           │          No              │',
  );
  print(
    '│ Cleanup runs      │        Yes           │          No              │',
  );
  print(
    '│ User sees app     │        No            │          Yes             │',
  );
  print(
    '└───────────────────┴──────────────────────┴──────────────────────────┘',
  );
  print('');

  print('Equality test:');
  print('  exit == exit: ${exitResponse == AppExitResponse.exit}');
  print('  exit == cancel: ${exitResponse == cancelResponse}');
  print(
    '  exit.index < cancel.index: ${exitResponse.index < cancelResponse.index}',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: WITH SERVICES BINDING
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: WITH SERVICES BINDING                                  │',
  );
  print(
    '│ Implementing exit handling                                        │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Implementation pattern:');
  print('  class MyApp extends StatefulWidget {');
  print('    @override');
  print('    State<MyApp> createState() => _MyAppState();');
  print('  }');
  print('');
  print('  class _MyAppState extends State<MyApp>');
  print('      with WidgetsBindingObserver {');
  print('');
  print('    @override');
  print('    void initState() {');
  print('      super.initState();');
  print('      WidgetsBinding.instance.addObserver(this);');
  print('    }');
  print('');
  print('    @override');
  print('    Future<AppExitResponse> didRequestAppExit() async {');
  print('      if (hasUnsavedChanges) {');
  print('        final shouldExit = await showExitDialog();');
  print('        return shouldExit');
  print('            ? AppExitResponse.exit');
  print('            : AppExitResponse.cancel;');
  print('      }');
  print('      return AppExitResponse.exit;');
  print('    }');
  print('  }');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: EXIT DIALOG EXAMPLE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: EXIT DIALOG EXAMPLE                                    │',
  );
  print(
    '│ Showing confirmation before exit                                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Exit confirmation dialog:');
  print('  Future<bool> showExitDialog() async {');
  print('    return await showDialog<bool>(');
  print('      context: context,');
  print('      builder: (context) => AlertDialog(');
  print('        title: Text("Unsaved Changes"),');
  print('        content: Text("Discard changes and exit?"),');
  print('        actions: [');
  print('          TextButton(');
  print('            child: Text("Cancel"),');
  print('            onPressed: () => Navigator.pop(context, false),');
  print('          ),');
  print('          TextButton(');
  print('            child: Text("Exit"),');
  print('            onPressed: () => Navigator.pop(context, true),');
  print('          ),');
  print('        ],');
  print('      ),');
  print('    ) ?? false;');
  print('  }');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: PLATFORM BEHAVIOR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: PLATFORM BEHAVIOR                                      │',
  );
  print(
    '│ How exit handling works on different platforms                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Platform triggers for exit request:');
  print(
    '┌───────────────────┬──────────────────────────────────────────────────┐',
  );
  print(
    '│     Platform      │   Exit Trigger                                   │',
  );
  print(
    '├───────────────────┼──────────────────────────────────────────────────┤',
  );
  print(
    '│ macOS             │ Cmd+Q, close button, quit menu                   │',
  );
  print(
    '│ Windows           │ Alt+F4, close button, taskbar close              │',
  );
  print(
    '│ Linux             │ Alt+F4, close button                             │',
  );
  print(
    '│ Android           │ Back button (root), recent apps swipe            │',
  );
  print(
    '│ iOS               │ App switcher swipe                               │',
  );
  print(
    '└───────────────────┴──────────────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: ENUM ITERATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: ENUM ITERATION                                         │',
  );
  print(
    '│ Working with AppExitResponse values                               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Iterating through values:');
  for (final value in AppExitResponse.values) {
    print('  ${value.index}: ${value.name} → $value');
  }
  print('');

  print('First and last values:');
  print('  First: ${AppExitResponse.values.first}');
  print('  Last: ${AppExitResponse.values.last}');
  print('  Count: ${AppExitResponse.values.length}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: PRACTICAL USE CASES                                   │',
  );
  print(
    '│ When to use exit vs cancel                                        │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Use exit:');
  print('  • Document saved successfully');
  print('  • No pending operations');
  print('  • User confirmed exit');
  print('');

  print('Use cancel:');
  print('  • Document has unsaved changes');
  print('  • File upload in progress');
  print('  • User needs to choose action');
  print('');

  print('Pattern for safe exit:');
  print('  if (await canExitSafely()) {');
  print('    return AppExitResponse.exit;');
  print('  } else {');
  print('    await showUnsavedChangesDialog();');
  print('    return AppExitResponse.cancel;');
  print('  }');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║           APP EXIT RESPONSE SUMMARY                               ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('AppExitResponse key features:');
  print('  • 2 response types: exit, cancel');
  print('  • Controls app termination');
  print('  • Part of WidgetsBindingObserver');
  print('  • Cross-platform support');
  print('');
  print('Best practices:');
  print('  • Check for unsaved data');
  print('  • Show confirmation dialogs');
  print('  • Clean up resources on exit');
  print('');
  print('AppExitResponse Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE53935), Color(0xFFEF5350)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.exit_to_app, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'AppExitResponse',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Application Exit Control',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // Enum Values
              _buildSectionHeader('ENUM VALUES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: valueResults.map((r) => _buildEnumRow(r)).toList(),
                ),
              ),
              SizedBox(height: 16.0),

              // Response Comparison
              _buildSectionHeader('RESPONSE COMPARISON'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildResponseCard(
                        'exit',
                        'Allow Exit',
                        Colors.green,
                        Icons.check_circle,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildResponseCard(
                        'cancel',
                        'Stay Open',
                        Colors.orange,
                        Icons.cancel,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Flow Diagram
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'EXIT REQUEST FLOW',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildFlowStep('User closes app', Icons.close),
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    _buildFlowStep('didRequestAppExit()', Icons.code),
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFlowResult('exit', Colors.green),
                        SizedBox(width: 24),
                        _buildFlowResult('cancel', Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Summary
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF37474F),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'SUMMARY',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryStat('Values', '${allValues.length}'),
                        _buildSummaryStat('Type', 'Enum'),
                        _buildSummaryStat('Sections', '10'),
                      ],
                    ),
                  ],
                ),
              ),

              // Footer
              Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Deep Demo • AppExitResponse • dart:ui',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
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

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(left: 16, bottom: 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFFE53935),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _buildEnumRow(Map<String, dynamic> r) {
  final name = r['name'] as String;
  final description = r['description'] as String;
  final response = r['response'] as AppExitResponse;
  final color = response == AppExitResponse.exit ? Colors.green : Colors.orange;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          width: 70,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildResponseCard(
  String name,
  String label,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 32),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    ),
  );
}

Widget _buildFlowStep(String text, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 11, color: Colors.white)),
      ],
    ),
  );
}

Widget _buildFlowResult(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildSummaryStat(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(label, style: TextStyle(fontSize: 10.0, color: Color(0xFF90A4AE))),
    ],
  );
}

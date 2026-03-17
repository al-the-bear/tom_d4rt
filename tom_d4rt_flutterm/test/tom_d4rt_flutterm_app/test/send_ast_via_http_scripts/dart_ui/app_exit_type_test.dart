// D4rt Deep Demo: AppExitType - Enum for App Exit Request Types
// This demo comprehensively explores AppExitType, which categorizes
// exit requests into cancelable and required types for proper handling.
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print(
    '═══════════════════════════════════════════════════════════════════════════',
  );
  print(
    '                    APPEXITTYPE DEEP DEMO                                   ',
  );
  print(
    '═══════════════════════════════════════════════════════════════════════════',
  );

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 1: AppExitType Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 1: AppExitType Fundamentals');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print(
    'AppExitType is an enum that classifies exit requests by their nature:',
  );
  print('- cancelable: User-initiated exit that can be prevented');
  print('- required: System-mandated exit that cannot be blocked');
  print('');
  print('Available values:');
  for (final value in AppExitType.values) {
    print('  [${value.index}] ${value.name}');
  }
  print('Total: ${AppExitType.values.length} exit types');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 2: Cancelable Exit Type Analysis
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 2: Cancelable Exit Type');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  final cancelable = AppExitType.cancelable;
  print('Type: $cancelable');
  print('Name: ${cancelable.name}');
  print('Index: ${cancelable.index}');
  print('');
  print('Use cases for cancelable exits:');
  print('  • User clicks close button');
  print('  • User presses Alt+F4 / Cmd+Q');
  print('  • User selects "Quit" from menu');
  print('  • Application receives window close event');
  print('');
  print('Behavior:');
  print('  • App can show "Save changes?" dialog');
  print('  • App can prevent exit by returning AppExitResponse.cancel');
  print('  • App can perform cleanup before exiting');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 3: Required Exit Type Analysis
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 3: Required Exit Type');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  final required = AppExitType.required;
  print('Type: $required');
  print('Name: ${required.name}');
  print('Index: ${required.index}');
  print('');
  print('Use cases for required exits:');
  print('  • System shutdown in progress');
  print('  • Force quit / Task Manager termination');
  print('  • System memory critical');
  print('  • User logoff / session end');
  print('');
  print('Behavior:');
  print('  • App CANNOT prevent this exit');
  print('  • App should save state immediately');
  print('  • AppExitResponse is ignored for this type');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 4: Exit Type Comparison
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 4: Exit Type Comparison');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('Comparing the two exit types:');
  print('');
  print('┌─────────────┬────────────────┬────────────────┐');
  print('│  Property   │   cancelable   │    required    │');
  print('├─────────────┼────────────────┼────────────────┤');
  print('│ Index       │       0        │       1        │');
  print('│ Can Block   │      Yes       │       No       │');
  print('│ User Choice │      Yes       │       No       │');
  print('│ Dialog OK   │      Yes       │       No       │');
  print('│ Cleanup     │    Full time   │  Limited time  │');
  print('└─────────────┴────────────────┴────────────────┘');
  print('');
  print('Equality checks:');
  print('cancelable == cancelable: ${cancelable == AppExitType.cancelable}');
  print('required == required: ${required == AppExitType.required}');
  print('cancelable == required: ${cancelable == required}');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 5: Enum Operations
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 5: Enum Operations');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('First value: ${AppExitType.values.first}');
  print('Last value: ${AppExitType.values.last}');
  print('');

  // Index to value mapping
  print('Index to value mapping:');
  for (var i = 0; i < AppExitType.values.length; i++) {
    print('  AppExitType.values[$i] = ${AppExitType.values[i]}');
  }

  // Check by name
  print('');
  print('Lookup by name:');
  final byNameCancelable = AppExitType.values.byName('cancelable');
  final byNameRequired = AppExitType.values.byName('required');
  print('  byName("cancelable"): $byNameCancelable');
  print('  byName("required"): $byNameRequired');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 6: Exit Handler Pattern
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 6: Exit Handler Pattern');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('Typical exit handler implementation:');
  print('');
  print('''
  Future<AppExitResponse> handleExitRequest(AppExitType type) async {
    switch (type) {
      case AppExitType.cancelable:
        // Can show dialog, save state, potentially cancel
        if (hasUnsavedChanges) {
          final shouldExit = await showSaveDialog();
          if (!shouldExit) {
            return AppExitResponse.cancel; // Block exit
          }
        }
        await saveState();
        return AppExitResponse.exit; // Allow exit
        
      case AppExitType.required:
        // Must exit - save what we can quickly
        await quickSave();
        return AppExitResponse.exit; // Response ignored anyway
    }
  }
  ''');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 7: Platform Behavior Comparison
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 7: Platform Behavior');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('How exit types map to platform events:');
  print('');
  print('Windows:');
  print('  • WM_CLOSE → cancelable');
  print('  • WM_QUERYENDSESSION → cancelable (can return FALSE)');
  print('  • WM_ENDSESSION → required');
  print('  • Task Manager kill → required');
  print('');
  print('macOS:');
  print('  • applicationShouldTerminate → cancelable');
  print('  • Force Quit → required');
  print('  • Logout/Shutdown → may be either');
  print('');
  print('Linux:');
  print('  • SIGTERM → cancelable (grace period)');
  print('  • SIGKILL → required (immediate)');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 8: Integration with ServicesBinding
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 8: ServicesBinding Integration');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('AppExitType is passed to exit request handlers:');
  print('');
  print('Registration pattern:');
  print('''
  // In your app initialization:
  ServicesBinding.instance.platformDispatcher.onExitRequested = 
    (AppExitType type) async {
      // Handle based on type
      return AppExitResponse.exit;
    };
  ''');
  print('');
  print('Note: The handler receives AppExitType and returns AppExitResponse');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 9: Decision Flow Visualization
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 9: Decision Flow');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('Exit request decision flow:');
  print('');
  print('  ┌─────────────────────┐');
  print('  │   Exit Requested    │');
  print('  └──────────┬──────────┘');
  print('             │');
  print('  ┌──────────▼──────────┐');
  print('  │   Check ExitType    │');
  print('  └──────────┬──────────┘');
  print('             │');
  print('     ┌───────┴───────┐');
  print('     │               │');
  print('  cancelable      required');
  print('     │               │');
  print('  ┌──▼───┐        ┌──▼───┐');
  print('  │ Can  │        │ Must │');
  print('  │Block?│        │ Exit │');
  print('  └──┬───┘        └──────┘');
  print('     │');
  print('  yes/no');
  print('     │');
  print('  ┌──▼───────────────┐');
  print('  │ Return Response  │');
  print('  │ exit or cancel   │');
  print('  └──────────────────┘');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 10: Practical Use Case Scenarios
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 10: Practical Scenarios');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );

  // Scenario simulation
  void simulateExitHandling(AppExitType exitType, bool hasUnsavedWork) {
    print('');
    print(
      'Scenario: exitType=${exitType.name}, hasUnsavedWork=$hasUnsavedWork',
    );

    switch (exitType) {
      case AppExitType.cancelable:
        if (hasUnsavedWork) {
          print('  → Show "Save changes?" dialog');
          print('  → User decides: save/discard/cancel');
          print('  → Return based on user choice');
        } else {
          print('  → No unsaved work, exit immediately');
          print('  → Return AppExitResponse.exit');
        }
        break;
      case AppExitType.required:
        print('  → System requires exit');
        if (hasUnsavedWork) {
          print('  → Auto-save to recovery file');
        }
        print('  → Return AppExitResponse.exit (ignored anyway)');
        break;
    }
  }

  simulateExitHandling(AppExitType.cancelable, true);
  simulateExitHandling(AppExitType.cancelable, false);
  simulateExitHandling(AppExitType.required, true);
  simulateExitHandling(AppExitType.required, false);

  print(
    '\n═══════════════════════════════════════════════════════════════════════════',
  );
  print(
    '                    APPEXITTYPE DEEP DEMO COMPLETE                          ',
  );
  print(
    '═══════════════════════════════════════════════════════════════════════════',
  );

  // ═══════════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION UI
  // ═══════════════════════════════════════════════════════════════════════════════
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.amber.shade50, Colors.orange.shade50],
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber.shade600, Colors.orange.shade600],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.exit_to_app, size: 48, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  'AppExitType',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Exit Request Type Classification',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Exit Types Grid
          Text(
            'Exit Types',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade800,
            ),
          ),
          SizedBox(height: 12),

          Row(
            children: [
              // Cancelable card
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.cancel_outlined,
                          size: 32,
                          color: Colors.green.shade700,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'cancelable',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      Text(
                        'Index: 0',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green.shade600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'User-initiated, can be blocked',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 12),

              // Required card
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade300),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.power_settings_new,
                          size: 32,
                          color: Colors.red.shade700,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'required',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                      ),
                      Text(
                        'Index: 1',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red.shade600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'System-mandated, cannot block',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Behavior Matrix
          Text(
            'Behavior Matrix',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade800,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildMatrixRow('Feature', 'Cancelable', 'Required', true),
                Divider(),
                _buildMatrixRow('Can Block', '✅ Yes', '❌ No', false),
                _buildMatrixRow('Show Dialog', '✅ Yes', '❌ No', false),
                _buildMatrixRow('User Choice', '✅ Yes', '❌ No', false),
                _buildMatrixRow('Full Cleanup', '✅ Yes', '⚠️ Limited', false),
                _buildMatrixRow('Response Used', '✅ Yes', '❌ Ignored', false),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Decision Flow
          Text(
            'Exit Decision Flow',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade800,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildFlowStep(
                  'Exit Requested',
                  Icons.notification_important,
                  Colors.blue,
                ),
                _buildFlowArrow(),
                _buildFlowStep(
                  'Check AppExitType',
                  Icons.question_mark,
                  Colors.purple,
                ),
                _buildFlowArrow(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFlowBranch('cancelable', 'Can cancel?', Colors.green),
                    _buildFlowBranch('required', 'Must exit', Colors.red),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Platform mapping
          Text(
            'Platform Mapping',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade800,
            ),
          ),
          SizedBox(height: 12),

          _buildPlatformCard('Windows', [
            'WM_CLOSE → cancelable',
            'WM_ENDSESSION → required',
            'Task Manager → required',
          ], Icons.window),
          SizedBox(height: 8),

          _buildPlatformCard('macOS', [
            'Cmd+Q → cancelable',
            'Force Quit → required',
            'Shutdown → varies',
          ], Icons.apple),
          SizedBox(height: 8),

          _buildPlatformCard('Linux', [
            'SIGTERM → cancelable',
            'SIGKILL → required',
            'X button → cancelable',
          ], Icons.computer),

          SizedBox(height: 32),

          // Footer
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '🚪 AppExitType Deep Demo',
                style: TextStyle(
                  color: Colors.amber.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildMatrixRow(
  String feature,
  String cancelable,
  String required,
  bool isHeader,
) {
  final style = TextStyle(
    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    fontSize: isHeader ? 14 : 13,
    color: Colors.grey.shade800,
  );

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(flex: 2, child: Text(feature, style: style)),
        Expanded(
          flex: 2,
          child: Text(cancelable, style: style, textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child: Text(required, style: style, textAlign: TextAlign.center),
        ),
      ],
    ),
  );
}

Widget _buildFlowStep(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: color),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

Widget _buildFlowArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Icon(Icons.arrow_downward, color: Colors.grey.shade400),
  );
}

Widget _buildFlowBranch(String type, String action, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Text(
          type,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        SizedBox(height: 4),
        Text(action, style: TextStyle(fontSize: 11, color: color)),
      ],
    ),
  );
}

Widget _buildPlatformCard(
  String platform,
  List<String> mappings,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue.shade600),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(platform, style: TextStyle(fontWeight: FontWeight.bold)),
              ...mappings.map(
                (m) => Text(
                  m,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

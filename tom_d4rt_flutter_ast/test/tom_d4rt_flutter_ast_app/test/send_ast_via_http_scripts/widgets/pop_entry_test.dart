// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PopEntry widget
// Demonstrates PopEntry: the mixin / callback interface that intercepts
// navigation pops (back button, system back gesture, Navigator.pop).
// A widget implementing PopEntry can veto or approve route pops,
// enabling "Are you sure?" dialogs, unsaved-changes guards, and
// multi-step form navigation.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PopEntry Deep Demo executing');

  // ============================================================
  // SECTION 1: What Is PopEntry?
  // ============================================================
  // PopEntry is a mixin on State<T> that lets a widget register
  // itself with the nearest ModalRoute to intercept pop requests.
  //
  // Key concepts:
  // • onPopInvoked — called when a pop is attempted
  // • canPop — whether the route can be popped right now
  //   (false = the pop is blocked, true = allowed)
  //
  // Flutter 3.12+ uses PopScope (which implements the PopEntry
  // protocol) as the primary API. PopScope wraps a child and
  // provides canPop + onPopInvokedWithResult.
  //
  // When canPop is false:
  // • System back button / gesture is intercepted
  // • Navigator.maybePop() respects it
  // • Navigator.pop() still forces the pop (by design)
  print('=== Section 1: PopEntry Concept ===');

  final conceptCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.security, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'PopEntry & PopScope',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Intercept and control navigation pop behavior.\n'
          'Guard routes with "Are you sure?" logic,\n'
          'unsaved-changes checks, and step-back controls.',
          style: TextStyle(fontSize: 12.0, color: Colors.white70, height: 1.5),
        ),
        SizedBox(height: 14.0),
        // Flow diagram: Pop attempt → canPop check → result
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                'Pop Interception Flow',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFlowBox('User presses\nBack', Colors.red, Icons.arrow_back),
                  _buildFlowArrow(),
                  _buildFlowBox('PopEntry\nchecks canPop', Colors.orange, Icons.help_outline),
                  _buildFlowArrow(),
                  Column(
                    children: [
                      _buildFlowBox('true → Pop', Colors.green, Icons.check),
                      SizedBox(height: 4.0),
                      _buildFlowBox('false → Block', Colors.red, Icons.block),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  'onPopInvoked is called regardless — canPop determines if the pop actually happens.',
                  style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created concept card with flow diagram');

  // ============================================================
  // SECTION 2: PopScope — The Primary API
  // ============================================================
  // PopScope is the widget that implements the PopEntry protocol.
  // It wraps a child and controls whether the route can be popped.
  print('=== Section 2: PopScope Widget ===');

  // Demonstrate a PopScope that blocks back navigation
  final popScopeBlocking = PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) {
      print('Pop attempted. didPop=$didPop (should be false since canPop=false)');
    },
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Text(
        'This content is protected by PopScope(canPop: false)',
        style: TextStyle(fontSize: 11.0, color: Colors.red.shade700),
      ),
    ),
  );

  // PopScope that allows popping
  final popScopeAllowing = PopScope(
    canPop: true,
    onPopInvokedWithResult: (didPop, result) {
      print('Pop attempted. didPop=$didPop (should be true since canPop=true)');
    },
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Text(
        'This content allows pops: PopScope(canPop: true)',
        style: TextStyle(fontSize: 11.0, color: Colors.green.shade700),
      ),
    ),
  );

  final popScopeVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 2: PopScope Widget',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'PopScope implements PopEntry — the standard way to guard routes.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        // Side by side: blocking vs allowing
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text('canPop: false', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.red.shade700)),
                  ),
                  SizedBox(height: 6.0),
                  popScopeBlocking,
                  SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.block, size: 14.0, color: Colors.red.shade400),
                      SizedBox(width: 4.0),
                      Text('Back blocked', style: TextStyle(fontSize: 9.0, color: Colors.red.shade600)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text('canPop: true', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
                  ),
                  SizedBox(height: 6.0),
                  popScopeAllowing,
                  SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, size: 14.0, color: Colors.green.shade400),
                      SizedBox(width: 4.0),
                      Text('Back allowed', style: TextStyle(fontSize: 9.0, color: Colors.green.shade600)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Code example
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'PopScope(\n'
            '  canPop: false,  // Block back navigation\n'
            '  onPopInvokedWithResult: (didPop, result) {\n'
            '    if (!didPop) {\n'
            '      // Show "Are you sure?" dialog\n'
            '      showExitConfirmation(context);\n'
            '    }\n'
            '  },\n'
            '  child: MyFormPage(),\n'
            ')',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF80DEEA), height: 1.4),
          ),
        ),
      ],
    ),
  );

  print('Created PopScope demo with blocking and allowing examples');

  // ============================================================
  // SECTION 3: Unsaved Changes Guard
  // ============================================================
  // The most common use case: prevent accidental loss of form data.
  print('=== Section 3: Unsaved Changes Guard ===');

  // Simulated form with "dirty" state
  final formFields = [
    {'label': 'Title', 'value': 'My Draft Post', 'dirty': true},
    {'label': 'Author', 'value': 'Jane Doe', 'dirty': false},
    {'label': 'Content', 'value': 'Lorem ipsum dolor sit amet...', 'dirty': true},
    {'label': 'Tags', 'value': 'flutter, dart', 'dirty': false},
    {'label': 'Category', 'value': '', 'dirty': false},
  ];

  final fieldWidgets = <Widget>[];
  for (final field in formFields) {
    final dirty = field['dirty'] as bool;
    fieldWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: dirty ? Colors.amber.shade50 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: dirty ? Colors.amber.shade300 : Colors.grey.shade200,
            width: dirty ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 70.0,
              child: Text(
                field['label'] as String,
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
              ),
            ),
            Expanded(
              child: Text(
                (field['value'] as String).isEmpty ? '(empty)' : field['value'] as String,
                style: TextStyle(
                  fontSize: 10.0,
                  color: (field['value'] as String).isEmpty ? Colors.grey.shade400 : Colors.grey.shade700,
                  fontStyle: (field['value'] as String).isEmpty ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            ),
            if (dirty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                decoration: BoxDecoration(
                  color: Colors.amber.shade200,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text('modified', style: TextStyle(fontSize: 7.0, fontWeight: FontWeight.bold, color: Colors.amber.shade800)),
              ),
          ],
        ),
      ),
    );
  }

  final unsavedGuard = PopScope(
    canPop: false, // Block because there are unsaved changes
    onPopInvokedWithResult: (didPop, result) {
      if (!didPop) {
        print('Pop blocked — show unsaved changes dialog');
      }
    },
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.amber.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Section 3: Unsaved Changes Guard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
          ),
          SizedBox(height: 4.0),
          Text(
            'Block back navigation when the form has unsaved changes.',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          ),
          SizedBox(height: 12.0),
          // Form header
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                Icon(Icons.edit_document, size: 16.0, color: Colors.blue.shade600),
                SizedBox(width: 6.0),
                Text('Edit Blog Post', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.blue.shade700)),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning, size: 10.0, color: Colors.amber.shade700),
                      SizedBox(width: 3.0),
                      Text('2 unsaved changes', style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: Colors.amber.shade800)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          ...fieldWidgets,
          SizedBox(height: 8.0),
          // The "blocked" indicator
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.shield, size: 16.0, color: Colors.red.shade600),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'PopScope(canPop: false) is active because hasUnsavedChanges == true.\n'
                    'Pressing Back will trigger onPopInvokedWithResult → show confirmation dialog.',
                    style: TextStyle(fontSize: 9.0, color: Colors.red.shade700, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          // Simulated dialog
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8.0, offset: Offset(0, 4))],
            ),
            child: Column(
              children: [
                Text('Unsaved Changes', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
                SizedBox(height: 6.0),
                Text(
                  'You have 2 unsaved changes.\nDo you want to save before leaving?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600, height: 1.4),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text('Discard', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700)),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text('Save & Leave', style: TextStyle(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text('Cancel', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
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

  print('Created unsaved changes guard demo');

  // ============================================================
  // SECTION 4: Multi-Step Form Navigation
  // ============================================================
  // PopScope can control step-by-step navigation in wizards.
  // Instead of popping the route, go back one step.
  print('=== Section 4: Multi-Step Form ===');

  final steps = [
    {'name': 'Personal Info', 'icon': Icons.person, 'color': Colors.blue, 'done': true},
    {'name': 'Address', 'icon': Icons.location_on, 'color': Colors.green, 'done': true},
    {'name': 'Payment', 'icon': Icons.credit_card, 'color': Colors.orange, 'done': false},
    {'name': 'Confirm', 'icon': Icons.check_circle, 'color': Colors.purple, 'done': false},
  ];

  final currentStep = 2; // "Payment" step (0-indexed)

  final stepWidgets = <Widget>[];
  for (var i = 0; i < steps.length; i++) {
    final step = steps[i];
    final isCurrent = i == currentStep;
    final isDone = step['done'] as bool;
    final color = step['color'] as MaterialColor;

    stepWidgets.add(
      Expanded(
        child: Column(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: isCurrent ? color.shade100 : (isDone ? color.shade50 : Colors.grey.shade100),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCurrent ? color.shade400 : (isDone ? color.shade200 : Colors.grey.shade300),
                  width: isCurrent ? 2.0 : 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: isDone
                  ? Icon(Icons.check, size: 16.0, color: color.shade600)
                  : Icon(step['icon'] as IconData, size: 16.0, color: isCurrent ? color.shade600 : Colors.grey.shade400),
            ),
            SizedBox(height: 4.0),
            Text(
              step['name'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8.0,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: isCurrent ? color.shade700 : (isDone ? color.shade500 : Colors.grey.shade500),
              ),
            ),
          ],
        ),
      ),
    );
    if (i < steps.length - 1) {
      stepWidgets.add(
        SizedBox(
          width: 20.0,
          child: Divider(color: isDone ? color.shade200 : Colors.grey.shade300, thickness: 1.5),
        ),
      );
    }
  }

  final multiStepVisual = Container(
    width: double.infinity,
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
          'Section 4: Multi-Step Form Navigation',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Use PopScope to go back one step instead of popping the route.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        // Step indicators
        Row(children: stepWidgets),
        SizedBox(height: 14.0),
        // Current step content
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.credit_card, size: 18.0, color: Colors.orange.shade600),
                  SizedBox(width: 6.0),
                  Text('Step 3: Payment', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
                ],
              ),
              SizedBox(height: 8.0),
              Text('Enter your payment details...', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // Pop behavior explanation
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PopScope Behavior:', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.blue.shade700)),
              SizedBox(height: 4.0),
              _buildBehaviorRow(Icons.arrow_back, 'Back pressed', 'Go to Step 2 (Address)', Colors.blue),
              SizedBox(height: 3.0),
              _buildBehaviorRow(Icons.first_page, 'Back on Step 1', 'Pop route (canPop: true)', Colors.green),
              SizedBox(height: 3.0),
              _buildBehaviorRow(Icons.navigate_next, 'Next', 'Advance to Step 4 (Confirm)', Colors.orange),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // Code pattern
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'PopScope(\n'
            '  canPop: currentStep == 0,  // Only allow pop on first step\n'
            '  onPopInvokedWithResult: (didPop, result) {\n'
            '    if (!didPop && currentStep > 0) {\n'
            '      setState(() => currentStep--);\n'
            '    }\n'
            '  },\n'
            '  child: StepContent(step: currentStep),\n'
            ')',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF80DEEA), height: 1.4),
          ),
        ),
      ],
    ),
  );

  print('Created multi-step form navigation demo');

  // ============================================================
  // SECTION 5: canPop vs onPopInvokedWithResult
  // ============================================================
  // Clarifying the relationship between canPop and the callback.
  print('=== Section 5: canPop vs onPopInvokedWithResult ===');

  final scenarios = [
    {
      'canPop': true,
      'didPop': true,
      'desc': 'Route pops normally. Callback fires with didPop=true.',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'result': 'Route removed from Navigator',
    },
    {
      'canPop': false,
      'didPop': false,
      'desc': 'Pop is blocked. Callback fires with didPop=false.',
      'icon': Icons.block,
      'color': Colors.red,
      'result': 'Route stays active — show dialog',
    },
  ];

  final scenarioCards = <Widget>[];
  for (final s in scenarios) {
    final color = s['color'] as MaterialColor;
    scenarioCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(s['icon'] as IconData, color: color.shade600, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'canPop: ${s['canPop']}',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: color.shade800),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                SizedBox(width: 28.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Callback receives: didPop = ${s['didPop']}',
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: color.shade700),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        s['desc'] as String,
                        style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
                      ),
                      SizedBox(height: 3.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: color.shade100,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'Result: ${s['result']}',
                          style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final canPopVisual = Container(
    width: double.infinity,
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
          'Section 5: canPop vs onPopInvokedWithResult',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'canPop determines whether the pop succeeds. The callback always fires.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        ...scenarioCards,
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, size: 16.0, color: Colors.amber.shade700),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Important: Navigator.pop() ignores canPop and always pops.\n'
                  'Only system back gestures and Navigator.maybePop() respect canPop.',
                  style: TextStyle(fontSize: 9.0, color: Colors.amber.shade800, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created canPop vs onPopInvokedWithResult visual');

  // ============================================================
  // SECTION 6: Common Patterns
  // ============================================================
  // Real-world patterns for using PopScope / PopEntry.
  print('=== Section 6: Common Patterns ===');

  final patterns = [
    {
      'name': 'Unsaved Changes Guard',
      'desc': 'Block pop when form is dirty, show save dialog.',
      'code': 'canPop: !hasChanges',
      'icon': Icons.save,
      'color': Colors.blue,
    },
    {
      'name': 'Wizard Step-Back',
      'desc': 'Go back one step instead of leaving the wizard.',
      'code': 'canPop: step == 0',
      'icon': Icons.view_carousel,
      'color': Colors.orange,
    },
    {
      'name': 'Exit Confirmation',
      'desc': 'Double-tap back to exit (Android pattern).',
      'code': 'canPop: recentlyPressedBack',
      'icon': Icons.exit_to_app,
      'color': Colors.red,
    },
    {
      'name': 'Search/Filter Reset',
      'desc': 'First back clears filters, second back exits.',
      'code': 'canPop: !hasActiveFilters',
      'icon': Icons.filter_list,
      'color': Colors.purple,
    },
    {
      'name': 'Bottom Sheet Dismiss',
      'desc': 'Prevent accidental dismiss of modal bottom sheet.',
      'code': 'canPop: !isProcessing',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.teal,
    },
  ];

  final patternCards = <Widget>[];
  for (final p in patterns) {
    final color = p['color'] as MaterialColor;
    patternCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 34.0,
              height: 34.0,
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(7.0),
              ),
              alignment: Alignment.center,
              child: Icon(p['icon'] as IconData, color: color.shade700, size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['name'] as String, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: color.shade800)),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
                  SizedBox(height: 2.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF263238),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Text(
                      p['code'] as String,
                      style: TextStyle(fontSize: 8.0, fontFamily: 'monospace', color: Color(0xFF80DEEA)),
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

  final patternsVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6: Common Patterns',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Real-world use cases for PopScope / PopEntry.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        ...patternCards,
      ],
    ),
  );

  print('Created common patterns visual with ${patternCards.length} patterns');

  // ============================================================
  // SECTION 7: PopScope Properties Reference
  // ============================================================
  print('=== Section 7: Property Reference ===');

  final propsVisual = Container(
    width: double.infinity,
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
          'Section 7: PopScope Properties',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Complete property reference for PopScope<T>.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        _buildPropCard(
          'canPop',
          'bool',
          true,
          'Whether the route should be allowed to pop.\n'
          'true = normal back behavior. false = back is blocked.\n'
          'Can change dynamically via setState().',
          'canPop: !hasUnsavedChanges',
          Icons.lock_open,
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildPropCard(
          'onPopInvokedWithResult',
          'PopInvokedWithResultCallback<T>?',
          false,
          'Called when a pop is attempted. Receives didPop (whether\n'
          'the pop actually happened) and result (the pop result value).\n'
          'Called regardless of canPop value.',
          'onPopInvokedWithResult: (didPop, result) { ... }',
          Icons.notification_important,
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildPropCard(
          'child',
          'Widget',
          true,
          'The widget subtree that this PopScope protects.\n'
          'Usually a page body, form, or wizard content.',
          'child: MyFormPage()',
          Icons.child_care,
          Colors.green,
        ),
        SizedBox(height: 12.0),
        // PopEntry mixin note
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, size: 16.0, color: Colors.indigo.shade600),
                  SizedBox(width: 6.0),
                  Text('PopEntry Mixin', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.indigo.shade700)),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                'PopScope is the widget API. Under the hood it uses the PopEntry\n'
                'mixin on its State. You rarely need to use PopEntry directly —\n'
                'PopScope covers almost all use cases.',
                style: TextStyle(fontSize: 9.0, color: Colors.indigo.shade700, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created property reference');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  print('Assembling all sections...');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.security, color: Colors.white, size: 40.0),
              SizedBox(height: 8.0),
              Text(
                'PopEntry & PopScope',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 4.0),
              Text(
                'Navigation Pop Interception',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
              SizedBox(height: 8.0),
              Text(
                'Control back button behavior with canPop\n'
                'and onPopInvokedWithResult. Guard routes,\n'
                'intercept navigation, protect unsaved data.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.0, color: Colors.white60, height: 1.4),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        conceptCard,
        SizedBox(height: 16.0),
        popScopeVisual,
        SizedBox(height: 16.0),
        unsavedGuard,
        SizedBox(height: 16.0),
        multiStepVisual,
        SizedBox(height: 16.0),
        canPopVisual,
        SizedBox(height: 16.0),
        patternsVisual,
        SizedBox(height: 16.0),
        propsVisual,
        SizedBox(height: 24.0),
        Center(
          child: Text(
            'PopEntry & PopScope Deep Demo — 7 sections',
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    ),
  );
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildFlowBox(String text, MaterialColor color, IconData icon) {
  return Container(
    width: 70.0,
    padding: EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      children: [
        Icon(icon, size: 14.0, color: color.shade600),
        SizedBox(height: 2.0),
        Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 7.0, color: color.shade700)),
      ],
    ),
  );
}

Widget _buildFlowArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(Icons.arrow_forward, size: 12.0, color: Colors.grey.shade400),
  );
}

Widget _buildBehaviorRow(IconData icon, String action, String result, MaterialColor color) {
  return Row(
    children: [
      Icon(icon, size: 14.0, color: color.shade400),
      SizedBox(width: 6.0),
      SizedBox(
        width: 100.0,
        child: Text(action, style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
      ),
      Text('→ ', style: TextStyle(fontSize: 9.0, color: Colors.grey.shade400)),
      Expanded(
        child: Text(result, style: TextStyle(fontSize: 9.0, color: color.shade700)),
      ),
    ],
  );
}

Widget _buildPropCard(String name, String type, bool required, String desc, String example, IconData icon, MaterialColor color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color.shade600, size: 18.0),
            SizedBox(width: 8.0),
            Text(name, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: color.shade800)),
            SizedBox(width: 6.0),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(type, style: TextStyle(fontSize: 8.0, fontFamily: 'monospace', color: Colors.grey.shade600)),
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
              decoration: BoxDecoration(
                color: required ? Colors.red.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Text(
                required ? 'required' : 'optional',
                style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: required ? Colors.red.shade700 : Colors.grey.shade600),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(desc, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.4)),
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(example, style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF80DEEA))),
        ),
      ],
    ),
  );
}

// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PopScope widget
// Demonstrates PopScope: controls whether a route can be popped (back navigation).
// PopScope replaced the deprecated WillPopScope in Flutter 3.12+.
// It provides canPop (bool) and onPopInvokedWithResult (callback) to intercept
// back-button presses, swipe-to-go-back gestures, and programmatic pop calls.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PopScope Deep Demo executing');

  // ============================================================
  // SECTION 1: What PopScope Does — Concept Overview
  // ============================================================
  print('=== Section 1: PopScope Concept Overview ===');

  // PopScope is a widget that registers a callback to intercept the
  // user's attempt to dismiss the enclosing ModalRoute. It controls
  // two things:
  //  1. canPop — whether the route can actually be popped
  //  2. onPopInvokedWithResult — called when pop is attempted
  //
  // Common use cases:
  //  - Preventing accidental loss of unsaved form data
  //  - Showing "discard changes?" confirmation dialogs
  //  - Multi-step wizards where back should go to previous step
  //  - Preventing exit from critical workflows (payments, uploads)

  final conceptOverview = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.shield, color: Colors.white, size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'PopScope',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Controls whether a route can be dismissed by the user. '
          'Wraps a child widget and intercepts back navigation attempts — '
          'back button presses, swipe gestures, and programmatic pops.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        // Two key properties
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Icon(Icons.toggle_on, color: Colors.greenAccent, size: 28.0),
                    SizedBox(height: 6.0),
                    Text(
                      'canPop',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Boolean flag: true = route can be popped, '
                      'false = route is blocked from popping',
                      style: TextStyle(fontSize: 10.0, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Icon(Icons.notifications_active, color: Colors.amberAccent, size: 28.0),
                    SizedBox(height: 6.0),
                    Text(
                      'onPopInvokedWithResult',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Callback fired when pop is attempted, '
                      'regardless of canPop value',
                      style: TextStyle(fontSize: 10.0, color: Colors.white70),
                      textAlign: TextAlign.center,
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

  print('Created concept overview with two key property cards');

  // ============================================================
  // SECTION 2: Basic PopScope — Allowing Navigation
  // ============================================================
  print('=== Section 2: Basic PopScope — canPop: true ===');

  // When canPop is true (default), the route can be popped normally.
  // The onPopInvokedWithResult callback still fires, but does not block.

  final allowedPage = PopScope(
    canPop: true,
    onPopInvokedWithResult: (bool didPop, dynamic result) {
      print('Pop attempted on allowed page, didPop: $didPop');
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.green.shade300, width: 2.0),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
            ),
            child: Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.green.shade700, size: 22.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Settings Page',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    'canPop: true',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.green, size: 48.0),
                SizedBox(height: 10.0),
                Text(
                  'Navigation Allowed',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'This page allows the user to navigate back freely. '
                  'The back button, swipe gesture, and programmatic pop '
                  'all work as expected. The callback still fires to '
                  'track navigation events.',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 14.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatusIndicator('Back Button', Icons.arrow_back, true),
                    SizedBox(width: 12.0),
                    _buildStatusIndicator('Swipe', Icons.swipe_left, true),
                    SizedBox(width: 12.0),
                    _buildStatusIndicator('Pop()', Icons.code, true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('Created basic PopScope with canPop: true');

  // ============================================================
  // SECTION 3: PopScope Blocking Navigation — Unsaved Form
  // ============================================================
  print('=== Section 3: PopScope Blocking Navigation ===');

  // When canPop is false, the system back button and swipe gesture
  // are blocked. The onPopInvokedWithResult callback fires with
  // didPop = false, giving the app a chance to show a dialog.

  final blockedPage = PopScope(
    canPop: false,
    onPopInvokedWithResult: (bool didPop, dynamic result) {
      print('Pop blocked! didPop: $didPop — show confirmation dialog');
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.red.shade300, width: 2.0),
      ),
      child: Column(
        children: [
          // Header — blocked
          Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
            ),
            child: Row(
              children: [
                Icon(Icons.block, color: Colors.red.shade700, size: 22.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Edit Profile — Unsaved Changes',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    'canPop: false',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Simulated form with unsaved changes
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(Icons.warning_amber, color: Colors.red.shade400, size: 48.0),
                SizedBox(height: 10.0),
                Text(
                  'Navigation Blocked',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'This page has unsaved changes. The back button and '
                  'swipe gesture are disabled. When the user tries to leave, '
                  'onPopInvokedWithResult fires with didPop=false, allowing '
                  'the app to show a "Discard changes?" dialog.',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 14.0),
                // Simulated form fields
                _buildFormField('Name', 'John Doe', true),
                SizedBox(height: 8.0),
                _buildFormField('Email', 'john@example.com', true),
                SizedBox(height: 8.0),
                _buildFormField('Bio', 'Modified text here...', false),
                SizedBox(height: 14.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatusIndicator('Back Button', Icons.arrow_back, false),
                    SizedBox(width: 12.0),
                    _buildStatusIndicator('Swipe', Icons.swipe_left, false),
                    SizedBox(width: 12.0),
                    _buildStatusIndicator('Pop()', Icons.code, false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('Created PopScope with canPop: false blocking navigation');

  // ============================================================
  // SECTION 4: Conditional Pop — Toggle-Based Control
  // ============================================================
  print('=== Section 4: Conditional Pop — Dynamic canPop ===');

  // In real apps, canPop is typically driven by state — e.g. whether
  // a form has been modified. Here we show both states side-by-side
  // to illustrate the toggle concept.

  final toggleStates = [
    {
      'label': 'Clean Form (no changes)',
      'canPop': true,
      'icon': Icons.edit_off,
      'detail': 'Form is pristine — user can freely navigate away',
      'color': Colors.teal,
    },
    {
      'label': 'Dirty Form (has changes)',
      'canPop': false,
      'icon': Icons.edit_note,
      'detail': 'Form has unsaved edits — navigation requires confirmation',
      'color': Colors.deepOrange,
    },
    {
      'label': 'Form Saved Successfully',
      'canPop': true,
      'icon': Icons.save,
      'detail': 'Changes saved — canPop flips back to true',
      'color': Colors.indigo,
    },
    {
      'label': 'Critical Workflow (uploading)',
      'canPop': false,
      'icon': Icons.cloud_upload,
      'detail': 'Upload in progress — must not leave until complete',
      'color': Colors.brown,
    },
  ];

  final toggleCards = <Widget>[];
  for (final state in toggleStates) {
    final canPop = state['canPop'] as bool;
    final color = state['color'] as MaterialColor;

    final card = PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        print('Conditional pop: ${state['label']}, didPop=$didPop');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: canPop ? color.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: canPop ? color.shade300 : Colors.grey.shade400,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: canPop ? color.shade100 : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                state['icon'] as IconData,
                size: 22.0,
                color: canPop ? color.shade700 : Colors.grey.shade600,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state['label'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    state['detail'] as String,
                    style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: canPop ? Colors.green.shade100 : Colors.red.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    canPop ? Icons.lock_open : Icons.lock,
                    size: 12.0,
                    color: canPop ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    canPop ? 'OPEN' : 'LOCKED',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      color: canPop ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    toggleCards.add(card);
  }

  final section4 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dynamic canPop Based on App State',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'In real apps, canPop is typically a computed value driven by '
          'state rather than a static constant. The PopScope widget '
          'rebuilds when canPop changes, enabling or disabling back navigation.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        ...toggleCards,
      ],
    ),
  );

  print('Created ${toggleCards.length} conditional pop state cards');

  // ============================================================
  // SECTION 5: Confirmation Dialog Pattern
  // ============================================================
  print('=== Section 5: Discard Changes Dialog Pattern ===');

  // The most common PopScope use case: when canPop is false and the user
  // tries to pop, onPopInvokedWithResult fires with didPop=false.
  // The callback then shows a dialog asking "Discard changes?".
  // If user confirms, the app calls Navigator.of(context).pop() manually.

  final dialogPattern = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.amber.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        // Pattern title
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
          ),
          child: Row(
            children: [
              Icon(Icons.pattern, color: Colors.amber.shade800, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                'Common Pattern: Discard Changes Dialog',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade900,
                ),
              ),
            ],
          ),
        ),
        // Flow visualization
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Step 1
              _buildFlowStep(
                '1',
                'User taps back button',
                'System detects pop attempt on current route',
                Icons.arrow_back,
                Colors.blue,
              ),
              _buildFlowArrow(),
              // Step 2
              _buildFlowStep(
                '2',
                'PopScope checks canPop',
                'canPop = false → blocks the pop from happening',
                Icons.shield,
                Colors.orange,
              ),
              _buildFlowArrow(),
              // Step 3
              _buildFlowStep(
                '3',
                'onPopInvokedWithResult fires',
                'Callback receives didPop=false, app shows dialog',
                Icons.notifications_active,
                Colors.purple,
              ),
              _buildFlowArrow(),
              // Step 4 - fork
              Row(
                children: [
                  Expanded(
                    child: _buildFlowStep(
                      '4a',
                      'User taps "Discard"',
                      'App calls Navigator.pop() manually',
                      Icons.delete_outline,
                      Colors.red,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: _buildFlowStep(
                      '4b',
                      'User taps "Keep Editing"',
                      'Dialog dismissed, user stays on page',
                      Icons.edit,
                      Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Simulated dialog
        Container(
          margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20.0,
                offset: Offset(0.0, 8.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.amber.shade700, size: 40.0),
              SizedBox(height: 10.0),
              Text(
                'Discard Changes?',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'You have unsaved changes. If you go back now, '
                'your changes will be lost.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Keep Editing',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Discard',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
  );

  print('Created confirmation dialog pattern visualization');

  // ============================================================
  // SECTION 6: Nested PopScopes
  // ============================================================
  print('=== Section 6: Nested PopScopes ===');

  // When PopScopes are nested, the innermost active PopScope takes
  // precedence. If the inner one has canPop: false, the route is blocked
  // even if the outer one has canPop: true. All callbacks fire from
  // innermost to outermost.

  final nestedDemo = PopScope(
    canPop: true,
    onPopInvokedWithResult: (bool didPop, dynamic result) {
      print('Outer PopScope: didPop=$didPop');
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.cyan.shade300, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nested PopScopes',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'When PopScopes are nested, the innermost scope with '
            'canPop: false blocks the entire route from popping. '
            'All onPopInvokedWithResult callbacks fire from innermost outward.',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          ),
          SizedBox(height: 14.0),
          // Outer scope visualization
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.layers_outlined, color: Colors.blue.shade600, size: 18.0),
                    SizedBox(width: 6.0),
                    Text(
                      'Outer PopScope (canPop: true)',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                // Inner scope — blocks
                PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (bool didPop, dynamic result) {
                    print('Inner PopScope: didPop=$didPop');
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.red.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.layers, color: Colors.red.shade600, size: 18.0),
                            SizedBox(width: 6.0),
                            Text(
                              'Inner PopScope (canPop: false)',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.lock, color: Colors.red, size: 20.0),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  'This inner scope BLOCKS the pop — '
                                  'even though the outer scope allows it',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.red.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                // Result summary
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.amber.shade700, size: 18.0),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'Result: Route is blocked. Both callbacks fire — '
                          'inner first (didPop=false), then outer (didPop=false). '
                          'The innermost canPop: false wins.',
                          style: TextStyle(fontSize: 10.0, color: Colors.amber.shade800),
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
    ),
  );

  print('Created nested PopScope demonstration');

  // ============================================================
  // SECTION 7: Real-World Use Cases Gallery
  // ============================================================
  print('=== Section 7: Real-World Use Cases ===');

  final useCases = [
    {
      'title': 'Form Editor',
      'icon': Icons.edit_document,
      'color': Colors.blue,
      'description': 'Block back navigation when form has unsaved edits. '
          'Show discard dialog on pop attempt.',
      'code': 'PopScope(\n  canPop: !_hasChanges,\n  onPopInvoked...',
    },
    {
      'title': 'Payment Flow',
      'icon': Icons.payment,
      'color': Colors.green,
      'description': 'Prevent leaving during transaction processing. '
          'Only allow exit after success or explicit cancel.',
      'code': 'PopScope(\n  canPop: _paymentComplete,\n  ...',
    },
    {
      'title': 'Onboarding Wizard',
      'icon': Icons.school,
      'color': Colors.purple,
      'description': 'Override back to go to previous wizard step '
          'instead of leaving the onboarding flow entirely.',
      'code': 'PopScope(\n  canPop: _step == 0,\n  onPopInvoked...',
    },
    {
      'title': 'Media Upload',
      'icon': Icons.cloud_upload,
      'color': Colors.orange,
      'description': 'Block exit while file uploads are in progress. '
          'Allow after upload completes or is cancelled.',
      'code': 'PopScope(\n  canPop: !_isUploading,\n  ...',
    },
    {
      'title': 'Quiz / Exam',
      'icon': Icons.quiz,
      'color': Colors.red,
      'description': 'Prevent accidental exit from a timed exam. '
          'Require confirmation with penalty warning.',
      'code': 'PopScope(\n  canPop: false,\n  onPopInvoked: _confirm...',
    },
    {
      'title': 'Chat Compose',
      'icon': Icons.chat_bubble,
      'color': Colors.teal,
      'description': 'Block leaving when the user has typed a message '
          'but not sent it. Save draft or discard on pop.',
      'code': 'PopScope(\n  canPop: _messageText.isEmpty,\n  ...',
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    final color = uc['color'] as MaterialColor;
    useCaseWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.shade50,
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42.0,
              height: 42.0,
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Icon(uc['icon'] as IconData, color: color.shade700, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uc['title'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade800,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    uc['description'] as String,
                    style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      uc['code'] as String,
                      style: TextStyle(
                        fontSize: 9.0,
                        fontFamily: 'monospace',
                        color: Colors.grey.shade800,
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

  final section7 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Real-World Use Cases',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'PopScope is essential wherever navigation away from a page '
          'might cause data loss or interrupt a critical operation.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        ...useCaseWidgets,
      ],
    ),
  );

  print('Created ${useCaseWidgets.length} real-world use case cards');

  // ============================================================
  // SECTION 8: didPop Parameter Deep Dive
  // ============================================================
  print('=== Section 8: Understanding didPop ===');

  // The didPop parameter in onPopInvokedWithResult tells you whether
  // the pop actually happened. It's true when canPop was true (pop
  // already occurred), and false when canPop was false (pop was blocked).

  final didPopExplanation = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Understanding the didPop Parameter',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        // didPop = true
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'didPop = true',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'when canPop: true',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'The pop has ALREADY happened by the time the callback fires. '
                'The route is being removed. Use this for cleanup: saving analytics, '
                'releasing resources, or logging the navigation event. '
                'Do NOT try to show dialogs — the page is already gone.',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // didPop = false
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'didPop = false',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'when canPop: false',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'The pop was BLOCKED. The route is still active. '
                'This is where you show confirmation dialogs, save drafts, '
                'or take any user-facing action. The page is still visible '
                'and interactive.',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Important note
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber.shade700, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Important: When didPop is true, avoid calling Navigator.pop() '
                  'again — it would pop the NEXT route in the stack. Only call '
                  'Navigator.pop() manually when didPop is false and you want '
                  'to proceed with the navigation.',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created didPop parameter explanation section');

  // ============================================================
  // SECTION 9: PopScope vs WillPopScope Comparison
  // ============================================================
  print('=== Section 9: PopScope vs WillPopScope ===');

  final comparisonRows = [
    {
      'aspect': 'API Style',
      'popScope': 'Synchronous bool (canPop)',
      'willPopScope': 'Async callback (Future<bool>)',
      'winner': 'popScope',
    },
    {
      'aspect': 'Back Gesture',
      'popScope': 'Works with predictive back',
      'willPopScope': 'Breaks predictive back on Android',
      'winner': 'popScope',
    },
    {
      'aspect': 'Pop Notification',
      'popScope': 'onPopInvokedWithResult fires always',
      'willPopScope': 'onWillPop only fires when trying to pop',
      'winner': 'popScope',
    },
    {
      'aspect': 'Flutter Version',
      'popScope': '3.12+ (recommended)',
      'willPopScope': 'Deprecated since 3.12',
      'winner': 'popScope',
    },
    {
      'aspect': 'Control Flow',
      'popScope': 'Declarative: set canPop state',
      'willPopScope': 'Imperative: return true/false',
      'winner': 'popScope',
    },
    {
      'aspect': 'Result Access',
      'popScope': 'Has result parameter',
      'willPopScope': 'No result access',
      'winner': 'popScope',
    },
  ];

  final comparisonWidgets = <Widget>[];
  for (final row in comparisonRows) {
    final isPopScope = row['winner'] == 'popScope';
    comparisonWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              row['aspect'] as String,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: isPopScope
                          ? Colors.green.shade50
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: isPopScope
                            ? Colors.green.shade300
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      row['popScope'] as String,
                      style: TextStyle(
                        fontSize: 9.0,
                        color: isPopScope
                            ? Colors.green.shade800
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      row['willPopScope'] as String,
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.red.shade700,
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
  }

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'PopScope',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'vs',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'WillPopScope (deprecated)',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        ...comparisonWidgets,
      ],
    ),
  );

  print('Created PopScope vs WillPopScope comparison');

  // ============================================================
  // SECTION 10: Multi-Step Wizard Pattern
  // ============================================================
  print('=== Section 10: Multi-Step Wizard with PopScope ===');

  // In a wizard, PopScope can intercept back navigation to go to the
  // previous wizard step instead of leaving the entire flow.

  final wizardSteps = [
    {'step': 1, 'title': 'Personal Info', 'icon': Icons.person, 'color': Colors.blue, 'active': false, 'completed': true},
    {'step': 2, 'title': 'Address', 'icon': Icons.location_on, 'color': Colors.teal, 'active': false, 'completed': true},
    {'step': 3, 'title': 'Payment', 'icon': Icons.payment, 'color': Colors.orange, 'active': true, 'completed': false},
    {'step': 4, 'title': 'Review', 'icon': Icons.fact_check, 'color': Colors.purple, 'active': false, 'completed': false},
  ];

  final stepWidgets = <Widget>[];
  for (var i = 0; i < wizardSteps.length; i++) {
    final step = wizardSteps[i];
    final isActive = step['active'] as bool;
    final isCompleted = step['completed'] as bool;
    final color = step['color'] as MaterialColor;

    stepWidgets.add(
      Expanded(
        child: Column(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: isCompleted
                    ? color.shade600
                    : isActive
                        ? color.shade100
                        : Colors.grey.shade200,
                shape: BoxShape.circle,
                border: isActive
                    ? Border.all(color: color.shade600, width: 2.5)
                    : null,
              ),
              alignment: Alignment.center,
              child: isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 18.0)
                  : Text(
                      '${step['step']}',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: isActive ? color.shade700 : Colors.grey.shade500,
                      ),
                    ),
            ),
            SizedBox(height: 4.0),
            Text(
              step['title'] as String,
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? color.shade700 : Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
    if (i < wizardSteps.length - 1) {
      stepWidgets.add(
        Container(
          width: 20.0,
          height: 2.0,
          margin: EdgeInsets.only(bottom: 16.0),
          color: isCompleted ? color.shade400 : Colors.grey.shade300,
        ),
      );
    }
  }

  final wizardSection = PopScope(
    canPop: false,
    onPopInvokedWithResult: (bool didPop, dynamic result) {
      print('Wizard: back pressed at step 3, would go to step 2 instead of leaving');
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.orange.shade200, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Multi-Step Wizard Pattern',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'PopScope intercepts back navigation to move to the previous '
            'wizard step instead of leaving the entire flow. On step 1, '
            'canPop becomes true to allow exiting.',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          ),
          SizedBox(height: 14.0),
          // Step progress bar
          Row(children: stepWidgets),
          SizedBox(height: 16.0),
          // Current step content
          Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Column(
              children: [
                Icon(Icons.payment, color: Colors.orange.shade600, size: 32.0),
                SizedBox(height: 8.0),
                Text(
                  'Step 3: Payment Details',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade800,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 14.0, color: Colors.orange.shade600),
                    SizedBox(width: 4.0),
                    Text(
                      'Back button → goes to Step 2 (not exit)',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.orange.shade700,
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

  print('Created wizard step pattern with PopScope');

  // ============================================================
  // ASSEMBLY
  // ============================================================
  print('=== Assembling PopScope Deep Demo ===');

  final result = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            children: [
              Text(
                'PopScope Deep Demo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Route pop interception • Back-navigation control • Form protection',
                style: TextStyle(fontSize: 11.0, color: Colors.white60),
              ),
            ],
          ),
        ),
        conceptOverview,
        allowedPage,
        blockedPage,
        section4,
        dialogPattern,
        nestedDemo,
        section7,
        didPopExplanation,
        comparisonSection,
        wizardSection,
        SizedBox(height: 30.0),
      ],
    ),
  );

  print('PopScope Deep Demo complete: 10 sections');
  return result;
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildStatusIndicator(String label, IconData icon, bool allowed) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: allowed ? Colors.green.shade50 : Colors.red.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: allowed ? Colors.green.shade300 : Colors.red.shade300,
      ),
    ),
    child: Column(
      children: [
        Icon(
          icon,
          size: 18.0,
          color: allowed ? Colors.green.shade600 : Colors.red.shade600,
        ),
        SizedBox(height: 2.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 9.0,
            color: allowed ? Colors.green.shade700 : Colors.red.shade700,
          ),
        ),
        Icon(
          allowed ? Icons.check : Icons.close,
          size: 12.0,
          color: allowed ? Colors.green : Colors.red,
        ),
      ],
    ),
  );
}

Widget _buildFormField(String label, String value, bool saved) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: saved ? Colors.grey.shade300 : Colors.orange.shade400,
      ),
    ),
    child: Row(
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              color: saved ? Colors.grey.shade800 : Colors.orange.shade700,
            ),
          ),
        ),
        if (!saved)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'MODIFIED',
              style: TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _buildFlowStep(
  String number,
  String title,
  String description,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: color.shade600,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Icon(icon, color: color.shade400, size: 20.0),
      ],
    ),
  );
}

Widget _buildFlowArrow() {
  return Container(
    height: 20.0,
    alignment: Alignment.center,
    child: Icon(Icons.arrow_downward, size: 16.0, color: Colors.grey.shade400),
  );
}

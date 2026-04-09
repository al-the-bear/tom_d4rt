// ignore_for_file: avoid_print
// D4rt test script: Tests PreviousFocusAction from widgets
// Deep Demo: Visual demonstration of reverse focus traversal action
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PreviousFocusAction Deep Demo executing');

  // ============================================================
  // SECTION 1: What is PreviousFocusAction?
  // ============================================================
  print('=== Section 1: PreviousFocusAction Overview ===');

  // Color palette: Sapphire / Azure
  final sapphire900 = Color(0xFF0D2B55);
  final sapphire800 = Color(0xFF123D77);
  final sapphire700 = Color(0xFF1A529E);
  final sapphire600 = Color(0xFF2468C2);
  final sapphire500 = Color(0xFF3080E0);
  final azure400 = Color(0xFF5BA0F0);
  final azure300 = Color(0xFF85BDF5);
  final azure200 = Color(0xFFADD5FA);
  final azure100 = Color(0xFFD4EAFD);
  final azure50 = Color(0xFFEDF5FE);

  final overviewCards = <Widget>[];

  // Card explaining the class identity
  overviewCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [sapphire900, sapphire700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: sapphire900.withValues(alpha: 0.4),
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
              Icon(Icons.skip_previous_rounded, size: 40.0, color: azure200),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'PreviousFocusAction',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: azure400.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'extends Action<PreviousFocusIntent>',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'monospace',
                color: azure200,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Moves keyboard focus to the previous focusable node '
            'in the focus traversal order. This is the core action '
            'behind the Shift+Tab keyboard shortcut provided by '
            'every Flutter application through WidgetsApp.',
            style: TextStyle(
              fontSize: 14.0,
              color: azure100,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Card showing the Action/Intent pattern
  overviewCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: azure50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: sapphire600.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Action/Intent Pattern',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: sapphire900,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Flutter decouples keyboard intent from action execution. '
            'PreviousFocusIntent declares the desire to move backward, '
            'while PreviousFocusAction performs the actual traversal. '
            'This separation allows any widget to override the action '
            'without changing the keyboard binding.',
            style: TextStyle(fontSize: 13.0, color: sapphire800, height: 1.5),
          ),
        ],
      ),
    ),
  );

  print('Created ${overviewCards.length} overview cards');

  // ============================================================
  // SECTION 2: The Traversal Chain
  // ============================================================
  print('=== Section 2: The Traversal Chain ===');

  final chainSteps = <Map<String, String>>[
    {
      'step': '1',
      'label': 'Keyboard Event',
      'detail': 'User presses Shift+Tab',
      'icon': 'keyboard',
    },
    {
      'step': '2',
      'label': 'Shortcut Binding',
      'detail': 'WidgetsApp maps Shift+Tab to PreviousFocusIntent',
      'icon': 'link',
    },
    {
      'step': '3',
      'label': 'Action Dispatch',
      'detail': 'Actions widget finds PreviousFocusAction',
      'icon': 'call_split',
    },
    {
      'step': '4',
      'label': 'invoke() Called',
      'detail': 'PreviousFocusAction.invoke(intent)',
      'icon': 'play_circle',
    },
    {
      'step': '5',
      'label': 'Focus Traversal',
      'detail': 'primaryFocus!.previousFocus()',
      'icon': 'swap_horiz',
    },
    {
      'step': '6',
      'label': 'Policy Resolution',
      'detail': 'FocusTraversalPolicy determines previous node',
      'icon': 'account_tree',
    },
    {
      'step': '7',
      'label': 'Focus Moves',
      'detail': 'Target FocusNode receives focus',
      'icon': 'center_focus_strong',
    },
  ];

  final chainWidgets = <Widget>[];

  for (var i = 0; i < chainSteps.length; i++) {
    final step = chainSteps[i];
    final isFirst = i == 0;
    final isLast = i == chainSteps.length - 1;
    final progressColor = Color.lerp(sapphire900, azure400, i / (chainSteps.length - 1))!;

    chainWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
        child: Row(
          children: [
            // Step number circle
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: progressColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: progressColor.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  step['step']!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            // Arrow connector
            if (!isFirst)
              SizedBox.shrink(),
            // Step content
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: progressColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: progressColor.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step['label']!,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: sapphire900,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      step['detail']!,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: sapphire700,
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

    // Arrow between steps
    if (!isLast) {
      chainWidgets.add(
        Container(
          margin: EdgeInsets.only(left: 33.0),
          height: 14.0,
          width: 2.0,
          color: progressColor.withValues(alpha: 0.4),
        ),
      );
    }
  }

  print('Created 7-step traversal chain visualization');

  // ============================================================
  // SECTION 3: Default Keyboard Bindings in WidgetsApp
  // ============================================================
  print('=== Section 3: Default Keyboard Bindings ===');

  final bindingsData = <Map<String, String>>[
    {
      'keys': 'Tab',
      'intent': 'NextFocusIntent',
      'action': 'NextFocusAction',
      'direction': 'Forward',
    },
    {
      'keys': 'Shift + Tab',
      'intent': 'PreviousFocusIntent',
      'action': 'PreviousFocusAction',
      'direction': 'Backward',
    },
    {
      'keys': 'Arrow Up',
      'intent': 'DirectionalFocusIntent(up)',
      'action': 'DirectionalFocusAction',
      'direction': 'Up',
    },
    {
      'keys': 'Arrow Down',
      'intent': 'DirectionalFocusIntent(down)',
      'action': 'DirectionalFocusAction',
      'direction': 'Down',
    },
    {
      'keys': 'Arrow Left',
      'intent': 'DirectionalFocusIntent(left)',
      'action': 'DirectionalFocusAction',
      'direction': 'Left',
    },
    {
      'keys': 'Arrow Right',
      'intent': 'DirectionalFocusIntent(right)',
      'action': 'DirectionalFocusAction',
      'direction': 'Right',
    },
  ];

  final bindingRows = <Widget>[];

  // Header row
  bindingRows.add(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: sapphire800,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90.0,
            child: Text('Keys', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0)),
          ),
          SizedBox(
            width: 120.0,
            child: Text('Intent', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0)),
          ),
          Expanded(
            child: Text('Action', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0)),
          ),
        ],
      ),
    ),
  );

  for (var i = 0; i < bindingsData.length; i++) {
    final binding = bindingsData[i];
    final isHighlighted = binding['intent'] == 'PreviousFocusIntent';
    final bgColor = isHighlighted
        ? azure400.withValues(alpha: 0.15)
        : (i.isEven ? azure50 : Colors.white);

    bindingRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: bgColor,
          border: isHighlighted
              ? Border.all(color: sapphire600, width: 2.0)
              : null,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 90.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: isHighlighted ? sapphire600 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  binding['keys']!,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                    color: isHighlighted ? Colors.white : Colors.grey.shade800,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 120.0,
              child: Text(
                binding['intent']!,
                style: TextStyle(
                  fontSize: 10.5,
                  fontFamily: 'monospace',
                  color: isHighlighted ? sapphire900 : Colors.grey.shade700,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              child: Text(
                binding['action']!,
                style: TextStyle(
                  fontSize: 10.5,
                  fontFamily: 'monospace',
                  color: isHighlighted ? sapphire900 : Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created bindings table with ${bindingsData.length} rows');

  // ============================================================
  // SECTION 4: Next vs Previous — Visual Comparison
  // ============================================================
  print('=== Section 4: Next vs Previous Focus Comparison ===');

  Widget buildActionCard({
    required String title,
    required String className,
    required String intentName,
    required String method,
    required String keyBinding,
    required String description,
    required Color cardColor,
    required Color accentColor,
    required IconData icon,
    required String direction,
  }) {
    return Container(
      width: 170.0,
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: accentColor, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 36.0, color: accentColor),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              className,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: accentColor,
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Intent: $intentName',
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 4.0),
          Text(
            'Calls: $method',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade600),
          ),
          SizedBox(height: 4.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              keyBinding,
              style: TextStyle(fontSize: 10.0, fontFamily: 'monospace'),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600, height: 1.3),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                direction == 'forward' ? Icons.arrow_forward : Icons.arrow_back,
                size: 18.0,
                color: accentColor,
              ),
              SizedBox(width: 4.0),
              Text(
                direction == 'forward' ? 'Forward' : 'Backward',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final comparisonRow = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildActionCard(
        title: 'Next Focus',
        className: 'NextFocusAction',
        intentName: 'NextFocusIntent',
        method: 'nextFocus()',
        keyBinding: 'Tab',
        description: 'Moves focus forward through the traversal order',
        cardColor: Colors.green.shade50,
        accentColor: Colors.green.shade700,
        icon: Icons.skip_next_rounded,
        direction: 'forward',
      ),
      SizedBox(width: 16.0),
      // Versus indicator
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Text(
          'vs',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
        ),
      ),
      SizedBox(width: 16.0),
      buildActionCard(
        title: 'Previous Focus',
        className: 'PreviousFocusAction',
        intentName: 'PreviousFocusIntent',
        method: 'previousFocus()',
        keyBinding: 'Shift+Tab',
        description: 'Moves focus backward through the traversal order',
        cardColor: azure50,
        accentColor: sapphire700,
        icon: Icons.skip_previous_rounded,
        direction: 'backward',
      ),
    ],
  );

  print('Created Next vs Previous visual comparison');

  // ============================================================
  // SECTION 5: Focus Traversal Order Visualization
  // ============================================================
  print('=== Section 5: Focus Traversal Order Visualization ===');

  final focusNodeLabels = [
    'Username Field',
    'Email Field',
    'Password Field',
    'Confirm Password',
    'Submit Button',
    'Cancel Button',
  ];

  // Show backward traversal through numbered nodes
  final traversalNodes = <Widget>[];

  for (var i = 0; i < focusNodeLabels.length; i++) {
    final nodeColor = Color.lerp(azure400, sapphire900, i / (focusNodeLabels.length - 1))!;

    traversalNodes.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Column(
          children: [
            // Arrow showing backward direction for all except last
            if (i > 0)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_upward, size: 16.0, color: sapphire500),
                  Text(
                    ' Shift+Tab ',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: sapphire500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            // Focus node box
            Container(
              width: 160.0,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [nodeColor.withValues(alpha: 0.15), nodeColor.withValues(alpha: 0.05)],
                ),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: nodeColor, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      color: nodeColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      focusNodeLabels[i],
                      style: TextStyle(
                        fontSize: 11.5,
                        color: nodeColor,
                        fontWeight: FontWeight.w500,
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

  print('Created ${focusNodeLabels.length}-node traversal visualization');

  // ============================================================
  // SECTION 6: invoke() Return Value Semantics
  // ============================================================
  print('=== Section 6: invoke() Method Details ===');

  final invokeDetails = <Widget>[];

  // Method signature card
  invokeDetails.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: sapphire900,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Method Signature',
            style: TextStyle(
              fontSize: 12.0,
              color: azure300,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'bool invoke(PreviousFocusIntent intent)',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'monospace',
              color: azure100,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Implementation',
            style: TextStyle(
              fontSize: 12.0,
              color: azure300,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'return primaryFocus!.previousFocus();',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'monospace',
                color: azure200,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Return value scenarios
  final returnScenarios = <Map<String, dynamic>>[
    {
      'returns': 'true',
      'meaning': 'Focus successfully moved to previous node',
      'scenario': 'A previous focusable widget exists in the traversal order',
      'color': Colors.green,
      'icon': Icons.check_circle,
    },
    {
      'returns': 'false',
      'meaning': 'Traversal reached the beginning',
      'scenario': 'No previous focusable widget; engine must pass focus to platform UI',
      'color': Colors.orange,
      'icon': Icons.warning_amber_rounded,
    },
  ];

  for (final scenario in returnScenarios) {
    invokeDetails.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: (scenario['color'] as Color).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: (scenario['color'] as Color).withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              scenario['icon'] as IconData,
              color: scenario['color'] as Color,
              size: 28.0,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Returns: ',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: (scenario['color'] as Color).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          scenario['returns'] as String,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            color: scenario['color'] as Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    scenario['meaning'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: sapphire900,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    scenario['scenario'] as String,
                    style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created invoke() details with ${returnScenarios.length} return scenarios');

  // ============================================================
  // SECTION 7: toKeyEventResult Conversion
  // ============================================================
  print('=== Section 7: toKeyEventResult Conversion ===');

  final keyEventCards = <Widget>[];

  keyEventCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: azure50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: sapphire500, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'toKeyEventResult Override',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: sapphire900,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'PreviousFocusAction overrides toKeyEventResult to ensure '
            'proper keyboard event propagation. When invoke returns true, '
            'the event is marked as handled. When false, it returns '
            'skipRemainingHandlers so the platform can process the focus change.',
            style: TextStyle(fontSize: 12.5, color: sapphire800, height: 1.5),
          ),
        ],
      ),
    ),
  );

  // Flow diagram for the key event result
  final keyFlowSteps = <Map<String, dynamic>>[
    {
      'condition': 'invoke() returns true',
      'result': 'KeyEventResult.handled',
      'explanation': 'Focus was moved; the key event is consumed',
      'color': Colors.green.shade700,
    },
    {
      'condition': 'invoke() returns false',
      'result': 'KeyEventResult.skipRemainingHandlers',
      'explanation': 'At boundary; engine handles platform focus escape',
      'color': Colors.orange.shade800,
    },
  ];

  for (final step in keyFlowSteps) {
    keyEventCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              (step['color'] as Color).withValues(alpha: 0.05),
              (step['color'] as Color).withValues(alpha: 0.12),
            ],
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: (step['color'] as Color).withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'If ${step['condition']}',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: step['color'] as Color,
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: (step['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                '→ ${step['result']}',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: step['color'] as Color,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              step['explanation'] as String,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  print('Created toKeyEventResult visualization');

  // ============================================================
  // SECTION 8: FocusTraversalPolicy Relationship
  // ============================================================
  print('=== Section 8: FocusTraversalPolicy Relationship ===');

  final policies = <Map<String, String>>[
    {
      'name': 'ReadingOrderTraversalPolicy',
      'behavior': 'Traverses in left-to-right, top-to-bottom reading order',
      'useCase': 'Default for most apps; natural form field navigation',
      'isDefault': 'true',
    },
    {
      'name': 'OrderedTraversalPolicy',
      'behavior': 'Uses FocusOrder widget to define explicit numeric ordering',
      'useCase': 'When reading order does not match desired tab order',
      'isDefault': 'false',
    },
    {
      'name': 'WidgetOrderTraversalPolicy',
      'behavior': 'Traverses in widget tree build order',
      'useCase': 'When widget build order matches desired navigation',
      'isDefault': 'false',
    },
  ];

  final policyCards = <Widget>[];

  policyCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: sapphire700,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.policy, size: 28.0, color: azure200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'PreviousFocusAction delegates the "which node is previous?" '
              'question entirely to the FocusTraversalPolicy in scope.',
              style: TextStyle(fontSize: 12.5, color: azure100, height: 1.4),
            ),
          ),
        ],
      ),
    ),
  );

  for (var i = 0; i < policies.length; i++) {
    final policy = policies[i];
    final isDefault = policy['isDefault'] == 'true';

    policyCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: isDefault ? azure400.withValues(alpha: 0.12) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isDefault ? sapphire600 : Colors.grey.shade300,
            width: isDefault ? 2.0 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    policy['name']!,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: isDefault ? sapphire900 : Colors.grey.shade800,
                    ),
                  ),
                ),
                if (isDefault)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: sapphire600,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'DEFAULT',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              policy['behavior']!,
              style: TextStyle(fontSize: 12.0, color: sapphire800, height: 1.4),
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Icon(Icons.lightbulb_outline, size: 14.0, color: Colors.amber.shade700),
                SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    policy['useCase']!,
                    style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${policies.length} policy cards');

  // ============================================================
  // SECTION 9: RequestFocusAction Contrast
  // ============================================================
  print('=== Section 9: RequestFocusAction Contrast ===');

  final contrastItems = <Map<String, String>>[
    {
      'aspect': 'Target',
      'previous': 'Previous node in traversal order',
      'request': 'Specific named FocusNode',
    },
    {
      'aspect': 'Intent data',
      'previous': 'No parameters (const constructor)',
      'request': 'Carries a FocusNode reference + callback',
    },
    {
      'aspect': 'Invocation',
      'previous': 'Automatic via Shift+Tab',
      'request': 'Programmatic or custom shortcut',
    },
    {
      'aspect': 'Return type',
      'previous': 'bool (did focus move?)',
      'request': 'void',
    },
    {
      'aspect': 'Scope',
      'previous': 'Relative to current focus',
      'request': 'Absolute — targets specific node',
    },
    {
      'aspect': 'Policy-dependent',
      'previous': 'Yes — uses FocusTraversalPolicy',
      'request': 'No — directly calls requestFocus()',
    },
  ];

  final contrastWidgets = <Widget>[];

  // Table header
  contrastWidgets.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: sapphire800,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80.0,
            child: Text('Aspect', style: TextStyle(color: azure200, fontWeight: FontWeight.bold, fontSize: 11.0)),
          ),
          Expanded(
            child: Text('PreviousFocusAction', style: TextStyle(color: azure100, fontWeight: FontWeight.bold, fontSize: 11.0)),
          ),
          Expanded(
            child: Text('RequestFocusAction', style: TextStyle(color: azure100, fontWeight: FontWeight.bold, fontSize: 11.0)),
          ),
        ],
      ),
    ),
  );

  for (var i = 0; i < contrastItems.length; i++) {
    final item = contrastItems[i];
    contrastWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        decoration: BoxDecoration(
          color: i.isEven ? azure50 : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80.0,
              child: Text(
                item['aspect']!,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: sapphire900,
                ),
              ),
            ),
            Expanded(
              child: Text(
                item['previous']!,
                style: TextStyle(fontSize: 10.5, color: sapphire700),
              ),
            ),
            Expanded(
              child: Text(
                item['request']!,
                style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created contrast table with ${contrastItems.length} rows');

  // ============================================================
  // SECTION 10: Custom Action Override Architecture
  // ============================================================
  print('=== Section 10: Custom Action Override ===');

  final overrideCards = <Widget>[];

  overrideCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [sapphire600, azure400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: sapphire700.withValues(alpha: 0.3),
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.build_circle, size: 28.0, color: Colors.white),
              SizedBox(width: 10.0),
              Text(
                'Overriding PreviousFocusAction',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Text(
            'Because PreviousFocusAction is resolved through the Actions '
            'widget, you can override it at any point in the widget tree. '
            'This is useful for logging, analytics, conditional traversal '
            'gating, or redirecting focus to a specific node instead of '
            'following the normal traversal order.',
            style: TextStyle(fontSize: 12.5, color: azure100, height: 1.5),
          ),
        ],
      ),
    ),
  );

  // Architecture diagram — showing override points
  final overrideSteps = <Map<String, String>>[
    {
      'layer': 'WidgetsApp',
      'action': 'Default PreviousFocusAction registered',
      'note': 'Root-level handler for entire app',
    },
    {
      'layer': 'Actions Widget',
      'action': 'Custom Action<PreviousFocusIntent> override',
      'note': 'Scoped override for subtree',
    },
    {
      'layer': 'FocusTraversalGroup',
      'action': 'Custom traversal policy',
      'note': 'Changes which node is "previous"',
    },
  ];

  for (var i = 0; i < overrideSteps.length; i++) {
    final step = overrideSteps[i];
    final depth = i * 24.0;

    overrideCards.add(
      Container(
        margin: EdgeInsets.only(left: 12.0 + depth, right: 12.0, top: 4.0, bottom: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color.lerp(sapphire900, azure50, i / 2.0)!.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color.lerp(sapphire700, azure400, i / 2.0)!,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              step['layer']!,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: sapphire900,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              step['action']!,
              style: TextStyle(fontSize: 11.5, color: sapphire700),
            ),
            SizedBox(height: 2.0),
            Text(
              step['note']!,
              style: TextStyle(
                fontSize: 10.5,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created override architecture with ${overrideSteps.length} layers');

  // ============================================================
  // SECTION 11: Platform Behavior Differences
  // ============================================================
  print('=== Section 11: Platform Focus Behavior ===');

  final platforms = <Map<String, String>>[
    {
      'platform': 'Desktop (Windows/Linux/macOS)',
      'tabBehavior': 'Tab/Shift+Tab standard',
      'focusEscape': 'At boundary, focus escapes to OS window chrome',
      'icon': 'desktop_windows',
    },
    {
      'platform': 'Web',
      'tabBehavior': 'Tab/Shift+Tab with browser integration',
      'focusEscape': 'At boundary, focus moves to browser address bar or other page elements',
      'icon': 'language',
    },
    {
      'platform': 'Mobile (iOS/Android)',
      'tabBehavior': 'Rarely used; focus via touch',
      'focusEscape': 'Focus traversal primarily for external keyboards',
      'icon': 'phone_android',
    },
  ];

  final platformCards = <Widget>[];

  for (var i = 0; i < platforms.length; i++) {
    final platform = platforms[i];
    final cardGradient = Color.lerp(sapphire800, azure400, i / 2.0)!;

    platformCards.add(
      Container(
        width: 160.0,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cardGradient.withValues(alpha: 0.12), cardGradient.withValues(alpha: 0.04)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cardGradient.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Column(
          children: [
            Icon(
              i == 0
                  ? Icons.desktop_windows
                  : (i == 1 ? Icons.language : Icons.phone_android),
              size: 32.0,
              color: cardGradient,
            ),
            SizedBox(height: 8.0),
            Text(
              platform['platform']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: sapphire900,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              platform['tabBehavior']!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.5, color: sapphire700),
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.amber.shade300, width: 0.5),
              ),
              child: Text(
                platform['focusEscape']!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9.5, color: Colors.amber.shade900),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${platforms.length} platform cards');

  // ============================================================
  // SECTION 12: Focus Groups and Scope Boundaries
  // ============================================================
  print('=== Section 12: Focus Groups and Scope Boundaries ===');

  // Visualize nested FocusTraversalGroups
  Widget buildFocusGroupBox({
    required String label,
    required Color borderColor,
    required List<String> children,
    required String policyName,
  }) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: borderColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                policyName,
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: borderColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: children.map((child) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: borderColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: borderColor.withValues(alpha: 0.4),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  child,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: borderColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  final focusGroupVisualization = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: azure50,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          'PreviousFocusAction respects FocusTraversalGroup boundaries. '
          'When Shift+Tab reaches the first node in a group, it moves '
          'to the last node in the previous group, not the previous '
          'node within the same group.',
          style: TextStyle(fontSize: 12.0, color: sapphire800, height: 1.4),
        ),
      ),
      buildFocusGroupBox(
        label: 'Group A (Navigation)',
        borderColor: sapphire700,
        children: ['Home', 'Search', 'Settings'],
        policyName: 'ReadingOrderTraversalPolicy',
      ),
      buildFocusGroupBox(
        label: 'Group B (Form)',
        borderColor: azure400,
        children: ['Name', 'Email', 'Phone', 'Address'],
        policyName: 'OrderedTraversalPolicy',
      ),
      buildFocusGroupBox(
        label: 'Group C (Actions)',
        borderColor: Colors.teal,
        children: ['Save', 'Cancel', 'Reset'],
        policyName: 'ReadingOrderTraversalPolicy',
      ),
    ],
  );

  print('Created focus group boundary visualization');

  // ============================================================
  // SECTION 13: Accessibility Integration
  // ============================================================
  print('=== Section 13: Accessibility ===');

  final accessibilityCards = <Widget>[];

  accessibilityCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade400],
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
              Icon(Icons.accessibility_new, size: 32.0, color: Colors.white),
              SizedBox(width: 10.0),
              Text(
                'Accessibility & Semantics',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            'PreviousFocusAction is fundamental to keyboard accessibility in '
            'Flutter. It ensures that users who rely on keyboard navigation '
            '(due to motor impairments or preference) can move backward '
            'through all interactive elements in a deterministic order.',
            style: TextStyle(fontSize: 12.5, color: Colors.white70, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final accessibilityPoints = <Map<String, String>>[
    {
      'title': 'WCAG 2.1.1 Keyboard',
      'detail': 'All functionality must be operable through keyboard. '
          'PreviousFocusAction provides the backward direction.',
    },
    {
      'title': 'Focus Visible (2.4.7)',
      'detail': 'When PreviousFocusAction moves focus, the target gets '
          'a visible focus indicator (ring or highlight).',
    },
    {
      'title': 'Focus Order (2.4.3)',
      'detail': 'The traversal order must be meaningful. PreviousFocusAction '
          'reverses the same order NextFocusAction follows.',
    },
    {
      'title': 'Screen Readers',
      'detail': 'Shift+Tab moves to previous element. Screen readers announce '
          'the newly focused widget label and role.',
    },
  ];

  for (final point in accessibilityPoints) {
    accessibilityCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.deepPurple.shade200,
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.verified, size: 20.0, color: Colors.deepPurple.shade400),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    point['title']!,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    point['detail']!,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.deepPurple.shade600,
                      height: 1.4,
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

  print('Created ${accessibilityPoints.length} accessibility cards');

  // ============================================================
  // SECTION 14: Complete Focus Action Family
  // ============================================================
  print('=== Section 14: Focus Action Family ===');

  final familyMembers = <Map<String, dynamic>>[
    {
      'name': 'NextFocusAction',
      'intent': 'NextFocusIntent',
      'binding': 'Tab',
      'method': 'nextFocus()',
      'color': Colors.green,
      'icon': Icons.arrow_forward,
    },
    {
      'name': 'PreviousFocusAction',
      'intent': 'PreviousFocusIntent',
      'binding': 'Shift+Tab',
      'method': 'previousFocus()',
      'color': sapphire700,
      'icon': Icons.arrow_back,
    },
    {
      'name': 'DirectionalFocusAction',
      'intent': 'DirectionalFocusIntent',
      'binding': 'Arrow Keys',
      'method': 'focusInDirection()',
      'color': Colors.purple,
      'icon': Icons.open_with,
    },
    {
      'name': 'RequestFocusAction',
      'intent': 'RequestFocusIntent',
      'binding': 'Custom',
      'method': 'requestFocus()',
      'color': Colors.orange,
      'icon': Icons.center_focus_strong,
    },
  ];

  final familyCards = <Widget>[];

  for (var i = 0; i < familyMembers.length; i++) {
    final member = familyMembers[i];
    final isCurrent = member['name'] == 'PreviousFocusAction';

    familyCards.add(
      Container(
        width: 140.0,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isCurrent
              ? (member['color'] as Color).withValues(alpha: 0.15)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: member['color'] as Color,
            width: isCurrent ? 3.0 : 1.5,
          ),
          boxShadow: isCurrent
              ? [
                  BoxShadow(
                    color: (member['color'] as Color).withValues(alpha: 0.3),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(
              member['icon'] as IconData,
              size: 28.0,
              color: member['color'] as Color,
            ),
            SizedBox(height: 8.0),
            Text(
              member['name'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                color: member['color'] as Color,
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                member['binding'] as String,
                style: TextStyle(
                  fontSize: 9.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              member['method'] as String,
              style: TextStyle(
                fontSize: 9.5,
                fontFamily: 'monospace',
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${familyMembers.length} family member cards');

  // ============================================================
  // SECTION 15: Integration Summary
  // ============================================================
  print('=== Section 15: Integration Summary ===');

  final summaryPoints = <Map<String, String>>[
    {
      'key': 'Class',
      'value': 'PreviousFocusAction extends Action<PreviousFocusIntent>',
    },
    {
      'key': 'Purpose',
      'value': 'Move keyboard focus to the previous focusable node',
    },
    {
      'key': 'Default Binding',
      'value': 'Shift+Tab in WidgetsApp',
    },
    {
      'key': 'invoke()',
      'value': 'Returns bool; calls primaryFocus!.previousFocus()',
    },
    {
      'key': 'Policy',
      'value': 'Defers to FocusTraversalPolicy for node ordering',
    },
    {
      'key': 'Boundary',
      'value': 'Returns false at start; engine handles platform escape',
    },
    {
      'key': 'Override',
      'value': 'Wrap subtree in Actions to provide custom handler',
    },
    {
      'key': 'Counterpart',
      'value': 'NextFocusAction for forward traversal',
    },
  ];

  final summaryRows = <Widget>[];

  for (var i = 0; i < summaryPoints.length; i++) {
    final point = summaryPoints[i];
    summaryRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: i.isEven ? sapphire900.withValues(alpha: 0.04) : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.0,
              child: Text(
                point['key']!,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: sapphire900,
                ),
              ),
            ),
            Expanded(
              child: Text(
                point['value']!,
                style: TextStyle(fontSize: 11.5, color: sapphire700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${summaryPoints.length} summary entries');
  print('PreviousFocusAction Deep Demo complete');

  // ============================================================
  // BUILD FINAL LAYOUT
  // ============================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('PreviousFocusAction Deep Demo'),
        backgroundColor: sapphire800,
        foregroundColor: Colors.white,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Overview
            ...overviewCards,

            // Section 2: Traversal Chain
            Container(
              margin: EdgeInsets.all(12.0),
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: azure50,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Traversal Chain',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: sapphire900,
                    ),
                  ),
                  Text(
                    'From key press to focus change',
                    style: TextStyle(fontSize: 12.0, color: sapphire600),
                  ),
                  SizedBox(height: 12.0),
                  ...chainWidgets,
                ],
              ),
            ),

            // Section 3: Keyboard Bindings
            Container(
              margin: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Default WidgetsApp Keyboard Bindings',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: sapphire900,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Column(
                      children: bindingRows,
                    ),
                  ),
                ],
              ),
            ),

            // Section 4: Next vs Previous Comparison
            Container(
              margin: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Next vs Previous Focus',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: sapphire900,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  comparisonRow,
                ],
              ),
            ),

            // Section 5: Traversal Order
            Container(
              margin: EdgeInsets.all(12.0),
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: sapphire900.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: sapphire600.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Text(
                    'Backward Traversal Order',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: sapphire900,
                    ),
                  ),
                  Text(
                    'Shift+Tab moves from bottom to top',
                    style: TextStyle(fontSize: 12.0, color: sapphire600),
                  ),
                  SizedBox(height: 12.0),
                  ...traversalNodes.reversed,
                ],
              ),
            ),

            // Section 6: invoke() Method
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'invoke() Method & Return Value',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: sapphire900,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ...invokeDetails,
                ],
              ),
            ),

            // Section 7: toKeyEventResult
            ...keyEventCards,

            // Section 8: Traversal Policies
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'FocusTraversalPolicy Integration',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: sapphire900,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ...policyCards,
                ],
              ),
            ),

            // Section 9: RequestFocusAction Contrast
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'PreviousFocusAction vs RequestFocusAction',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: sapphire900,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ...contrastWidgets,
                ],
              ),
            ),

            // Section 10: Override Architecture
            ...overrideCards,

            // Section 11: Platform Behavior
            Container(
              margin: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Platform-Specific Behavior',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: sapphire900,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: platformCards,
                  ),
                ],
              ),
            ),

            // Section 12: Focus Groups
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Focus Groups & Scope Boundaries',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: sapphire900,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  focusGroupVisualization,
                ],
              ),
            ),

            // Section 13: Accessibility
            ...accessibilityCards,

            // Section 14: Focus Action Family
            Container(
              margin: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Focus Action Family',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: sapphire900,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    alignment: WrapAlignment.center,
                    children: familyCards,
                  ),
                ],
              ),
            ),

            // Section 15: Summary
            Container(
              margin: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: sapphire600.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: sapphire800,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11.0),
                        topRight: Radius.circular(11.0),
                      ),
                    ),
                    child: Text(
                      'Quick Reference Summary',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ...summaryRows,
                ],
              ),
            ),

            SizedBox(height: 32.0),
          ],
        ),
      ),
    ),
  );
}

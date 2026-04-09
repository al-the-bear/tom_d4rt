// ignore_for_file: avoid_print
// D4rt test script: Tests PreviousFocusIntent from widgets
// Deep Demo: Visual demonstration of the backward-focus intent declaration
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PreviousFocusIntent Deep Demo executing');

  // ============================================================
  // SECTION 1: What is PreviousFocusIntent?
  // ============================================================
  print('=== Section 1: PreviousFocusIntent Overview ===');

  // Color palette: Coral / Peach
  final coral900 = Color(0xFF7A1B1B);
  final coral800 = Color(0xFF9C2828);
  final coral700 = Color(0xFFBE3E3E);
  final coral600 = Color(0xFFD9554B);
  final coral500 = Color(0xFFE87461);
  final peach400 = Color(0xFFF09580);
  final peach300 = Color(0xFFF5B3A0);
  final peach200 = Color(0xFFFAD0C3);
  final peach100 = Color(0xFFFDE8E0);
  final peach50 = Color(0xFFFFF4F0);

  final overviewCards = <Widget>[];

  // Hero card
  overviewCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [coral900, coral600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: coral900.withValues(alpha: 0.4),
            blurRadius: 14.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mail_outline, size: 38.0, color: peach200),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'PreviousFocusIntent',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: peach400.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'class PreviousFocusIntent extends Intent',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'monospace',
                color: peach200,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'A parameter-free Intent that declares the desire to move '
            'keyboard focus to the previous focusable widget. It carries '
            'no data — its very presence IS the message. The simplest '
            'possible Intent: const PreviousFocusIntent().',
            style: TextStyle(
              fontSize: 14.0,
              color: peach100,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Source code card
  overviewCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, size: 18.0, color: peach400),
              SizedBox(width: 8.0),
              Text(
                'Complete Source Code',
                style: TextStyle(fontSize: 13.0, color: peach300, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            'class PreviousFocusIntent extends Intent {\n'
            '  const PreviousFocusIntent();\n'
            '}',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'monospace',
              color: peach200,
              height: 1.6,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'That is the ENTIRE class. Three lines.\n'
            'The simplicity is intentional — an Intent is pure declaration.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade400,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );

  print('Created ${overviewCards.length} overview cards');

  // ============================================================
  // SECTION 2: The Intent Abstraction Layer
  // ============================================================
  print('=== Section 2: Intent Abstraction Layer ===');

  final intentLayerCards = <Widget>[];

  intentLayerCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: peach50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: coral600.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Does Intent Exist?',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: coral900,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Intent separates WHAT from HOW. The keyboard shortcut system '
            'does not call actions directly — it creates Intents. This '
            'decoupling lets different parts of the widget tree respond '
            'to the same desire differently, without changing the shortcut map.',
            style: TextStyle(fontSize: 13.0, color: coral800, height: 1.5),
          ),
        ],
      ),
    ),
  );

  // Three-layer diagram
  final layers = <Map<String, dynamic>>[
    {
      'label': 'Input Layer',
      'subtitle': 'Keyboard / Gesture',
      'detail': 'Physical key events from the platform',
      'color': Colors.grey.shade700,
      'icon': Icons.keyboard,
    },
    {
      'label': 'Intent Layer',
      'subtitle': 'PreviousFocusIntent',
      'detail': 'Semantic meaning: "go to previous focus"',
      'color': coral600,
      'icon': Icons.mail_outline,
    },
    {
      'label': 'Action Layer',
      'subtitle': 'PreviousFocusAction',
      'detail': 'Execution: calls previousFocus()',
      'color': Colors.teal.shade700,
      'icon': Icons.play_circle_outline,
    },
  ];

  for (var i = 0; i < layers.length; i++) {
    final layer = layers[i];
    final isIntent = i == 1;

    intentLayerCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
        child: Column(
          children: [
            if (i > 0)
              Container(
                height: 20.0,
                width: 2.0,
                color: (layer['color'] as Color).withValues(alpha: 0.4),
              ),
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: isIntent
                    ? (layer['color'] as Color).withValues(alpha: 0.1)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: layer['color'] as Color,
                  width: isIntent ? 2.5 : 1.5,
                ),
                boxShadow: isIntent
                    ? [
                        BoxShadow(
                          color: (layer['color'] as Color).withValues(alpha: 0.2),
                          blurRadius: 8.0,
                          offset: Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  Icon(
                    layer['icon'] as IconData,
                    size: 28.0,
                    color: layer['color'] as Color,
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          layer['label'] as String,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: layer['color'] as Color,
                          ),
                        ),
                        Text(
                          layer['subtitle'] as String,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                            color: (layer['color'] as Color).withValues(alpha: 0.8),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          layer['detail'] as String,
                          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
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
  }

  print('Created ${layers.length}-layer abstraction diagram');

  // ============================================================
  // SECTION 3: Built-in Focus Intent Family
  // ============================================================
  print('=== Section 3: Built-in Focus Intent Family ===');

  final intentFamily = <Map<String, dynamic>>[
    {
      'name': 'NextFocusIntent',
      'params': 'None',
      'constructor': 'const NextFocusIntent()',
      'purpose': 'Move focus forward',
      'binding': 'Tab',
      'color': Colors.green.shade600,
      'icon': Icons.arrow_forward,
    },
    {
      'name': 'PreviousFocusIntent',
      'params': 'None',
      'constructor': 'const PreviousFocusIntent()',
      'purpose': 'Move focus backward',
      'binding': 'Shift+Tab',
      'color': coral600,
      'icon': Icons.arrow_back,
    },
    {
      'name': 'DirectionalFocusIntent',
      'params': 'TraversalDirection, ignoreTextFields',
      'constructor': 'DirectionalFocusIntent(direction)',
      'purpose': 'Move focus in spatial direction',
      'binding': 'Arrow Keys',
      'color': Colors.purple.shade600,
      'icon': Icons.open_with,
    },
    {
      'name': 'RequestFocusIntent',
      'params': 'FocusNode, callback',
      'constructor': 'RequestFocusIntent(node)',
      'purpose': 'Focus specific node',
      'binding': 'Custom',
      'color': Colors.amber.shade800,
      'icon': Icons.center_focus_strong,
    },
  ];

  final familyCards = <Widget>[];

  for (var i = 0; i < intentFamily.length; i++) {
    final intent = intentFamily[i];
    final isCurrent = intent['name'] == 'PreviousFocusIntent';

    familyCards.add(
      Container(
        width: 165.0,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isCurrent
              ? (intent['color'] as Color).withValues(alpha: 0.12)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: intent['color'] as Color,
            width: isCurrent ? 3.0 : 1.5,
          ),
          boxShadow: isCurrent
              ? [
                  BoxShadow(
                    color: (intent['color'] as Color).withValues(alpha: 0.25),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(intent['icon'] as IconData, size: 28.0, color: intent['color'] as Color),
            SizedBox(height: 8.0),
            Text(
              intent['name'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: intent['color'] as Color,
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                intent['binding'] as String,
                style: TextStyle(fontSize: 9.5, fontFamily: 'monospace'),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Params: ${intent['params']}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600),
            ),
            SizedBox(height: 4.0),
            Text(
              intent['purpose'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${intentFamily.length} intent family cards');

  // ============================================================
  // SECTION 4: Const Constructor Significance
  // ============================================================
  print('=== Section 4: Const Constructor Significance ===');

  final constBenefits = <Map<String, String>>[
    {
      'benefit': 'Compile-time Constant',
      'detail': 'PreviousFocusIntent can be created at compile time. '
          'No heap allocation at runtime when used as const.',
    },
    {
      'benefit': 'Canonical Instance',
      'detail': 'const PreviousFocusIntent() always returns the same '
          'instance. Two const constructions are identical(). ',
    },
    {
      'benefit': 'Shortcut Map Keys',
      'detail': 'Used as values in the WidgetsApp shortcut map. '
          'Const intents avoid creating new objects per key press.',
    },
    {
      'benefit': 'Zero Parameters',
      'detail': 'Unlike DirectionalFocusIntent(direction) or '
          'RequestFocusIntent(node), this intent carries no data. '
          'The type alone conveys all meaning.',
    },
  ];

  final constCards = <Widget>[];

  for (var i = 0; i < constBenefits.length; i++) {
    final benefit = constBenefits[i];
    final tileColor = Color.lerp(coral700, peach400, i / (constBenefits.length - 1))!;

    constCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: tileColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: tileColor.withValues(alpha: 0.35), width: 1.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: tileColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    benefit['benefit']!,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: coral900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    benefit['detail']!,
                    style: TextStyle(fontSize: 11.5, color: coral800, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${constBenefits.length} const benefit cards');

  // ============================================================
  // SECTION 5: Intent vs Action Separation of Concerns
  // ============================================================
  print('=== Section 5: Separation of Concerns ===');

  final separationCards = <Widget>[];

  // Side-by-side comparison
  Widget buildSideCard({
    required String title,
    required String subtitle,
    required List<String> responsibilities,
    required Color cardColor,
    required IconData icon,
  }) {
    return Container(
      width: 170.0,
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: cardColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: cardColor, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24.0, color: cardColor),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: cardColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: cardColor.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 10.0),
          ...responsibilities.map((r) {
            return Padding(
              padding: EdgeInsets.only(bottom: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyle(color: cardColor, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(
                      r,
                      style: TextStyle(fontSize: 10.5, color: Colors.grey.shade800, height: 1.3),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  separationCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: buildSideCard(
              title: 'Intent',
              subtitle: 'PreviousFocusIntent',
              responsibilities: [
                'Declares desire',
                'Carries parameters (or none)',
                'Is immutable & const',
                'Lives in shortcut maps',
                'Has no side effects',
              ],
              cardColor: coral600,
              icon: Icons.mail_outline,
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: buildSideCard(
              title: 'Action',
              subtitle: 'PreviousFocusAction',
              responsibilities: [
                'Performs the work',
                'Has side effects',
                'Can be overridden per subtree',
                'Returns a result',
                'Has access to context',
              ],
              cardColor: Colors.teal.shade700,
              icon: Icons.play_circle_outline,
            ),
          ),
        ],
      ),
    ),
  );

  print('Created Intent vs Action side-by-side comparison');

  // ============================================================
  // SECTION 6: Shortcuts → Actions Pipeline
  // ============================================================
  print('=== Section 6: Shortcuts to Actions Pipeline ===');

  final pipelineSteps = <Map<String, String>>[
    {
      'stage': 'ShortcutManager',
      'input': 'KeyEvent (Shift+Tab)',
      'output': 'PreviousFocusIntent',
      'detail': 'Looks up key combo in shortcut map',
    },
    {
      'stage': 'Shortcuts Widget',
      'input': 'PreviousFocusIntent',
      'output': 'Intent dispatched',
      'detail': 'Walks up widget tree to find Actions',
    },
    {
      'stage': 'Actions Widget',
      'input': 'PreviousFocusIntent',
      'output': 'PreviousFocusAction resolved',
      'detail': 'Maps intent type to registered action',
    },
    {
      'stage': 'Action.invoke()',
      'input': 'PreviousFocusIntent instance',
      'output': 'bool (focus moved)',
      'detail': 'Executes the focus change',
    },
  ];

  final pipelineWidgets = <Widget>[];

  for (var i = 0; i < pipelineSteps.length; i++) {
    final step = pipelineSteps[i];
    final stageColor = Color.lerp(coral800, peach400, i / (pipelineSteps.length - 1))!;

    pipelineWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
        child: Column(
          children: [
            if (i > 0)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: Icon(Icons.arrow_downward, size: 18.0, color: stageColor.withValues(alpha: 0.5)),
              ),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: stageColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: stageColor, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: stageColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['stage']!,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: coral900,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          step['detail']!,
                          style: TextStyle(fontSize: 11.0, color: coral700),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                step['input']!,
                                style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: Colors.grey.shade700),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.0),
                              child: Icon(Icons.arrow_right_alt, size: 16.0, color: stageColor),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: stageColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                step['output']!,
                                style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: stageColor),
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
          ],
        ),
      ),
    );
  }

  print('Created ${pipelineSteps.length}-stage pipeline visualization');

  // ============================================================
  // SECTION 7: Parameter-Bearing vs Parameter-Free Intents
  // ============================================================
  print('=== Section 7: Parameter Bearing vs Free ===');

  final paramComparison = <Map<String, dynamic>>[
    {
      'category': 'Parameter-Free',
      'examples': ['PreviousFocusIntent', 'NextFocusIntent', 'DismissIntent', 'ActivateIntent'],
      'description': 'Type alone is the message. No runtime data carried.',
      'analogy': 'Like a flag signal — the signal IS the message.',
      'color': coral600,
    },
    {
      'category': 'Parameter-Bearing',
      'examples': ['RequestFocusIntent(node)', 'DirectionalFocusIntent(dir)', 'ScrollIntent(direction, type)'],
      'description': 'Carries data the action needs to execute properly.',
      'analogy': 'Like a message with an address — says what AND where.',
      'color': Colors.indigo,
    },
  ];

  final paramCards = <Widget>[];

  for (final comparison in paramComparison) {
    paramCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: (comparison['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: (comparison['color'] as Color).withValues(alpha: 0.4),
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: comparison['color'] as Color,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                comparison['category'] as String,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: (comparison['examples'] as List<String>).map((ex) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: (comparison['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: (comparison['color'] as Color).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    ex,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: comparison['color'] as Color,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10.0),
            Text(
              comparison['description'] as String,
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800, height: 1.4),
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Icon(Icons.lightbulb_outline, size: 14.0, color: Colors.amber.shade700),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    comparison['analogy'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade600,
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

  print('Created parameter comparison cards');

  // ============================================================
  // SECTION 8: Custom Intent Creation Pattern
  // ============================================================
  print('=== Section 8: Custom Intent Patterns ===');

  final customIntentCards = <Widget>[];

  customIntentCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [coral700, peach400],
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
              Icon(Icons.construction, size: 28.0, color: Colors.white),
              SizedBox(width: 10.0),
              Text(
                'Creating Your Own Intents',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Text(
            'PreviousFocusIntent is a template for creating custom intents. '
            'When your application needs a new semantic action, create an '
            'Intent subclass, register a matching Action, and bind a shortcut.',
            style: TextStyle(fontSize: 12.5, color: peach100, height: 1.5),
          ),
        ],
      ),
    ),
  );

  // Intent creation recipe
  final recipeSteps = <Map<String, String>>[
    {
      'step': 'Define Intent',
      'code': 'class SaveDocumentIntent extends Intent {\n  const SaveDocumentIntent();\n}',
      'note': 'Follow the PreviousFocusIntent pattern — const, lightweight',
    },
    {
      'step': 'Create Action',
      'code': 'class SaveDocumentAction extends Action<SaveDocumentIntent> {\n  void invoke(SaveDocumentIntent intent) { /* save logic */ }\n}',
      'note': 'The action carries the real implementation',
    },
    {
      'step': 'Register & Bind',
      'code': 'Actions(\n  actions: {SaveDocumentIntent: SaveDocumentAction()},\n  child: Shortcuts(\n    shortcuts: {SingleActivator(LogicalKeyboardKey.keyS, control: true): SaveDocumentIntent()},\n    child: ...\n  ),\n)',
      'note': 'Connect intent to shortcut and action in the widget tree',
    },
  ];

  for (var i = 0; i < recipeSteps.length; i++) {
    final recipe = recipeSteps[i];
    customIntentCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: peach50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: coral500.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: coral600,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'Step ${i + 1}: ${recipe['step']!}',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                recipe['code']!,
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: peach200,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              recipe['note']!,
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

  print('Created ${recipeSteps.length}-step custom intent recipe');

  // ============================================================
  // SECTION 9: Actions.invoke Dispatch
  // ============================================================
  print('=== Section 9: Actions.invoke Dispatch ===');

  final dispatchCards = <Widget>[];

  dispatchCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: peach50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: coral500.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dispatching PreviousFocusIntent Programmatically',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: coral900,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'While PreviousFocusIntent is typically triggered by Shift+Tab, '
            'it can also be invoked programmatically via Actions.invoke:',
            style: TextStyle(fontSize: 12.0, color: coral800, height: 1.4),
          ),
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Color(0xFF1E1E2E),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Actions.invoke(\n'
              '  context,\n'
              '  const PreviousFocusIntent(),\n'
              ');',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'monospace',
                color: peach200,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'This is equivalent to pressing Shift+Tab. The same traversal '
            'chain executes, the same FocusTraversalPolicy is consulted, '
            'and the same Action handles the intent.',
            style: TextStyle(fontSize: 11.5, color: coral700, height: 1.4),
          ),
        ],
      ),
    ),
  );

  // maybeInvoke comparison
  final invokeVariants = <Map<String, String>>[
    {
      'method': 'Actions.invoke(context, intent)',
      'behavior': 'Throws if no action found for intent type',
      'useCase': 'When action MUST exist',
    },
    {
      'method': 'Actions.maybeInvoke(context, intent)',
      'behavior': 'Returns null if no action found',
      'useCase': 'When action is optional',
    },
    {
      'method': 'Actions.handler(context, intent)',
      'behavior': 'Returns a VoidCallback that invokes the intent, or null',
      'useCase': 'Deferred invocation (e.g., button onPressed)',
    },
  ];

  for (final variant in invokeVariants) {
    dispatchCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              variant['method']!,
              style: TextStyle(
                fontSize: 11.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: coral800,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              variant['behavior']!,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 2.0),
            Text(
              'Use: ${variant['useCase']!}',
              style: TextStyle(
                fontSize: 10.0,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created dispatch visualization with ${invokeVariants.length} variants');

  // ============================================================
  // SECTION 10: WidgetsApp Shortcut Map
  // ============================================================
  print('=== Section 10: WidgetsApp Shortcut Map ===');

  final shortcutEntries = <Map<String, String>>[
    {'activator': 'SingleActivator(LogicalKeyboardKey.tab)', 'intent': 'NextFocusIntent()'},
    {'activator': 'SingleActivator(LogicalKeyboardKey.tab, shift: true)', 'intent': 'PreviousFocusIntent()'},
    {'activator': 'SingleActivator(LogicalKeyboardKey.arrowUp)', 'intent': 'DirectionalFocusIntent(up)'},
    {'activator': 'SingleActivator(LogicalKeyboardKey.arrowDown)', 'intent': 'DirectionalFocusIntent(down)'},
    {'activator': 'SingleActivator(LogicalKeyboardKey.arrowLeft)', 'intent': 'DirectionalFocusIntent(left)'},
    {'activator': 'SingleActivator(LogicalKeyboardKey.arrowRight)', 'intent': 'DirectionalFocusIntent(right)'},
  ];

  final shortcutRows = <Widget>[];

  shortcutRows.add(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: coral800,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('ShortcutActivator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11.0)),
          ),
          Expanded(
            flex: 2,
            child: Text('Intent', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11.0)),
          ),
        ],
      ),
    ),
  );

  for (var i = 0; i < shortcutEntries.length; i++) {
    final entry = shortcutEntries[i];
    final isHighlighted = entry['intent']!.contains('Previous');

    shortcutRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isHighlighted
              ? coral500.withValues(alpha: 0.12)
              : (i.isEven ? peach50 : Colors.white),
          border: isHighlighted
              ? Border.all(color: coral600, width: 2.0)
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                entry['activator']!,
                style: TextStyle(
                  fontSize: 9.5,
                  fontFamily: 'monospace',
                  color: isHighlighted ? coral900 : Colors.grey.shade700,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                entry['intent']!,
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: isHighlighted ? coral800 : Colors.grey.shade600,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created shortcut map visualization with ${shortcutEntries.length} entries');

  // ============================================================
  // SECTION 11: Intent Identity and Type Matching
  // ============================================================
  print('=== Section 11: Intent Identity & Type Matching ===');

  final identityCards = <Widget>[];

  identityCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [coral900, coral700],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.fingerprint, size: 28.0, color: peach200),
              SizedBox(width: 10.0),
              Text(
                'How Actions Finds the Right Action',
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
            'When PreviousFocusIntent is dispatched, the Actions widget '
            'looks for an Action registered against the PreviousFocusIntent '
            'type. The matching is type-based, not instance-based. This is '
            'why const construction works — all instances are the same type.',
            style: TextStyle(fontSize: 12.5, color: peach100, height: 1.5),
          ),
        ],
      ),
    ),
  );

  // Show the type matching flow
  final matchSteps = <Map<String, String>>[
    {
      'step': 'Intent received',
      'detail': 'const PreviousFocusIntent()',
    },
    {
      'step': 'Type extracted',
      'detail': 'intent.runtimeType → PreviousFocusIntent',
    },
    {
      'step': 'Action lookup',
      'detail': 'actionMap[PreviousFocusIntent] → PreviousFocusAction',
    },
    {
      'step': 'Action invoked',
      'detail': 'action.invoke(intent) → bool',
    },
  ];

  for (var i = 0; i < matchSteps.length; i++) {
    final step = matchSteps[i];
    identityCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: peach100.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: coral600, width: 3.0),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22.0,
              height: 22.0,
              decoration: BoxDecoration(
                color: coral600,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['step']!,
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: coral900),
                  ),
                  Text(
                    step['detail']!,
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: coral700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created type matching flow');

  // ============================================================
  // SECTION 12: Focus Scope Interaction
  // ============================================================
  print('=== Section 12: Focus Scope Interaction ===');

  final scopeCards = <Widget>[];

  scopeCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: peach50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: coral500.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FocusScope and Intent Resolution',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: coral900,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'PreviousFocusIntent travels through FocusScope boundaries. '
            'When previousFocus() is called, FocusScope determines whether '
            'traversal stays within the scope or escapes to the parent. '
            'Modal dialogs create a FocusScope that traps the intent.',
            style: TextStyle(fontSize: 12.5, color: coral800, height: 1.5),
          ),
        ],
      ),
    ),
  );

  // Visual: nested focus scopes
  Widget buildScopeBox({
    required String label,
    required Color color,
    required bool trapsTraversal,
    required Widget child,
  }) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: trapsTraversal ? 3.0 : 1.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
        color: color.withValues(alpha: 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  label,
                  style: TextStyle(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              if (trapsTraversal) ...[
                SizedBox(width: 6.0),
                Icon(Icons.lock, size: 14.0, color: color),
                SizedBox(width: 2.0),
                Text(
                  'Traps traversal',
                  style: TextStyle(fontSize: 9.0, color: color, fontStyle: FontStyle.italic),
                ),
              ],
            ],
          ),
          SizedBox(height: 8.0),
          child,
        ],
      ),
    );
  }

  scopeCards.add(
    buildScopeBox(
      label: 'Root FocusScope',
      color: Colors.grey.shade600,
      trapsTraversal: false,
      child: Column(
        children: [
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: ['AppBar', 'NavButton'].map((node) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(node, style: TextStyle(fontSize: 10.0)),
              );
            }).toList(),
          ),
          buildScopeBox(
            label: 'Dialog FocusScope',
            color: coral600,
            trapsTraversal: true,
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: ['OK Button', 'Cancel Button', 'Input Field'].map((node) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: coral600.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: coral600.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    node,
                    style: TextStyle(fontSize: 10.0, color: coral800),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),
  );

  print('Created focus scope visualization');

  // ============================================================
  // SECTION 13: Real-World Form Navigation
  // ============================================================
  print('=== Section 13: Form Navigation Scenario ===');

  final formFields = <Map<String, dynamic>>[
    {'label': 'Full Name', 'icon': Icons.person, 'position': 1},
    {'label': 'Email Address', 'icon': Icons.email, 'position': 2},
    {'label': 'Phone Number', 'icon': Icons.phone, 'position': 3},
    {'label': 'Date of Birth', 'icon': Icons.calendar_today, 'position': 4},
    {'label': 'Country', 'icon': Icons.public, 'position': 5},
    {'label': 'Submit', 'icon': Icons.send, 'position': 6},
  ];

  final formWidgets = <Widget>[];

  formWidgets.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: peach50,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        'In a registration form, Shift+Tab (PreviousFocusIntent) lets '
        'users correct previous fields without reaching for the mouse. '
        'Each field is a focusable node in reading order:',
        style: TextStyle(fontSize: 12.0, color: coral800, height: 1.4),
      ),
    ),
  );

  for (var i = 0; i < formFields.length; i++) {
    final field = formFields[i];
    final fieldColor = Color.lerp(coral700, peach400, i / (formFields.length - 1))!;

    formWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: fieldColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: fieldColor.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: fieldColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${field['position']}',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Icon(field['icon'] as IconData, size: 20.0, color: fieldColor),
            SizedBox(width: 8.0),
            Text(
              field['label'] as String,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: coral900,
              ),
            ),
            Spacer(),
            if (i > 0)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_upward, size: 14.0, color: fieldColor.withValues(alpha: 0.6)),
                  Text(
                    ' Shift+Tab',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: fieldColor.withValues(alpha: 0.6),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  print('Created form navigation with ${formFields.length} fields');

  // ============================================================
  // SECTION 14: Diagnostics and Debugging
  // ============================================================
  print('=== Section 14: Diagnostics and Debugging ===');

  final debugCards = <Widget>[];

  debugCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: coral900.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: coral700.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bug_report, size: 24.0, color: coral700),
              SizedBox(width: 10.0),
              Text(
                'Debugging Focus Intents',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: coral900,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            'When PreviousFocusIntent is not working as expected, '
            'use these debugging techniques:',
            style: TextStyle(fontSize: 12.0, color: coral800, height: 1.4),
          ),
        ],
      ),
    ),
  );

  final debugTips = <Map<String, String>>[
    {
      'tip': 'Check Actions.maybeFind',
      'detail': 'Actions.maybeFind<PreviousFocusIntent>(context) '
          'returns null if no action is registered for this intent in the scope.',
    },
    {
      'tip': 'Inspect Focus Tree',
      'detail': 'Use debugDumpFocusTree() to see the complete focus hierarchy '
          'and verify that nodes are in the expected order.',
    },
    {
      'tip': 'Verify FocusTraversalGroup',
      'detail': 'Ensure widgets are inside a FocusTraversalGroup. Without one, '
          'traversal uses the nearest enclosing scope (usually root).',
    },
    {
      'tip': 'Check canRequestFocus',
      'detail': 'FocusNode.canRequestFocus must be true. Disabled widgets '
          'are skipped by the traversal policy.',
    },
  ];

  for (final tip in debugTips) {
    debugCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: peach100,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.tips_and_updates, size: 18.0, color: coral600),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tip['tip']!,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: coral900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    tip['detail']!,
                    style: TextStyle(fontSize: 11.0, color: coral700, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${debugTips.length} debugging tips');

  // ============================================================
  // SECTION 15: Integration Summary
  // ============================================================
  print('=== Section 15: Integration Summary ===');

  final summaryEntries = <Map<String, String>>[
    {'key': 'Class', 'value': 'PreviousFocusIntent extends Intent'},
    {'key': 'Constructor', 'value': 'const PreviousFocusIntent() — zero parameters'},
    {'key': 'Source', 'value': 'Three lines of code. The simplest Intent.'},
    {'key': 'Purpose', 'value': 'Declares desire to move focus backward'},
    {'key': 'Triggered by', 'value': 'Shift+Tab (default) or Actions.invoke()'},
    {'key': 'Handled by', 'value': 'PreviousFocusAction (default in WidgetsApp)'},
    {'key': 'Type matching', 'value': 'Actions widget matches intent.runtimeType to registered Action'},
    {'key': 'Pattern', 'value': 'Intent/Action separation of concerns — WHAT vs HOW'},
  ];

  final summaryRows = <Widget>[];

  for (var i = 0; i < summaryEntries.length; i++) {
    final entry = summaryEntries[i];
    summaryRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: i.isEven ? coral900.withValues(alpha: 0.04) : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90.0,
              child: Text(
                entry['key']!,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: coral900,
                ),
              ),
            ),
            Expanded(
              child: Text(
                entry['value']!,
                style: TextStyle(fontSize: 11.5, color: coral700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${summaryEntries.length} summary entries');
  print('PreviousFocusIntent Deep Demo complete');

  // ============================================================
  // BUILD FINAL LAYOUT
  // ============================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('PreviousFocusIntent Deep Demo'),
        backgroundColor: coral800,
        foregroundColor: Colors.white,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Overview
            ...overviewCards,

            // Section 2: Intent Abstraction Layer
            ...intentLayerCards,

            // Section 3: Family
            Container(
              margin: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Built-in Focus Intent Family',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: coral900),
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

            // Section 4: Const Constructor
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Const Constructor Significance',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: coral900),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ...constCards,
                ],
              ),
            ),

            // Section 5: Separation of Concerns
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Intent vs Action: Separation of Concerns',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: coral900),
                    ),
                  ),
                  ...separationCards,
                ],
              ),
            ),

            // Section 6: Pipeline
            Container(
              margin: EdgeInsets.all(12.0),
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: peach50,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shortcuts → Actions Pipeline',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: coral900),
                  ),
                  SizedBox(height: 12.0),
                  ...pipelineWidgets,
                ],
              ),
            ),

            // Section 7: Parameter Comparison
            ...paramCards,

            // Section 8: Custom Intent
            ...customIntentCards,

            // Section 9: Dispatch
            ...dispatchCards,

            // Section 10: Shortcut Map
            Container(
              margin: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WidgetsApp Default Shortcut Map',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: coral900),
                  ),
                  SizedBox(height: 8.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Column(children: shortcutRows),
                  ),
                ],
              ),
            ),

            // Section 11: Identity
            ...identityCards,

            // Section 12: Focus Scope
            ...scopeCards,

            // Section 13: Form Navigation
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Real-World: Form Navigation',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: coral900),
                    ),
                  ),
                  ...formWidgets,
                ],
              ),
            ),

            // Section 14: Debugging
            ...debugCards,

            // Section 15: Summary
            Container(
              margin: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: coral600.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: coral800,
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

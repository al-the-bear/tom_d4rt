// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// render_indexed_stack_test.dart
// Deep demo: IndexedStack (RenderIndexedStack) widget showcase
// IndexedStack shows only one child at a time from a stack of children.
// The index property controls which child is visible.
// All children maintain their state even when not visible.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderIndexedStack Deep Demo ===');
  print('IndexedStack displays a single child from a list of children.');
  print('The widget at the given index is shown; others are hidden but alive.');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 16),

        // Section 1: Basic index selection
        _buildSectionTitle('1. Basic Index Selection'),
        _buildBasicIndexExamples(context),
        SizedBox(height: 24),

        // Section 2: Alignment values
        _buildSectionTitle('2. Different Alignment Values'),
        _buildAlignmentExamples(context),
        SizedBox(height: 24),

        // Section 3: Sizing behavior
        _buildSectionTitle('3. Sizing Behavior (Largest Child)'),
        _buildSizingBehavior(context),
        SizedBox(height: 24),

        // Section 4: Text direction
        _buildSectionTitle('4. TextDirection Values'),
        _buildTextDirectionExamples(context),
        SizedBox(height: 24),

        // Section 5: Null index
        _buildSectionTitle('5. Null Index (Hide All Children)'),
        _buildNullIndexExample(context),
        SizedBox(height: 24),

        // Section 6: Comparison with Visibility and Offstage
        _buildSectionTitle('6. IndexedStack vs Visibility vs Offstage'),
        _buildComparisonSection(context),
        SizedBox(height: 24),

        // Section 7: Practical patterns
        _buildSectionTitle('7. Practical Patterns'),
        _buildPracticalPatterns(context),
        SizedBox(height: 24),

        // Section 8: State preservation
        _buildSectionTitle('8. State Preservation Demonstration'),
        _buildStatePreservation(context),
        SizedBox(height: 24),

        // Section 9: Nested IndexedStack
        _buildSectionTitle('9. Nested IndexedStack'),
        _buildNestedIndexedStack(context),
        SizedBox(height: 24),

        // Section 10: Decorated children
        _buildSectionTitle('10. Decorated Children Gallery'),
        _buildDecoratedChildren(context),
        SizedBox(height: 32),
      ],
    ),
  );
}

// Header with gradient styling
Widget _buildHeader() {
  print('[header] Building IndexedStack demo header');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF283593), Color(0xFF3949AB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IndexedStack Deep Demo',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'RenderIndexedStack / IndexedStack widget',
          style: TextStyle(fontSize: 14, color: Color(0xFFB0BEC5)),
        ),
        SizedBox(height: 4),
        Text(
          'Shows one child at a time. All children stay alive and maintain state.',
          style: TextStyle(fontSize: 12, color: Color(0xFF90CAF9)),
        ),
      ],
    ),
  );
}

// Section title with gradient accent
Widget _buildSectionTitle(String title) {
  print('[section] $title');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 28,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF42A5F5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A237E),
            ),
          ),
        ),
      ],
    ),
  );
}

// Section 1: Basic index selection showing index 0, 1, 2, 3
Widget _buildBasicIndexExamples(BuildContext context) {
  print('[basic] Building basic index selection examples');

  List<Widget> children = [
    _buildColoredChild('Page A (index 0)', Color(0xFFE53935), Icons.looks_one),
    _buildColoredChild('Page B (index 1)', Color(0xFF43A047), Icons.looks_two),
    _buildColoredChild('Page C (index 2)', Color(0xFF1E88E5), Icons.looks_3),
    _buildColoredChild('Page D (index 3)', Color(0xFFFB8C00), Icons.looks_4),
  ];

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Each row shows IndexedStack at a different index:',
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
        SizedBox(height: 8),

        // Index 0
        _buildIndexLabel('index: 0'),
        Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFBDBDBD)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IndexedStack(index: 0, children: children),
        ),
        SizedBox(height: 8),

        // Index 1
        _buildIndexLabel('index: 1'),
        Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFBDBDBD)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IndexedStack(index: 1, children: children),
        ),
        SizedBox(height: 8),

        // Index 2
        _buildIndexLabel('index: 2'),
        Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFBDBDBD)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IndexedStack(index: 2, children: children),
        ),
        SizedBox(height: 8),

        // Index 3
        _buildIndexLabel('index: 3'),
        Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFBDBDBD)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IndexedStack(index: 3, children: children),
        ),
      ],
    ),
  );
}

Widget _buildColoredChild(String label, Color color, IconData icon) {
  print('[child] Creating colored child: $label');
  return Container(
    width: double.infinity,
    color: color,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildIndexLabel(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF7986CB),
        fontFamily: 'monospace',
      ),
    ),
  );
}

// Section 2: Different alignment values
Widget _buildAlignmentExamples(BuildContext context) {
  print('[alignment] Building alignment examples');

  List<Alignment> alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.center,
    Alignment.bottomLeft,
    Alignment.bottomRight,
  ];

  List<String> alignmentNames = [
    'topLeft',
    'topCenter',
    'topRight',
    'center',
    'bottomLeft',
    'bottomRight',
  ];

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Small child inside large IndexedStack container with different alignments:',
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(alignments.length, (i) {
            print('[alignment] Rendering alignment: ${alignmentNames[i]}');
            return Column(
              children: [
                Text(
                  alignmentNames[i],
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Container(
                  width: 110,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    border: Border.all(color: Color(0xFF9E9E9E)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IndexedStack(
                    index: 0,
                    alignment: alignments[i],
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF3949AB),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        color: Color(0xFFE53935),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    ),
  );
}

// Section 3: Sizing behavior - takes size of largest child
Widget _buildSizingBehavior(BuildContext context) {
  print('[sizing] Building sizing behavior demo');
  print('[sizing] IndexedStack always sizes to the LARGEST child');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IndexedStack sizes itself to the LARGEST child, even when showing a smaller one.',
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Showing small child (index 0) but sized to largest
            Expanded(
              child: Column(
                children: [
                  Text(
                    'index: 0 (small child)',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE53935), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IndexedStack(
                      index: 0,
                      children: [
                        Container(
                          width: 60,
                          height: 40,
                          color: Color(0xFFEF9A9A),
                          child: Center(
                            child: Text(
                              'Small',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                        Container(
                          width: 140,
                          height: 100,
                          color: Color(0xFF90CAF9),
                          child: Center(
                            child: Text(
                              'LARGE',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 70,
                          color: Color(0xFFA5D6A7),
                          child: Center(
                            child: Text(
                              'Medium',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Border shows actual size',
                    style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            // Showing large child (index 1)
            Expanded(
              child: Column(
                children: [
                  Text(
                    'index: 1 (large child)',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF1E88E5), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IndexedStack(
                      index: 1,
                      children: [
                        Container(
                          width: 60,
                          height: 40,
                          color: Color(0xFFEF9A9A),
                          child: Center(
                            child: Text(
                              'Small',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                        Container(
                          width: 140,
                          height: 100,
                          color: Color(0xFF90CAF9),
                          child: Center(
                            child: Text(
                              'LARGE',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 70,
                          color: Color(0xFFA5D6A7),
                          child: Center(
                            child: Text(
                              'Medium',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Same border size!',
                    style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Section 4: TextDirection values
Widget _buildTextDirectionExamples(BuildContext context) {
  print('[textDir] Building textDirection examples');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TextDirection affects alignment resolution for directional alignments:',
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'TextDirection.ltr',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      border: Border.all(color: Color(0xFF66BB6A)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IndexedStack(
                      index: 0,
                      textDirection: TextDirection.ltr,
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF2E7D32),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'LTR Start',
                                style: TextStyle(color: Color(0xFF2E7D32)),
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
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'TextDirection.rtl',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      border: Border.all(color: Color(0xFFEF6C00)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IndexedStack(
                      index: 0,
                      textDirection: TextDirection.rtl,
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_back, color: Color(0xFFE65100)),
                              SizedBox(width: 4),
                              Text(
                                'RTL Start',
                                style: TextStyle(color: Color(0xFFE65100)),
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
          ],
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'AlignmentDirectional.centerStart aligns left in LTR, right in RTL.',
            style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
          ),
        ),
      ],
    ),
  );
}

// Section 5: Null index hides all children
Widget _buildNullIndexExample(BuildContext context) {
  print('[null] Building null index example');
  print('[null] When index is null, no child is displayed');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'When index is null, no children are visible. The stack still occupies space.',
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'index: 0',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF42A5F5), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IndexedStack(
                      index: 0,
                      children: [
                        Container(
                          color: Color(0xFF42A5F5),
                          child: Center(
                            child: Text(
                              'Visible!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(color: Color(0xFFEF5350)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'index: null',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFBDBDBD), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IndexedStack(
                      index: null,
                      children: [
                        Container(
                          color: Color(0xFF42A5F5),
                          child: Center(
                            child: Text(
                              'Visible!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(color: Color(0xFFEF5350)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Note: The container with null index is the same height. Space is still reserved.',
            style: TextStyle(fontSize: 12, color: Color(0xFF388E3C)),
          ),
        ),
      ],
    ),
  );
}

// Section 6: Comparison with Visibility and Offstage
Widget _buildComparisonSection(BuildContext context) {
  print(
    '[compare] Building comparison: IndexedStack vs Visibility vs Offstage',
  );

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Three approaches to conditionally hiding widgets:',
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
        SizedBox(height: 10),

        // IndexedStack approach
        _buildComparisonCard(
          'IndexedStack',
          Color(0xFF1A237E),
          'Shows one child, hides others. All children stay in the tree and keep state.',
          IndexedStack(
            index: 0,
            children: [
              Container(
                height: 40,
                color: Color(0xFF3949AB),
                child: Center(
                  child: Text('Active', style: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                height: 40,
                color: Color(0xFFE0E0E0),
                child: Center(child: Text('Hidden but alive')),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),

        // Visibility approach
        _buildComparisonCard(
          'Visibility',
          Color(0xFF1B5E20),
          'Hides a single widget. Widget stays in the tree. Can show a replacement.',
          Column(
            children: [
              Visibility(
                visible: true,
                child: Container(
                  height: 40,
                  color: Color(0xFF43A047),
                  child: Center(
                    child: Text(
                      'Visible',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: false,
                child: Container(
                  height: 40,
                  color: Color(0xFFE0E0E0),
                  child: Center(child: Text('Invisible')),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),

        // Offstage approach
        _buildComparisonCard(
          'Offstage',
          Color(0xFFBF360C),
          'Removes widget from layout but keeps in the tree. No space reserved.',
          Column(
            children: [
              Offstage(
                offstage: false,
                child: Container(
                  height: 40,
                  color: Color(0xFFE64A19),
                  child: Center(
                    child: Text(
                      'On Stage',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: true,
                child: Container(
                  height: 40,
                  color: Color(0xFFE0E0E0),
                  child: Center(child: Text('Off Stage')),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),

        // Summary table
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFCE93D8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 4),
              Text(
                'IndexedStack: reserves space of LARGEST child, all children keep state',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                'Visibility: can maintain or collapse space, single child focus',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                'Offstage: no space reserved, child still in tree for state',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonCard(
  String title,
  Color color,
  String description,
  Widget child,
) {
  print('[compare] Card: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 128)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
        ),
        SizedBox(height: 8),
        ClipRRect(borderRadius: BorderRadius.circular(6), child: child),
      ],
    ),
  );
}

// Section 7: Practical patterns
Widget _buildPracticalPatterns(BuildContext context) {
  print('[patterns] Building practical pattern examples');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab-style content switching
        _buildPatternCard(
          'Tab-Style Content Switching',
          Icons.tab,
          Color(0xFF0277BD),
          'Use IndexedStack to switch between tab pages while preserving scroll position.',
          _buildTabStyleExample(),
        ),
        SizedBox(height: 12),

        // Step wizard
        _buildPatternCard(
          'Step Wizard / Onboarding',
          Icons.linear_scale,
          Color(0xFF558B2F),
          'IndexedStack for multi-step forms. Each step retains its input data.',
          _buildStepWizardExample(),
        ),
        SizedBox(height: 12),

        // Card flip
        _buildPatternCard(
          'Card Flip / Toggle View',
          Icons.flip,
          Color(0xFF6A1B9A),
          'Switch between front and back views of a card. Both views stay alive.',
          _buildCardFlipExample(),
        ),
      ],
    ),
  );
}

Widget _buildPatternCard(
  String title,
  IconData icon,
  Color color,
  String description,
  Widget example,
) {
  print('[pattern] $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 20), color.withValues(alpha: 8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: color.withValues(alpha: 77)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
        ),
        SizedBox(height: 10),
        example,
      ],
    ),
  );
}

Widget _buildTabStyleExample() {
  print('[tab] Building tab-style content switching example');
  // Simulated tab bar + IndexedStack body at index 1
  return Column(
    children: [
      // Simulated tab bar
      Container(
        decoration: BoxDecoration(
          color: Color(0xFFE1F5FE),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            _buildTabButton('Home', false, Color(0xFF0277BD)),
            _buildTabButton('Search', true, Color(0xFF0277BD)),
            _buildTabButton('Profile', false, Color(0xFF0277BD)),
          ],
        ),
      ),
      SizedBox(height: 6),
      // IndexedStack as tab body
      Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF81D4FA)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: IndexedStack(
          index: 1,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.home, color: Color(0xFF0277BD), size: 24),
                  Text('Home Content', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search, color: Color(0xFF0277BD), size: 24),
                  Text(
                    'Search Content (active)',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, color: Color(0xFF0277BD), size: 24),
                  Text('Profile Content', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildTabButton(String label, bool active, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: active ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : color,
            fontSize: 12,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    ),
  );
}

Widget _buildStepWizardExample() {
  print('[wizard] Building step wizard example at step 1');
  return Column(
    children: [
      // Step indicators
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepDot(1, false, Color(0xFF558B2F)),
          Container(width: 30, height: 2, color: Color(0xFF558B2F)),
          _buildStepDot(2, true, Color(0xFF558B2F)),
          Container(width: 30, height: 2, color: Color(0xFFBDBDBD)),
          _buildStepDot(3, false, Color(0xFFBDBDBD)),
        ],
      ),
      SizedBox(height: 8),
      // Step content
      Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFFF1F8E9),
          borderRadius: BorderRadius.circular(6),
        ),
        child: IndexedStack(
          index: 1,
          children: [
            Center(
              child: Text(
                'Step 1: Enter your name',
                style: TextStyle(fontSize: 13),
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.email, color: Color(0xFF558B2F), size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Step 2: Enter your email (active)',
                    style: TextStyle(fontSize: 13, color: Color(0xFF33691E)),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'Step 3: Confirm details',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildStepDot(int step, bool active, Color color) {
  return Container(
    width: 28,
    height: 28,
    decoration: BoxDecoration(
      color: active ? color : Colors.transparent,
      border: Border.all(color: color, width: 2),
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        '$step',
        style: TextStyle(
          color: active ? Colors.white : color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ),
  );
}

Widget _buildCardFlipExample() {
  print('[flip] Building card flip example showing front face');
  return Container(
    height: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: IndexedStack(
      index: 0,
      children: [
        // Front face
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7B1FA2), Color(0xFF9C27B0)],
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.credit_card, color: Colors.white, size: 24),
                SizedBox(height: 4),
                Text(
                  'Front Face',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
        // Back face
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, color: Color(0xFF6A1B9A), size: 24),
                SizedBox(height: 4),
                Text(
                  'Back Face (details)',
                  style: TextStyle(color: Color(0xFF6A1B9A), fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Section 8: State preservation
Widget _buildStatePreservation(BuildContext context) {
  print('[state] Building state preservation demonstration');
  print('[state] All children in IndexedStack maintain their state');
  print('[state] This is the key advantage over conditional rendering');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All children maintain state even when hidden. This is critical for:',
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
        SizedBox(height: 8),

        // State preservation info cards
        _buildStateInfoCard(
          Icons.text_fields,
          'Form Inputs',
          'Text fields retain entered text when switching tabs.',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 6),
        _buildStateInfoCard(
          Icons.list,
          'Scroll Position',
          'Lists remember their scroll position across tab switches.',
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 6),
        _buildStateInfoCard(
          Icons.animation,
          'Animations',
          'Running animations continue in the background.',
          Color(0xFFE65100),
        ),
        SizedBox(height: 6),
        _buildStateInfoCard(
          Icons.timer,
          'Timers & Streams',
          'Active timers and streams keep running when hidden.',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 12),

        // Visual demo of state preservation
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Demonstration: Switch showing index 2 of 3 children',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(height: 8),
              IndexedStack(
                index: 2,
                children: [
                  _buildStateChild(
                    'Child 0',
                    'Has a counter at value 42',
                    Color(0xFFE53935),
                  ),
                  _buildStateChild(
                    'Child 1',
                    'Has a text input with "Hello"',
                    Color(0xFF43A047),
                  ),
                  _buildStateChild(
                    'Child 2',
                    'Currently visible (active)',
                    Color(0xFF1E88E5),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Children 0 and 1 are invisible but their hypothetical counter/input values are preserved.',
                style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateInfoCard(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 18),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 51)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateChild(String name, String info, Color color) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Text(info, style: TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    ),
  );
}

// Section 9: Nested IndexedStack
Widget _buildNestedIndexedStack(BuildContext context) {
  print('[nested] Building nested IndexedStack example');
  print('[nested] Outer stack at index 1, inner stack at index 0');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IndexedStack can be nested for multi-level navigation:',
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF5C6BC0), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Outer IndexedStack (index: 1)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF283593),
                ),
              ),
              SizedBox(height: 6),
              IndexedStack(
                index: 1,
                children: [
                  // Outer child 0
                  Container(
                    height: 100,
                    color: Color(0xFFFFCDD2),
                    child: Center(child: Text('Outer Page A')),
                  ),
                  // Outer child 1 contains inner IndexedStack
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFFF8A65), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inner IndexedStack (index: 0)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFBF360C),
                          ),
                        ),
                        SizedBox(height: 6),
                        IndexedStack(
                          index: 0,
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFF7043),
                                    Color(0xFFFF8A65),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  'Inner Sub-Page 1 (active)',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              color: Color(0xFFFFAB91),
                              child: Center(child: Text('Inner Sub-Page 2')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Outer child 2
                  Container(
                    height: 100,
                    color: Color(0xFFC8E6C9),
                    child: Center(child: Text('Outer Page C')),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Outer shows child 1 which contains an inner IndexedStack showing sub-page 1.',
          style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
        ),
      ],
    ),
  );
}

// Section 10: Decorated children gallery
Widget _buildDecoratedChildren(BuildContext context) {
  print('[gallery] Building decorated children gallery');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IndexedStack with richly styled children at different indices:',
          style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildGalleryItem(0)),
            SizedBox(width: 8),
            Expanded(child: _buildGalleryItem(1)),
            SizedBox(width: 8),
            Expanded(child: _buildGalleryItem(2)),
          ],
        ),
        SizedBox(height: 12),

        // Full-width decorated IndexedStack
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: IndexedStack(
              index: 0,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF0D47A1),
                        Color(0xFF1565C0),
                        Color(0xFF42A5F5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(Icons.dashboard, color: Colors.white, size: 36),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dashboard View',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Your analytics at a glance',
                              style: TextStyle(
                                color: Color(0xFFBBDEFB),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF1B5E20),
                        Color(0xFF2E7D32),
                        Color(0xFF66BB6A),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Settings View',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFBF360C),
                        Color(0xFFE64A19),
                        Color(0xFFFF7043),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Notifications View',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Footer info
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Takeaways',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 6),
              _buildTakeawayItem(
                'IndexedStack lays out ALL children but paints only one',
              ),
              _buildTakeawayItem('Size is determined by the LARGEST child'),
              _buildTakeawayItem(
                'All children maintain their state (key advantage)',
              ),
              _buildTakeawayItem('Use null index to hide all children'),
              _buildTakeawayItem(
                'alignment and textDirection control child positioning',
              ),
              _buildTakeawayItem(
                'Great for tabs, wizards, and content switching',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildGalleryItem(int showIndex) {
  print('[gallery] Gallery item showing index $showIndex');
  return Column(
    children: [
      Text(
        'idx: $showIndex',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5C6BC0),
        ),
      ),
      SizedBox(height: 4),
      Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFBDBDBD)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: IndexedStack(
            index: showIndex,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE53935), Color(0xFFEF5350)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.favorite, color: Colors.white, size: 28),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.eco, color: Colors.white, size: 28),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.water_drop, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildTakeawayItem(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('  ', style: TextStyle(color: Color(0xFF3949AB), fontSize: 12)),
        Icon(Icons.check_circle_outline, color: Color(0xFF3949AB), size: 14),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Color(0xFF37474F)),
          ),
        ),
      ],
    ),
  );
}

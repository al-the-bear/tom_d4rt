// D4rt test script: Deep Demo for TextAffinity from dart:ui
// TextAffinity specifies cursor affinity at text boundaries
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TextAffinity Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: TextAffinity Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('TextAffinity defines cursor positioning at text position boundaries');
  print('All values: ${TextAffinity.values}');
  print('Count: ${TextAffinity.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Values
  // ═══════════════════════════════════════════════════════════════════════════

  for (final a in TextAffinity.values) {
    print('${a.name}: index=${a.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: downstream
  // ═══════════════════════════════════════════════════════════════════════════

  final downstream = TextAffinity.downstream;
  print('\ndownstream: ${downstream.name}');
  print(
    'The cursor is attached to the trailing edge of the character before it',
  );
  print('Used when cursor at end of line prefers to stay on current line');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: upstream
  // ═══════════════════════════════════════════════════════════════════════════

  final upstream = TextAffinity.upstream;
  print('\nupstream: ${upstream.name}');
  print('The cursor is attached to the leading edge of the character after it');
  print('Used when cursor at start of line prefers to stay on current line');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: TextPosition with Affinity
  // ═══════════════════════════════════════════════════════════════════════════

  final posDownstream = TextPosition(
    offset: 10,
    affinity: TextAffinity.downstream,
  );
  final posUpstream = TextPosition(offset: 10, affinity: TextAffinity.upstream);

  print('\n--- TextPosition with affinity ---');
  print('Position 10 downstream: $posDownstream');
  print('Position 10 upstream: $posUpstream');
  print(
    'Same offset, different affinity: ${posDownstream.offset == posUpstream.offset}',
  );
  print('Equal positions? ${posDownstream == posUpstream}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Switch Patterns
  // ═══════════════════════════════════════════════════════════════════════════

  for (final a in TextAffinity.values) {
    final desc = switch (a) {
      TextAffinity.downstream => 'Cursor after previous character',
      TextAffinity.upstream => 'Cursor before next character',
    };
    print('switch ${a.name}: $desc');
  }

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
              _buildHeader(),
              SizedBox(height: 16),

              // Section 1: Overview
              _buildSectionCard(
                'TextAffinity Overview',
                Icons.text_fields,
                Colors.blue,
                [
                  'TextAffinity specifies cursor affinity at text position boundaries',
                  'Important when cursor position is at a line break or boundary',
                  'Determines which line the cursor visually appears on',
                  'Values: ${TextAffinity.values.length} (downstream, upstream)',
                ],
              ),

              // Section 2: Value Cards
              _buildSectionHeader('ALL VALUES'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildAffinityCard(
                        TextAffinity.downstream,
                        Colors.indigo,
                        'After previous',
                        'Cursor attached to trailing edge\nof preceding character',
                        Icons.arrow_forward,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildAffinityCard(
                        TextAffinity.upstream,
                        Colors.teal,
                        'Before next',
                        'Cursor attached to leading edge\nof following character',
                        Icons.arrow_back,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Section 3: Visual Demonstration
              _buildSectionHeader('VISUAL DEMONSTRATION'),
              _buildVisualDemo(),
              SizedBox(height: 16),

              // Section 4: Line Break Scenario
              _buildSectionHeader('LINE BREAK SCENARIO'),
              _buildLineBreakDemo(),
              SizedBox(height: 16),

              // Section 5: TextPosition Examples
              _buildSectionHeader('TEXTPOSITION WITH AFFINITY'),
              _buildTextPositionDemo(),
              SizedBox(height: 16),

              // Section 6: RTL Example
              _buildSectionHeader('BIDIRECTIONAL TEXT'),
              _buildBidirectionalDemo(),
              SizedBox(height: 16),

              // Section 7: Comparison Table
              _buildSectionHeader('AFFINITY COMPARISON'),
              _buildComparisonTable(),
              SizedBox(height: 16),

              // Section 8: Use Cases
              _buildSectionHeader('USE CASES'),
              _buildUseCasesSection(),
              SizedBox(height: 16),

              // Section 9: Interactive Demo Concept
              _buildSectionHeader('CURSOR POSITION CONCEPT'),
              _buildCursorPositionConceptDemo(),
              SizedBox(height: 32),

              // Footer
              _buildFooter(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildHeader() {
  return Container(
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF3F51B5).withValues(alpha: 0.3),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: EdgeInsets.all(24),
    child: Column(
      children: [
        Icon(Icons.text_rotation_none, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          'TextAffinity',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Cursor Position Affinity at Text Boundaries',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'dart:ui Enum • ${TextAffinity.values.length} Values',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
        letterSpacing: 1.2,
      ),
    ),
  );
}

Widget _buildSectionCard(
  String title,
  IconData icon,
  Color color,
  List<String> points,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: points
                .map(
                  (point) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            point,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAffinityCard(
  TextAffinity affinity,
  Color color,
  String subtitle,
  String description,
  IconData icon,
) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 32),
              SizedBox(height: 8),
              Text(
                affinity.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'index: ${affinity.index}',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildVisualDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Character Position Visualization',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        // Text with character boxes
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 'Hello'.length; i++) ...[
              Container(
                width: 40,
                height: 50,
                decoration: BoxDecoration(
                  color: i == 2
                      ? Colors.blue.withValues(alpha: 0.2)
                      : Colors.grey[100],
                  border: Border.all(color: Colors.grey[400]!),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello'[i],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$i',
                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 16),

        // Downstream explanation
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_forward, color: Colors.indigo),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'downstream: At offset 3, cursor visually after "l" (index 2)',
                  style: TextStyle(fontSize: 13, color: Colors.indigo[700]),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),

        // Upstream explanation
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_back, color: Colors.teal),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'upstream: At offset 3, cursor visually before "l" (index 3)',
                  style: TextStyle(fontSize: 13, color: Colors.teal[700]),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLineBreakDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Line Break Behavior',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'When cursor is at a line break, affinity determines which line it appears on:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),

        // Line 1
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Text('First line ends here', style: TextStyle(fontSize: 14)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 2,
                height: 20,
                color: Colors.indigo,
              ),
              Icon(Icons.arrow_downward, size: 16, color: Colors.indigo),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            '↑ downstream: cursor at end of line 1',
            style: TextStyle(
              fontSize: 11,
              color: Colors.indigo,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 8),

        // Line 2
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_upward, size: 16, color: Colors.teal),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 2,
                height: 20,
                color: Colors.teal,
              ),
              Text('Second line starts here', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            '↑ upstream: cursor at start of line 2',
            style: TextStyle(
              fontSize: 11,
              color: Colors.teal,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 12),

        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber[700], size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Same offset value, but cursor visually appears on different lines',
                  style: TextStyle(fontSize: 12, color: Colors.amber[900]),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTextPositionDemo() {
  final pos1 = TextPosition(offset: 5, affinity: TextAffinity.downstream);
  final pos2 = TextPosition(offset: 5, affinity: TextAffinity.upstream);
  final pos3 = TextPosition(offset: 10, affinity: TextAffinity.downstream);

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TextPosition Objects',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        _buildPositionRow('pos1', 'offset: 5, downstream', pos1, Colors.indigo),
        SizedBox(height: 8),
        _buildPositionRow('pos2', 'offset: 5, upstream', pos2, Colors.teal),
        SizedBox(height: 8),
        _buildPositionRow(
          'pos3',
          'offset: 10, downstream',
          pos3,
          Colors.purple,
        ),

        SizedBox(height: 16),
        Divider(),
        SizedBox(height: 12),

        Text(
          'Equality Comparisons',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),

        _buildComparisonRow('pos1 == pos1', pos1 == pos1),
        _buildComparisonRow('pos1 == pos2', pos1 == pos2),
        _buildComparisonRow(
          'pos1.offset == pos2.offset',
          pos1.offset == pos2.offset,
        ),
        _buildComparisonRow(
          'pos1.affinity == pos2.affinity',
          pos1.affinity == pos2.affinity,
        ),
      ],
    ),
  );
}

Widget _buildPositionRow(
  String name,
  String desc,
  TextPosition pos,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 13, color: Colors.grey[800]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(String comparison, bool result) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(
            comparison,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
              color: Colors.grey[800],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: result ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            result ? 'true' : 'false',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBidirectionalDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bidirectional Text Context',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Affinity is especially important in mixed LTR/RTL text:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),

        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Example: "Hello שָׁלוֹם World"',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                'At boundary between LTR "Hello" and RTL "שָׁלוֹם":\n'
                '• downstream: cursor stays with "Hello" (LTR context)\n'
                '• upstream: cursor attaches to "שָׁלוֹם" (RTL context)',
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonTable() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Property',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'downstream',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.indigo,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'upstream',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildTableRow('Index', '0', '1'),
        _buildTableRow('Cursor edge', 'Trailing', 'Leading'),
        _buildTableRow('Line preference', 'Previous line', 'Next line'),
        _buildTableRow('Default for', 'End of text', 'Start of text'),
      ],
    ),
  );
}

Widget _buildTableRow(String prop, String down, String up) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            prop,
            style: TextStyle(fontSize: 12, color: Colors.grey[800]),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            down,
            style: TextStyle(fontSize: 12, color: Colors.indigo),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(up, style: TextStyle(fontSize: 12, color: Colors.teal)),
        ),
      ],
    ),
  );
}

Widget _buildUseCasesSection() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _buildUseCaseCard(
          'Text Selection',
          'When selecting text across lines, affinity determines selection endpoints',
          Icons.select_all,
          Colors.blue,
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Cursor Navigation',
          'Arrow key navigation at line boundaries respects affinity',
          Icons.keyboard,
          Colors.green,
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'IME Integration',
          'Input method editors use affinity for composing region placement',
          Icons.keyboard_alt,
          Colors.orange,
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Text Rendering',
          'Cursor rendering at soft line breaks depends on affinity',
          Icons.brush,
          Colors.purple,
        ),
      ],
    ),
  );
}

Widget _buildUseCaseCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey[200]!),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCursorPositionConceptDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cursor Position Concept',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        // Visual cursor between characters
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCharBox('A', 0),
            _buildCursorLine(Colors.indigo, 'downstream\n(offset 1)'),
            _buildCharBox('B', 1),
            _buildCursorLine(Colors.teal, 'upstream\n(offset 1)'),
            _buildCharBox('C', 2),
          ],
        ),
        SizedBox(height: 24),

        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Both cursors are at offset 1, but:\n'
            '• downstream cursor is attached to "A"\n'
            '• upstream cursor is attached to "B"\n\n'
            'In most cases they appear identical, but at line breaks '
            'or direction changes, the visual position differs.',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCharBox(String char, int index) {
  return Container(
    width: 50,
    height: 60,
    margin: EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      border: Border.all(color: Colors.grey[400]!),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(char, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(
          'idx $index',
          style: TextStyle(fontSize: 10, color: Colors.grey[500]),
        ),
      ],
    ),
  );
}

Widget _buildCursorLine(Color color, String label) {
  return Column(
    children: [
      Container(
        width: 3,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      SizedBox(height: 4),
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 9, color: color),
      ),
    ],
  );
}

Widget _buildFooter() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'TextAffinity Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          '${TextAffinity.values.length} values: downstream (edge after char) and upstream (edge before char). '
          'Essential for proper cursor positioning at text boundaries, line breaks, and bidirectional text.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    ),
  );
}

// D4rt test script: Deep demo for TextAlign from dart:ui
//
// TextAlign defines how text is aligned horizontally within its container.
// Six values exist:
//   - TextAlign.left — align text to the left edge
//   - TextAlign.right — align text to the right edge
//   - TextAlign.center — center text horizontally
//   - TextAlign.justify — stretch text to fill the width (spaces expanded)
//   - TextAlign.start — align to start based on text direction (LTR→left, RTL→right)
//   - TextAlign.end — align to end based on text direction (LTR→right, RTL→left)
//
// This demo visually demonstrates each alignment mode using Text widgets
// with different background colors to clearly show positioning.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TextAlign Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: ENUM VALUES OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TextAlign Enum Values ---');
  final allAligns = TextAlign.values;
  print('TextAlign.values: $allAligns');
  print('Count: ${allAligns.length}');

  for (final align in allAligns) {
    print(
      '  ${align.name}: index=${align.index}, toString=${align.toString()}',
    );
  }

  // Descriptions for each alignment
  final alignDescriptions = <TextAlign, String>{
    TextAlign.left: 'Text aligned to left edge',
    TextAlign.right: 'Text aligned to right edge',
    TextAlign.center: 'Text centered horizontally',
    TextAlign.justify: 'Text stretched to fill width',
    TextAlign.start: 'Start-aligned (LTR=left, RTL=right)',
    TextAlign.end: 'End-aligned (LTR=right, RTL=left)',
  };

  // Colors for visualization
  final alignColors = <TextAlign, Color>{
    TextAlign.left: const Color(0xFF1565C0),
    TextAlign.right: const Color(0xFF2E7D32),
    TextAlign.center: const Color(0xFF6A1B9A),
    TextAlign.justify: const Color(0xFFC62828),
    TextAlign.start: const Color(0xFFEF6C00),
    TextAlign.end: const Color(0xFF00838F),
  };

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: BASIC ALIGNMENT COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Basic Alignment Comparison ---');

  Widget buildAlignmentRow(TextAlign align, String label, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        textAlign: align,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildBasicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Text Alignment Comparison',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        buildAlignmentRow(
          TextAlign.left,
          'TextAlign.left - Left aligned',
          const Color(0xFF1565C0),
        ),
        buildAlignmentRow(
          TextAlign.center,
          'TextAlign.center - Centered',
          const Color(0xFF6A1B9A),
        ),
        buildAlignmentRow(
          TextAlign.right,
          'TextAlign.right - Right aligned',
          const Color(0xFF2E7D32),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: LEFT ALIGNMENT DEMO
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TextAlign.left Section ---');

  Widget buildLeftDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TextAlign.left — Left Edge Alignment',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Text starts from the left edge of the container.'),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFE3F2FD),
          child: const Text(
            'This text is left-aligned. Notice how it hugs the left side.',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFE3F2FD),
          child: const Text(
            'Short',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFE3F2FD),
          child: const Text(
            'This is a longer piece of text that demonstrates how left alignment works with multiple lines. Each line starts from the left edge, creating a ragged right edge.',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFBBDEFB),
          child: const Text(
            'Use case: Body text, paragraphs, LTR reading flow',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CENTER ALIGNMENT DEMO
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TextAlign.center Section ---');

  Widget buildCenterDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TextAlign.center — Centered Horizontally',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Text is positioned in the middle of the container.'),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFF3E5F5),
          child: const Text(
            'Centered Text',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFF3E5F5),
          child: const Text(
            'Multiple lines of centered text.\nEach line is independently centered.\nNotice the symmetry.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE1BEE7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            children: [
              Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Centered title and subtitle pattern',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF7B1FA2)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFCE93D8),
          child: const Text(
            'Use case: Headlines, titles, dialogs, empty states',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: RIGHT ALIGNMENT DEMO
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TextAlign.right Section ---');

  Widget buildRightDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TextAlign.right — Right Edge Alignment',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Text ends at the right edge of the container.'),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFE8F5E9),
          child: const Text(
            'Right-aligned text',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFE8F5E9),
          child: const Text(
            '\$1,234.56',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Table-like display
        Container(
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFC8E6C9),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(child: Text('Product')),
                  const Expanded(
                    child: Text('Price', textAlign: TextAlign.right),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Expanded(child: Text('Widget A')),
                  const Expanded(
                    child: Text('\$10.00', textAlign: TextAlign.right),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(child: Text('Widget B')),
                  const Expanded(
                    child: Text('\$25.50', textAlign: TextAlign.right),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      '\$35.50',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFA5D6A7),
          child: const Text(
            'Use case: Numbers, prices, dates, table columns',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: JUSTIFY ALIGNMENT DEMO
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TextAlign.justify Section ---');

  Widget buildJustifyDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TextAlign.justify — Full Width Justification',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Text is stretched to fill the entire width (spaces expanded).',
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFFFEBEE),
          child: const Text(
            'This paragraph demonstrates justified text alignment. Notice how the spacing between words is adjusted so that both the left and right edges align perfectly with the container boundaries. This creates a clean, newspaper-like appearance.',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 8),
        // Side by side comparison
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xFFFFCDD2),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Left',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Same text without justify shows ragged right edge.',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xFFEF9A9A),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Justify',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Same text with justify fills the full width evenly.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFE57373),
          child: const Text(
            'Use case: Newspaper columns, formal documents, print layouts',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: START/END ALIGNMENT (DIRECTIONALITY)
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TextAlign.start and TextAlign.end ---');

  Widget buildStartEndDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TextAlign.start / TextAlign.end — Directional',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Alignment adapts based on text direction (LTR vs RTL).'),
        const SizedBox(height: 12),
        // LTR examples
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFFFF3E0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LTR Context (Left-to-Right):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: const Color(0xFFFFE0B2),
                child: const Text(
                  'start = left in LTR',
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: const Color(0xFFB2EBF2),
                child: const Text(
                  'end = right in LTR',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // RTL examples
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFE0F7FA),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RTL Context (Right-to-Left):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: const Color(0xFFFFE0B2),
                child: const Text(
                  'start = right in RTL',
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: const Color(0xFFB2EBF2),
                child: const Text(
                  'end = left in RTL',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFFFCC80),
          child: const Text(
            'Use case: Internationalized apps, bidirectional text support',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: ALL ALIGNMENTS GRID
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- All Alignments Grid ---');

  Widget buildAlignmentsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complete TextAlign Grid',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        ...TextAlign.values.map((align) {
          final color = alignColors[align] ?? Colors.grey;
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: color, width: 4)),
              color: color.withValues(alpha: 0.1),
            ),
            child: Text(
              '${align.name}: ${alignDescriptions[align]}',
              textAlign: align,
              style: TextStyle(color: color),
            ),
          );
        }),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: MULTI-LINE BEHAVIOR
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Multi-Line Behavior ---');

  Widget buildMultiLineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Multi-Line Text Alignment',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xFFE3F2FD),
                child: const Column(
                  children: [
                    Text(
                      'Left',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Line one\nLine two\nLine three',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xFFF3E5F5),
                child: const Column(
                  children: [
                    Text(
                      'Center',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Line one\nLine two\nLine three',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xFFE8F5E9),
                child: const Column(
                  children: [
                    Text(
                      'Right',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Line one\nLine two\nLine three',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: PRACTICAL APPLICATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Practical Applications ---');

  Widget buildPracticalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Practical Applications',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        // Card with mixed alignment
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Card',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'This is a description of the product using left-aligned text for readability.',
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price:', style: TextStyle(fontWeight: FontWeight.w500)),
                  Text(
                    '\$29.99',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Form labels
        const Text(
          'Form Labels:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFF5F5F5),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text('Name:', textAlign: TextAlign.right),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('John Doe'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text('Email:', textAlign: TextAlign.right),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('john@example.com'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Dialog buttons
        const Text(
          'Dialog Pattern:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              const Text(
                'Confirm Action',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Are you sure you want to proceed?',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {}, child: const Text('Cancel')),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: ENUM OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Enum Operations ---');

  final align1 = TextAlign.left;
  final align2 = TextAlign.left;
  final align3 = TextAlign.center;

  print('align1 == align2: ${align1 == align2}');
  print('identical(align1, align2): ${identical(align1, align2)}');
  print('align1 == align3: ${align1 == align3}');
  print('align1.hashCode: ${align1.hashCode}');

  Widget buildEnumOpsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enum Operations',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('left == left: ${align1 == align2}'),
              Text('identical(left, left): ${identical(align1, align2)}'),
              Text('left == center: ${align1 == align3}'),
              const SizedBox(height: 8),
              Text('left.index: ${TextAlign.left.index}'),
              Text('right.index: ${TextAlign.right.index}'),
              Text('center.index: ${TextAlign.center.index}'),
              Text('justify.index: ${TextAlign.justify.index}'),
              Text('start.index: ${TextAlign.start.index}'),
              Text('end.index: ${TextAlign.end.index}'),
              const SizedBox(height: 8),
              Text('left.hashCode: ${align1.hashCode}'),
              Text('center.hashCode: ${align3.hashCode}'),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD VISUAL OUTPUT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Building Visual Output ---');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        const Text(
          'TextAlign Deep Demo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Demonstrates horizontal text alignment options.'),
        const SizedBox(height: 16),

        // Enum overview card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TextAlign Values',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 12),
                ...allAligns.map((align) {
                  final color = alignColors[align] ?? Colors.grey;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          align == TextAlign.left
                              ? Icons.format_align_left
                              : align == TextAlign.right
                              ? Icons.format_align_right
                              : align == TextAlign.center
                              ? Icons.format_align_center
                              : align == TextAlign.justify
                              ? Icons.format_align_justify
                              : Icons.swap_horiz,
                          color: color,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          align.name,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            alignDescriptions[align] ?? '',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Basic section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildBasicSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Left section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildLeftDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Center section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildCenterDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Right section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildRightDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Justify section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildJustifyDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Start/End section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildStartEndDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // All alignments grid
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildAlignmentsGrid(),
          ),
        ),
        const SizedBox(height: 16),

        // Multi-line
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildMultiLineSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Practical applications
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildPracticalSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Enum operations
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildEnumOpsSection(),
          ),
        ),
        const SizedBox(height: 32),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('• TextAlign.left/right: Fixed directional alignment'),
              Text('• TextAlign.center: Horizontally centered'),
              Text('• TextAlign.justify: Full-width with expanded spacing'),
              Text('• TextAlign.start/end: Direction-aware (LTR/RTL)'),
              SizedBox(height: 8),
              Text('Use start/end for internationalized apps.'),
              Text('Use left/right for explicit positioning.'),
            ],
          ),
        ),
      ],
    ),
  );
}

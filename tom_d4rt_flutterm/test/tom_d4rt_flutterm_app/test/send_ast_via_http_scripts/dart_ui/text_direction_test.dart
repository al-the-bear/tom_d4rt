// D4rt test script: Deep demo for TextDirection from dart:ui
//
// TextDirection defines the reading direction of text.
// Two values exist:
//   - TextDirection.ltr — Left-to-Right (English, most European languages)
//   - TextDirection.rtl — Right-to-Left (Arabic, Hebrew, Persian, Urdu)
//
// This affects text alignment, layout direction, and widget positioning.
// This demo visually demonstrates both directions and their effects.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TextDirection Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: ENUM VALUES OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- TextDirection Enum Values ---');
  final allDirections = TextDirection.values;
  print('TextDirection.values: $allDirections');
  print('Count: ${allDirections.length}');

  for (final direction in allDirections) {
    print(
      '  ${direction.name}: index=${direction.index}, toString=${direction.toString()}',
    );
  }

  // Descriptions
  final directionDescriptions = <TextDirection, String>{
    TextDirection.ltr: 'Left-to-Right (English, Spanish, etc.)',
    TextDirection.rtl: 'Right-to-Left (Arabic, Hebrew, etc.)',
  };

  // Colors for visualization
  final directionColors = <TextDirection, Color>{
    TextDirection.ltr: const Color(0xFF1565C0),
    TextDirection.rtl: const Color(0xFF2E7D32),
  };

  // Example languages
  final languageExamples = <TextDirection, List<String>>{
    TextDirection.ltr: [
      'English',
      'Spanish',
      'French',
      'German',
      'Chinese',
      'Japanese',
    ],
    TextDirection.rtl: [
      'Arabic',
      'Hebrew',
      'Persian',
      'Urdu',
      'Pashto',
      'Sindhi',
    ],
  };

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: BASIC DIRECTION COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Basic Direction Comparison ---');

  Widget buildBasicComparison() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Direction Comparison',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        // LTR
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            border: Border.all(color: const Color(0xFF1565C0)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF1565C0),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'LTR: Text flows left to right →',
                  style: TextStyle(color: Color(0xFF1565C0)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        // RTL
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            border: Border.all(color: const Color(0xFF2E7D32)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF2E7D32),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'RTL: Text flows right to left ←',
                  style: TextStyle(color: Color(0xFF2E7D32)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: TEXT ALIGNMENT EFFECTS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Text Alignment Effects ---');

  Widget buildAlignmentEffects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TextAlign.start and TextAlign.end Behavior',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('start/end adapt to text direction:'),
        const SizedBox(height: 12),
        // Headers
        Row(
          children: const [
            Expanded(
              child: Text(
                'LTR',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                'RTL',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // TextAlign.start
        Row(
          children: [
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFFE3F2FD),
                  child: const Text('start', textAlign: TextAlign.start),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFFE8F5E9),
                  child: const Text('start', textAlign: TextAlign.start),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // TextAlign.end
        Row(
          children: [
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFFBBDEFB),
                  child: const Text('end', textAlign: TextAlign.end),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFFC8E6C9),
                  child: const Text('end', textAlign: TextAlign.end),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ROW LAYOUT DIRECTION
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Row Layout Direction ---');

  Widget buildRowLayoutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Row Children Order',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Row children layout direction changes with TextDirection:'),
        const SizedBox(height: 12),
        // LTR Row
        const Text('LTR Row:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFFE3F2FD),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 40,
                  color: const Color(0xFF1565C0),
                  child: const Center(
                    child: Text('1', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 50,
                  height: 40,
                  color: const Color(0xFF1976D2),
                  child: const Center(
                    child: Text('2', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 50,
                  height: 40,
                  color: const Color(0xFF1E88E5),
                  child: const Center(
                    child: Text('3', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 50,
                  height: 40,
                  color: const Color(0xFF42A5F5),
                  child: const Center(
                    child: Text('4', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        // RTL Row
        const Text('RTL Row:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFFE8F5E9),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 40,
                  color: const Color(0xFF2E7D32),
                  child: const Center(
                    child: Text('1', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 50,
                  height: 40,
                  color: const Color(0xFF388E3C),
                  child: const Center(
                    child: Text('2', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 50,
                  height: 40,
                  color: const Color(0xFF43A047),
                  child: const Center(
                    child: Text('3', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 50,
                  height: 40,
                  color: const Color(0xFF66BB6A),
                  child: const Center(
                    child: Text('4', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFFFF9C4),
          child: const Text(
            'Notice: Same children [1,2,3,4] appear in reverse order for RTL',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: ICON POSITIONING
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Icon Positioning ---');

  Widget buildIconPositioning() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Icon/Button Positioning',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Leading and trailing icons adapt to direction:'),
        const SizedBox(height: 12),
        // LTR list items
        const Text('LTR List:', style: TextStyle(fontWeight: FontWeight.w500)),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Documents'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Photos'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // RTL list items
        const Text('RTL List:', style: TextStyle(fontWeight: FontWeight.w500)),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Documents'),
                trailing: const Icon(Icons.chevron_left),
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Photos'),
                trailing: const Icon(Icons.chevron_left),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: PADDING AND MARGINS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Padding and Margins ---');

  Widget buildPaddingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'EdgeInsetsDirectional',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'EdgeInsetsDirectional uses start/end instead of left/right:',
        ),
        const SizedBox(height: 12),
        // LTR
        const Text(
          'LTR with start padding:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.only(start: 40),
            color: const Color(0xFFE3F2FD),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0xFF1565C0),
              child: const Text(
                'Content',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // RTL
        const Text(
          'RTL with start padding:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.only(start: 40),
            color: const Color(0xFFE8F5E9),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0xFF2E7D32),
              child: const Text(
                'Content',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFFFF9C4),
          child: const Text(
            'start=40 applies to left in LTR, right in RTL',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: BIDIRECTIONAL TEXT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Bidirectional Text ---');

  Widget buildBidiSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bidirectional Text (Bidi)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Text containing both LTR and RTL scripts:'),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFF3E5F5),
          child: const Text(
            'English text مع بعض العربية together',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFE1BEE7),
          child: const Text(
            'Numbers 123 in RTL context أرقام',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 8),
        // Explicit direction
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFE8F5E9),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: const Text(
              'مرحبا Hello World',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFCE93D8),
          child: const Text(
            'Unicode Bidi algorithm handles mixed scripts automatically',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: LANGUAGE EXAMPLES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Language Examples ---');

  Widget buildLanguageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Languages by Direction',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        // LTR Languages
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF1565C0),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'LTR Languages',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: (languageExamples[TextDirection.ltr] ?? []).map((
                  lang,
                ) {
                  return Chip(
                    label: Text(lang, style: const TextStyle(fontSize: 12)),
                    backgroundColor: const Color(0xFFBBDEFB),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // RTL Languages
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF2E7D32),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'RTL Languages',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: (languageExamples[TextDirection.rtl] ?? []).map((
                  lang,
                ) {
                  return Chip(
                    label: Text(lang, style: const TextStyle(fontSize: 12)),
                    backgroundColor: const Color(0xFFC8E6C9),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: APP BAR LAYOUT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- App Bar Layout ---');

  Widget buildAppBarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'App Bar with Direction',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        // LTR App Bar
        const Text(
          'LTR App Bar:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu, color: Colors.white),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'My App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.search, color: Colors.white),
                const SizedBox(width: 8),
                const Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // RTL App Bar
        const Text(
          'RTL App Bar:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2E7D32), Color(0xFF388E3C)],
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu, color: Colors.white),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'تطبيقي',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.search, color: Colors.white),
                const SizedBox(width: 8),
                const Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: FORM FIELDS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Form Fields ---');

  Widget buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Form Field Direction',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LTR form
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: const Color(0xFFE3F2FD),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LTR Form',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name',
                            icon: Icon(Icons.person),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // RTL form
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: const Color(0xFFE8F5E9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RTL Form',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'الاسم',
                            icon: Icon(Icons.person),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: ENUM OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Enum Operations ---');

  final dir1 = TextDirection.ltr;
  final dir2 = TextDirection.ltr;
  final dir3 = TextDirection.rtl;

  print('dir1 == dir2: ${dir1 == dir2}');
  print('identical(dir1, dir2): ${identical(dir1, dir2)}');
  print('dir1 == dir3: ${dir1 == dir3}');
  print('dir1.hashCode: ${dir1.hashCode}');

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
              Text('ltr == ltr: ${dir1 == dir2}'),
              Text('identical(ltr, ltr): ${identical(dir1, dir2)}'),
              Text('ltr == rtl: ${dir1 == dir3}'),
              const SizedBox(height: 8),
              Text('ltr.index: ${TextDirection.ltr.index}'),
              Text('rtl.index: ${TextDirection.rtl.index}'),
              const SizedBox(height: 8),
              Text('ltr.hashCode: ${dir1.hashCode}'),
              Text('rtl.hashCode: ${dir3.hashCode}'),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: PRACTICAL APPLICATION
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Practical Application ---');

  Widget buildPracticalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Internationalization (i18n) Best Practices',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFFB300)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '✓ Do:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 4),
              Text('• Use TextAlign.start/end instead of left/right'),
              Text('• Use EdgeInsetsDirectional instead of EdgeInsets'),
              Text('• Use leading/trailing instead of left/right in widgets'),
              Text('• Test your app with both LTR and RTL locales'),
              SizedBox(height: 12),
              Text(
                '✗ Avoid:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC62828),
                ),
              ),
              SizedBox(height: 4),
              Text('• Hardcoding left/right positioning'),
              Text('• Using directional icons without mirroring'),
              Text('• Assuming all users read left-to-right'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFE0F2F1),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Getting TextDirection:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Directionality.of(context)',
                style: TextStyle(fontFamily: 'monospace'),
              ),
              Text(
                'Directionality.maybeOf(context)',
                style: TextStyle(fontFamily: 'monospace'),
              ),
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
          'TextDirection Deep Demo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Demonstrates text and layout direction for internationalization.',
        ),
        const SizedBox(height: 16),

        // Enum overview card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TextDirection Values',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 12),
                ...allDirections.map((dir) {
                  final color = directionColors[dir] ?? Colors.grey;
                  final icon = dir == TextDirection.ltr
                      ? Icons.arrow_forward
                      : Icons.arrow_back;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(icon, color: color, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          dir.name.toUpperCase(),
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            directionDescriptions[dir] ?? '',
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

        // Basic comparison
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildBasicComparison(),
          ),
        ),
        const SizedBox(height: 16),

        // Alignment effects
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildAlignmentEffects(),
          ),
        ),
        const SizedBox(height: 16),

        // Row layout
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildRowLayoutSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Icon positioning
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildIconPositioning(),
          ),
        ),
        const SizedBox(height: 16),

        // Padding section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildPaddingSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Bidi section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildBidiSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Language examples
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildLanguageSection(),
          ),
        ),
        const SizedBox(height: 16),

        // App bar section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildAppBarSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Form section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildFormSection(),
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
        const SizedBox(height: 16),

        // Practical section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildPracticalSection(),
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
              Text('• TextDirection.ltr: Left-to-Right reading'),
              Text('• TextDirection.rtl: Right-to-Left reading'),
              SizedBox(height: 8),
              Text('Affects:'),
              Text('  - Row/Wrap children order'),
              Text('  - TextAlign.start/end interpretation'),
              Text('  - EdgeInsetsDirectional resolution'),
              Text('  - Leading/trailing widget positioning'),
            ],
          ),
        ),
      ],
    ),
  );
}

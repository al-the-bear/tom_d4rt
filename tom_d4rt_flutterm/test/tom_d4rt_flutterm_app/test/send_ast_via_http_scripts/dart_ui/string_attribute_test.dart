// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for StringAttribute from dart:ui
// StringAttribute is the base class for text attributes like SpellOut and Locale
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS - Global scope for D4rt compatibility
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade700, Colors.indigo.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.text_fields, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        const Text(
          'StringAttribute',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Text Accessibility Attributes from dart:ui',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    ),
  );
}

Widget _buildClassHierarchy() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.indigo.shade700),
            const SizedBox(width: 8),
            const Text(
              'Class Hierarchy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        const Center(
          child: Column(
            children: [
              _HierarchyNode(
                name: 'StringAttribute',
                description: 'Abstract base class',
                isAbstract: true,
              ),
              _HierarchyConnector(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _HierarchyNode(
                    name: 'SpellOutStringAttribute',
                    description: 'Characters spelled individually',
                    isAbstract: false,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 16),
                  _HierarchyNode(
                    name: 'LocaleStringAttribute',
                    description: 'Specifies text locale',
                    isAbstract: false,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _HierarchyNode extends StatelessWidget {
  final String name;
  final String description;
  final bool isAbstract;
  final Color? color;

  const _HierarchyNode({
    required this.name,
    required this.description,
    required this.isAbstract,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final nodeColor = color ?? Colors.indigo;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: nodeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: nodeColor.withValues(alpha: 0.5),
          width: isAbstract ? 2 : 1,
          style: isAbstract ? BorderStyle.solid : BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontStyle: isAbstract ? FontStyle.italic : FontStyle.normal,
              color: nodeColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _HierarchyConnector extends StatelessWidget {
  const _HierarchyConnector();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Column(
        children: [
          Container(width: 2, height: 12, color: Colors.grey.shade400),
          Icon(Icons.arrow_drop_down, color: Colors.grey.shade400, size: 16),
        ],
      ),
    );
  }
}

Widget _buildSpellOutDemo(ui.SpellOutStringAttribute attr) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.record_voice_over, color: Colors.blue.shade700),
            const SizedBox(width: 8),
            const Text(
              'SpellOutStringAttribute',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPropertyRow('range.start', '${attr.range.start}'),
              _buildPropertyRow('range.end', '${attr.range.end}'),
              _buildPropertyRow(
                'range.isNormalized',
                '${attr.range.isNormalized}',
              ),
              _buildPropertyRow(
                'range.isCollapsed',
                '${attr.range.isCollapsed}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.accessibility, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Screen readers will spell out characters individually: '
                  '"H-E-L-L-O" instead of "Hello"',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildCodeExample(
          'SpellOutStringAttribute(\n'
          '  range: TextRange(start: 0, end: 5),\n'
          ')',
        ),
        const SizedBox(height: 12),
        _buildUseCaseSection('Use Cases', Colors.blue, [
          'Acronyms (NASA → N-A-S-A)',
          'Serial numbers (AB123 → A-B-1-2-3)',
          'Important codes or identifiers',
          'Non-word abbreviations',
        ]),
      ],
    ),
  );
}

Widget _buildLocaleDemo(ui.LocaleStringAttribute attr) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.translate, color: Colors.green.shade700),
            const SizedBox(width: 8),
            const Text(
              'LocaleStringAttribute',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPropertyRow('range.start', '${attr.range.start}'),
              _buildPropertyRow('range.end', '${attr.range.end}'),
              _buildPropertyRow('locale', '${attr.locale}'),
              _buildPropertyRow(
                'locale.languageCode',
                attr.locale.languageCode,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.language, color: Colors.green.shade700),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Screen readers will use the specified locale for pronunciation, '
                  'helpful for multilingual text.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildCodeExample(
          'LocaleStringAttribute(\n'
          '  range: TextRange(start: 5, end: 10),\n'
          '  locale: Locale(\'fr\'),\n'
          ')',
        ),
        const SizedBox(height: 12),
        _buildUseCaseSection('Use Cases', Colors.green, [
          'Foreign words in text',
          'Names from different cultures',
          'Multilingual documents',
          'Language-specific pronunciation',
        ]),
      ],
    ),
  );
}

Widget _buildPropertyRow(String name, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeExample(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildUseCaseSection(String title, Color color, List<String> cases) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: color),
      ),
      const SizedBox(height: 8),
      ...cases.map(
        (c) => Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Row(
            children: [
              Icon(Icons.arrow_right, size: 16, color: color),
              const SizedBox(width: 4),
              Expanded(child: Text(c, style: const TextStyle(fontSize: 12))),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildTextRangeDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_snippet, color: Colors.orange.shade700),
            const SizedBox(width: 8),
            const Text(
              'TextRange in StringAttribute',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        const Text('Sample text: "Hello World! Bonjour!"'),
        const SizedBox(height: 16),
        _buildRangeVisualization('Hello World! Bonjour!', [
          _RangeHighlight(0, 5, Colors.blue, 'SpellOut'),
          _RangeHighlight(13, 20, Colors.green, 'Locale: fr'),
        ]),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Range properties:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• start: Beginning of the affected text (inclusive)',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '• end: End of the affected text (exclusive)',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '• isNormalized: start ≤ end',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '• isCollapsed: start == end (empty range)',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _RangeHighlight {
  final int start;
  final int end;
  final Color color;
  final String label;
  _RangeHighlight(this.start, this.end, this.color, this.label);
}

Widget _buildRangeVisualization(String text, List<_RangeHighlight> highlights) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              color: Colors.black,
            ),
            children: _buildHighlightedText(text, highlights),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: highlights
            .map(
              (h) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: h.color.withValues(alpha: 0.3),
                        border: Border.all(color: h.color),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${h.label} [${h.start}:${h.end}]',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    ],
  );
}

List<TextSpan> _buildHighlightedText(
  String text,
  List<_RangeHighlight> highlights,
) {
  final spans = <TextSpan>[];
  var currentIndex = 0;

  // Sort highlights by start position
  final sortedHighlights = [...highlights]
    ..sort((a, b) => a.start.compareTo(b.start));

  for (final h in sortedHighlights) {
    // Add non-highlighted text before this highlight
    if (currentIndex < h.start) {
      spans.add(TextSpan(text: text.substring(currentIndex, h.start)));
    }
    // Add highlighted text
    spans.add(
      TextSpan(
        text: text.substring(h.start, h.end),
        style: TextStyle(
          backgroundColor: h.color.withValues(alpha: 0.3),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    currentIndex = h.end;
  }

  // Add remaining text
  if (currentIndex < text.length) {
    spans.add(TextSpan(text: text.substring(currentIndex)));
  }

  return spans;
}

Widget _buildMultipleAttributesDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: Colors.purple.shade700),
            const SizedBox(width: 8),
            const Text(
              'Multiple Attributes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        const Text(
          'A text can have multiple StringAttribute instances for different ranges:',
          style: TextStyle(fontSize: 13),
        ),
        const SizedBox(height: 12),
        _buildCodeExample(
          'final attributes = [\n'
          '  SpellOutStringAttribute(\n'
          '    range: TextRange(start: 0, end: 4),  // "NASA"\n'
          '  ),\n'
          '  LocaleStringAttribute(\n'
          '    range: TextRange(start: 20, end: 30),\n'
          '    locale: Locale(\'ja\'),  // Japanese text\n'
          '  ),\n'
          '  LocaleStringAttribute(\n'
          '    range: TextRange(start: 35, end: 45),\n'
          '    locale: Locale(\'ar\'),  // Arabic text\n'
          '  ),\n'
          '];',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.info, color: Colors.purple),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Ranges should not overlap. Each range specifies exactly where '
                  'the attribute is applied in the text.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAccessibilitySection() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility_new, color: Colors.teal.shade700),
            const SizedBox(width: 8),
            const Text(
              'Accessibility Impact',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        _buildAccessibilityItem(
          Icons.hearing,
          'Screen Readers',
          'Attributes tell screen readers how to pronounce specific text segments.',
        ),
        const SizedBox(height: 12),
        _buildAccessibilityItem(
          Icons.volume_up,
          'Voice Output',
          'SpellOut makes individual characters spoken, helpful for abbreviations.',
        ),
        const SizedBox(height: 12),
        _buildAccessibilityItem(
          Icons.language,
          'Language Detection',
          'LocaleStringAttribute ensures correct pronunciation for foreign words.',
        ),
        const SizedBox(height: 12),
        _buildAccessibilityItem(
          Icons.text_format,
          'Rich Text Support',
          'Works with attributed strings in text rendering pipelines.',
        ),
      ],
    ),
  );
}

Widget _buildAccessibilityItem(
  IconData icon,
  String title,
  String description,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: Colors.teal.shade700),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildLocaleExamples() {
  final locales = [
    ('en', 'English', 'Hello'),
    ('fr', 'French', 'Bonjour'),
    ('de', 'German', 'Guten Tag'),
    ('es', 'Spanish', 'Hola'),
    ('ja', 'Japanese', 'こんにちは'),
    ('zh', 'Chinese', '你好'),
    ('ar', 'Arabic', 'مرحبا'),
    ('ru', 'Russian', 'Привет'),
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag, color: Colors.indigo.shade700),
            const SizedBox(width: 8),
            const Text(
              'Common Locales',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: locales
              .map(
                (l) => Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Text(
                        l.$1,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade700,
                        ),
                      ),
                      Text(l.$2, style: const TextStyle(fontSize: 10)),
                      Text(l.$3, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== StringAttribute Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: SpellOutStringAttribute
  // ═══════════════════════════════════════════════════════════════════════════

  final spellOut1 = ui.SpellOutStringAttribute(
    range: TextRange(start: 0, end: 5),
  );
  print('SpellOut [0:5]: range=${spellOut1.range}');

  final spellOut2 = ui.SpellOutStringAttribute(
    range: TextRange(start: 10, end: 15),
  );
  print('SpellOut [10:15]: range=${spellOut2.range}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: LocaleStringAttribute
  // ═══════════════════════════════════════════════════════════════════════════

  final locale1 = ui.LocaleStringAttribute(
    range: TextRange(start: 5, end: 12),
    locale: ui.Locale('fr'),
  );
  print('Locale fr [5:12]: range=${locale1.range}, locale=${locale1.locale}');

  final locale2 = ui.LocaleStringAttribute(
    range: TextRange(start: 0, end: 8),
    locale: ui.Locale('de'),
  );
  print('Locale de [0:8]: range=${locale2.range}, locale=${locale2.locale}');

  final locale3 = ui.LocaleStringAttribute(
    range: TextRange(start: 15, end: 25),
    locale: ui.Locale('ja'),
  );
  print('Locale ja [15:25]: range=${locale3.range}, locale=${locale3.locale}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Range properties
  // ═══════════════════════════════════════════════════════════════════════════

  print('Range properties:');
  print('spellOut1.range.isNormalized: ${spellOut1.range.isNormalized}');
  print('spellOut1.range.isCollapsed: ${spellOut1.range.isCollapsed}');
  print('spellOut1.range.start: ${spellOut1.range.start}');
  print('spellOut1.range.end: ${spellOut1.range.end}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Various locales
  // ═══════════════════════════════════════════════════════════════════════════

  final locales = ['en', 'fr', 'de', 'es', 'ja', 'zh', 'ar', 'ru'];
  for (final code in locales) {
    final attr = ui.LocaleStringAttribute(
      range: TextRange(start: 0, end: 10),
      locale: ui.Locale(code),
    );
    print('Locale $code: languageCode=${attr.locale.languageCode}');
  }

  print('=== StringAttribute Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Roboto'),
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('StringAttribute Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),

            _buildClassHierarchy(),
            const SizedBox(height: 20),

            _buildSpellOutDemo(spellOut1),
            const SizedBox(height: 20),

            _buildLocaleDemo(locale1),
            const SizedBox(height: 20),

            _buildTextRangeDemo(),
            const SizedBox(height: 20),

            _buildMultipleAttributesDemo(),
            const SizedBox(height: 20),

            _buildAccessibilitySection(),
            const SizedBox(height: 20),

            _buildLocaleExamples(),
            const SizedBox(height: 32),

            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.indigo.shade700),
                  const SizedBox(width: 8),
                  const Text(
                    'StringAttribute Demo Complete',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

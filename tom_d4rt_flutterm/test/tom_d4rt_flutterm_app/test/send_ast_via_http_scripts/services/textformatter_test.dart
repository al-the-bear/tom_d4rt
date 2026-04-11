// ignore_for_file: avoid_print
// Deep demo: Textformatter — TextInputFormatter system
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Warm Amber / Soft Cream
// ─────────────────────────────────────────────────────────────
const Color _tfAmber = Color(0xFFE65100);
const Color _tfCream = Color(0xFFFFF3E0);
const Color _tfDarkBrown = Color(0xFF3E2723);
const Color _tfMedAmber = Color(0xFFF57C00);
const Color _tfLightAmber = Color(0xFFFFCC80);
const Color _tfWhite = Color(0xFFFFFFFF);
const Color _tfGray = Color(0xFF5D4037);
const Color _tfDarkGray = Color(0xFF4E342E);
const Color _tfAccentTeal = Color(0xFF00695C);
const Color _tfAccentBlue = Color(0xFF1565C0);
const Color _tfAccentRed = Color(0xFFC62828);
const Color _tfAccentGreen = Color(0xFF2E7D32);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _tfSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _tfWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _tfLightAmber, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x1AE65100), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _tfAmber,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _tfWhite, fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _tfLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _tfDarkBrown, fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

Widget _tfBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _tfGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _tfChip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _tfInfoRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(key,
              style: const TextStyle(
                  color: _tfDarkBrown, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: _tfGray, fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _tfDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 1,
    color: _tfLightAmber.withValues(alpha: 0.5),
  );
}

Widget _tfMono(String text, {Color? color}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _tfDarkBrown.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _tfLightAmber.withValues(alpha: 0.4)),
    ),
    child: Text(text,
        style: TextStyle(
            color: color ?? _tfDarkGray,
            fontSize: 11,
            fontFamily: 'monospace',
            height: 1.4)),
  );
}

// ─────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════');
  print('  Textformatter — Deep Demo');
  print('  TextInputFormatter: filtering and transforming input');
  print('═══════════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _tfCream,
      appBarTheme: const AppBarTheme(
        backgroundColor: _tfAmber,
        foregroundColor: _tfWhite,
        elevation: 3,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TextInputFormatter'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _buildBanner(),
            _buildWhatIsIt(),
            _buildFilteringFormatter(),
            _buildLengthLimiting(),
            _buildCustomFormatterAnatomy(),
            _buildFormatEditUpdate(),
            _buildSelectionPreservation(), // problem source
            _buildPhoneFormatter(),
            _buildCreditCardFormatter(),
            _buildCurrencyFormatter(),
            _buildChainedFormatters(),
            _buildSimulatedFormatter(),
            _buildSummary(), 
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 1 — Banner
// ═══════════════════════════════════════════════════════════════
Widget _buildBanner() {
  print('[Section 1] Banner');
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_tfAmber, _tfMedAmber],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x40E65100), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.text_format, size: 52, color: _tfWhite),
        const SizedBox(height: 12),
        const Text('TextInputFormatter',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _tfWhite, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _tfWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Input Filtering · Formatting · Transformation',
            style: TextStyle(color: _tfWhite, fontSize: 11),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            _tfChip('services', _tfWhite),
            _tfChip('text input', _tfWhite),
            _tfChip('formatters', _tfWhite),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 2 — What Is It?
// ═══════════════════════════════════════════════════════════════
Widget _buildWhatIsIt() {
  print('[Section 2] What is TextInputFormatter?');
  return _tfSection('What Is TextInputFormatter?', [
    _tfBody(
      'TextInputFormatter is an abstract class that intercepts and '
      'modifies text as it flows from the platform\'s input method to '
      'Flutter\'s TextEditingController. Every keystroke passes through '
      'all attached formatters before the TextField displays it.',
    ),
    _tfDivider(),
    _tfLabel('How Formatters Fit In'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tfCream,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildFlowNode('User types on keyboard', Icons.keyboard, _tfAmber),
          _buildFlowArrow(),
          _buildFlowNode('Platform sends text change', Icons.phone_android, _tfMedAmber),
          _buildFlowArrow(),
          _buildFlowNode('formatEditUpdate() called', Icons.text_format, _tfAccentTeal),
          _buildFlowArrow(),
          _buildFlowNode('Filtered text → TextField', Icons.text_fields, _tfAccentBlue),
        ],
      ),
    ),
    _tfDivider(),
    _tfLabel('Built-in Formatters'),
    _tfInfoRow('FilteringText...', 'Allow or deny characters by pattern'),
    _tfInfoRow('LengthLimiting...', 'Cap text at a maximum length'),
    _tfBody(
      'You can also create custom formatters for any transformation: '
      'phone numbers, credit cards, currency, dates, and more.',
    ),
  ]);
}

Widget _buildFlowNode(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: _tfWhite,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(label,
            style: TextStyle(
                color: color, fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

Widget _buildFlowArrow() {
  return Container(
    margin: const EdgeInsets.only(left: 24),
    height: 12,
    width: 2,
    color: _tfLightAmber.withValues(alpha: 0.5),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 3 — FilteringTextInputFormatter
// ═══════════════════════════════════════════════════════════════
Widget _buildFilteringFormatter() {
  print('[Section 3] FilteringTextInputFormatter');
  return _tfSection('FilteringTextInputFormatter', [
    _tfBody(
      'Allows or denies characters based on a RegExp pattern. The two '
      'modes are allow (whitelist) and deny (blacklist).',
    ),
    _tfDivider(),
    _tfLabel('Allow Mode — Digits Only'),
    _buildFilterExample(
      'FilteringTextInputFormatter.digitsOnly',
      'User types: "abc123def456"',
      'Result:     "123456"',
      _tfAccentGreen,
    ),
    _tfLabel('Allow Mode — Custom Pattern'),
    _buildFilterExample(
      'FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ]"))',
      'User types: "Hello 123 World!"',
      'Result:     "Hello  World"',
      _tfAccentTeal,
    ),
    _tfLabel('Deny Mode — No Spaces'),
    _buildFilterExample(
      'FilteringTextInputFormatter.deny(RegExp(r"\\s"))',
      'User types: "no spaces here"',
      'Result:     "nospaceshere"',
      _tfAccentBlue,
    ),
    _tfLabel('Deny Mode — No Special Chars'),
    _buildFilterExample(
      'FilteringTextInputFormatter.deny(RegExp(r"[^a-zA-Z0-9]"))',
      'User types: "user@email.com"',
      'Result:     "useremailcom"',
      _tfAmber,
    ),
    _tfDivider(),
    _tfLabel('Replacement String'),
    _tfBody(
      'FilteringTextInputFormatter accepts an optional replacementString '
      'parameter. Denied characters are replaced with this string '
      'instead of being removed:',
    ),
    _buildFilterExample(
      'FilteringTextInputFormatter.deny(\n'
      '  RegExp(r"[0-9]"),\n'
      '  replacementString: "*",\n'
      ')',
      'User types: "PIN: 1234"',
      'Result:     "PIN: ****"',
      _tfAccentRed,
    ),
  ]);
}

Widget _buildFilterExample(
    String formatter, String input, String result, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(formatter,
            style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace')),
        const SizedBox(height: 6),
        Text(input,
            style: const TextStyle(
                color: _tfGray, fontSize: 11, fontFamily: 'monospace')),
        Text(result,
            style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace')),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 4 — LengthLimitingTextInputFormatter
// ═══════════════════════════════════════════════════════════════
Widget _buildLengthLimiting() {
  print('[Section 4] LengthLimitingTextInputFormatter');
  return _tfSection('LengthLimitingTextInputFormatter', [
    _tfBody(
      'Prevents text from exceeding a maximum number of characters. '
      'Handles Unicode correctly by counting grapheme clusters:',
    ),
    _tfDivider(),
    _tfLabel('Basic Usage'),
    _tfMono('LengthLimitingTextInputFormatter(10)'),
    _tfBody('Limits input to 10 characters maximum.'),
    _tfDivider(),
    _tfLabel('Truncation Strategy'),
    _buildTruncationCard('MaxLengthEnforcement.none',
        'No enforcement, max is advisory only',
        _tfGray, false),
    _buildTruncationCard('MaxLengthEnforcement.enforced',
        'Hard limit, extra characters are dropped',
        _tfAccentGreen, true),
    _buildTruncationCard('MaxLengthEnforcement.truncateAfterCompositionEnds',
        'Allows composing to exceed limit temporarily (CJK IME)',
        _tfAccentTeal, true),
    _tfDivider(),
    _tfLabel('Unicode-Aware'),
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _tfCream,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUnicodeRow('Hello 🌍', 7, 'Emoji = 1 grapheme'),
          _buildUnicodeRow('café', 4, 'é = 1 grapheme'),
          _buildUnicodeRow('👨‍👩‍👧‍👦', 1, 'Family = 1 grapheme (ZWJ)'),
          _buildUnicodeRow('한국어', 3, 'Hangul = 3 graphemes'),
        ],
      ),
    ),
  ]);
}

Widget _buildTruncationCard(String name, String desc, Color color, bool active) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: color.withValues(alpha: active ? 0.4 : 0.15),
        width: active ? 1.5 : 1,
      ),
    ),
    child: Row(
      children: [
        Icon(active ? Icons.check_circle : Icons.radio_button_off,
            size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace')),
              Text(desc,
                  style: const TextStyle(color: _tfGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildUnicodeRow(String text, int count, String note) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text('"$text"',
              style: const TextStyle(
                  color: _tfDarkBrown, fontSize: 12, fontFamily: 'monospace')),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _tfAmber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('$count',
              style: const TextStyle(
                  color: _tfAmber, fontSize: 11, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(note,
              style: const TextStyle(color: _tfGray, fontSize: 10)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 5 — Custom Formatter Anatomy
// ═══════════════════════════════════════════════════════════════
Widget _buildCustomFormatterAnatomy() {
  print('[Section 5] Custom formatter anatomy');
  return _tfSection('Custom Formatter Anatomy', [
    _tfBody(
      'To create a custom TextInputFormatter, extend the class and '
      'override formatEditUpdate:',
    ),
    _tfDivider(),
    _tfMono(
      'class UpperCaseFormatter extends TextInputFormatter {\n'
      '  @override\n'
      '  TextEditingValue formatEditUpdate(\n'
      '    TextEditingValue oldValue,\n'
      '    TextEditingValue newValue,\n'
      '  ) {\n'
      '    return TextEditingValue(\n'
      '      text: newValue.text.toUpperCase(),\n'
      '      selection: newValue.selection,\n'
      '      composing: newValue.composing,\n'
      '    );\n'
      '  }\n'
      '}',
    ),
    _tfDivider(),
    _tfLabel('TextEditingValue Fields'),
    _tfInfoRow('text', 'The raw text string'),
    _tfInfoRow('selection', 'Cursor position / selection range'),
    _tfInfoRow('composing', 'IME composing region (partial input)'),
    _tfDivider(),
    _tfLabel('Rules to Follow'),
    _tfBody(
      '1. Always preserve or adjust the selection\n'
      '2. Handle the composing region carefully\n'
      '3. Return the old value to reject the change\n'
      '4. Return the new value unchanged to accept as-is\n'
      '5. Return a modified value to transform',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 6 — formatEditUpdate Deep Dive
// ═══════════════════════════════════════════════════════════════
Widget _buildFormatEditUpdate() {
  print('[Section 6] formatEditUpdate mechanics');
  return _tfSection('formatEditUpdate Mechanics', [
    _tfBody(
      'The formatEditUpdate method receives the old and new values. '
      'It must return a TextEditingValue. Here are common scenarios:',
    ),
    _tfDivider(),
    _buildScenarioCard(
      'Accept as-is',
      'return newValue;',
      'User types "a" → "a" appears',
      _tfAccentGreen,
    ),
    _buildScenarioCard(
      'Reject change',
      'return oldValue;',
      'User types "!" → nothing changes',
      _tfAccentRed,
    ),
    _buildScenarioCard(
      'Transform text',
      'return newValue.copyWith(\n'
      '  text: newValue.text.toUpperCase(),\n'
      ');',
      'User types "hello" → "HELLO" appears',
      _tfAccentTeal,
    ),
    _buildScenarioCard(
      'Insert formatting',
      'return TextEditingValue(\n'
      '  text: formatted,\n'
      '  selection: TextSelection.collapsed(\n'
      '    offset: newCursorPos,\n'
      '  ),\n'
      ');',
      'User types "1234567890" → "(123) 456-7890"',
      _tfAmber,
    ),
    _tfDivider(),
    _tfLabel('Old vs New Value'),
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _tfGray.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('oldValue',
                    style: TextStyle(
                        color: _tfGray, fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _tfBody('Previous TextEditingValue\nbefore the user\'s change'),
                _tfBody('text: "Hell"\noffset: 4'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _tfAmber.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _tfAmber.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('newValue',
                    style: TextStyle(
                        color: _tfAmber, fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _tfBody('Proposed new value\nafter the user\'s change'),
                _tfBody('text: "Hello"\noffset: 5'),
              ],
            ),
          ),
        ),
      ],
    ),
  ]);
}

Widget _buildScenarioCard(
    String title, String code, String effect, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(code,
            style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 10.5,
                fontFamily: 'monospace')),
        const SizedBox(height: 4),
        Text(effect,
            style: const TextStyle(color: _tfGray, fontSize: 11)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 7 — Selection Preservation
// ═══════════════════════════════════════════════════════════════
Widget _buildSelectionPreservation() {
  print('[Section 7] Selection preservation');
  return _tfSection('Selection Preservation', [
    _tfBody(
      'When a formatter modifies the text, it must also update the '
      'selection (cursor position) to match. If the text length changes, '
      'the cursor must be adjusted:',
    ),
    _tfDivider(),
    _tfLabel('Example: Inserting a Dash'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tfCream,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSelectionStep('Before', '1234|', 4, _tfGray),
          _buildSelectionStep('User types "5"', '12345|', 5, _tfMedAmber),
          _buildSelectionStep('Formatter adds "-"', '1234-5|', 6, _tfAmber),
        ],
      ),
    ),
    _tfDivider(),
    _tfLabel('Selection Adjustment Rules'),
    _tfBody(
      '• If you insert characters before the cursor, offset += count\n'
      '• If you remove characters before the cursor, offset -= count\n'
      '• If you replace the entire text, compute new offset from the change\n'
      '• Never set offset > text.length (will crash)\n'
      '• Never set offset < 0 (will crash)',
    ),
    _tfDivider(),
    _tfLabel('Selection vs Range'),
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _tfAccentTeal.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Collapsed',
                    style: TextStyle(color: _tfAccentTeal, fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _tfBody('baseOffset == extentOffset'),
                _buildCursorVisual('Hello|World', 5, 5),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _tfAccentBlue.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Range Selection',
                    style: TextStyle(color: _tfAccentBlue, fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _tfBody('baseOffset != extentOffset'),
                _buildCursorVisual('He[llo Wo]rld', 2, 8),
              ],
            ),
          ),
        ),
      ],
    ),
  ]);
}

Widget _buildSelectionStep(String label, String visual, int offset, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _tfWhite,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(visual,
              style: TextStyle(
                  color: color, fontSize: 12, fontFamily: 'monospace',
                  fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 8),
        Text('offset: $offset',
            style: const TextStyle(color: _tfGray, fontSize: 10)),
      ],
    ),
  );
}

Widget _buildCursorVisual(String text, int base, int extent) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
      children: [
        if (base == extent) ...[
          TextSpan(
              text: text.substring(0, base),
              style: const TextStyle(color: _tfDarkBrown)),
          const TextSpan(
              text: '│',
              style: TextStyle(color: _tfAmber/*, fontWeight: FontWeight.w900*/)),
          // const TextSpan( text: 'schau mer mal'),
          TextSpan(
              text: text.substring(base + 1),
              style: const TextStyle(color: _tfDarkBrown)
              ),
        ] else ...[
          TextSpan(
              text: text,
              style: const TextStyle(color: _tfDarkBrown)),
        ],
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 8 — Phone Number Formatter
// ═══════════════════════════════════════════════════════════════
Widget _buildPhoneFormatter() {
  print('[Section 8] Phone number formatter');
  return _tfSection('Phone Number Formatter', [
    _tfBody(
      'A practical phone number formatter that inserts parentheses, '
      'spaces, and dashes as the user types:',
    ),
    _tfDivider(),
    _tfLabel('Format: (XXX) XXX-XXXX'),
    _buildPhoneStep(0, '', 'Empty'),
    _buildPhoneStep(1, '(1', 'First digit'),
    _buildPhoneStep(3, '(123', 'Area code filling'),
    _buildPhoneStep(4, '(123) 4', 'Area code complete'),
    _buildPhoneStep(6, '(123) 456', 'Prefix filling'),
    _buildPhoneStep(7, '(123) 456-7', 'Dash inserted'),
    _buildPhoneStep(10, '(123) 456-7890', 'Complete'),
    _tfDivider(),
    _tfLabel('Implementation Logic'),
    _tfMono(
      'String format(String digits) {\n'
      '  final d = digits.replaceAll(RegExp(r"\\D"), "");\n'
      '  final buf = StringBuffer();\n'
      '  for (int i = 0; i < d.length && i < 10; i++) {\n'
      '    if (i == 0) buf.write("(");\n'
      '    if (i == 3) buf.write(") ");\n'
      '    if (i == 6) buf.write("-");\n'
      '    buf.write(d[i]);\n'
      '  }\n'
      '  return buf.toString();\n'
      '}',
    ),
    _tfDivider(),
    _tfLabel('Visual Preview'),
    _buildFormattedField('(555) 867-5309', Icons.phone, _tfAccentTeal),
  ]);
}

Widget _buildPhoneStep(int digitCount, String display, String note) {
  return Container(
    margin: const EdgeInsets.only(bottom: 3),
    child: Row(
      children: [
        Container(
          width: 24,
          alignment: Alignment.center,
          child: Text('$digitCount',
              style: const TextStyle(
                  color: _tfAmber, fontSize: 11, fontWeight: FontWeight.w700)),
        ),
        Container(
          width: 130,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: _tfCream,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(display.isEmpty ? '(empty)' : display,
              style: TextStyle(
                  color: display.isEmpty ? _tfGray : _tfDarkBrown,
                  fontSize: 12,
                  fontFamily: 'monospace')),
        ),
        const SizedBox(width: 8),
        Text(note, style: const TextStyle(color: _tfGray, fontSize: 10)),
      ],
    ),
  );
}

Widget _buildFormattedField(String text, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: _tfWhite,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 2),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _tfDarkBrown,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                  letterSpacing: 1.2)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 9 — Credit Card Formatter
// ═══════════════════════════════════════════════════════════════
Widget _buildCreditCardFormatter() {
  print('[Section 9] Credit card formatter');
  return _tfSection('Credit Card Number Formatter', [
    _tfBody(
      'Groups digits into chunks of 4 separated by spaces. Also '
      'detects the card network from the prefix:',
    ),
    _tfDivider(),
    _tfLabel('Format: XXXX XXXX XXXX XXXX'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _tfDarkBrown,
            _tfDarkGray.withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.credit_card, size: 28, color: _tfLightAmber),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _tfAmber.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('VISA',
                    style: TextStyle(
                        color: _tfLightAmber, fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('4532 0123 4567 8901',
              style: TextStyle(
                  color: _tfWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                  letterSpacing: 2)),
          const SizedBox(height: 12),
          const Row(
            children: [
              Text('CARD HOLDER',
                  style: TextStyle(color: _tfLightAmber, fontSize: 8)),
              Spacer(),
              Text('EXPIRES',
                  style: TextStyle(color: _tfLightAmber, fontSize: 8)),
            ],
          ),
          const Row(
            children: [
              Text('J. DOE',
                  style: TextStyle(
                      color: _tfWhite, fontSize: 11, fontWeight: FontWeight.w500)),
              Spacer(),
              Text('12/28',
                  style: TextStyle(
                      color: _tfWhite, fontSize: 11, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    ),
    _tfDivider(),
    _tfLabel('Network Detection'),
    _buildNetworkRow('4xxx', 'Visa', _tfAccentBlue),
    _buildNetworkRow('5[1-5]xx', 'Mastercard', _tfAccentRed),
    _buildNetworkRow('3[47]x', 'Amex (15 digits)', _tfAccentTeal),
    _buildNetworkRow('6011', 'Discover', _tfMedAmber),
    _tfDivider(),
    _tfLabel('Grouping Logic'),
    _tfMono(
      'String group(String digits) {\n'
      '  final buf = StringBuffer();\n'
      '  for (int i = 0; i < digits.length; i++) {\n'
      '    if (i > 0 && i % 4 == 0) buf.write(" ");\n'
      '    buf.write(digits[i]);\n'
      '  }\n'
      '  return buf.toString();\n'
      '}',
    ),
  ]);
}

Widget _buildNetworkRow(String prefix, String name, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 70,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(prefix,
              style: TextStyle(
                  color: color, fontSize: 11, fontFamily: 'monospace',
                  fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 8),
        Text(name,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 10 — Currency Formatter
// ═══════════════════════════════════════════════════════════════
Widget _buildCurrencyFormatter() {
  print('[Section 10] Currency formatter');
  return _tfSection('Currency Formatter', [
    _tfBody(
      'Formats numeric input as currency with thousands separators '
      'and decimal places:',
    ),
    _tfDivider(),
    _tfLabel('Formatting Progression'),
    _buildCurrencyStep('1', '\$1.00'),
    _buildCurrencyStep('12', '\$12.00'),
    _buildCurrencyStep('123', '\$123.00'),
    _buildCurrencyStep('1234', '\$1,234.00'),
    _buildCurrencyStep('12345', '\$12,345.00'),
    _buildCurrencyStep('1234567', '\$1,234,567.00'),
    _buildCurrencyStep('123456789', '\$123,456,789.00'),
    _tfDivider(),
    _tfLabel('Decimal Input Mode'),
    _tfBody(
      'Some implementations work in "cents mode" where digits are '
      'entered right-to-left into the decimal places first:',
    ),
    _buildCurrencyStep('1', '\$0.01'),
    _buildCurrencyStep('12', '\$0.12'),
    _buildCurrencyStep('123', '\$1.23'),
    _buildCurrencyStep('1234', '\$12.34'),
    _buildCurrencyStep('12345', '\$123.45'),
    _tfDivider(),
    _tfLabel('Locale Variations'),
    Row(
      children: [
        Expanded(child: _buildLocaleCard('US', '\$1,234.56', '., separator')),
        const SizedBox(width: 6),
        Expanded(child: _buildLocaleCard('DE', '1.234,56 €', 'Reversed .,€')),
        const SizedBox(width: 6),
        Expanded(child: _buildLocaleCard('JP', '¥1,234', 'No decimals')),
      ],
    ),
  ]);
}

Widget _buildCurrencyStep(String input, String display) {
  return Container(
    margin: const EdgeInsets.only(bottom: 3),
    child: Row(
      children: [
        Container(
          width: 90,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: _tfCream,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('digits: $input',
              style: const TextStyle(
                  color: _tfGray, fontSize: 11, fontFamily: 'monospace')),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward, size: 12, color: _tfMedAmber),
        const SizedBox(width: 8),
        Text(display,
            style: const TextStyle(
                color: _tfAmber,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace')),
      ],
    ),
  );
}

Widget _buildLocaleCard(String locale, String example, String note) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _tfAmber.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(locale,
            style: const TextStyle(
                color: _tfAmber, fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(example,
            style: const TextStyle(
                color: _tfDarkBrown, fontSize: 11, fontFamily: 'monospace')),
        const SizedBox(height: 2),
        Text(note,
            style: const TextStyle(color: _tfGray, fontSize: 9)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 11 — Chained Formatters
// ═══════════════════════════════════════════════════════════════
Widget _buildChainedFormatters() {
  print('[Section 11] Chained formatters');
  return _tfSection('Chained Formatters', [
    _tfBody(
      'Multiple formatters can be chained together in the inputFormatters '
      'list. They execute in order, each receiving the output of the '
      'previous one:',
    ),
    _tfDivider(),
    _tfLabel('Chain Example'),
    _tfMono(
      'TextField(\n'
      '  inputFormatters: [\n'
      '    FilteringTextInputFormatter.digitsOnly,  // 1\n'
      '    LengthLimitingTextInputFormatter(10),     // 2\n'
      '    PhoneNumberFormatter(),                   // 3\n'
      '  ],\n'
      ')',
    ),
    _tfDivider(),
    // Pipeline visualization
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tfCream,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildChainStep(1, 'FilteringTextInputFormatter',
              '"abc123def456" → "123456"', _tfAccentRed),
          _buildChainArrow(),
          _buildChainStep(2, 'LengthLimitingTextInputFormatter',
              '"1234567890123" → "1234567890"', _tfAccentTeal),
          _buildChainArrow(),
          _buildChainStep(3, 'PhoneNumberFormatter',
              '"1234567890" → "(123) 456-7890"', _tfAmber),
        ],
      ),
    ),
    _tfDivider(),
    _tfLabel('Order Matters!'),
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _tfAccentRed.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _tfAccentRed.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber, size: 16, color: _tfAccentRed),
              SizedBox(width: 6),
              Text('Wrong Order',
                  style: TextStyle(color: _tfAccentRed, fontSize: 12,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 4),
          _tfBody(
            'If PhoneFormatter runs before FilteringTextInputFormatter, '
            'the filter will strip the parentheses and dashes that the '
            'phone formatter just added!',
          ),
        ],
      ),
    ),
  ]);
}

Widget _buildChainStep(int num, String name, String example, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _tfWhite,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: _tfWhite, fontSize: 10, fontWeight: FontWeight.w800)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color, fontSize: 11, fontWeight: FontWeight.w600)),
              Text(example,
                  style: const TextStyle(
                      color: _tfGray, fontSize: 10, fontFamily: 'monospace')),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildChainArrow() {
  return Container(
    margin: const EdgeInsets.only(left: 20),
    height: 10,
    width: 2,
    color: _tfLightAmber.withValues(alpha: 0.5),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 12 — Simulated Interactive Formatter
// ═══════════════════════════════════════════════════════════════
Widget _buildSimulatedFormatter() {
  print('[Section 12] Simulated interactive formatter');
  return _tfSection('Simulated Formatter in Action', [
    _tfBody(
      'This UI simulates how a formatter chain processes each keystroke:',
    ),
    _tfDivider(),
    // Simulated input field
    Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _tfCream,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Raw input
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _tfWhite,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _tfGray.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Raw Input',
                    style: TextStyle(color: _tfGray, fontSize: 9)),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'a1b2c3d4e5f6g7h8i9j0',
                          style: TextStyle(
                              color: _tfDarkBrown,
                              fontSize: 14,
                              fontFamily: 'monospace')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Step 1: Filter
          _buildProcessStep('Step 1: digitsOnly',
              'a1b2c3d4e5f6g7h8i9j0', '12345678 90', _tfAccentRed),
          const SizedBox(height: 6),
          // Step 2: Length limit
          _buildProcessStep('Step 2: maxLength(10)',
              '1234567890', '1234567890', _tfAccentTeal),
          const SizedBox(height: 6),
          // Step 3: Phone format
          _buildProcessStep('Step 3: phoneFormat',
              '1234567890', '(123) 456-7890', _tfAmber),
          const SizedBox(height: 10),
          // Final field
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _tfWhite,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _tfAmber, width: 2),
              boxShadow: [
                BoxShadow(
                  color: _tfAmber.withValues(alpha: 0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('TextField Display',
                    style: TextStyle(color: _tfAmber, fontSize: 9,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text('(123) 456-7890',
                    style: TextStyle(
                        color: _tfDarkBrown,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                        letterSpacing: 1)),
              ],
            ),
          ),
        ],
      ),
    ),
  ]);
}

Widget _buildProcessStep(
    String label, String input, String output, Color color) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                color: color, fontSize: 10, fontWeight: FontWeight.w700)),
        const SizedBox(height: 3),
        Row(
          children: [
            Expanded(
              child: Text('"$input"',
                  style: const TextStyle(
                      color: _tfGray, fontSize: 10, fontFamily: 'monospace')),
            ),
            Icon(Icons.arrow_forward, size: 12, color: color),
            Expanded(
              child: Text('"$output"',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: color, fontSize: 10, fontFamily: 'monospace',
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 13 — Summary
// ═══════════════════════════════════════════════════════════════
Widget _buildSummary() {
  print('[Section 13] Summary');
  print('Textformatter deep demo complete.');
  return _tfSection('Summary', [
    _tfBody(
      'TextInputFormatter provides a powerful, composable way to filter '
      'and transform text input. Flutter ships with FilteringTextInputFormatter '
      'and LengthLimitingTextInputFormatter, but custom formatters handle '
      'complex patterns like phone numbers, credit cards, and currencies.',
    ),
    _tfDivider(),
    _tfLabel('Key Takeaways'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tfAmber.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tfBody('✦ formatEditUpdate(old, new) → transformed value'),
          _tfBody('✦ FilteringTextInputFormatter: allow/deny characters'),
          _tfBody('✦ LengthLimitingTextInputFormatter: character limit'),
          _tfBody('✦ Custom formatters: phone, credit card, currency, etc.'),
          _tfBody('✦ Always preserve/adjust cursor selection offset'),
          _tfBody('✦ Handle composing region for IME input'),
          _tfBody('✦ Chain order matters: filter → limit → format'),
          _tfBody('✦ Unicode-aware: count graphemes, not code units'),
        ],
      ),
    ),
    _tfDivider(),
    Wrap(
      children: [
        _tfChip('TextInputFormatter', _tfAmber),
        _tfChip('Filtering', _tfAccentRed),
        _tfChip('LengthLimiting', _tfAccentTeal),
        _tfChip('Custom', _tfAccentBlue),
        _tfChip('Chaining', _tfAccentGreen),
      ],
    ),
  ]);
}

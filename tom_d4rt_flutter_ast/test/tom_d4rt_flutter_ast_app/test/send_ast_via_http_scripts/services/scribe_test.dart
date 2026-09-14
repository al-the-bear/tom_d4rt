// ignore_for_file: avoid_print
// Deep demo: Scribe — platform text input integration mixin
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Deep Plum / Lavender Blush
// ─────────────────────────────────────────────────────────────
const Color _scPlum = Color(0xFF4A148C);
const Color _scLavender = Color(0xFFF3E5F5);
const Color _scDarkPurple = Color(0xFF311B92);
const Color _scMedPurple = Color(0xFF7B1FA2);
const Color _scLightPurple = Color(0xFFCE93D8);
const Color _scWhite = Color(0xFFFFFFFF);
const Color _scGray = Color(0xFF5D4E6D);
const Color _scDarkGray = Color(0xFF1B0A2E);
const Color _scAccentPink = Color(0xFFC2185B);
const Color _scAccentTeal = Color(0xFF00695C);
const Color _scAccentAmber = Color(0xFFF57F17);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _scSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _scWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _scLightPurple, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x1A4A148C), blurRadius: 8, offset: Offset(0, 3)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _scPlum,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _scWhite, fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _scLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _scDarkPurple, fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

Widget _scBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _scGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _scChip(String label, Color color) {
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

Widget _scInfoRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(key,
              style: const TextStyle(
                  color: _scDarkPurple, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: _scGray, fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _scDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 1,
    color: _scLightPurple.withValues(alpha: 0.5),
  );
}

// ─────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════');
  print('  Scribe — Deep Demo');
  print('  Platform text input integration mixin');
  print('═══════════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _scLavender,
      appBarTheme: const AppBarTheme(
        backgroundColor: _scPlum,
        foregroundColor: _scWhite,
        elevation: 3,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Scribe'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _buildBanner(),
            _buildWhatIsIt(),
            _buildScribeVsTextInputClient(),
            _buildTextInputConnection(),
            _buildDeltaBasedUpdates(),
            _buildSelectionHandling(),
            _buildComposingRegion(),
            _buildIMEInteractionLifecycle(),
            _buildAutofillIntegration(),
            _buildMultiLineVsSingleLine(),
            _buildSimulatedTextEditor(),
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
        colors: [_scPlum, _scDarkPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x404A148C), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.edit_note, size: 52, color: _scWhite),
        const SizedBox(height: 12),
        const Text('Scribe',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _scWhite, fontSize: 24, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _scWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Platform Text Input · IME · Delta Updates',
            style: TextStyle(color: _scWhite, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _scChip('services', _scWhite),
            _scChip('TextInput', _scWhite),
            _scChip('mixin', _scWhite),
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
  print('[Section 2] What is Scribe?');
  return _scSection('What Is Scribe?', [
    _scBody(
      'Scribe is a mixin (introduced in Flutter 3.x) that provides '
      'the interface between a widget and the platform\'s text input system. '
      'It replaces and extends the older TextInputClient interface, offering '
      'richer text editing capabilities.',
    ),
    _scDivider(),
    _scLabel('Core Purpose'),
    _scBody(
      'When a widget needs to accept keyboard input from the platform '
      '(soft keyboard on mobile, hardware keyboard text events), it mixes '
      'in Scribe to receive text editing commands: insertions, deletions, '
      'selections, and IME composition updates.',
    ),
    _scDivider(),
    _scLabel('Who Uses Scribe?'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _scLavender,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildUserCard('EditableText', 'The core text editing widget in Flutter. '
              'Uses Scribe to connect to the platform keyboard.',
              Icons.text_fields, _scPlum),
          _buildUserCard('TextField / TextFormField', 'Higher-level widgets that '
              'wrap EditableText. Scribe runs underneath.',
              Icons.input, _scMedPurple),
          _buildUserCard('CupertinoTextField', 'iOS-styled text field. Same '
              'Scribe connection under the hood.',
              Icons.phone_iphone, _scAccentPink),
          _buildUserCard('Custom Text Editors', 'Any widget that needs direct '
              'keyboard input can use Scribe.',
              Icons.code, _scAccentTeal),
        ],
      ),
    ),
  ]);
}

Widget _buildUserCard(String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _scWhite,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 22, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _scGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 3 — Scribe vs TextInputClient Evolution
// ═══════════════════════════════════════════════════════════════
Widget _buildScribeVsTextInputClient() {
  print('[Section 3] Scribe vs TextInputClient');
  return _scSection('Scribe vs TextInputClient', [
    _scBody(
      'Scribe evolved from TextInputClient. Understanding the history '
      'helps explain why Scribe exists:',
    ),
    _scDivider(),
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _scGray.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _scGray.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                const Icon(Icons.history, size: 24, color: _scGray),
                const SizedBox(height: 6),
                const Text('TextInputClient',
                    style: TextStyle(
                        color: _scGray, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                _scBody('Original interface'),
                _scBody('updateEditingValue() — full state replacement'),
                _scBody('performAction() — basic actions'),
                _scBody('No delta support'),
                _scBody('Simple selection model'),
                _scBody('Limited IME integration'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _scPlum.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _scPlum, width: 2),
            ),
            child: Column(
              children: [
                const Icon(Icons.auto_awesome, size: 24, color: _scPlum),
                const SizedBox(height: 6),
                const Text('Scribe ★',
                    style: TextStyle(
                        color: _scPlum, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                _scBody('Modern mixin replacement'),
                _scBody('Delta-based updates (TextEditingDelta)'),
                _scBody('Rich action handling'),
                _scBody('Granular change tracking'),
                _scBody('Advanced selection & composing'),
                _scBody('Full IME lifecycle'),
              ],
            ),
          ),
        ),
      ],
    ),
    _scDivider(),
    _scLabel('Why Mixin Instead of Interface?'),
    _scBody(
      'As a mixin, Scribe provides default implementations for optional '
      'methods. Widgets only override what they need, unlike TextInputClient '
      'which required implementing every method even if unused.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 4 — TextInputConnection
// ═══════════════════════════════════════════════════════════════
Widget _buildTextInputConnection() {
  print('[Section 4] How Scribe connects to TextInput');
  return _scSection('Connecting to the Platform', [
    _scBody(
      'Scribe works with TextInput to establish a connection between '
      'the widget and the platform\'s input system:',
    ),
    _scDivider(),
    // Connection pipeline
    _buildConnectionStep(1, 'Widget requests focus',
        'User taps on the text field, triggering focus acquisition.',
        Icons.touch_app, _scPlum),
    _buildConnectionArrow(),
    _buildConnectionStep(2, 'Attach to TextInput',
        'TextInput.attach(scribeInstance, config) creates a TextInputConnection.',
        Icons.link, _scMedPurple),
    _buildConnectionArrow(),
    _buildConnectionStep(3, 'Show keyboard',
        'connection.show() asks the platform to display the soft keyboard.',
        Icons.keyboard, _scAccentPink),
    _buildConnectionArrow(),
    _buildConnectionStep(4, 'Bidirectional communication',
        'Platform sends text changes → Scribe callbacks fire.\n'
        'Widget sends selection/value → platform updates IME.',
        Icons.swap_horiz, _scAccentTeal),
    _buildConnectionArrow(),
    _buildConnectionStep(5, 'Detach on blur',
        'connection.close() detaches when the widget loses focus.',
        Icons.link_off, _scGray),
    _scDivider(),
    _scLabel('TextInputConfiguration'),
    _scBody(
      'When attaching, a TextInputConfiguration specifies:',
    ),
    _scInfoRow('inputType', 'TextInputType (text, number, email, url, etc.)'),
    _scInfoRow('obscureText', 'Whether input should be masked (passwords)'),
    _scInfoRow('autocorrect', 'Enable/disable autocorrection'),
    _scInfoRow('inputAction', 'What the action button does (done, go, search)'),
    _scInfoRow('keyboardAppearance', 'Light or dark keyboard theme'),
    _scInfoRow('enableDeltaModel', 'Opt into delta-based text updates'),
  ]);
}

Widget _buildConnectionStep(
    int num, String title, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 2),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: _scWhite, fontSize: 13, fontWeight: FontWeight.w800)),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _scGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildConnectionArrow() {
  return Container(
    margin: const EdgeInsets.only(left: 16),
    height: 10,
    width: 2,
    color: _scLightPurple.withValues(alpha: 0.5),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 5 — Delta-Based Updates
// ═══════════════════════════════════════════════════════════════
Widget _buildDeltaBasedUpdates() {
  print('[Section 5] Delta-based text updates');
  return _scSection('Delta-Based Text Updates', [
    _scBody(
      'One of Scribe\'s key improvements is delta-based text updates via '
      'TextEditingDelta. Instead of replacing the entire text value on '
      'every keystroke, only the change is communicated:',
    ),
    _scDivider(),
    _scLabel('Traditional (Full Replacement)'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _scGray.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDeltaExample('Before:', 'Hello Worl|', _scGray),
          const Icon(Icons.arrow_downward, size: 16, color: _scGray),
          _buildDeltaExample('Platform sends:', 'Hello World|', _scAccentPink),
          _scBody('→ Entire string "Hello World" transmitted + cursor position'),
          _scBody('→ Widget must diff old vs new to detect what changed'),
        ],
      ),
    ),
    _scDivider(),
    _scLabel('Delta-Based (Granular)'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _scPlum.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _scPlum.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDeltaExample('Before:', 'Hello Worl|', _scGray),
          const Icon(Icons.arrow_downward, size: 16, color: _scPlum),
          _scBody('Platform sends TextEditingDelta:'),
          Container(
            margin: const EdgeInsets.only(left: 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _scPlum.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _scInfoRow('type', 'TextEditingDeltaInsertion'),
                _scInfoRow('offset', '10 (after "l")'),
                _scInfoRow('text', '"d" (just the inserted char)'),
                _scInfoRow('selection', 'TextSelection(offset: 11)'),
              ],
            ),
          ),
          _scBody('→ Only the change is sent, not the full string'),
          _scBody('→ Undo/redo and change tracking become trivial'),
        ],
      ),
    ),
    _scDivider(),
    _scLabel('Delta Types'),
    _buildDeltaTypeCard('TextEditingDeltaInsertion', 'Text was inserted at a position',
        Icons.add, _scAccentTeal),
    _buildDeltaTypeCard('TextEditingDeltaDeletion', 'Text was deleted from a range',
        Icons.remove, _scAccentPink),
    _buildDeltaTypeCard('TextEditingDeltaReplacement', 'Text range was replaced with new text',
        Icons.find_replace, _scAccentAmber),
    _buildDeltaTypeCard('TextEditingDeltaNonTextUpdate', 'Only selection/composing changed, no text change',
        Icons.select_all, _scMedPurple),
  ]);
}

Widget _buildDeltaExample(String label, String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Text(label,
            style: TextStyle(
                color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(text,
              style: TextStyle(
                  color: color, fontSize: 12, fontFamily: 'monospace')),
        ),
      ],
    ),
  );
}

Widget _buildDeltaTypeCard(String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color, fontSize: 11, fontWeight: FontWeight.w700,
                      fontFamily: 'monospace')),
              Text(desc,
                  style: const TextStyle(color: _scGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 6 — Selection Handling
// ═══════════════════════════════════════════════════════════════
Widget _buildSelectionHandling() {
  print('[Section 6] Selection handling');
  return _scSection('Selection Handling', [
    _scBody(
      'Scribe manages text selection — the cursor position and any '
      'highlighted range of text:',
    ),
    _scDivider(),
    _scLabel('TextSelection Components'),
    _scInfoRow('baseOffset', 'Where the selection started (anchor)'),
    _scInfoRow('extentOffset', 'Where the selection ends (active end)'),
    _scInfoRow('affinity', 'Line affinity for positions at line breaks'),
    _scInfoRow('isDirectional', 'Whether selection direction matters'),
    _scDivider(),
    // Selection visualization
    _scLabel('Selection Scenarios'),
    _buildSelectionVisual('Cursor (no selection)', 'Hello World',
        11, 11, 'base == extent → just a blinking cursor'),
    _buildSelectionVisual('Forward selection', 'Hello World',
        0, 5, 'base < extent → "Hello" selected left-to-right'),
    _buildSelectionVisual('Backward selection', 'Hello World',
        11, 6, 'base > extent → selected right-to-left'),
    _buildSelectionVisual('Full selection', 'Hello World',
        0, 11, 'Select All → entire text highlighted'),
    _scDivider(),
    _scBody(
      'Scribe reports selection changes back to the platform so the IME '
      'can adjust its candidate window position, and the platform can '
      'position selection handles on mobile.',
    ),
  ]);
}

Widget _buildSelectionVisual(
    String title, String text, int base, int extent, String desc) {
  final int start = base < extent ? base : extent;
  final int end = base < extent ? extent : base;
  final bool isCursor = base == extent;

  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _scLavender,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: _scDarkPurple, fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        // Text with selection highlight
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: _scWhite,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _scLightPurple),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  color: _scDarkGray, fontSize: 14, fontFamily: 'monospace'),
              children: [
                if (start > 0)
                  TextSpan(text: text.substring(0, start)),
                if (isCursor)
                  TextSpan(
                    text: '|',
                    style: TextStyle(
                        color: _scPlum.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w900),
                  ),
                if (!isCursor)
                  TextSpan(
                    text: text.substring(start, end),
                    style: TextStyle(
                      backgroundColor: _scPlum.withValues(alpha: 0.2),
                      color: _scPlum,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (end < text.length)
                  TextSpan(text: text.substring(end)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(desc,
            style: const TextStyle(color: _scGray, fontSize: 10.5)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 7 — Composing Region
// ═══════════════════════════════════════════════════════════════
Widget _buildComposingRegion() {
  print('[Section 7] Composing region');
  return _scSection('Composing Region', [
    _scBody(
      'The composing region represents text that\'s currently being '
      'composed by the IME — it hasn\'t been committed yet. This is '
      'shown with an underline in most systems:',
    ),
    _scDivider(),
    // Example: Japanese IME
    _scLabel('Example: Japanese IME Input'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _scLavender,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComposingStep(1, 'User types "nihon"', 'にほん', true,
              'Composing: kana shown with underline'),
          _buildComposingStep(2, 'IME shows candidates', '[日本] にほん 二本',
              true, 'Still composing: candidates displayed'),
          _buildComposingStep(3, 'User selects 日本', '日本', false,
              'Committed: composing region cleared'),
        ],
      ),
    ),
    _scDivider(),
    _scLabel('Composing in TextEditingValue'),
    _scInfoRow('composing.start', 'First character of composing text'),
    _scInfoRow('composing.end', 'Last character of composing text'),
    _scInfoRow('composing.isValid', 'Whether a composing region is active'),
    _scInfoRow('TextRange.empty', 'No active composing (text is committed)'),
    _scDivider(),
    _scLabel('Visual Styling'),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _scWhite,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _scLightPurple),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('I am typing in ',
              style: TextStyle(color: _scDarkGray, fontSize: 14)),
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: _scMedPurple, width: 2),
              ),
            ),
            child: const Text('Toky',
                style: TextStyle(
                    color: _scMedPurple, fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 4),
          const Text('↑ composing region (underlined)',
              style: TextStyle(color: _scGray, fontSize: 10)),
        ],
      ),
    ),
  ]);
}

Widget _buildComposingStep(
    int num, String action, String display, bool composing, String desc) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: composing ? _scMedPurple : _scAccentTeal,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: _scWhite, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(action,
                  style: const TextStyle(
                      color: _scDarkPurple, fontSize: 11, fontWeight: FontWeight.w600)),
              Container(
                margin: const EdgeInsets.only(top: 3),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: _scWhite,
                  borderRadius: BorderRadius.circular(4),
                  border: composing
                      ? const Border(
                          bottom: BorderSide(color: _scMedPurple, width: 2))
                      : Border.all(color: _scAccentTeal.withValues(alpha: 0.3)),
                ),
                child: Text(display,
                    style: TextStyle(
                        color: composing ? _scMedPurple : _scAccentTeal,
                        fontSize: 13)),
              ),
              const SizedBox(height: 2),
              Text(desc,
                  style: const TextStyle(color: _scGray, fontSize: 10)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 8 — IME Interaction Lifecycle
// ═══════════════════════════════════════════════════════════════
Widget _buildIMEInteractionLifecycle() {
  print('[Section 8] IME interaction lifecycle');

  Widget phase(String name, String desc, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        color: color, fontSize: 12, fontWeight: FontWeight.w700)),
                Text(desc,
                    style: const TextStyle(color: _scGray, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _scSection('IME Interaction Lifecycle', [
    _scBody(
      'The full lifecycle of an IME (Input Method Editor) interaction '
      'through Scribe:',
    ),
    _scDivider(),
    phase('connectionDidBecomeActive', 'TextInput connection established, keyboard visible',
        _scPlum, Icons.play_circle),
    phase('showAutocorrectionPromptRect', 'Platform requests rect for autocorrection UI',
        _scMedPurple, Icons.crop_square),
    phase('updateEditingValue / updateEditingValueWithDeltas',
        'Platform sends text changes (full or delta-based)',
        _scAccentTeal, Icons.text_snippet),
    phase('performAction', 'User presses action button (done, go, search, newline)',
        _scAccentAmber, Icons.keyboard_return),
    phase('performPrivateCommand', 'IME sends custom commands (e.g., emoji, stickers)',
        _scAccentPink, Icons.extension),
    phase('updateFloatingCursor', 'Long-press cursor drag on iOS — raw position updates',
        _scDarkPurple, Icons.drag_handle),
    phase('connectionDidClose', 'TextInput connection closed, keyboard hidden',
        _scGray, Icons.stop_circle),
    _scDivider(),
    _scLabel('Callback Priority'),
    _scBody(
      'Delta updates (updateEditingValueWithDeltas) take priority over '
      'full value updates (updateEditingValue) when enableDeltaModel is '
      'true in the TextInputConfiguration. Scribe manages this dispatch.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 9 — Autofill Integration
// ═══════════════════════════════════════════════════════════════
Widget _buildAutofillIntegration() {
  print('[Section 9] Autofill integration');
  return _scSection('Autofill Integration', [
    _scBody(
      'Scribe participates in the autofill system, allowing fields to '
      'receive auto-filled values from the platform\'s password manager '
      'or autofill service:',
    ),
    _scDivider(),
    _scLabel('Autofill Hints'),
    _buildAutofillGroup([
      _buildAutofillField('Username', 'AutofillHints.username',
          Icons.person, _scPlum),
      _buildAutofillField('Email', 'AutofillHints.email',
          Icons.email, _scMedPurple),
      _buildAutofillField('Password', 'AutofillHints.password',
          Icons.lock, _scAccentPink),
      _buildAutofillField('Phone', 'AutofillHints.telephoneNumber',
          Icons.phone, _scAccentTeal),
      _buildAutofillField('Address', 'AutofillHints.streetAddressLine1',
          Icons.home, _scAccentAmber),
      _buildAutofillField('Name', 'AutofillHints.name',
          Icons.badge, _scDarkPurple),
    ]),
    _scDivider(),
    _scLabel('AutofillGroup'),
    _scBody(
      'Multiple Scribe-backed fields are grouped via AutofillGroup. '
      'When the group is submitted (e.g., form submit), '
      'AutofillGroup.of(context).commit() tells the platform to '
      'save the autofill data.',
    ),
    _scDivider(),
    // Simulated autofill prompt
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _scDarkGray.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _scLightPurple),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.security, size: 18, color: _scMedPurple),
              const SizedBox(width: 8),
              const Text('Autofill Suggestion',
                  style: TextStyle(
                      color: _scDarkPurple, fontSize: 12, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _scWhite,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _scPlum.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.account_circle, size: 28, color: _scPlum),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('user@example.com',
                          style: TextStyle(
                              color: _scDarkPurple, fontSize: 13,
                              fontWeight: FontWeight.w600)),
                      const Text('Saved password • Tap to fill',
                          style: TextStyle(color: _scGray, fontSize: 11)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 14, color: _scLightPurple),
              ],
            ),
          ),
        ],
      ),
    ),
  ]);
}

Widget _buildAutofillGroup(List<Widget> fields) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _scLavender,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: _scPlum.withValues(alpha: 0.2),
        style: BorderStyle.solid,
      ),
    ),
    child: Column(children: fields),
  );
}

Widget _buildAutofillField(String label, String hint, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _scWhite,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(label,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.w600)),
        const Spacer(),
        Text(hint,
            style: const TextStyle(
                color: _scGray, fontSize: 10, fontFamily: 'monospace')),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 10 — Multi-Line vs Single-Line
// ═══════════════════════════════════════════════════════════════
Widget _buildMultiLineVsSingleLine() {
  print('[Section 10] Multi-line vs single-line');
  return _scSection('Multi-Line vs Single-Line', [
    _scBody(
      'Scribe handles both single-line and multi-line text input, '
      'affecting how the action button and newline handling work:',
    ),
    _scDivider(),
    Row(
      children: [
        Expanded(
          child: _buildTextFieldSim('Single Line', false, [
            'One line of text',
            'Enter → performs action',
            'TextInputType.text',
            'Action: done/go/search',
          ], _scPlum),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildTextFieldSim('Multi Line', true, [
            'Multiple lines\nof text\nhere',
            'Enter → new line',
            'TextInputType.multiline',
            'Action: newline',
          ], _scAccentTeal),
        ),
      ],
    ),
    _scDivider(),
    _scLabel('Action Button Behavior'),
    _scInfoRow('TextInputAction.done', 'Closes keyboard, submits form'),
    _scInfoRow('TextInputAction.go', 'Navigate/submit (browsers)'),
    _scInfoRow('TextInputAction.search', 'Trigger search'),
    _scInfoRow('TextInputAction.send', 'Send message (chat apps)'),
    _scInfoRow('TextInputAction.next', 'Move focus to next field'),
    _scInfoRow('TextInputAction.newline', 'Insert newline (multi-line)'),
    _scDivider(),
    _scBody(
      'Scribe\'s performAction() callback receives the TextInputAction '
      'when the user presses the keyboard\'s action button. The widget '
      'decides what to do: submit a form, move focus, or insert a newline.',
    ),
  ]);
}

Widget _buildTextFieldSim(
    String title, bool multiLine, List<String> details, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Column(
      children: [
        Text(title,
            style: TextStyle(
                color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        // Simulated field
        Container(
          width: double.infinity,
          height: multiLine ? 60 : 30,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _scWhite,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color),
          ),
          child: Text(multiLine ? 'Line 1\nLine 2\nLine 3' : 'Single line text|',
              style: TextStyle(color: color, fontSize: 10)),
        ),
        const SizedBox(height: 6),
        ...details.map((d) => Text(d,
            style: const TextStyle(color: _scGray, fontSize: 10),
            textAlign: TextAlign.center)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 11 — Simulated Text Editor
// ═══════════════════════════════════════════════════════════════
Widget _buildSimulatedTextEditor() {
  print('[Section 11] Simulated text editor');
  return _scSection('Simulated Text Editor', [
    _scBody(
      'A visual simulation showing different Scribe interaction states '
      'in a text editing context:',
    ),
    _scDivider(),
    // Editor with toolbar
    Container(
      decoration: BoxDecoration(
        color: _scWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _scPlum, width: 2),
        boxShadow: const [
          BoxShadow(color: Color(0x1A4A148C), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          // Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _scPlum.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              border: const Border(
                bottom: BorderSide(color: _scLightPurple),
              ),
            ),
            child: Row(
              children: [
                _buildToolbarButton(Icons.format_bold),
                _buildToolbarButton(Icons.format_italic),
                _buildToolbarButton(Icons.format_underline),
                const SizedBox(width: 8),
                Container(width: 1, height: 20, color: _scLightPurple),
                const SizedBox(width: 8),
                _buildToolbarButton(Icons.format_list_bulleted),
                _buildToolbarButton(Icons.format_list_numbered),
                const Spacer(),
                _buildToolbarButton(Icons.undo),
                _buildToolbarButton(Icons.redo),
              ],
            ),
          ),
          // Editor content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(minHeight: 120),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: _scDarkGray, fontSize: 13, height: 1.6),
                children: [
                  const TextSpan(text: 'The quick '),
                  TextSpan(
                    text: 'brown fox',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      backgroundColor: _scPlum.withValues(alpha: 0.12),
                      color: _scPlum,
                    ),
                  ),
                  const TextSpan(text: ' jumps over the lazy dog.\n\n'),
                  const TextSpan(text: 'Each character typed goes through the '),
                  const TextSpan(
                    text: 'Scribe',
                    style: TextStyle(fontStyle: FontStyle.italic, color: _scMedPurple),
                  ),
                  const TextSpan(text: ' mixin, processed as a TextEditingDelta, '
                      'and rendered by the '),
                  const TextSpan(
                    text: 'EditableText',
                    style: TextStyle(fontStyle: FontStyle.italic, color: _scMedPurple),
                  ),
                  const TextSpan(text: ' widget.\n\n'),
                  const TextSpan(text: 'Currently '),
                  TextSpan(
                    text: 'compo',
                    style: TextStyle(
                      color: _scMedPurple,
                      decoration: TextDecoration.underline,
                      decorationColor: _scMedPurple.withValues(alpha: 0.6),
                      decorationThickness: 2,
                    ),
                  ),
                  TextSpan(
                    text: '|',
                    style: TextStyle(
                        color: _scPlum.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          // Status bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _scPlum.withValues(alpha: 0.04),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
              border: const Border(
                top: BorderSide(color: _scLightPurple),
              ),
            ),
            child: Row(
              children: [
                _scChip('Composing: "compo"', _scMedPurple),
                _scChip('Cursor: 135', _scPlum),
                const Spacer(),
                const Text('Lines: 3 | Words: 28',
                    style: TextStyle(color: _scGray, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    ),
    _scDivider(),
    _scLabel('What Scribe Handles Here'),
    _scBody('• Each keystroke → TextEditingDelta through the mixin'),
    _scBody('• Selection of "brown fox" → TextSelection update to platform'),
    _scBody('• Composing "compo" → composing region underline displayed'),
    _scBody('• Toolbar actions → programmatic TextEditingValue changes'),
    _scBody('• Undo/redo → delta history enables precise reversal'),
  ]);
}

Widget _buildToolbarButton(IconData icon) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2),
    width: 28,
    height: 28,
    decoration: BoxDecoration(
      color: _scWhite,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: _scLightPurple.withValues(alpha: 0.4)),
    ),
    child: Icon(icon, size: 16, color: _scMedPurple),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 12 — Summary
// ═══════════════════════════════════════════════════════════════
Widget _buildSummary() {
  print('[Section 12] Summary');
  print('Scribe deep demo complete.');
  return _scSection('Summary', [
    _scBody(
      'Scribe is the modern text input mixin in Flutter, providing the '
      'bridge between widgets and the platform keyboard/IME system. '
      'It supersedes TextInputClient with delta-based updates, richer '
      'composing region support, and better IME lifecycle management.',
    ),
    _scDivider(),
    _scLabel('Key Takeaways'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _scPlum.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _scBody('✦ Mixin replacement for TextInputClient'),
          _scBody('✦ Delta-based updates via TextEditingDelta'),
          _scBody('✦ Manages selection, composing, and cursor state'),
          _scBody('✦ Full IME lifecycle with composing region tracking'),
          _scBody('✦ Connects via TextInput.attach() ↔ TextInputConnection'),
          _scBody('✦ Autofill integration through AutofillGroup'),
          _scBody('✦ Handles both single-line and multi-line input'),
          _scBody('✦ Used by EditableText, TextField, CupertinoTextField'),
        ],
      ),
    ),
    _scDivider(),
    Wrap(
      children: [
        _scChip('Scribe', _scPlum),
        _scChip('TextEditingDelta', _scMedPurple),
        _scChip('TextInputConnection', _scAccentTeal),
        _scChip('IME', _scAccentPink),
        _scChip('Autofill', _scAccentAmber),
      ],
    ),
  ]);
}

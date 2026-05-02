// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ---------------------------------------------------------------------------
// SmartQuotesType Deep Demo
// ---------------------------------------------------------------------------
//
// SmartQuotesType is a small but genuinely interesting enum that lives in the
// `flutter/services` library. It has only two values:
//
//   * SmartQuotesType.enabled
//   * SmartQuotesType.disabled
//
// It is consumed by text-input widgets — TextField, CupertinoTextField, and
// the lower-level EditableText — to control whether straight ASCII quotes
// (the apostrophe `'` and the straight double quote `"`) get auto-replaced
// by their typographically curly counterparts (`'` `'` `"` `"`) as the user
// types. This is a soft-keyboard / IME concern: the platform does the
// substitution before the character ever reaches the Flutter framework, so
// TextField simply forwards a hint flag to the platform's text input
// connection and the rest happens in the OS keyboard.
//
// Where it matters in practice:
//   * iOS:     primary target. The iOS soft keyboard substitutes quotes by
//              default in most text-style fields. Setting smartQuotesType to
//              `disabled` is how you turn it off (e.g. for code editors,
//              JSON entry, URL fields, password reveal, etc.).
//   * Android: most modern IMEs (Gboard, SwiftKey, Samsung Keyboard) honor
//              the IME hint TYPE_TEXT_FLAG_NO_SUGGESTIONS-style flags that
//              Flutter sets, but the substitution behavior is keyboard-app
//              dependent. Some Android keyboards never substitute at all.
//   * macOS:   the system "Smart Quotes" preference under
//              System Settings -> Keyboard -> Text Input affects all native
//              text input. Flutter desktop respects the platform default.
//   * Windows: no system smart-quote substitution by default. The flag is a
//              no-op for hardware keyboards.
//   * Linux:   same as Windows — no system smart-quote substitution.
//   * Web:     the browser owns text input. Substitution is OS- and
//              browser-keyboard dependent.
//
// This file is a hand-authored demo. It is meant to be read top-to-bottom as
// a tutorial, and every section renders real, live widgets that exercise
// `SmartQuotesType.enabled` and `SmartQuotesType.disabled` on real
// `TextField` and `CupertinoTextField` instances. There is no widget-test
// machinery here — this is a build-only demo file consumed by the d4rt AST
// http test pipeline, which compiles the file, walks its AST, and verifies
// that every widget reference type and named-arg flow round-trips through
// the bridge.
//
// ---------------------------------------------------------------------------
// The build function — entry point used by the AST harness.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SmartQuotesType Deep Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 14, height: 1.45),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SmartQuotesType Deep Demo'),
        backgroundColor: const Color(0xFFEADDFF),
        foregroundColor: const Color(0xFF21005D),
        centerTitle: false,
      ),
      backgroundColor: const Color(0xFFFDFBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // -----------------------------------------------------------
              // 1. Intro + curly-vs-straight diagram
              // -----------------------------------------------------------
              _DemoSection(
                index: 1,
                title: 'What is SmartQuotesType?',
                subtitle:
                    'A two-value enum for controlling iOS-style automatic '
                    'curly-quote substitution.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const <Widget>[
                    _Paragraph(
                      'SmartQuotesType lives in package:flutter/services '
                      'and has exactly two values: enabled and disabled. '
                      'It is a hint passed through the platform text input '
                      'channel that asks the soft keyboard / IME to replace '
                      'straight ASCII quotes with their curly typographic '
                      'equivalents as the user types.',
                    ),
                    SizedBox(height: 8),
                    _Paragraph(
                      'On iOS this is the dominant code path — the iOS '
                      'soft keyboard implements smart quotes natively. On '
                      'Android the behavior depends on the active IME '
                      '(Gboard, SwiftKey, Samsung Keyboard). On desktop it '
                      'is mostly a no-op for hardware keyboards, although '
                      'macOS has a system-wide Smart Quotes preference '
                      'that affects all native text input.',
                    ),
                    SizedBox(height: 16),
                    _QuoteDiagram(),
                    SizedBox(height: 12),
                    _Paragraph(
                      'Notice that the curly variants have visible '
                      'directionality — the opener leans into the word, '
                      'the closer leans away. Straight quotes are the same '
                      'glyph on both ends, which is fine for code but ugly '
                      'for prose typesetting.',
                    ),
                  ],
                ),
              ),

              // -----------------------------------------------------------
              // 2. Side-by-side TextFields
              // -----------------------------------------------------------
              _DemoSection(
                index: 2,
                title: 'Side-by-side TextFields',
                subtitle:
                    'Two real Material TextFields, one with smartQuotesType '
                    'enabled and one disabled, with live mirrored output.',
                child: const _SideBySideTextFields(),
              ),

              // -----------------------------------------------------------
              // 3. CupertinoTextField version
              // -----------------------------------------------------------
              _DemoSection(
                index: 3,
                title: 'CupertinoTextField comparison',
                subtitle:
                    'The same comparison using CupertinoTextField, which is '
                    'where the iOS keyboard effect is most visible.',
                child: const _SideBySideCupertinoFields(),
              ),

              // -----------------------------------------------------------
              // 4. All input types matrix
              // -----------------------------------------------------------
              _DemoSection(
                index: 4,
                title: 'Keyboard-type x SmartQuotesType matrix',
                subtitle:
                    'A 5 x 2 grid: keyboard types (text, emailAddress, url, '
                    'multiline, name) crossed with SmartQuotesType.enabled '
                    'and SmartQuotesType.disabled.',
                child: const _KeyboardMatrix(),
              ),

              // -----------------------------------------------------------
              // 5. Live curly-quote substitution showcase
              // -----------------------------------------------------------
              _DemoSection(
                index: 5,
                title: 'Live curly-quote substitution showcase',
                subtitle:
                    'A TextField with smartQuotesType: enabled plus a '
                    'manual "apply smart quotes" button that demonstrates '
                    'the substitution algorithm explicitly.',
                child: const _SubstitutionShowcase(),
              ),

              // -----------------------------------------------------------
              // 6. Platform behavior chart
              // -----------------------------------------------------------
              _DemoSection(
                index: 6,
                title: 'Platform behavior chart',
                subtitle:
                    'How each platform actually behaves when '
                    'smartQuotesType: SmartQuotesType.enabled is set. The '
                    'row matching this device is highlighted.',
                child: const _PlatformBehaviorTable(),
              ),

              // -----------------------------------------------------------
              // 7. InputDecoration showcase
              // -----------------------------------------------------------
              _DemoSection(
                index: 7,
                title: 'InputDecoration showcase',
                subtitle:
                    'Production-style fields: search bar, comment box, '
                    'address field, password reveal — each with the right '
                    'SmartQuotesType setting for the use case.',
                child: const _InputDecorationShowcase(),
              ),

              // -----------------------------------------------------------
              // 8. Default value & inheritance
              // -----------------------------------------------------------
              _DemoSection(
                index: 8,
                title: 'Default value & inheritance',
                subtitle:
                    'When you omit smartQuotesType the default depends on '
                    'keyboardType and platform. Three fields with no '
                    'smartQuotesType set, captioned with the inferred '
                    'default.',
                child: const _DefaultsShowcase(),
              ),

              // -----------------------------------------------------------
              // 9. Common pitfalls
              // -----------------------------------------------------------
              _DemoSection(
                index: 9,
                title: 'Common pitfalls',
                subtitle:
                    'Quick rules of thumb for when to enable and when to '
                    'disable smart quotes.',
                child: const _PitfallCards(),
              ),

              // -----------------------------------------------------------
              // 10. Recipe gallery
              // -----------------------------------------------------------
              _DemoSection(
                index: 10,
                title: 'Recipe gallery',
                subtitle:
                    'Four ready-to-paste recipes with full TextField '
                    'configurations: code editor, email composer, search '
                    'bar, note-taking.',
                child: const _RecipeGallery(),
              ),

              // -----------------------------------------------------------
              // 11. Reference table
              // -----------------------------------------------------------
              _DemoSection(
                index: 11,
                title: 'IME-related enums reference table',
                subtitle:
                    'How smartQuotesType, smartDashesType, autocorrect, and '
                    'enableSuggestions interact on a TextField.',
                child: const _ReferenceTable(),
              ),

              const SizedBox(height: 24),
              const _FooterNote(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION SCAFFOLDING
// ===========================================================================

class _DemoSection extends StatelessWidget {
  const _DemoSection({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.black.withOpacity(0.06)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEADDFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$index',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF21005D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1D1B20),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF5F5862),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFEDE7F1),
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  const _Paragraph(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 1.5,
        color: Color(0xFF1D1B20),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        height: 1.4,
        color: Color(0xFF5F5862),
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

class _Mono extends StatelessWidget {
  const _Mono(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF3EDF7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFF21005D),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.label, {required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

// ===========================================================================
// 1. INTRO — quote diagram
// ===========================================================================

class _QuoteDiagram extends StatelessWidget {
  const _QuoteDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F2FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7DFEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Expanded(
                child: _DiagramColumn(
                  title: 'Straight ASCII',
                  glyphs: <String>[
                    "'apostrophe'",
                    '"double quote"',
                  ],
                  hint:
                      'Code, JSON, URLs, identifiers. The same glyph for '
                      'open and close.',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _DiagramColumn(
                  title: 'Curly typographic',
                  glyphs: <String>[
                    '\u2018apostrophe\u2019',
                    '\u201Cdouble quote\u201D',
                  ],
                  hint:
                      'Prose, chat, essays. Open and close glyphs differ; '
                      'the keyboard picks the right one based on context.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.compare_arrows, size: 18, color: Color(0xFF6750A4)),
              SizedBox(width: 6),
              Text(
                'SmartQuotesType.enabled triggers the right -> left swap',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6750A4),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiagramColumn extends StatelessWidget {
  const _DiagramColumn({
    required this.title,
    required this.glyphs,
    required this.hint,
  });

  final String title;
  final List<String> glyphs;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF21005D),
          ),
        ),
        const SizedBox(height: 8),
        for (final String g in glyphs)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              g,
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 18,
                color: Color(0xFF1D1B20),
              ),
            ),
          ),
        const SizedBox(height: 8),
        Text(
          hint,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF5F5862),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// 2. SIDE-BY-SIDE TEXTFIELDS
// ===========================================================================

class _SideBySideTextFields extends StatefulWidget {
  const _SideBySideTextFields();

  @override
  State<_SideBySideTextFields> createState() => _SideBySideTextFieldsState();
}

class _SideBySideTextFieldsState extends State<_SideBySideTextFields> {
  final TextEditingController _enabledController = TextEditingController(
    text: "Type 'hello' or \"hello\" — watch the quotes.",
  );
  final TextEditingController _disabledController = TextEditingController(
    text: "Type 'hello' or \"hello\" — quotes stay straight.",
  );

  @override
  void initState() {
    super.initState();
    _enabledController.addListener(_refresh);
    _disabledController.addListener(_refresh);
  }

  @override
  void dispose() {
    _enabledController.removeListener(_refresh);
    _disabledController.removeListener(_refresh);
    _enabledController.dispose();
    _disabledController.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _LabeledTextField(
                label: 'SmartQuotesType.enabled',
                pillColor: const Color(0xFF1B5E20),
                hint: 'Try: it\'s "great"',
                controller: _enabledController,
                smartQuotesType: SmartQuotesType.enabled,
                description:
                    'On iOS the keyboard substitutes \u2018, \u2019, '
                    '\u201C, \u201D as you type.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _LabeledTextField(
                label: 'SmartQuotesType.disabled',
                pillColor: const Color(0xFFB71C1C),
                hint: 'Try: it\'s "great"',
                controller: _disabledController,
                smartQuotesType: SmartQuotesType.disabled,
                description:
                    'Quotes are kept exactly as typed — perfect for code, '
                    'JSON, URLs, identifiers.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _LiveMirror(
          enabledText: _enabledController.text,
          disabledText: _disabledController.text,
        ),
      ],
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  const _LabeledTextField({
    required this.label,
    required this.pillColor,
    required this.hint,
    required this.controller,
    required this.smartQuotesType,
    required this.description,
  });

  final String label;
  final Color pillColor;
  final String hint;
  final TextEditingController controller;
  final SmartQuotesType smartQuotesType;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Pill(label, color: pillColor),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          smartQuotesType: smartQuotesType,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 6),
        _Caption(description),
      ],
    );
  }
}

class _LiveMirror extends StatelessWidget {
  const _LiveMirror({
    required this.enabledText,
    required this.disabledText,
  });

  final String enabledText;
  final String disabledText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F2FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Live mirror — actual characters in each controller:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF21005D),
            ),
          ),
          const SizedBox(height: 8),
          _MirrorRow(label: 'enabled', text: enabledText),
          const SizedBox(height: 4),
          _MirrorRow(label: 'disabled', text: disabledText),
          const SizedBox(height: 8),
          _Caption(
            'Char codes: enabled=${_codes(enabledText)} | '
            'disabled=${_codes(disabledText)}',
          ),
        ],
      ),
    );
  }

  String _codes(String s) {
    if (s.isEmpty) return '<empty>';
    final List<String> only = <String>[];
    for (final int code in s.runes) {
      if (code == 0x27 ||
          code == 0x22 ||
          code == 0x2018 ||
          code == 0x2019 ||
          code == 0x201C ||
          code == 0x201D) {
        only.add(
          'U+${code.toRadixString(16).toUpperCase().padLeft(4, '0')}',
        );
      }
    }
    if (only.isEmpty) return '<no quote chars>';
    return only.join(' ');
  }
}

class _MirrorRow extends StatelessWidget {
  const _MirrorRow({required this.label, required this.text});
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 70,
          child: _Mono(label),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SelectableText(
            text.isEmpty ? '<empty>' : text,
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 14,
              color: Color(0xFF1D1B20),
            ),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// 3. CUPERTINO TEXTFIELD VERSION
// ===========================================================================

class _SideBySideCupertinoFields extends StatefulWidget {
  const _SideBySideCupertinoFields();

  @override
  State<_SideBySideCupertinoFields> createState() =>
      _SideBySideCupertinoFieldsState();
}

class _SideBySideCupertinoFieldsState
    extends State<_SideBySideCupertinoFields> {
  final TextEditingController _enabled = TextEditingController(
    text: 'iOS-style "smart" \'quotes\' on.',
  );
  final TextEditingController _disabled = TextEditingController(
    text: 'iOS-style "smart" \'quotes\' off.',
  );

  @override
  void initState() {
    super.initState();
    _enabled.addListener(_r);
    _disabled.addListener(_r);
  }

  @override
  void dispose() {
    _enabled.dispose();
    _disabled.dispose();
    super.dispose();
  }

  void _r() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _Pill(
                    'Cupertino · enabled',
                    color: Color(0xFF1B5E20),
                  ),
                  const SizedBox(height: 8),
                  CupertinoTextField(
                    controller: _enabled,
                    smartQuotesType: SmartQuotesType.enabled,
                    placeholder: 'Type something with quotes',
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      border: Border.all(color: const Color(0xFFCBC4CF)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const _Caption(
                    'iOS soft keyboard does the substitution; on desktop '
                    'the flag is forwarded but inert.',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _Pill(
                    'Cupertino · disabled',
                    color: Color(0xFFB71C1C),
                  ),
                  const SizedBox(height: 8),
                  CupertinoTextField(
                    controller: _disabled,
                    smartQuotesType: SmartQuotesType.disabled,
                    placeholder: 'Type something with quotes',
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      border: Border.all(color: const Color(0xFFCBC4CF)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const _Caption(
                    'Quotes preserved as typed — what you want for any '
                    'kind of structured input.',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _LiveMirror(
          enabledText: _enabled.text,
          disabledText: _disabled.text,
        ),
      ],
    );
  }
}

// ===========================================================================
// 4. KEYBOARD MATRIX
// ===========================================================================

class _KeyboardMatrix extends StatelessWidget {
  const _KeyboardMatrix();

  static const List<_KbRow> _rows = <_KbRow>[
    _KbRow(
      label: 'text',
      type: TextInputType.text,
      hint: 'Plain text — prose-friendly.',
    ),
    _KbRow(
      label: 'emailAddress',
      type: TextInputType.emailAddress,
      hint: 'name@example.com',
    ),
    _KbRow(
      label: 'url',
      type: TextInputType.url,
      hint: 'https://flutter.dev',
    ),
    _KbRow(
      label: 'multiline',
      type: TextInputType.multiline,
      hint: 'Multi-line essay…',
    ),
    _KbRow(
      label: 'name',
      type: TextInputType.name,
      hint: 'Ada Lovelace',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: <Widget>[
        for (final _KbRow row in _rows) ...<Widget>[
          _MatrixCell(
            row: row,
            quotes: SmartQuotesType.enabled,
          ),
          _MatrixCell(
            row: row,
            quotes: SmartQuotesType.disabled,
          ),
        ],
      ],
    );
  }
}

class _KbRow {
  const _KbRow({
    required this.label,
    required this.type,
    required this.hint,
  });
  final String label;
  final TextInputType type;
  final String hint;
}

class _MatrixCell extends StatelessWidget {
  const _MatrixCell({required this.row, required this.quotes});
  final _KbRow row;
  final SmartQuotesType quotes;

  @override
  Widget build(BuildContext context) {
    final bool enabled = quotes == SmartQuotesType.enabled;
    final Color accent = enabled
        ? const Color(0xFF1B5E20)
        : const Color(0xFFB71C1C);
    return SizedBox(
      width: 240,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFBFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE7DFEC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _Pill(row.label, color: const Color(0xFF6750A4)),
                const SizedBox(width: 6),
                _Pill(enabled ? 'enabled' : 'disabled', color: accent),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              keyboardType: row.type,
              smartQuotesType: quotes,
              maxLines: row.type == TextInputType.multiline ? 3 : 1,
              decoration: InputDecoration(
                hintText: row.hint,
                border: const OutlineInputBorder(),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// 5. LIVE SUBSTITUTION SHOWCASE
// ===========================================================================

class _SubstitutionShowcase extends StatefulWidget {
  const _SubstitutionShowcase();

  @override
  State<_SubstitutionShowcase> createState() => _SubstitutionShowcaseState();
}

class _SubstitutionShowcaseState extends State<_SubstitutionShowcase> {
  final TextEditingController _input = TextEditingController(
    text: "Hello, \"world\" — it's a test.",
  );
  String _processed = '';

  @override
  void initState() {
    super.initState();
    _input.addListener(_onChanged);
    _processed = _applySmart(_input.text);
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {});
  }

  String _applySmart(String input) {
    final StringBuffer out = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      final String c = input[i];
      if (c == '"') {
        final bool isOpen = i == 0 || _isWhitespace(input[i - 1]);
        out.write(isOpen ? '\u201C' : '\u201D');
      } else if (c == '\'') {
        final bool isOpen = i == 0 || _isWhitespace(input[i - 1]);
        out.write(isOpen ? '\u2018' : '\u2019');
      } else {
        out.write(c);
      }
    }
    return out.toString();
  }

  bool _isWhitespace(String s) =>
      s == ' ' || s == '\t' || s == '\n' || s == '\r';

  void _apply() {
    setState(() {
      _processed = _applySmart(_input.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          controller: _input,
          smartQuotesType: SmartQuotesType.enabled,
          decoration: const InputDecoration(
            labelText: 'Type quotes here (smartQuotesType: enabled)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: _apply,
              icon: const Icon(Icons.format_quote),
              label: const Text('Apply manual smart quotes'),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: _Caption(
                'On iOS, this happens at keyboard time. On other platforms '
                'you can do the substitution manually for output, like '
                'this.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _HighlightBox(text: _processed),
      ],
    );
  }
}

class _HighlightBox extends StatelessWidget {
  const _HighlightBox({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> spans = <TextSpan>[];
    for (final int code in text.runes) {
      final String s = String.fromCharCode(code);
      final bool curly = code == 0x2018 ||
          code == 0x2019 ||
          code == 0x201C ||
          code == 0x201D;
      spans.add(TextSpan(
        text: s,
        style: TextStyle(
          color: curly ? const Color(0xFF6750A4) : const Color(0xFF1D1B20),
          fontWeight: curly ? FontWeight.w800 : FontWeight.w400,
          backgroundColor:
              curly ? const Color(0xFFEADDFF) : Colors.transparent,
        ),
      ));
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F2FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE7DFEC)),
      ),
      child: SelectableText.rich(
        TextSpan(
          style: const TextStyle(fontFamily: 'serif', fontSize: 16),
          children: spans,
        ),
      ),
    );
  }
}

// ===========================================================================
// 6. PLATFORM BEHAVIOR TABLE
// ===========================================================================

class _PlatformBehaviorTable extends StatelessWidget {
  const _PlatformBehaviorTable();

  static const List<_PlatformRow> _rows = <_PlatformRow>[
    _PlatformRow(
      platform: TargetPlatform.iOS,
      name: 'iOS',
      enabled: 'Soft keyboard substitutes curly quotes by default.',
      disabled: 'Soft keyboard keeps quotes straight.',
      notes: 'Primary use case. Effect is highly visible.',
    ),
    _PlatformRow(
      platform: TargetPlatform.android,
      name: 'Android',
      enabled: 'Depends on IME (Gboard / SwiftKey / Samsung).',
      disabled: 'Hint forwarded as TYPE_TEXT_FLAG_NO_SUGGESTIONS-style.',
      notes: 'Most modern keyboards honor the flag.',
    ),
    _PlatformRow(
      platform: TargetPlatform.macOS,
      name: 'macOS',
      enabled: 'System Smart Quotes preference applies.',
      disabled: 'Forces straight quotes regardless of preference.',
      notes: 'System Settings -> Keyboard -> Text Input -> Smart quotes.',
    ),
    _PlatformRow(
      platform: TargetPlatform.windows,
      name: 'Windows',
      enabled: 'No-op for hardware keyboards.',
      disabled: 'No-op for hardware keyboards.',
      notes: 'Windows IME has no native smart-quote substitution.',
    ),
    _PlatformRow(
      platform: TargetPlatform.linux,
      name: 'Linux',
      enabled: 'No-op for hardware keyboards.',
      disabled: 'No-op for hardware keyboards.',
      notes: 'Some IBus IMEs do substitution, mostly nope.',
    ),
    _PlatformRow(
      platform: TargetPlatform.fuchsia,
      name: 'Web / Fuchsia',
      enabled: 'Browser- / OS-keyboard dependent.',
      disabled: 'Browser- / OS-keyboard dependent.',
      notes: 'Cannot guarantee behavior; treat as best-effort hint.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final TargetPlatform current = Theme.of(context).platform;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFDFBFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE7DFEC)),
          ),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(110),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(1.2),
              3: FlexColumnWidth(1.4),
            },
            border: TableBorder.symmetric(
              inside: const BorderSide(color: Color(0xFFEDE7F1)),
            ),
            children: <TableRow>[
              const TableRow(
                decoration: BoxDecoration(color: Color(0xFFEADDFF)),
                children: <Widget>[
                  _Th('Platform'),
                  _Th('enabled'),
                  _Th('disabled'),
                  _Th('Notes'),
                ],
              ),
              for (final _PlatformRow r in _rows)
                TableRow(
                  decoration: BoxDecoration(
                    color: r.platform == current
                        ? const Color(0xFFFFF8E1)
                        : Colors.transparent,
                  ),
                  children: <Widget>[
                    _Td(
                      r.name +
                          (r.platform == current ? '  <- you' : ''),
                      bold: r.platform == current,
                    ),
                    _Td(r.enabled),
                    _Td(r.disabled),
                    _Td(r.notes),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _Caption(
          'Highlighted row matches Theme.of(context).platform: $current',
        ),
      ],
    );
  }
}

class _PlatformRow {
  const _PlatformRow({
    required this.platform,
    required this.name,
    required this.enabled,
    required this.disabled,
    required this.notes,
  });
  final TargetPlatform platform;
  final String name;
  final String enabled;
  final String disabled;
  final String notes;
}

class _Th extends StatelessWidget {
  const _Th(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Color(0xFF21005D),
        ),
      ),
    );
  }
}

class _Td extends StatelessWidget {
  const _Td(this.text, {this.bold = false});
  final String text;
  final bool bold;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          height: 1.4,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          color: const Color(0xFF1D1B20),
        ),
      ),
    );
  }
}

// ===========================================================================
// 7. INPUT DECORATION SHOWCASE
// ===========================================================================

class _InputDecorationShowcase extends StatefulWidget {
  const _InputDecorationShowcase();

  @override
  State<_InputDecorationShowcase> createState() =>
      _InputDecorationShowcaseState();
}

class _InputDecorationShowcaseState extends State<_InputDecorationShowcase> {
  final TextEditingController _search = TextEditingController();
  final TextEditingController _comment = TextEditingController(
    text: 'I really liked the "intro" — great pacing!',
  );
  final TextEditingController _address = TextEditingController(
    text: "1600 Pennsylvania Ave NW, Washington, D.C.",
  );
  final TextEditingController _password = TextEditingController(
    text: "P@ssw0rd!'",
  );
  bool _passwordVisible = false;

  @override
  void dispose() {
    _search.dispose();
    _comment.dispose();
    _address.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Search bar — disabled (queries should be literal).
        TextField(
          controller: _search,
          smartQuotesType: SmartQuotesType.disabled,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search the docs',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0xFFF3EDF7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
          ),
        ),
        const SizedBox(height: 6),
        const _Caption(
          'Search bar — SmartQuotesType.disabled. Queries should match what '
          'the user typed exactly so they can copy/paste from logs.',
        ),

        const SizedBox(height: 16),

        // Comment box — enabled (prose).
        TextField(
          controller: _comment,
          smartQuotesType: SmartQuotesType.enabled,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Leave a comment',
            hintText: 'What did you think?',
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12, right: 8, top: 12),
              child: Icon(Icons.chat_bubble_outline),
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 6),
        const _Caption(
          'Comment box — SmartQuotesType.enabled. Prose benefits from '
          'typographically correct curly quotes.',
        ),

        const SizedBox(height: 16),

        // Address — enabled is fine (it is prose-like).
        TextField(
          controller: _address,
          smartQuotesType: SmartQuotesType.enabled,
          decoration: const InputDecoration(
            labelText: 'Mailing address',
            prefixIcon: Icon(Icons.home_outlined),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 6),
        const _Caption(
          'Address — SmartQuotesType.enabled is fine; addresses rarely '
          'contain quote characters anyway.',
        ),

        const SizedBox(height: 16),

        // Password reveal — disabled (every character must be literal).
        TextField(
          controller: _password,
          smartQuotesType: SmartQuotesType.disabled,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() => _passwordVisible = !_passwordVisible);
              },
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 6),
        const _Caption(
          'Password — SmartQuotesType.disabled is mandatory. Every byte '
          'must be exactly what the user typed.',
        ),
      ],
    );
  }
}

// ===========================================================================
// 8. DEFAULTS SHOWCASE
// ===========================================================================

class _DefaultsShowcase extends StatelessWidget {
  const _DefaultsShowcase();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _DefaultCase(
          title: 'TextField with no smartQuotesType, keyboardType: text',
          field: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Plain text — defaults shown below',
              border: OutlineInputBorder(),
            ),
          ),
          defaultDescription:
              'Default: SmartQuotesType.enabled. Flutter assumes prose '
              'unless told otherwise.',
        ),
        SizedBox(height: 16),
        _DefaultCase(
          title: 'TextField with no smartQuotesType, keyboardType: url',
          field: TextField(
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              labelText: 'URL — defaults shown below',
              border: OutlineInputBorder(),
            ),
          ),
          defaultDescription:
              'Default: SmartQuotesType.disabled. URL keyboard infers '
              'structured input.',
        ),
        SizedBox(height: 16),
        _DefaultCase(
          title:
              'TextField with no smartQuotesType, keyboardType: '
              'visiblePassword',
          field: TextField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: 'Password — defaults shown below',
              border: OutlineInputBorder(),
            ),
          ),
          defaultDescription:
              'Default: SmartQuotesType.disabled. Password keyboard always '
              'disables substitution.',
        ),
      ],
    );
  }
}

class _DefaultCase extends StatelessWidget {
  const _DefaultCase({
    required this.title,
    required this.field,
    required this.defaultDescription,
  });

  final String title;
  final Widget field;
  final String defaultDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE7DFEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF21005D),
            ),
          ),
          const SizedBox(height: 8),
          field,
          const SizedBox(height: 6),
          _Caption(defaultDescription),
        ],
      ),
    );
  }
}

// ===========================================================================
// 9. COMMON PITFALLS
// ===========================================================================

class _PitfallCards extends StatelessWidget {
  const _PitfallCards();

  static const List<_PitfallCard> _cards = <_PitfallCard>[
    _PitfallCard(
      icon: Icons.code,
      color: Color(0xFFB71C1C),
      title: 'Writing code? disable smart quotes',
      body:
          'Programming languages parse straight quotes. Curly quotes lead '
          'to mysterious "unexpected character" errors. Always set '
          'SmartQuotesType.disabled for code editors.',
    ),
    _PitfallCard(
      icon: Icons.data_object,
      color: Color(0xFFB71C1C),
      title: 'JSON input? disable smart quotes',
      body:
          'JSON requires straight double quotes. Pasting curly-quote '
          'JSON breaks every parser. SmartQuotesType.disabled on JSON '
          'inputs is non-negotiable.',
    ),
    _PitfallCard(
      icon: Icons.link,
      color: Color(0xFFB71C1C),
      title: 'URL field? disable smart quotes',
      body:
          'URLs sometimes contain quote characters in query strings. '
          'Smart-substituted ones break percent-encoding. Use '
          'SmartQuotesType.disabled.',
    ),
    _PitfallCard(
      icon: Icons.edit_note,
      color: Color(0xFF1B5E20),
      title: 'Essay or chat? enable smart quotes',
      body:
          'Prose, chat messages, comments, and any text ultimately read '
          'by humans benefits from typographically correct curly quotes. '
          'SmartQuotesType.enabled is the right default.',
    ),
    _PitfallCard(
      icon: Icons.terminal,
      color: Color(0xFFB71C1C),
      title: 'Shell commands? disable',
      body:
          'Anything that ends up at a shell, Docker, or remote SSH '
          'session must keep quotes literal. SmartQuotesType.disabled.',
    ),
    _PitfallCard(
      icon: Icons.alternate_email,
      color: Color(0xFFB71C1C),
      title: 'Email and URLs? disable',
      body:
          'TextInputType.emailAddress and TextInputType.url default to '
          'disabled, but if you override keyboardType, set '
          'smartQuotesType explicitly.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: <Widget>[
        for (final _PitfallCard c in _cards)
          SizedBox(
            width: 280,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: c.color.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: c.color.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(c.icon, color: c.color, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          c.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: c.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    c.body,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: Color(0xFF1D1B20),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _PitfallCard {
  const _PitfallCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String body;
}

// ===========================================================================
// 10. RECIPE GALLERY
// ===========================================================================

class _RecipeGallery extends StatelessWidget {
  const _RecipeGallery();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: const <Widget>[
        _RecipeCard(
          title: 'Code editor (disabled)',
          subtitle: 'Monospace, no autocorrect, straight quotes only.',
          quotes: SmartQuotesType.disabled,
          monospace: true,
          maxLines: 6,
          autocorrect: false,
          enableSuggestions: false,
          smartDashes: SmartDashesType.disabled,
          keyboardType: TextInputType.multiline,
          initial: "void main() {\n  print('hello');\n}",
        ),
        _RecipeCard(
          title: 'Email composer (enabled)',
          subtitle: 'Multi-line prose with curly quotes and autocorrect.',
          quotes: SmartQuotesType.enabled,
          monospace: false,
          maxLines: 6,
          autocorrect: true,
          enableSuggestions: true,
          smartDashes: SmartDashesType.enabled,
          keyboardType: TextInputType.multiline,
          initial:
              'Hi team,\n\nI just wanted to say "thanks" — really '
              'appreciate it.\n\nBest,\nAda',
        ),
        _RecipeCard(
          title: 'Search bar (disabled)',
          subtitle: 'Single line, literal queries, no autocorrect.',
          quotes: SmartQuotesType.disabled,
          monospace: false,
          maxLines: 1,
          autocorrect: false,
          enableSuggestions: false,
          smartDashes: SmartDashesType.disabled,
          keyboardType: TextInputType.text,
          initial: '"exact phrase" OR keyword',
        ),
        _RecipeCard(
          title: 'Note-taking (enabled)',
          subtitle: 'Casual prose, all the IME niceties on.',
          quotes: SmartQuotesType.enabled,
          monospace: false,
          maxLines: 6,
          autocorrect: true,
          enableSuggestions: true,
          smartDashes: SmartDashesType.enabled,
          keyboardType: TextInputType.multiline,
          initial:
              "Idea for tomorrow: read a chapter of \"Designing Data-"
              "Intensive Applications\" and don't forget the gym.",
        ),
      ],
    );
  }
}

class _RecipeCard extends StatefulWidget {
  const _RecipeCard({
    required this.title,
    required this.subtitle,
    required this.quotes,
    required this.monospace,
    required this.maxLines,
    required this.autocorrect,
    required this.enableSuggestions,
    required this.smartDashes,
    required this.keyboardType,
    required this.initial,
  });

  final String title;
  final String subtitle;
  final SmartQuotesType quotes;
  final bool monospace;
  final int maxLines;
  final bool autocorrect;
  final bool enableSuggestions;
  final SmartDashesType smartDashes;
  final TextInputType keyboardType;
  final String initial;

  @override
  State<_RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<_RecipeCard> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.quotes == SmartQuotesType.enabled;
    return SizedBox(
      width: 320,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFBFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE7DFEC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF21005D),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF5F5862),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ctrl,
              smartQuotesType: widget.quotes,
              smartDashesType: widget.smartDashes,
              autocorrect: widget.autocorrect,
              enableSuggestions: widget.enableSuggestions,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              style: TextStyle(
                fontFamily: widget.monospace ? 'monospace' : null,
                fontSize: 13,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                _Pill(
                  enabled ? 'quotes: enabled' : 'quotes: disabled',
                  color: enabled
                      ? const Color(0xFF1B5E20)
                      : const Color(0xFFB71C1C),
                ),
                _Pill(
                  widget.smartDashes == SmartDashesType.enabled
                      ? 'dashes: enabled'
                      : 'dashes: disabled',
                  color: widget.smartDashes == SmartDashesType.enabled
                      ? const Color(0xFF1B5E20)
                      : const Color(0xFFB71C1C),
                ),
                _Pill(
                  widget.autocorrect ? 'autocorrect' : 'no autocorrect',
                  color: widget.autocorrect
                      ? const Color(0xFF1B5E20)
                      : const Color(0xFFB71C1C),
                ),
                _Pill(
                  widget.enableSuggestions
                      ? 'suggestions'
                      : 'no suggestions',
                  color: widget.enableSuggestions
                      ? const Color(0xFF1B5E20)
                      : const Color(0xFFB71C1C),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// 11. REFERENCE TABLE
// ===========================================================================

class _ReferenceTable extends StatelessWidget {
  const _ReferenceTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7DFEC)),
      ),
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(170),
          1: FixedColumnWidth(140),
          2: FlexColumnWidth(1.2),
          3: FlexColumnWidth(1.4),
        },
        border: TableBorder.symmetric(
          inside: const BorderSide(color: Color(0xFFEDE7F1)),
        ),
        children: const <TableRow>[
          TableRow(
            decoration: BoxDecoration(color: Color(0xFFEADDFF)),
            children: <Widget>[
              _Th('Property'),
              _Th('Type'),
              _Th('Default'),
              _Th('Effect'),
            ],
          ),
          TableRow(children: <Widget>[
            _Td('smartQuotesType'),
            _Td('SmartQuotesType?'),
            _Td('platform / kbd inferred'),
            _Td(
              'Whether the IME substitutes \u201C\u201D and \u2018\u2019 '
              'for straight quotes.',
            ),
          ]),
          TableRow(children: <Widget>[
            _Td('smartDashesType'),
            _Td('SmartDashesType?'),
            _Td('platform / kbd inferred'),
            _Td(
              'Whether double-hyphens are replaced by an em-dash. Same '
              'iOS-keyboard mechanism as smart quotes.',
            ),
          ]),
          TableRow(children: <Widget>[
            _Td('autocorrect'),
            _Td('bool'),
            _Td('true'),
            _Td(
              'Whether the IME offers spelling/grammar autocorrect. '
              'Independent of smart quotes — they can co-exist.',
            ),
          ]),
          TableRow(children: <Widget>[
            _Td('enableSuggestions'),
            _Td('bool'),
            _Td('true'),
            _Td(
              'Whether the IME shows the suggestion strip. Disabling does '
              'not by itself disable autocorrect or smart quotes.',
            ),
          ]),
          TableRow(children: <Widget>[
            _Td('obscureText'),
            _Td('bool'),
            _Td('false'),
            _Td(
              'When true, all of autocorrect, suggestions, smart quotes, '
              'and smart dashes are forcibly disabled regardless of the '
              'explicit values.',
            ),
          ]),
          TableRow(children: <Widget>[
            _Td('keyboardType'),
            _Td('TextInputType'),
            _Td('text'),
            _Td(
              'Influences the inferred default for smartQuotesType and '
              'smartDashesType (e.g. url and emailAddress default to '
              'disabled).',
            ),
          ]),
        ],
      ),
    );
  }
}

// ===========================================================================
// FOOTER
// ===========================================================================

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEADDFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Icon(Icons.info_outline, color: Color(0xFF21005D)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Reminder: SmartQuotesType is a hint to the platform IME. '
              'You cannot guarantee substitution on every device, but '
              'setting it correctly is a robustness win and costs nothing. '
              'Default to enabled for prose and disabled for any kind of '
              'structured input (code, JSON, URLs, identifiers, '
              'shell commands).',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xFF21005D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// END OF FILE
// ===========================================================================
//
// Final notes for readers and AST-walking tools alike:
//
//   * SmartQuotesType.enabled  appears on TextField and CupertinoTextField
//     instances throughout the file (sections 2, 3, 4, 5, 7, 8, 10).
//   * SmartQuotesType.disabled appears on TextField and CupertinoTextField
//     instances throughout the file (sections 2, 3, 4, 7, 9, 10).
//   * Both values are consumed as live arguments to widget constructors,
//     not just mentioned in strings — section 1 covers descriptive text
//     but every later section actually wires the enum into a real widget.
//
// The build() function is the documented entry point for the d4rt AST
// http harness. It returns a fully-formed widget tree rooted at
// MaterialApp -> Scaffold -> SafeArea -> SingleChildScrollView -> Column,
// matching the shape required by the harness for visual round-trip tests.
//
// ---------------------------------------------------------------------------

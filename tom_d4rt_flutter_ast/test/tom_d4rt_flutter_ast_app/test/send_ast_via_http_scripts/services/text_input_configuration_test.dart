// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// Visual deep demo: Flutter TextInputConfiguration (services.dart)
// Replaces a legacy text fixture with a richly illustrated reference page
// covering every TextInputConfiguration field, the TextInputAction enum,
// TextCapitalization variants, keyboardAppearance brightness, autofill hints,
// a realistic constructor literal, and common pitfalls. The whole demo is
// rendered through a single static `build(BuildContext)` entry point.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _kInk = Color(0xFF0E1726);
const Color _kInkSoft = Color(0xFF334155);
const Color _kInkMuted = Color(0xFF64748B);
const Color _kPaper = Color(0xFFF7F9FC);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kBorder = Color(0xFFE2E8F0);
const Color _kBorderSoft = Color(0xFFEEF2F7);
const Color _kAccent = Color(0xFF2563EB);
const Color _kAccentSoft = Color(0xFFDBEAFE);
const Color _kViolet = Color(0xFF7C3AED);
const Color _kVioletSoft = Color(0xFFEDE9FE);
const Color _kPink = Color(0xFFDB2777);
const Color _kPinkSoft = Color(0xFFFCE7F3);
const Color _kEmerald = Color(0xFF059669);
const Color _kEmeraldSoft = Color(0xFFD1FAE5);
const Color _kAmber = Color(0xFFD97706);
const Color _kAmberSoft = Color(0xFFFEF3C7);
const Color _kRose = Color(0xFFE11D48);
const Color _kRoseSoft = Color(0xFFFFE4E6);
const Color _kSlate = Color(0xFF475569);
const Color _kSlateSoft = Color(0xFFE2E8F0);
const Color _kCode = Color(0xFF0B1020);
const Color _kCodeText = Color(0xFFE6EDF3);
const Color _kKeyCap = Color(0xFFF1F5F9);
const Color _kKeyEdge = Color(0xFFCBD5E1);

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextInputConfiguration deep demo',
    theme: ThemeData(
      scaffoldBackgroundColor: _kPaper,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk),
      ),
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _PrivateSection1Hero(),
                const SizedBox(height: 28),
                _PrivateSection2Anatomy(),
                const SizedBox(height: 28),
                _PrivateSection3Examples(),
                const SizedBox(height: 28),
                _PrivateSection4ActionGallery(),
                const SizedBox(height: 28),
                _PrivateSection5Capitalization(),
                const SizedBox(height: 28),
                _PrivateSection6Brightness(),
                const SizedBox(height: 28),
                _PrivateSection7Autofill(),
                const SizedBox(height: 28),
                _PrivateSection8CodeListing(),
                const SizedBox(height: 28),
                _PrivateSection9Pitfalls(),
                const SizedBox(height: 28),
                _PrivateSection10Footer(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — Hero: stylized phone IME keyboard graphic
// ===========================================================================
class _PrivateSection1Hero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1E3A8A), Color(0xFF7C3AED)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
                    ),
                    child: Text(
                      'package:flutter/services.dart',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.95),
                        fontSize: 11,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'TextInputConfiguration',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'The bundle of options that TextInput.attach() ships to the\n'
                    'platform IME so it can build the right on-screen keyboard.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 15,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      _PrivateHeroChip(label: 'inputType'),
                      _PrivateHeroChip(label: 'inputAction'),
                      _PrivateHeroChip(label: 'obscureText'),
                      _PrivateHeroChip(label: 'autocorrect'),
                      _PrivateHeroChip(label: 'autofillConfiguration'),
                      _PrivateHeroChip(label: 'keyboardAppearance'),
                      _PrivateHeroChip(label: 'enableDeltaModel'),
                      _PrivateHeroChip(label: 'viewId'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 5,
              child: _PrivatePhoneMockup(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateHeroChip extends StatelessWidget {
  final String label;
  const _PrivateHeroChip({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.30)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PrivatePhoneMockup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18), width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          // notch
          Container(
            width: 80,
            height: 6,
            margin: const EdgeInsets.only(top: 2, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          // status bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('9:41',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                Row(children: <Widget>[
                  Icon(Icons.signal_cellular_alt,
                      size: 12, color: Colors.white.withValues(alpha: 0.85)),
                  const SizedBox(width: 4),
                  Icon(Icons.wifi,
                      size: 12, color: Colors.white.withValues(alpha: 0.85)),
                  const SizedBox(width: 4),
                  Icon(Icons.battery_full,
                      size: 14, color: Colors.white.withValues(alpha: 0.85)),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // text field row
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.alternate_email, size: 16, color: _kInkMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('user@example|',
                      style: TextStyle(
                          color: _kInk,
                          fontSize: 13,
                          fontFamily: 'monospace')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // suggestion bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _PrivateSuggestion('@gmail.com'),
                _PrivateSuggestion('@outlook.com'),
                _PrivateSuggestion('@yahoo.com'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // keyboard rows
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: <Widget>[
                _PrivateKeyRow(keys: const <String>['1','2','3','4','5','6','7','8','9','0']),
                const SizedBox(height: 6),
                _PrivateKeyRow(keys: const <String>['q','w','e','r','t','y','u','i','o','p']),
                const SizedBox(height: 6),
                _PrivateKeyRow(keys: const <String>['a','s','d','f','g','h','j','k','l']),
                const SizedBox(height: 6),
                _PrivateKeyRow(keys: const <String>['z','x','c','v','b','n','m','@','.']),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    _PrivateKeyCap(label: 'ABC', flex: 2),
                    _PrivateKeyCap(label: 'space', flex: 5),
                    _PrivateKeyCap(label: '@', flex: 1),
                    _PrivateKeyCap(label: 'next', flex: 2, color: _kAccent, textColor: Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateSuggestion extends StatelessWidget {
  final String label;
  const _PrivateSuggestion(this.label);
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600),
    );
  }
}

class _PrivateKeyRow extends StatelessWidget {
  final List<String> keys;
  const _PrivateKeyRow({required this.keys});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: keys
          .map<Widget>((String k) => _PrivateKeyCap(label: k, flex: 1))
          .toList(),
    );
  }
}

class _PrivateKeyCap extends StatelessWidget {
  final String label;
  final int flex;
  final Color? color;
  final Color? textColor;
  const _PrivateKeyCap({
    required this.label,
    required this.flex,
    this.color,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: 26,
        decoration: BoxDecoration(
          color: color ?? _kKeyCap,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: _kKeyEdge.withValues(alpha: 0.6), width: 0.6),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: textColor ?? _kInk,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 2 — Anatomy of TextInputConfiguration: 16-field panel
// ===========================================================================
class _PrivateSection2Anatomy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PrivateAnatomyRow> rows = <_PrivateAnatomyRow>[
      _PrivateAnatomyRow('inputType', 'TextInputType', 'Logical keyboard kind (text, email, number…)'),
      _PrivateAnatomyRow('readOnly', 'bool', 'When true the field cannot be edited via IME'),
      _PrivateAnatomyRow('obscureText', 'bool', 'Hides characters and disables suggestions'),
      _PrivateAnatomyRow('autocorrect', 'bool', 'Allow the platform to auto-correct typed text'),
      _PrivateAnatomyRow('smartDashesType', 'SmartDashesType', 'Convert "--" to em-dash on Apple platforms'),
      _PrivateAnatomyRow('smartQuotesType', 'SmartQuotesType', 'Curly quotes vs straight quotes'),
      _PrivateAnatomyRow('enableSuggestions', 'bool', 'Show predictive suggestions in the IME bar'),
      _PrivateAnatomyRow('enableInteractiveSelection', 'bool', 'Allow native selection handles & magnifier'),
      _PrivateAnatomyRow('actionLabel', 'String?', 'Custom label drawn on the action key'),
      _PrivateAnatomyRow('inputAction', 'TextInputAction', 'Logical action: done, go, search, next…'),
      _PrivateAnatomyRow('keyboardAppearance', 'Brightness', 'Light or dark IME chrome (iOS-respecting)'),
      _PrivateAnatomyRow('textCapitalization', 'TextCapitalization', 'none / words / sentences / characters'),
      _PrivateAnatomyRow('autofillConfiguration', 'AutofillConfiguration', 'Hints + uniqueId for autofill providers'),
      _PrivateAnatomyRow('enableIMEPersonalizedLearning', 'bool', 'Let the IME learn from this field’s content'),
      _PrivateAnatomyRow('allowedMimeTypes', 'List<String>', 'Mime types the IME may insert (e.g. image/gif)'),
      _PrivateAnatomyRow('enableDeltaModel', 'bool', 'Send TextEditingDelta updates to the client'),
      _PrivateAnatomyRow('viewId', 'int?', 'Target FlutterView id for multi-window apps'),
    ];
    return _PrivateCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _PrivateSectionHeader(
              kicker: 'SECTION 2',
              title: 'Anatomy of a TextInputConfiguration',
              subtitle:
                  'All seventeen named parameters at a glance — name, declared type, and the role they play '
                  'when the framework hands the configuration to the platform IME.',
              accent: _kAccent,
            ),
            const SizedBox(height: 18),
            LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints c) {
                final int columns = c.maxWidth > 900 ? 2 : 1;
                final double colWidth =
                    (c.maxWidth - (columns - 1) * 14) / columns;
                return Wrap(
                  spacing: 14,
                  runSpacing: 12,
                  children: rows
                      .map<Widget>((row) => SizedBox(
                            width: colWidth,
                            child: _PrivateAnatomyTile(row: row),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateAnatomyRow {
  final String name;
  final String type;
  final String description;
  _PrivateAnatomyRow(this.name, this.type, this.description);
}

class _PrivateAnatomyTile extends StatelessWidget {
  final _PrivateAnatomyRow row;
  const _PrivateAnatomyTile({required this.row});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _kAccentSoft,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  row.name,
                  style: const TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kSlateSoft,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  row.type,
                  style: const TextStyle(
                    color: _kSlate,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            row.description,
            style: const TextStyle(color: _kInkSoft, fontSize: 13, height: 1.35),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 3 — Worked-example cards
// ===========================================================================
class _PrivateSection3Examples extends StatelessWidget {
  TextInputConfiguration _regular() => const TextInputConfiguration(
        inputType: TextInputType.text,
        autocorrect: true,
        enableSuggestions: true,
        textCapitalization: TextCapitalization.sentences,
        inputAction: TextInputAction.done,
        keyboardAppearance: Brightness.light,
      );
  TextInputConfiguration _password() => const TextInputConfiguration(
        inputType: TextInputType.visiblePassword,
        obscureText: true,
        autocorrect: false,
        enableSuggestions: false,
        smartDashesType: SmartDashesType.disabled,
        smartQuotesType: SmartQuotesType.disabled,
        enableIMEPersonalizedLearning: false,
        inputAction: TextInputAction.done,
      );
  TextInputConfiguration _email() => const TextInputConfiguration(
        inputType: TextInputType.emailAddress,
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        inputAction: TextInputAction.next,
      );
  TextInputConfiguration _phone() => const TextInputConfiguration(
        inputType: TextInputType.phone,
        autocorrect: false,
        enableSuggestions: false,
        inputAction: TextInputAction.done,
      );
  TextInputConfiguration _multiline() => const TextInputConfiguration(
        inputType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        inputAction: TextInputAction.newline,
        autocorrect: true,
        enableSuggestions: true,
      );
  TextInputConfiguration _search() => const TextInputConfiguration(
        inputType: TextInputType.text,
        autocorrect: false,
        enableSuggestions: true,
        textCapitalization: TextCapitalization.none,
        inputAction: TextInputAction.search,
        actionLabel: 'Find',
      );

  @override
  Widget build(BuildContext context) {
    final List<_PrivateExampleSpec> specs = <_PrivateExampleSpec>[
      _PrivateExampleSpec(
        label: 'Regular text',
        accent: _kAccent,
        accentSoft: _kAccentSoft,
        icon: Icons.short_text,
        placeholder: 'Type a note here…',
        config: _regular(),
        codeLines: const <String>[
          'TextInputConfiguration(',
          '  inputType: TextInputType.text,',
          '  autocorrect: true,',
          '  enableSuggestions: true,',
          '  textCapitalization: TextCapitalization.sentences,',
          '  inputAction: TextInputAction.done,',
          '  keyboardAppearance: Brightness.light,',
          ')',
        ],
      ),
      _PrivateExampleSpec(
        label: 'Password',
        accent: _kRose,
        accentSoft: _kRoseSoft,
        icon: Icons.lock_outline,
        placeholder: '••••••••••',
        config: _password(),
        codeLines: const <String>[
          'TextInputConfiguration(',
          '  inputType: TextInputType.visiblePassword,',
          '  obscureText: true,',
          '  autocorrect: false,',
          '  enableSuggestions: false,',
          '  smartDashesType: SmartDashesType.disabled,',
          '  smartQuotesType: SmartQuotesType.disabled,',
          '  enableIMEPersonalizedLearning: false,',
          '  inputAction: TextInputAction.done,',
          ')',
        ],
      ),
      _PrivateExampleSpec(
        label: 'Email address',
        accent: _kViolet,
        accentSoft: _kVioletSoft,
        icon: Icons.alternate_email,
        placeholder: 'you@example.com',
        config: _email(),
        codeLines: const <String>[
          'TextInputConfiguration(',
          '  inputType: TextInputType.emailAddress,',
          '  autocorrect: false,',
          '  enableSuggestions: false,',
          '  textCapitalization: TextCapitalization.none,',
          '  inputAction: TextInputAction.next,',
          ')',
        ],
      ),
      _PrivateExampleSpec(
        label: 'Phone',
        accent: _kEmerald,
        accentSoft: _kEmeraldSoft,
        icon: Icons.phone,
        placeholder: '+1 (555) 010-2020',
        config: _phone(),
        codeLines: const <String>[
          'TextInputConfiguration(',
          '  inputType: TextInputType.phone,',
          '  autocorrect: false,',
          '  enableSuggestions: false,',
          '  inputAction: TextInputAction.done,',
          ')',
        ],
      ),
      _PrivateExampleSpec(
        label: 'Multi-line note',
        accent: _kAmber,
        accentSoft: _kAmberSoft,
        icon: Icons.notes,
        placeholder: 'Write something\non multiple lines…',
        config: _multiline(),
        codeLines: const <String>[
          'TextInputConfiguration(',
          '  inputType: TextInputType.multiline,',
          '  textCapitalization: TextCapitalization.sentences,',
          '  inputAction: TextInputAction.newline,',
          '  autocorrect: true,',
          '  enableSuggestions: true,',
          ')',
        ],
      ),
      _PrivateExampleSpec(
        label: 'Search box',
        accent: _kPink,
        accentSoft: _kPinkSoft,
        icon: Icons.search,
        placeholder: 'Search Tom corpus…',
        config: _search(),
        codeLines: const <String>[
          'TextInputConfiguration(',
          '  inputType: TextInputType.text,',
          '  autocorrect: false,',
          '  enableSuggestions: true,',
          '  textCapitalization: TextCapitalization.none,',
          '  inputAction: TextInputAction.search,',
          '  actionLabel: \'Find\',',
          ')',
        ],
      ),
    ];

    return _PrivateCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _PrivateSectionHeader(
              kicker: 'SECTION 3',
              title: 'Six worked examples',
              subtitle:
                  'Each card pairs a fake TextField mock, the constructor literal as code, '
                  'and the resulting toJson() console output that the framework would dispatch over the platform channel.',
              accent: _kViolet,
            ),
            const SizedBox(height: 18),
            LayoutBuilder(builder: (BuildContext ctx, BoxConstraints c) {
              final int cols = c.maxWidth > 980 ? 2 : 1;
              final double cw = (c.maxWidth - (cols - 1) * 16) / cols;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: specs
                    .map<Widget>((s) => SizedBox(
                          width: cw,
                          child: _PrivateExampleCard(spec: s),
                        ))
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PrivateExampleSpec {
  final String label;
  final Color accent;
  final Color accentSoft;
  final IconData icon;
  final String placeholder;
  final TextInputConfiguration config;
  final List<String> codeLines;
  _PrivateExampleSpec({
    required this.label,
    required this.accent,
    required this.accentSoft,
    required this.icon,
    required this.placeholder,
    required this.config,
    required this.codeLines,
  });
}

class _PrivateExampleCard extends StatelessWidget {
  final _PrivateExampleSpec spec;
  const _PrivateExampleCard({required this.spec});

  String _renderJson() {
    final Map<String, dynamic> json = spec.config.toJson();
    final List<String> lines = <String>['{'];
    final List<String> keys = json.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      final String k = keys[i];
      final Object? v = json[k];
      final String comma = i == keys.length - 1 ? '' : ',';
      lines.add('  "$k": ${_PrivateJsonValue.encode(v)}$comma');
    }
    lines.add('}');
    return lines.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: spec.accentSoft,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(spec.icon, color: spec.accent, size: 18),
                const SizedBox(width: 8),
                Text(
                  spec.label,
                  style: TextStyle(
                    color: spec.accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: spec.accent.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    spec.config.inputAction.toString().split('.').last,
                    style: TextStyle(
                      color: spec.accent,
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Mock TextField
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
            child: _PrivateMockField(
              icon: spec.icon,
              placeholder: spec.placeholder,
              accent: spec.accent,
              obscure: spec.config.obscureText,
              multiline: spec.config.inputType == TextInputType.multiline,
            ),
          ),
          // Code listing
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
            child: _PrivateCodeBlock(
              title: 'constructor',
              lines: spec.codeLines,
              language: 'dart',
            ),
          ),
          // toJson
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
            child: _PrivateConsoleBlock(
              title: 'toJson()',
              text: _renderJson(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateJsonValue {
  static String encode(Object? v) {
    if (v == null) return 'null';
    if (v is bool) return v ? 'true' : 'false';
    if (v is num) return v.toString();
    if (v is String) return '"$v"';
    if (v is List<Object?>) {
      if (v.isEmpty) return '[]';
      return '[${v.map<String>(encode).join(', ')}]';
    }
    if (v is Map<String, dynamic>) {
      if (v.isEmpty) return '{}';
      final List<String> parts = <String>[];
      v.forEach((String k, Object? val) {
        parts.add('"$k": ${encode(val)}');
      });
      return '{${parts.join(', ')}}';
    }
    return '"${v.toString()}"';
  }
}

class _PrivateMockField extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final Color accent;
  final bool obscure;
  final bool multiline;
  const _PrivateMockField({
    required this.icon,
    required this.placeholder,
    required this.accent,
    required this.obscure,
    required this.multiline,
  });
  @override
  Widget build(BuildContext context) {
    final String text = obscure ? '••••••••' : placeholder;
    return Container(
      height: multiline ? 64 : 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _kPaper,
        border: Border.all(color: accent, width: 1.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: multiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: multiline ? 10 : 0),
            child: Icon(icon, color: accent, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: multiline ? 8 : 0),
              child: Text(
                text,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 13,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          Container(
            width: 1.5,
            height: 16,
            color: accent,
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 4 — TextInputAction enum gallery
// ===========================================================================
class _PrivateSection4ActionGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PrivateActionTile> tiles = <_PrivateActionTile>[
      _PrivateActionTile('done', Icons.check_circle, _kEmerald, 'Submits the form, dismisses keyboard'),
      _PrivateActionTile('go', Icons.arrow_forward, _kAccent, 'Generic "go" — submit and proceed'),
      _PrivateActionTile('search', Icons.search, _kViolet, 'Trigger a search — magnifier icon on iOS'),
      _PrivateActionTile('send', Icons.send, _kPink, 'Send the typed message'),
      _PrivateActionTile('next', Icons.east, _kAccent, 'Move focus to the next field'),
      _PrivateActionTile('previous', Icons.west, _kSlate, 'Move focus to the previous field (Android)'),
      _PrivateActionTile('continueAction', Icons.double_arrow, _kAccent, 'iOS continue — typically same as next'),
      _PrivateActionTile('join', Icons.group_add, _kEmerald, 'Join (e.g. Wi-Fi network passphrase)'),
      _PrivateActionTile('route', Icons.alt_route, _kViolet, 'Direction lookup — Maps style'),
      _PrivateActionTile('emergencyCall', Icons.local_hospital, _kRose, 'Emergency call shortcut'),
      _PrivateActionTile('newline', Icons.subdirectory_arrow_left, _kAmber, 'Insert a literal line break'),
      _PrivateActionTile('none', Icons.block, _kSlate, 'No action — the key is hidden'),
      _PrivateActionTile('unspecified', Icons.help_outline, _kInkMuted, 'Platform default for the inputType'),
      _PrivateActionTile('done (alt)', Icons.keyboard_return, _kEmerald, 'Some IMEs show "Return" instead'),
      _PrivateActionTile('go (alt)', Icons.flight_takeoff, _kAccent, 'Some IMEs show a takeoff glyph'),
      _PrivateActionTile('send (alt)', Icons.outgoing_mail, _kPink, 'Mail apps render an envelope'),
    ];
    return _PrivateCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _PrivateSectionHeader(
              kicker: 'SECTION 4',
              title: 'TextInputAction enum gallery',
              subtitle:
                  'Sixteen action variants. The label drawn on the IME action key maps to one of these enum '
                  'values; the platform may choose to display its own icon depending on locale and inputType.',
              accent: _kEmerald,
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: tiles
                  .map<Widget>((t) => _PrivateActionMock(tile: t))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateActionTile {
  final String name;
  final IconData icon;
  final Color color;
  final String hint;
  _PrivateActionTile(this.name, this.icon, this.color, this.hint);
}

class _PrivateActionMock extends StatelessWidget {
  final _PrivateActionTile tile;
  const _PrivateActionMock({required this.tile});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 174,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // mock keyboard action button
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: tile.color,
              borderRadius: BorderRadius.circular(7),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: tile.color.withValues(alpha: 0.35),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(tile.icon, color: Colors.white, size: 16),
                const SizedBox(width: 6),
                Text(
                  tile.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tile.hint,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 11,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 5 — TextCapitalization four-card panel
// ===========================================================================
class _PrivateSection5Capitalization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PrivateCapEntry> caps = <_PrivateCapEntry>[
      _PrivateCapEntry(
          'TextCapitalization.none',
          'Never auto-capitalize. Treat input verbatim.',
          'hello world from flutter',
          'hello world from flutter',
          _kSlate,
          _kSlateSoft),
      _PrivateCapEntry(
          'TextCapitalization.words',
          'Capitalize the first letter of every word.',
          'hello world from flutter',
          'Hello World From Flutter',
          _kAccent,
          _kAccentSoft),
      _PrivateCapEntry(
          'TextCapitalization.sentences',
          'Capitalize the first letter of every sentence.',
          'hello world. how are you?',
          'Hello world. How are you?',
          _kViolet,
          _kVioletSoft),
      _PrivateCapEntry(
          'TextCapitalization.characters',
          'Force every character to upper case (caps lock).',
          'hello world',
          'HELLO WORLD',
          _kRose,
          _kRoseSoft),
    ];
    return _PrivateCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _PrivateSectionHeader(
              kicker: 'SECTION 5',
              title: 'TextCapitalization variants',
              subtitle:
                  'How the IME transforms typed text before it reaches the framework. '
                  'Pick the variant that matches the field’s semantics; this also influences the IME shift state on first launch.',
              accent: _kPink,
            ),
            const SizedBox(height: 18),
            LayoutBuilder(builder: (BuildContext ctx, BoxConstraints c) {
              final int cols = c.maxWidth > 880 ? 4 : c.maxWidth > 560 ? 2 : 1;
              final double cw = (c.maxWidth - (cols - 1) * 12) / cols;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: caps
                    .map<Widget>((cap) => SizedBox(
                          width: cw,
                          child: _PrivateCapCard(entry: cap),
                        ))
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PrivateCapEntry {
  final String name;
  final String description;
  final String before;
  final String after;
  final Color accent;
  final Color accentSoft;
  _PrivateCapEntry(this.name, this.description, this.before, this.after,
      this.accent, this.accentSoft);
}

class _PrivateCapCard extends StatelessWidget {
  final _PrivateCapEntry entry;
  const _PrivateCapCard({required this.entry});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: entry.accentSoft,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              entry.name,
              style: TextStyle(
                color: entry.accent,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry.description,
            style: const TextStyle(color: _kInkSoft, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 12),
          _PrivateBeforeAfter(label: 'before', value: entry.before, accent: _kInkMuted),
          const SizedBox(height: 6),
          _PrivateBeforeAfter(label: 'after', value: entry.after, accent: entry.accent),
        ],
      ),
    );
  }
}

class _PrivateBeforeAfter extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;
  const _PrivateBeforeAfter({
    required this.label,
    required this.value,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kBorderSoft),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: TextStyle(
                color: accent,
                fontSize: 10,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 6 — keyboardAppearance Brightness comparison
// ===========================================================================
class _PrivateSection6Brightness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _PrivateSectionHeader(
              kicker: 'SECTION 6',
              title: 'keyboardAppearance: Brightness',
              subtitle:
                  'On iOS the IME chrome (background, key caps, suggestion bar) follows the requested brightness. '
                  'On Android the platform usually ignores this preference.',
              accent: _kAmber,
            ),
            const SizedBox(height: 16),
            LayoutBuilder(builder: (BuildContext ctx, BoxConstraints c) {
              final double w = c.maxWidth > 760 ? (c.maxWidth - 16) / 2 : c.maxWidth;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: <Widget>[
                  SizedBox(
                    width: w,
                    child: _PrivateBrightnessCard(
                      label: 'Brightness.light',
                      bg: const Color(0xFFE5E7EB),
                      keyCap: Colors.white,
                      keyText: _kInk,
                      accent: _kAccent,
                    ),
                  ),
                  SizedBox(
                    width: w,
                    child: _PrivateBrightnessCard(
                      label: 'Brightness.dark',
                      bg: const Color(0xFF1E293B),
                      keyCap: const Color(0xFF334155),
                      keyText: Colors.white,
                      accent: _kViolet,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PrivateBrightnessCard extends StatelessWidget {
  final String label;
  final Color bg;
  final Color keyCap;
  final Color keyText;
  final Color accent;
  const _PrivateBrightnessCard({
    required this.label,
    required this.bg,
    required this.keyCap,
    required this.keyText,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (final List<String> row in const <List<String>>[
            <String>['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
            <String>['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
            <String>['z', 'x', 'c', 'v', 'b', 'n', 'm']
          ])
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: row
                    .map<Widget>((String k) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            height: 30,
                            decoration: BoxDecoration(
                              color: keyCap,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              k,
                              style: TextStyle(
                                color: keyText,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  height: 30,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: keyCap,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text('123',
                      style: TextStyle(color: keyText, fontWeight: FontWeight.w600)),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  height: 30,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: keyCap,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text('space',
                      style: TextStyle(color: keyText, fontWeight: FontWeight.w600)),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 30,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: const Text('done',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 7 — autofillConfiguration deep-dive (chip cloud)
// ===========================================================================
class _PrivateSection7Autofill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PrivateAutofillChip> chips = <_PrivateAutofillChip>[
      _PrivateAutofillChip('email', Icons.alternate_email, _kAccent),
      _PrivateAutofillChip('username', Icons.person_outline, _kAccent),
      _PrivateAutofillChip('newUsername', Icons.person_add_alt_1, _kAccent),
      _PrivateAutofillChip('password', Icons.lock_outline, _kRose),
      _PrivateAutofillChip('newPassword', Icons.enhanced_encryption, _kRose),
      _PrivateAutofillChip('oneTimeCode', Icons.sms_outlined, _kViolet),
      _PrivateAutofillChip('telephoneNumber', Icons.phone_outlined, _kEmerald),
      _PrivateAutofillChip('telephoneNumberNational', Icons.phone_iphone, _kEmerald),
      _PrivateAutofillChip('name', Icons.badge_outlined, _kAmber),
      _PrivateAutofillChip('givenName', Icons.face_outlined, _kAmber),
      _PrivateAutofillChip('familyName', Icons.family_restroom, _kAmber),
      _PrivateAutofillChip('namePrefix', Icons.title, _kAmber),
      _PrivateAutofillChip('nameSuffix', Icons.subtitles_outlined, _kAmber),
      _PrivateAutofillChip('nickname', Icons.tag, _kAmber),
      _PrivateAutofillChip('streetAddressLine1', Icons.home_outlined, _kPink),
      _PrivateAutofillChip('streetAddressLine2', Icons.home_work_outlined, _kPink),
      _PrivateAutofillChip('addressCity', Icons.location_city, _kPink),
      _PrivateAutofillChip('addressState', Icons.map_outlined, _kPink),
      _PrivateAutofillChip('postalCode', Icons.markunread_mailbox_outlined, _kPink),
      _PrivateAutofillChip('countryName', Icons.flag_outlined, _kPink),
      _PrivateAutofillChip('creditCardNumber', Icons.credit_card, _kSlate),
      _PrivateAutofillChip('creditCardSecurityCode', Icons.password, _kSlate),
      _PrivateAutofillChip('creditCardExpirationDate', Icons.event, _kSlate),
      _PrivateAutofillChip('birthday', Icons.cake_outlined, _kViolet),
      _PrivateAutofillChip('gender', Icons.transgender, _kViolet),
      _PrivateAutofillChip('jobTitle', Icons.work_outline, _kSlate),
      _PrivateAutofillChip('organizationName', Icons.business, _kSlate),
    ];
    return _PrivateCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _PrivateSectionHeader(
              kicker: 'SECTION 7',
              title: 'autofillConfiguration & AutofillHints',
              subtitle:
                  'AutofillConfiguration carries a uniqueIdentifier plus a list of autofillHints. '
                  'The platform uses the hints to match the field to a saved credential, address, or card record.',
              accent: _kEmerald,
            ),
            const SizedBox(height: 16),
            // model card
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(
                color: _kPaper,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'AutofillConfiguration',
                    style: TextStyle(
                      color: _kInk,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'fields:',
                    style: TextStyle(color: _kInkMuted, fontSize: 11, letterSpacing: 0.6),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text('• uniqueIdentifier — String',
                            style: TextStyle(color: _kInkSoft, fontSize: 12, fontFamily: 'monospace')),
                        Text('• autofillHints     — List<String>',
                            style: TextStyle(color: _kInkSoft, fontSize: 12, fontFamily: 'monospace')),
                        Text('• currentEditingValue — TextEditingValue',
                            style: TextStyle(color: _kInkSoft, fontSize: 12, fontFamily: 'monospace')),
                        Text('• hintText           — String?',
                            style: TextStyle(color: _kInkSoft, fontSize: 12, fontFamily: 'monospace')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Common AutofillHints',
              style: TextStyle(
                color: _kInk,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: chips
                  .map<Widget>((c) => _PrivateAutofillPill(chip: c))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateAutofillChip {
  final String label;
  final IconData icon;
  final Color color;
  _PrivateAutofillChip(this.label, this.icon, this.color);
}

class _PrivateAutofillPill extends StatelessWidget {
  final _PrivateAutofillChip chip;
  const _PrivateAutofillPill({required this.chip});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 10, 6),
      decoration: BoxDecoration(
        color: chip.color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: chip.color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(chip.icon, color: chip.color, size: 14),
          const SizedBox(width: 6),
          Text(
            chip.label,
            style: TextStyle(
              color: chip.color,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 8 — Realistic constructor literal listing
// ===========================================================================
class _PrivateSection8CodeListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> lines = <String>[
      '// A login email field, ready for autofill, on iOS dark mode.',
      'final TextInputConfiguration loginEmail = TextInputConfiguration(',
      '  inputType: TextInputType.emailAddress,',
      '  readOnly: false,',
      '  obscureText: false,',
      '  autocorrect: false,',
      '  smartDashesType: SmartDashesType.disabled,',
      '  smartQuotesType: SmartQuotesType.disabled,',
      '  enableSuggestions: false,',
      '  enableInteractiveSelection: true,',
      '  actionLabel: \'Continue\',',
      '  inputAction: TextInputAction.next,',
      '  textCapitalization: TextCapitalization.none,',
      '  keyboardAppearance: Brightness.dark,',
      '  autofillConfiguration: AutofillConfiguration(',
      '    uniqueIdentifier: \'login.email\',',
      '    autofillHints: <String>[',
      '      AutofillHints.username,',
      '      AutofillHints.email,',
      '    ],',
      '    currentEditingValue: TextEditingValue.empty,',
      '  ),',
      '  enableIMEPersonalizedLearning: true,',
      '  allowedMimeTypes: const <String>[],',
      '  enableDeltaModel: false,',
      '  viewId: 0,',
      ');',
    ];
    return _PrivateCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _PrivateSectionHeader(
              kicker: 'SECTION 8',
              title: 'A realistic constructor literal',
              subtitle:
                  'Putting every field into one literal so you can see them sit together. '
                  'The line at the top would normally show up in a real form widget that handles login.',
              accent: _kViolet,
            ),
            const SizedBox(height: 16),
            _PrivateCodeBlock(
              title: 'login_form.dart',
              lines: lines,
              language: 'dart',
              maxHeight: 520,
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 9 — Pitfalls
// ===========================================================================
class _PrivateSection9Pitfalls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PrivatePitfall> pitfalls = <_PrivatePitfall>[
      _PrivatePitfall(
        title: 'enableDeltaModel demands a delta-aware client',
        body:
            'Setting enableDeltaModel: true switches the IME to send TextEditingDelta updates instead of '
            'whole TextEditingValue snapshots. Your TextInputClient must implement updateEditingValueWithDeltas '
            'or the field will silently misbehave.',
        accent: _kRose,
        accentSoft: _kRoseSoft,
        icon: Icons.warning_amber_rounded,
      ),
      _PrivatePitfall(
        title: 'obscureText turns off suggestions and autocorrect',
        body:
            'When obscureText is true the framework forces autocorrect = false and enableSuggestions = false '
            'regardless of what you pass. Trying to override is a no-op — and a security smell anyway.',
        accent: _kAmber,
        accentSoft: _kAmberSoft,
        icon: Icons.lock_clock,
      ),
      _PrivatePitfall(
        title: 'keyboardAppearance is iOS-only in practice',
        body:
            'Brightness.dark is honored on iOS, but Android typically ignores the request because the IME '
            'is a separate app. Don’t rely on it for visual consistency across platforms.',
        accent: _kViolet,
        accentSoft: _kVioletSoft,
        icon: Icons.brightness_4_outlined,
      ),
      _PrivatePitfall(
        title: 'smartDashes/Quotes are Apple-platform features',
        body:
            'These flags are passed through to UITextInputTraits on iOS/macOS. On Android and the web the '
            'value is simply forwarded but usually ignored.',
        accent: _kSlate,
        accentSoft: _kSlateSoft,
        icon: Icons.format_quote,
      ),
      _PrivatePitfall(
        title: 'allowedMimeTypes only matters on Android',
        body:
            'The list controls which mime types the IME’s commit-content channel may send (animated GIFs from '
            'Gboard, for example). Empty list = none. Other platforms ignore this field.',
        accent: _kEmerald,
        accentSoft: _kEmeraldSoft,
        icon: Icons.attach_file,
      ),
      _PrivatePitfall(
        title: 'viewId is required for multi-window IME routing',
        body:
            'When your app is multi-window (desktop / multi-display Android), the engine needs to know which '
            'FlutterView the IME should target. Leave viewId at the default for single-window apps.',
        accent: _kAccent,
        accentSoft: _kAccentSoft,
        icon: Icons.tab,
      ),
    ];
    return _PrivateCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _PrivateSectionHeader(
              kicker: 'SECTION 9',
              title: 'Pitfalls and platform notes',
              subtitle:
                  'A handful of behaviours that bite teams the first time they wire up a custom EditableText. '
                  'Skim before you ship a custom keyboard surface.',
              accent: _kRose,
            ),
            const SizedBox(height: 16),
            LayoutBuilder(builder: (BuildContext ctx, BoxConstraints c) {
              final int cols = c.maxWidth > 880 ? 2 : 1;
              final double cw = (c.maxWidth - (cols - 1) * 14) / cols;
              return Wrap(
                spacing: 14,
                runSpacing: 14,
                children: pitfalls
                    .map<Widget>((p) => SizedBox(
                          width: cw,
                          child: _PrivatePitfallCard(pitfall: p),
                        ))
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PrivatePitfall {
  final String title;
  final String body;
  final Color accent;
  final Color accentSoft;
  final IconData icon;
  _PrivatePitfall({
    required this.title,
    required this.body,
    required this.accent,
    required this.accentSoft,
    required this.icon,
  });
}

class _PrivatePitfallCard extends StatelessWidget {
  final _PrivatePitfall pitfall;
  const _PrivatePitfallCard({required this.pitfall});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: pitfall.accentSoft,
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Alignment.center,
            child: Icon(pitfall.icon, color: pitfall.accent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pitfall.title,
                  style: TextStyle(
                    color: pitfall.accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  pitfall.body,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 10 — Footer
// ===========================================================================
class _PrivateSection10Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
        child: Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _kAccentSoft,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.keyboard_alt_outlined, color: _kAccent, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'TextInputConfiguration deep demo',
                    style: TextStyle(
                      color: _kInk,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Visual reference for the platform-channel payload behind every Flutter TextField. '
                    'Part of the D4rt analyzer-free interpreter test corpus.',
                    style: TextStyle(
                      color: _kInkMuted,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _kPaper,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: _kBorder),
              ),
              child: const Text(
                'flutter/services.dart',
                style: TextStyle(
                  color: _kInkSoft,
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
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
// Reusable building blocks
// ===========================================================================
class _PrivateCard extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  const _PrivateCard({required this.child, this.gradient});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: gradient == null ? _kCard : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: child,
      ),
    );
  }
}

class _PrivateSectionHeader extends StatelessWidget {
  final String kicker;
  final String title;
  final String subtitle;
  final Color accent;
  const _PrivateSectionHeader({
    required this.kicker,
    required this.title,
    required this.subtitle,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            kicker,
            style: TextStyle(
              color: accent,
              fontSize: 11,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: _kInk,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: _kInkMuted,
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _PrivateCodeBlock extends StatelessWidget {
  final String title;
  final List<String> lines;
  final String language;
  final double? maxHeight;
  const _PrivateCodeBlock({
    required this.title,
    required this.lines,
    required this.language,
    this.maxHeight,
  });
  @override
  Widget build(BuildContext context) {
    final Widget content = Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < lines.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 28,
                    child: Text(
                      (i + 1).toString().padLeft(2, ' '),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      lines[i],
                      style: const TextStyle(
                        color: _kCodeText,
                        fontFamily: 'monospace',
                        fontSize: 12,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: _kCode,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // header strip
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: <Widget>[
                _PrivateTrafficLight(color: const Color(0xFFEF4444)),
                const SizedBox(width: 6),
                _PrivateTrafficLight(color: const Color(0xFFF59E0B)),
                const SizedBox(width: 6),
                _PrivateTrafficLight(color: const Color(0xFF10B981)),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    language,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (maxHeight != null)
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight!),
              child: SingleChildScrollView(child: content),
            )
          else
            content,
        ],
      ),
    );
  }
}

class _PrivateTrafficLight extends StatelessWidget {
  final Color color;
  const _PrivateTrafficLight({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9,
      height: 9,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _PrivateConsoleBlock extends StatelessWidget {
  final String title;
  final String text;
  const _PrivateConsoleBlock({required this.title, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.terminal, color: Color(0xFF22C55E), size: 13),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFA5F3FC),
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

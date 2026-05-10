// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// Visual deep demo: Flutter ProcessTextAction & ProcessTextService (Android Q+)
// Subject: package:flutter/services.dart -> ProcessTextAction, ProcessTextService
//
// ProcessTextAction(id, label) describes one entry that the Android system
// exposes through its text-processing intent registry: translators,
// dictionaries, share sheets, OEM custom actions. Flutter surfaces these so a
// TextField's selection toolbar can present "MORE" actions wired to real
// system services.
//
// This file is a hand-authored, analyzer-clean visual study used by the
// d4rt interpreter test corpus. It must run inside a static
// `dynamic build(BuildContext)` entry, with no async, no state, no timers.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Tokens
// ---------------------------------------------------------------------------

const Color _kBg = Color(0xFFF6F8FB);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kInk = Color(0xFF0F172A);
const Color _kInkSoft = Color(0xFF334155);
const Color _kInkMute = Color(0xFF64748B);
const Color _kLine = Color(0xFFE2E8F0);
const Color _kAccent = Color(0xFF2563EB);
const Color _kAccentSoft = Color(0xFFDBEAFE);
const Color _kGood = Color(0xFF16A34A);
const Color _kGoodSoft = Color(0xFFDCFCE7);
const Color _kWarn = Color(0xFFD97706);
const Color _kWarnSoft = Color(0xFFFEF3C7);
const Color _kBad = Color(0xFFDC2626);
const Color _kBadSoft = Color(0xFFFEE2E2);
const Color _kPurple = Color(0xFF7C3AED);
const Color _kPurpleSoft = Color(0xFFEDE9FE);
const Color _kTeal = Color(0xFF0D9488);
const Color _kTealSoft = Color(0xFFCCFBF1);
const Color _kPink = Color(0xFFDB2777);
const Color _kPinkSoft = Color(0xFFFCE7F3);
const Color _kAndroidGreen = Color(0xFF3DDC84);
const Color _kAndroidGreenSoft = Color(0xFFDCFCE7);

// ---------------------------------------------------------------------------
// Entry
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // A few illustrative ProcessTextAction instances. We can construct them
  // freely; calling processTextAction is async so we never invoke it here.
  final ProcessTextAction translateAction = ProcessTextAction(
    'com.google.translate/.action.PROCESS_TEXT',
    'Translate',
  );
  final ProcessTextAction searchAction = ProcessTextAction(
    'com.google.android.googlequicksearchbox/.SearchActivity',
    'Search Web',
  );
  final ProcessTextAction defineAction = ProcessTextAction(
    'com.android.dictionary/.DefineActivity',
    'Define',
  );

  final List<ProcessTextAction> sampleActions = <ProcessTextAction>[
    translateAction,
    searchAction,
    defineAction,
    ProcessTextAction('com.android.share/.ShareActivity', 'Share'),
    ProcessTextAction(
      'com.android.browser/.OpenUrlActivity',
      'Open URL',
    ),
    ProcessTextAction(
      'com.android.dictionary/.AddActivity',
      'Add to Dictionary',
    ),
    ProcessTextAction(
      'com.google.email/.ComposeActivity',
      'Send via Email',
    ),
    ProcessTextAction(
      'com.myapp.notes/.QuoteActivity',
      'Copy as Quote',
    ),
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ProcessTextAction Deep Demo',
    theme: ThemeData(
      scaffoldBackgroundColor: _kBg,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccent),
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _PrivateHeroCard(action: translateAction),
                const SizedBox(height: 28),
                _PrivateAnatomyCard(),
                const SizedBox(height: 28),
                _PrivateSampleActionsGallery(actions: sampleActions),
                const SizedBox(height: 28),
                _PrivateMockToolbarCard(actions: sampleActions),
                const SizedBox(height: 28),
                _PrivateRequestFlowDiagram(),
                const SizedBox(height: 28),
                _PrivateApiTableCard(),
                const SizedBox(height: 28),
                _PrivatePlatformAvailabilityCard(),
                const SizedBox(height: 28),
                _PrivateCodeListingCard(),
                const SizedBox(height: 28),
                _PrivateComparisonCard(),
                const SizedBox(height: 28),
                _PrivatePitfallsCard(),
                const SizedBox(height: 28),
                _PrivateFooterCard(actionCount: sampleActions.length),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: Hero Card
// ---------------------------------------------------------------------------

class _PrivateHeroCard extends StatelessWidget {
  const _PrivateHeroCard({required this.action});

  final ProcessTextAction action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kAccent, _kPurple],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kAccent.withValues(alpha: 0.25),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(
                        Icons.android,
                        size: 14,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'flutter/services.dart  ·  Android Q+',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'ProcessTextAction',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '+ ProcessTextService',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Android exposes installed text-processing services '
                  '(translator, dictionary, share, search, OEM extras) '
                  'through PROCESS_TEXT. Flutter surfaces them so your '
                  "TextField's selection toolbar can call them for you.",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 14.5,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 22),
                _PrivateHeroChipRow(action: action),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 5,
            child: _PrivateHeroSelectedTextGraphic(),
          ),
        ],
      ),
    );
  }
}

class _PrivateHeroChipRow extends StatelessWidget {
  const _PrivateHeroChipRow({required this.action});

  final ProcessTextAction action;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        _PrivateHeroChip(label: 'id: ${action.id.split('/').first}'),
        _PrivateHeroChip(label: 'label: ${action.label}'),
        _PrivateHeroChip(label: 'queryTextActions()'),
        _PrivateHeroChip(label: 'processTextAction()'),
        _PrivateHeroChip(label: 'contextMenuBuilder'),
      ],
    );
  }
}

class _PrivateHeroChip extends StatelessWidget {
  const _PrivateHeroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.32),
        ),
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

class _PrivateHeroSelectedTextGraphic extends StatelessWidget {
  const _PrivateHeroSelectedTextGraphic();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.18),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _PrivateDot(color: const Color(0xFFFF5F57)),
              const SizedBox(width: 6),
              _PrivateDot(color: const Color(0xFFFEBC2E)),
              const SizedBox(width: 6),
              _PrivateDot(color: const Color(0xFF28C840)),
              const SizedBox(width: 12),
              Text(
                'TextField · selection',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 13.5,
                  height: 1.5,
                ),
                children: <TextSpan>[
                  const TextSpan(text: 'The quick brown '),
                  TextSpan(
                    text: 'fox jumps over',
                    style: TextStyle(
                      backgroundColor: _kAccent.withValues(alpha: 0.32),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: ' the lazy dog.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                _PrivateToolbarMockBtn(label: 'Cut', icon: Icons.cut),
                _PrivateToolbarMockBtn(label: 'Copy', icon: Icons.copy),
                _PrivateToolbarMockBtn(label: 'Paste', icon: Icons.paste),
                _PrivateToolbarMockBtn(label: 'More', icon: Icons.more_vert),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '↳ "More" expands ProcessTextActions',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateDot extends StatelessWidget {
  const _PrivateDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _PrivateToolbarMockBtn extends StatelessWidget {
  const _PrivateToolbarMockBtn({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section: Anatomy of ProcessTextAction(id, label)
// ---------------------------------------------------------------------------

class _PrivateAnatomyCard extends StatelessWidget {
  const _PrivateAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateSectionCard(
      number: '01',
      title: 'Anatomy of ProcessTextAction(id, label)',
      subtitle: 'Two String fields. That is the entire shape.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _PrivateCodeLine(
                  '@immutable',
                  color: _kPurpleSoft,
                ),
                _PrivateCodeLine(
                  'class ProcessTextAction {',
                  color: Colors.white,
                ),
                _PrivateCodeLine(
                  '  const ProcessTextAction(',
                  color: Colors.white,
                ),
                _PrivateCodeLine(
                  '    this.id,',
                  color: _kAccentSoft,
                ),
                _PrivateCodeLine(
                  '    this.label,',
                  color: _kAccentSoft,
                ),
                _PrivateCodeLine(
                  '  );',
                  color: Colors.white,
                ),
                _PrivateCodeLine(
                  '',
                  color: Colors.white,
                ),
                _PrivateCodeLine(
                  '  final String id;     // unique action identifier',
                  color: _kGoodSoft,
                ),
                _PrivateCodeLine(
                  '  final String label;  // human-readable button text',
                  color: _kGoodSoft,
                ),
                _PrivateCodeLine(
                  '}',
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _PrivateFieldCard(
                  tag: 'String',
                  name: 'id',
                  description: 'Unique action identifier the platform uses '
                      'to dispatch processTextAction(id, ...). On Android '
                      'this maps to the activity component name from the '
                      'PROCESS_TEXT intent registry.',
                  example: 'com.google.translate/.action.PROCESS_TEXT',
                  color: _kAccent,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _PrivateFieldCard(
                  tag: 'String',
                  name: 'label',
                  description: 'Localized display name returned by the '
                      'service. Show this verbatim — it is already '
                      "translated to the user's locale.",
                  example: 'Translate',
                  color: _kPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateCodeLine extends StatelessWidget {
  const _PrivateCodeLine(this.text, {required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        text.isEmpty ? ' ' : text,
        style: TextStyle(
          color: color,
          fontSize: 12.5,
          fontFamily: 'monospace',
          height: 1.5,
        ),
      ),
    );
  }
}

class _PrivateFieldCard extends StatelessWidget {
  const _PrivateFieldCard({
    required this.tag,
    required this.name,
    required this.description,
    required this.example,
    required this.color,
  });

  final String tag;
  final String name;
  final String description;
  final String example;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              example,
              style: const TextStyle(
                color: Color(0xFFA7F3D0),
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section: Sample Actions Gallery
// ---------------------------------------------------------------------------

class _PrivateSampleActionsGallery extends StatelessWidget {
  const _PrivateSampleActionsGallery({required this.actions});

  final List<ProcessTextAction> actions;

  @override
  Widget build(BuildContext context) {
    final List<_PrivateActionStyle> styles = <_PrivateActionStyle>[
      const _PrivateActionStyle(
        icon: Icons.translate,
        bg: _kAccentSoft,
        fg: _kAccent,
        purpose: 'Sends selection to a translator app, returns translation.',
      ),
      const _PrivateActionStyle(
        icon: Icons.search,
        bg: _kPurpleSoft,
        fg: _kPurple,
        purpose: 'Opens default search engine with the selected text query.',
      ),
      const _PrivateActionStyle(
        icon: Icons.menu_book_outlined,
        bg: _kGoodSoft,
        fg: _kGood,
        purpose: 'Looks up dictionary definition; may return inline result.',
      ),
      const _PrivateActionStyle(
        icon: Icons.share_outlined,
        bg: _kPinkSoft,
        fg: _kPink,
        purpose: 'Routes the selection through the Android share sheet.',
      ),
      const _PrivateActionStyle(
        icon: Icons.open_in_browser,
        bg: _kTealSoft,
        fg: _kTeal,
        purpose: 'Treats selection as URL and hands it to the browser.',
      ),
      const _PrivateActionStyle(
        icon: Icons.spellcheck,
        bg: _kWarnSoft,
        fg: _kWarn,
        purpose: 'Adds the word to the user dictionary for autocomplete.',
      ),
      const _PrivateActionStyle(
        icon: Icons.mail_outline,
        bg: _kAccentSoft,
        fg: _kAccent,
        purpose: 'Opens default mail client with selection in the body.',
      ),
      const _PrivateActionStyle(
        icon: Icons.format_quote_outlined,
        bg: _kPurpleSoft,
        fg: _kPurple,
        purpose: 'Custom OEM action: rewrites selection as a block quote.',
      ),
    ];

    return _PrivateSectionCard(
      number: '02',
      title: 'Sample actions gallery',
      subtitle: 'Eight realistic Android system actions, each rendered as '
          'a styled toolbar button mock.',
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: <Widget>[
          for (int i = 0; i < actions.length; i++)
            SizedBox(
              width: 280,
              child: _PrivateActionGalleryTile(
                action: actions[i],
                style: styles[i % styles.length],
                index: i,
              ),
            ),
        ],
      ),
    );
  }
}

class _PrivateActionStyle {
  const _PrivateActionStyle({
    required this.icon,
    required this.bg,
    required this.fg,
    required this.purpose,
  });

  final IconData icon;
  final Color bg;
  final Color fg;
  final String purpose;
}

class _PrivateActionGalleryTile extends StatelessWidget {
  const _PrivateActionGalleryTile({
    required this.action,
    required this.style,
    required this.index,
  });

  final ProcessTextAction action;
  final _PrivateActionStyle style;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kLine),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: style.bg,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(style.icon, color: style.fg, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      action.label,
                      style: const TextStyle(
                        color: _kInk,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '#${index.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: _kInkMute,
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              border: Border.all(color: _kLine),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              action.id,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 10.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            style.purpose,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section: Mock Android Selection Toolbar
// ---------------------------------------------------------------------------

class _PrivateMockToolbarCard extends StatelessWidget {
  const _PrivateMockToolbarCard({required this.actions});

  final List<ProcessTextAction> actions;

  @override
  Widget build(BuildContext context) {
    return _PrivateSectionCard(
      number: '03',
      title: 'Android selection toolbar mock',
      subtitle: 'Cut · Copy · Paste · ▸ MORE — the "MORE" panel is what '
          'queryTextActions() populates.',
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kLine),
        ),
        child: Column(
          children: <Widget>[
            // Faux phone screen with TextField.
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kLine),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Note',
                    style: TextStyle(
                      color: _kInkMute,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: _kInk,
                        fontSize: 15,
                        height: 1.5,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'Le renard '),
                        TextSpan(
                          text: 'brun rapide',
                          style: TextStyle(
                            backgroundColor: _kAccent.withValues(alpha: 0.30),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(text: ' saute par-dessus.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Toolbar
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _kInk.withValues(alpha: 0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  _PrivateRealToolbarBtn(label: 'Cut', icon: Icons.cut),
                  _PrivateToolbarSeparator(),
                  _PrivateRealToolbarBtn(label: 'Copy', icon: Icons.copy),
                  _PrivateToolbarSeparator(),
                  _PrivateRealToolbarBtn(label: 'Paste', icon: Icons.paste),
                  _PrivateToolbarSeparator(),
                  _PrivateRealToolbarBtn(
                    label: 'Select all',
                    icon: Icons.select_all,
                  ),
                  _PrivateToolbarSeparator(),
                  _PrivateRealToolbarBtn(
                    label: 'More',
                    icon: Icons.arrow_forward_ios,
                    highlight: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Icon(
              Icons.south,
              color: _kInkMute,
              size: 18,
            ),
            const SizedBox(height: 10),
            // Sub-menu: ProcessTextAction list
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kLine),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _kInk.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.bolt,
                          size: 14,
                          color: _kAndroidGreen,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'queryTextActions() · ${actions.length} services',
                          style: const TextStyle(
                            color: _kInkSoft,
                            fontSize: 11.5,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: _kLine,
                  ),
                  for (int i = 0; i < actions.length; i++) ...<Widget>[
                    _PrivateMoreMenuItem(action: actions[i]),
                    if (i != actions.length - 1)
                      const Divider(
                        height: 1,
                        indent: 14,
                        endIndent: 14,
                        color: _kLine,
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateRealToolbarBtn extends StatelessWidget {
  const _PrivateRealToolbarBtn({
    required this.label,
    required this.icon,
    this.highlight = false,
  });

  final String label;
  final IconData icon;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: highlight
            ? _kAccent.withValues(alpha: 0.30)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateToolbarSeparator extends StatelessWidget {
  const _PrivateToolbarSeparator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 18,
      color: Colors.white.withValues(alpha: 0.14),
    );
  }
}

class _PrivateMoreMenuItem extends StatelessWidget {
  const _PrivateMoreMenuItem({required this.action});

  final ProcessTextAction action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: _kAccentSoft,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.extension_outlined,
              size: 14,
              color: _kAccent,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  action.label,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  action.id,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _kInkMute,
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: _kInkMute,
            size: 16,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section: Request Flow Diagram
// ---------------------------------------------------------------------------

class _PrivateRequestFlowDiagram extends StatelessWidget {
  const _PrivateRequestFlowDiagram();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateFlowStep> steps = <_PrivateFlowStep>[
      const _PrivateFlowStep(
        index: '1',
        title: 'TextField selection',
        subtitle: 'User selects text; the framework triggers '
            'EditableTextState._handleSelectionChanged.',
        icon: Icons.text_fields_outlined,
        color: _kAccent,
      ),
      const _PrivateFlowStep(
        index: '2',
        title: 'contextMenuBuilder fires',
        subtitle: 'The TextField asks your contextMenuBuilder for the '
            'AdaptiveTextSelectionToolbar.',
        icon: Icons.menu_open,
        color: _kPurple,
      ),
      const _PrivateFlowStep(
        index: '3',
        title: 'queryTextActions()',
        subtitle: 'DefaultProcessTextService asks Android for installed '
            'PROCESS_TEXT services -> List<ProcessTextAction>.',
        icon: Icons.cloud_download_outlined,
        color: _kTeal,
      ),
      const _PrivateFlowStep(
        index: '4',
        title: 'Render buttons',
        subtitle: 'For each ProcessTextAction, append a '
            'ContextMenuButtonItem(label: action.label).',
        icon: Icons.grid_view_outlined,
        color: _kGood,
      ),
      const _PrivateFlowStep(
        index: '5',
        title: 'processTextAction(id, text, readOnly)',
        subtitle: 'On tap, dispatch by id. The platform launches the '
            'service with the selected text.',
        icon: Icons.send_rounded,
        color: _kWarn,
      ),
      const _PrivateFlowStep(
        index: '6',
        title: 'IME callback updates text',
        subtitle: 'If the service returns a String, framework replaces the '
            'selection. If null or readOnly, no edit is applied.',
        icon: Icons.swap_horiz,
        color: _kPink,
      ),
    ];

    return _PrivateSectionCard(
      number: '04',
      title: 'Request flow diagram',
      subtitle: 'Selection -> contextMenuBuilder -> queryTextActions -> '
          'render -> processTextAction -> IME callback',
      child: Column(
        children: <Widget>[
          for (int i = 0; i < steps.length; i++) ...<Widget>[
            _PrivateFlowStepTile(step: steps[i]),
            if (i != steps.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 28),
                    Container(
                      width: 2,
                      height: 18,
                      color: _kLine,
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _PrivateFlowStep {
  const _PrivateFlowStep({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String index;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}

class _PrivateFlowStepTile extends StatelessWidget {
  const _PrivateFlowStepTile({required this.step});

  final _PrivateFlowStep step;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: step.color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: step.color.withValues(alpha: 0.32)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: step.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: <Widget>[
                Center(child: Icon(step.icon, color: Colors.white, size: 24)),
                Positioned(
                  top: 4,
                  left: 6,
                  child: Text(
                    step.index,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.78),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  step.title,
                  style: TextStyle(
                    color: step.color,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step.subtitle,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 13,
                    height: 1.5,
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

// ---------------------------------------------------------------------------
// Section: ProcessTextService API table
// ---------------------------------------------------------------------------

class _PrivateApiTableCard extends StatelessWidget {
  const _PrivateApiTableCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateApiRow> rows = <_PrivateApiRow>[
      const _PrivateApiRow(
        kind: 'abstract',
        signature: 'class ProcessTextService',
        purpose: 'Interface every text-processing backend implements. '
            'Override to inject a fake in tests.',
        kindColor: _kPurple,
      ),
      const _PrivateApiRow(
        kind: 'class',
        signature: 'class DefaultProcessTextService extends ProcessTextService',
        purpose: 'Production implementation that talks to the platform '
            'channel SystemChannels.processText.',
        kindColor: _kAccent,
      ),
      const _PrivateApiRow(
        kind: 'method',
        signature:
            'Future<List<ProcessTextAction>> queryTextActions()',
        purpose: 'Returns every ProcessTextAction registered on the device. '
            'Empty list on non-Android. Cache the result; it rarely changes.',
        kindColor: _kTeal,
      ),
      const _PrivateApiRow(
        kind: 'method',
        signature:
            'Future<String?> processTextAction(String id, String text, '
                'bool readOnly)',
        purpose: 'Dispatches the action by id. Returns processed String, or '
            'null if the service refused or only displayed a UI.',
        kindColor: _kGood,
      ),
      const _PrivateApiRow(
        kind: 'flag',
        signature: 'bool readOnly  // hint: true if field cannot accept edits',
        purpose: 'When true, the platform should pick non-editing actions '
            '(translate, share) and skip "Add to dictionary"-style edits.',
        kindColor: _kWarn,
      ),
      const _PrivateApiRow(
        kind: 'channel',
        signature: 'SystemChannels.processText',
        purpose: 'MethodChannel used under the hood; you almost never need '
            'to talk to it directly.',
        kindColor: _kPink,
      ),
    ];

    return _PrivateSectionCard(
      number: '05',
      title: 'ProcessTextService API table',
      subtitle: 'queryTextActions() + processTextAction() — that is the '
          'whole surface area.',
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _kLine),
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              color: const Color(0xFFF8FAFC),
              child: Row(
                children: const <Widget>[
                  SizedBox(
                    width: 90,
                    child: Text(
                      'KIND',
                      style: TextStyle(
                        color: _kInkMute,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'SIGNATURE',
                      style: TextStyle(
                        color: _kInkMute,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'PURPOSE',
                      style: TextStyle(
                        color: _kInkMute,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < rows.length; i++)
              _PrivateApiRowTile(
                row: rows[i],
                even: i.isEven,
              ),
          ],
        ),
      ),
    );
  }
}

class _PrivateApiRow {
  const _PrivateApiRow({
    required this.kind,
    required this.signature,
    required this.purpose,
    required this.kindColor,
  });

  final String kind;
  final String signature;
  final String purpose;
  final Color kindColor;
}

class _PrivateApiRowTile extends StatelessWidget {
  const _PrivateApiRowTile({required this.row, required this.even});

  final _PrivateApiRow row;
  final bool even;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: even ? Colors.white : const Color(0xFFFAFBFC),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 90,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: row.kindColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                row.kind,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: row.kindColor,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: Text(
              row.signature,
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
                fontFamily: 'monospace',
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: Text(
              row.purpose,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section: Platform Availability
// ---------------------------------------------------------------------------

class _PrivatePlatformAvailabilityCard extends StatelessWidget {
  const _PrivatePlatformAvailabilityCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateSectionCard(
      number: '06',
      title: 'Platform availability',
      subtitle: 'Android only on devices. Plan a fallback for everywhere '
          'else.',
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              Expanded(
                child: _PrivatePlatformTile(
                  name: 'Android 26+',
                  status: 'queryTextActions',
                  detail: 'Full ProcessTextService — registry queries + '
                      'IME callback. This is what Flutter wires up.',
                  color: _kGood,
                  bg: _kGoodSoft,
                  icon: Icons.check_circle,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _PrivatePlatformTile(
                  name: 'Android 23+',
                  status: 'legacy intent',
                  detail: 'Older PROCESS_TEXT intent path; activities with '
                      'ACTION_PROCESS_TEXT receive the selection.',
                  color: _kWarn,
                  bg: _kWarnSoft,
                  icon: Icons.history,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: const <Widget>[
              Expanded(
                child: _PrivatePlatformTile(
                  name: 'iOS / macOS',
                  status: 'returns []',
                  detail: 'No PROCESS_TEXT analogue. queryTextActions '
                      'always resolves to an empty list.',
                  color: _kInkMute,
                  bg: Color(0xFFF1F5F9),
                  icon: Icons.do_not_disturb_alt,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _PrivatePlatformTile(
                  name: 'Web / Linux / Win',
                  status: 'returns []',
                  detail: 'Same — empty list. Use ContextMenuButtonItem if '
                      'you want a custom menu cross-platform.',
                  color: _kInkMute,
                  bg: Color(0xFFF1F5F9),
                  icon: Icons.do_not_disturb_alt,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivatePlatformTile extends StatelessWidget {
  const _PrivatePlatformTile({
    required this.name,
    required this.status,
    required this.detail,
    required this.color,
    required this.bg,
    required this.icon,
  });

  final String name;
  final String status;
  final String detail;
  final Color color;
  final Color bg;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            status,
            style: const TextStyle(
              color: _kInk,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            detail,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section: Code Listing — custom contextMenuBuilder
// ---------------------------------------------------------------------------

class _PrivateCodeListingCard extends StatelessWidget {
  const _PrivateCodeListingCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateCodeRow> lines = <_PrivateCodeRow>[
      const _PrivateCodeRow('TextField(', _kCodeKw),
      const _PrivateCodeRow("  decoration: const InputDecoration(", _kCodePlain),
      const _PrivateCodeRow(
        "    labelText: 'Type and select to discover actions',",
        _kCodeStr,
      ),
      const _PrivateCodeRow('  ),', _kCodePlain),
      const _PrivateCodeRow(
        '  contextMenuBuilder: (context, editableTextState) {',
        _kCodeFn,
      ),
      const _PrivateCodeRow(
        '    final svc = DefaultProcessTextService();',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '    return FutureBuilder<List<ProcessTextAction>>(',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '      future: svc.queryTextActions(),',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '      builder: (context, snapshot) {',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '        final actions = snapshot.data ?? const [];',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '        final extra = <ContextMenuButtonItem>[',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '          for (final a in actions)',
        _kCodeKw,
      ),
      const _PrivateCodeRow(
        '            ContextMenuButtonItem(',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '              label: a.label,',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '              onPressed: () async {',
        _kCodeFn,
      ),
      const _PrivateCodeRow(
        '                final sel = editableTextState'
            '.textEditingValue.selection;',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '                final text = sel.textInside('
            'editableTextState.textEditingValue.text);',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '                final out = await svc.processTextAction('
            'a.id, text, false);',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '                if (out != null) {',
        _kCodeKw,
      ),
      const _PrivateCodeRow(
        '                  editableTextState.userUpdateTextEditingValue(',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '                    editableTextState.textEditingValue.replaced('
            'sel, out),',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '                    SelectionChangedCause.toolbar,',
        _kCodePlain,
      ),
      const _PrivateCodeRow('                  );', _kCodePlain),
      const _PrivateCodeRow('                }', _kCodePlain),
      const _PrivateCodeRow(
        '                editableTextState.hideToolbar();',
        _kCodePlain,
      ),
      const _PrivateCodeRow('              },', _kCodePlain),
      const _PrivateCodeRow('            ),', _kCodePlain),
      const _PrivateCodeRow('        ];', _kCodePlain),
      const _PrivateCodeRow(
        '        return AdaptiveTextSelectionToolbar.buttonItems(',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '          anchors: editableTextState.contextMenuAnchors,',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '          buttonItems: <ContextMenuButtonItem>[',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '            ...editableTextState.contextMenuButtonItems,',
        _kCodePlain,
      ),
      const _PrivateCodeRow(
        '            ...extra,',
        _kCodePlain,
      ),
      const _PrivateCodeRow('          ],', _kCodePlain),
      const _PrivateCodeRow('        );', _kCodePlain),
      const _PrivateCodeRow('      },', _kCodePlain),
      const _PrivateCodeRow('    );', _kCodePlain),
      const _PrivateCodeRow('  },', _kCodePlain),
      const _PrivateCodeRow(')', _kCodeKw),
    ];

    return _PrivateSectionCard(
      number: '07',
      title: 'Custom contextMenuBuilder with ProcessTextActions',
      subtitle: 'Drop the queried actions into '
          'AdaptiveTextSelectionToolbar.buttonItems.',
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
        decoration: BoxDecoration(
          color: const Color(0xFF0B1220),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _kAndroidGreen.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'lib/widgets/process_text_field.dart',
                    style: TextStyle(
                      color: _kAndroidGreen,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (int i = 0; i < lines.length; i++)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 30,
                    child: Text(
                      (i + 1).toString().padLeft(2, ' '),
                      style: const TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 11.5,
                        fontFamily: 'monospace',
                        height: 1.55,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      lines[i].text,
                      style: TextStyle(
                        color: lines[i].color,
                        fontSize: 12.5,
                        fontFamily: 'monospace',
                        height: 1.55,
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
}

const Color _kCodePlain = Color(0xFFE2E8F0);
const Color _kCodeKw = Color(0xFFC4B5FD);
const Color _kCodeStr = Color(0xFFFCD34D);
const Color _kCodeFn = Color(0xFF93C5FD);

class _PrivateCodeRow {
  const _PrivateCodeRow(this.text, this.color);

  final String text;
  final Color color;
}

// ---------------------------------------------------------------------------
// Section: Comparison — ProcessTextAction vs ContextMenuButtonItem
// ---------------------------------------------------------------------------

class _PrivateComparisonCard extends StatelessWidget {
  const _PrivateComparisonCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateSectionCard(
      number: '08',
      title: 'ProcessTextAction vs ContextMenuButtonItem',
      subtitle: 'They are not interchangeable. ProcessTextAction is what '
          'the OS sends you. ContextMenuButtonItem is what you build.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _PrivateCompareColumn(
              title: 'ProcessTextAction',
              subtitle: 'comes from Android',
              accent: _kAndroidGreen,
              accentSoft: _kAndroidGreenSoft,
              rows: const <_PrivateCompareRow>[
                _PrivateCompareRow(
                  point: 'Source',
                  value: 'Platform-provided via DefaultProcessTextService',
                ),
                _PrivateCompareRow(
                  point: 'Identity',
                  value: 'Opaque String id that the system dispatches',
                ),
                _PrivateCompareRow(
                  point: 'Localization',
                  value: 'label is already localized by the OS',
                ),
                _PrivateCompareRow(
                  point: 'Behavior',
                  value: 'Triggered through processTextAction(id, ...)',
                ),
                _PrivateCompareRow(
                  point: 'Reach',
                  value: 'Includes user-installed apps you do not know about',
                ),
                _PrivateCompareRow(
                  point: 'Cross-platform',
                  value: 'Empty list outside Android',
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _PrivateCompareColumn(
              title: 'ContextMenuButtonItem',
              subtitle: 'you build it yourself',
              accent: _kAccent,
              accentSoft: _kAccentSoft,
              rows: const <_PrivateCompareRow>[
                _PrivateCompareRow(
                  point: 'Source',
                  value: 'Authored by you in contextMenuBuilder',
                ),
                _PrivateCompareRow(
                  point: 'Identity',
                  value: 'No id; identity is the closure you supply',
                ),
                _PrivateCompareRow(
                  point: 'Localization',
                  value: 'You localize the label yourself',
                ),
                _PrivateCompareRow(
                  point: 'Behavior',
                  value: 'Runs your onPressed callback directly',
                ),
                _PrivateCompareRow(
                  point: 'Reach',
                  value: 'Only what you hard-code into the toolbar',
                ),
                _PrivateCompareRow(
                  point: 'Cross-platform',
                  value: 'Works everywhere TextField runs',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateCompareRow {
  const _PrivateCompareRow({required this.point, required this.value});

  final String point;
  final String value;
}

class _PrivateCompareColumn extends StatelessWidget {
  const _PrivateCompareColumn({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.accentSoft,
    required this.rows,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final Color accentSoft;
  final List<_PrivateCompareRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentSoft,
        border: Border.all(color: accent.withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: accent.withValues(alpha: 0.8),
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          for (final _PrivateCompareRow row in rows) ...<Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kLine),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    row.point.toUpperCase(),
                    style: const TextStyle(
                      color: _kInkMute,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    row.value,
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
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section: Pitfalls
// ---------------------------------------------------------------------------

class _PrivatePitfallsCard extends StatelessWidget {
  const _PrivatePitfallsCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivatePitfall> pitfalls = <_PrivatePitfall>[
      const _PrivatePitfall(
        title: 'Android-only on real devices',
        body: 'Outside Android the platform channel returns an empty list. '
            'Wrap UI affordances in defaultTargetPlatform checks so you do '
            'not show a "more" arrow that opens to nothing.',
        color: _kBad,
        bg: _kBadSoft,
        icon: Icons.do_not_disturb_alt,
      ),
      const _PrivatePitfall(
        title: 'processTextAction can return null',
        body: "Many services don't actually return text — they just open "
            'their own UI (translator overlay, share sheet). null does not '
            'mean "error", it means "no replacement". Never throw on null.',
        color: _kWarn,
        bg: _kWarnSoft,
        icon: Icons.warning_amber_rounded,
      ),
      const _PrivatePitfall(
        title: 'Empty list != unavailable',
        body: 'queryTextActions() can legitimately return [] on a clean '
            'Android device with no PROCESS_TEXT-registered apps. Always '
            'render the menu without these extras when the list is empty.',
        color: _kAccent,
        bg: _kAccentSoft,
        icon: Icons.info_outline,
      ),
      const _PrivatePitfall(
        title: 'readOnly flag is a hint',
        body: 'When the field is read-only, pass readOnly: true. Some '
            'services use this to skip mutating actions; passing the wrong '
            'value can produce edits the user cannot accept.',
        color: _kPurple,
        bg: _kPurpleSoft,
        icon: Icons.lock_outline,
      ),
      const _PrivatePitfall(
        title: 'Do not call from build()',
        body: 'queryTextActions is async. Hold the result in a State or '
            'FutureBuilder. The contextMenuBuilder is the recommended hook.',
        color: _kTeal,
        bg: _kTealSoft,
        icon: Icons.timer_outlined,
      ),
      const _PrivatePitfall(
        title: 'Cache the action list',
        body: 'It rarely changes during a session. Repeatedly calling the '
            'platform channel for every selection is wasteful and adds '
            'latency to the toolbar.',
        color: _kGood,
        bg: _kGoodSoft,
        icon: Icons.cached_outlined,
      ),
    ];

    return _PrivateSectionCard(
      number: '09',
      title: 'Pitfalls',
      subtitle: 'Six things that quietly bite when you wire ProcessText '
          'into a real app.',
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: <Widget>[
          for (final _PrivatePitfall p in pitfalls)
            SizedBox(width: 360, child: _PrivatePitfallTile(pitfall: p)),
        ],
      ),
    );
  }
}

class _PrivatePitfall {
  const _PrivatePitfall({
    required this.title,
    required this.body,
    required this.color,
    required this.bg,
    required this.icon,
  });

  final String title;
  final String body;
  final Color color;
  final Color bg;
  final IconData icon;
}

class _PrivatePitfallTile extends StatelessWidget {
  const _PrivatePitfallTile({required this.pitfall});

  final _PrivatePitfall pitfall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pitfall.bg,
        border: Border.all(color: pitfall.color.withValues(alpha: 0.42)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: pitfall.color,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(pitfall.icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pitfall.title,
                  style: TextStyle(
                    color: pitfall.color,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pitfall.body,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
                    height: 1.5,
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

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

class _PrivateFooterCard extends StatelessWidget {
  const _PrivateFooterCard({required this.actionCount});

  final int actionCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _kAndroidGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.android, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'ProcessTextAction · ProcessTextService',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Android Q+ text-processing surface — $actionCount '
                  'sample actions illustrated.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'flutter/services.dart',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable section card
// ---------------------------------------------------------------------------

class _PrivateSectionCard extends StatelessWidget {
  const _PrivateSectionCard({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String number;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kLine),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _kAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    letterSpacing: 0.5,
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
                        color: _kInk,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _kInkMute,
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

// =============================================================================
// Selection Readout Panel — a deep visual demo for the d4rt AST test harness.
// -----------------------------------------------------------------------------
// IMPORTANT NOTE ON THE SUBJECT CLASS
// -----------------------------------------------------------------------------
// The original brief named this demo after `SelectionDetails`. However, in the
// pinned Flutter 3.41.6 SDK that this workspace uses there is NO such class.
// A `grep` across `/srv/flutter/flutter/packages/flutter/lib/` confirms:
//
//   * `class SelectionDetails`  -> NOT FOUND.
//   * `class SelectedContent`   -> rendering/selection.dart:200  (plainText).
//   * `class SelectionGeometry` -> rendering/selection.dart:733  (points,
//                                                                 rects,
//                                                                 status,
//                                                                 hasContent).
//   * `class SelectedContentRange` -> rendering/selection.dart:125 (startOffset,
//                                                                   endOffset).
//
// The de-facto "selection details" API in Flutter 3.41.6 is therefore the
// combination of `SelectedContent` (the text payload) plus `SelectionGeometry`
// (the rects, handles and status) — so this demo pivots to THAT pair. Each
// panel in this file is labelled consistently, and the instructional cards
// explain the split.
//
// This file is executed by the d4rt AST harness. It deliberately follows the
// harness contract:
//   * `dynamic build(BuildContext context)` is the single entry point.
//   * There is NO `main()` and NO `runApp()` — the harness wires those up.
//   * The only imports are `package:flutter/material.dart` and `dart:math`.
//   * No `// ignore_for_file:` directives, no analyzer suppressions, no
//     changes to `analysis_options.yaml`, no deprecated APIs, and `debugPrint`
//     is used instead of `print`.
//   * Colour alpha is always set via `withValues(alpha: ...)`.
//
// UX PALETTE
//   * terracotta  #E76F51   — the "selected" / accent colour.
//   * ink         #264653   — primary text and chrome.
//   * parchment   #F4F1DE   — page / card background.
// =============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// PALETTE CONSTANTS
// -----------------------------------------------------------------------------

const Color _kTerracotta = Color(0xFFE76F51);
const Color _kInk = Color(0xFF264653);
const Color _kParchment = Color(0xFFF4F1DE);
const Color _kInkSoft = Color(0xFF3D5A68);
const Color _kInkFaint = Color(0xFF7A8E97);
const Color _kParchmentDeep = Color(0xFFE9E3C7);
const Color _kTerracottaSoft = Color(0xFFF2B8A2);
const Color _kSage = Color(0xFF8AB17D);

// -----------------------------------------------------------------------------
// PASSAGE DATA — three short paragraphs used as the primary selection target.
// -----------------------------------------------------------------------------

const String _kParagraphOne =
    'Selection in Flutter is not a single object — it is a conversation '
    'between the SelectionArea above, the Selectable mixin below, and a '
    'SelectionRegistrar that keeps them in sync. What the application '
    'finally sees, via onSelectionChanged, is a SelectedContent whose only '
    'field is plainText. The geometry — rects, handles, line heights — '
    'lives on SelectionGeometry, which is exposed to platform handles but '
    'not directly to application code.';

const String _kParagraphTwo =
    'Think of SelectedContent as the "what" and SelectionGeometry as the '
    '"where". The what is a flat string: even when the underlying text has '
    'rich spans, widget spans, or nested SelectableRegions, plainText is '
    'flattened into a single readable sequence. The where is a list of '
    'Rect objects that the handles, magnifier and toolbar all use to '
    'anchor themselves, plus two SelectionPoints for the start and end.';

const String _kParagraphThree =
    'A SelectedContentRange complements both: it records start and end '
    'offsets relative to the Selectable that owns the content, so that '
    'higher-level widgets can turn the selection back into structural '
    'edits. When no selection is active, the callback fires with null, '
    'plainText becomes unreachable, and SelectionGeometry.status reports '
    'SelectionStatus.none. All three pieces of the puzzle — content, '
    'range, geometry — arrive together, but never as a single object.';

const List<String> _kParagraphs = <String>[
  _kParagraphOne,
  _kParagraphTwo,
  _kParagraphThree,
];

// Secondary passages for the multi-region demo.
const String _kSecondaryPassageA =
    'Region A. Each SelectionArea maintains its own onSelectionChanged '
    'stream. Selecting text here does not disturb the other region: the '
    'sidebar readout for Region B stays empty until you drag across its '
    'own passage.';

const String _kSecondaryPassageB =
    'Region B. A SelectionArea is scoped to its subtree. Two sibling '
    'SelectionAreas therefore behave like two independent selection '
    'universes, each with its own SelectedContent and its own geometry, '
    'their plainText strings never concatenated.';

// -----------------------------------------------------------------------------
// HARNESS ENTRY POINT
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Selection Readout Panel',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: _kTerracotta,
        onPrimary: Colors.white,
        secondary: _kInk,
        onSecondary: _kParchment,
        error: const Color(0xFFB23A48),
        onError: Colors.white,
        surface: _kParchment,
        onSurface: _kInk,
      ),
      scaffoldBackgroundColor: _kParchment,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk, fontSize: 14, height: 1.45),
        bodyLarge: TextStyle(color: _kInk, fontSize: 16, height: 1.55),
        titleLarge: TextStyle(
          color: _kInk,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: _kInk,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    ),
    home: const _SelectionReadoutScaffold(),
  );
}

// -----------------------------------------------------------------------------
// TOP LEVEL SCAFFOLD
// -----------------------------------------------------------------------------

class _SelectionReadoutScaffold extends StatefulWidget {
  const _SelectionReadoutScaffold();

  @override
  State<_SelectionReadoutScaffold> createState() =>
      _SelectionReadoutScaffoldState();
}

class _SelectionReadoutScaffoldState extends State<_SelectionReadoutScaffold> {
  // Primary region state.
  String? _primaryPlainText;
  final List<_GestureLogEntry> _primaryLog = <_GestureLogEntry>[];
  int _primaryTick = 0;

  // Secondary region A.
  String? _secondaryAPlainText;
  final List<_GestureLogEntry> _secondaryALog = <_GestureLogEntry>[];

  // Secondary region B.
  String? _secondaryBPlainText;
  final List<_GestureLogEntry> _secondaryBLog = <_GestureLogEntry>[];

  void _onPrimarySelection(dynamic content) {
    final String? text = _extractPlainText(content);
    debugPrint('[SelectionReadout] primary -> ${text?.length ?? 0} chars');
    setState(() {
      _primaryPlainText = text;
      _primaryTick += 1;
      _primaryLog.insert(
        0,
        _GestureLogEntry(
          timestamp: DateTime.now(),
          excerpt: _excerptOf(text),
          charCount: text?.length ?? 0,
        ),
      );
      if (_primaryLog.length > 12) {
        _primaryLog.removeLast();
      }
    });
  }

  void _onSecondaryASelection(dynamic content) {
    final String? text = _extractPlainText(content);
    debugPrint('[SelectionReadout] regionA -> ${text?.length ?? 0} chars');
    setState(() {
      _secondaryAPlainText = text;
      _secondaryALog.insert(
        0,
        _GestureLogEntry(
          timestamp: DateTime.now(),
          excerpt: _excerptOf(text),
          charCount: text?.length ?? 0,
        ),
      );
      if (_secondaryALog.length > 8) {
        _secondaryALog.removeLast();
      }
    });
  }

  void _onSecondaryBSelection(dynamic content) {
    final String? text = _extractPlainText(content);
    debugPrint('[SelectionReadout] regionB -> ${text?.length ?? 0} chars');
    setState(() {
      _secondaryBPlainText = text;
      _secondaryBLog.insert(
        0,
        _GestureLogEntry(
          timestamp: DateTime.now(),
          excerpt: _excerptOf(text),
          charCount: text?.length ?? 0,
        ),
      );
      if (_secondaryBLog.length > 8) {
        _secondaryBLog.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kParchment,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 48),
          children: <Widget>[
            const _IntroHeaderCard(),
            const SizedBox(height: 20),
            _SelectionReadoutHero(
              plainText: _primaryPlainText,
              paragraphs: _kParagraphs,
              onSelectionChanged: _onPrimarySelection,
              tick: _primaryTick,
            ),
            const SizedBox(height: 20),
            _DetailsFieldTable(plainText: _primaryPlainText),
            const SizedBox(height: 20),
            _GestureLogCard(entries: _primaryLog),
            const SizedBox(height: 24),
            const _InstructionalTriptych(),
            const SizedBox(height: 24),
            _MultiRegionDemo(
              passageA: _kSecondaryPassageA,
              passageB: _kSecondaryPassageB,
              plainTextA: _secondaryAPlainText,
              plainTextB: _secondaryBPlainText,
              onSelectionChangedA: _onSecondaryASelection,
              onSelectionChangedB: _onSecondaryBSelection,
              logA: _secondaryALog,
              logB: _secondaryBLog,
            ),
            const SizedBox(height: 24),
            const _GotchasCard(),
            const SizedBox(height: 24),
            const _AnatomyDiagram(),
            const SizedBox(height: 24),
            const _ApiCheatSheet(),
            const SizedBox(height: 24),
            const _FooterCredits(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _kInk,
      foregroundColor: _kParchment,
      elevation: 0,
      titleSpacing: 24,
      toolbarHeight: 72,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _kTerracotta,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.text_fields_rounded,
              color: _kParchment,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Selection Readout Panel',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _kParchment,
                ),
              ),
              Text(
                'SelectedContent + SelectionGeometry — Flutter 3.41.6',
                style: TextStyle(
                  fontSize: 12,
                  color: _kParchmentDeep,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: const <Widget>[
        _AppBarPill(label: 'harness', icon: Icons.smart_toy_outlined),
        SizedBox(width: 10),
        _AppBarPill(label: 'd4rt AST', icon: Icons.memory_rounded),
        SizedBox(width: 18),
      ],
    );
  }
}

class _AppBarPill extends StatelessWidget {
  const _AppBarPill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _kParchment.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _kParchment.withValues(alpha: 0.32),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: _kParchment),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              color: _kParchment,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// UTILITIES — selection plainText extraction, excerpt formatting, stats.
// -----------------------------------------------------------------------------

String? _extractPlainText(dynamic content) {
  // `SelectionArea.onSelectionChanged` passes a `SelectedContent?`. We read its
  // `plainText` via `dynamic` to keep this file limited to
  // `package:flutter/material.dart` — `SelectedContent` itself is declared in
  // `package:flutter/rendering.dart` and is NOT re-exported through material.
  if (content == null) {
    return null;
  }
  try {
    final dynamic text = (content as dynamic).plainText;
    if (text is String) {
      return text;
    }
  } catch (e) {
    debugPrint('[SelectionReadout] plainText read failed: $e');
  }
  return null;
}

String _excerptOf(String? text) {
  if (text == null || text.isEmpty) {
    return '(empty)';
  }
  final String single = text.replaceAll('\n', ' ');
  if (single.length <= 48) {
    return single;
  }
  return '${single.substring(0, 45)}...';
}

int _wordCountOf(String? text) {
  if (text == null) {
    return 0;
  }
  final String trimmed = text.trim();
  if (trimmed.isEmpty) {
    return 0;
  }
  return trimmed
      .split(RegExp(r'\s+'))
      .where((String w) => w.isNotEmpty)
      .length;
}

String _firstLineOf(String? text) {
  if (text == null || text.isEmpty) {
    return '(none)';
  }
  final int nl = text.indexOf('\n');
  final String head = nl == -1 ? text : text.substring(0, nl);
  if (head.length <= 80) {
    return head;
  }
  return '${head.substring(0, 77)}...';
}

String _formatTimestamp(DateTime ts) {
  String two(int v) => v < 10 ? '0$v' : '$v';
  String three(int v) {
    if (v < 10) {
      return '00$v';
    }
    if (v < 100) {
      return '0$v';
    }
    return '$v';
  }

  return '${two(ts.hour)}:${two(ts.minute)}:${two(ts.second)}.'
      '${three(ts.millisecond)}';
}

String _statusLabelFor(String? plainText) {
  if (plainText == null) {
    return 'SelectionStatus.none';
  }
  if (plainText.isEmpty) {
    return 'SelectionStatus.collapsed';
  }
  return 'SelectionStatus.uncollapsed';
}

// -----------------------------------------------------------------------------
// GESTURE LOG ENTRY
// -----------------------------------------------------------------------------

class _GestureLogEntry {
  const _GestureLogEntry({
    required this.timestamp,
    required this.excerpt,
    required this.charCount,
  });

  final DateTime timestamp;
  final String excerpt;
  final int charCount;
}

// -----------------------------------------------------------------------------
// INTRO HEADER CARD
// -----------------------------------------------------------------------------

class _IntroHeaderCard extends StatelessWidget {
  const _IntroHeaderCard();

  @override
  Widget build(BuildContext context) {
    return _NotebookCard(
      padding: const EdgeInsets.fromLTRB(28, 22, 28, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _kTerracotta.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _kTerracotta.withValues(alpha: 0.55),
                width: 1.6,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.highlight_alt_rounded,
              size: 38,
              color: _kTerracotta,
            ),
          ),
          const SizedBox(width: 22),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'What you are looking at',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A hand-authored visualization of how Flutter surfaces a '
                  'selection to application code. Highlight text in the '
                  'passage below and the sidebar updates live: character '
                  'and word counts, first-line preview, geometry rects '
                  'painted in terracotta over the passage, and a gesture '
                  'log capturing every SelectedContent that crosses the '
                  'wire.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.55,
                    color: _kInkSoft,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Subject: SelectedContent + SelectionGeometry '
                  '(SelectionDetails does not exist in Flutter 3.41.6).',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: _kInkFaint,
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

// -----------------------------------------------------------------------------
// NOTEBOOK CARD — shared decorative container used across the demo.
// -----------------------------------------------------------------------------

class _NotebookCard extends StatelessWidget {
  const _NotebookCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.accent = _kTerracotta,
    this.label,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color accent;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _kInk.withValues(alpha: 0.12),
          width: 1.2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 6,
            child: Container(
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.85),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
            ),
          ),
          if (label != null)
            Positioned(
              right: 14,
              top: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  label!,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: accent,
                  ),
                ),
              ),
            ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HERO — the big selectable passage + live sidebar.
// -----------------------------------------------------------------------------

class _SelectionReadoutHero extends StatelessWidget {
  const _SelectionReadoutHero({
    required this.plainText,
    required this.paragraphs,
    required this.onSelectionChanged,
    required this.tick,
  });

  final String? plainText;
  final List<String> paragraphs;
  final ValueChanged<dynamic> onSelectionChanged;
  final int tick;

  @override
  Widget build(BuildContext context) {
    return _NotebookCard(
      label: 'HERO PASSAGE',
      padding: const EdgeInsets.fromLTRB(28, 24, 24, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: _HeroPassagePanel(
              paragraphs: paragraphs,
              onSelectionChanged: onSelectionChanged,
              plainText: plainText,
              tick: tick,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: _HeroSidebar(plainText: plainText),
          ),
        ],
      ),
    );
  }
}

class _HeroPassagePanel extends StatelessWidget {
  const _HeroPassagePanel({
    required this.paragraphs,
    required this.onSelectionChanged,
    required this.plainText,
    required this.tick,
  });

  final List<String> paragraphs;
  final ValueChanged<dynamic> onSelectionChanged;
  final String? plainText;
  final int tick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionLabel(
          icon: Icons.menu_book_rounded,
          text: 'Passage (SelectionArea)',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: _kParchmentDeep.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _kInk.withValues(alpha: 0.16),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
          child: SelectionArea(
            onSelectionChanged: onSelectionChanged,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (int i = 0; i < paragraphs.length; i++) ...<Widget>[
                      if (i > 0) const SizedBox(height: 14),
                      _PassageParagraph(
                        index: i,
                        text: paragraphs[i],
                      ),
                    ],
                  ],
                ),
                // Overlay layer — decorative geometry rects simulating how
                // SelectionGeometry.selectionRects would look if we could
                // read them directly. These rects are deterministic for the
                // passage so they always line up visually.
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _GeometryOverlayPainter(
                        plainText: plainText,
                        tick: tick,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        _PassageFootnote(plainText: plainText),
      ],
    );
  }
}

class _PassageParagraph extends StatelessWidget {
  const _PassageParagraph({required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26,
          height: 26,
          margin: const EdgeInsets.only(top: 2, right: 12),
          decoration: BoxDecoration(
            color: _kInk,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: _kParchment,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15.5,
              height: 1.6,
              color: _kInk,
            ),
          ),
        ),
      ],
    );
  }
}

class _PassageFootnote extends StatelessWidget {
  const _PassageFootnote({required this.plainText});

  final String? plainText;

  @override
  Widget build(BuildContext context) {
    final bool hasSelection =
        plainText != null && plainText!.isNotEmpty;
    return Row(
      children: <Widget>[
        Icon(
          hasSelection
              ? Icons.check_circle_rounded
              : Icons.radio_button_unchecked_rounded,
          size: 16,
          color: hasSelection ? _kSage : _kInkFaint,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            hasSelection
                ? 'SelectedContent arrived — ${plainText!.length} char(s).'
                : 'No SelectedContent yet. Drag across the passage above.',
            style: TextStyle(
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
              color: hasSelection ? _kSage : _kInkFaint,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 16, color: _kInk),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: _kInk,
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// HERO SIDEBAR — the live "Selection Details" panel.
// -----------------------------------------------------------------------------

class _HeroSidebar extends StatelessWidget {
  const _HeroSidebar({required this.plainText});

  final String? plainText;

  @override
  Widget build(BuildContext context) {
    final int chars = plainText?.length ?? 0;
    final int words = _wordCountOf(plainText);
    final String preview = _firstLineOf(plainText);
    final String status = _statusLabelFor(plainText);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionLabel(
          icon: Icons.dashboard_customize_rounded,
          text: 'Selection Details',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _StatusDot(
                    active: plainText != null && plainText!.isNotEmpty,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: _kParchment,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _SidebarStatRow(label: 'plainText.length', value: '$chars'),
              const SizedBox(height: 8),
              _SidebarStatRow(label: 'wordCount (derived)', value: '$words'),
              const SizedBox(height: 8),
              _SidebarStatRow(
                label: 'hasContent',
                value: (plainText != null).toString(),
              ),
              const SizedBox(height: 8),
              _SidebarStatRow(
                label: 'hasSelection',
                value:
                    (plainText != null && plainText!.isNotEmpty).toString(),
              ),
              const SizedBox(height: 16),
              const Text(
                'First-line preview',
                style: TextStyle(
                  color: _kParchmentDeep,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kParchment.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _kTerracotta.withValues(alpha: 0.45),
                  ),
                ),
                child: Text(
                  preview,
                  style: const TextStyle(
                    color: _kParchment,
                    fontSize: 12.5,
                    height: 1.45,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const _SidebarLegend(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SidebarStatRow extends StatelessWidget {
  const _SidebarStatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: _kParchmentDeep,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: _kTerracotta.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: _kParchment,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: active ? _kTerracotta : _kInkFaint,
        shape: BoxShape.circle,
        boxShadow: active
            ? <BoxShadow>[
                BoxShadow(
                  color: _kTerracotta.withValues(alpha: 0.6),
                  blurRadius: 6,
                ),
              ]
            : const <BoxShadow>[],
      ),
    );
  }
}

class _SidebarLegend extends StatelessWidget {
  const _SidebarLegend();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Overlay legend',
          style: TextStyle(
            color: _kParchmentDeep,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        _LegendRow(
          color: _kTerracotta.withValues(alpha: 0.5),
          label: 'selectionRects (SelectionGeometry)',
        ),
        const SizedBox(height: 4),
        _LegendRow(
          color: _kTerracotta,
          label: 'startSelectionPoint',
          isHandle: true,
        ),
        const SizedBox(height: 4),
        _LegendRow(
          color: _kTerracottaSoft,
          label: 'endSelectionPoint',
          isHandle: true,
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.color,
    required this.label,
    this.isHandle = false,
  });

  final Color color;
  final String label;
  final bool isHandle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 16,
          height: isHandle ? 10 : 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(isHandle ? 5 : 2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: _kParchment,
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// GEOMETRY OVERLAY PAINTER
// -----------------------------------------------------------------------------
// This painter simulates the look of `SelectionGeometry.selectionRects` over
// the passage. The real Flutter selection engine computes these rects inside
// the render tree for the Selectable mixin; they are not exposed to
// application code in 3.41.6. To give the demo a pedagogical "look at what
// the geometry means" feel, we generate a deterministic pseudo-layout from
// the current `plainText` length, keyed to the passage dimensions at paint
// time. The point is explanatory, not pixel-accurate.

class _GeometryOverlayPainter extends CustomPainter {
  _GeometryOverlayPainter({required this.plainText, required this.tick});

  final String? plainText;
  final int tick;

  @override
  void paint(Canvas canvas, Size size) {
    if (plainText == null || plainText!.isEmpty) {
      return;
    }
    final double w = size.width;
    final double h = size.height;
    if (w <= 0 || h <= 0) {
      return;
    }

    // Deterministic pseudo-random selection bands based on length.
    final int len = plainText!.length;
    final int bands = math.min(5, 1 + (len ~/ 45));
    final math.Random rng = math.Random(len * 17 + tick * 3);

    final Paint bandPaint = Paint()
      ..color = _kTerracotta.withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;
    final Paint strokePaint = Paint()
      ..color = _kTerracotta.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final double lineHeight = 24.8;
    final double topPadding = 4;
    final double leftPadding = 38; // room for number bullet.

    double lastRight = leftPadding;
    for (int i = 0; i < bands; i++) {
      final double top =
          topPadding + i * (lineHeight + 2) + rng.nextDouble() * 2;
      if (top + lineHeight > h) {
        break;
      }
      final double left = (i == 0)
          ? (leftPadding + rng.nextDouble() * 40)
          : leftPadding;
      final double right = (i == bands - 1)
          ? math.min(w - 12, leftPadding + rng.nextDouble() * (w - 80) + 40)
          : w - 16;
      final Rect band = Rect.fromLTRB(left, top, right, top + lineHeight);
      final RRect rr =
          RRect.fromRectAndRadius(band, const Radius.circular(3));
      canvas.drawRRect(rr, bandPaint);
      canvas.drawRRect(rr, strokePaint);
      lastRight = right;
    }

    // Handles.
    final double startX = leftPadding + 12;
    final double startY = topPadding;
    final double endX = lastRight;
    final double endY = topPadding + (bands - 1) * (lineHeight + 2);

    _drawHandle(canvas, Offset(startX, startY), lineHeight,
        _kTerracotta, isStart: true);
    _drawHandle(canvas, Offset(endX, endY + lineHeight), lineHeight,
        _kTerracottaSoft, isStart: false);
  }

  void _drawHandle(
    Canvas canvas,
    Offset anchor,
    double lineHeight,
    Color color, {
    required bool isStart,
  }) {
    final Paint fill = Paint()..color = color;
    final Paint outline = Paint()
      ..color = _kInk.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Line segment.
    canvas.drawLine(
      anchor,
      Offset(anchor.dx, anchor.dy + lineHeight),
      Paint()
        ..color = color
        ..strokeWidth = 1.8,
    );

    // Disc.
    final double r = 5.5;
    final Offset disc =
        isStart ? Offset(anchor.dx, anchor.dy) : Offset(anchor.dx, anchor.dy);
    canvas.drawCircle(disc, r, fill);
    canvas.drawCircle(disc, r, outline);
  }

  @override
  bool shouldRepaint(covariant _GeometryOverlayPainter oldDelegate) {
    return oldDelegate.plainText != plainText || oldDelegate.tick != tick;
  }
}

// -----------------------------------------------------------------------------
// DETAILS FIELD TABLE — a live table of SelectionGeometry / SelectedContent
// fields keyed to the current selection.
// -----------------------------------------------------------------------------

class _DetailsFieldTable extends StatelessWidget {
  const _DetailsFieldTable({required this.plainText});

  final String? plainText;

  @override
  Widget build(BuildContext context) {
    final List<_FieldRow> rows = _buildRows(plainText);

    return _NotebookCard(
      label: 'GEOMETRY INSPECTOR',
      accent: _kInk,
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Live field table',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Each row below mirrors a field you would read off of the '
            'SelectedContent / SelectionGeometry pair. Values update as '
            'you select and deselect text in the hero passage.',
            style: TextStyle(
              fontSize: 13,
              color: _kInkSoft,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: _kParchmentDeep.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _kInk.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              children: <Widget>[
                const _FieldTableHeader(),
                for (int i = 0; i < rows.length; i++)
                  _FieldTableRow(row: rows[i], zebra: i.isOdd),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<_FieldRow> _buildRows(String? text) {
    final bool has = text != null;
    final bool nonEmpty = text != null && text.isNotEmpty;
    final int len = text?.length ?? 0;
    final int words = _wordCountOf(text);
    return <_FieldRow>[
      _FieldRow(
        origin: 'SelectedContent',
        field: 'plainText',
        type: 'String',
        value: has
            ? "'${_excerptOf(text)}'"
            : 'null',
        note: 'The full selected text, flattened from rich spans.',
        active: nonEmpty,
      ),
      _FieldRow(
        origin: 'SelectedContent',
        field: 'plainText.length',
        type: 'int',
        value: '$len',
        note: 'Derived char count — useful for status bars.',
        active: nonEmpty,
      ),
      _FieldRow(
        origin: 'derived',
        field: 'wordCount',
        type: 'int',
        value: '$words',
        note: 'Not on SelectedContent; computed by the app.',
        active: nonEmpty,
      ),
      _FieldRow(
        origin: 'SelectionGeometry',
        field: 'hasContent',
        type: 'bool',
        value: has.toString(),
        note: 'True when the Selectable has any selectable content.',
        active: has,
      ),
      _FieldRow(
        origin: 'SelectionGeometry',
        field: 'hasSelection',
        type: 'bool (derived)',
        value: nonEmpty.toString(),
        note: 'status != SelectionStatus.none.',
        active: nonEmpty,
      ),
      _FieldRow(
        origin: 'SelectionGeometry',
        field: 'status',
        type: 'SelectionStatus',
        value: _statusLabelFor(text),
        note: 'none / collapsed / uncollapsed.',
        active: nonEmpty,
      ),
      _FieldRow(
        origin: 'SelectionGeometry',
        field: 'startSelectionPoint',
        type: 'SelectionPoint?',
        value: nonEmpty
            ? 'SelectionPoint(localPosition, lineHeight, handleType.left)'
            : 'null',
        note: 'Anchor where the start handle is drawn.',
        active: nonEmpty,
      ),
      _FieldRow(
        origin: 'SelectionGeometry',
        field: 'endSelectionPoint',
        type: 'SelectionPoint?',
        value: nonEmpty
            ? 'SelectionPoint(localPosition, lineHeight, handleType.right)'
            : 'null',
        note: 'Anchor where the end handle is drawn.',
        active: nonEmpty,
      ),
      _FieldRow(
        origin: 'SelectionGeometry',
        field: 'selectionRects',
        type: 'List<Rect>',
        value: nonEmpty ? '[${math.min(5, 1 + len ~/ 45)} rect(s)]' : '[]',
        note: 'Local-coord rects for the highlight overlay.',
        active: nonEmpty,
      ),
      _FieldRow(
        origin: 'SelectedContentRange',
        field: 'startOffset',
        type: 'int',
        value: nonEmpty ? '0' : '-',
        note: 'Offset relative to the Selectable content.',
        active: nonEmpty,
      ),
      _FieldRow(
        origin: 'SelectedContentRange',
        field: 'endOffset',
        type: 'int',
        value: nonEmpty ? '$len' : '-',
        note: 'Inclusive end offset for this range.',
        active: nonEmpty,
      ),
    ];
  }
}

class _FieldRow {
  const _FieldRow({
    required this.origin,
    required this.field,
    required this.type,
    required this.value,
    required this.note,
    required this.active,
  });

  final String origin;
  final String field;
  final String type;
  final String value;
  final String note;
  final bool active;
}

class _FieldTableHeader extends StatelessWidget {
  const _FieldTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: const Row(
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              'Origin',
              style: TextStyle(
                color: _kParchment,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: Text(
              'Field',
              style: TextStyle(
                color: _kParchment,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              'Type',
              style: TextStyle(
                color: _kParchment,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Live value / note',
              style: TextStyle(
                color: _kParchment,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldTableRow extends StatelessWidget {
  const _FieldTableRow({required this.row, required this.zebra});

  final _FieldRow row;
  final bool zebra;

  @override
  Widget build(BuildContext context) {
    final Color background = zebra
        ? _kParchment.withValues(alpha: 0.55)
        : _kParchment.withValues(alpha: 0.25);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: background,
        border: Border(
          top: BorderSide(
            color: _kInk.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: _OriginChip(origin: row.origin, active: row.active),
          ),
          SizedBox(
            width: 180,
            child: Text(
              row.field,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: _kInk,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              row.type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: _kInkSoft,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  row.value,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: row.active ? _kTerracotta : _kInkFaint,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  row.note,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: _kInkSoft,
                    height: 1.4,
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

class _OriginChip extends StatelessWidget {
  const _OriginChip({required this.origin, required this.active});

  final String origin;
  final bool active;

  @override
  Widget build(BuildContext context) {
    Color bg;
    switch (origin) {
      case 'SelectedContent':
        bg = _kTerracotta;
        break;
      case 'SelectionGeometry':
        bg = _kInk;
        break;
      case 'SelectedContentRange':
        bg = _kSage;
        break;
      default:
        bg = _kInkFaint;
        break;
    }
    final double alpha = active ? 0.85 : 0.35;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg.withValues(alpha: alpha),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        origin,
        style: const TextStyle(
          color: _kParchment,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// GESTURE LOG CARD
// -----------------------------------------------------------------------------

class _GestureLogCard extends StatelessWidget {
  const _GestureLogCard({required this.entries});

  final List<_GestureLogEntry> entries;

  @override
  Widget build(BuildContext context) {
    return _NotebookCard(
      label: 'GESTURE LOG',
      accent: _kSage,
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.receipt_long_rounded, color: _kInk, size: 20),
              const SizedBox(width: 8),
              const Text(
                'onSelectionChanged event stream',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kSage.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${entries.length} event(s)',
                  style: const TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (entries.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kParchmentDeep.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kInk.withValues(alpha: 0.12)),
              ),
              child: const Text(
                'No events yet. Drag across the hero passage above to start '
                'recording.',
                style: TextStyle(
                  color: _kInkSoft,
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                ),
              ),
            )
          else
            Column(
              children: <Widget>[
                for (int i = 0; i < entries.length; i++)
                  _GestureLogItem(entry: entries[i], index: i),
              ],
            ),
        ],
      ),
    );
  }
}

class _GestureLogItem extends StatelessWidget {
  const _GestureLogItem({required this.entry, required this.index});

  final _GestureLogEntry entry;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool fresh = index == 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: fresh
            ? _kTerracotta.withValues(alpha: 0.16)
            : _kParchmentDeep.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: fresh
              ? _kTerracotta.withValues(alpha: 0.6)
              : _kInk.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: fresh ? _kTerracotta : _kInk.withValues(alpha: 0.55),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${entries(index)}',
              style: const TextStyle(
                color: _kParchment,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: Text(
              _formatTimestamp(entry.timestamp),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _kInk,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 66,
            child: Text(
              '${entry.charCount} ch',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _kInkSoft,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              entry.excerpt,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12.5,
                color: _kInk,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper so the event number counts from 1 for the newest entry at the top.
  int entries(int i) => i + 1;
}

// -----------------------------------------------------------------------------
// INSTRUCTIONAL TRIPTYCH — three explanatory cards side by side.
// -----------------------------------------------------------------------------

class _InstructionalTriptych extends StatelessWidget {
  const _InstructionalTriptych();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        Expanded(child: _InstructionalPanelOne()),
        SizedBox(width: 16),
        Expanded(child: _InstructionalPanelTwo()),
        SizedBox(width: 16),
        Expanded(child: _InstructionalPanelThree()),
      ],
    );
  }
}

class _InstructionalPanelOne extends StatelessWidget {
  const _InstructionalPanelOne();

  @override
  Widget build(BuildContext context) {
    return _InstructionalPanel(
      title: 'What SelectedContent tells you',
      accent: _kTerracotta,
      icon: Icons.description_rounded,
      bullets: const <String>[
        'plainText is the only field: a flat String of the selected text.',
        'null when the user has no active selection.',
        'Rich spans (TextSpan, WidgetSpan) are flattened before delivery.',
        'Safe to copy to the clipboard, feed to search, or diff.',
      ],
      footer: 'Delivered through SelectionArea.onSelectionChanged.',
    );
  }
}

class _InstructionalPanelTwo extends StatelessWidget {
  const _InstructionalPanelTwo();

  @override
  Widget build(BuildContext context) {
    return _InstructionalPanel(
      title: 'How handles use SelectionGeometry',
      accent: _kInk,
      icon: Icons.architecture_rounded,
      bullets: const <String>[
        'selectionRects drive the translucent highlight.',
        'startSelectionPoint + endSelectionPoint place the handles.',
        'Each SelectionPoint carries localPosition, lineHeight, handleType.',
        'status decides whether the toolbar / magnifier appear at all.',
      ],
      footer: 'Consumed by SelectableRegion internally, not by app code.',
    );
  }
}

class _InstructionalPanelThree extends StatelessWidget {
  const _InstructionalPanelThree();

  @override
  Widget build(BuildContext context) {
    return _InstructionalPanel(
      title: 'Where SelectedContentRange fits',
      accent: _kSage,
      icon: Icons.linear_scale_rounded,
      bullets: const <String>[
        'startOffset / endOffset relative to the Selectable content.',
        'WidgetSpan content contributes to offset length.',
        'Lets higher-level widgets map selection back to structure.',
        'Retrieved via SelectionHandler.getSelection, not onSelectionChanged.',
      ],
      footer: 'Complement to plainText for structural editing.',
    );
  }
}

class _InstructionalPanel extends StatelessWidget {
  const _InstructionalPanel({
    required this.title,
    required this.accent,
    required this.icon,
    required this.bullets,
    required this.footer,
  });

  final String title;
  final Color accent;
  final IconData icon;
  final List<String> bullets;
  final String footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accent.withValues(alpha: 0.35),
          width: 1.4,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: accent, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (final String bullet in bullets) _Bullet(text: bullet, accent: accent),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              footer,
              style: TextStyle(
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
                color: accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text, required this.accent});

  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: _kInkSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// MULTI REGION DEMO — two stacked SelectionAreas with independent readouts.
// -----------------------------------------------------------------------------

class _MultiRegionDemo extends StatelessWidget {
  const _MultiRegionDemo({
    required this.passageA,
    required this.passageB,
    required this.plainTextA,
    required this.plainTextB,
    required this.onSelectionChangedA,
    required this.onSelectionChangedB,
    required this.logA,
    required this.logB,
  });

  final String passageA;
  final String passageB;
  final String? plainTextA;
  final String? plainTextB;
  final ValueChanged<dynamic> onSelectionChangedA;
  final ValueChanged<dynamic> onSelectionChangedB;
  final List<_GestureLogEntry> logA;
  final List<_GestureLogEntry> logB;

  @override
  Widget build(BuildContext context) {
    return _NotebookCard(
      label: 'MULTI REGION',
      accent: _kInkSoft,
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Two SelectionAreas, two SelectedContents',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Select text in each passage independently. Note that each region '
            'has its own sidebar and its own onSelectionChanged stream — '
            'SelectedContent is always scoped to a single SelectionArea.',
            style: TextStyle(
              fontSize: 13,
              color: _kInkSoft,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          _MultiRegionRow(
            regionLabel: 'Region A',
            regionColor: _kTerracotta,
            passage: passageA,
            plainText: plainTextA,
            onSelectionChanged: onSelectionChangedA,
            log: logA,
          ),
          const SizedBox(height: 20),
          _MultiRegionRow(
            regionLabel: 'Region B',
            regionColor: _kSage,
            passage: passageB,
            plainText: plainTextB,
            onSelectionChanged: onSelectionChangedB,
            log: logB,
          ),
        ],
      ),
    );
  }
}

class _MultiRegionRow extends StatelessWidget {
  const _MultiRegionRow({
    required this.regionLabel,
    required this.regionColor,
    required this.passage,
    required this.plainText,
    required this.onSelectionChanged,
    required this.log,
  });

  final String regionLabel;
  final Color regionColor;
  final String passage;
  final String? plainText;
  final ValueChanged<dynamic> onSelectionChanged;
  final List<_GestureLogEntry> log;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: _kParchmentDeep.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: regionColor.withValues(alpha: 0.45),
                width: 1.4,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: regionColor.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        regionLabel,
                        style: TextStyle(
                          color: regionColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'SelectionArea',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: _kInkFaint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SelectionArea(
                  onSelectionChanged: onSelectionChanged,
                  child: Text(
                    passage,
                    style: const TextStyle(
                      fontSize: 14.5,
                      height: 1.55,
                      color: _kInk,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: _MultiRegionSidebar(
            regionColor: regionColor,
            plainText: plainText,
            log: log,
          ),
        ),
      ],
    );
  }
}

class _MultiRegionSidebar extends StatelessWidget {
  const _MultiRegionSidebar({
    required this.regionColor,
    required this.plainText,
    required this.log,
  });

  final Color regionColor;
  final String? plainText;
  final List<_GestureLogEntry> log;

  @override
  Widget build(BuildContext context) {
    final int chars = plainText?.length ?? 0;
    final int words = _wordCountOf(plainText);
    final bool has = plainText != null && plainText!.isNotEmpty;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _StatusDot(active: has),
              const SizedBox(width: 8),
              Text(
                _statusLabelFor(plainText),
                style: const TextStyle(
                  color: _kParchment,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: regionColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _MiniStat(label: 'chars', value: '$chars'),
          const SizedBox(height: 6),
          _MiniStat(label: 'words', value: '$words'),
          const SizedBox(height: 6),
          _MiniStat(
            label: 'events',
            value: '${log.length}',
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kParchment.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: regionColor.withValues(alpha: 0.45),
              ),
            ),
            child: Text(
              _excerptOf(plainText),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _kParchment,
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: _kParchmentDeep,
              fontSize: 11.5,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: _kParchment,
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// GOTCHAS CARD
// -----------------------------------------------------------------------------

class _GotchasCard extends StatelessWidget {
  const _GotchasCard();

  @override
  Widget build(BuildContext context) {
    return _NotebookCard(
      label: 'GOTCHAS',
      accent: const Color(0xFFB23A48),
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.warning_amber_rounded, color: Color(0xFFB23A48)),
              SizedBox(width: 10),
              Text(
                'Things that bite you the first time',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _GotchaRow(
            number: '01',
            title: 'plainText is not a reactive stream of characters.',
            body:
                'onSelectionChanged only fires when the selection becomes '
                'stable. Mid-drag intermediate values are coalesced, and a '
                'collapsed selection (click, no drag) arrives with an empty '
                'plainText, not null.',
          ),
          _GotchaRow(
            number: '02',
            title: 'SelectedContent is not re-exported from material.dart.',
            body:
                'The class lives in `package:flutter/rendering.dart`. This '
                'demo reads `plainText` via `dynamic` so the file stays '
                'limited to material + dart:math imports — exactly as the '
                'harness contract requires.',
          ),
          _GotchaRow(
            number: '03',
            title: 'SelectionGeometry is not given to app code.',
            body:
                'You cannot read selectionRects or SelectionPoints from the '
                'SelectionArea callback. To see them, you must implement '
                'Selectable yourself or inspect the render tree — the '
                'overlay in the hero passage is decorative, based on the '
                'shape those rects usually take.',
          ),
          _GotchaRow(
            number: '04',
            title: 'Each SelectionArea is its own world.',
            body:
                'Stacking two SelectionAreas gives you two independent '
                'selections. Clipboard copy still works per region, but '
                'there is no "global" SelectedContent across regions.',
          ),
          _GotchaRow(
            number: '05',
            title: 'Null does not mean "no content".',
            body:
                'Null means "no current selection". SelectionGeometry.hasContent '
                'being true can still coexist with a null SelectedContent — '
                'the content is present, just not currently selected.',
          ),
        ],
      ),
    );
  }
}

class _GotchaRow extends StatelessWidget {
  const _GotchaRow({
    required this.number,
    required this.title,
    required this.body,
  });

  final String number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFB23A48).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFB23A48).withValues(alpha: 0.5),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                fontSize: 14,
                color: Color(0xFFB23A48),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: _kInkSoft,
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

// -----------------------------------------------------------------------------
// ANATOMY DIAGRAM — static diagram showing how the pieces fit together.
// -----------------------------------------------------------------------------

class _AnatomyDiagram extends StatelessWidget {
  const _AnatomyDiagram();

  @override
  Widget build(BuildContext context) {
    return _NotebookCard(
      label: 'ANATOMY',
      accent: _kInk,
      padding: const EdgeInsets.fromLTRB(28, 26, 28, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Where the objects live',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'A simplified map of the Flutter selection pipeline in 3.41.6. '
            'Each node points to the class that holds the data, and each '
            'arrow is an observable relationship rather than a call.',
            style: TextStyle(
              fontSize: 13,
              color: _kInkSoft,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 260,
            child: CustomPaint(
              painter: _AnatomyDiagramPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnatomyDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final List<_AnatomyNode> nodes = <_AnatomyNode>[
      _AnatomyNode(
        label: 'SelectionArea',
        detail: 'widget root',
        color: _kInk,
        center: Offset(w * 0.12, h * 0.5),
        width: 150,
        height: 58,
      ),
      _AnatomyNode(
        label: 'SelectableRegion',
        detail: 'state owner',
        color: _kInkSoft,
        center: Offset(w * 0.34, h * 0.5),
        width: 160,
        height: 58,
      ),
      _AnatomyNode(
        label: 'Selectable',
        detail: 'mixin on render objects',
        color: _kSage,
        center: Offset(w * 0.57, h * 0.5),
        width: 170,
        height: 58,
      ),
      _AnatomyNode(
        label: 'SelectedContent',
        detail: 'plainText only',
        color: _kTerracotta,
        center: Offset(w * 0.83, h * 0.22),
        width: 170,
        height: 56,
      ),
      _AnatomyNode(
        label: 'SelectionGeometry',
        detail: 'rects + points + status',
        color: _kTerracotta,
        center: Offset(w * 0.83, h * 0.5),
        width: 200,
        height: 56,
      ),
      _AnatomyNode(
        label: 'SelectedContentRange',
        detail: 'startOffset / endOffset',
        color: _kTerracotta,
        center: Offset(w * 0.83, h * 0.78),
        width: 210,
        height: 56,
      ),
    ];

    // Arrows.
    final Paint arrowPaint = Paint()
      ..color = _kInk.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    _arrow(canvas, nodes[0], nodes[1], arrowPaint);
    _arrow(canvas, nodes[1], nodes[2], arrowPaint);
    _arrow(canvas, nodes[2], nodes[3], arrowPaint);
    _arrow(canvas, nodes[2], nodes[4], arrowPaint);
    _arrow(canvas, nodes[2], nodes[5], arrowPaint);

    for (final _AnatomyNode node in nodes) {
      _drawNode(canvas, node);
    }
  }

  void _drawNode(Canvas canvas, _AnatomyNode node) {
    final Rect rect = Rect.fromCenter(
      center: node.center,
      width: node.width,
      height: node.height,
    );
    final RRect rr =
        RRect.fromRectAndRadius(rect, const Radius.circular(10));
    final Paint fill = Paint()..color = node.color.withValues(alpha: 0.14);
    final Paint border = Paint()
      ..color = node.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawRRect(rr, fill);
    canvas.drawRRect(rr, border);

    final TextPainter title = TextPainter(
      text: TextSpan(
        text: node.label,
        style: TextStyle(
          color: node.color,
          fontWeight: FontWeight.w700,
          fontSize: 13,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: node.width - 12);
    title.paint(
      canvas,
      Offset(
        rect.left + (rect.width - title.width) / 2,
        rect.top + 8,
      ),
    );

    final TextPainter detail = TextPainter(
      text: TextSpan(
        text: node.detail,
        style: TextStyle(
          color: node.color.withValues(alpha: 0.8),
          fontSize: 11,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: node.width - 12);
    detail.paint(
      canvas,
      Offset(
        rect.left + (rect.width - detail.width) / 2,
        rect.top + 8 + title.height + 2,
      ),
    );
  }

  void _arrow(
      Canvas canvas, _AnatomyNode from, _AnatomyNode to, Paint paint) {
    final Offset start = Offset(
      from.center.dx + from.width / 2,
      from.center.dy,
    );
    final Offset end = Offset(
      to.center.dx - to.width / 2,
      to.center.dy,
    );
    final Offset midA = Offset((start.dx + end.dx) / 2, start.dy);
    final Offset midB = Offset((start.dx + end.dx) / 2, end.dy);
    final Path path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(midA.dx, midA.dy)
      ..lineTo(midB.dx, midB.dy)
      ..lineTo(end.dx, end.dy);
    canvas.drawPath(path, paint);

    // Arrow head.
    final double ah = 5;
    final Path head = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(end.dx - ah, end.dy - ah)
      ..lineTo(end.dx - ah, end.dy + ah)
      ..close();
    canvas.drawPath(
      head,
      Paint()..color = paint.color,
    );
  }

  @override
  bool shouldRepaint(covariant _AnatomyDiagramPainter oldDelegate) => false;
}

class _AnatomyNode {
  _AnatomyNode({
    required this.label,
    required this.detail,
    required this.color,
    required this.center,
    required this.width,
    required this.height,
  });

  final String label;
  final String detail;
  final Color color;
  final Offset center;
  final double width;
  final double height;
}

// -----------------------------------------------------------------------------
// API CHEAT SHEET — a condensed reference of the relevant classes.
// -----------------------------------------------------------------------------

class _ApiCheatSheet extends StatelessWidget {
  const _ApiCheatSheet();

  @override
  Widget build(BuildContext context) {
    return _NotebookCard(
      label: 'CHEAT SHEET',
      accent: _kTerracotta,
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'One-glance reference',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'The actual public API surface in Flutter 3.41.6 around '
            '"selection details".',
            style: TextStyle(
              fontSize: 13,
              color: _kInkSoft,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          _CheatEntry(
            title: 'class SelectedContent',
            location: 'package:flutter/rendering.dart',
            members: <String>[
              'final String plainText;',
            ],
            note: 'Immutable. Only field is plainText. Delivered via '
                'SelectionArea.onSelectionChanged.',
          ),
          SizedBox(height: 14),
          _CheatEntry(
            title: 'class SelectionGeometry',
            location: 'package:flutter/rendering.dart',
            members: <String>[
              'final SelectionPoint? startSelectionPoint;',
              'final SelectionPoint? endSelectionPoint;',
              'final List<Rect> selectionRects;',
              'final SelectionStatus status;',
              'final bool hasContent;',
              'bool get hasSelection;',
              'SelectionGeometry copyWith({...});',
            ],
            note: 'Produced by Selectable implementations. Consumed by '
                'SelectableRegion for handles / toolbar anchoring.',
          ),
          SizedBox(height: 14),
          _CheatEntry(
            title: 'class SelectionPoint',
            location: 'package:flutter/rendering.dart',
            members: <String>[
              'final Offset localPosition;',
              'final double lineHeight;',
              'final TextSelectionHandleType handleType;',
            ],
            note: 'The anchor used to place a selection handle in local '
                'coordinates of the owning Selectable.',
          ),
          SizedBox(height: 14),
          _CheatEntry(
            title: 'class SelectedContentRange',
            location: 'package:flutter/rendering.dart',
            members: <String>[
              'final int startOffset;',
              'final int endOffset;',
            ],
            note: 'Range of the current selection within the content of a '
                'Selectable. Reached via SelectionHandler.getSelection.',
          ),
          SizedBox(height: 14),
          _CheatEntry(
            title: 'enum SelectionStatus',
            location: 'package:flutter/rendering.dart',
            members: <String>[
              'none',
              'collapsed',
              'uncollapsed',
            ],
            note: 'Tri-state flag describing the selection lifecycle at a '
                'given Selectable.',
          ),
        ],
      ),
    );
  }
}

class _CheatEntry extends StatelessWidget {
  const _CheatEntry({
    required this.title,
    required this.location,
    required this.members,
    required this.note,
  });

  final String title;
  final String location;
  final List<String> members;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _kParchmentDeep.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _kInk.withValues(alpha: 0.14),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: _kInk.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  location,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: _kInkSoft,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final String member in members)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: _kTerracotta,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      member,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: _kInk,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
          Text(
            note,
            style: const TextStyle(
              fontSize: 12,
              color: _kInkSoft,
              fontStyle: FontStyle.italic,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// FOOTER CREDITS
// -----------------------------------------------------------------------------

class _FooterCredits extends StatelessWidget {
  const _FooterCredits();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.auto_awesome_rounded,
            color: _kTerracotta,
            size: 22,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Selection Readout Panel — a d4rt AST harness demo of '
              'SelectedContent + SelectionGeometry in Flutter 3.41.6.',
              style: TextStyle(
                color: _kParchment,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _kTerracotta.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'hand-authored',
              style: TextStyle(
                color: _kParchment,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

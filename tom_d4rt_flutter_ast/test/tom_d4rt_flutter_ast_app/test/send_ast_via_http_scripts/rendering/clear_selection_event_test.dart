// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
// D4rt deep visual demo: ClearSelectionEvent (package:flutter/rendering.dart)
// ----------------------------------------------------------------------------
// ClearSelectionEvent is a SelectionEvent subtype dispatched to a
// SelectionHandler whenever the framework wants to *clear* (i.e. fully
// deselect) the handler's current selection. It is the deselect-all signal
// in the Selection API.
//
// Where it lives:
//   SelectionEvent  (abstract)
//     ├── ClearSelectionEvent           (this file)
//     ├── SelectAllSelectionEvent
//     ├── SelectParagraphSelectionEvent
//     ├── SelectWordSelectionEvent
//     ├── GranularlyExtendSelectionEvent
//     ├── DirectionallyExtendSelectionEvent
//     └── SelectionEdgeUpdateEvent (start / end variants)
//
// Each event carries a SelectionEventType value. ClearSelectionEvent's type
// is SelectionEventType.clear — a pure signal with no payload.
//
// Lifecycle context:
//   idle  →  user starts drag        →  start  (edge update / select-word)
//          →  user keeps dragging    →  extend (edge update)
//          →  user taps elsewhere    →  clear  ← THIS event
//          →  back to idle.
//
// This script is a *visualisation*. It does not actually drive a
// SelectableRegion — d4rt cannot subclass Flutter abstracts, and we keep
// every widget static. Real selection is mocked with painted rectangles.
//
// Sections:
//   1.  Anatomy of the SelectionEvent hierarchy (diagram).
//   2.  SelectionEventType mosaic — coloured chips per enum value.
//   3.  Lifecycle timeline (idle → start → extend → clear → idle).
//   4.  Mock document with three selection states (full / partial / cleared).
//   5.  Code-card showing dispatch wiring.
//   6.  SelectableRegion mock with three "buttons" (Select All / Word / Clear).
//   7.  Comparison columns: ClearSelectionEvent vs SelectAll vs SelectWord.
//   8.  Constructor card: ClearSelectionEvent() takes no payload — why.
//   9.  Pitfalls: SelectionContainer.disabled and idempotent clears.
//   10. Footer summary.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ============================================================================
// PALETTE — slate / indigo / amber, with a "selection blue" accent.
// ============================================================================

const Color _bgDeep = Color(0xFF0F141A);
const Color _bgPanel = Color(0xFF161D26);
const Color _bgPanel2 = Color(0xFF1C2530);
const Color _bgPanel3 = Color(0xFF222D3A);
const Color _bgCode = Color(0xFF0A0E13);

const Color _border = Color(0xFF2C3946);
const Color _borderSoft = Color(0xFF202A36);
const Color _borderHi = Color(0xFF3A4D62);

const Color _ink = Color(0xFFEDF1F6);
const Color _inkSoft = Color(0xFFC0CAD6);
const Color _inkMuted = Color(0xFF8893A2);
const Color _inkDim = Color(0xFF5E6976);

const Color _accent = Color(0xFF6FA8FF); // selection blue
const Color _accentDeep = Color(0xFF3D7AD9);
const Color _accentSoft = Color(0xFFA9C8FF);

const Color _amber = Color(0xFFE6B259);
const Color _amberSoft = Color(0xFFF1D49A);

const Color _green = Color(0xFF7AC196);

const Color _rose = Color(0xFFE07B8E);

const Color _violet = Color(0xFFA68BE6);
const Color _violetSoft = Color(0xFFCEBEEF);

const Color _teal = Color(0xFF6FC9C5);

const Color _selectionFill = Color(0xFF2D5BAB);
const Color _selectionFillSoft = Color(0xFF6FA8FF);

// ============================================================================
// TYPOGRAPHY
// ============================================================================

const TextStyle _tHero = TextStyle(
  color: _ink,
  fontSize: 30,
  fontWeight: FontWeight.w800,
  letterSpacing: -0.4,
);
const TextStyle _tHeroSub = TextStyle(
  color: _inkSoft,
  fontSize: 14,
  height: 1.5,
);
const TextStyle _tSection = TextStyle(
  color: _ink,
  fontSize: 20,
  fontWeight: FontWeight.w700,
  letterSpacing: -0.2,
);
const TextStyle _tSectionSub = TextStyle(
  color: _inkMuted,
  fontSize: 12,
  height: 1.4,
);
const TextStyle _tBody = TextStyle(
  color: _inkSoft,
  fontSize: 13,
  height: 1.45,
);
const TextStyle _tBodyHi = TextStyle(
  color: _ink,
  fontSize: 13,
  height: 1.45,
  fontWeight: FontWeight.w600,
);
const TextStyle _tLabel = TextStyle(
  color: _inkMuted,
  fontSize: 10,
  letterSpacing: 1.6,
  fontWeight: FontWeight.w700,
);
const TextStyle _tCode = TextStyle(
  color: Color(0xFFC9D7E5),
  fontSize: 12.5,
  height: 1.5,
  fontFamily: 'monospace',
);
const TextStyle _tCodeKey = TextStyle(
  color: Color(0xFF89B4FA),
  fontSize: 12.5,
  height: 1.5,
  fontFamily: 'monospace',
  fontWeight: FontWeight.w600,
);
const TextStyle _tDoc = TextStyle(
  color: _ink,
  fontSize: 14,
  height: 1.6,
);
const TextStyle _tDocSel = TextStyle(
  color: _ink,
  fontSize: 14,
  height: 1.6,
  backgroundColor: _selectionFill,
);

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  // Try to build the actual event. If d4rt's bridging chokes on the const
  // ctor, we fall back to a textual note rather than crashing the demo.
  String eventTypeLabel;
  String eventRuntimeLabel;
  String eventConstructionNote;
  try {
    final ClearSelectionEvent ev = const ClearSelectionEvent();
    final SelectionEventType t = ev.type;
    eventTypeLabel = t.toString();
    eventRuntimeLabel = ev.runtimeType.toString();
    eventConstructionNote = 'const ClearSelectionEvent() OK';
  } catch (e) {
    eventTypeLabel = 'SelectionEventType.clear';
    eventRuntimeLabel = 'ClearSelectionEvent';
    eventConstructionNote =
        'const ctor not bridged in this runtime — using literals (${e.runtimeType})';
  }

  // SelectionEventType enum values. We list them by name so we don't depend
  // on iteration order being bridged — d4rt forbids for-in over bridged
  // iterables anyway.
  final List<List<String>> eventTypeRows = <List<String>>[
    <String>['clear', 'Drop the entire selection — the subject of this demo.'],
    <String>['selectAll', 'Mark the whole subtree as selected.'],
    <String>['selectWord', 'Snap selection to the word at a global offset.'],
    <String>['selectParagraph', 'Snap selection to the paragraph at offset.'],
    <String>['startEdgeUpdate', 'Move the start edge of the selection.'],
    <String>['endEdgeUpdate', 'Move the end edge of the selection.'],
    <String>['granularlyExtendSelection', 'Extend by char/word/line/document.'],
    <String>['directionallyExtendSelection', 'Extend by direction (next line, …).'],
  ];

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #69, P2): the
  // composed page contains a hero block + 9 sections + spacers and is
  // far taller than the 800x600 test viewport — the bare Container >
  // Column overflowed by Infinity px on the bottom (and cascading NaN
  // offset errors from the broken layout). Wrap root in Scaffold >
  // SafeArea > SingleChildScrollView so the deep demo scrolls inside a
  // bounded viewport. The three Row(crossAxisAlignment.stretch) sites
  // in this script (inside _sectionHeader, _compareBlock, _pitfall) are
  // all wrapped in IntrinsicHeight, so the now-unbounded vertical
  // context does not trigger any new "BoxConstraints forces infinite
  // height" errors.
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: _bgDeep,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _hero(eventTypeLabel, eventRuntimeLabel, eventConstructionNote),
        const SizedBox(height: 36),
        _sectionAnatomy(),
        const SizedBox(height: 44),
        _sectionEventTypeMosaic(eventTypeRows),
        const SizedBox(height: 44),
        _sectionLifecycle(),
        const SizedBox(height: 44),
        _sectionMockDocument(),
        const SizedBox(height: 44),
        _sectionDispatchCode(),
        const SizedBox(height: 44),
        _sectionRegionMock(),
        const SizedBox(height: 44),
        _sectionComparison(),
        const SizedBox(height: 44),
        _sectionConstructor(),
        const SizedBox(height: 44),
        _sectionPitfalls(),
        const SizedBox(height: 44),
        _footer(),
      ],
    ),
        ),
      ),
    ),
  );
}

// ============================================================================
// HERO
// ============================================================================

Widget _hero(String typeLabel, String runtimeLabel, String note) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_bgPanel3, _bgPanel],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _borderHi, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _accent.withValues(alpha: 0.10),
          blurRadius: 32,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[_accent, _accentDeep],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _accent.withValues(alpha: 0.45),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.format_clear, color: Colors.white, size: 50),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('package:flutter/rendering.dart', style: _tLabel),
              const SizedBox(height: 6),
              const Text('ClearSelectionEvent', style: _tHero),
              const SizedBox(height: 6),
              const Text(
                'Deselect-all signal dispatched to a SelectionHandler.\n'
                'Carries no payload — pure command, type SelectionEventType.clear.',
                style: _tHeroSub,
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  _heroBadge('type', typeLabel, _accent),
                  _heroBadge('runtimeType', runtimeLabel, _violet),
                  _heroBadge('payload', 'none', _green),
                  _heroBadge('idempotent', 'yes', _amber),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _bgPanel2,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _borderSoft, width: 1),
                ),
                child: Text(note,
                    style: _tBody.copyWith(color: _inkMuted, fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _heroBadge(String label, String value, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            )),
        const SizedBox(width: 8),
        Text(value,
            style: TextStyle(
              color: _ink,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            )),
      ],
    ),
  );
}

// ============================================================================
// COMMON SECTION HEADER
// ============================================================================

Widget _sectionHeader(
  String number,
  String title,
  String subtitle,
  IconData icon,
  Color tint,
) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #69, P5(a)): the
  // original decoration combined borderRadius(14) with an asymmetric
  // Border (left: width 4 tint, top/right/bottom: width 1 _borderSoft).
  // Refactor to uniform Border.all(_borderSoft, 1) under a ClipRRect(14),
  // and render the tint accent as an actual 4-dp left strip inside an
  // IntrinsicHeight > Row(stretch). The gradient now fills the Expanded
  // body strip (visually equivalent for the header band).
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 20),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: IntrinsicHeight(
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: _borderSoft, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(width: 4, color: tint),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        tint.withValues(alpha: 0.18),
                        tint.withValues(alpha: 0.04),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[tint, tint.withValues(alpha: 0.55)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(13),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: tint.withValues(alpha: 0.45),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: tint.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(number,
                        style: TextStyle(
                          color: tint,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.3,
                        )),
                  ),
                  const SizedBox(width: 10),
                  Text(title, style: _tSection),
                ],
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: _tSectionSub),
            ],
          ),
        ),
      ],
    ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 1 — ANATOMY OF THE HIERARCHY
// ============================================================================

Widget _sectionAnatomy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '01',
        'Anatomy: where ClearSelectionEvent fits',
        'SelectionEvent is the abstract root. ClearSelectionEvent is one leaf among many.',
        Icons.account_tree_rounded,
        _accent,
      ),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _bgPanel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _hierarchyRoot('SelectionEvent', 'abstract'),
            _hierarchyArrow(),
            _hierarchyChildren(),
            const SizedBox(height: 22),
            _anatomyLegend(),
          ],
        ),
      ),
    ],
  );
}

Widget _hierarchyRoot(String name, String tag) {
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_violet, _accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _violet.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.workspaces_outlined, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              )),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(tag,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                )),
          ),
        ],
      ),
    ),
  );
}

Widget _hierarchyArrow() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: <Widget>[
          Container(width: 2, height: 14, color: _borderHi),
          Icon(Icons.expand_more, color: _borderHi, size: 22),
        ],
      ),
    ),
  );
}

Widget _hierarchyChildren() {
  final List<List<dynamic>> rows = <List<dynamic>>[
    <dynamic>['ClearSelectionEvent', 'clear', _accent, true],
    <dynamic>['SelectAllSelectionEvent', 'selectAll', _green, false],
    <dynamic>['SelectWordSelectionEvent', 'selectWord', _amber, false],
    <dynamic>['SelectParagraphSelectionEvent', 'selectParagraph', _teal, false],
    <dynamic>['SelectionEdgeUpdateEvent', 'startEdge / endEdge', _violet, false],
    <dynamic>['GranularlyExtendSelectionEvent', 'granularlyExtend', _rose, false],
    <dynamic>['DirectionallyExtendSelectionEvent', 'directionallyExtend', _amberSoft, false],
  ];
  return Wrap(
    spacing: 12,
    runSpacing: 12,
    alignment: WrapAlignment.center,
    children: <Widget>[
      _hierLeaf(rows[0][0] as String, rows[0][1] as String, rows[0][2] as Color, rows[0][3] as bool),
      _hierLeaf(rows[1][0] as String, rows[1][1] as String, rows[1][2] as Color, rows[1][3] as bool),
      _hierLeaf(rows[2][0] as String, rows[2][1] as String, rows[2][2] as Color, rows[2][3] as bool),
      _hierLeaf(rows[3][0] as String, rows[3][1] as String, rows[3][2] as Color, rows[3][3] as bool),
      _hierLeaf(rows[4][0] as String, rows[4][1] as String, rows[4][2] as Color, rows[4][3] as bool),
      _hierLeaf(rows[5][0] as String, rows[5][1] as String, rows[5][2] as Color, rows[5][3] as bool),
      _hierLeaf(rows[6][0] as String, rows[6][1] as String, rows[6][2] as Color, rows[6][3] as bool),
    ],
  );
}

Widget _hierLeaf(String name, String type, Color color, bool highlight) {
  return Container(
    width: 250,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: highlight ? color.withValues(alpha: 0.18) : _bgPanel2,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(
        color: highlight ? color : _borderSoft,
        width: highlight ? 2 : 1,
      ),
      boxShadow: highlight
          ? <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.30),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ]
          : <BoxShadow>[],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(name,
                  style: TextStyle(
                    color: highlight ? _ink : _inkSoft,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                  overflow: TextOverflow.ellipsis),
            ),
            if (highlight)
              Icon(Icons.center_focus_strong, color: color, size: 14),
          ],
        ),
        const SizedBox(height: 6),
        Text('SelectionEventType.$type',
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              fontFamily: 'monospace',
              letterSpacing: 0.2,
            )),
      ],
    ),
  );
}

Widget _anatomyLegend() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _bgPanel2,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: _borderSoft, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.lightbulb_outline, color: _amber, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text('Why a class hierarchy and not just an enum?', style: _tBodyHi),
              SizedBox(height: 4),
              Text(
                'Each subclass carries its own payload. ClearSelectionEvent is '
                'the rare one with no payload — but it still subclasses '
                'SelectionEvent so a SelectionHandler can dispatch on type.',
                style: _tBody,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 — SelectionEventType MOSAIC
// ============================================================================

Widget _sectionEventTypeMosaic(List<List<String>> rows) {
  // Map name → tint.
  final Map<String, Color> tints = <String, Color>{
    'clear': _accent,
    'selectAll': _green,
    'selectWord': _amber,
    'selectParagraph': _teal,
    'startEdgeUpdate': _violet,
    'endEdgeUpdate': _violetSoft,
    'granularlyExtendSelection': _rose,
    'directionallyExtendSelection': _amberSoft,
  };

  final List<Widget> chips = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    final String name = rows[i][0];
    final String desc = rows[i][1];
    final Color color = tints[name] ?? _inkSoft;
    chips.add(_eventTypeChip(name, desc, color, name == 'clear'));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '02',
        'SelectionEventType mosaic',
        'Every SelectionEvent reports a SelectionEventType. ClearSelectionEvent uses .clear.',
        Icons.grid_view_rounded,
        _green,
      ),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _bgPanel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
        ),
        child: Wrap(
          spacing: 14,
          runSpacing: 14,
          children: chips,
        ),
      ),
    ],
  );
}

Widget _eventTypeChip(String name, String desc, Color color, bool highlight) {
  return Container(
    width: 320,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: highlight ? 0.30 : 0.16),
          color.withValues(alpha: highlight ? 0.10 : 0.04),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: color.withValues(alpha: highlight ? 0.85 : 0.42),
        width: highlight ? 2 : 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.32),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('.$name',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 12,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  )),
            ),
            if (highlight) ...<Widget>[
              const SizedBox(width: 8),
              Icon(Icons.star, color: color, size: 14),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(desc, style: _tBody.copyWith(fontSize: 12)),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 — LIFECYCLE TIMELINE
// ============================================================================

Widget _sectionLifecycle() {
  final List<_Stage> stages = <_Stage>[
    const _Stage('idle', 'No selection. Cursor blinks, nothing highlighted.', Icons.circle_outlined, _inkMuted),
    const _Stage('start', 'SelectWordSelectionEvent / startEdgeUpdate.', Icons.touch_app, _green),
    const _Stage('extend', 'Repeated endEdgeUpdate as user drags.', Icons.swap_horiz, _amber),
    const _Stage('extend+', 'GranularlyExtend / DirectionallyExtend (Shift+→).', Icons.east, _rose),
    const _Stage('clear', 'ClearSelectionEvent dispatched (THIS event).', Icons.clear_all, _accent),
    const _Stage('idle', 'Back to no selection.', Icons.circle_outlined, _inkMuted),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '03',
        'Lifecycle timeline',
        'Six-stage walk through a typical selection: idle → start → extend → clear → idle.',
        Icons.timeline,
        _amber,
      ),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _bgPanel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          children: <Widget>[
            _lifecycleRow(stages, 0, 3),
            const SizedBox(height: 18),
            _lifecycleRow(stages, 3, 6),
            const SizedBox(height: 18),
            _lifecycleNarrative(),
          ],
        ),
      ),
    ],
  );
}

Widget _lifecycleRow(List<_Stage> stages, int from, int to) {
  final List<Widget> kids = <Widget>[];
  for (int i = from; i < to; i++) {
    if (i > from) kids.add(_lifecycleArrow(i == 4));
    kids.add(Expanded(child: _lifecycleCard(stages[i], i)));
  }
  return Row(crossAxisAlignment: CrossAxisAlignment.center, children: kids);
}

Widget _lifecycleArrow(bool emphasised) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Column(
      children: <Widget>[
        Icon(Icons.east,
            color: emphasised ? _accent : _borderHi,
            size: emphasised ? 26 : 22),
        if (emphasised)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text('clear',
                style: TextStyle(
                  color: _accent,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.3,
                )),
          ),
      ],
    ),
  );
}

Widget _lifecycleCard(_Stage stage, int index) {
  return Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: _bgPanel2,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: stage.color.withValues(alpha: 0.55), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: stage.color.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(stage.icon, color: stage.color, size: 18),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _bgDeep,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('#$index',
                  style: TextStyle(
                    color: _inkMuted,
                    fontSize: 9.5,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(stage.name,
            style: TextStyle(
              color: stage.color,
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            )),
        const SizedBox(height: 5),
        Text(stage.description, style: _tBody.copyWith(fontSize: 11.5)),
        const SizedBox(height: 10),
        _stageMiniDoc(index),
      ],
    ),
  );
}

Widget _stageMiniDoc(int index) {
  // Each tiny inset depicts what the document "looks like" at that stage.
  switch (index) {
    case 0:
      return _miniDoc(<double>[1.0, 0.0, 0.0]);
    case 1:
      return _miniDoc(<double>[0.45, 0.6, 0.0]); // partial start
    case 2:
      return _miniDoc(<double>[0.45, 1.0, 0.5]);
    case 3:
      return _miniDoc(<double>[0.45, 1.0, 1.0]);
    case 4:
      return _miniDoc(<double>[1.0, 0.0, 0.0]);
    case 5:
      return _miniDoc(<double>[1.0, 0.0, 0.0]);
  }
  return _miniDoc(<double>[1.0, 0.0, 0.0]);
}

Widget _miniDoc(List<double> selFactors) {
  // Three "lines" of fake text. selFactor: 0 = no selection, 1 = full line.
  final List<Widget> lines = <Widget>[];
  for (int i = 0; i < 3; i++) {
    final double f = i < selFactors.length ? selFactors[i] : 0.0;
    lines.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Stack(
        children: <Widget>[
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: _borderSoft,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          if (f > 0.0)
            FractionallySizedBox(
              widthFactor: f.clamp(0.0, 1.0),
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[_selectionFill, _selectionFillSoft],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
        ],
      ),
    ));
  }
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _bgDeep,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _borderSoft, width: 1),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: lines),
  );
}

Widget _lifecycleNarrative() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _bgDeep,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: _borderSoft, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 4,
          height: 56,
          decoration: BoxDecoration(
            color: _accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text('Where ClearSelectionEvent fits in the timeline',
                  style: _tBodyHi),
              SizedBox(height: 6),
              Text(
                'The clear stage is *terminal* for the active selection. After a '
                'handler processes it, range, position, and start/end edges are '
                'forgotten — but the handler itself stays subscribed to the '
                'SelectionRegistrar, ready for the next start.',
                style: _tBody,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Stage {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  const _Stage(this.name, this.description, this.icon, this.color);
}

// ============================================================================
// SECTION 4 — MOCK DOCUMENT, THREE STATES
// ============================================================================

Widget _sectionMockDocument() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '04',
        'Mock document — three selection states',
        'A paragraph painted with overlay rectangles to depict full / partial / cleared states.',
        Icons.article_outlined,
        _teal,
      ),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _bgPanel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _docState('1. Fully selected', 'SelectAll dispatched.', _green, _DocSelMode.full)),
            const SizedBox(width: 14),
            Expanded(child: _docState('2. Partly selected', 'Drag in progress, mid-extend.', _amber, _DocSelMode.partial)),
            const SizedBox(width: 14),
            Expanded(child: _docState('3. Cleared', 'After ClearSelectionEvent.', _accent, _DocSelMode.none)),
          ],
        ),
      ),
    ],
  );
}

enum _DocSelMode { full, partial, none }

Widget _docState(String title, String subtitle, Color color, _DocSelMode mode) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _bgPanel2,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title, style: _tBodyHi.copyWith(color: color)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: _tBody.copyWith(fontSize: 11.5)),
        const SizedBox(height: 12),
        _docPaint(mode),
        const SizedBox(height: 10),
        _docCaption(mode),
      ],
    ),
  );
}

Widget _docPaint(_DocSelMode mode) {
  // Render Text.rich with three TextSpans. The "selection" is a Container
  // overlay drawn in a Stack — a static depiction, not real selection.
  const String s1 = 'Selection events are how Flutter ';
  const String s2 = 'communicates with selectable widgets ';
  const String s3 = 'about user intent.';

  TextSpan span(String t, bool selected) => TextSpan(
        text: t,
        style: selected ? _tDocSel : _tDoc,
      );

  // Decide which spans appear "selected".
  bool a, b, c;
  switch (mode) {
    case _DocSelMode.full:
      a = true;
      b = true;
      c = true;
      break;
    case _DocSelMode.partial:
      a = false;
      b = true;
      c = false;
      break;
    case _DocSelMode.none:
      a = false;
      b = false;
      c = false;
      break;
  }

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _bgDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _borderSoft, width: 1),
    ),
    child: Text.rich(
      TextSpan(children: <InlineSpan>[span(s1, a), span(s2, b), span(s3, c)]),
    ),
  );
}

Widget _docCaption(_DocSelMode mode) {
  String label;
  String hint;
  switch (mode) {
    case _DocSelMode.full:
      label = 'range = [0, length)';
      hint = 'After SelectAllSelectionEvent';
      break;
    case _DocSelMode.partial:
      label = 'range = [13, 47)';
      hint = 'After endEdgeUpdate (mid-drag)';
      break;
    case _DocSelMode.none:
      label = 'range = none';
      hint = 'After ClearSelectionEvent';
      break;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: _bgDeep,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _borderSoft, width: 1),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.crop_free, color: _inkMuted, size: 14),
        const SizedBox(width: 7),
        Expanded(
          child: Text(label,
              style: TextStyle(
                color: _inkSoft,
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
              overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(width: 8),
        Text(hint,
            style: TextStyle(
              color: _inkMuted,
              fontSize: 10,
              fontStyle: FontStyle.italic,
            )),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5 — DISPATCH CODE CARD
// ============================================================================

Widget _sectionDispatchCode() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '05',
        'How a SelectionHandler receives ClearSelectionEvent',
        'Conceptual wiring: handler.dispatchSelectionEvent(const ClearSelectionEvent()).',
        Icons.code,
        _violet,
      ),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _bgPanel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _codeCard(
              title: 'dispatch.dart',
              lines: <String>[
                '// Conceptual — your real handler is provided by the framework.',
                'final SelectionHandler handler = registrar.findHandler();',
                '',
                '// Build the event. No payload, just a const signal.',
                'const SelectionEvent ev = ClearSelectionEvent();',
                '',
                '// Dispatch — the handler returns a SelectionResult.',
                'final SelectionResult r = handler.dispatchSelectionEvent(ev);',
                '',
                '// For .clear, r is typically SelectionResult.none — there\'s',
                '// nothing left to track; the handler swallowed the signal.',
                'assert(ev.type == SelectionEventType.clear);',
              ],
            ),
            const SizedBox(height: 16),
            _codeAnnotations(),
          ],
        ),
      ),
    ],
  );
}

Widget _codeCard({required String title, required List<String> lines}) {
  final List<Widget> lineWidgets = <Widget>[];
  for (int i = 0; i < lines.length; i++) {
    final String text = lines[i];
    final bool isComment = text.trim().startsWith('//');
    final TextStyle style = isComment
        ? _tCode.copyWith(color: _inkMuted, fontStyle: FontStyle.italic)
        : _tCodeKey;
    lineWidgets.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 28,
            child: Text('${i + 1}',
                style: TextStyle(
                  color: _inkDim,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.right),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    ));
  }
  return Container(
    decoration: BoxDecoration(
      color: _bgCode,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: _borderSoft, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #69, P5(a)):
        // the original header decoration combined a BorderRadius.only
        // with Border(bottom: only) — the unspecified sides default to
        // BorderSide.none (color black) which differs from the bottom's
        // _borderSoft, triggering the uniform-colors assertion. Use
        // ClipRRect for the top-corner rounding and a separate bottom
        // border via a uniform Border.all on a zero-height bottom strip
        // — achieved here by wrapping in a Column and using a 1-dp
        // Container divider below the header (visually identical).
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(13),
            topRight: Radius.circular(13),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _bgPanel2,
              border: Border(
                bottom: BorderSide(color: _borderSoft, width: 1),
              ),
            ),
            child: Row(
            children: <Widget>[
              Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: _rose, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: _amber, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: _green, shape: BoxShape.circle)),
              const SizedBox(width: 14),
              Text(title,
                  style: TextStyle(
                    color: _inkSoft,
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                  )),
            ],
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lineWidgets,
          ),
        ),
      ],
    ),
  );
}

Widget _codeAnnotations() {
  final List<List<dynamic>> ann = <List<dynamic>>[
    <dynamic>['no payload', 'ClearSelectionEvent() takes no parameters.', _green],
    <dynamic>['const-friendly', 'You can const-construct it; equality is identity.', _accent],
    <dynamic>['dispatch result', 'Usually SelectionResult.none after a clear.', _amber],
    <dynamic>['idempotent', 'Clearing an empty selection is a no-op.', _violet],
  ];
  final List<Widget> kids = <Widget>[];
  for (int i = 0; i < ann.length; i++) {
    kids.add(_codeAnnRow(
      ann[i][0] as String,
      ann[i][1] as String,
      ann[i][2] as Color,
    ));
  }
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _bgPanel2,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: _borderSoft, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: kids,
    ),
  );
}

Widget _codeAnnRow(String tag, String description, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 110,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
          ),
          child: Text(tag,
              style: TextStyle(
                color: color,
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                fontFamily: 'monospace',
              )),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(description, style: _tBody.copyWith(fontSize: 12))),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6 — SELECTABLE REGION MOCK
// ============================================================================

Widget _sectionRegionMock() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '06',
        'SelectableRegion mock',
        'Three sentences with three "buttons" — purely visual, no callbacks.',
        Icons.tab_unselected,
        _rose,
      ),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _bgPanel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _regionFrame(),
            const SizedBox(height: 14),
            _regionButtons(),
            const SizedBox(height: 14),
            _regionLegend(),
          ],
        ),
      ),
    ],
  );
}

Widget _regionFrame() {
  // SelectableRegion frame visualisation — three sentences as separate
  // selectable units.
  const List<String> sentences = <String>[
    'A SelectionRegistrar collects Selectables from its subtree.',
    'Each Selectable becomes a SelectionHandler when an event arrives.',
    'A ClearSelectionEvent tells every handler to drop its current range.',
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < sentences.length; i++) {
    rows.add(_regionSentence(i, sentences[i]));
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _bgPanel2,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: _accent.withValues(alpha: 0.45), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _accent.withValues(alpha: 0.10),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.tab_unselected, color: _accent, size: 16),
            const SizedBox(width: 8),
            Text('SelectableRegion (mock)',
                style: TextStyle(
                  color: _accentSoft,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                )),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _green.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('3 selectables',
                  style: TextStyle(
                    color: _green,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...rows,
      ],
    ),
  );
}

Widget _regionSentence(int i, String text) {
  // Slightly different "selection state" per sentence to suggest variety.
  final List<double> sels = <double>[0.0, 0.55, 0.0];
  final double f = sels[i];
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _bgDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderSoft, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _violet.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('${i + 1}',
                style: TextStyle(
                  color: _violet,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                )),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 18,
                  alignment: Alignment.centerLeft,
                  child: Text(text,
                      style: _tBody.copyWith(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                if (f > 0.0)
                  IgnorePointer(
                    child: FractionallySizedBox(
                      widthFactor: f,
                      child: Container(
                        height: 18,
                        decoration: BoxDecoration(
                          color: _selectionFill.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _regionButtons() {
  return Row(
    children: <Widget>[
      Expanded(child: _regionButton('Select All', 'SelectAllSelectionEvent', _green, Icons.select_all)),
      const SizedBox(width: 12),
      Expanded(child: _regionButton('Select Word', 'SelectWordSelectionEvent', _amber, Icons.spellcheck)),
      const SizedBox(width: 12),
      Expanded(child: _regionButton('Clear', 'ClearSelectionEvent', _accent, Icons.format_clear)),
    ],
  );
}

Widget _regionButton(String label, String dispatched, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.28),
          color.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                  color: _ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                )),
          ],
        ),
        const SizedBox(height: 6),
        Text('would dispatch:',
            style: TextStyle(
              color: _inkMuted,
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            )),
        const SizedBox(height: 2),
        Text(dispatched,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            )),
      ],
    ),
  );
}

Widget _regionLegend() {
  return Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: _bgPanel2,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _borderSoft, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.info_outline, color: _accentSoft, size: 17),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            'Buttons are static depictions — d4rt does not run callbacks here. '
            'In a real app, each tap would call selectableRegionState.'
            'selectAll / selectWordEdgeAt / clearSelection, which in turn '
            'dispatches the named event to every registered handler.',
            style: _tBody.copyWith(fontSize: 11.5),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7 — COMPARISON TABLE (3 columns)
// ============================================================================

Widget _sectionComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '07',
        'Comparison: clear vs selectAll vs selectWord',
        'Three SelectionEvents side by side. ClearSelectionEvent is the only one with no payload.',
        Icons.compare_arrows,
        _amber,
      ),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _bgPanel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _compareColumn(
              name: 'ClearSelectionEvent',
              type: 'SelectionEventType.clear',
              icon: Icons.format_clear,
              color: _accent,
              payload: 'none',
              effect: 'Drops every range and edge. Selection becomes empty.',
              when: 'ESC pressed, tap outside region, programmatic clear.',
              ctor: 'const ClearSelectionEvent()',
              note: 'Pure signal — no positional / named arguments.',
              isHighlight: true,
            )),
            const SizedBox(width: 14),
            Expanded(child: _compareColumn(
              name: 'SelectAllSelectionEvent',
              type: 'SelectionEventType.selectAll',
              icon: Icons.select_all,
              color: _green,
              payload: 'none',
              effect: 'Marks the entire content of every handler as selected.',
              when: 'Cmd/Ctrl+A, "Select All" menu item.',
              ctor: 'const SelectAllSelectionEvent()',
              note: 'Also payload-less — but the *result* is maximal selection.',
              isHighlight: false,
            )),
            const SizedBox(width: 14),
            Expanded(child: _compareColumn(
              name: 'SelectWordSelectionEvent',
              type: 'SelectionEventType.selectWord',
              icon: Icons.spellcheck,
              color: _amber,
              payload: 'globalPosition: Offset',
              effect: 'Snaps selection to the word at globalPosition.',
              when: 'Double-tap, long-press, "Select Word" menu.',
              ctor: 'SelectWordSelectionEvent(globalPosition: Offset(...))',
              note: 'Has a real payload — the screen-space pointer location.',
              isHighlight: false,
            )),
          ],
        ),
      ),
    ],
  );
}

Widget _compareColumn({
  required String name,
  required String type,
  required IconData icon,
  required Color color,
  required String payload,
  required String effect,
  required String when,
  required String ctor,
  required String note,
  required bool isHighlight,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: isHighlight ? color.withValues(alpha: 0.10) : _bgPanel2,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(
        color: color.withValues(alpha: isHighlight ? 0.85 : 0.45),
        width: isHighlight ? 2 : 1,
      ),
      boxShadow: isHighlight
          ? <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ]
          : <BoxShadow>[],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[color, color.withValues(alpha: 0.55)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(name,
                  style: TextStyle(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  )),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _compareRow('type', type, color),
        _compareRow('payload', payload, _inkSoft),
        _compareRow('ctor', ctor, _inkSoft),
        const SizedBox(height: 10),
        _compareBlock('effect', effect, _green),
        _compareBlock('when', when, _violet),
        _compareBlock('note', note, _amber),
      ],
    ),
  );
}

Widget _compareRow(String label, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 60,
          child: Text(label,
              style: TextStyle(
                color: _inkMuted,
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              )),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(value,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2),
        ),
      ],
    ),
  );
}

Widget _compareBlock(String label, String text, Color color) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #69, P5(a)): the
  // original decoration combined borderRadius(8) with Border(left: only).
  // The unspecified BorderSides default to BorderSide.none (color black,
  // width 0) which is not uniform with the left side. Refactor to a
  // ClipRRect(8) > IntrinsicHeight > Row(stretch, [3-dp accent, Expanded
  // (Padding(9, content))]) with no border on the inner DecoratedBox.
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: IntrinsicHeight(
        child: DecoratedBox(
          decoration: BoxDecoration(color: _bgDeep),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(width: 3, color: color),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(label.toUpperCase(),
                          style: TextStyle(
                            color: color,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.4,
                          )),
                      const SizedBox(height: 3),
                      Text(text, style: _tBody.copyWith(fontSize: 11.5)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 8 — CONSTRUCTOR CARD
// ============================================================================

Widget _sectionConstructor() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '08',
        'Constructor: ClearSelectionEvent()',
        'No parameters. No payload. The signal IS the value.',
        Icons.build_circle_outlined,
        _violet,
      ),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _bgPanel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 5, child: _ctorSignature()),
            const SizedBox(width: 18),
            Expanded(flex: 4, child: _ctorRationale()),
          ],
        ),
      ),
    ],
  );
}

Widget _ctorSignature() {
  return _codeCard(
    title: 'clear_selection_event.dart',
    lines: <String>[
      '// From package:flutter/src/rendering/selection.dart',
      'class ClearSelectionEvent extends SelectionEvent {',
      '  const ClearSelectionEvent() : super._(SelectionEventType.clear);',
      '',
      '  // No fields. No properties. No equality customisation.',
      '  // Two ClearSelectionEvent instances are interchangeable.',
      '}',
      '',
      '// Equivalent at the call-site:',
      'const ClearSelectionEvent c1 = ClearSelectionEvent();',
      'const ClearSelectionEvent c2 = ClearSelectionEvent();',
      'assert(identical(c1, c2));   // const-canonicalised',
      'assert(c1.type == c2.type);  // both .clear',
    ],
  );
}

Widget _ctorRationale() {
  final List<List<String>> rationale = <List<String>>[
    <String>['Why no payload?',
      'Clearing is total. There is no "where" or "how much" to clear — '
      'the handler simply drops everything it currently tracks.'],
    <String>['Why const?',
      'A const ClearSelectionEvent can be canonicalised by the compiler — '
      'no allocation per dispatch, no GC pressure for a high-frequency '
      'signal.'],
    <String>['Why not an enum value alone?',
      'Because every SelectionEvent is dispatched via the same '
      'dispatchSelectionEvent(SelectionEvent) method. A class lets '
      'the type system stay uniform with payload-bearing events.'],
    <String>['Why no callback?',
      'The handler returns a SelectionResult synchronously. Callbacks '
      'would invert the control flow and break the dispatch loop.'],
  ];
  final List<Widget> kids = <Widget>[];
  for (int i = 0; i < rationale.length; i++) {
    kids.add(_rationaleRow(rationale[i][0], rationale[i][1], i));
  }
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _bgPanel2,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: _violet.withValues(alpha: 0.45), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: kids,
    ),
  );
}

Widget _rationaleRow(String q, String a, int i) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _violet.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text('${i + 1}',
              style: TextStyle(
                color: _violet,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              )),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(q, style: _tBodyHi.copyWith(fontSize: 12.5)),
              const SizedBox(height: 3),
              Text(a, style: _tBody.copyWith(fontSize: 11.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9 — PITFALLS
// ============================================================================

Widget _sectionPitfalls() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '09',
        'Pitfalls — and SelectionContainer.disabled',
        'A handful of footguns when wiring ClearSelectionEvent into your widget tree.',
        Icons.warning_amber_rounded,
        _rose,
      ),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _bgPanel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _pitfall(
              icon: Icons.shield_moon,
              tint: _rose,
              title: 'SelectionContainer.disabled blocks dispatch',
              body:
                  'Wrapping a subtree in SelectionContainer.disabled() prevents '
                  'any SelectionEvent — including ClearSelectionEvent — from '
                  'reaching its descendants. If a clear "doesn\'t work", check '
                  'for a disabled SelectionContainer ancestor first.',
            ),
            const SizedBox(height: 12),
            _pitfall(
              icon: Icons.repeat,
              tint: _amber,
              title: 'Clears are idempotent — but still cost a frame',
              body:
                  'Dispatching ClearSelectionEvent on an already-empty selection '
                  'is safe (handlers return SelectionResult.none) but still '
                  'walks the tree. Avoid spamming clears in tight loops.',
            ),
            const SizedBox(height: 12),
            _pitfall(
              icon: Icons.merge_type,
              tint: _accent,
              title: 'Clear vs disposing the SelectableRegion',
              body:
                  'Clearing keeps the registrar and handlers alive for the next '
                  'selection. Disposing the SelectableRegion tears them down. '
                  'Use clear for "deselect", dispose for "navigate away".',
            ),
            const SizedBox(height: 12),
            _pitfall(
              icon: Icons.flash_on,
              tint: _green,
              title: 'Clear + new start in the same frame is fine',
              body:
                  'You can dispatch ClearSelectionEvent and immediately follow '
                  'with a SelectWordSelectionEvent. The handler observes them '
                  'in order and the user sees a single-frame transition.',
            ),
            const SizedBox(height: 12),
            _pitfall(
              icon: Icons.bug_report,
              tint: _violet,
              title: 'Don\'t conflate clear with paint suppression',
              body:
                  'Hiding the selection highlight (e.g. via theme) does not '
                  'clear the underlying range. The handler still owns it. '
                  'Always dispatch ClearSelectionEvent if you want the model '
                  'to forget.',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _pitfall({
  required IconData icon,
  required Color tint,
  required String title,
  required String body,
}) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #69, P5(a)): the
  // original decoration combined borderRadius(11) with an asymmetric
  // Border (left: width 4 tint, top/right/bottom: width 1 _borderSoft).
  // Refactor to uniform Border.all(_borderSoft, 1) under a ClipRRect(11)
  // with the tint accent rendered as a 4-dp left strip inside an
  // IntrinsicHeight > Row(stretch).
  return ClipRRect(
    borderRadius: BorderRadius.circular(11),
    child: IntrinsicHeight(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgPanel2,
          border: Border.all(color: _borderSoft, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(width: 4, color: tint),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: tint.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: tint, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title, style: _tBodyHi),
                          const SizedBox(height: 4),
                          Text(body, style: _tBody),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 10 — FOOTER
// ============================================================================

Widget _footer() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_bgPanel3, _bgPanel],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _borderHi, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[_accent, _violet],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(Icons.bookmark_added,
                  color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text('Summary', style: _tSection),
                  SizedBox(height: 2),
                  Text(
                    'ClearSelectionEvent — the single-purpose deselect-all signal.',
                    style: _tSectionSub,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _footerBullets(),
        const SizedBox(height: 14),
        _footerSig(),
      ],
    ),
  );
}

Widget _footerBullets() {
  final List<List<dynamic>> bullets = <List<dynamic>>[
    <dynamic>[Icons.check_circle, _green,
      'ClearSelectionEvent extends SelectionEvent — a leaf in the rendering hierarchy.'],
    <dynamic>[Icons.check_circle, _green,
      'Reports SelectionEventType.clear; carries no payload.'],
    <dynamic>[Icons.check_circle, _green,
      'const-constructible — cheap to dispatch repeatedly.'],
    <dynamic>[Icons.check_circle, _green,
      'Handled by every SelectionHandler beneath the SelectionRegistrar.'],
    <dynamic>[Icons.check_circle, _green,
      'Idempotent: clearing an empty selection is a safe no-op.'],
    <dynamic>[Icons.check_circle, _green,
      'Blocked by SelectionContainer.disabled — verify ancestors when debugging.'],
    <dynamic>[Icons.check_circle, _green,
      'Use clear for "deselect", dispose for "tear down the region".'],
  ];
  final List<Widget> kids = <Widget>[];
  for (int i = 0; i < bullets.length; i++) {
    kids.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(bullets[i][0] as IconData,
              color: bullets[i][1] as Color, size: 16),
          const SizedBox(width: 9),
          Expanded(
            child: Text(bullets[i][2] as String,
                style: _tBody.copyWith(fontSize: 12.5)),
          ),
        ],
      ),
    ));
  }
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _bgPanel2,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _borderSoft, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: kids,
    ),
  );
}

Widget _footerSig() {
  return Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: _bgDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _borderSoft, width: 1),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.code, color: _accent, size: 16),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            'package:flutter/rendering.dart  ·  ClearSelectionEvent  ·  '
            'static dynamic build(BuildContext) — d4rt deep-demo script',
            style: TextStyle(
              color: _inkSoft,
              fontSize: 11.5,
              fontFamily: 'monospace',
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    ),
  );
}

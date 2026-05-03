// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of TextSelectionToolbar.
//
// This script is shipped over HTTP to a d4rt-driven Flutter test app and
// rendered live. It must execute in d4rt's static-only sandbox: no setState,
// no controllers, no animations, no dynamic iteration over BridgedInstance.
//
// The demo focuses on Material's `TextSelectionToolbar` widget, which is the
// pill-shaped popover Material renders above or below selected text. The
// real selection lifecycle is not driven here; instead we place the toolbar
// directly inside Stacks together with painted "anchor markers" so the
// reader can study every visual variant of the toolbar in isolation.
//
// Structure (8+ sections, each a Card):
//   1. Intro                  — what the toolbar is and why it matters
//   2. Anchor above           — toolbar pinned above an anchor marker
//   3. Anchor below           — toolbar pinned below an anchor marker
//   4. Variable child counts  — 1, 2, 3, 4, 5, 6 actions
//   5. Long action labels     — overflow / wrapping behaviour
//   6. Icon actions row       — buttons that mix icons with labels
//   7. Anatomy diagram        — labelled boxes describing the parts
//   8. Adaptive comparison    — Material vs Cupertino contrast notes
//
// All `TextSelectionToolbarTextButton.onPressed` callbacks are no-ops so
// the demo produces zero side effects when interpreted.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'TextSelectionToolbar Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.purple,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F2FB),
      appBar: AppBar(
        title: const Text('TextSelectionToolbar'),
        backgroundColor: Colors.purple.shade100,
        foregroundColor: Colors.purple.shade900,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildIntroCard(),
          const SizedBox(height: 16),
          _buildAnchorAboveSection(),
          const SizedBox(height: 16),
          _buildAnchorBelowSection(),
          const SizedBox(height: 16),
          _buildVariableChildCounts(),
          const SizedBox(height: 16),
          _buildLongActionLabels(),
          const SizedBox(height: 16),
          _buildIconActionsRow(),
          const SizedBox(height: 16),
          _buildAnatomyDiagram(),
          const SizedBox(height: 16),
          _buildComparisonWithCupertino(),
          const SizedBox(height: 16),
          _buildClosingNotes(),
          const SizedBox(height: 32),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Intro card.
// ---------------------------------------------------------------------------

Widget _buildIntroCard() {
  return _sectionCard(
    headerTitle: '1. What is TextSelectionToolbar?',
    headerSubtitle: 'The Material popover for selected text',
    headerGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF7B1FA2), Color(0xFFCE93D8)],
    ),
    headerIcon: Icons.text_fields,
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'The TextSelectionToolbar widget paints the small pill-shaped '
            'popover that Material renders above (or below) a text selection. '
            'It hosts the Cut / Copy / Paste / Select all actions and is '
            'usually wired up internally by EditableText, but the widget can '
            'be used standalone as well.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          const Text(
            'Two anchor offsets drive its position:\n'
            '  • anchorAbove — preferred Y when there is room above\n'
            '  • anchorBelow — fallback Y when there is no room above\n'
            'Both anchors are global Offsets in screen coordinates, and the '
            'toolbar internally clamps itself within the safe area.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 16),
          _miniLegend(),
          const SizedBox(height: 16),
          _calloutBox(
            title: 'Static demo only',
            message:
                'This script runs inside the d4rt sandbox, so we cannot drive '
                'a real selection. Each section instead places the toolbar '
                'inside a fixed-size Stack alongside an anchor marker so the '
                'visual layout can be inspected without lifecycle plumbing.',
            color: Colors.purple,
            icon: Icons.info_outline,
          ),
        ],
      ),
    ),
  );
}

Widget _miniLegend() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Legend used in every section:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _legendRow(Colors.deepPurple, 'Anchor marker (where text is selected)'),
        _legendRow(Colors.teal, 'anchorAbove offset target'),
        _legendRow(Colors.orange, 'anchorBelow offset target'),
        _legendRow(Colors.grey, 'Available content area'),
      ],
    ),
  );
}

Widget _legendRow(Color color, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — Anchor above demo.
// ---------------------------------------------------------------------------

Widget _buildAnchorAboveSection() {
  return _sectionCard(
    headerTitle: '2. Anchor above the selection',
    headerSubtitle: 'Toolbar appears above when there is enough room',
    headerGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF00796B), Color(0xFF80CBC4)],
    ),
    headerIcon: Icons.arrow_upward,
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'When the user selects text and the system has space above the '
            'selection, the toolbar prefers the anchorAbove position. The '
            'tail of the pill points down toward the selection, and the '
            'buttons read left-to-right. This is the default in most desktop '
            'and tablet contexts where the upper region of the screen is '
            'rarely occluded.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: Stack(
              children: <Widget>[
                _backgroundGrid(Colors.teal.shade50),
                _anchorMarker(left: 140, top: 150, color: Colors.deepPurple),
                _anchorDot(left: 152, top: 110, color: Colors.teal,
                    label: 'above'),
                Positioned(
                  left: 50,
                  top: 30,
                  child: TextSelectionToolbar(
                    anchorAbove: const Offset(150, 110),
                    anchorBelow: const Offset(150, 170),
                    children: <Widget>[
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        onPressed: () {},
                        child: const Text('Cut'),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        onPressed: () {},
                        child: const Text('Copy'),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        onPressed: () {},
                        child: const Text('Paste'),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        onPressed: () {},
                        child: const Text('Select all'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _bulletNotes(<String>[
            'anchorAbove: Offset(150, 110) — chosen because there is space.',
            'Buttons use TextSelectionToolbarTextButton with default padding.',
            'The toolbar internally clamps to safe horizontal margins.',
            'On Android the pill uses the M3 surface tone with elevation 1.',
          ]),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — Anchor below demo.
// ---------------------------------------------------------------------------

Widget _buildAnchorBelowSection() {
  return _sectionCard(
    headerTitle: '3. Anchor below the selection',
    headerSubtitle: 'Used when there is no headroom above',
    headerGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFE65100), Color(0xFFFFB74D)],
    ),
    headerIcon: Icons.arrow_downward,
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'If the selection sits near the top of the screen, or if a sticky '
            'header occludes the would-be toolbar position, Material flips '
            'the toolbar to anchorBelow. The pill grows downward and the '
            'tail points up toward the highlighted run. This avoids the '
            'common iOS bug of selection toolbars colliding with the status '
            'bar or notification panel.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: Stack(
              children: <Widget>[
                _backgroundGrid(Colors.orange.shade50),
                _anchorMarker(left: 140, top: 30, color: Colors.deepPurple),
                _anchorDot(left: 152, top: 70, color: Colors.orange,
                    label: 'below'),
                Positioned(
                  left: 60,
                  top: 90,
                  child: TextSelectionToolbar(
                    anchorAbove: const Offset(150, 0),
                    anchorBelow: const Offset(150, 70),
                    children: <Widget>[
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        onPressed: () {},
                        child: const Text('Cut'),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        onPressed: () {},
                        child: const Text('Copy'),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        onPressed: () {},
                        child: const Text('Share'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _bulletNotes(<String>[
            'anchorAbove pinned to y=0 to force the below position.',
            'anchorBelow points to the bottom edge of the selection.',
            'Three actions keep the pill compact for narrow viewports.',
            'On Android 12+ the elevation creates a subtle shadow ring.',
          ]),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — Variable child counts.
// ---------------------------------------------------------------------------

Widget _buildVariableChildCounts() {
  return _sectionCard(
    headerTitle: '4. Variable child counts',
    headerSubtitle: '1, 2, 3, 4, 5 and 6 actions',
    headerGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF1565C0), Color(0xFF64B5F6)],
    ),
    headerIcon: Icons.format_list_numbered,
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'TextSelectionToolbar accepts any number of children. Below we '
            'render six toolbars side-by-side, each with a different number '
            'of actions. Notice how the pill expands horizontally as actions '
            'are added; once it would overflow the screen, Material switches '
            'to a paginated overflow menu (not shown here because we have '
            'plenty of room in this static demo).',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          _toolbarRow(
            label: '1 child',
            offset: const Offset(80, 60),
            children: <Widget>[
              _tbButton('Copy'),
            ],
          ),
          const SizedBox(height: 12),
          _toolbarRow(
            label: '2 children',
            offset: const Offset(80, 60),
            children: <Widget>[
              _tbButton('Copy'),
              _tbButton('Paste'),
            ],
          ),
          const SizedBox(height: 12),
          _toolbarRow(
            label: '3 children',
            offset: const Offset(80, 60),
            children: <Widget>[
              _tbButton('Cut'),
              _tbButton('Copy'),
              _tbButton('Paste'),
            ],
          ),
          const SizedBox(height: 12),
          _toolbarRow(
            label: '4 children',
            offset: const Offset(80, 60),
            children: <Widget>[
              _tbButton('Cut'),
              _tbButton('Copy'),
              _tbButton('Paste'),
              _tbButton('Select all'),
            ],
          ),
          const SizedBox(height: 12),
          _toolbarRow(
            label: '5 children',
            offset: const Offset(80, 60),
            children: <Widget>[
              _tbButton('Cut'),
              _tbButton('Copy'),
              _tbButton('Paste'),
              _tbButton('Select all'),
              _tbButton('Share'),
            ],
          ),
          const SizedBox(height: 12),
          _toolbarRow(
            label: '6 children',
            offset: const Offset(60, 60),
            children: <Widget>[
              _tbButton('Cut'),
              _tbButton('Copy'),
              _tbButton('Paste'),
              _tbButton('All'),
              _tbButton('Share'),
              _tbButton('Look up'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _toolbarRow({
  required String label,
  required Offset offset,
  required List<Widget> children,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade100),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.blue.shade100,
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 110,
          child: Stack(
            children: <Widget>[
              _backgroundGrid(Colors.white),
              _anchorMarker(left: 140, top: 80, color: Colors.deepPurple),
              Positioned(
                left: offset.dx,
                top: offset.dy - 50,
                child: TextSelectionToolbar(
                  anchorAbove: Offset(offset.dx + 70, offset.dy - 10),
                  anchorBelow: Offset(offset.dx + 70, offset.dy + 30),
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _tbButton(String label) {
  return TextSelectionToolbarTextButton(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    onPressed: () {},
    child: Text(label),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — Long action labels.
// ---------------------------------------------------------------------------

Widget _buildLongActionLabels() {
  return _sectionCard(
    headerTitle: '5. Long action labels',
    headerSubtitle: 'Translation strings can stretch the pill',
    headerGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFAD1457), Color(0xFFF06292)],
    ),
    headerIcon: Icons.translate,
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Localised strings can be much longer than their English source. '
            'German "Auswählen" is two characters longer than "Select", and '
            'Finnish "Valitse kaikki" is nearly twice the length of "All". '
            'TextSelectionToolbar handles this by letting the pill grow until '
            'it cannot fit on screen, at which point overflow handling kicks '
            'in and the trailing actions move into a chevron menu.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: Stack(
              children: <Widget>[
                _backgroundGrid(Colors.pink.shade50),
                _anchorMarker(left: 160, top: 130, color: Colors.deepPurple),
                Positioned(
                  left: 20,
                  top: 30,
                  child: TextSelectionToolbar(
                    anchorAbove: const Offset(170, 110),
                    anchorBelow: const Offset(170, 170),
                    children: <Widget>[
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        onPressed: () {},
                        child: const Text('Auswählen'),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        onPressed: () {},
                        child: const Text('Kopieren'),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        onPressed: () {},
                        child: const Text('Einfügen'),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 110,
                  child: TextSelectionToolbar(
                    anchorAbove: const Offset(170, 90),
                    anchorBelow: const Offset(170, 150),
                    children: <Widget>[
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        onPressed: () {},
                        child: const Text('Valitse kaikki'),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        onPressed: () {},
                        child: const Text('Etsi'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _bulletNotes(<String>[
            'Two stacked toolbars to compare label widths side by side.',
            'Top toolbar uses German labels (Auswählen / Kopieren / Einfügen).',
            'Bottom toolbar uses Finnish labels (Valitse kaikki / Etsi).',
            'Designers should test localisation early to spot pill clipping.',
          ]),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Icon actions row.
// ---------------------------------------------------------------------------

Widget _buildIconActionsRow() {
  return _sectionCard(
    headerTitle: '6. Icon-bearing actions',
    headerSubtitle: 'Mixing icons and labels in the pill',
    headerGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF2E7D32), Color(0xFFA5D6A7)],
    ),
    headerIcon: Icons.emoji_symbols,
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'TextSelectionToolbarTextButton accepts any child widget. While '
            'pure-text labels are the convention, you can supply Row(icon, '
            'text) combos for richer affordances such as language switching '
            'or document-action menus. Keep icons small (16-18 dp) and pad '
            'them tightly to maintain the toolbar\'s pill aesthetic.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: Stack(
              children: <Widget>[
                _backgroundGrid(Colors.green.shade50),
                _anchorMarker(left: 170, top: 130, color: Colors.deepPurple),
                Positioned(
                  left: 20,
                  top: 30,
                  child: TextSelectionToolbar(
                    anchorAbove: const Offset(180, 110),
                    anchorBelow: const Offset(180, 170),
                    children: <Widget>[
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.content_cut, size: 16),
                            SizedBox(width: 6),
                            Text('Cut'),
                          ],
                        ),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.content_copy, size: 16),
                            SizedBox(width: 6),
                            Text('Copy'),
                          ],
                        ),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.content_paste, size: 16),
                            SizedBox(width: 6),
                            Text('Paste'),
                          ],
                        ),
                      ),
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.share, size: 16),
                            SizedBox(width: 6),
                            Text('Share'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _bulletNotes(<String>[
            'Each child is a Row(icon, gap, text) inside the text button.',
            'Icons are 16dp to match the M3 dense toolbar guidance.',
            'Reusable helpers keep the boilerplate manageable in real apps.',
            'Mixing icons sparingly; over-decoration distracts from the text.',
          ]),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — Anatomy diagram.
// ---------------------------------------------------------------------------

Widget _buildAnatomyDiagram() {
  return _sectionCard(
    headerTitle: '7. Anatomy of the toolbar',
    headerSubtitle: 'Static layout labelling each visual part',
    headerGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF4527A0), Color(0xFF9575CD)],
    ),
    headerIcon: Icons.architecture,
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'The toolbar is composed of a few clearly identifiable parts: '
            'the rounded surface (the "pill"), the inner padding region, the '
            'row of TextSelectionToolbarTextButton instances, the optional '
            'overflow chevron, and the tail that visually connects the pill '
            'to the selection. Each part can be themed independently using '
            'the Material 3 surface tokens.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          _anatomyBox(
            title: 'Pill surface',
            description: 'BorderRadius.circular(8), elevation 1, surface tint',
            color: Colors.deepPurple.shade100,
          ),
          _anatomyBox(
            title: 'Inner padding',
            description: 'EdgeInsets.symmetric(horizontal: 0, vertical: 0)',
            color: Colors.purple.shade100,
          ),
          _anatomyBox(
            title: 'Action row',
            description: 'Row of TextSelectionToolbarTextButton widgets',
            color: Colors.indigo.shade100,
          ),
          _anatomyBox(
            title: 'Overflow chevron',
            description: 'Appears when child count exceeds the available width',
            color: Colors.blue.shade100,
          ),
          _anatomyBox(
            title: 'Tail / pointer',
            description: 'Drawn by parent compositor; not a sub-widget',
            color: Colors.cyan.shade100,
          ),
          _anatomyBox(
            title: 'Anchor offsets',
            description: 'anchorAbove + anchorBelow guide the layout pass',
            color: Colors.teal.shade100,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: Stack(
              children: <Widget>[
                _backgroundGrid(Colors.deepPurple.shade50),
                _anchorMarker(left: 150, top: 140, color: Colors.deepPurple),
                Positioned(
                  left: 30,
                  top: 30,
                  child: TextSelectionToolbar(
                    anchorAbove: const Offset(160, 120),
                    anchorBelow: const Offset(160, 170),
                    children: <Widget>[
                      _tbButton('Cut'),
                      _tbButton('Copy'),
                      _tbButton('Paste'),
                      _tbButton('Select all'),
                    ],
                  ),
                ),
                const Positioned(
                  left: 230,
                  top: 50,
                  child: _DiagramArrow(label: 'pill surface'),
                ),
                const Positioned(
                  left: 230,
                  top: 80,
                  child: _DiagramArrow(label: 'action row'),
                ),
                const Positioned(
                  left: 230,
                  top: 140,
                  child: _DiagramArrow(label: 'anchor'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _anatomyBox({
  required String title,
  required String description,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.label_important_outline, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(description, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}

class _DiagramArrow extends StatelessWidget {
  final String label;
  const _DiagramArrow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.arrow_left, size: 14, color: Colors.deepPurple),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8 — Comparison with Cupertino.
// ---------------------------------------------------------------------------

Widget _buildComparisonWithCupertino() {
  return _sectionCard(
    headerTitle: '8. Material vs Cupertino comparison',
    headerSubtitle: 'AdaptiveTextSelectionToolbar bridges the two',
    headerGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFC62828), Color(0xFFEF9A9A)],
    ),
    headerIcon: Icons.compare_arrows,
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Flutter ships TWO platform-specific toolbars: TextSelectionToolbar '
            '(Material) and CupertinoTextSelectionToolbar (iOS). When you do '
            'not need to pick manually, the AdaptiveTextSelectionToolbar '
            'widget chooses the right one for you based on the current '
            'TargetPlatform. Below is a side-by-side schematic comparison.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _platformCard(
                title: 'Material',
                accent: Colors.purple,
                lines: <String>[
                  'Pill with rounded square corners',
                  'Surface tone matches M3 theme',
                  'Elevation produces faint shadow',
                  'Buttons use ButtonStyle.text',
                  'Overflow uses chevron icon',
                ],
              )),
              const SizedBox(width: 12),
              Expanded(child: _platformCard(
                title: 'Cupertino',
                accent: Colors.blue,
                lines: <String>[
                  'Capsule with full rounded ends',
                  'Translucent vibrancy backdrop',
                  'No elevation; uses platform blur',
                  'Buttons use SF Pro typography',
                  'Overflow uses arrow paginator',
                ],
              )),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: Stack(
              children: <Widget>[
                _backgroundGrid(Colors.red.shade50),
                _anchorMarker(left: 150, top: 130, color: Colors.deepPurple),
                Positioned(
                  left: 30,
                  top: 30,
                  child: TextSelectionToolbar(
                    anchorAbove: const Offset(160, 110),
                    anchorBelow: const Offset(160, 170),
                    children: <Widget>[
                      _tbButton('Cut'),
                      _tbButton('Copy'),
                      _tbButton('Paste'),
                    ],
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 110,
                  child: _fakeCupertinoToolbar(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _bulletNotes(<String>[
            'Material toolbar drawn with the real widget for accuracy.',
            'Cupertino toolbar simulated below with a stylised capsule.',
            'AdaptiveTextSelectionToolbar picks based on Theme.platform.',
            'Most apps should let the adaptive variant do the work.',
          ]),
        ],
      ),
    ),
  );
}

Widget _platformCard({
  required String title,
  required MaterialColor accent,
  required List<String> lines,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[accent.shade50, accent.shade100],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.shade200),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.shade100,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: accent.shade900,
          ),
        ),
        const SizedBox(height: 8),
        _platformBullet(lines, 0),
        _platformBullet(lines, 1),
        _platformBullet(lines, 2),
        _platformBullet(lines, 3),
        _platformBullet(lines, 4),
      ],
    ),
  );
}

Widget _platformBullet(List<String> lines, int index) {
  if (index >= lines.length) {
    return const SizedBox.shrink();
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(lines[index], style: const TextStyle(fontSize: 12))),
      ],
    ),
  );
}

Widget _fakeCupertinoToolbar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.85),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text('Cut', style: TextStyle(color: Colors.white, fontSize: 13)),
        SizedBox(width: 14),
        Text('Copy', style: TextStyle(color: Colors.white, fontSize: 13)),
        SizedBox(width: 14),
        Text('Paste', style: TextStyle(color: Colors.white, fontSize: 13)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Closing notes.
// ---------------------------------------------------------------------------

Widget _buildClosingNotes() {
  return _sectionCard(
    headerTitle: '9. Closing notes & best practices',
    headerSubtitle: 'When to use, when to avoid, and what to remember',
    headerGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF37474F), Color(0xFF90A4AE)],
    ),
    headerIcon: Icons.bookmark_added,
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Use TextSelectionToolbar when you need a Material-styled selection '
            'popover but want to bypass the default EditableText pipeline. '
            'Common reasons include integrating with a custom selection '
            'controller, building a rich-text editor, or providing extra '
            'actions such as "Translate" or "Define". Avoid bypassing the '
            'adaptive variant in cross-platform apps; users expect the '
            'native look on each platform.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          _calloutBox(
            title: 'Do',
            message:
                'Prefer AdaptiveTextSelectionToolbar.editableText / .editable / '
                '.buttonItems factories — they wire up the standard actions and '
                'still let you append custom buttons.',
            color: Colors.green,
            icon: Icons.check_circle_outline,
          ),
          const SizedBox(height: 8),
          _calloutBox(
            title: 'Avoid',
            message:
                'Do not hard-code anchor offsets in production. Use the '
                'TextSelectionDelegate / SelectionOverlay APIs to compute '
                'anchors from the live RenderEditable geometry.',
            color: Colors.red,
            icon: Icons.warning_amber_outlined,
          ),
          const SizedBox(height: 8),
          _calloutBox(
            title: 'Remember',
            message:
                'TextSelectionToolbarTextButton has special padding rules: '
                'the leading and trailing buttons use larger horizontal '
                'padding than the inner ones. Use the .getPadding helper if '
                'you want to mimic that precisely.',
            color: Colors.amber,
            icon: Icons.memory,
          ),
          const SizedBox(height: 16),
          const Text(
            'End of demo.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared section card scaffolding.
// ---------------------------------------------------------------------------

Widget _sectionCard({
  required String headerTitle,
  required String headerSubtitle,
  required Gradient headerGradient,
  required IconData headerIcon,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(gradient: headerGradient),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(headerIcon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        headerTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        headerSubtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body,
        ],
      ),
    ),
  );
}

Widget _calloutBox({
  required String title,
  required String message,
  required MaterialColor color,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.shade200),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.shade100,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color.shade700, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
              const SizedBox(height: 4),
              Text(message, style: const TextStyle(fontSize: 13, height: 1.35)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _bulletNotes(List<String> lines) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _bulletLine(lines, 0),
        _bulletLine(lines, 1),
        _bulletLine(lines, 2),
        _bulletLine(lines, 3),
        _bulletLine(lines, 4),
        _bulletLine(lines, 5),
      ],
    ),
  );
}

Widget _bulletLine(List<String> lines, int index) {
  if (index >= lines.length) {
    return const SizedBox.shrink();
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('▸ ', style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(lines[index], style: const TextStyle(fontSize: 13)),
        ),
      ],
    ),
  );
}

Widget _backgroundGrid(Color color) {
  return Positioned.fill(
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: <Widget>[
          _gridDivider(),
          _gridDivider(),
          _gridDivider(),
          _gridDivider(),
        ],
      ),
    ),
  );
}

Widget _gridDivider() {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
    ),
  );
}

Widget _anchorMarker({
  required double left,
  required double top,
  required Color color,
}) {
  return Positioned(
    left: left,
    top: top,
    child: Container(
      width: 24,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    ),
  );
}

Widget _anchorDot({
  required double left,
  required double top,
  required MaterialColor color,
  required String label,
}) {
  return Positioned(
    left: left,
    top: top,
    child: Row(
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.shade200,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

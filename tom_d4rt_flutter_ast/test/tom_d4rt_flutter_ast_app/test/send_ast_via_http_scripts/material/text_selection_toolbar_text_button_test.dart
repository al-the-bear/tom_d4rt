// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of TextSelectionToolbarTextButton.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'TextSelectionToolbarTextButton Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
    home: Scaffold(
      appBar: AppBar(title: const Text('TextSelectionToolbarTextButton')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildIntroCard(),
          const SizedBox(height: 18),
          _buildSingleButtonShowcase(),
          const SizedBox(height: 18),
          _buildPaddingFromIndex(),
          const SizedBox(height: 18),
          _buildStandardActionLabels(),
          const SizedBox(height: 18),
          _buildToolbarSurrogate(),
          const SizedBox(height: 18),
          _buildVariationsWithIcons(),
          const SizedBox(height: 18),
          _buildButtonAnatomyDiagram(),
          const SizedBox(height: 18),
          _buildUsageGuide(),
          const SizedBox(height: 24),
          _buildFooter(),
          const SizedBox(height: 32),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Intro card
// ---------------------------------------------------------------------------
Widget _buildIntroCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFE0B2), Color(0xFFFFCC80), Color(0xFFFFB74D)],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33FF8F00),
          blurRadius: 24,
          offset: Offset(0, 10),
        ),
        BoxShadow(
          color: Color(0x22FF6F00),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFE65100), Color(0xFFBF360C)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x55BF360C),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.text_fields,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TextSelectionToolbarTextButton',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Inner action button used by TextSelectionToolbar',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF5D4037),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.78),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            'TextSelectionToolbarTextButton is a thin Material wrapper around '
            'TextButton that mimics the native Android text-selection menu '
            'button. Each button is constructed with an explicit padding which '
            'depends on whether the button is the first, middle, last, or only '
            'item in the toolbar. Use the static helper getPadding(index, total) '
            'to compute the standard padding so first/last items breathe a '
            'little wider, while middle items stay tight.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF3E2723),
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _buildPill('child: Text', const Color(0xFFFF6F00)),
            _buildPill('padding: EdgeInsetsGeometry', const Color(0xFFEF6C00)),
            _buildPill('onPressed: VoidCallback?', const Color(0xFFE65100)),
            _buildPill('alignment: AlignmentGeometry?', const Color(0xFFD84315)),
            _buildPill('static getPadding(i, n)', const Color(0xFFBF360C)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPill(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.4),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2: Single button showcase
// ---------------------------------------------------------------------------
Widget _buildSingleButtonShowcase() {
  return _sectionShell(
    title: 'Single button showcase',
    subtitle: 'A bare TextSelectionToolbarTextButton, framed for visibility.',
    accent: const Color(0xFFFF6F00),
    body: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xFFFFFDE7), Color(0xFFFFF3E0)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFFFB74D),
              width: 1.2,
            ),
          ),
          child: Column(
            children: <Widget>[
              const Text(
                'Bare button, transparent background, EdgeInsets.symmetric(horizontal: 14)',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6D4C41),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextSelectionToolbarTextButton(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  onPressed: () {},
                  child: const Text('Tap me'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Notice that the button has no visible chrome of its own. The Material '
            'TextSelectionToolbar provides the rounded-pill background, and each '
            'TextSelectionToolbarTextButton inherits the parent surface color via '
            'a transparent background. The label color tracks the active '
            'ColorScheme.onSurface, falling back to black/white on the default '
            'light/dark schemes.',
            style: TextStyle(fontSize: 12, color: Color(0xFF5D4037), height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3: Padding from index helper — the key pedagogical section
// ---------------------------------------------------------------------------
Widget _buildPaddingFromIndex() {
  return _sectionShell(
    title: 'TextSelectionToolbarTextButton.getPadding(index, total)',
    subtitle: 'First/last buttons get more start/end padding so they breathe '
        'against the rounded toolbar edges. Middle buttons stay tight.',
    accent: const Color(0xFFEF6C00),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paddingRuleExplanation(),
        const SizedBox(height: 16),
        _paddingRow1Single(),
        const SizedBox(height: 14),
        _paddingRow2Pair(),
        const SizedBox(height: 14),
        _paddingRow3Trio(),
        const SizedBox(height: 14),
        _paddingRow4Quad(),
        const SizedBox(height: 14),
        _paddingRow5Quintet(),
        const SizedBox(height: 14),
        _paddingRow6Sextet(),
        const SizedBox(height: 16),
        _paddingValuesTable(),
      ],
    ),
  );
}

Widget _paddingRuleExplanation() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFECB3)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFFFB300), width: 1),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.rule, color: Color(0xFFE65100), size: 20),
            SizedBox(width: 8),
            Text(
              'The padding rule',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: Color(0xFF3E2723),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'EdgeInsetsDirectional.only(start, end). Internal constants:\n'
          '  • _kMiddlePadding = 9.5  (between siblings)\n'
          '  • _kEndPadding   = 14.5 (against toolbar edges)\n\n'
          'Position rules:\n'
          '  • only   (total == 1)            → start = 14.5, end = 14.5\n'
          '  • first  (index == 0)            → start = 14.5, end = 9.5\n'
          '  • middle (0 < index < total - 1) → start = 9.5,  end = 9.5\n'
          '  • last   (index == total - 1)    → start = 9.5,  end = 14.5\n\n'
          'Net effect: a 5-logical-pixel breathing room at the toolbar edges, '
          'and tight 9.5-pixel gutters between sibling buttons.',
          style: TextStyle(
            fontSize: 12,
            height: 1.5,
            color: Color(0xFF4E342E),
          ),
        ),
      ],
    ),
  );
}

Widget _paddingRow1Single() {
  return _paddingDemoBlock(
    title: 'total = 1 (single button is "only")',
    swatch: const Color(0xFFFFA000),
    pillRow: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(0, 1),
          onPressed: () {},
          child: const Text('Copy'),
        ),
      ],
    ),
    description: 'A solitary button is treated as "only": both edges get the '
        'wider 14.5px padding so the label is centered with comfortable margins.',
  );
}

Widget _paddingRow2Pair() {
  return _paddingDemoBlock(
    title: 'total = 2 (first + last)',
    swatch: const Color(0xFFFB8C00),
    pillRow: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(0, 2),
          onPressed: () {},
          child: const Text('Cut'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(1, 2),
          onPressed: () {},
          child: const Text('Copy'),
        ),
      ],
    ),
    description: 'Two buttons share a tight inner gutter (9.5 + 9.5 = 19px '
        'between glyph runs) but each outer edge is widened to 14.5px.',
  );
}

Widget _paddingRow3Trio() {
  return _paddingDemoBlock(
    title: 'total = 3 (first + middle + last)',
    swatch: const Color(0xFFF57C00),
    pillRow: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(0, 3),
          onPressed: () {},
          child: const Text('Cut'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(1, 3),
          onPressed: () {},
          child: const Text('Copy'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(2, 3),
          onPressed: () {},
          child: const Text('Paste'),
        ),
      ],
    ),
    description: 'Classic 3-button layout. The middle button uses the tighter '
        '9.5/9.5 padding. The first and last keep their wide outer edges.',
  );
}

Widget _paddingRow4Quad() {
  return _paddingDemoBlock(
    title: 'total = 4 (first, middle, middle, last)',
    swatch: const Color(0xFFEF6C00),
    pillRow: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(0, 4),
          onPressed: () {},
          child: const Text('Cut'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(1, 4),
          onPressed: () {},
          child: const Text('Copy'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(2, 4),
          onPressed: () {},
          child: const Text('Paste'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(3, 4),
          onPressed: () {},
          child: const Text('Select all'),
        ),
      ],
    ),
    description: 'With 4 buttons, both inner buttons (indices 1 and 2) report '
        'as middle and share the same tight padding profile.',
  );
}

Widget _paddingRow5Quintet() {
  return _paddingDemoBlock(
    title: 'total = 5 (first, middle×3, last)',
    swatch: const Color(0xFFE65100),
    pillRow: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(0, 5),
          onPressed: () {},
          child: const Text('Cut'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(1, 5),
          onPressed: () {},
          child: const Text('Copy'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(2, 5),
          onPressed: () {},
          child: const Text('Paste'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(3, 5),
          onPressed: () {},
          child: const Text('Look up'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(4, 5),
          onPressed: () {},
          child: const Text('Share'),
        ),
      ],
    ),
    description: 'Five buttons. Indices 1, 2 and 3 all map to the middle '
        'position and share the 9.5/9.5 padding profile.',
  );
}

Widget _paddingRow6Sextet() {
  return _paddingDemoBlock(
    title: 'total = 6 (first, middle×4, last)',
    swatch: const Color(0xFFD84315),
    pillRow: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(0, 6),
          onPressed: () {},
          child: const Text('Cut'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(1, 6),
          onPressed: () {},
          child: const Text('Copy'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(2, 6),
          onPressed: () {},
          child: const Text('Paste'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(3, 6),
          onPressed: () {},
          child: const Text('Look up'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(4, 6),
          onPressed: () {},
          child: const Text('Search'),
        ),
        Container(width: 1, height: 28, color: const Color(0x22000000)),
        TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(5, 6),
          onPressed: () {},
          child: const Text('Share'),
        ),
      ],
    ),
    description: 'Six buttons. The same rule scales up: only the first and '
        'last receive the wider 14.5px outer edge; everything between is tight.',
  );
}

Widget _paddingDemoBlock({
  required String title,
  required Color swatch,
  required Widget pillRow,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: swatch.withOpacity(0.4), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: swatch.withOpacity(0.18),
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
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: swatch,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: swatch.withOpacity(0.5),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: swatch,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: pillRow,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF5D4037),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _paddingValuesTable() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFFDE7), Color(0xFFFFF8E1)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFFFE082)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Computed padding values (start / end, in logical pixels)',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 13,
            color: Color(0xFF3E2723),
          ),
        ),
        const SizedBox(height: 10),
        _tableRow('Position', 'start', 'end', isHeader: true),
        _tableDivider(),
        _tableRow('only   (total = 1)', '14.5', '14.5'),
        _tableDivider(),
        _tableRow('first  (index = 0)', '14.5', '9.5'),
        _tableDivider(),
        _tableRow('middle (interior)', '9.5', '9.5'),
        _tableDivider(),
        _tableRow('last   (index = n - 1)', '9.5', '14.5'),
      ],
    ),
  );
}

Widget _tableRow(String a, String b, String c, {bool isHeader = false}) {
  final TextStyle style = TextStyle(
    fontSize: 12,
    color: const Color(0xFF3E2723),
    fontWeight: isHeader ? FontWeight.w800 : FontWeight.w500,
  );
  return Row(
    children: <Widget>[
      Expanded(flex: 4, child: Text(a, style: style)),
      Expanded(flex: 2, child: Text(b, style: style, textAlign: TextAlign.center)),
      Expanded(flex: 2, child: Text(c, style: style, textAlign: TextAlign.center)),
    ],
  );
}

Widget _tableDivider() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Divider(height: 1, color: Color(0x33FF8F00)),
  );
}

// ---------------------------------------------------------------------------
// Section 4: Standard action labels
// ---------------------------------------------------------------------------
Widget _buildStandardActionLabels() {
  return _sectionShell(
    title: 'Standard action labels',
    subtitle: 'Common labels shipped by Material text-selection toolbars.',
    accent: const Color(0xFFE65100),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'These labels are produced by MaterialLocalizations and surfaced '
          'via the editable text\'s context menu builders. The exact set '
          'depends on selection state, platform, and capabilities.',
          style: TextStyle(fontSize: 12, color: Color(0xFF5D4037), height: 1.4),
        ),
        const SizedBox(height: 14),
        _actionLabelTile(
          label: 'Cut',
          icon: Icons.content_cut,
          color: const Color(0xFFD84315),
          description: 'Removes the current selection and copies it to the '
              'clipboard. Hidden when the selection is empty or read-only.',
        ),
        const SizedBox(height: 10),
        _actionLabelTile(
          label: 'Copy',
          icon: Icons.content_copy,
          color: const Color(0xFFE65100),
          description: 'Copies the current selection to the clipboard. '
              'Hidden when the selection is empty.',
        ),
        const SizedBox(height: 10),
        _actionLabelTile(
          label: 'Paste',
          icon: Icons.content_paste,
          color: const Color(0xFFEF6C00),
          description: 'Inserts clipboard content at the caret. Greyed out '
              'when the clipboard is empty (platform-dependent).',
        ),
        const SizedBox(height: 10),
        _actionLabelTile(
          label: 'Select all',
          icon: Icons.select_all,
          color: const Color(0xFFF57C00),
          description: 'Expands the selection to span all editable text.',
        ),
        const SizedBox(height: 10),
        _actionLabelTile(
          label: 'Look up',
          icon: Icons.menu_book,
          color: const Color(0xFFFB8C00),
          description: 'Opens the system dictionary or definition lookup '
              'for the current selection (platform-gated).',
        ),
        const SizedBox(height: 10),
        _actionLabelTile(
          label: 'Search',
          icon: Icons.search,
          color: const Color(0xFFFFA000),
          description: 'Searches the web for the selected text using the '
              'platform default search provider.',
        ),
        const SizedBox(height: 10),
        _actionLabelTile(
          label: 'Share',
          icon: Icons.share,
          color: const Color(0xFFFFB300),
          description: 'Opens the system share sheet with the selected '
              'text as the share payload.',
        ),
        const SizedBox(height: 10),
        _actionLabelTile(
          label: 'Translate',
          icon: Icons.translate,
          color: const Color(0xFFFFC107),
          description: 'Opens the system translation flow for the current '
              'selection. Available on iOS 18+ and select Android builds.',
        ),
        const SizedBox(height: 10),
        _actionLabelTile(
          label: 'Custom action',
          icon: Icons.extension,
          color: const Color(0xFFBF360C),
          description: 'Apps can append additional actions via '
              'EditableTextContextMenuBuilder by emitting their own '
              'TextSelectionToolbarTextButton entries.',
        ),
      ],
    ),
  );
}

Widget _actionLabelTile({
  required String label,
  required IconData icon,
  required Color color,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.3), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.12),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[color, color.withOpacity(0.7)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: TextSelectionToolbarTextButton(
            padding: const EdgeInsetsDirectional.only(start: 14.5, end: 14.5),
            onPressed: () {},
            child: Text(label),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF5D4037),
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: Toolbar surrogate — the rounded-pill container in context
// ---------------------------------------------------------------------------
Widget _buildToolbarSurrogate() {
  return _sectionShell(
    title: 'Toolbar surrogate',
    subtitle: 'How buttons sit inside a rounded-pill container that mimics '
        'the real TextSelectionToolbar.',
    accent: const Color(0xFFBF360C),
    body: Column(
      children: <Widget>[
        _toolbarStage(
          label: 'Pixel-style toolbar (3 actions)',
          children: <Widget>[
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(0, 3),
              onPressed: () {},
              child: const Text('Cut'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(1, 3),
              onPressed: () {},
              child: const Text('Copy'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(2, 3),
              onPressed: () {},
              child: const Text('Paste'),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _toolbarStage(
          label: 'With selection-aware actions (5)',
          children: <Widget>[
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(0, 5),
              onPressed: () {},
              child: const Text('Cut'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(1, 5),
              onPressed: () {},
              child: const Text('Copy'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(2, 5),
              onPressed: () {},
              child: const Text('Paste'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(3, 5),
              onPressed: () {},
              child: const Text('Look up'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(4, 5),
              onPressed: () {},
              child: const Text('Share'),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _toolbarStage(
          label: 'Read-only selection (Copy + Look up + Share)',
          children: <Widget>[
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(0, 3),
              onPressed: () {},
              child: const Text('Copy'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(1, 3),
              onPressed: () {},
              child: const Text('Look up'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(2, 3),
              onPressed: () {},
              child: const Text('Share'),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _toolbarStage(
          label: 'Single "only" button',
          children: <Widget>[
            TextSelectionToolbarTextButton(
              padding: TextSelectionToolbarTextButton.getPadding(0, 1),
              onPressed: () {},
              child: const Text('Paste'),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Notice that nothing about the buttons themselves changes when '
            'they appear inside the toolbar — the surrounding pill provides '
            'the surface color, and each button paints its label on top with '
            'a transparent background. Padding is the only per-button knob '
            'the toolbar tunes for visual rhythm.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF5D4037),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _toolbarStage({required String label, required List<Widget> children}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 6),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF5D4037),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
      ),
    ],
  );
}

class _ToolbarDivider extends StatelessWidget {
  const _ToolbarDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 28,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: const Color(0x22000000),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6: Variations with icons and trailing chevrons
// ---------------------------------------------------------------------------
Widget _buildVariationsWithIcons() {
  return _sectionShell(
    title: 'Variations: leading icons, trailing chevrons',
    subtitle: 'Even though the contract is `child: Widget`, you can compose '
        'arbitrarily — Row, icons, badges, chevrons.',
    accent: const Color(0xFFD84315),
    body: Column(
      children: <Widget>[
        _variationCard(
          title: 'Leading icon variant',
          accent: const Color(0xFFD84315),
          children: <Widget>[
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 14.5, end: 9.5),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.content_cut, size: 16),
                  SizedBox(width: 6),
                  Text('Cut'),
                ],
              ),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 9.5, end: 9.5),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.content_copy, size: 16),
                  SizedBox(width: 6),
                  Text('Copy'),
                ],
              ),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 9.5, end: 14.5),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.content_paste, size: 16),
                  SizedBox(width: 6),
                  Text('Paste'),
                ],
              ),
            ),
          ],
          description: 'A Row child lets you prepend a 16px icon. Note that '
              'the standard padding still wraps the entire Row.',
        ),
        const SizedBox(height: 14),
        _variationCard(
          title: 'Trailing chevron (overflow indicator)',
          accent: const Color(0xFFBF360C),
          children: <Widget>[
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 14.5, end: 9.5),
              onPressed: () {},
              child: const Text('Cut'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 9.5, end: 9.5),
              onPressed: () {},
              child: const Text('Copy'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 9.5, end: 14.5),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('More'),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 18),
                ],
              ),
            ),
          ],
          description: 'A chevron in the trailing position is the standard '
              'pattern for "more actions". Tapping should expand the toolbar '
              'or open a secondary menu.',
        ),
        const SizedBox(height: 14),
        _variationCard(
          title: 'Badged button (count indicator)',
          accent: const Color(0xFFAD1457),
          children: <Widget>[
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 14.5, end: 9.5),
              onPressed: () {},
              child: const Text('Suggestions'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 9.5, end: 9.5),
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Replace'),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFAD1457),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 9.5, end: 14.5),
              onPressed: () {},
              child: const Text('Dismiss'),
            ),
          ],
          description: 'Compose a tiny badge inside the child Row to surface '
              'a count, e.g. number of spell-check suggestions.',
        ),
        const SizedBox(height: 14),
        _variationCard(
          title: 'Long labels (translate, look up)',
          accent: const Color(0xFF6A1B9A),
          children: <Widget>[
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 14.5, end: 9.5),
              onPressed: () {},
              child: const Text('Translate'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 9.5, end: 9.5),
              onPressed: () {},
              child: const Text('Look up'),
            ),
            const _ToolbarDivider(),
            TextSelectionToolbarTextButton(
              padding: const EdgeInsetsDirectional.only(start: 9.5, end: 14.5),
              onPressed: () {},
              child: const Text('Share via …'),
            ),
          ],
          description: 'Longer labels still respect the same padding rule. '
              'The horizontal scroll inside our surrogate prevents overflow '
              'while preserving the visual rhythm.',
        ),
        const SizedBox(height: 14),
        _hoverPressedSection(),
      ],
    ),
  );
}

Widget _variationCard({
  required String title,
  required Color accent,
  required List<Widget> children,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          accent.withOpacity(0.06),
          accent.withOpacity(0.14),
        ],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withOpacity(0.3), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.18),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: accent,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(
            fontSize: 11.5,
            color: Color(0xFF5D4037),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _hoverPressedSection() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Hover and pressed states',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Color(0xFF004D40),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Because TextSelectionToolbarTextButton wraps a TextButton, it '
          'inherits Material\'s hover / focus / pressed overlays. The '
          'overlay colors are derived from ColorScheme.onSurface and applied '
          'on top of the transparent background. Visualisation:',
          style: TextStyle(fontSize: 12, color: Color(0xFF004D40), height: 1.4),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(child: _stateChip('default', const Color(0x00000000), Colors.transparent)),
            const SizedBox(width: 8),
            Expanded(child: _stateChip('hover', const Color(0x14000000), const Color(0xFFFFFFFF))),
            const SizedBox(width: 8),
            Expanded(child: _stateChip('focus', const Color(0x1F000000), const Color(0xFFFFFFFF))),
            const SizedBox(width: 8),
            Expanded(child: _stateChip('pressed', const Color(0x29000000), const Color(0xFFFFFFFF))),
          ],
        ),
      ],
    ),
  );
}

Widget _stateChip(String label, Color overlay, Color base) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    decoration: BoxDecoration(
      color: base,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF80CBC4), width: 1),
    ),
    child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: overlay,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF004D40),
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: Anatomy diagram
// ---------------------------------------------------------------------------
Widget _buildButtonAnatomyDiagram() {
  return _sectionShell(
    title: 'Button anatomy',
    subtitle: 'A labelled diagram showing the parts of one '
        'TextSelectionToolbarTextButton inside its toolbar.',
    accent: const Color(0xFF6A1B9A),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x336A1B9A),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              const Text(
                'Anatomy of an "only" button (start = 14.5, end = 14.5)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4A148C),
                ),
              ),
              const SizedBox(height: 14),
              _anatomyDiagram(),
              const SizedBox(height: 14),
              _anatomyLegend(),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _hitRegionExplanation(),
      ],
    ),
  );
}

Widget _anatomyDiagram() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // The hit region (kMinInteractiveDimension = 48px tall)
        Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFFF7043),
              width: 1.5,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // Padding region
        Container(
          height: 36,
          margin: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: const Color(0x336A1B9A),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        // Label area
        Container(
          height: 22,
          margin: const EdgeInsets.symmetric(horizontal: 32.5),
          decoration: BoxDecoration(
            color: const Color(0xFF4A148C),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Cut',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyLegend() {
  return Column(
    children: <Widget>[
      _legendRow(
        const Color(0xFFFF7043),
        'Hit region',
        'Always at least kMinInteractiveDimension (48 logical px) tall, '
            'enforced by minimumSize on the underlying TextButton.',
      ),
      const SizedBox(height: 6),
      _legendRow(
        const Color(0x886A1B9A),
        'Padding (start / end)',
        'EdgeInsetsDirectional.only(start, end). 14.5 on outer edges, 9.5 '
            'between siblings. No vertical padding is applied here.',
      ),
      const SizedBox(height: 6),
      _legendRow(
        const Color(0xFF4A148C),
        'Label area',
        'The child widget — typically a Text. Foreground color comes from '
            'ColorScheme.onSurface; weight is FontWeight.w400.',
      ),
    ],
  );
}

Widget _legendRow(Color color, String name, String description) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: 14,
        height: 14,
        margin: const EdgeInsets.only(top: 2, right: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      Expanded(
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF4A148C),
              height: 1.4,
            ),
            children: <InlineSpan>[
              TextSpan(
                text: '$name — ',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              TextSpan(text: description),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _hitRegionExplanation() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFFFB300)),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.touch_app, color: Color(0xFFE65100), size: 18),
            SizedBox(width: 6),
            Text(
              'Why the hit region is bigger than the label',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: Color(0xFF3E2723),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'TextSelectionToolbarTextButton sets minimumSize to '
          'Size(kMinInteractiveDimension, kMinInteractiveDimension), which is '
          '48×48 logical pixels. That guarantees the button is large enough '
          'to be tapped reliably even when the label is short — e.g. "Cut" '
          'paints in roughly 22×16 px, but the underlying TextButton still '
          'reports a 48px-tall hit area.',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF5D4037),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8: Usage guide
// ---------------------------------------------------------------------------
Widget _buildUsageGuide() {
  return _sectionShell(
    title: 'Usage guide',
    subtitle: 'When (and when not) to instantiate '
        'TextSelectionToolbarTextButton directly.',
    accent: const Color(0xFF1B5E20),
    body: Column(
      children: <Widget>[
        _guidanceCard(
          icon: Icons.check_circle,
          color: const Color(0xFF2E7D32),
          title: 'Do — extend the system menu',
          body: 'Inside an EditableTextContextMenuBuilder, append your own '
              'TextSelectionToolbarTextButton entries to the buttonItems list '
              'so they pick up the same padding/typography as the built-in '
              'actions.',
        ),
        const SizedBox(height: 10),
        _guidanceCard(
          icon: Icons.check_circle,
          color: const Color(0xFF388E3C),
          title: 'Do — use getPadding for parity',
          body: 'When you instantiate buttons manually, always compute padding '
              'with TextSelectionToolbarTextButton.getPadding(index, total). '
              'Hand-tuned padding will drift from the platform defaults.',
        ),
        const SizedBox(height: 10),
        _guidanceCard(
          icon: Icons.check_circle,
          color: const Color(0xFF43A047),
          title: 'Do — keep the child a Text',
          body: 'Stick to a Text or a small Row(<Icon, Text>) child. The '
              'native menu does not support arbitrary widgets and your label '
              'should remain comparable in size to the others.',
        ),
        const SizedBox(height: 10),
        _guidanceCard(
          icon: Icons.cancel,
          color: const Color(0xFFC62828),
          title: 'Don\'t — wrap in another button',
          body: 'TextSelectionToolbarTextButton already builds a TextButton. '
              'Wrapping it in InkWell, GestureDetector, or another button '
              'will create overlapping hit regions and confuse Material\'s '
              'overlay handling.',
        ),
        const SizedBox(height: 10),
        _guidanceCard(
          icon: Icons.cancel,
          color: const Color(0xFFD32F2F),
          title: 'Don\'t — paint your own background',
          body: 'The transparent background is intentional: the toolbar '
              'paints the surface color underneath. Setting a backgroundColor '
              'on a wrapping Container will produce inconsistent visuals when '
              'themes flip between light and dark.',
        ),
        const SizedBox(height: 10),
        _guidanceCard(
          icon: Icons.cancel,
          color: const Color(0xFFE53935),
          title: 'Don\'t — set a tiny tap target',
          body: 'Don\'t shrink minimumSize below kMinInteractiveDimension. '
              'Use copyWith only for child / onPressed / padding / alignment.',
        ),
        const SizedBox(height: 14),
        _quickReference(),
      ],
    ),
  );
}

Widget _guidanceCard({
  required IconData icon,
  required Color color,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.3)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.12),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF424242),
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

Widget _quickReference() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1B5E20), Color(0xFF2E7D32)],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x551B5E20),
          blurRadius: 14,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: Colors.white, size: 18),
            SizedBox(width: 6),
            Text(
              'Quick reference',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'final List<Widget> buttons = <Widget>[\n'
          '  TextSelectionToolbarTextButton(\n'
          '    padding: TextSelectionToolbarTextButton.getPadding(0, 3),\n'
          '    onPressed: () => editor.cutSelection(SelectionChangedCause.toolbar),\n'
          '    child: const Text("Cut"),\n'
          '  ),\n'
          '  TextSelectionToolbarTextButton(\n'
          '    padding: TextSelectionToolbarTextButton.getPadding(1, 3),\n'
          '    onPressed: () => editor.copySelection(SelectionChangedCause.toolbar),\n'
          '    child: const Text("Copy"),\n'
          '  ),\n'
          '  TextSelectionToolbarTextButton(\n'
          '    padding: TextSelectionToolbarTextButton.getPadding(2, 3),\n'
          '    onPressed: () => editor.pasteText(SelectionChangedCause.toolbar),\n'
          '    child: const Text("Paste"),\n'
          '  ),\n'
          '];',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            height: 1.45,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------
Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[Color(0xFF3E2723), Color(0xFF5D4037)],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x553E2723),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: const Row(
      children: <Widget>[
        Icon(Icons.text_fields, color: Color(0xFFFFE0B2), size: 22),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'TextSelectionToolbarTextButton — the small but essential atom of '
            'the Material text-selection menu. Light, themed, and padding-aware.',
            style: TextStyle(
              color: Color(0xFFFFE0B2),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared section shell
// ---------------------------------------------------------------------------
Widget _sectionShell({
  required String title,
  required String subtitle,
  required Color accent,
  required Widget body,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: accent.withOpacity(0.18), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.16),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
        const BoxShadow(
          color: Color(0x10000000),
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6,
              height: 28,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[accent, accent.withOpacity(0.6)],
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: accent,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF6D4C41),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        body,
      ],
    ),
  );
}

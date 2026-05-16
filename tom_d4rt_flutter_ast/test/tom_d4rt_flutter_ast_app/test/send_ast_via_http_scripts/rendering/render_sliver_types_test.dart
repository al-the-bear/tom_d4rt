// ignore_for_file: avoid_print, unused_local_variable
import 'package:flutter/material.dart';

// ============================================================================
// SLIVER TYPES - DEEP VISUAL DEMO
// ----------------------------------------------------------------------------
// This script renders an instructive page that walks the reader through the
// principal sliver widgets available in Flutter's Material/Cupertino layers.
// Each section embeds a small, finite-height CustomScrollView so the behaviour
// of that particular sliver can be observed in isolation, with surrounding
// captions and diagrams that explain what to look for.
//
// The script is intentionally written as a flat collection of top-level
// helper functions so it can be executed by the analyzer-free D4rt Flutter
// interpreter without needing StatelessWidget/StatefulWidget subclasses.
// ============================================================================

const Color _kPageBackground = Color(0xFFEFF2F7);
const Color _kPanelBackground = Color(0xFFFFFFFF);
const Color _kBorderColor = Color(0xFFD6DBE3);
const Color _kAccentColor = Color(0xFF1F6FEB);
const Color _kAccentDeep = Color(0xFF0A3D91);
const Color _kAccentLight = Color(0xFFDCE9FF);
const Color _kSuccessColor = Color(0xFF2E7D32);
const Color _kWarningColor = Color(0xFFEF6C00);
const Color _kCautionColor = Color(0xFFC62828);
const Color _kMutedText = Color(0xFF55606E);
const Color _kStrongText = Color(0xFF1A1F26);

const TextStyle _kHeroTitleStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w800,
  color: Colors.white,
  letterSpacing: 0.3,
);

const TextStyle _kHeroSubtitleStyle = TextStyle(
  fontSize: 15,
  color: Color(0xFFE0EBFF),
  height: 1.35,
);

const TextStyle _kSectionTitleStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: _kStrongText,
);

const TextStyle _kSectionLeadStyle = TextStyle(
  fontSize: 14,
  color: _kMutedText,
  height: 1.45,
);

const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 12.5,
  color: _kMutedText,
  height: 1.4,
);

const TextStyle _kCalloutTitleStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: _kStrongText,
);

const TextStyle _kCalloutBodyStyle = TextStyle(
  fontSize: 13,
  color: _kStrongText,
  height: 1.4,
);

const TextStyle _kCellTitleStyle = TextStyle(
  fontSize: 13.5,
  fontWeight: FontWeight.w600,
  color: _kStrongText,
);

const TextStyle _kCellSubtitleStyle = TextStyle(
  fontSize: 12,
  color: _kMutedText,
);

const TextStyle _kTableHeaderStyle = TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  letterSpacing: 0.3,
);

const TextStyle _kTableCellStyle = TextStyle(
  fontSize: 12.5,
  color: _kStrongText,
  height: 1.35,
);

const TextStyle _kGlossaryTermStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w700,
  color: _kAccentDeep,
);

const TextStyle _kGlossaryDefStyle = TextStyle(
  fontSize: 12.5,
  color: _kStrongText,
  height: 1.4,
);

// ============================================================================
// BUILD ENTRY
// ============================================================================
dynamic build(BuildContext context) {
  print('[render_sliver_types_test] build() starting');
  final Widget page = MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Sliver Types Deep Demo',
    theme: ThemeData(
      primaryColor: _kAccentColor,
      scaffoldBackgroundColor: _kPageBackground,
      colorScheme: const ColorScheme.light(
        primary: _kAccentColor,
        secondary: _kAccentDeep,
        surface: _kPanelBackground,
      ),
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: _kPageBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeroHeader(),
              const SizedBox(height: 28),
              _buildConceptSection(),
              const SizedBox(height: 28),
              _buildToBoxAdapterSection(),
              const SizedBox(height: 28),
              _buildSliverListSection(),
              const SizedBox(height: 28),
              _buildFixedExtentListSection(),
              const SizedBox(height: 28),
              _buildPrototypeExtentListSection(),
              const SizedBox(height: 28),
              _buildSliverGridSection(),
              const SizedBox(height: 28),
              _buildSliverPaddingSection(),
              const SizedBox(height: 28),
              _buildSliverFillRemainingSection(),
              const SizedBox(height: 28),
              _buildPseudoPersistentHeaderSection(),
              const SizedBox(height: 28),
              _buildSliverAppBarSection(),
              const SizedBox(height: 28),
              _buildComparisonTableSection(),
              const SizedBox(height: 28),
              _buildGlossarySection(),
              const SizedBox(height: 28),
              _buildEpilogueSection(),
            ],
          ),
        ),
      ),
    ),
  );
  print('[render_sliver_types_test] build() returning widget tree');
  return page;
}

// ============================================================================
// SECTION 1 - HERO HEADER
// ============================================================================
Widget _buildHeroHeader() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kAccentDeep, _kAccentColor],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x331F6FEB),
          blurRadius: 16,
          offset: Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _heroChip('CHAPTER 14'),
                  const SizedBox(height: 12),
                  const Text(
                    'Sliver Types Deep Dive',
                    style: _kHeroTitleStyle,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A guided tour of the sliver protocol and the principal '
                    'sliver widgets available in Flutter\'s Material layer.',
                    style: _kHeroSubtitleStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            _heroIllustration(),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          children: <Widget>[
            _heroMetric('11', 'sections'),
            const SizedBox(width: 14),
            _heroMetric('9', 'sliver types'),
            const SizedBox(width: 14),
            _heroMetric('15', 'glossary rows'),
            const SizedBox(width: 14),
            _heroMetric('0', 'state classes'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
    ),
  );
}

Widget _heroIllustration() {
  return Container(
    width: 110,
    height: 110,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _illustrationBar(width: 80, color: const Color(0xFF8DB6FF)),
        const SizedBox(height: 5),
        _illustrationBar(width: 70, color: const Color(0xFFB8D1FF)),
        const SizedBox(height: 5),
        _illustrationBar(width: 84, color: const Color(0xFF8DB6FF)),
        const SizedBox(height: 5),
        _illustrationBar(width: 60, color: const Color(0xFFE5EEFF)),
        const SizedBox(height: 5),
        _illustrationBar(width: 80, color: const Color(0xFFB8D1FF)),
      ],
    ),
  );
}

Widget _illustrationBar({required double width, required Color color}) {
  return Container(
    width: width,
    height: 12,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

Widget _heroMetric(String value, String label) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFFE0EBFF),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// REUSABLE PANEL CHROME
// ============================================================================
Widget _sectionPanel({
  required String sectionNumber,
  required String title,
  required String lead,
  required List<Widget> children,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _kPanelBackground,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kBorderColor),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _kAccentLight,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                sectionNumber,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: _kAccentDeep,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: _kSectionTitleStyle),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(lead, style: _kSectionLeadStyle),
        const SizedBox(height: 18),
        ...children,
      ],
    ),
  );
}

Widget _callout({
  required Color borderColor,
  required Color background,
  required String title,
  required String body,
  IconData? icon,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: borderColor, width: 4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon ?? Icons.info_outline, size: 18, color: borderColor),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kCalloutTitleStyle),
              const SizedBox(height: 4),
              Text(body, style: _kCalloutBodyStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _demoFrame({required String caption, required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF7F9FC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kBorderColor),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.play_circle_fill,
                size: 16, color: _kAccentColor),
            const SizedBox(width: 6),
            Expanded(
              child: Text(caption, style: _kCaptionStyle),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 - CONCEPT OF A SLIVER
// ============================================================================
Widget _buildConceptSection() {
  return _sectionPanel(
    sectionNumber: '02',
    title: 'What is a sliver?',
    lead: 'A sliver is a portion of a scrollable area. While ordinary widgets '
        'measure themselves with BoxConstraints (width and height ranges), '
        'slivers measure themselves with SliverConstraints (scrollOffset, '
        'remainingPaintExtent, axisDirection and friends). A CustomScrollView '
        'orchestrates a list of slivers along a single axis to form a unified '
        'scrolling viewport.',
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: _conceptDiagram()),
          const SizedBox(width: 16),
          Expanded(child: _conceptBullets()),
        ],
      ),
      const SizedBox(height: 16),
      _callout(
        borderColor: _kAccentColor,
        background: _kAccentLight,
        icon: Icons.lightbulb_outline,
        title: 'Rule of thumb',
        body: 'If a child of CustomScrollView is a regular box widget, wrap it '
            'in SliverToBoxAdapter. If a child already implements the sliver '
            'protocol, add it directly.',
      ),
    ],
  );
}

Widget _conceptDiagram() {
  return Container(
    height: 240,
    decoration: BoxDecoration(
      color: const Color(0xFFF1F4F9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kBorderColor),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _diagramLabel('Viewport'),
        const SizedBox(height: 6),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kBorderColor),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _diagramSliver('SliverAppBar', _kAccentColor),
                const SizedBox(height: 4),
                _diagramSliver('SliverList', const Color(0xFF66BB6A)),
                const SizedBox(height: 4),
                _diagramSliver('SliverGrid', const Color(0xFFFFA726)),
                const SizedBox(height: 4),
                _diagramSliver('SliverFillRemaining',
                    const Color(0xFF8E24AA)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _diagramLabel(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: _kMutedText,
      letterSpacing: 0.8,
    ),
  );
}

Widget _diagramSliver(String label, Color color) {
  return Expanded(
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: HSLColor.fromColor(color).withLightness(0.30).toColor(),
        ),
      ),
    ),
  );
}

Widget _conceptBullets() {
  final List<List<String>> rows = <List<String>>[
    <String>['scrollOffset', 'How far past this sliver the user has scrolled'],
    <String>['remainingPaintExtent', 'Pixels left of the viewport to paint'],
    <String>['axisDirection', 'Direction of scroll growth (down/right/up/left)'],
    <String>['crossAxisExtent', 'Width when scrolling vertically'],
    <String>['overlap', 'Pixels obscured by a previous pinned sliver'],
  ];
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F9FC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kBorderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Key SliverConstraints fields',
            style: _kCalloutTitleStyle),
        const SizedBox(height: 8),
        for (final List<String> row in rows) _conceptRow(row[0], row[1]),
      ],
    ),
  );
}

Widget _conceptRow(String name, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6, right: 8),
          decoration: const BoxDecoration(
            color: _kAccentColor,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: _kCalloutBodyStyle,
              children: <InlineSpan>[
                TextSpan(
                  text: name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _kAccentDeep,
                    fontFamily: 'monospace',
                  ),
                ),
                const TextSpan(text: ' — '),
                TextSpan(text: description),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 - SliverToBoxAdapter
// ============================================================================
Widget _buildToBoxAdapterSection() {
  return _sectionPanel(
    sectionNumber: '03',
    title: 'SliverToBoxAdapter',
    lead: 'The simplest sliver. It takes a single box widget and exposes it '
        'to the sliver protocol with its natural intrinsic height. Use it '
        'whenever a header, footer, banner, or one-off widget needs to sit '
        'inside a CustomScrollView alongside other slivers.',
    children: <Widget>[
      _demoFrame(
        caption: 'Below: three SliverToBoxAdapter widgets inside a '
            'CustomScrollView of finite height. Scroll inside the panel.',
        child: SizedBox(
          height: 240,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(child: _adapterTile('Banner', _kAccentColor)),
              SliverToBoxAdapter(
                child: _adapterTile('Callout', const Color(0xFF66BB6A)),
              ),
              SliverToBoxAdapter(
                child: _adapterTile('Footer', const Color(0xFFFFA726)),
              ),
              SliverToBoxAdapter(
                child: _adapterTile('Decoration', const Color(0xFF8E24AA)),
              ),
              SliverToBoxAdapter(
                child: _adapterTile('Closing', const Color(0xFF26A69A)),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 14),
      _callout(
        borderColor: _kWarningColor,
        background: const Color(0xFFFFF4E5),
        icon: Icons.warning_amber_rounded,
        title: 'Performance note',
        body: 'SliverToBoxAdapter builds its child eagerly. For long lists '
            'use SliverList or SliverFixedExtentList, which build children '
            'lazily as they enter the viewport.',
      ),
    ],
  );
}

Widget _adapterTile(String label, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.crop_din,
              size: 18, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: _kCellTitleStyle),
              const SizedBox(height: 2),
              const Text('SliverToBoxAdapter child',
                  style: _kCellSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4 - SliverList
// ============================================================================
Widget _buildSliverListSection() {
  return _sectionPanel(
    sectionNumber: '04',
    title: 'SliverList',
    lead: 'SliverList builds variable-extent children lazily via a '
        'SliverChildBuilderDelegate. Each child is measured individually, so '
        'rows may have different heights. This is the default workhorse for '
        'most scrollable lists embedded in CustomScrollView.',
    children: <Widget>[
      _demoFrame(
        caption: 'Below: ten variable-height rows produced by a builder '
            'callback. Notice every row has different padding.',
        child: SizedBox(
          height: 260,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _variableRow(index);
                  },
                  childCount: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 14),
      _callout(
        borderColor: _kSuccessColor,
        background: const Color(0xFFE7F4E8),
        icon: Icons.check_circle_outline,
        title: 'When to choose SliverList',
        body: 'Rows of mixed heights, content-driven sizing, or expensive '
            'children that benefit from lazy construction.',
      ),
    ],
  );
}

Widget _variableRow(int index) {
  final List<String> titles = <String>[
    'Onboarding step',
    'Profile field',
    'Notification preference',
    'Recent activity',
    'Saved location',
    'Drafted message',
    'Pinned conversation',
    'Quick note',
    'Calendar entry',
    'Task reminder',
    'Bookmark',
    'Recent file',
  ];
  final List<int> heights = <int>[64, 84, 56, 92, 72, 80, 60, 100, 70, 88, 62, 96];
  final int paletteIndex = index % titles.length;
  final String title = titles[paletteIndex];
  final int height = heights[paletteIndex];
  final Color tint = HSLColor.fromAHSL(
    1.0,
    (paletteIndex * 31) % 360.0,
    0.45,
    0.78,
  ).toColor();
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
    height: height.toDouble(),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kBorderColor),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text('${index + 1}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _kStrongText,
              )),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kCellTitleStyle),
              Text('height = ${height}px', style: _kCellSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5 - SliverFixedExtentList
// ============================================================================
Widget _buildFixedExtentListSection() {
  return _sectionPanel(
    sectionNumber: '05',
    title: 'SliverFixedExtentList',
    lead: 'When every child has the same main-axis extent, SliverFixedExtentList '
        'skips the per-child layout pass and computes positions arithmetically. '
        'It is dramatically cheaper than SliverList for long uniform lists.',
    children: <Widget>[
      _demoFrame(
        caption: 'Below: itemExtent = 60 px. Each row paints with the same '
            'arithmetically-computed offset.',
        child: SizedBox(
          height: 240,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFixedExtentList(
                itemExtent: 60,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      _fixedExtentRow(index),
                  childCount: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 14),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _callout(
              borderColor: _kAccentColor,
              background: _kAccentLight,
              icon: Icons.speed,
              title: 'Performance',
              body: 'Layout cost is O(1) per child instead of O(layout). '
                  'Prefer this sliver for telephone directories, settings '
                  'rows, or message previews.',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _callout(
              borderColor: _kCautionColor,
              background: const Color(0xFFFEEBEE),
              icon: Icons.report_gmailerrorred,
              title: 'Watch out',
              body: 'If a child exceeds itemExtent, content will be clipped. '
                  'Use SliverList instead when sizes vary.',
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _fixedExtentRow(int index) {
  final Color tint = HSLColor.fromAHSL(
    1.0,
    (index * 21) % 360.0,
    0.55,
    0.62,
  ).toColor();
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.15),
      border: Border.all(color: tint),
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: <Widget>[
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text('Fixed extent row #${index + 1}',
              style: _kCellTitleStyle),
        ),
        const Icon(Icons.chevron_right, color: _kMutedText),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6 - SliverPrototypeExtentList
// ============================================================================
Widget _buildPrototypeExtentListSection() {
  return _sectionPanel(
    sectionNumber: '06',
    title: 'SliverPrototypeExtentList',
    lead: 'A close relative of SliverFixedExtentList. Instead of providing a '
        'numeric itemExtent, you provide a prototype widget; the sliver '
        'measures its intrinsic height and uses that value as the extent for '
        'every child. Handy when the row size is data-driven.',
    children: <Widget>[
      _demoFrame(
        caption: 'Below: prototype is a single ListTile-like row. All '
            'children take the prototype\'s measured height.',
        child: SizedBox(
          height: 240,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPrototypeExtentList(
                prototypeItem: _prototypeItem(),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      _prototypeRow(index),
                  childCount: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 14),
      _callout(
        borderColor: _kAccentColor,
        background: _kAccentLight,
        icon: Icons.straighten,
        title: 'How it works',
        body: 'The prototype is laid out once during the first frame; its '
            'measured extent is cached and applied to every child until the '
            'prototype changes.',
      ),
    ],
  );
}

Widget _prototypeItem() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    child: Row(
      children: const <Widget>[
        Icon(Icons.account_circle, size: 28, color: _kAccentColor),
        SizedBox(width: 10),
        Expanded(child: Text('Prototype row', style: _kCellTitleStyle)),
      ],
    ),
  );
}

Widget _prototypeRow(int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F4F9),
      border: Border.all(color: _kBorderColor),
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: <Widget>[
        const Icon(Icons.person_outline, color: _kAccentColor),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Prototype-extent row #${index + 1}',
                  style: _kCellTitleStyle),
              const Text('Height taken from prototypeItem',
                  style: _kCellSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7 - SliverGrid
// ============================================================================
Widget _buildSliverGridSection() {
  return _sectionPanel(
    sectionNumber: '07',
    title: 'SliverGrid',
    lead: 'SliverGrid arranges children into a two-dimensional grid via a '
        'SliverGridDelegate. The two most common delegates are '
        'SliverGridDelegateWithFixedCrossAxisCount (fixed column count) and '
        'SliverGridDelegateWithMaxCrossAxisExtent (responsive column count).',
    children: <Widget>[
      _demoFrame(
        caption: 'Fixed cross-axis count = 3.',
        child: SizedBox(
          height: 240,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.4,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      _gridTile(index, label: 'Fixed'),
                  childCount: 15,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 14),
      _demoFrame(
        caption: 'Max cross-axis extent = 120 px. Columns reflow to fit.',
        child: SizedBox(
          height: 240,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 120,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      _gridTile(index, label: 'Max'),
                  childCount: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _gridTile(int index, {required String label}) {
  final Color color = HSLColor.fromAHSL(
    1.0,
    (index * 47) % 360.0,
    0.55,
    0.65,
  ).toColor();
  return Container(
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text('${index + 1}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              )),
        ),
        const SizedBox(height: 4),
        Text(label, style: _kCellSubtitleStyle),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8 - SliverPadding
// ============================================================================
Widget _buildSliverPaddingSection() {
  return _sectionPanel(
    sectionNumber: '08',
    title: 'SliverPadding',
    lead: 'SliverPadding wraps another sliver in EdgeInsets so the inner '
        'sliver gets pushed inward without breaking the sliver protocol. '
        'Use it instead of wrapping with Padding, which would coerce the '
        'inner sliver back into a box.',
    children: <Widget>[
      _demoFrame(
        caption: 'Below: inner SliverList wrapped in 24 px of padding.',
        child: SizedBox(
          height: 220,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) =>
                        _paddingRow(index),
                    childCount: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 14),
      _callout(
        borderColor: _kAccentColor,
        background: _kAccentLight,
        icon: Icons.format_indent_increase,
        title: 'Tip',
        body: 'EdgeInsets are interpreted in the sliver\'s cross-axis and '
            'main-axis directions, so swapping axisDirection automatically '
            'remaps left/right/top/bottom.',
      ),
    ],
  );
}

Widget _paddingRow(int index) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFF90CAF9)),
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.padding, color: _kAccentColor, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text('Padded row #${index + 1}', style: _kCellTitleStyle),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9 - SliverFillRemaining
// ============================================================================
Widget _buildSliverFillRemainingSection() {
  return _sectionPanel(
    sectionNumber: '09',
    title: 'SliverFillRemaining',
    lead: 'SliverFillRemaining expands to fill whatever vertical space is '
        'left in the viewport after preceding slivers have been laid out. '
        'It is most often used for empty states or trailing call-to-action '
        'screens that should occupy the rest of the page.',
    children: <Widget>[
      _demoFrame(
        caption: 'Below: a small header sliver followed by SliverFillRemaining '
            'that paints a centred empty-state card.',
        child: SizedBox(
          height: 240,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF9FA8DA)),
                  ),
                  child: const Text(
                    'Inbox is empty',
                    style: _kCellTitleStyle,
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFFE082)),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(Icons.inbox, size: 36, color: _kWarningColor),
                      SizedBox(height: 8),
                      Text('Nothing here yet',
                          style: _kCalloutTitleStyle),
                      SizedBox(height: 4),
                      Text('Pull-to-refresh to check again.',
                          style: _kCellSubtitleStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 14),
      _callout(
        borderColor: _kSuccessColor,
        background: const Color(0xFFE7F4E8),
        icon: Icons.fit_screen,
        title: 'hasScrollBody flag',
        body: 'Pass hasScrollBody:false when the child does not itself scroll '
            '(typical for empty states). The default true is for embedding a '
            'nested scrollable.',
      ),
    ],
  );
}

// ============================================================================
// SECTION 10 - Pseudo persistent header (no subclass)
// ============================================================================
Widget _buildPseudoPersistentHeaderSection() {
  return _sectionPanel(
    sectionNumber: '10',
    title: 'Pseudo-persistent header pattern',
    lead: 'SliverPersistentHeader takes a SliverPersistentHeaderDelegate, '
        'which is abstract and would force a subclass. To stay subclass-free '
        'and analyzer-clean, this demo illustrates the concept with a '
        'SliverToBoxAdapter that paints a fake "header" and shows how a real '
        'one would behave when pinned or floating.',
    children: <Widget>[
      _demoFrame(
        caption: 'Below: a static visual stand-in for what a pinned '
            'persistent header looks like on screen.',
        child: SizedBox(
          height: 240,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(child: _fakeHeader()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _paddingRow(index);
                  },
                  childCount: 6,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 14),
      _callout(
        borderColor: _kWarningColor,
        background: const Color(0xFFFFF4E5),
        icon: Icons.info_outline,
        title: 'Real persistent headers',
        body: 'In production, override minExtent/maxExtent/build/shouldRebuild '
            'on a SliverPersistentHeaderDelegate. The pinned variant stays '
            'glued to the top; the floating variant returns when the user '
            'scrolls back.',
      ),
    ],
  );
}

Widget _fakeHeader() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    height: 64,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[_kAccentDeep, _kAccentColor],
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Row(
      children: const <Widget>[
        Icon(Icons.push_pin, color: Colors.white),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'Pinned header (visual stand-in)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 11 - SliverAppBar
// ============================================================================
Widget _buildSliverAppBarSection() {
  return _sectionPanel(
    sectionNumber: '11',
    title: 'SliverAppBar',
    lead: 'SliverAppBar is a concrete persistent header tailored for app bars. '
        'It supports pinned, floating, snap, and expanded modes plus a '
        'FlexibleSpaceBar for a hero background that collapses on scroll.',
    children: <Widget>[
      _demoFrame(
        caption: 'pinned: true, expandedHeight: 140, with FlexibleSpaceBar.',
        child: SizedBox(
          height: 240,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                floating: false,
                snap: false,
                expandedHeight: 140,
                backgroundColor: _kAccentColor,
                title: const Text('Pinned'),
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('Pinned + expanded',
                      style: TextStyle(fontSize: 13)),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[_kAccentDeep, _kAccentColor],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      _appBarRow(index, 'pinned'),
                  childCount: 6,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      _demoFrame(
        caption: 'floating: true, snap: true. The bar returns when you '
            'reverse scroll direction.',
        child: SizedBox(
          height: 240,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: false,
                floating: true,
                snap: true,
                backgroundColor: _kSuccessColor,
                title: const Text('Floating + snap'),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      _appBarRow(index, 'floating'),
                  childCount: 8,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      _demoFrame(
        caption: 'pinned: true with bottom: PreferredSize for a tab-like row.',
        child: SizedBox(
          height: 240,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: _kWarningColor,
                title: const Text('With bottom'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(36),
                  child: Container(
                    color: _kWarningColor.withValues(alpha: 0.85),
                    height: 36,
                    alignment: Alignment.center,
                    child: const Text(
                      'Tabs / filters / breadcrumbs',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      _appBarRow(index, 'bottom'),
                  childCount: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _appBarRow(int index, String tag) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F9FC),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kBorderColor),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: _kAccentLight,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text('${index + 1}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: _kAccentDeep,
                fontSize: 12,
              )),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$tag row ${index + 1}', style: _kCellTitleStyle),
              const Text('Scroll to observe the app bar response',
                  style: _kCellSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 12 - Comparison table
// ============================================================================
Widget _buildComparisonTableSection() {
  final List<List<String>> rows = <List<String>>[
    <String>['SliverToBoxAdapter', 'Single box widget', 'Banners, footers'],
    <String>['SliverList', 'Variable-extent children', 'Mixed content lists'],
    <String>['SliverFixedExtentList', 'Uniform height', 'Long uniform lists'],
    <String>['SliverPrototypeExtentList', 'Data-driven height', 'Prototype-based rows'],
    <String>['SliverGrid', '2D grid', 'Galleries, dashboards'],
    <String>['SliverPadding', 'Wraps a sliver in insets', 'Inner margin'],
    <String>['SliverFillRemaining', 'Fills remaining viewport', 'Empty states'],
    <String>['SliverPersistentHeader', 'Pinned/floating header', 'Tab strips'],
    <String>['SliverAppBar', 'App bar persistent header', 'Top app bar'],
    <String>['SliverAnimatedList', 'Animated list', 'Inserts/removes'],
  ];
  return _sectionPanel(
    sectionNumber: '12',
    title: 'Comparison table',
    lead: 'A side-by-side reference of the sliver widgets covered in this '
        'document, with their primary purpose and a typical use case.',
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kBorderColor),
          color: const Color(0xFFFAFBFC),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            _tableHeader(),
            for (int i = 0; i < rows.length; i++)
              _tableRow(rows[i], even: i.isEven),
          ],
        ),
      ),
      const SizedBox(height: 14),
      _callout(
        borderColor: _kAccentColor,
        background: _kAccentLight,
        icon: Icons.menu_book,
        title: 'Choosing a sliver',
        body: 'Start from the most specific sliver that satisfies your needs '
            '— fixed extent if heights are uniform, prototype extent if they '
            'are data-driven, otherwise SliverList.',
      ),
    ],
  );
}

Widget _tableHeader() {
  return Container(
    color: _kAccentDeep,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: const <Widget>[
        Expanded(
          flex: 3,
          child: Text('Sliver', style: _kTableHeaderStyle),
        ),
        Expanded(
          flex: 3,
          child: Text('Purpose', style: _kTableHeaderStyle),
        ),
        Expanded(
          flex: 3,
          child: Text('Typical use', style: _kTableHeaderStyle),
        ),
      ],
    ),
  );
}

Widget _tableRow(List<String> cells, {required bool even}) {
  return Container(
    color: even ? Colors.white : const Color(0xFFF1F4F9),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            cells[0],
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: _kAccentDeep,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(flex: 3, child: Text(cells[1], style: _kTableCellStyle)),
        Expanded(flex: 3, child: Text(cells[2], style: _kTableCellStyle)),
      ],
    ),
  );
}

// ============================================================================
// SECTION 13 - Glossary
// ============================================================================
Widget _buildGlossarySection() {
  final List<List<String>> entries = <List<String>>[
    <String>['Sliver', 'A piece of a scrollable area that obeys the sliver '
        'protocol (SliverConstraints + SliverGeometry).'],
    <String>['Viewport', 'The widget that hosts a list of slivers and '
        'orchestrates their painting and hit-testing.'],
    <String>['SliverConstraints', 'The constraints handed to a sliver during '
        'layout — scrollOffset, remainingPaintExtent, axisDirection, etc.'],
    <String>['SliverGeometry', 'A sliver\'s reply to layout: paintExtent, '
        'scrollExtent, maxPaintExtent, layoutExtent, and visible.'],
    <String>['scrollOffset', 'How many logical pixels of this sliver have '
        'already been scrolled out of the viewport.'],
    <String>['paintExtent', 'The number of pixels this sliver will paint '
        'inside the viewport along the main axis.'],
    <String>['layoutExtent', 'The portion of paintExtent that is visible '
        '(unobscured by pinned siblings).'],
    <String>['maxPaintExtent', 'The greatest paintExtent the sliver could '
        'ever request; used to compute scroll metrics.'],
    <String>['Delegate', 'A small object that supplies children to a sliver '
        '(SliverChildBuilderDelegate, SliverChildListDelegate, etc.).'],
    <String>['Builder delegate', 'A delegate that constructs children '
        'lazily via an itemBuilder callback.'],
    <String>['List delegate', 'A delegate that takes a finite list of '
        'pre-built children, used for short lists.'],
    <String>['itemExtent', 'The exact main-axis extent of every child in a '
        'SliverFixedExtentList.'],
    <String>['prototypeItem', 'A widget used by SliverPrototypeExtentList '
        'to derive the per-child extent.'],
    <String>['Pinned', 'A persistent header mode where the header remains '
        'glued to the leading edge of the viewport.'],
    <String>['Floating', 'A persistent header mode where the header '
        'reappears as soon as the user reverses scroll direction.'],
  ];
  return _sectionPanel(
    sectionNumber: '13',
    title: 'Glossary',
    lead: 'Fifteen terms drawn from this chapter, for quick reference.',
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFBFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kBorderColor),
        ),
        child: Column(
          children: <Widget>[
            for (int i = 0; i < entries.length; i++)
              _glossaryRow(entries[i][0], entries[i][1], divider: i < entries.length - 1),
          ],
        ),
      ),
    ],
  );
}

Widget _glossaryRow(String term, String def, {required bool divider}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 130,
              child: Text(term, style: _kGlossaryTermStyle),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(def, style: _kGlossaryDefStyle)),
          ],
        ),
      ),
      if (divider)
        const Divider(height: 1, thickness: 1, color: Color(0xFFEDEFF3)),
    ],
  );
}

// ============================================================================
// SECTION 14 - Epilogue
// ============================================================================
Widget _buildEpilogueSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _kAccentDeep,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.book_outlined, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'End of chapter',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'You have now seen every sliver that comes by default in the '
          'Material library, the way they interact with the viewport, and '
          'guidelines for choosing between them. In the next chapter we '
          'will look at custom scroll effects: pull-to-refresh, sliver '
          'overlap absorption, and orchestrating nested scroll views.',
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xFFE0EBFF),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            _epilogueChip(Icons.school_outlined, 'Concepts'),
            const SizedBox(width: 8),
            _epilogueChip(Icons.view_list, 'Slivers'),
            const SizedBox(width: 8),
            _epilogueChip(Icons.grid_view, 'Grids'),
            const SizedBox(width: 8),
            _epilogueChip(Icons.layers, 'Headers'),
          ],
        ),
      ],
    ),
  );
}

Widget _epilogueChip(IconData icon, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

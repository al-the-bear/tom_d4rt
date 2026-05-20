// D4rt test script: Deep Demo - Wrap Widget Visual Gallery
// Comprehensive demonstration of Wrap layout configurations, alignments,
// directions, spacing, and real-world flowing layouts (chips, tags,
// galleries, swatches, badge grids, keyword clouds).
import 'dart:math' as math;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SHARED PALETTES, SEEDS, AND HELPER DATA
  // ============================================================================

  const Color bgSlate = Color(0xFF0F172A);
  const Color bgSlateSoft = Color(0xFF1E293B);
  const Color bgSlateMuted = Color(0xFF334155);
  const Color cardSurface = Color(0xFF1F2937);
  const Color cardSurfaceLight = Color(0xFFF8FAFC);
  const Color borderSoft = Color(0xFF334155);
  const Color borderAccent = Color(0xFF38BDF8);
  const Color textPrimary = Color(0xFFE2E8F0);
  const Color textSecondary = Color(0xFF94A3B8);
  const Color textInk = Color(0xFF0F172A);
  const Color hint = Color(0xFF64748B);

  const List<Color> spectrum = <Color>[
    Color(0xFFEF4444),
    Color(0xFFF97316),
    Color(0xFFF59E0B),
    Color(0xFFEAB308),
    Color(0xFF84CC16),
    Color(0xFF22C55E),
    Color(0xFF10B981),
    Color(0xFF14B8A6),
    Color(0xFF06B6D4),
    Color(0xFF0EA5E9),
    Color(0xFF3B82F6),
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
    Color(0xFFA855F7),
    Color(0xFFD946EF),
    Color(0xFFEC4899),
    Color(0xFFF43F5E),
  ];

  const List<String> programmingTags = <String>[
    'Dart',
    'Flutter',
    'D4rt',
    'AST',
    'Widgets',
    'Layout',
    'Render',
    'Paint',
    'Compose',
    'Reactive',
    'State',
    'Stream',
    'Future',
    'Isolate',
    'FFI',
    'JIT',
    'AOT',
    'GC',
    'VM',
    'SDK',
  ];

  const List<String> moodTags = <String>[
    'calm',
    'focus',
    'flow',
    'spark',
    'craft',
    'depth',
    'vivid',
    'lucid',
    'tender',
    'bold',
    'crisp',
    'soft',
    'gentle',
    'bright',
    'mellow',
    'fierce',
  ];

  const List<String> productKeywords = <String>[
    'wireless',
    'ergonomic',
    'fast-charge',
    'noise-cancelling',
    'hi-res',
    'titanium',
    'matte-black',
    'minimal',
    'open-back',
    'studio',
    'travel',
    'eco-friendly',
    'recycled',
    'lightweight',
    'pro',
  ];

  // ============================================================================
  // SECTION 1: HORIZONTAL DIRECTION WITH DEFAULT START ALIGNMENT
  // ============================================================================

  final List<Widget> startAlignedBoxes = List<Widget>.generate(11, (int index) {
    final Color tint = spectrum[index % spectrum.length];
    final double w = 56.0 + (index % 4) * 14.0;
    return _buildLabelBox(
      label: 'A$index',
      tint: tint,
      width: w,
      height: 44.0,
    );
  });

  final Wrap startWrap = Wrap(
    direction: Axis.horizontal,
    alignment: WrapAlignment.start,
    spacing: 8.0,
    runSpacing: 8.0,
    children: startAlignedBoxes,
  );

  // ============================================================================
  // SECTION 2: HORIZONTAL WITH ALIGNMENT END
  // ============================================================================

  final List<Widget> endAlignedBoxes = List<Widget>.generate(9, (int index) {
    final Color tint = spectrum[(index + 4) % spectrum.length];
    final double w = 60.0 + (index % 3) * 18.0;
    return _buildLabelBox(
      label: 'E$index',
      tint: tint,
      width: w,
      height: 44.0,
    );
  });

  final Wrap endWrap = Wrap(
    direction: Axis.horizontal,
    alignment: WrapAlignment.end,
    spacing: 8.0,
    runSpacing: 8.0,
    children: endAlignedBoxes,
  );

  // ============================================================================
  // SECTION 3: HORIZONTAL WITH ALIGNMENT CENTER
  // ============================================================================

  final List<Widget> centerAlignedBoxes = List<Widget>.generate(7, (int index) {
    final Color tint = spectrum[(index + 8) % spectrum.length];
    final double w = 64.0 + (index % 5) * 10.0;
    return _buildLabelBox(
      label: 'C$index',
      tint: tint,
      width: w,
      height: 44.0,
    );
  });

  final Wrap centerWrap = Wrap(
    direction: Axis.horizontal,
    alignment: WrapAlignment.center,
    spacing: 8.0,
    runSpacing: 8.0,
    children: centerAlignedBoxes,
  );

  // ============================================================================
  // SECTION 4: HORIZONTAL WITH ALIGNMENT SPACEBETWEEN
  // ============================================================================

  final List<Widget> spaceBetweenBoxes = List<Widget>.generate(6, (int index) {
    final Color tint = spectrum[(index + 2) % spectrum.length];
    return _buildLabelBox(
      label: 'SB$index',
      tint: tint,
      width: 68.0,
      height: 44.0,
    );
  });

  final Wrap spaceBetweenWrap = Wrap(
    direction: Axis.horizontal,
    alignment: WrapAlignment.spaceBetween,
    runSpacing: 8.0,
    children: spaceBetweenBoxes,
  );

  // ============================================================================
  // SECTION 5: HORIZONTAL WITH ALIGNMENT SPACEAROUND
  // ============================================================================

  final List<Widget> spaceAroundBoxes = List<Widget>.generate(5, (int index) {
    final Color tint = spectrum[(index + 5) % spectrum.length];
    return _buildLabelBox(
      label: 'SA$index',
      tint: tint,
      width: 72.0,
      height: 44.0,
    );
  });

  final Wrap spaceAroundWrap = Wrap(
    direction: Axis.horizontal,
    alignment: WrapAlignment.spaceAround,
    runSpacing: 8.0,
    children: spaceAroundBoxes,
  );

  // ============================================================================
  // SECTION 6: HORIZONTAL WITH ALIGNMENT SPACEEVENLY
  // ============================================================================

  final List<Widget> spaceEvenlyBoxes = List<Widget>.generate(5, (int index) {
    final Color tint = spectrum[(index + 9) % spectrum.length];
    return _buildLabelBox(
      label: 'SE$index',
      tint: tint,
      width: 72.0,
      height: 44.0,
    );
  });

  final Wrap spaceEvenlyWrap = Wrap(
    direction: Axis.horizontal,
    alignment: WrapAlignment.spaceEvenly,
    runSpacing: 8.0,
    children: spaceEvenlyBoxes,
  );

  // ============================================================================
  // SECTION 7: CROSSAXISALIGNMENT VARIANTS (start / center / end)
  // ============================================================================

  final List<Widget> mixedHeightBoxes = List<Widget>.generate(8, (int index) {
    final Color tint = spectrum[(index * 2) % spectrum.length];
    final double height = 26.0 + ((index * 11) % 5) * 12.0;
    return _buildLabelBox(
      label: 'H$index',
      tint: tint,
      width: 56.0,
      height: height,
    );
  });

  final Wrap crossStartWrap = Wrap(
    direction: Axis.horizontal,
    crossAxisAlignment: WrapCrossAlignment.start,
    spacing: 6.0,
    runSpacing: 6.0,
    children: mixedHeightBoxes,
  );

  final Wrap crossCenterWrap = Wrap(
    direction: Axis.horizontal,
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 6.0,
    runSpacing: 6.0,
    children: mixedHeightBoxes,
  );

  final Wrap crossEndWrap = Wrap(
    direction: Axis.horizontal,
    crossAxisAlignment: WrapCrossAlignment.end,
    spacing: 6.0,
    runSpacing: 6.0,
    children: mixedHeightBoxes,
  );

  // ============================================================================
  // SECTION 8: RUNALIGNMENT VARIANTS (multi-row layouts)
  // ============================================================================

  final List<Widget> denseTiles = List<Widget>.generate(18, (int index) {
    final Color tint = spectrum[(index + 3) % spectrum.length];
    return _buildLabelBox(
      label: 'R$index',
      tint: tint,
      width: 78.0,
      height: 38.0,
    );
  });

  final Wrap runStartWrap = Wrap(
    direction: Axis.horizontal,
    runAlignment: WrapAlignment.start,
    spacing: 6.0,
    runSpacing: 6.0,
    children: denseTiles,
  );

  final Wrap runCenterWrap = Wrap(
    direction: Axis.horizontal,
    runAlignment: WrapAlignment.center,
    spacing: 6.0,
    runSpacing: 14.0,
    children: denseTiles,
  );

  final Wrap runEndWrap = Wrap(
    direction: Axis.horizontal,
    runAlignment: WrapAlignment.end,
    spacing: 6.0,
    runSpacing: 6.0,
    children: denseTiles,
  );

  final Wrap runSpaceBetweenWrap = Wrap(
    direction: Axis.horizontal,
    runAlignment: WrapAlignment.spaceBetween,
    spacing: 6.0,
    runSpacing: 6.0,
    children: denseTiles,
  );

  // ============================================================================
  // SECTION 9: SPACING & RUNSPACING GRADIENTS
  // ============================================================================

  final List<Widget> spacingTinyTiles = List<Widget>.generate(15, (int index) {
    final Color tint = spectrum[(index + 6) % spectrum.length];
    return _buildLabelBox(
      label: 's$index',
      tint: tint,
      width: 50.0,
      height: 32.0,
    );
  });

  final Wrap tightWrap = Wrap(
    spacing: 2.0,
    runSpacing: 2.0,
    children: spacingTinyTiles,
  );

  final Wrap mediumWrap = Wrap(
    spacing: 10.0,
    runSpacing: 10.0,
    children: spacingTinyTiles,
  );

  final Wrap looseWrap = Wrap(
    spacing: 22.0,
    runSpacing: 22.0,
    children: spacingTinyTiles,
  );

  // ============================================================================
  // SECTION 10: VERTICAL DIRECTION
  // ============================================================================

  final List<Widget> verticalTiles = List<Widget>.generate(6, (int index) {
    final Color tint = spectrum[(index + 11) % spectrum.length];
    return _buildLabelBox(
      label: 'V$index',
      tint: tint,
      width: 92.0,
      height: 36.0,
    );
  });

  final Wrap verticalWrapStart = Wrap(
    direction: Axis.vertical,
    alignment: WrapAlignment.start,
    spacing: 6.0,
    runSpacing: 8.0,
    children: verticalTiles,
  );

  final Wrap verticalWrapCenter = Wrap(
    direction: Axis.vertical,
    alignment: WrapAlignment.center,
    spacing: 6.0,
    runSpacing: 8.0,
    children: verticalTiles,
  );

  final Wrap verticalWrapEnd = Wrap(
    direction: Axis.vertical,
    alignment: WrapAlignment.end,
    spacing: 6.0,
    runSpacing: 8.0,
    children: verticalTiles,
  );

  // ============================================================================
  // SECTION 11: TEXT DIRECTION (LTR vs RTL)
  // ============================================================================

  final List<Widget> ltrTiles = List<Widget>.generate(8, (int index) {
    final Color tint = spectrum[(index + 1) % spectrum.length];
    return _buildLabelBox(
      label: 'L$index',
      tint: tint,
      width: 64.0,
      height: 40.0,
    );
  });

  final Wrap ltrWrap = Wrap(
    textDirection: TextDirection.ltr,
    alignment: WrapAlignment.start,
    spacing: 6.0,
    runSpacing: 6.0,
    children: ltrTiles,
  );

  final List<Widget> rtlTiles = List<Widget>.generate(8, (int index) {
    final Color tint = spectrum[(index + 7) % spectrum.length];
    return _buildLabelBox(
      label: 'R$index',
      tint: tint,
      width: 64.0,
      height: 40.0,
    );
  });

  final Wrap rtlWrap = Wrap(
    textDirection: TextDirection.rtl,
    alignment: WrapAlignment.start,
    spacing: 6.0,
    runSpacing: 6.0,
    children: rtlTiles,
  );

  // ============================================================================
  // SECTION 12: VERTICAL DIRECTION (UP vs DOWN)
  // ============================================================================

  final List<Widget> vdTiles = List<Widget>.generate(5, (int index) {
    final Color tint = spectrum[(index + 12) % spectrum.length];
    return _buildLabelBox(
      label: 'D$index',
      tint: tint,
      width: 60.0,
      height: 34.0,
    );
  });

  final Wrap verticalDownWrap = Wrap(
    direction: Axis.vertical,
    verticalDirection: VerticalDirection.down,
    spacing: 6.0,
    runSpacing: 8.0,
    children: vdTiles,
  );

  final Wrap verticalUpWrap = Wrap(
    direction: Axis.vertical,
    verticalDirection: VerticalDirection.up,
    spacing: 6.0,
    runSpacing: 8.0,
    children: vdTiles,
  );

  // ============================================================================
  // SECTION 13: CLIP BEHAVIOR (none / hardEdge / antiAlias)
  // ============================================================================

  final List<Widget> clipTiles = List<Widget>.generate(6, (int index) {
    final Color tint = spectrum[(index + 4) % spectrum.length];
    return _buildLabelBox(
      label: 'K$index',
      tint: tint,
      width: 80.0,
      height: 40.0,
    );
  });

  final Wrap clipNoneWrap = Wrap(
    clipBehavior: Clip.none,
    spacing: 6.0,
    runSpacing: 6.0,
    children: clipTiles,
  );

  final Wrap clipHardWrap = Wrap(
    clipBehavior: Clip.hardEdge,
    spacing: 6.0,
    runSpacing: 6.0,
    children: clipTiles,
  );

  final Wrap clipAntiAliasWrap = Wrap(
    clipBehavior: Clip.antiAlias,
    spacing: 6.0,
    runSpacing: 6.0,
    children: clipTiles,
  );

  // ============================================================================
  // SECTION 14: REAL-WORLD CHIP CLUSTER (programming tags)
  // ============================================================================

  final List<Widget> programmingChips = List<Widget>.generate(
    programmingTags.length,
    (int index) {
      final String label = programmingTags[index];
      final Color tint = spectrum[index % spectrum.length];
      return _buildChip(label: label, tint: tint);
    },
  );

  final Wrap programmingChipCluster = Wrap(
    alignment: WrapAlignment.start,
    spacing: 8.0,
    runSpacing: 10.0,
    children: programmingChips,
  );

  // ============================================================================
  // SECTION 15: BUTTON ARRAY (mixed pill widths)
  // ============================================================================

  final List<String> actionLabels = <String>[
    'Save',
    'Save as draft',
    'Publish now',
    'Schedule',
    'Preview',
    'Discard',
    'Duplicate',
    'Archive',
    'Move to folder',
    'Share link',
    'Send for review',
    'Approve',
    'Reject changes',
    'Mark as done',
  ];

  final List<Widget> buttonArray = List<Widget>.generate(actionLabels.length, (
    int index,
  ) {
    final String label = actionLabels[index];
    final Color tint = spectrum[(index * 3) % spectrum.length];
    return _buildPillButton(label: label, tint: tint, accent: index % 3 == 0);
  });

  final Wrap buttonArrayWrap = Wrap(
    alignment: WrapAlignment.start,
    spacing: 10.0,
    runSpacing: 10.0,
    children: buttonArray,
  );

  // ============================================================================
  // SECTION 16: IMAGE GALLERY (placeholder tiles)
  // ============================================================================

  final List<Widget> galleryTiles = List<Widget>.generate(12, (int index) {
    final Color tint = spectrum[(index * 5) % spectrum.length];
    final Color tint2 = spectrum[(index * 5 + 3) % spectrum.length];
    return _buildGalleryTile(
      index: index,
      primary: tint,
      secondary: tint2,
    );
  });

  final Wrap galleryWrap = Wrap(
    alignment: WrapAlignment.center,
    spacing: 12.0,
    runSpacing: 12.0,
    children: galleryTiles,
  );

  // ============================================================================
  // SECTION 17: BADGE GRID
  // ============================================================================

  final List<String> badgeTitles = <String>[
    'Verified',
    'Pro',
    'Beta',
    'New',
    'Hot',
    'Stable',
    'Legacy',
    'Preview',
    'Internal',
    'Public',
    'Featured',
    'Trending',
    'Sale',
    'Limited',
    'Sold out',
    'Pre-order',
    'Coming soon',
  ];

  final List<Widget> badgeGrid = List<Widget>.generate(badgeTitles.length, (
    int index,
  ) {
    final String label = badgeTitles[index];
    final Color tint = spectrum[(index * 2 + 1) % spectrum.length];
    return _buildBadge(label: label, tint: tint);
  });

  final Wrap badgeGridWrap = Wrap(
    alignment: WrapAlignment.spaceEvenly,
    spacing: 8.0,
    runSpacing: 10.0,
    children: badgeGrid,
  );

  // ============================================================================
  // SECTION 18: KEYWORD CLOUD WITH VARYING SIZES (real-world feel)
  // ============================================================================

  final math.Random cloudRng = math.Random(42);

  final List<Widget> keywordCloud = List<Widget>.generate(
    productKeywords.length * 3,
    (int index) {
      final String label = productKeywords[index % productKeywords.length];
      final Color tint = spectrum[(index * 7) % spectrum.length];
      final double weight = 12.0 + cloudRng.nextDouble() * 16.0;
      final double opacity = 0.55 + cloudRng.nextDouble() * 0.45;
      return _buildKeyword(
        label: label,
        tint: tint,
        fontSize: weight,
        opacity: opacity,
      );
    },
  );

  final Wrap keywordCloudWrap = Wrap(
    alignment: WrapAlignment.center,
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 10.0,
    runSpacing: 6.0,
    children: keywordCloud,
  );

  // ============================================================================
  // SECTION 19: TAG EDITOR (chips with delete affordance + add tile)
  // ============================================================================

  final List<Widget> tagEditorChildren = <Widget>[];
  for (int i = 0; i < moodTags.length; i++) {
    final String t = moodTags[i];
    final Color tint = spectrum[(i * 4) % spectrum.length];
    tagEditorChildren.add(_buildEditableTag(label: t, tint: tint));
  }
  tagEditorChildren.add(_buildAddTag());

  final Wrap tagEditorWrap = Wrap(
    alignment: WrapAlignment.start,
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 8.0,
    runSpacing: 8.0,
    children: tagEditorChildren,
  );

  // ============================================================================
  // SECTION 20: COLOR PALETTE SWATCHES
  // ============================================================================

  final List<Widget> swatchTiles = List<Widget>.generate(spectrum.length * 2, (
    int index,
  ) {
    final Color base = spectrum[index % spectrum.length];
    final bool dark = index >= spectrum.length;
    final Color shown = dark ? _darken(base, 0.25) : base;
    final String code = _toHex(shown);
    return _buildSwatch(color: shown, code: code);
  });

  final Wrap swatchWrap = Wrap(
    alignment: WrapAlignment.start,
    crossAxisAlignment: WrapCrossAlignment.start,
    spacing: 10.0,
    runSpacing: 10.0,
    children: swatchTiles,
  );

  // ============================================================================
  // SECTION 21: NUMERIC RAINBOW (vertical-direction grid)
  // ============================================================================

  final List<Widget> numericTiles = List<Widget>.generate(20, (int index) {
    final Color tint = spectrum[index % spectrum.length];
    return _buildLabelBox(
      label: '${index + 1}',
      tint: tint,
      width: 48.0,
      height: 36.0,
    );
  });

  final Wrap numericRainbow = Wrap(
    direction: Axis.vertical,
    alignment: WrapAlignment.start,
    runAlignment: WrapAlignment.center,
    spacing: 6.0,
    runSpacing: 8.0,
    children: numericTiles,
  );

  // ============================================================================
  // SECTION 22: TIMELINE-LIKE FLOW (mixed sizes, sequential)
  // ============================================================================

  final List<String> timelineLabels = <String>[
    '00:00',
    '00:05',
    '00:11',
    '00:20',
    '00:32',
    '00:48',
    '01:04',
    '01:22',
    '01:41',
    '02:03',
    '02:25',
    '02:48',
    '03:12',
    '03:36',
    '04:00',
    '04:24',
  ];

  final List<Widget> timelineTiles = List<Widget>.generate(
    timelineLabels.length,
    (int index) {
      final String label = timelineLabels[index];
      final Color tint = spectrum[(index * 6) % spectrum.length];
      return _buildTimelineNode(label: label, tint: tint, index: index);
    },
  );

  final Wrap timelineWrap = Wrap(
    alignment: WrapAlignment.start,
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 6.0,
    runSpacing: 8.0,
    children: timelineTiles,
  );

  // ============================================================================
  // ROOT SCAFFOLD
  // ============================================================================

  return Scaffold(
    backgroundColor: bgSlate,
    appBar: AppBar(
      backgroundColor: bgSlateSoft,
      elevation: 0.0,
      title: const Text(
        'Wrap Widget Gallery',
        style: TextStyle(
          color: textPrimary,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
      iconTheme: const IconThemeData(color: textPrimary),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(28.0),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'A deep tour of direction, alignment, run alignment, '
              'cross-axis alignment, spacing, text direction, vertical '
              'direction, clipping, and real-world flowing layouts.',
              style: TextStyle(color: textSecondary, fontSize: 11.5),
            ),
          ),
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildIntroCard(
            title: 'Wrap fundamentals',
            body: 'Wrap lays out children sequentially in the main axis and '
                'starts a new run when the next child does not fit. It is the '
                'natural choice for chip clusters, tag editors, flowing '
                'galleries, badge grids, and any UI where layout density '
                'should adapt to available width.',
            border: borderAccent,
          ),
          const SizedBox(height: 18.0),
          _buildSectionCard(
            number: '01',
            title: 'WrapAlignment.start',
            subtitle: 'Children pack to the leading edge of every run.',
            child: startWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '02',
            title: 'WrapAlignment.end',
            subtitle: 'Children pack to the trailing edge of every run.',
            child: endWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '03',
            title: 'WrapAlignment.center',
            subtitle: 'Children center within each run.',
            child: centerWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '04',
            title: 'WrapAlignment.spaceBetween',
            subtitle: 'Equal space between children, none at the ends.',
            child: spaceBetweenWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '05',
            title: 'WrapAlignment.spaceAround',
            subtitle: 'Equal space around each child, half at the ends.',
            child: spaceAroundWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '06',
            title: 'WrapAlignment.spaceEvenly',
            subtitle: 'Equal space between every child and the edges.',
            child: spaceEvenlyWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 22.0),
          _buildSectionHeader(
            label: 'crossAxisAlignment',
            description:
                'Aligns children of differing cross-axis sizes within a run.',
            accent: spectrum[10],
          ),
          const SizedBox(height: 8.0),
          _buildTriColumn(
            surface: cardSurface,
            border: borderSoft,
            left: _buildLabeledTile(
              title: 'start',
              tint: spectrum[5],
              child: crossStartWrap,
            ),
            mid: _buildLabeledTile(
              title: 'center',
              tint: spectrum[8],
              child: crossCenterWrap,
            ),
            right: _buildLabeledTile(
              title: 'end',
              tint: spectrum[12],
              child: crossEndWrap,
            ),
          ),
          const SizedBox(height: 22.0),
          _buildSectionHeader(
            label: 'runAlignment',
            description:
                'Controls how multiple runs (rows) align in the cross axis '
                'when the wrap itself has spare cross-axis space.',
            accent: spectrum[4],
          ),
          const SizedBox(height: 8.0),
          _buildBoxedWrapTile(
            label: 'runAlignment.start',
            child: runStartWrap,
            height: 200.0,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 10.0),
          _buildBoxedWrapTile(
            label: 'runAlignment.center',
            child: runCenterWrap,
            height: 200.0,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 10.0),
          _buildBoxedWrapTile(
            label: 'runAlignment.end',
            child: runEndWrap,
            height: 200.0,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 10.0),
          _buildBoxedWrapTile(
            label: 'runAlignment.spaceBetween',
            child: runSpaceBetweenWrap,
            height: 200.0,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 22.0),
          _buildSectionHeader(
            label: 'spacing & runSpacing',
            description:
                'The gap between children in the same run, and the gap '
                'between runs.',
            accent: spectrum[14],
          ),
          const SizedBox(height: 8.0),
          _buildSectionCard(
            number: '07',
            title: 'tight (spacing 2 / runSpacing 2)',
            subtitle: 'Dense packing; suitable for swatches and icon grids.',
            child: tightWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '08',
            title: 'medium (spacing 10 / runSpacing 10)',
            subtitle: 'Balanced spacing for tag clusters and chip rows.',
            child: mediumWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '09',
            title: 'loose (spacing 22 / runSpacing 22)',
            subtitle: 'Airy layout for high-emphasis CTA arrays.',
            child: looseWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 22.0),
          _buildSectionHeader(
            label: 'direction: Axis.vertical',
            description:
                'When direction is vertical, the main axis runs top-to-bottom '
                'and new runs flow left-to-right.',
            accent: spectrum[2],
          ),
          const SizedBox(height: 8.0),
          _buildTriColumn(
            surface: cardSurface,
            border: borderSoft,
            left: _buildLabeledTile(
              title: 'vert start',
              tint: spectrum[11],
              child: SizedBox(height: 240.0, child: verticalWrapStart),
            ),
            mid: _buildLabeledTile(
              title: 'vert center',
              tint: spectrum[6],
              child: SizedBox(height: 240.0, child: verticalWrapCenter),
            ),
            right: _buildLabeledTile(
              title: 'vert end',
              tint: spectrum[13],
              child: SizedBox(height: 240.0, child: verticalWrapEnd),
            ),
          ),
          const SizedBox(height: 22.0),
          _buildSectionHeader(
            label: 'textDirection',
            description:
                'Mirrors the main axis order. LTR fills left-to-right; '
                'RTL fills right-to-left.',
            accent: spectrum[3],
          ),
          const SizedBox(height: 8.0),
          _buildSectionCard(
            number: '10',
            title: 'TextDirection.ltr',
            subtitle: 'L0 sits at the left; subsequent tiles flow rightward.',
            child: ltrWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '11',
            title: 'TextDirection.rtl',
            subtitle: 'R0 sits at the right; subsequent tiles flow leftward.',
            child: rtlWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 22.0),
          _buildSectionHeader(
            label: 'verticalDirection',
            description:
                'Reverses the order of children along the vertical axis.',
            accent: spectrum[7],
          ),
          const SizedBox(height: 8.0),
          _buildTriColumn(
            surface: cardSurface,
            border: borderSoft,
            left: _buildLabeledTile(
              title: 'vert down',
              tint: spectrum[12],
              child: SizedBox(height: 200.0, child: verticalDownWrap),
            ),
            mid: _buildLabeledTile(
              title: 'vert up',
              tint: spectrum[1],
              child: SizedBox(height: 200.0, child: verticalUpWrap),
            ),
            right: _buildLabeledTile(
              title: 'comparison',
              tint: spectrum[9],
              child: const _DirectionLegend(),
            ),
          ),
          const SizedBox(height: 22.0),
          _buildSectionHeader(
            label: 'clipBehavior',
            description:
                'Determines whether out-of-bounds painting from descendants '
                'is clipped.',
            accent: spectrum[0],
          ),
          const SizedBox(height: 8.0),
          _buildSectionCard(
            number: '12',
            title: 'Clip.none (default)',
            subtitle:
                'Children may paint outside Wrap bounds; lowest cost.',
            child: clipNoneWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '13',
            title: 'Clip.hardEdge',
            subtitle: 'Crisp clip with aliased edges; cheap GPU work.',
            child: clipHardWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '14',
            title: 'Clip.antiAlias',
            subtitle: 'Smoothed clip edges; ideal for rounded surfaces.',
            child: clipAntiAliasWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 22.0),
          _buildBigSectionHeader(
            label: 'Real-world flows',
            description:
                'Wrap shines for content where the count of children is '
                'data-driven and the layout must reflow on resize.',
            accent: spectrum[15],
          ),
          const SizedBox(height: 12.0),
          _buildSectionCard(
            number: '15',
            title: 'Programming tag cluster',
            subtitle:
                'A horizontal Wrap of colored chips representing taxonomic '
                'tags. Resizing the surface naturally reflows the cluster.',
            child: programmingChipCluster,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '16',
            title: 'Pill button array',
            subtitle:
                'Action buttons of varying widths laid out via Wrap so they '
                'never overflow a row.',
            child: buttonArrayWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '17',
            title: 'Image gallery (placeholder tiles)',
            subtitle:
                'A reflowing gallery of square tiles, centered in their run.',
            child: galleryWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '18',
            title: 'Badge grid',
            subtitle:
                'Badges with WrapAlignment.spaceEvenly across multiple runs.',
            child: badgeGridWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '19',
            title: 'Keyword cloud',
            subtitle:
                'Varying font sizes and opacities to emulate a tag cloud.',
            child: keywordCloudWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '20',
            title: 'Tag editor',
            subtitle:
                'Editable tags with delete affordance plus an add tile.',
            child: tagEditorWrap,
            surface: cardSurfaceLight,
            border: borderSoft,
            inverted: true,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '21',
            title: 'Color palette swatches',
            subtitle:
                'Each tile shows a swatch with its hex code; reflows when '
                'the surface is narrowed.',
            child: swatchWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '22',
            title: 'Numeric rainbow (Axis.vertical)',
            subtitle:
                'A vertical Wrap of numbered tiles; new runs flow rightward.',
            child: SizedBox(height: 240.0, child: numericRainbow),
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 14.0),
          _buildSectionCard(
            number: '23',
            title: 'Timeline-like flow',
            subtitle:
                'Timestamp tiles connected visually by chevrons, wrapping '
                'across multiple runs.',
            child: timelineWrap,
            surface: cardSurface,
            border: borderSoft,
          ),
          const SizedBox(height: 22.0),
          _buildFooterNote(
            text: 'End of Wrap gallery — '
                '${spectrum.length} spectrum colors, '
                '${programmingTags.length} programming tags, '
                '${moodTags.length} mood tags, '
                '${productKeywords.length} product keywords.',
            tint: hint,
            ink: textInk,
            ground: bgSlateMuted,
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ============================================================================
// HELPER BUILDERS
// ============================================================================

Widget _buildLabelBox({
  required String label,
  required Color tint,
  required double width,
  required double height,
}) {
  return Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          tint.withValues(alpha: 0.85),
          tint.withValues(alpha: 0.55),
        ],
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: tint.withValues(alpha: 0.85),
        width: 1.0,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tint.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFF0F172A),
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget _buildChip({required String label, required Color tint}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: tint.withValues(alpha: 0.55),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: tint,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: tint.withValues(alpha: 0.6),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: TextStyle(
            color: tint.withValues(alpha: 0.95),
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPillButton({
  required String label,
  required Color tint,
  required bool accent,
}) {
  final Color fg = accent ? const Color(0xFF0F172A) : tint;
  final Color bg = accent
      ? tint.withValues(alpha: 0.85)
      : tint.withValues(alpha: 0.12);
  final Color border = tint.withValues(alpha: 0.55);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 9.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(24.0),
      border: Border.all(color: border, width: 1.0),
      boxShadow: accent
          ? <BoxShadow>[
              BoxShadow(
                color: tint.withValues(alpha: 0.35),
                blurRadius: 10.0,
                offset: const Offset(0.0, 3.0),
              ),
            ]
          : <BoxShadow>[],
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _buildGalleryTile({
  required int index,
  required Color primary,
  required Color secondary,
}) {
  return Container(
    width: 96.0,
    height: 96.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          primary.withValues(alpha: 0.9),
          secondary.withValues(alpha: 0.75),
        ],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: primary.withValues(alpha: 0.85),
        width: 1.2,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: primary.withValues(alpha: 0.28),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 8.0,
          top: 8.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              '#${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Positioned(
          right: 8.0,
          bottom: 8.0,
          child: Icon(
            Icons.photo_camera_outlined,
            color: Colors.white.withValues(alpha: 0.85),
            size: 18.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildBadge({required String label, required Color tint}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: tint.withValues(alpha: 0.6),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.verified_outlined,
          color: tint,
          size: 12.0,
        ),
        const SizedBox(width: 6.0),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: tint.withValues(alpha: 0.95),
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyword({
  required String label,
  required Color tint,
  required double fontSize,
  required double opacity,
}) {
  return Text(
    label,
    style: TextStyle(
      color: tint.withValues(alpha: opacity),
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
  );
}

Widget _buildEditableTag({required String label, required Color tint}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(10.0, 6.0, 6.0, 6.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: tint.withValues(alpha: 0.55),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: _darken(tint, 0.35),
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6.0),
        Container(
          width: 18.0,
          height: 18.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.35),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close,
            color: _darken(tint, 0.45),
            size: 12.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAddTag() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A).withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: const Color(0xFF0F172A).withValues(alpha: 0.25),
        width: 1.0,
      ),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.add, color: Color(0xFF0F172A), size: 14.0),
        SizedBox(width: 4.0),
        Text(
          'Add tag',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSwatch({required Color color, required String code}) {
  return Container(
    width: 84.0,
    decoration: BoxDecoration(
      color: const Color(0xFF111827),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: const Color(0xFF334155),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 52.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(7.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Text(
            code,
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimelineNode({
  required String label,
  required Color tint,
  required int index,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: tint.withValues(alpha: 0.6),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: tint,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Text(
              label,
              style: TextStyle(
                color: tint.withValues(alpha: 0.95),
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Icon(
          Icons.chevron_right,
          color: tint.withValues(alpha: 0.7),
          size: 16.0,
        ),
      ),
    ],
  );
}

Widget _buildIntroCard({
  required String title,
  required String body,
  required Color border,
}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: border.withValues(alpha: 0.5), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: border.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: border.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: border, width: 1.0),
              ),
              child: Icon(
                Icons.dashboard_customize_outlined,
                color: border,
                size: 18.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFE2E8F0),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          body,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionCard({
  required String number,
  required String title,
  required String subtitle,
  required Widget child,
  required Color surface,
  required Color border,
  bool inverted = false,
}) {
  final Color titleColor =
      inverted ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0);
  final Color subtitleColor =
      inverted ? const Color(0xFF334155) : const Color(0xFF94A3B8);
  final Color numberColor =
      inverted ? const Color(0xFF1E40AF) : const Color(0xFF38BDF8);
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: numberColor.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: numberColor.withValues(alpha: 0.5),
                  width: 1.0,
                ),
              ),
              child: Text(
                number,
                style: TextStyle(
                  color: numberColor,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          subtitle,
          style: TextStyle(
            color: subtitleColor,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: inverted
                ? const Color(0xFFE2E8F0)
                : const Color(0xFF0F172A).withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: inverted
                  ? const Color(0xFFCBD5E1)
                  : const Color(0xFF334155).withValues(alpha: 0.7),
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader({
  required String label,
  required String description,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          accent.withValues(alpha: 0.18),
          accent.withValues(alpha: 0.04),
        ],
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.55),
        width: 1.0,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 6.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: accent,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                description,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBigSectionHeader({
  required String label,
  required String description,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          accent.withValues(alpha: 0.28),
          accent.withValues(alpha: 0.06),
        ],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.7),
        width: 1.2,
      ),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.auto_awesome, color: accent, size: 22.0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: accent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                description,
                style: const TextStyle(
                  color: Color(0xFFCBD5E1),
                  fontSize: 12.0,
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

Widget _buildLabeledTile({
  required String title,
  required Color tint,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A).withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: tint.withValues(alpha: 0.55),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: tint,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                color: tint,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        child,
      ],
    ),
  );
}

Widget _buildTriColumn({
  required Widget left,
  required Widget mid,
  required Widget right,
  required Color surface,
  required Color border,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: left),
        const SizedBox(width: 8.0),
        Expanded(child: mid),
        const SizedBox(width: 8.0),
        Expanded(child: right),
      ],
    ),
  );
}

Widget _buildBoxedWrapTile({
  required String label,
  required Widget child,
  required double height,
  required Color surface,
  required Color border,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 2.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF38BDF8),
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color(0xFF334155).withValues(alpha: 0.8),
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ],
    ),
  );
}

Widget _buildFooterNote({
  required String text,
  required Color tint,
  required Color ink,
  required Color ground,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: ground.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: tint.withValues(alpha: 0.45),
        width: 1.0,
      ),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.info_outline, color: tint, size: 16.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: tint,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    ),
  );
}

Color _darken(Color color, double amount) {
  final double clamped = amount.clamp(0.0, 1.0);
  final int r =
      ((color.r * 255.0).round() * (1.0 - clamped)).round().clamp(0, 255);
  final int g =
      ((color.g * 255.0).round() * (1.0 - clamped)).round().clamp(0, 255);
  final int b =
      ((color.b * 255.0).round() * (1.0 - clamped)).round().clamp(0, 255);
  return Color.fromARGB((color.a * 255.0).round(), r, g, b);
}

String _toHex(Color color) {
  String two(int v) => v.toRadixString(16).padLeft(2, '0').toUpperCase();
  final int r = (color.r * 255.0).round();
  final int g = (color.g * 255.0).round();
  final int b = (color.b * 255.0).round();
  return '#${two(r)}${two(g)}${two(b)}';
}

class _DirectionLegend extends StatelessWidget {
  const _DirectionLegend();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _LegendRow(
          icon: Icons.arrow_downward,
          label: 'down: children flow top to bottom',
          tint: Color(0xFF38BDF8),
        ),
        SizedBox(height: 8.0),
        _LegendRow(
          icon: Icons.arrow_upward,
          label: 'up: children flow bottom to top',
          tint: Color(0xFFF59E0B),
        ),
        SizedBox(height: 8.0),
        _LegendRow(
          icon: Icons.swap_vert,
          label: 'reverses run order in vertical wraps',
          tint: Color(0xFFA855F7),
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.icon,
    required this.label,
    required this.tint,
  });

  final IconData icon;
  final String label;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: tint, size: 14.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: tint,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

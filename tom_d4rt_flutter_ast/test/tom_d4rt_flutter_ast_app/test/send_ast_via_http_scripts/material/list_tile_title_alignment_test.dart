// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ListTileTitleAlignment Deep Demo ===');
  for (final v in ListTileTitleAlignment.values) {
    print('  ${v.index}: ${v.name}');
  }

  // ==========================================================================
  // PALETTES
  // ==========================================================================
  // Hero card palette
  const heroBg = Color(0xFF0F2040);
  const heroFg = Color(0xFFE6F0FF);
  const heroAccent = Color(0xFF63B0FF);
  const heroSoft = Color(0xFF1B355E);

  // Per-value showcase palette (warm peach)
  const perValueBg = Color(0xFFFFF1E6);
  const perValueFg = Color(0xFF4A2C1A);
  const perValueAccent = Color(0xFFE07A4B);
  const perValueSoft = Color(0xFFFFD9BE);

  // Side-by-side sweep palette (mint)
  const sweepBg = Color(0xFFE6F7EE);
  const sweepFg = Color(0xFF1F4031);
  const sweepAccent = Color(0xFF2E8B57);
  const sweepSoft = Color(0xFFC8EAD7);

  // Subtitle length sweep palette (lavender)
  const subBg = Color(0xFFF1ECFB);
  const subFg = Color(0xFF2E1F55);
  const subAccent = Color(0xFF6E3CC4);
  const subSoft = Color(0xFFD9CBF3);

  // Leading variants palette (slate)
  const leadBg = Color(0xFFEDF1F5);
  const leadFg = Color(0xFF1F2A38);
  const leadAccent = Color(0xFF3F5C76);
  const leadSoft = Color(0xFFD2DBE5);

  // isThreeLine palette (rose)
  const triBg = Color(0xFFFFE9EC);
  const triFg = Color(0xFF55121C);
  const triAccent = Color(0xFFC2185B);
  const triSoft = Color(0xFFFFC7CD);

  // Themed palette (teal)
  const themedBg = Color(0xFFE0F4F4);
  const themedFg = Color(0xFF0F3B3B);
  const themedAccent = Color(0xFF00838F);
  const themedSoft = Color(0xFFB2DFDB);

  // Recipe gallery palette (amber)
  const recipeBg = Color(0xFFFFF8E1);
  const recipeFg = Color(0xFF3F2D00);
  const recipeAccent = Color(0xFFB8860B);
  const recipeSoft = Color(0xFFFFE9A8);

  // Reference table palette (graphite)
  const refBg = Color(0xFF1B1F24);
  const refFg = Color(0xFFE7ECF2);
  const refAccent = Color(0xFFFFB454);
  const refSoft = Color(0xFF2A3038);

  // ==========================================================================
  // SECTION 1 — HERO CARD
  //
  // A title-axis illustration plus a real ListTile used as a live "specimen".
  // ==========================================================================

  final heroIllustration = Container(
    height: 180,
    decoration: BoxDecoration(
      color: heroSoft,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: heroAccent.withOpacity(0.6), width: 1),
    ),
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: heroAccent,
                borderRadius: BorderRadius.circular(28),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.account_circle,
                  color: heroBg, size: 36),
            ),
            const SizedBox(height: 6),
            const Text(
              'leading',
              style: TextStyle(color: heroFg, fontSize: 11),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'title — primary text row',
                style: TextStyle(
                    color: heroFg,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                'subtitle line one — flows to multiple lines depending on '
                'content and width.',
                style: TextStyle(color: heroFg, fontSize: 12, height: 1.3),
              ),
              SizedBox(height: 4),
              Text(
                'subtitle line two — alignment controls how leading & trailing '
                'lock to title vs whole tile.',
                style: TextStyle(color: heroFg, fontSize: 12, height: 1.3),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chevron_right, color: heroAccent, size: 32),
            const SizedBox(height: 6),
            const Text(
              'trailing',
              style: TextStyle(color: heroFg, fontSize: 11),
            ),
          ],
        ),
      ],
    ),
  );

  final heroAxisLegend = Container(
    margin: const EdgeInsets.only(top: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: heroSoft.withOpacity(0.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: const [
        Icon(Icons.vertical_align_top, color: heroAccent, size: 18),
        SizedBox(width: 6),
        Text('top',
            style: TextStyle(color: heroFg, fontWeight: FontWeight.w500)),
        SizedBox(width: 16),
        Icon(Icons.vertical_align_center, color: heroAccent, size: 18),
        SizedBox(width: 6),
        Text('center',
            style: TextStyle(color: heroFg, fontWeight: FontWeight.w500)),
        SizedBox(width: 16),
        Icon(Icons.vertical_align_bottom, color: heroAccent, size: 18),
        SizedBox(width: 6),
        Text('bottom',
            style: TextStyle(color: heroFg, fontWeight: FontWeight.w500)),
        SizedBox(width: 16),
        Icon(Icons.height, color: heroAccent, size: 18),
        SizedBox(width: 6),
        Text('titleHeight',
            style: TextStyle(color: heroFg, fontWeight: FontWeight.w500)),
      ],
    ),
  );

  final heroLiveSpecimen = Container(
    margin: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      color: heroBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: heroAccent, width: 1),
    ),
    child: Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        listTileTheme: const ListTileThemeData(
          textColor: heroFg,
          iconColor: heroAccent,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: const CircleAvatar(
          backgroundColor: heroAccent,
          foregroundColor: heroBg,
          child: Icon(Icons.star),
        ),
        title: const Text('Live specimen — center alignment'),
        subtitle: const Text(
          'A real ListTile rendered with ListTileTitleAlignment.center; '
          'leading + trailing pin to the vertical center of the tile.',
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
      ),
    ),
  );

  final heroCard = Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: heroBg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: heroAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.format_align_center,
                  color: heroBg, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'ListTileTitleAlignment',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'How leading & trailing widgets vertically align with the '
                    'title row.',
                    style: TextStyle(color: heroFg, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'ListTileTitleAlignment is a five-value enum that decides where the '
          'leading and trailing widgets sit relative to the title text. '
          'threeLine and titleHeight are content-aware; top, center, and '
          'bottom snap to fixed positions of the tile box.',
          style: TextStyle(color: heroFg, fontSize: 13, height: 1.45),
        ),
        const SizedBox(height: 16),
        heroIllustration,
        heroAxisLegend,
        heroLiveSpecimen,
      ],
    ),
  );

  // ==========================================================================
  // SECTION 2 — PER-VALUE SHOWCASE
  //
  // One live ListTile per enum value, each with a multi-line subtitle so the
  // alignment is visually unambiguous.
  // ==========================================================================

  Widget perValueTile(ListTileTitleAlignment value, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: perValueAccent.withOpacity(0.55), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: perValueSoft,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: perValueAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'index ${value.index}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '.${value.name}',
                  style: TextStyle(
                      color: perValueFg,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace'),
                ),
                const Spacer(),
                Text(
                  description,
                  style: TextStyle(
                      color: perValueFg.withOpacity(0.85), fontSize: 12),
                ),
              ],
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
            titleAlignment: value,
            leading: CircleAvatar(
              backgroundColor: perValueAccent,
              foregroundColor: Colors.white,
              child: Text(
                value.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              'Title for ${value.name}',
              style: TextStyle(
                  color: perValueFg, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Subtitle line one for the ${value.name} alignment.\n'
              'Subtitle line two extends the tile vertically.\n'
              'Subtitle line three forces a tall content area.',
              style: TextStyle(color: perValueFg.withOpacity(0.85)),
            ),
            trailing: Icon(Icons.chevron_right, color: perValueAccent),
          ),
          ),
        ],
      ),
    );
  }

  final perValueCard = Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: perValueBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: perValueAccent.withOpacity(0.4), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: perValueAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              'Section 2 — per-value showcase',
              style: TextStyle(
                  color: perValueFg,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Each card pairs the enum value with a live ListTile that has the '
          'same content, so vertical positioning of the leading avatar and '
          'trailing chevron is the only variable.',
          style: TextStyle(color: perValueFg, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 16),
        perValueTile(ListTileTitleAlignment.threeLine,
            'Behaves like top when isThreeLine, else center'),
        perValueTile(ListTileTitleAlignment.titleHeight,
            'Aligns to the height of the title text'),
        perValueTile(ListTileTitleAlignment.top, 'Snap to top edge'),
        perValueTile(ListTileTitleAlignment.center,
            'Snap to vertical center of tile'),
        perValueTile(ListTileTitleAlignment.bottom, 'Snap to bottom edge'),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 3 — SIDE-BY-SIDE ENUM SWEEP
  //
  // The same tile content rendered five times in a vertical sweep grid for
  // a direct visual comparison.
  // ==========================================================================

  Widget sweepTile(ListTileTitleAlignment value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sweepAccent.withOpacity(0.5)),
      ),
      // `IntrinsicHeight` bounds the Row's vertical axis so the
      // `CrossAxisAlignment.stretch` doesn't propagate `h=Infinity` from the
      // outer `SingleChildScrollView` down into the side label container.
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 96,
              decoration: BoxDecoration(
                color: sweepSoft,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Text(
                value.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: sweepFg,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Material(
                type: MaterialType.transparency,
                child: ListTile(
                titleAlignment: value,
                leading: Icon(Icons.bookmark_border, color: sweepAccent),
                title: Text(
                  'Identical title text',
                  style: TextStyle(
                      color: sweepFg, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Identical two-line subtitle so only the alignment varies '
                  'across this column.',
                  style: TextStyle(color: sweepFg.withOpacity(0.85)),
                ),
                trailing: Icon(Icons.more_vert, color: sweepAccent),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final sweepCard = Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: sweepBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: sweepAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: sweepAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              'Section 3 — side-by-side enum sweep',
              style: TextStyle(
                  color: sweepFg,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Identical content rendered with each of the five enum values, '
          'stacked in one card so the vertical positioning of the leading '
          'icon and trailing button is directly comparable.',
          style: TextStyle(color: sweepFg, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 16),
        sweepTile(ListTileTitleAlignment.threeLine),
        sweepTile(ListTileTitleAlignment.titleHeight),
        sweepTile(ListTileTitleAlignment.top),
        sweepTile(ListTileTitleAlignment.center),
        sweepTile(ListTileTitleAlignment.bottom),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 4 — SUBTITLE LENGTH SWEEP
  //
  // Same alignment, three subtitle lengths (1 line / 3 lines / 6 lines) to
  // show how threeLine and titleHeight react to content height.
  // ==========================================================================

  String oneLine() => 'Short subtitle.';
  String threeLines() =>
      'Three-line subtitle — line one.\nLine two of three.\nLine three of three.';
  String sixLines() =>
      'Six-line subtitle — line one.\nLine two.\nLine three.\nLine four.\n'
      'Line five.\nLine six wraps the tile considerably.';

  Widget subSampleColumn(String label, ListTileTitleAlignment alignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: subAccent.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: subAccent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '.${alignment.name}',
                style: TextStyle(
                    color: subFg,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: subSoft.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: ListTile(
              titleAlignment: alignment,
              leading: Icon(Icons.short_text, color: subAccent),
              title: Text('1-line subtitle',
                  style: TextStyle(
                      color: subFg, fontWeight: FontWeight.w600)),
              subtitle: Text(oneLine(),
                  style: TextStyle(color: subFg.withOpacity(0.85))),
              trailing: Icon(Icons.east, color: subAccent),
            ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: subSoft.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: ListTile(
              titleAlignment: alignment,
              leading: Icon(Icons.notes, color: subAccent),
              title: Text('3-line subtitle',
                  style: TextStyle(
                      color: subFg, fontWeight: FontWeight.w600)),
              subtitle: Text(threeLines(),
                  style: TextStyle(color: subFg.withOpacity(0.85))),
              trailing: Icon(Icons.east, color: subAccent),
            ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: subSoft.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: ListTile(
              titleAlignment: alignment,
              leading: Icon(Icons.subject, color: subAccent),
              title: Text('6-line subtitle',
                  style: TextStyle(
                      color: subFg, fontWeight: FontWeight.w600)),
              subtitle: Text(sixLines(),
                  style: TextStyle(color: subFg.withOpacity(0.85))),
              trailing: Icon(Icons.east, color: subAccent),
            ),
            ),
          ),
        ],
      ),
    );
  }

  final subtitleSweepCard = Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: subBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: subAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.format_size, color: subAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              'Section 4 — subtitle length sweep',
              style: TextStyle(
                  color: subFg,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'For each of the two content-aware alignments, the same alignment '
          'is rendered with three subtitle lengths. Watch how threeLine '
          'flips behaviour at the three-line threshold and how titleHeight '
          'stays anchored to the title row regardless of subtitle size.',
          style: TextStyle(color: subFg, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 16),
        subSampleColumn('threeLine', ListTileTitleAlignment.threeLine),
        subSampleColumn('titleHeight', ListTileTitleAlignment.titleHeight),
        subSampleColumn('center (control)', ListTileTitleAlignment.center),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 5 — LEADING WIDGET VARIANTS
  //
  // Same alignment, four leading widget heights — small icon, rounded avatar,
  // 56x56 avatar, square thumbnail. Demonstrates that leading height matters.
  // ==========================================================================

  Widget leadVariantTile(String label, Widget leading,
      ListTileTitleAlignment alignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: leadAccent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: leadAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  alignment.name,
                  style: TextStyle(
                      color: leadFg.withOpacity(0.7),
                      fontSize: 11,
                      fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
            titleAlignment: alignment,
            leading: leading,
            title: Text(
              'Leading widget height varies',
              style: TextStyle(
                  color: leadFg, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'The trailing chevron and leading widget anchor relative to '
              'the same alignment value, but their visual offset scales with '
              'the size of the leading widget.',
              style: TextStyle(color: leadFg.withOpacity(0.85)),
            ),
            trailing: Icon(Icons.chevron_right, color: leadAccent),
          ),
          ),
        ],
      ),
    );
  }

  Widget leadVariantsBlock(ListTileTitleAlignment alignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: leadSoft.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: leadAccent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Alignment fixed at .${alignment.name}',
              style: TextStyle(
                  color: leadFg,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace'),
            ),
          ),
          leadVariantTile(
              'icon 24', Icon(Icons.star, color: leadAccent), alignment),
          leadVariantTile(
              'avatar 40',
              CircleAvatar(
                  backgroundColor: leadAccent,
                  child: const Text('AB',
                      style: TextStyle(color: Colors.white))),
              alignment),
          leadVariantTile(
              'avatar 56',
              CircleAvatar(
                  radius: 28,
                  backgroundColor: leadAccent,
                  child: const Icon(Icons.face, color: Colors.white, size: 28)),
              alignment),
          leadVariantTile(
              'thumb 56',
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: leadAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.image, color: Colors.white, size: 30),
              ),
              alignment),
        ],
      ),
    );
  }

  final leadVariantsCard = Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: leadBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: leadAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.image_outlined, color: leadAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              'Section 5 — leading widget variants',
              style: TextStyle(
                  color: leadFg,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'A small icon, a 40-pixel avatar, a 56-pixel avatar, and a 56-pixel '
          'square thumbnail all aligned with the same value. The leading '
          'widget height is what changes; the alignment value applies to '
          'whichever widget you supply.',
          style: TextStyle(color: leadFg, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 16),
        leadVariantsBlock(ListTileTitleAlignment.center),
        leadVariantsBlock(ListTileTitleAlignment.top),
        leadVariantsBlock(ListTileTitleAlignment.bottom),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 6 — isThreeLine vs titleHeight INTERACTION
  //
  // Two ListTile pairs: one with isThreeLine: false, one with true. Each pair
  // uses ListTileTitleAlignment.threeLine and titleHeight to show that the
  // alignment-name behavior toggles based on the isThreeLine flag.
  // ==========================================================================

  Widget triCompareRow(String label, bool isThreeLine,
      ListTileTitleAlignment alignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: triAccent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(6, 4, 6, 4),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: triSoft.withOpacity(0.6),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: triAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'isThreeLine=$isThreeLine, alignment=.${alignment.name}',
                  style: TextStyle(
                      color: triFg.withOpacity(0.75),
                      fontSize: 11,
                      fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
            isThreeLine: isThreeLine,
            titleAlignment: alignment,
            leading: CircleAvatar(
              backgroundColor: triAccent,
              child: const Icon(Icons.bolt, color: Colors.white),
            ),
            title: Text('Interaction sample',
                style:
                    TextStyle(color: triFg, fontWeight: FontWeight.w600)),
            subtitle: Text(
              'Subtitle line one of the interaction sample.\n'
              'Subtitle line two — Material requires three rows when '
              'isThreeLine: true.\n'
              'Subtitle line three is here for safety.',
              style: TextStyle(color: triFg.withOpacity(0.85)),
            ),
            trailing: Icon(Icons.adjust, color: triAccent),
          ),
          ),
        ],
      ),
    );
  }

  final isThreeLineCard = Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: triBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: triAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.toggle_on, color: triAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              'Section 6 — isThreeLine vs alignment',
              style: TextStyle(
                  color: triFg,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'ListTileTitleAlignment.threeLine reads the isThreeLine flag and '
          'routes between top (when true) and center (when false). Compare '
          'the two flag states with both threeLine and titleHeight applied.',
          style: TextStyle(color: triFg, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 16),
        triCompareRow('A1', false, ListTileTitleAlignment.threeLine),
        triCompareRow('A2', true, ListTileTitleAlignment.threeLine),
        triCompareRow('B1', false, ListTileTitleAlignment.titleHeight),
        triCompareRow('B2', true, ListTileTitleAlignment.titleHeight),
        triCompareRow('C1', false, ListTileTitleAlignment.center),
        triCompareRow('C2', true, ListTileTitleAlignment.center),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 7 — THEMED VIA ListTileThemeData
  //
  // Each themed block sets ListTileTheme(data: ListTileThemeData(
  // titleAlignment: ...)) so child tiles inherit it without setting it
  // explicitly. Also includes one tile that overrides locally to show
  // precedence.
  // ==========================================================================

  Widget themedBlock(ListTileTitleAlignment themeValue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: themedAccent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              'Theme.titleAlignment = .${themeValue.name}',
              style: TextStyle(
                  color: themedFg,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace'),
            ),
          ),
          ListTileTheme(
            data: ListTileThemeData(
              titleAlignment: themeValue,
              iconColor: themedAccent,
              textColor: themedFg,
              tileColor: themedSoft.withOpacity(0.35),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.cloud),
                  title: const Text('Inherits theme alignment'),
                  subtitle: const Text(
                    'No explicit titleAlignment on this tile — picks up the '
                    'theme value above.',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: const Icon(Icons.public),
                  title: const Text('Also inherits'),
                  subtitle: const Text(
                    'Long subtitle to reveal vertical anchor.\n'
                    'Second line for clarity.',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
                ListTile(
                  titleAlignment: ListTileTitleAlignment.bottom,
                  leading: const Icon(Icons.flag),
                  title: const Text('Local override = .bottom'),
                  subtitle: const Text(
                    'Demonstrates that an explicit per-tile alignment '
                    'overrides the surrounding ListTileTheme.',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            ),
          ),
        ],
      ),
    );
  }

  final themedCard = Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: themedBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: themedAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: themedAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              'Section 7 — themed via ListTileThemeData',
              style: TextStyle(
                  color: themedFg,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'ListTileThemeData.titleAlignment supplies a default for every '
          'descendant tile that does not set its own value. The third tile '
          'in each block overrides it locally to demonstrate that explicit '
          'per-tile values win.',
          style: TextStyle(color: themedFg, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 16),
        themedBlock(ListTileTitleAlignment.top),
        themedBlock(ListTileTitleAlignment.center),
        themedBlock(ListTileTitleAlignment.titleHeight),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 8 — RECIPE GALLERY
  //
  // Three real-world list patterns, each picking the alignment that fits
  // best: chat list (titleHeight), contact list (center), settings (top).
  // ==========================================================================

  Widget chatListEntry({
    required String name,
    required String snippet,
    required String time,
    required Color avatarColor,
    bool unread = false,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
      titleAlignment: ListTileTitleAlignment.titleHeight,
      leading: CircleAvatar(
        backgroundColor: avatarColor,
        foregroundColor: Colors.white,
        child: Text(name.substring(0, 1).toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                  color: recipeFg,
                  fontWeight:
                      unread ? FontWeight.w800 : FontWeight.w600),
            ),
          ),
          Text(
            time,
            style: TextStyle(
                color: recipeFg.withOpacity(0.7), fontSize: 12),
          ),
        ],
      ),
      subtitle: Text(
        snippet,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: recipeFg.withOpacity(0.85)),
      ),
      trailing: unread
          ? Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: recipeAccent,
                borderRadius: BorderRadius.circular(5),
              ),
            )
          : const SizedBox(width: 10),
    ),
    );
  }

  Widget contactListEntry({
    required String name,
    required String role,
    required String avatar,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: recipeAccent.withOpacity(0.85),
        foregroundColor: Colors.white,
        child: Text(avatar,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      title: Text(name,
          style: TextStyle(
              color: recipeFg, fontWeight: FontWeight.w600)),
      subtitle: Text(role,
          style: TextStyle(color: recipeFg.withOpacity(0.85))),
      trailing: Wrap(
        spacing: 6,
        children: [
          Icon(Icons.phone, color: recipeAccent),
          Icon(Icons.message, color: recipeAccent),
        ],
      ),
    ),
    );
  }

  Widget settingsEntry({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: recipeSoft,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: recipeAccent),
      ),
      title: Text(title,
          style: TextStyle(
              color: recipeFg, fontWeight: FontWeight.w600)),
      subtitle: Text(description,
          style: TextStyle(color: recipeFg.withOpacity(0.85))),
      trailing: Icon(Icons.chevron_right, color: recipeAccent),
    ),
    );
  }

  Widget recipeBlock(String label, String reason, List<Widget> tiles) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: recipeAccent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: recipeAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    reason,
                    style: TextStyle(
                        color: recipeFg.withOpacity(0.85), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          ...tiles,
        ],
      ),
    );
  }

  final recipeCard = Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: recipeBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: recipeAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: recipeAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              'Section 8 — recipe gallery',
              style: TextStyle(
                  color: recipeFg,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Three real-world list patterns, each picking the alignment that '
          'fits the visual rhythm of its row content.',
          style: TextStyle(color: recipeFg, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 16),
        recipeBlock(
          'CHAT — titleHeight',
          'Avatars stay near the title row so unread badges line up with the '
              'sender name.',
          [
            chatListEntry(
              name: 'Ada Lovelace',
              snippet:
                  'Sent the punch-card design over.\nWill iterate after '
                  'lunch.',
              time: '12:08',
              avatarColor: recipeAccent,
              unread: true,
            ),
            chatListEntry(
              name: 'Brian Kernighan',
              snippet: '“Hello, world!” still works as expected.',
              time: '11:42',
              avatarColor: const Color(0xFF8E5A3C),
            ),
            chatListEntry(
              name: 'Grace Hopper',
              snippet:
                  'Found a moth in the relay.\nDocumenting the incident now.\n'
                  'Will tape it into the logbook.',
              time: 'Yesterday',
              avatarColor: const Color(0xFFA76C2D),
              unread: true,
            ),
          ],
        ),
        recipeBlock(
          'CONTACTS — center',
          'Trailing call/message icons must vertically center on the avatar '
              'regardless of subtitle length.',
          [
            contactListEntry(
                name: 'Donald Knuth', role: 'Author, TAOCP', avatar: 'DK'),
            contactListEntry(
                name: 'Edsger W. Dijkstra',
                role: 'Algorithm theorist',
                avatar: 'EW'),
            contactListEntry(
                name: 'Margaret Hamilton',
                role: 'Software engineer',
                avatar: 'MH'),
          ],
        ),
        recipeBlock(
          'SETTINGS — top',
          'Icons anchor to the title row so dense settings rows scan top-to-'
              'bottom even with multi-line descriptions.',
          [
            settingsEntry(
              icon: Icons.notifications,
              title: 'Notifications',
              description:
                  'Push, email, and in-app alerts. Configure quiet hours and '
                  'channels.',
            ),
            settingsEntry(
              icon: Icons.lock_outline,
              title: 'Privacy & security',
              description:
                  'Sign-in methods, recovery, two-factor authentication, and '
                  'app permissions.',
            ),
            settingsEntry(
              icon: Icons.color_lens,
              title: 'Appearance',
              description:
                  'Theme, density, font scale, and reduced-motion options.',
            ),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 9 — REFERENCE TABLE
  //
  // A dense reference card listing every enum value with index, description,
  // and a one-line "use when" hint.
  // ==========================================================================

  TableRow refRow(ListTileTitleAlignment v, String description, String useWhen) {
    return TableRow(
      decoration: BoxDecoration(
        color: refSoft,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            v.name,
            style: TextStyle(
                color: refAccent,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            v.index.toString(),
            style: TextStyle(color: refFg, fontFamily: 'monospace'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            description,
            style: TextStyle(color: refFg, fontSize: 12, height: 1.35),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            useWhen,
            style: TextStyle(
                color: refFg.withOpacity(0.85), fontSize: 12, height: 1.35),
          ),
        ),
      ],
    );
  }

  TableRow refHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(color: refAccent),
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('value',
              style: TextStyle(
                  color: refBg,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace')),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('idx',
              style: TextStyle(
                  color: refBg,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace')),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('description',
              style: TextStyle(
                  color: refBg, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('use when',
              style: TextStyle(
                  color: refBg, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  final referenceCard = Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: refBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: refAccent.withOpacity(0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book_outlined, color: refAccent, size: 28),
            const SizedBox(width: 10),
            Text(
              'Section 9 — reference table',
              style: TextStyle(
                  color: refFg,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Quick-glance reference for every enum value with index, behavior, '
          'and a recommended use-when hint.',
          style: TextStyle(color: refFg, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: refAccent.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(120),
                1: FixedColumnWidth(48),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
              },
              children: [
                refHeaderRow(),
                refRow(
                  ListTileTitleAlignment.threeLine,
                  'top when isThreeLine: true; otherwise center.',
                  'Material defaults — pairs with isThreeLine flag.',
                ),
                refRow(
                  ListTileTitleAlignment.titleHeight,
                  'Aligns to the height of the title row.',
                  'Avatars in chat lists, name rows in inboxes.',
                ),
                refRow(
                  ListTileTitleAlignment.top,
                  'Snap leading & trailing to the top edge of the tile.',
                  'Settings entries with multi-line descriptions.',
                ),
                refRow(
                  ListTileTitleAlignment.center,
                  'Snap leading & trailing to vertical center.',
                  'Contact lists, action rows, equal-height tiles.',
                ),
                refRow(
                  ListTileTitleAlignment.bottom,
                  'Snap leading & trailing to the bottom edge.',
                  'Timeline rows where bottom-anchored badges read first.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: refSoft,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: refAccent.withOpacity(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: refAccent),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Order of precedence: ListTile.titleAlignment > '
                  'ListTileThemeData.titleAlignment > Material default '
                  '(threeLine). Pre-Material 3 apps may also see legacy '
                  'behavior shadowed by ThemeData.useMaterial3.',
                  style: TextStyle(
                      color: refFg, fontSize: 12, height: 1.45),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // ASSEMBLE
  // ==========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heroCard,
              perValueCard,
              sweepCard,
              subtitleSweepCard,
              leadVariantsCard,
              isThreeLineCard,
              themedCard,
              recipeCard,
              referenceCard,
            ],
          ),
        ),
      ),
    ),
  );
}

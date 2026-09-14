// ignore_for_file: avoid_print
// D4rt deep demo: OverlayChildLayoutInfo — layout information extension type
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Moss / Sage ───────────────────────────────────────────
  const deepMoss = Color(0xFF33691E);
  const moss = Color(0xFF558B2F);
  const sage = Color(0xFF689F38);
  const softMoss = Color(0xFF7CB342);
  const lightSage = Color(0xFFC5E1A5);
  const paleMoss = Color(0xFFF1F8E9);
  const whiteSage = Color(0xFFF7FBF0);
  const darkLoam = Color(0xFF1B3409);
  const accentBrick = Color(0xFFBF360C);
  const accentSlate = Color(0xFF37474F);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionHeader(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 22, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.75)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget infoBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: darkLoam)),
    );
  }

  Widget fieldRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: darkLoam)),
          ),
        ],
      ),
    );
  }

  Widget pill(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('OverlayChildLayoutInfo deep demo executing');
  print('=' * 60);

  print('\n--- What is OverlayChildLayoutInfo ---');
  print('An extension type wrapping (Size, Matrix4, Size)');
  print('Defined in widgets/overlay.dart line 38');
  print('Provides layout info for OverlayPortal overlay children');

  print('\n--- Three getters ---');
  print('childSize: Size of OverlayPortal.child in its own coords');
  print('childPaintTransform: Matrix4 mapping child to overlay coords');
  print('overlaySize: Size of the target Overlay');

  print('\n--- Used by ---');
  print('OverlayPortal.overlayChildLayoutBuilder constructor');
  print('typedef OverlayChildLayoutBuilder = Widget Function(');
  print('  BuildContext context, OverlayChildLayoutInfo info);');

  print('\n--- Key behaviors ---');
  print('Available during layout phase only');
  print('childPaintTransform enables coordinate-space mapping');
  print('overlaySize lets you clamp position within bounds');

  print('\n${'=' * 60}');
  print('OverlayChildLayoutInfo deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepMoss, moss, sage],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.layers, size: 28, color: lightSage),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('OverlayChildLayoutInfo',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('An extension type that provides layout information '
                  'for positioning overlay children relative to their '
                  'source widget and the target Overlay. Used by '
                  'OverlayPortal.overlayChildLayoutBuilder.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                pill('extension type', moss, Colors.white),
                pill('childSize', sage, Colors.white),
                pill('childPaintTransform', softMoss, darkLoam),
                pill('overlaySize', lightSage, darkLoam),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionHeader('1 \u00b7 What Is OverlayChildLayoutInfo',
            'An extension type wrapping a record tuple',
            deepMoss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepMoss.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepMoss.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'extension type OverlayChildLayoutInfo._(\n'
                    '  (Size childSize,\n'
                    '   Matrix4 childPaintTransform,\n'
                    '   Size overlaySize) _info\n'
                    ') {\n'
                    '  Size get childSize;\n'
                    '  Matrix4 get childPaintTransform;\n'
                    '  Size get overlaySize;\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepMoss)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'Unlike a class, an extension type has zero runtime overhead. '
                'The underlying representation is a Dart record (tuple) of '
                '(Size, Matrix4, Size). The getters provide named access to '
                'the positional record fields.',
                deepMoss,
                paleMoss,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 3. The three getters ─────────────────────────────────────
        sectionHeader('2 \u00b7 The Three Getters',
            'childSize, childPaintTransform, overlaySize',
            moss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final getter in [
                ('childSize', 'Size',
                    'The size of the OverlayPortal.child in its own local '
                    'coordinate system. This is the widget that triggers '
                    'the overlay, measured after layout.',
                    Icons.crop_din, moss),
                ('childPaintTransform', 'Matrix4',
                    'The paint transform that maps the child\u0027s local '
                    'coordinates into the target Overlay\u0027s coordinate '
                    'space. Encodes translation, rotation, and scale.',
                    Icons.transform, deepMoss),
                ('overlaySize', 'Size',
                    'The size of the target Overlay widget itself. Use '
                    'this to clamp your overlay child within the visible '
                    'area and prevent it from going off-screen.',
                    Icons.fullscreen, sage),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: getter.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: getter.$5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(getter.$4, size: 22, color: getter.$5),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(getter.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: getter.$5)),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: getter.$5.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(getter.$2,
                                      style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 9,
                                          color: getter.$5)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(getter.$3,
                                style: TextStyle(
                                    fontSize: 12, color: darkLoam)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. OverlayChildLayoutBuilder typedef ─────────────────────
        sectionHeader('3 \u00b7 The OverlayChildLayoutBuilder Typedef',
            'The callback that receives OverlayChildLayoutInfo',
            sage, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: sage.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: sage.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'typedef OverlayChildLayoutBuilder =\n'
                    '  Widget Function(\n'
                    '    BuildContext context,\n'
                    '    OverlayChildLayoutInfo info,\n'
                    '  );',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: sage)),
              ),
              const SizedBox(height: 8),
              fieldRow('Parameter 1', 'BuildContext context', sage),
              fieldRow('Parameter 2', 'OverlayChildLayoutInfo info', moss),
              fieldRow('Returns', 'Widget — the overlay child to display', deepMoss),
              const SizedBox(height: 8),
              infoBox(
                'This callback is passed to OverlayPortal.overlayChildLayoutBuilder '
                'constructor. Unlike the simpler overlayChildBuilder, this '
                'variant provides layout information so you can position the '
                'overlay relative to the source widget.',
                sage,
                paleMoss,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Coordinate system diagram ─────────────────────────────
        sectionHeader('4 \u00b7 Coordinate System Visual',
            'How childPaintTransform maps between coordinate spaces',
            deepMoss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightSage),
          ),
          child: Column(
            children: [
              // Overlay coordinate space
              Container(
                width: double.infinity,
                height: 180,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentSlate.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: accentSlate, width: 2),
                ),
                child: Stack(
                  children: [
                    // Label: Overlay
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: accentSlate,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                        child: const Text('Overlay (overlaySize)',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    // Child widget box
                    Positioned(
                      top: 50,
                      left: 40,
                      child: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          color: moss.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: moss, width: 2),
                        ),
                        child: Center(
                          child: Text('child\n(childSize)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: moss)),
                        ),
                      ),
                    ),
                    // Transform arrow
                    Positioned(
                      top: 55,
                      left: 140,
                      child: Row(
                        children: [
                          Icon(Icons.arrow_forward,
                              size: 14, color: accentBrick),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: accentBrick.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text('childPaintTransform',
                                style: TextStyle(
                                    fontSize: 7,
                                    fontWeight: FontWeight.bold,
                                    color: accentBrick)),
                          ),
                        ],
                      ),
                    ),
                    // Overlay child positioned relative to child
                    Positioned(
                      top: 100,
                      left: 40,
                      child: Container(
                        width: 110,
                        height: 50,
                        decoration: BoxDecoration(
                          color: sage.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: sage,
                              width: 2),
                        ),
                        child: Center(
                          child: Text('overlay child\n(positioned using info)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: sage)),
                        ),
                      ),
                    ),
                    // Dashed connection line (simulated)
                    Positioned(
                      top: 90,
                      left: 85,
                      child: Icon(Icons.arrow_downward,
                          size: 12, color: deepMoss),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              infoBox(
                'The childPaintTransform is a 4\u00d74 matrix that maps '
                'the child\u0027s local (0,0) origin to its position in '
                'the Overlay\u0027s coordinate space. By reading the '
                'translation from this matrix, you know exactly where '
                'the child appears within the overlay.',
                deepMoss,
                paleMoss,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. OverlayPortal constructor comparison ──────────────────
        sectionHeader('5 \u00b7 Two OverlayPortal Constructors',
            'With and without layout info',
            moss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentSlate.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentSlate),
                  ),
                  child: Column(
                    children: [
                      Text('OverlayPortal()',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentSlate)),
                      const SizedBox(height: 4),
                      Text('overlayChildBuilder:\n(context) => widget',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9,
                              color: accentSlate)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: accentSlate.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('No layout info',
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: accentSlate)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: moss.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: moss, width: 2),
                  ),
                  child: Column(
                    children: [
                      Text('.overlayChildLayoutBuilder()',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: moss)),
                      const SizedBox(height: 4),
                      Text('overlayChildLayoutBuilder:\n(context, info) => widget',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9,
                              color: moss)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: moss.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('Has OverlayChildLayoutInfo',
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: moss)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        infoBox(
          'The overlayChildLayoutBuilder named constructor provides the '
          'OverlayChildLayoutInfo parameter. Use this when you need to '
          'position the overlay relative to the child widget.',
          moss,
          paleMoss,
        ),
        const SizedBox(height: 14),

        // ── 7. Extracting position from Matrix4 ──────────────────────
        sectionHeader('6 \u00b7 Reading Position From childPaintTransform',
            'How to extract translation from a Matrix4',
            deepMoss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepMoss.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepMoss.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Get child position in overlay coords\n'
                    'final transform = info.childPaintTransform;\n'
                    'final childX = transform.getTranslation().x;\n'
                    'final childY = transform.getTranslation().y;\n'
                    '\n'
                    '// Position overlay child below the trigger\n'
                    'final top = childY + info.childSize.height;\n'
                    'final left = childX;\n'
                    '\n'
                    '// Clamp within overlay bounds\n'
                    'final maxLeft = info.overlaySize.width\n'
                    '    - tooltipWidth;\n'
                    'final clampedLeft = left.clamp(0, maxLeft);',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepMoss)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'Matrix4.getTranslation() returns a Vector3. The x and y '
                'components give the child\u0027s top-left corner in the '
                'overlay\u0027s coordinate space. Combine with childSize '
                'and overlaySize to position the overlay child anywhere '
                'relative to the trigger.',
                deepMoss,
                paleMoss,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Visual: tooltip positioning ───────────────────────────
        sectionHeader('7 \u00b7 Visual: Tooltip Positioning Pattern',
            'Using all three getters together',
            sage, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightSage),
          ),
          child: Column(
            children: [
              // Simulated overlay area
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: accentSlate.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: accentSlate.withValues(alpha: 0.3)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 2,
                      right: 4,
                      child: Text('overlaySize: 320\u00d7160',
                          style: TextStyle(
                              fontSize: 8, color: accentSlate)),
                    ),
                    // Trigger button
                    Positioned(
                      top: 30,
                      left: 60,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: moss,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Hover Me',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    // Size annotation
                    Positioned(
                      top: 16,
                      left: 60,
                      child: Text('childSize: 82\u00d730',
                          style: TextStyle(
                              fontSize: 7,
                              color: moss,
                              fontWeight: FontWeight.bold)),
                    ),
                    // Transform annotation
                    Positioned(
                      top: 40,
                      left: 170,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: accentBrick.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text('transform: (60, 30)',
                            style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                                color: accentBrick)),
                      ),
                    ),
                    // Arrow down
                    Positioned(
                      top: 62,
                      left: 95,
                      child: Icon(Icons.arrow_downward,
                          size: 12, color: sage),
                    ),
                    // Tooltip overlay child
                    Positioned(
                      top: 76,
                      left: 40,
                      child: Container(
                        width: 140,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: darkLoam.withValues(alpha: 0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border.all(color: sage),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tooltip Content',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: sage)),
                            Text('Positioned at:\ny = 30 + 30 = 60\nx = 60',
                                style: TextStyle(
                                    fontSize: 8, color: darkLoam)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: sage.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                    'top = childPaintTransform.y + childSize.height\n'
                    'left = childPaintTransform.x\n'
                    'Clamped: left.clamp(0, overlaySize.width - tooltipWidth)',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: sage)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Matrix4 structure ─────────────────────────────────────
        sectionHeader('8 \u00b7 Understanding the Matrix4',
            'What the 4\u00d74 transform matrix contains',
            moss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // Matrix grid
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: moss.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: moss),
                ),
                child: Column(
                  children: [
                    Text('childPaintTransform (typical)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: moss)),
                    const SizedBox(height: 8),
                    for (final row in [
                      ['scaleX', '0', '0', 'tx'],
                      ['0', 'scaleY', '0', 'ty'],
                      ['0', '0', '1', '0'],
                      ['0', '0', '0', '1'],
                    ])
                      Row(
                        children: [
                          const Text(' [ ', style: TextStyle(fontSize: 10)),
                          for (var i = 0; i < 4; i++)
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(1),
                                padding: const EdgeInsets.all(4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: (row[i] == 'tx' || row[i] == 'ty')
                                      ? accentBrick.withValues(alpha: 0.1)
                                      : moss.withValues(alpha: 0.04),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(row[i],
                                    style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 9,
                                        fontWeight: (row[i] == 'tx' ||
                                                row[i] == 'ty')
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: (row[i] == 'tx' ||
                                                row[i] == 'ty')
                                            ? accentBrick
                                            : darkLoam)),
                              ),
                            ),
                          const Text(' ] ', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              fieldRow('tx (position [12])', 'Child X in overlay coords', accentBrick),
              fieldRow('ty (position [13])', 'Child Y in overlay coords', accentBrick),
              fieldRow('scaleX', 'Horizontal scale factor', moss),
              fieldRow('scaleY', 'Vertical scale factor', moss),
            ],
          ),
        ),
        infoBox(
          'For most use cases, you only need the translation (tx, ty). '
          'These tell you where the child\u0027s top-left corner is '
          'in the overlay. Scale is usually 1.0 unless transforms are '
          'applied to ancestor widgets.',
          moss,
          paleMoss,
        ),
        const SizedBox(height: 14),

        // ── 10. Positioning strategies ───────────────────────────────
        sectionHeader('9 \u00b7 Positioning Strategies',
            'Common overlay positioning patterns',
            deepMoss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final strat in [
                ('Below child', 'top = childY + childSize.height\nleft = childX',
                    'Dropdowns, suggestions', Icons.arrow_drop_down, moss),
                ('Above child', 'top = childY - tooltipHeight\nleft = childX',
                    'Tooltips when near bottom', Icons.arrow_drop_up, sage),
                ('Right of child', 'top = childY\nleft = childX + childSize.width',
                    'Side panels, popovers', Icons.arrow_right, deepMoss),
                ('Centered below', 'top = childY + childSize.height\n'
                    'left = childX + childSize.width/2 - w/2',
                    'Centered tooltips', Icons.unfold_more, softMoss),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: strat.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: strat.$5, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(strat.$4, size: 20, color: strat.$5),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(strat.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: strat.$5)),
                            Text(strat.$2,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: darkLoam)),
                            Text(strat.$3,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    color: strat.$5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Boundary clamping ────────────────────────────────────
        sectionHeader('10 \u00b7 Boundary Clamping With overlaySize',
            'Keeping overlays within the visible area',
            sage, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: sage.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: sage.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'final overlayW = info.overlaySize.width;\n'
                    'final overlayH = info.overlaySize.height;\n'
                    '\n'
                    '// Clamp horizontally\n'
                    'var left = childX;\n'
                    'if (left + popupWidth > overlayW) {\n'
                    '  left = overlayW - popupWidth;\n'
                    '}\n'
                    'if (left < 0) left = 0;\n'
                    '\n'
                    '// Clamp vertically\n'
                    'var top = childY + childH;\n'
                    'if (top + popupHeight > overlayH) {\n'
                    '  top = childY - popupHeight; // flip above\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: sage)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'overlaySize acts as the bounding box. Clamping ensures '
                'your tooltip or popup stays within the overlay. If it '
                'would overflow at the bottom, flip it above the trigger. '
                'If it would overflow on the right, shift it left.',
                sage,
                paleMoss,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Comparison with CompositedTransformFollower ──────────
        sectionHeader('11 \u00b7 vs CompositedTransformFollower',
            'Two approaches to overlay positioning',
            moss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: moss),
                children: [
                  for (final h in ['Aspect', 'OverlayChildLayoutInfo', 'CompositedTransformFollower'])
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(h,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9)),
                    ),
                ],
              ),
              for (final row in [
                ('Approach', 'Builder callback with info', 'LayerLink + separate widget'),
                ('Timing', 'Layout phase', 'Composite phase'),
                ('Flexibility', 'Full control over positioning', 'Offset + alignment only'),
                ('Boundary', 'Manual via overlaySize', 'No built-in boundary'),
                ('Complexity', 'Lower (single widget)', 'Higher (target + follower + link)'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: deepMoss)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 9, color: darkLoam)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 9, color: darkLoam)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Extension type vs class ──────────────────────────────
        sectionHeader('12 \u00b7 Extension Type vs Class',
            'Why OverlayChildLayoutInfo is an extension type',
            deepMoss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final item in [
                ('Zero runtime overhead', 'Extension types compile away '
                    'completely. At runtime, it is just a raw record tuple.',
                    Icons.speed, moss),
                ('Named getters', 'Instead of accessing positional record '
                    'fields, you get meaningful names: childSize, '
                    'childPaintTransform, overlaySize.',
                    Icons.label, sage),
                ('Type safety', 'You cannot accidentally pass a random '
                    '(Size, Matrix4, Size) where an OverlayChildLayoutInfo '
                    'is expected — the types are distinct.',
                    Icons.shield, deepMoss),
                ('Private constructor', 'The ._() constructor means only '
                    'the framework can create instances. User code reads them.',
                    Icons.lock, accentSlate),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: item.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: item.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(item.$3, size: 18, color: item.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: item.$4)),
                            Text(item.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkLoam)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Practical patterns ───────────────────────────────────
        sectionHeader('13 \u00b7 Practical Patterns',
            'Real-world usage scenarios',
            sage, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final pattern in [
                ('Custom Tooltip', 'Position a rich tooltip below the '
                    'trigger button using childPaintTransform + childSize.',
                    Icons.chat_bubble_outline, moss),
                ('Autocomplete Dropdown', 'Open a suggestion list below '
                    'a text field, clamped within overlaySize bounds.',
                    Icons.list_alt, sage),
                ('Context Menu', 'Show a menu at the child\u0027s position, '
                    'flipping above if near the bottom edge.',
                    Icons.menu_open, deepMoss),
                ('Popover Card', 'Display a detail card anchored to a '
                    'list item, tracking its position even during scroll.',
                    Icons.open_in_new, softMoss),
                ('Color Picker', 'Anchor a color picker below a swatch '
                    'button, centered horizontally.',
                    Icons.palette, accentBrick),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: pattern.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: pattern.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(pattern.$3, size: 18, color: pattern.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pattern.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: pattern.$4)),
                            Text(pattern.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkLoam)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Performance ──────────────────────────────────────────
        sectionHeader('14 \u00b7 Performance Characteristics',
            'Lightweight by design', deepMoss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('Extension type', 'Zero allocation — compiles to raw record', Icons.memory, moss),
                ('Layout-phase only', 'Info is computed during layout, not on demand', Icons.schedule, sage),
                ('Matrix4 reuse', 'The transform matrix is already computed for painting', Icons.refresh, deepMoss),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: perf.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: perf.$4, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(perf.$3, size: 16, color: perf.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${perf.$1}: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: perf.$4)),
                            TextSpan(
                                text: perf.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkLoam)),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionHeader('15 \u00b7 Summary',
            'Key takeaways', deepMoss, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepMoss, moss],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Extension type wrapping (Size, Matrix4, Size) with zero overhead',
                'Three getters: childSize, childPaintTransform, overlaySize',
                'Used by OverlayPortal.overlayChildLayoutBuilder constructor',
                'childPaintTransform maps child coordinates to overlay coordinates',
                'Extract translation with getTranslation().x and .y',
                'overlaySize provides bounds for clamping overlay position',
                'Private constructor — only the framework creates instances',
                'Computed during layout phase, not on demand',
                'Enables tooltips, dropdowns, context menus, popovers',
                'Lower complexity than CompositedTransformTarget + Follower approach',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightSage,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}

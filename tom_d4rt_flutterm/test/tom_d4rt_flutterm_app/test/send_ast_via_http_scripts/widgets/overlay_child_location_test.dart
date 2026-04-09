// ignore_for_file: avoid_print
// D4rt deep demo: OverlayChildLocation — overlay insertion point enum
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Slate / Ice ───────────────────────────────────────────
  const deepSlate = Color(0xFF263238);
  const slate = Color(0xFF37474F);
  const steel = Color(0xFF546E7A);
  const softSlate = Color(0xFF78909C);
  const lightIce = Color(0xFFCFD8DC);
  const paleIce = Color(0xFFECEFF1);
  const whiteIce = Color(0xFFF7F9FA);
  const darkCharcoal = Color(0xFF1A2327);
  const accentCyan = Color(0xFF00838F);
  const accentAmber = Color(0xFFFF8F00);

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
          style: TextStyle(fontSize: 13, color: darkCharcoal)),
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
                style: TextStyle(fontSize: 13, color: darkCharcoal)),
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
  print('OverlayChildLocation deep demo executing');
  print('=' * 60);

  print('\n--- OverlayChildLocation enum ---');
  print('Values: nearestOverlay, rootOverlay');
  print('Defined in widgets/overlay.dart line 1712');
  print('Used by OverlayPortal.overlayLocation parameter');

  print('\n--- nearestOverlay ---');
  print('Inserts overlay child into the nearest enclosing Overlay');
  print('This is the default behavior');
  print('Overlay child transforms with ancestor widgets');

  print('\n--- rootOverlay ---');
  print('Inserts overlay child into the root (top-level) Overlay');
  print('Overlay child is positioned in screen coordinates');
  print('Not affected by ancestor transforms');

  print('\n--- Key behaviors ---');
  print('Default: nearestOverlay');
  print('Root overlay is typically the one created by MaterialApp/Navigator');
  print('Choice affects coordinate systems and z-ordering');

  print('\n${'=' * 60}');
  print('OverlayChildLocation deep demo completed');

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
              colors: [deepSlate, slate, steel],
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
                  Icon(Icons.layers_outlined, size: 28, color: lightIce),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('OverlayChildLocation',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('An enum that controls which Overlay receives the '
                  'overlay child from an OverlayPortal. Choose between '
                  'the nearest ancestor Overlay or the root Overlay.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                pill('enum', slate, Colors.white),
                pill('nearestOverlay', steel, Colors.white),
                pill('rootOverlay', softSlate, Colors.white),
                pill('OverlayPortal', lightIce, darkCharcoal),
              ]),
            ],
          ),
        ),

        // ── 2. Enum values ───────────────────────────────────────────
        sectionHeader('1 \u00b7 Enum Values',
            'Two insertion points for overlay children',
            deepSlate, Colors.white),
        for (final val in [
          ('nearestOverlay', 'Default',
              'Inserts the overlay child into the nearest enclosing '
              'Overlay widget in the widget tree. The overlay child '
              'inherits all ancestor transforms (scale, rotation, '
              'translation). This is the most common choice and '
              'matches how most popup menus and tooltips work.',
              Icons.filter_1, accentCyan),
          ('rootOverlay', 'Screen-level',
              'Inserts the overlay child into the root Overlay, '
              'typically created by MaterialApp or Navigator. The '
              'overlay child is positioned in the root coordinate '
              'space, unaffected by intermediate transforms. Use '
              'this for overlays that should span the entire screen.',
              Icons.filter_2, accentAmber),
        ])
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: whiteIce,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: val.$5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(val.$4, size: 22, color: val.$5),
                    const SizedBox(width: 8),
                    Text(val.$1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: val.$5)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: val.$5.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(val.$2,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: val.$5)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(val.$3,
                    style: TextStyle(fontSize: 12, color: darkCharcoal)),
              ],
            ),
          ),
        const SizedBox(height: 14),

        // ── 3. Visual: widget tree diagram ───────────────────────────
        sectionHeader('2 \u00b7 Widget Tree: Where Overlays Live',
            'Visual showing nearest vs root Overlay in the tree',
            slate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightIce),
          ),
          child: Column(
            children: [
              // Tree structure
              for (final node in [
                (0, 'MaterialApp', 'Creates root Overlay', deepSlate, true),
                (1, 'Navigator', '', steel, false),
                (2, 'Overlay (ROOT)', 'rootOverlay target', accentAmber, true),
                (3, 'Scaffold', '', softSlate, false),
                (4, 'Stack', '', softSlate, false),
                (5, 'Overlay (NESTED)', 'nearestOverlay target', accentCyan, true),
                (6, 'YourWidget', '', steel, false),
                (7, 'OverlayPortal', 'overlayLocation: ?', deepSlate, true),
              ])
                Padding(
                  padding: EdgeInsets.only(left: node.$1 * 16.0, top: 3, bottom: 3),
                  child: Row(
                    children: [
                      if (node.$1 > 0)
                        Text('${'  ' * (node.$1 - 1)}\u2514\u2500 ',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: softSlate)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: node.$5
                              ? node.$4.withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: node.$5
                              ? Border.all(color: node.$4)
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(node.$2,
                                style: TextStyle(
                                    fontWeight: node.$5
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 10,
                                    color: node.$4)),
                            if (node.$3.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(node.$3,
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontStyle: FontStyle.italic,
                                        color: node.$4)),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: accentAmber.withValues(alpha: 0.15),
                      border: Border.all(color: accentAmber),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('rootOverlay',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: accentAmber)),
                  const SizedBox(width: 16),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: accentCyan.withValues(alpha: 0.15),
                      border: Border.all(color: accentCyan),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('nearestOverlay',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: accentCyan)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Usage in OverlayPortal ────────────────────────────────
        sectionHeader('3 \u00b7 Usage in OverlayPortal',
            'How to pass overlayLocation',
            steel, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Default usage
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentCyan.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: accentCyan.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Default (nearestOverlay):',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: accentCyan)),
                    const SizedBox(height: 4),
                    Text('OverlayPortal(\n'
                        '  controller: controller,\n'
                        '  // overlayLocation defaults to\n'
                        '  // OverlayChildLocation.nearestOverlay\n'
                        '  overlayChildBuilder: (ctx) => ...,\n'
                        ')',
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                            color: accentCyan)),
                  ],
                ),
              ),
              // Root usage
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentAmber.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: accentAmber.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Explicit root:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: accentAmber)),
                    const SizedBox(height: 4),
                    Text('OverlayPortal(\n'
                        '  controller: controller,\n'
                        '  overlayLocation:\n'
                        '    OverlayChildLocation.rootOverlay,\n'
                        '  overlayChildBuilder: (ctx) => ...,\n'
                        ')',
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                            color: accentAmber)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Nearest vs root side-by-side ──────────────────────────
        sectionHeader('4 \u00b7 Side-by-Side Comparison',
            'Behavior differences between the two values',
            deepSlate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // nearestOverlay
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentCyan.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentCyan),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.filter_none,
                          size: 24, color: accentCyan),
                      const SizedBox(height: 4),
                      Text('nearestOverlay',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentCyan)),
                      const Divider(),
                      for (final trait in [
                        'Closest Overlay ancestor',
                        'Inherits transforms',
                        'Scoped coordinate space',
                        'Respects clipping',
                        'Good for local popups',
                      ])
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle,
                                  size: 10, color: accentCyan),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(trait,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: darkCharcoal)),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // rootOverlay
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentAmber.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentAmber),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.fullscreen,
                          size: 24, color: accentAmber),
                      const SizedBox(height: 4),
                      Text('rootOverlay',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentAmber)),
                      const Divider(),
                      for (final trait in [
                        'Top-level Overlay',
                        'Ignores ancestor transforms',
                        'Screen coordinate space',
                        'Can escape clipping',
                        'Good for full-screen overlays',
                      ])
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle,
                                  size: 10, color: accentAmber),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(trait,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: darkCharcoal)),
                              ),
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
        const SizedBox(height: 14),

        // ── 6. Transform inheritance ─────────────────────────────────
        sectionHeader('5 \u00b7 Transform Inheritance',
            'How ancestor transforms affect overlay children',
            slate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightIce),
          ),
          child: Column(
            children: [
              // Scenario: scaled ancestor
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // nearestOverlay case
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentCyan.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: accentCyan.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Text('nearestOverlay',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: accentCyan)),
                          const SizedBox(height: 4),
                          Container(
                            width: 80,
                            height: 50,
                            decoration: BoxDecoration(
                              color: accentCyan.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: accentCyan),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 2,
                                  left: 2,
                                  child: Text('Transform(scale: 0.8)',
                                      style: TextStyle(
                                          fontSize: 5, color: accentCyan)),
                                ),
                                Positioned(
                                  top: 14,
                                  left: 10,
                                  child: Container(
                                    width: 60,
                                    height: 12,
                                    color: accentCyan.withValues(alpha: 0.2),
                                    child: Center(
                                      child: Text('button (0.8x)',
                                          style: TextStyle(
                                              fontSize: 5,
                                              color: accentCyan)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 28,
                                  left: 10,
                                  child: Container(
                                    width: 60,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: accentCyan),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Center(
                                      child: Text('popup (0.8x)',
                                          style: TextStyle(
                                              fontSize: 5,
                                              fontWeight: FontWeight.bold,
                                              color: accentCyan)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Also scaled 0.8x',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontStyle: FontStyle.italic,
                                  color: accentCyan)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // rootOverlay case
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentAmber.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: accentAmber.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Text('rootOverlay',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: accentAmber)),
                          const SizedBox(height: 4),
                          Container(
                            width: 80,
                            height: 50,
                            decoration: BoxDecoration(
                              color: accentAmber.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: accentAmber),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 2,
                                  left: 2,
                                  child: Text('Transform(scale: 0.8)',
                                      style: TextStyle(
                                          fontSize: 5, color: accentAmber)),
                                ),
                                Positioned(
                                  top: 14,
                                  left: 10,
                                  child: Container(
                                    width: 60,
                                    height: 12,
                                    color: accentAmber.withValues(alpha: 0.2),
                                    child: Center(
                                      child: Text('button (0.8x)',
                                          style: TextStyle(
                                              fontSize: 5,
                                              color: accentAmber)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 28,
                                  left: 5,
                                  child: Container(
                                    width: 70,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: accentAmber),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Center(
                                      child: Text('popup (1.0x)',
                                          style: TextStyle(
                                              fontSize: 5,
                                              fontWeight: FontWeight.bold,
                                              color: accentAmber)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Full size (1.0x)',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontStyle: FontStyle.italic,
                                  color: accentAmber)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              infoBox(
                'With nearestOverlay, the overlay child inherits all '
                'ancestor transforms (scale, rotation, etc). With '
                'rootOverlay, the overlay child is placed at the root '
                'level and is not affected by intermediate transforms.',
                slate,
                paleIce,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Coordinate spaces ─────────────────────────────────────
        sectionHeader('6 \u00b7 Coordinate Space Differences',
            'How position maps differently for each location',
            deepSlate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final coord in [
                ('nearestOverlay', 'Local to nearest Overlay',
                    'Position (0,0) is the top-left of the nearest '
                    'ancestor Overlay. Size is bounded by that Overlay\u0027s '
                    'dimensions. If the Overlay is inside a Dialog, coordinates '
                    'are relative to the Dialog.',
                    accentCyan),
                ('rootOverlay', 'Global (screen-level)',
                    'Position (0,0) is the top-left of the root Overlay '
                    '(usually the full screen minus system UI). Size is '
                    'the full screen dimensions. Coordinates are absolute.',
                    accentAmber),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: coord.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: coord.$4, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(coord.$1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: coord.$4)),
                          const SizedBox(width: 8),
                          Text(coord.$2,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                  color: coord.$4)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(coord.$3,
                          style: TextStyle(
                              fontSize: 11, color: darkCharcoal)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Z-ordering ────────────────────────────────────────────
        sectionHeader('7 \u00b7 Z-Ordering',
            'How overlayLocation affects stacking order',
            steel, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // Stack diagram
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: steel.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: steel),
                ),
                child: Column(
                  children: [
                    Text('Stacking Order (top to bottom)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: steel)),
                    const SizedBox(height: 8),
                    for (final layer in [
                      ('Root overlay children', accentAmber, 'highest z-order'),
                      ('Root overlay entries', steel, ''),
                      ('Page content', softSlate, ''),
                      ('Nested overlay children', accentCyan, 'within nested scope'),
                      ('Nested overlay entries', softSlate, ''),
                    ])
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: layer.$2.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: layer.$2.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(layer.$1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: layer.$2)),
                            ),
                            if (layer.$3.isNotEmpty)
                              Text(layer.$3,
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontStyle: FontStyle.italic,
                                      color: layer.$2)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              infoBox(
                'rootOverlay children always appear above nested overlay '
                'children because the root Overlay paints after all nested '
                'overlays. This is useful for modal dialogs or full-screen '
                'loaders that must be on top of everything.',
                steel,
                paleIce,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Clipping behavior ─────────────────────────────────────
        sectionHeader('8 \u00b7 Clipping Behavior',
            'How clip regions interact with overlay location',
            slate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // nearestOverlay with clip
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentCyan.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: accentCyan.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Text('nearestOverlay',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: accentCyan)),
                      const SizedBox(height: 4),
                      Container(
                        width: 80,
                        height: 60,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(color: accentCyan),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: 2,
                              left: 2,
                              child: Text('ClipRect',
                                  style: TextStyle(
                                      fontSize: 5, color: accentCyan)),
                            ),
                            Positioned(
                              top: 20,
                              left: 10,
                              child: Container(
                                width: 60,
                                height: 14,
                                color: accentCyan.withValues(alpha: 0.15),
                                child: Center(
                                  child: Text('popup (clipped)',
                                      style: TextStyle(
                                          fontSize: 5,
                                          color: accentCyan)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Clipped by ancestor',
                          style: TextStyle(
                              fontSize: 8,
                              color: accentCyan,
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // rootOverlay escapes clip
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentAmber.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: accentAmber.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Text('rootOverlay',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: accentAmber)),
                      const SizedBox(height: 4),
                      Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: accentAmber),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: 2,
                              left: 2,
                              child: Text('ClipRect',
                                  style: TextStyle(
                                      fontSize: 5, color: accentAmber)),
                            ),
                            Positioned(
                              top: 20,
                              left: 5,
                              child: Container(
                                width: 70,
                                height: 14,
                                color: accentAmber.withValues(alpha: 0.15),
                                child: Center(
                                  child: Text('popup (escapes)',
                                      style: TextStyle(
                                          fontSize: 5,
                                          color: accentAmber)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Escapes clip region',
                          style: TextStyle(
                              fontSize: 8,
                              color: accentAmber,
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        infoBox(
          'nearestOverlay children can be clipped by ancestor ClipRect, '
          'ClipRRect, etc. rootOverlay children escape those clip regions '
          'because they are inserted at the root level, above all '
          'intermediate clipping widgets.',
          slate,
          paleIce,
        ),
        const SizedBox(height: 14),

        // ── 10. Use cases table ──────────────────────────────────────
        sectionHeader('9 \u00b7 When to Use Each Value',
            'Decision guide', deepSlate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(5),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepSlate),
                children: [
                  for (final h in ['Use Case', 'Location', 'Reason'])
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(h,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('Dropdown menu', 'nearest', 'Menu scales with parent'),
                ('Tooltip', 'nearest', 'Positions relative to trigger'),
                ('Full-screen loader', 'root', 'Must cover entire screen'),
                ('Modal dialog', 'root', 'Above all other content'),
                ('Autocomplete', 'nearest', 'Follows text field position'),
                ('Onboarding overlay', 'root', 'Covers app UI completely'),
                ('Context menu', 'nearest', 'Local to interaction point'),
                ('Image preview', 'root', 'Fills screen, escapes scroll'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10, color: darkCharcoal)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: row.$2 == 'nearest'
                              ? accentCyan.withValues(alpha: 0.1)
                              : accentAmber.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(row.$2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: row.$2 == 'nearest'
                                    ? accentCyan
                                    : accentAmber)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: darkCharcoal)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Nested overlays scenario ─────────────────────────────
        sectionHeader('10 \u00b7 Nested Overlays',
            'Dialog inside a dialog scenario',
            steel, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: steel.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: steel),
                ),
                child: Column(
                  children: [
                    // Outer overlay
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentAmber.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: accentAmber.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Text('Root Overlay',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: accentAmber)),
                          const SizedBox(height: 4),
                          // Dialog
                          Container(
                            width: 200,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: steel),
                            ),
                            child: Column(
                              children: [
                                Text('Dialog (has own Overlay)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8,
                                        color: steel)),
                                const SizedBox(height: 4),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: accentCyan.withValues(alpha: 0.06),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: accentCyan.withValues(alpha: 0.3)),
                                  ),
                                  child: Column(
                                    children: [
                                      Text('Dialog\u0027s Overlay',
                                          style: TextStyle(
                                              fontSize: 7,
                                              color: accentCyan)),
                                      const SizedBox(height: 2),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          pill('nearest = here',
                                              accentCyan, Colors.white),
                                          pill('root = outer',
                                              accentAmber, Colors.white),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              infoBox(
                'When a Dialog creates its own Overlay (Navigator does this), '
                'nearestOverlay targets that Dialog\u0027s Overlay. '
                'rootOverlay targets the app\u0027s root Overlay. This matters '
                'for confirmation dialogs inside dialogs — use root to escape '
                'the inner dialog\u0027s scope.',
                steel,
                paleIce,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Impact on OverlayChildLayoutInfo ─────────────────────
        sectionHeader('11 \u00b7 Impact on OverlayChildLayoutInfo',
            'How location changes the info values',
            slate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              fieldRow('childSize', 'Same for both. Size of OverlayPortal.child',
                  slate),
              const Divider(),
              for (final info in [
                ('childPaintTransform (nearest)',
                    'Maps to nearest Overlay coords. Smaller offsets.',
                    accentCyan),
                ('childPaintTransform (root)',
                    'Maps to root Overlay coords. Larger offsets '
                    'including Dialog/Navigator padding.',
                    accentAmber),
                ('overlaySize (nearest)',
                    'Size of nearest Overlay (e.g., Dialog size).',
                    accentCyan),
                ('overlaySize (root)',
                    'Size of root Overlay (usually full screen).',
                    accentAmber),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: info.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: info.$3, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: info.$3)),
                      Text(info.$2,
                          style: TextStyle(
                              fontSize: 10, color: darkCharcoal)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Common mistakes ──────────────────────────────────────
        sectionHeader('12 \u00b7 Common Mistakes',
            'Pitfalls when choosing overlay location',
            deepSlate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final mistake in [
                ('Using root for tooltips',
                    'Tooltip coordinates are relative to the root, so '
                    'positioning becomes complex. Use nearest instead.',
                    Icons.warning_amber, accentAmber),
                ('Expecting nearest to escape clips',
                    'nearestOverlay children stay within the nearest '
                    'Overlay\u0027s scope and can be clipped. Use root '
                    'if you need to escape.',
                    Icons.content_cut, accentCyan),
                ('Forgetting Navigator creates Overlays',
                    'Each Navigator pushes its own Overlay. In a '
                    'multi-navigator app, nearest may not be what you expect.',
                    Icons.navigation, steel),
                ('Mixing coordinates with root',
                    'When using rootOverlay, OverlayChildLayoutInfo.overlaySize '
                    'is the full screen. Clamping logic must account for '
                    'system bars and safe areas.',
                    Icons.crop, slate),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: mistake.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: mistake.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(mistake.$3, size: 18, color: mistake.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mistake.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: mistake.$4)),
                            Text(mistake.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkCharcoal)),
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

        // ── 14. Enum properties ──────────────────────────────────────
        sectionHeader('13 \u00b7 Enum API Properties',
            'Standard Dart enum members',
            steel, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              fieldRow('values', '[nearestOverlay, rootOverlay]', steel),
              fieldRow('index', '0 = nearestOverlay, 1 = rootOverlay', steel),
              fieldRow('name', '"nearestOverlay" or "rootOverlay"', steel),
              const Divider(),
              fieldRow('Default', 'OverlayPortal uses nearestOverlay', deepSlate),
              fieldRow('Defined in', 'widgets/overlay.dart line 1712', deepSlate),
              fieldRow('Used by', 'OverlayPortal.overlayLocation', deepSlate),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Performance ──────────────────────────────────────────
        sectionHeader('14 \u00b7 Performance Notes',
            'Both values are equally performant',
            slate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('Same cost', 'Both values insert a single overlay entry — '
                    'no difference in layout cost', Icons.speed, steel),
                ('No re-layout', 'Changing overlayLocation does not trigger '
                    're-layout unless the overlay child depends on info.overlaySize',
                    Icons.refresh, slate),
                ('Build-time only', 'The enum value is read once during '
                    'OverlayPortal initialization', Icons.build, deepSlate),
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
                                    fontSize: 11, color: darkCharcoal)),
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
            'Key takeaways', deepSlate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepSlate, slate],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Enum with two values: nearestOverlay and rootOverlay',
                'Controls which Overlay receives the OverlayPortal overlay child',
                'nearestOverlay (default) targets the closest ancestor Overlay',
                'rootOverlay targets the top-level Overlay from MaterialApp/Navigator',
                'nearestOverlay inherits ancestor transforms; rootOverlay does not',
                'nearestOverlay can be clipped by ancestor widgets; rootOverlay escapes clipping',
                'rootOverlay children have higher z-order than nearestOverlay children',
                'Use nearest for tooltips, dropdowns, context menus',
                'Use root for full-screen overlays, modal dialogs, onboarding',
                'Affects OverlayChildLayoutInfo coordinate space and overlaySize',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightIce,
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

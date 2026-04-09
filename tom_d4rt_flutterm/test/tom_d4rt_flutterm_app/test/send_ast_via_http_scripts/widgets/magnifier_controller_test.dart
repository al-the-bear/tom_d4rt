// ignore_for_file: avoid_print
// D4rt deep demo: MagnifierController — manages magnifier overlay lifecycle
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Amethyst / Violet ──────────────────────────────────────
  const deepAmethyst = Color(0xFF1B0A3C);
  const royalViolet = Color(0xFF2E1065);
  const wisteria = Color(0xFF6D28D9);
  const orchid = Color(0xFF8B5CF6);
  const lavenderMist = Color(0xFFC4B5FD);
  const softLilac = Color(0xFFEDE9FE);
  const crystalWhite = Color(0xFFF5F3FF);
  const pinkAccent = Color(0xFFF472B6);
  const goldAccent = Color(0xFFFBBF24);
  const emeraldAccent = Color(0xFF34D399);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
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

  Widget noteBox(String text, Color border, Color bg) {
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
          style: TextStyle(fontSize: 13, color: deepAmethyst)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: deepAmethyst)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  Widget stateCard(String title, IconData icon, String description,
      Color accent, bool isActive) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: crystalWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: accent, width: 4)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, size: 22, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: deepAmethyst)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isActive
                            ? emeraldAccent.withValues(alpha: 0.15)
                            : Colors.grey.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(isActive ? 'ACTIVE' : 'INACTIVE',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: isActive
                                  ? emeraldAccent
                                  : Colors.grey)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(description,
                    style: TextStyle(fontSize: 12, color: royalViolet)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Gather data ────────────────────────────────────────────────────
  print('MagnifierController deep demo executing');
  print('=' * 60);

  final controller = MagnifierController();

  // Section 1
  print('\n--- What is MagnifierController ---');
  print('Manages magnifier overlay lifecycle');
  print('Controls show/hide with optional animation');

  // Section 2
  print('\n--- Initial state ---');
  print('shown: ${controller.shown}');
  print('overlayEntry: ${controller.overlayEntry}');
  print('animationController: ${controller.animationController}');

  // Section 3 — Properties
  print('\n--- Properties ---');
  print('Type: ${controller.runtimeType}');
  print('shown (bool): ${controller.shown}');
  print('overlayEntry: ${controller.overlayEntry}');

  print('\n${'=' * 60}');
  print('MagnifierController deep demo completed');

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
              colors: [deepAmethyst, royalViolet, wisteria],
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
                  Icon(Icons.zoom_in, size: 28, color: lavenderMist),
                  const SizedBox(width: 10),
                  const Text('MagnifierController',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                  'Manages the display and animation of the text magnifier overlay',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Controller', wisteria, Colors.white),
                tag('Overlay', orchid, Colors.white),
                tag('Animation', lavenderMist, deepAmethyst),
                tag('Text Selection', softLilac, deepAmethyst),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is MagnifierController',
            'Overlay lifecycle manager for the text magnifier',
            deepAmethyst, Colors.white),
        noteBox(
          'MagnifierController manages the lifecycle of a magnifier overlay — '
          'the zoomed loupe that appears when you drag a text selection '
          'handle on mobile. It controls when the magnifier appears in the '
          'Overlay, optionally drives an AnimationController for entrance '
          'and exit animations, and provides the shown status and the '
          'overlayEntry reference for paint-order management.',
          wisteria,
          crystalWhite,
        ),
        dataRow('Type', 'class (non-abstract)', wisteria),
        dataRow('Package', 'package:flutter/widgets.dart', orchid),
        dataRow('Source', 'magnifier.dart', royalViolet),
        dataRow('Purpose', 'Show/hide/animate the magnifier overlay', deepAmethyst),
        const SizedBox(height: 14),

        // ── 3. Constructor ───────────────────────────────────────────
        sectionBanner('2 \u00b7 Construction',
            'Creating with or without an AnimationController',
            royalViolet, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: crystalWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                      left: BorderSide(color: wisteria, width: 3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Without animation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: wisteria)),
                    const SizedBox(height: 4),
                    Text('MagnifierController()',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: royalViolet)),
                    const SizedBox(height: 4),
                    Text('Magnifier appears/disappears instantly — no fade',
                        style: TextStyle(fontSize: 12, color: deepAmethyst)),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                      left: BorderSide(color: orchid, width: 3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('With animation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: orchid)),
                    const SizedBox(height: 4),
                    Text('MagnifierController(animationController: ...)',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: royalViolet)),
                    const SizedBox(height: 4),
                    Text('AnimationController drives entrance/exit — value set to 0 on creation',
                        style: TextStyle(fontSize: 12, color: deepAmethyst)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Properties ────────────────────────────────────────────
        sectionBanner('3 \u00b7 Properties',
            'The three key properties of MagnifierController',
            wisteria, Colors.white),
        for (final prop in [
          ('shown', 'bool', 'Whether magnifier is currently visible',
              'True when overlayEntry != null AND animation is forward/completed',
              Icons.visibility, emeraldAccent),
          ('overlayEntry', 'OverlayEntry?', 'The magnifier\'s overlay entry',
              'Used to position other entries above/below the magnifier',
              Icons.layers, orchid),
          ('animationController', 'AnimationController?', 'Optional animation driver',
              'Drives fade-in on show() and fade-out on hide()',
              Icons.animation, wisteria),
        ])
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: crystalWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border(
                  left: BorderSide(color: prop.$6, width: 4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: prop.$6.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(prop.$5, size: 22, color: prop.$6),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(prop.$1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace',
                                  color: deepAmethyst)),
                          const SizedBox(width: 8),
                          tag(prop.$2, prop.$6.withValues(alpha: 0.1),
                              prop.$6),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(prop.$3,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: royalViolet)),
                      Text(prop.$4,
                          style: TextStyle(
                              fontSize: 11,
                              color: deepAmethyst.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 14),

        // ── 5. shown property states ─────────────────────────────────
        sectionBanner('4 \u00b7 The shown Property In Detail',
            'When shown is true vs false',
            deepAmethyst, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: crystalWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepAmethyst),
                children: [
                  for (final h in ['overlayEntry', 'AnimationStatus', 'shown'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11)),
                    ),
                ],
              ),
              for (final row in [
                ('null', 'any', false),
                ('non-null', 'null (no controller)', true),
                ('non-null', 'completed', true),
                ('non-null', 'forward', true),
                ('non-null', 'reverse', false),
                ('non-null', 'dismissed', false),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: row.$1 == 'null'
                                  ? Colors.grey
                                  : orchid)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: wisteria)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: row.$3
                              ? emeraldAccent.withValues(alpha: 0.12)
                              : pinkAccent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(row.$3 ? 'true' : 'false',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: row.$3
                                    ? emeraldAccent
                                    : pinkAccent)),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. show() method ─────────────────────────────────────────
        sectionBanner('5 \u00b7 show() Method',
            'Displaying the magnifier in the overlay',
            royalViolet, Colors.white),
        noteBox(
          'show() inserts a magnifier widget into the Overlay via a new '
          'OverlayEntry. It first removes any existing entry, captures the '
          'current InheritedTheme context, and creates the overlay. If an '
          'AnimationController is present, it drives forward() to animate in. '
          'The \'below\' parameter controls paint order in the Overlay.',
          orchid,
          crystalWhite,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: crystalWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final param in [
                ('context', 'BuildContext', 'Required — provides Overlay access', wisteria),
                ('builder', 'WidgetBuilder', 'Required — builds the magnifier widget', orchid),
                ('below', 'OverlayEntry?', 'Optional — insert below this entry', royalViolet),
                ('debugRequiredFor', 'Widget?', 'Optional — debug assertion helper', deepAmethyst),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: param.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(param.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: param.$4)),
                      ),
                      SizedBox(
                        width: 90,
                        child: Text(param.$2,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: lavenderMist)),
                      ),
                      Expanded(
                        child: Text(param.$3,
                            style: TextStyle(
                                fontSize: 11, color: deepAmethyst)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. hide() method ─────────────────────────────────────────
        sectionBanner('6 \u00b7 hide() Method',
            'Removing the magnifier from the overlay',
            wisteria, Colors.white),
        noteBox(
          'hide() reverses the animation (if present), then optionally '
          'removes the OverlayEntry. The removeFromOverlay parameter (default '
          'true) determines whether the entry is actually removed — set it '
          'to false if you need to preserve state between show/hide cycles.',
          wisteria,
          crystalWhite,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: crystalWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final scenario in [
                ('hide()', 'Animate out + remove from overlay', emeraldAccent, true),
                ('hide(removeFromOverlay: false)', 'Animate out but keep entry', goldAccent, false),
                ('removeFromOverlay()', 'Instant removal, no animation', pinkAccent, true),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: scenario.$3, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(scenario.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: deepAmethyst)),
                      const SizedBox(height: 4),
                      Text(scenario.$2,
                          style: TextStyle(fontSize: 12, color: royalViolet)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Lifecycle flow ────────────────────────────────────────
        sectionBanner('7 \u00b7 Lifecycle Flow',
            'Show → animate → position → hide sequence',
            deepAmethyst, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: crystalWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Create controller', 'MagnifierController(animationController: ...)',
                    deepAmethyst),
                (2, 'Call show()', 'Inserts OverlayEntry with magnifier widget',
                    royalViolet),
                (3, 'Capture themes', 'InheritedTheme.capture preserves inherited widgets',
                    wisteria),
                (4, 'Insert overlay', 'OverlayState.insert with optional below entry',
                    orchid),
                (5, 'Animate forward', 'AnimationController.forward() (if present)',
                    lavenderMist),
                (6, 'User interaction', 'Magnifier follows gesture via MagnifierInfo updates',
                    emeraldAccent),
                (7, 'Call hide()', 'AnimationController.reverse() + entry removal',
                    pinkAccent),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: step.$4,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${step.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: deepAmethyst)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 11, color: royalViolet)),
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

        // ── 9. Simulated magnifier display ───────────────────────────
        sectionBanner('8 \u00b7 Magnifier Visualization',
            'How a magnifier appears over text selection',
            orchid, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                deepAmethyst.withValues(alpha: 0.04),
                crystalWhite,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lavenderMist),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.zoom_in, size: 18, color: wisteria),
                  const SizedBox(width: 8),
                  Text('Text Selection with Magnifier',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: deepAmethyst)),
                ],
              ),
              const SizedBox(height: 12),
              // Simulate text with caret
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: lavenderMist),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('The quick brown fox jumps over the lazy dog',
                        style: TextStyle(fontSize: 14, color: deepAmethyst)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('The quick ',
                            style: TextStyle(fontSize: 14, color: deepAmethyst)),
                        Container(
                          width: 2,
                          height: 18,
                          color: wisteria,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          color: wisteria.withValues(alpha: 0.2),
                          child: Text('brown',
                              style: TextStyle(fontSize: 14, color: deepAmethyst)),
                        ),
                        Text(' fox jumps',
                            style: TextStyle(fontSize: 14, color: deepAmethyst)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Magnifier bubble
              Container(
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: wisteria, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: wisteria.withValues(alpha: 0.25),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text('brown',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: deepAmethyst)),
              ),
              const SizedBox(height: 6),
              Text('\u2191 Magnified text shown in overlay',
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: royalViolet)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Overlay paint order ──────────────────────────────────
        sectionBanner('9 \u00b7 Overlay Paint Order',
            'How the \'below\' parameter affects display',
            royalViolet, Colors.white),
        noteBox(
          'Content painted AFTER the magnifier in the Overlay will NOT '
          'appear inside the magnifier. Content painted BEFORE it (below '
          'in the overlay stack) WILL be visible through the lens. Use '
          'the \'below\' parameter in show() to insert the magnifier at '
          'the correct position for your content to be magnified.',
          royalViolet,
          crystalWhite,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: crystalWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final layer in [
                ('Above magnifier', 'NOT visible inside magnifier', pinkAccent, 4),
                ('Magnifier (OverlayEntry)', 'The lens itself', wisteria, 3),
                ('Below magnifier', 'VISIBLE inside magnifier', emeraldAccent, 2),
                ('App content', 'Root widget tree', deepAmethyst, 1),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: layer.$3.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: layer.$3, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: layer.$3.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('${layer.$4}',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: layer.$3)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(layer.$1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: deepAmethyst)),
                          Text(layer.$2,
                              style: TextStyle(
                                  fontSize: 11, color: royalViolet)),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Platform behavior ────────────────────────────────────
        sectionBanner('10 \u00b7 Platform Magnifier Styles',
            'iOS loupe vs Android magnifier',
            orchid, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: crystalWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: orchid),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.phone_iphone, size: 30, color: orchid),
                      const SizedBox(height: 6),
                      Text('iOS',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: deepAmethyst)),
                      const SizedBox(height: 4),
                      Text('CupertinoMagnifier',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: wisteria)),
                      const SizedBox(height: 4),
                      Text('Rounded loupe with shadow, follows finger above caret',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: royalViolet)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: emeraldAccent),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.phone_android,
                          size: 30, color: emeraldAccent),
                      const SizedBox(height: 6),
                      Text('Android',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: deepAmethyst)),
                      const SizedBox(height: 4),
                      Text('TextMagnifier',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: emeraldAccent)),
                      const SizedBox(height: 4),
                      Text('Rectangular lens above selection, auto-hiding on boundary',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: royalViolet)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Current controller state ─────────────────────────────
        sectionBanner('11 \u00b7 Current Controller State',
            'Live inspection of the demo controller',
            deepAmethyst, Colors.white),
        stateCard('shown', Icons.visibility_off,
            'shown = ${controller.shown} — no overlay entry yet',
            pinkAccent, false),
        stateCard('overlayEntry', Icons.layers_clear,
            'overlayEntry = ${controller.overlayEntry}',
            Colors.grey, false),
        stateCard('animationController', Icons.animation,
            'animationController = ${controller.animationController}',
            Colors.grey, false),
        const SizedBox(height: 14),

        // ── 13. Usage scenarios ──────────────────────────────────────
        sectionBanner('12 \u00b7 Usage Scenarios',
            'When MagnifierController is used in Flutter',
            wisteria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: crystalWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final scenario in [
                ('Text field selection', Icons.text_fields,
                    'Long-press and drag to select text shows magnifier', wisteria),
                ('Cursor positioning', Icons.edit,
                    'Dragging the cursor handle activates magnification', orchid),
                ('Custom selection', Icons.select_all,
                    'Custom SelectableRegion with magnifier support', royalViolet),
                ('Rich text editing', Icons.format_paint,
                    'Rich text editors use magnifier for precise selection', deepAmethyst),
                ('Accessibility', Icons.accessibility_new,
                    'Helps users see exact cursor position on small screens', emeraldAccent),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: scenario.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(scenario.$2, size: 20, color: scenario.$4),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scenario.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: deepAmethyst)),
                            Text(scenario.$3,
                                style: TextStyle(
                                    fontSize: 12, color: royalViolet)),
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

        // ── 14. Related classes ──────────────────────────────────────
        sectionBanner('13 \u00b7 Related Classes',
            'MagnifierController\'s ecosystem',
            orchid, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: crystalWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepAmethyst),
                children: [
                  for (final h in ['Class', 'Role'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11)),
                    ),
                ],
              ),
              for (final row in [
                ('MagnifierController', 'Manages overlay lifecycle + animation'),
                ('MagnifierInfo', 'Carries position data (gesture, caret, field)'),
                ('RawMagnifier', 'The actual magnifying lens widget'),
                ('MagnifierDecoration', 'Visual decoration for the magnifier'),
                ('TextMagnifier', 'Android-style magnifier implementation'),
                ('CupertinoMagnifier', 'iOS-style loupe implementation'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: row.$1 == 'MagnifierController'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontFamily: 'monospace',
                              color: row.$1 == 'MagnifierController'
                                  ? wisteria
                                  : deepAmethyst)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 11, color: royalViolet)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Inheritance ──────────────────────────────────────────
        sectionBanner('14 \u00b7 Class Structure',
            'MagnifierController is a standalone class',
            deepAmethyst, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: crystalWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', 0, Colors.grey),
                ('\u2514\u2500 MagnifierController', 1, wisteria),
              ])
                Padding(
                  padding: EdgeInsets.only(
                      left: level.$2 * 12.0, top: 4, bottom: 4),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          fontWeight: level.$2 == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: level.$3)),
                ),
              const SizedBox(height: 8),
              noteBox(
                'MagnifierController is a plain Dart class — not a Widget, '
                'not a ChangeNotifier. It manages an OverlayEntry directly '
                'and delegates animation to an optional AnimationController.',
                wisteria,
                softLilac,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepAmethyst, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepAmethyst, royalViolet],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Manages the lifecycle of a magnifier overlay for text selection',
                'show() inserts the magnifier with optional animation forward',
                'hide() reverses animation and optionally removes from overlay',
                'shown property combines overlayEntry state + animation direction',
                'overlayEntry reference enables paint-order management',
                'Optional AnimationController for smooth entrance/exit',
                'Used by TextField and SelectableText for mobile magnification',
                'Platform-specific: CupertinoMagnifier (iOS) vs TextMagnifier (Android)',
                'Works with MagnifierInfo to track gesture and caret positions',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lavenderMist,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
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

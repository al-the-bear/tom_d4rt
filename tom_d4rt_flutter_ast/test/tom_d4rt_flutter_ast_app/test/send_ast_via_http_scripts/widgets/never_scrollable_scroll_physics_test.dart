// ignore_for_file: avoid_print
// D4rt deep demo: NeverScrollableScrollPhysics — physics that disables all user scrolling
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Pistachio / Fern ──────────────────────────────────────
  const deepPistachio = Color(0xFF33691E);
  const pistachio = Color(0xFF558B2F);
  const fern = Color(0xFF689F38);
  const softPistachio = Color(0xFF7CB342);
  const lightFern = Color(0xFF9CCC65);
  const palePistachio = Color(0xFFF1F8E9);
  const whiteFern = Color(0xFFF7FBF0);
  const darkMoss = Color(0xFF1B3A08);
  const accentCoral = Color(0xFFE53935);
  const accentBlue = Color(0xFF1E88E5);

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
          style: TextStyle(fontSize: 13, color: darkMoss)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: darkMoss)),
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

  // ── Print diagnostics ──────────────────────────────────────────────
  print('NeverScrollableScrollPhysics deep demo executing');
  print('=' * 60);

  print('\n--- What is NeverScrollableScrollPhysics ---');
  print('A ScrollPhysics subclass that disables all user scrolling');
  print('Extends ScrollPhysics');
  print('allowUserScrolling returns false (always)');
  print('allowImplicitScrolling returns false (always)');

  final physics = NeverScrollableScrollPhysics();
  print('\n--- Properties ---');
  print('allowUserScrolling: ${physics.allowUserScrolling}');
  print('allowImplicitScrolling: ${physics.allowImplicitScrolling}');

  final chained = physics.applyTo(const BouncingScrollPhysics());
  print('\n--- Chaining ---');
  print('applyTo(BouncingScrollPhysics) creates chained physics');
  print('Even chained, user scrolling is still disabled');
  print('allowUserScrolling after chain: ${chained.allowUserScrolling}');

  print('\n--- Use cases ---');
  print('1. Fixed-content containers that should not scroll');
  print('2. PageView locked to programmatic navigation only');
  print('3. Scroll views controlled only by ScrollController');
  print('4. Grid displays with overflow clipping');

  print('\n${'=' * 60}');
  print('NeverScrollableScrollPhysics deep demo completed');

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
              colors: [deepPistachio, pistachio, fern],
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
                  Icon(Icons.lock, size: 28, color: palePistachio),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('NeverScrollableScrollPhysics',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('ScrollPhysics that completely blocks all user-initiated scrolling',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('ScrollPhysics', fern, Colors.white),
                tag('allowUserScrolling: false', softPistachio, darkMoss),
                tag('allowImplicitScrolling: false', lightFern, darkMoss),
                tag('const', palePistachio, darkMoss),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is NeverScrollableScrollPhysics',
            'The physics object that says: no scrolling allowed',
            deepPistachio, Colors.white),
        noteBox(
          'NeverScrollableScrollPhysics is a ScrollPhysics subclass that '
          'prevents all user-initiated scrolling. It overrides two key getters '
          '— allowUserScrolling and allowImplicitScrolling — to always return '
          'false. This means touch dragging, mouse wheel, keyboard scrolling, '
          'and accessibility-driven scrolling are all blocked. However, '
          'programmatic scrolling via a ScrollController still works.',
          pistachio,
          whiteFern,
        ),
        dataRow('Extends', 'ScrollPhysics', pistachio),
        dataRow('Constructor', 'const NeverScrollableScrollPhysics({parent})', deepPistachio),
        dataRow('allowUserScrolling', 'false (always)', accentCoral),
        dataRow('allowImplicitScrolling', 'false (always)', accentCoral),
        dataRow('Programmatic scroll', 'Still works via controller', accentBlue),
        const SizedBox(height: 14),

        // ── 3. The two blocked properties ────────────────────────────
        sectionBanner('2 \u00b7 The Two Blocked Properties',
            'What gets disabled and what still works',
            pistachio, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteFern,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentCoral.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentCoral, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.block, size: 26, color: accentCoral),
                      const SizedBox(height: 4),
                      Text('allowUserScrolling',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: accentCoral)),
                      const SizedBox(height: 4),
                      Text('= false',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: accentCoral)),
                      const SizedBox(height: 6),
                      Text('Blocks: touch drag,\nmouse wheel,\nkeyboard scroll,\naccessibility scroll',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkMoss)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentCoral.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentCoral, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.visibility_off, size: 26,
                          color: accentCoral),
                      const SizedBox(height: 4),
                      Text('allowImplicit\nScrolling',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: accentCoral)),
                      const SizedBox(height: 4),
                      Text('= false',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: accentCoral)),
                      const SizedBox(height: 6),
                      Text('Prevents: scroll-to-\nfocused-child,\nensureVisible,\nsemantics scroll',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkMoss)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Live demo: locked vs scrollable ───────────────────────
        sectionBanner('3 \u00b7 Live Demo: Locked vs Scrollable',
            'Side-by-side comparison',
            fern, Colors.white),
        SizedBox(
          height: 220,
          child: Row(
            children: [
              // Scrollable side
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: accentBlue, width: 2),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: accentBlue,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.touch_app, size: 16,
                                color: Colors.white),
                            const SizedBox(width: 6),
                            Text('Normal (scrollable)',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 20,
                          padding: const EdgeInsets.all(4),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: accentBlue.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text('Item ${index + 1}',
                                  style: TextStyle(
                                      fontSize: 11, color: darkMoss)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Locked side
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: accentCoral, width: 2),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: accentCoral,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.lock, size: 16,
                                color: Colors.white),
                            const SizedBox(width: 6),
                            Text('Never (locked)',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 20,
                          padding: const EdgeInsets.all(4),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: accentCoral.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text('Item ${index + 1}',
                                  style: TextStyle(
                                      fontSize: 11, color: darkMoss)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        noteBox(
          'Left: normal ListView scrolls freely. Right: NeverScrollableScrollPhysics '
          'prevents any scrolling — try dragging and nothing happens. Items below the '
          'clip boundary are invisible and unreachable.',
          fern,
          palePistachio,
        ),
        const SizedBox(height: 14),

        // ── 5. Constructor and chaining ──────────────────────────────
        sectionBanner('4 \u00b7 Constructor & applyTo Chaining',
            'How NeverScrollableScrollPhysics composes with others',
            deepPistachio, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteFern,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepPistachio.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepPistachio.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Basic usage\n'
                    'const NeverScrollableScrollPhysics()\n'
                    '\n'
                    '// With parent physics\n'
                    'const NeverScrollableScrollPhysics(\n'
                    '  parent: BouncingScrollPhysics(),\n'
                    ')\n'
                    '\n'
                    '// Via applyTo\n'
                    'NeverScrollableScrollPhysics()\n'
                    '  .applyTo(ClampingScrollPhysics())',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepPistachio)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'Even when chained with BouncingScrollPhysics or ClampingScrollPhysics, '
                'the NeverScrollableScrollPhysics still blocks all user input. The parent '
                'physics is only consulted for behaviors that Never... doesn\'t override '
                '(e.g., creating ballistic simulations for programmatic scrolls).',
                deepPistachio,
                palePistachio,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Live demo: locked grid view ───────────────────────────
        sectionBanner('5 \u00b7 Live Demo: Locked GridView',
            'A grid that displays but does not scroll',
            pistachio, Colors.white),
        SizedBox(
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              padding: const EdgeInsets.all(4),
              itemCount: 16,
              itemBuilder: (context, index) {
                final colors = [
                  deepPistachio, pistachio, fern, softPistachio,
                  lightFern, accentBlue,
                  accentCoral, darkMoss,
                ];
                final color = colors[index % colors.length];
                return Container(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: color, width: 1),
                  ),
                  child: Center(
                    child: Text('${index + 1}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: color)),
                  ),
                );
              },
            ),
          ),
        ),
        noteBox(
          'This GridView is locked with NeverScrollableScrollPhysics. It shows '
          'a fixed 4x4 grid that cannot be scrolled. Useful for dashboards '
          'or preview panels where content should not move.',
          pistachio,
          whiteFern,
        ),
        const SizedBox(height: 14),

        // ── 7. ScrollPhysics comparison table ────────────────────────
        sectionBanner('6 \u00b7 ScrollPhysics Comparison',
            'NeverScrollable vs other physics objects',
            fern, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteFern,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(4),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepPistachio),
                children: [
                  for (final h in ['Physics', 'User', 'Implicit'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('BouncingScrollPhysics', 'Yes', 'Yes'),
                ('ClampingScrollPhysics', 'Yes', 'Yes'),
                ('AlwaysScrollableScrollPhysics', 'Yes', 'Yes'),
                ('NeverScrollableScrollPhysics', 'No', 'No'),
                ('PageScrollPhysics', 'Yes', 'No'),
                ('RangeMaintainingScrollPhysics', 'Yes', 'Yes'),
              ])
                TableRow(
                  decoration: row.$1.startsWith('Never')
                      ? BoxDecoration(
                          color: accentCoral.withValues(alpha: 0.06))
                      : null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              fontWeight: row.$1.startsWith('Never')
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: row.$1.startsWith('Never')
                                  ? accentCoral
                                  : darkMoss)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: row.$2 == 'No'
                                  ? accentCoral
                                  : accentBlue)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: row.$3 == 'No'
                                  ? accentCoral
                                  : accentBlue)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Use case: embedded list inside another scrollable ─────
        sectionBanner('7 \u00b7 Use Case: Embedded Non-Scrollable List',
            'ListView inside a ScrollView with shrinkWrap',
            deepPistachio, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteFern,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightFern),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepPistachio.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepPistachio.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'SingleChildScrollView(\n'
                    '  child: Column(\n'
                    '    children: [\n'
                    '      HeaderWidget(),\n'
                    '      ListView(\n'
                    '        physics: NeverScrollableScrollPhysics(),\n'
                    '        shrinkWrap: true,\n'
                    '        children: items,\n'
                    '      ),\n'
                    '      FooterWidget(),\n'
                    '    ],\n'
                    '  ),\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepPistachio)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'The most common pattern: a ListView inside a SingleChildScrollView. '
                'NeverScrollableScrollPhysics + shrinkWrap makes the ListView behave '
                'like a static Column — it shows all items without its own scroll, '
                'while the outer SingleChildScrollView handles scrolling for the '
                'entire page.',
                deepPistachio,
                palePistachio,
              ),
              const SizedBox(height: 8),
              // Actual embedded list demo
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: pistachio.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: pistachio),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Embedded list demo:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: pistachio)),
                    const SizedBox(height: 4),
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        for (var i = 0; i < 5; i++)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: fern.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('Embedded item ${i + 1}',
                                style: TextStyle(
                                    fontSize: 11, color: darkMoss)),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Use case: locked PageView ─────────────────────────────
        sectionBanner('8 \u00b7 Use Case: Locked PageView',
            'PageView controlled only by buttons, not swipe',
            pistachio, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteFern,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 140,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (final page in [
                      ('Page 1', 'Locked — cannot swipe', deepPistachio,
                          Icons.looks_one),
                      ('Page 2', 'Only reachable via controller', pistachio,
                          Icons.looks_two),
                      ('Page 3', 'Programmatic navigation only', fern,
                          Icons.looks_3),
                    ])
                      Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: page.$3.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: page.$3, width: 2),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(page.$4, size: 30, color: page.$3),
                              const SizedBox(height: 6),
                              Text(page.$1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: page.$3)),
                              Text(page.$2,
                                  style: TextStyle(
                                      fontSize: 11, color: darkMoss)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              noteBox(
                'This PageView uses NeverScrollableScrollPhysics — swiping does '
                'nothing. Pages can only be changed via PageController.animateToPage() '
                'or jumpToPage(). Useful for step-by-step wizards where the user '
                'must complete a step before proceeding.',
                pistachio,
                palePistachio,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. What still works ─────────────────────────────────────
        sectionBanner('9 \u00b7 What Still Works',
            'Programmatic control is not affected',
            fern, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteFern,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final item in [
                ('ScrollController.animateTo()', 'Smooth animated scrolling '
                    'to a specific offset', Icons.play_arrow, accentBlue),
                ('ScrollController.jumpTo()', 'Instant jump to an offset '
                    'without animation', Icons.skip_next, accentBlue),
                ('Scrollable.ensureVisible()', 'Scroll to make a widget '
                    'visible (when called programmatically)', Icons.visibility, accentBlue),
                ('Touch / drag', 'BLOCKED — no response to user input',
                    Icons.block, accentCoral),
                ('Mouse wheel', 'BLOCKED — no scroll on wheel events',
                    Icons.block, accentCoral),
                ('Keyboard arrows', 'BLOCKED — no keyboard-driven scroll',
                    Icons.block, accentCoral),
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
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: item.$4)),
                            Text(item.$2,
                                style: TextStyle(
                                    fontSize: 10, color: darkMoss)),
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

        // ── 11. Physics resolution chain ─────────────────────────────
        sectionBanner('10 \u00b7 Physics Resolution Chain',
            'How Flutter resolves which physics to use',
            deepPistachio, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteFern,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Widget physics', 'physics property on ListView, etc.',
                    pistachio),
                (2, 'applyTo()', 'Chains widget physics with theme physics',
                    fern),
                (3, 'Theme physics', 'ScrollBehavior from MaterialApp',
                    softPistachio),
                (4, 'Platform default', 'Bouncing (iOS) or Clamping (Android)',
                    lightFern),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$4.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: step.$4,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text('${step.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
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
                                    fontSize: 11,
                                    color: darkMoss)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 10, color: darkMoss)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              noteBox(
                'NeverScrollableScrollPhysics at step 1 overrides everything. '
                'Its allowUserScrolling=false is checked first and blocks '
                'all user input regardless of parent physics in the chain.',
                deepPistachio,
                palePistachio,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Live demo: horizontal locked ─────────────────────────
        sectionBanner('11 \u00b7 Live Demo: Horizontal Locked List',
            'Horizontal ListView with no scroll',
            pistachio, Colors.white),
        SizedBox(
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                final hue = (index * 30.0) % 360;
                final color = HSVColor.fromAHSV(1.0, hue, 0.4, 0.8).toColor();
                return Container(
                  width: 80,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('${index + 1}',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: color)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        noteBox(
          'A horizontal ListView with NeverScrollableScrollPhysics — only the '
          'visible items (those that fit) are shown. Items beyond the right edge '
          'cannot be scrolled into view by the user.',
          pistachio,
          whiteFern,
        ),
        const SizedBox(height: 14),

        // ── 13. When NOT to use ──────────────────────────────────────
        sectionBanner('12 \u00b7 When NOT To Use',
            'Situations where NeverScrollableScrollPhysics is wrong',
            fern, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteFern,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final case_ in [
                ('Long scrollable content', 'Users need to reach content '
                    'below the fold. Locking scroll makes it inaccessible.',
                    Icons.warning_amber, Color(0xFFEF6C00)),
                ('Accessibility requirements', 'Screen readers need '
                    'allowImplicitScrolling for scroll semantics. Blocking '
                    'it reduces accessibility.',
                    Icons.accessibility, Color(0xFFEF6C00)),
                ('Just hiding scrollbar', 'Use scrollbarTheme or '
                    'ScrollbarThemeData instead. NeverScrollable blocks all scroll, '
                    'not just the visual indicator.',
                    Icons.horizontal_rule, Color(0xFFEF6C00)),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: case_.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: case_.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(case_.$3, size: 20, color: case_.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(case_.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkMoss)),
                            Text(case_.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkMoss)),
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

        // ── 14. Class hierarchy ──────────────────────────────────────
        sectionBanner('13 \u00b7 Class Hierarchy',
            'Inheritance chain', deepPistachio, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteFern,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', Colors.grey),
                ('\u2514\u2500 ScrollPhysics', softPistachio),
                ('    \u2514\u2500 NeverScrollableScrollPhysics', pistachio),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight:
                              level.$1.contains('NeverScrollable')
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          color: level.$2)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Class definition ─────────────────────────────────────
        sectionBanner('14 \u00b7 Class Definition',
            'The complete class', pistachio, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteFern,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepPistachio.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepPistachio.withValues(alpha: 0.3)),
            ),
            child: Text(
                'class NeverScrollableScrollPhysics\n'
                '    extends ScrollPhysics {\n'
                '  const NeverScrollableScrollPhysics({super.parent});\n'
                '\n'
                '  @override\n'
                '  NeverScrollableScrollPhysics applyTo(\n'
                '      ScrollPhysics? ancestor) {\n'
                '    return NeverScrollableScrollPhysics(\n'
                '        parent: buildParent(ancestor));\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  bool get allowUserScrolling => false;\n'
                '\n'
                '  @override\n'
                '  bool get allowImplicitScrolling => false;\n'
                '}',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: deepPistachio)),
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepPistachio, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepPistachio, pistachio],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Extends ScrollPhysics — disables all user-initiated scrolling',
                'allowUserScrolling and allowImplicitScrolling both return false',
                'Programmatic scrolling via ScrollController still works',
                'const constructor, composable via applyTo(parent)',
                'Classic use: ListView + shrinkWrap inside SingleChildScrollView',
                'Useful for locked PageViews controlled by buttons only',
                'Dashboard grids that show fixed content without scroll',
                'Even when chained with other physics, Never... always wins',
                'Does not block ScrollController.animateTo() or jumpTo()',
                'Be careful with accessibility — blocks implicit scrolling too',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightFern,
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

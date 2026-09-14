// ignore_for_file: avoid_print
// D4rt deep demo: NavigationMode — traditional vs directional navigation enum
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Cinnamon / Nutmeg ─────────────────────────────────────
  const deepCinnamon = Color(0xFF5D4037);
  const cinnamon = Color(0xFF795548);
  const nutmeg = Color(0xFF8D6E63);
  const warmSpice = Color(0xFFA1887F);
  const lightCinnamon = Color(0xFFBCAAA4);
  const paleCinnamon = Color(0xFFEFEBE9);
  const creamSpice = Color(0xFFFAF7F5);
  const darkEspresso = Color(0xFF3E2723);
  const sageGreen = Color(0xFF66BB6A);
  const blueTeal = Color(0xFF0097A7);

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
          style: TextStyle(fontSize: 13, color: darkEspresso)),
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
                style: TextStyle(fontSize: 13, color: darkEspresso)),
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
  print('NavigationMode deep demo executing');
  print('=' * 60);

  print('\n--- What is NavigationMode ---');
  print('Enum describing how navigation works in the application');
  print('Two values: traditional and directional');

  print('\n--- NavigationMode.traditional ---');
  print('Standard keyboard/mouse navigation');
  print('Disabled widgets cannot receive focus');
  print('Focus moves via Tab key or mouse clicks');

  print('\n--- NavigationMode.directional ---');
  print('Directional navigation for TV/gamepad interfaces');
  print('Disabled widgets retain focus for traversal');
  print('Focus moves via arrow keys (up/down/left/right)');

  print('\n--- Accessing NavigationMode ---');
  final mode = MediaQuery.navigationModeOf(context);
  print('Current mode: $mode');
  print('Access via MediaQuery.navigationModeOf(context)');

  print('\n${'=' * 60}');
  print('NavigationMode deep demo completed');

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
              colors: [deepCinnamon, cinnamon, nutmeg],
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
                  Icon(Icons.gamepad, size: 28, color: paleCinnamon),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('NavigationMode',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Enum controlling how navigation and focus work in different input environments',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Enum', nutmeg, Colors.white),
                tag('MediaQuery', warmSpice, darkEspresso),
                tag('Focus Traversal', lightCinnamon, darkEspresso),
                tag('Accessibility', paleCinnamon, darkEspresso),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is NavigationMode',
            'An enum that describes the app\'s navigation paradigm',
            deepCinnamon, Colors.white),
        noteBox(
          'NavigationMode is an enum in Flutter\'s MediaQuery system that '
          'describes how the user navigates through the UI. It determines '
          'whether disabled widgets can receive focus and how focus traversal '
          'works. The current mode is stored in MediaQueryData and accessed '
          'via MediaQuery.navigationModeOf(context).',
          cinnamon,
          creamSpice,
        ),
        dataRow('Type', 'enum', cinnamon),
        dataRow('Values', 'traditional, directional', deepCinnamon),
        dataRow('Defined in', 'widgets/media_query.dart', darkEspresso),
        dataRow('Access', 'MediaQuery.navigationModeOf(context)', nutmeg),
        const SizedBox(height: 14),

        // ── 3. The two values ────────────────────────────────────────
        sectionBanner('2 \u00b7 The Two Values',
            'Traditional vs directional navigation',
            cinnamon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Traditional
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: sageGreen.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: sageGreen, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.mouse, size: 28, color: sageGreen),
                      const SizedBox(height: 6),
                      Text('traditional',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'monospace',
                              color: sageGreen)),
                      const SizedBox(height: 6),
                      Text('Keyboard + Mouse',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: darkEspresso)),
                      const SizedBox(height: 4),
                      Text('Standard desktop and mobile input. Tab to move focus. '
                          'Disabled widgets lose focus and cannot be reached.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkEspresso)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Directional
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: blueTeal.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: blueTeal, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.gamepad, size: 28, color: blueTeal),
                      const SizedBox(height: 6),
                      Text('directional',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'monospace',
                              color: blueTeal)),
                      const SizedBox(height: 6),
                      Text('TV Remote + Gamepad',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: darkEspresso)),
                      const SizedBox(height: 4),
                      Text('Arrow-key navigation for lean-back UIs. Disabled widgets '
                          'retain focus for traversal continuity.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkEspresso)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Behavior comparison ───────────────────────────────────
        sectionBanner('3 \u00b7 Behavior Comparison',
            'How each mode affects focus and navigation',
            nutmeg, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepCinnamon),
                children: [
                  for (final h in ['Behavior', 'Traditional', 'Directional'])
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
                ('Disabled widget focus', 'Loses focus', 'Retains focus'),
                ('Focus navigation', 'Tab / Shift+Tab', 'Arrow keys'),
                ('Primary input', 'Mouse + Keyboard', 'Remote / Gamepad'),
                ('Activation', 'Click / Enter', 'Select button'),
                ('Focus indicator', 'Standard ring', 'Always visible'),
                ('Scroll behavior', 'Mouse wheel', 'Focus-driven'),
                ('Typical platform', 'Desktop / Mobile', 'Android TV / tvOS'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: cinnamon)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: sageGreen)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: blueTeal)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. How to access ─────────────────────────────────────────
        sectionBanner('4 \u00b7 How To Access NavigationMode',
            'Reading the current mode from MediaQuery',
            deepCinnamon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cinnamon.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: cinnamon.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Read the current navigation mode\n'
                    'final mode = MediaQuery.navigationModeOf(context);\n\n'
                    '// Check for directional mode\n'
                    'if (mode == NavigationMode.directional) {\n'
                    '  // TV/gamepad navigation active\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepCinnamon)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'navigationModeOf() is a static convenience method that reads '
                'from the nearest MediaQuery ancestor. It subscribes only to '
                'navigation mode changes, not all MediaQuery changes.',
                deepCinnamon,
                paleCinnamon,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Current value display ─────────────────────────────────
        sectionBanner('5 \u00b7 Live Value',
            'Current NavigationMode in this context',
            cinnamon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightCinnamon),
          ),
          child: Row(
            children: [
              Icon(
                mode == NavigationMode.traditional
                    ? Icons.mouse
                    : Icons.gamepad,
                size: 32,
                color: mode == NavigationMode.traditional
                    ? sageGreen
                    : blueTeal,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NavigationMode.$mode',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'monospace',
                            color: deepCinnamon)),
                    Text(mode == NavigationMode.traditional
                        ? 'Standard keyboard/mouse navigation is active'
                        : 'Directional TV/gamepad navigation is active',
                        style: TextStyle(
                            fontSize: 12, color: darkEspresso)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Disabled widget focus ─────────────────────────────────
        sectionBanner('6 \u00b7 Disabled Widget Focus Behavior',
            'The key difference between the two modes',
            nutmeg, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // Traditional
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: sageGreen.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                      left: BorderSide(color: sageGreen, width: 3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mouse, size: 18, color: sageGreen),
                        const SizedBox(width: 6),
                        Text('Traditional Mode',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: sageGreen)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Enabled'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: null,
                          child: const Text('Disabled'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Disabled button cannot receive focus — Tab skips it',
                        style: TextStyle(
                            fontSize: 10, color: darkEspresso)),
                  ],
                ),
              ),
              // Directional
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: blueTeal.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                      left: BorderSide(color: blueTeal, width: 3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.gamepad, size: 18, color: blueTeal),
                        const SizedBox(width: 6),
                        Text('Directional Mode',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: blueTeal)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Disabled widgets retain focus so arrow navigation '
                        'maintains spatial continuity. Without this, disabled '
                        'items would create "holes" in the focus grid.',
                        style: TextStyle(
                            fontSize: 11, color: darkEspresso)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Setting NavigationMode ────────────────────────────────
        sectionBanner('7 \u00b7 Setting NavigationMode',
            'How to configure it for your application',
            deepCinnamon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepCinnamon.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepCinnamon.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Wrap your app with MediaQuery override\n'
                    'MediaQuery(\n'
                    '  data: MediaQuery.of(context).copyWith(\n'
                    '    navigationMode: NavigationMode.directional,\n'
                    '  ),\n'
                    '  child: MyApp(),\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepCinnamon)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'NavigationMode is part of MediaQueryData. To change it, wrap '
                'your widget tree with a MediaQuery that copies the existing data '
                'with the desired navigation mode.',
                deepCinnamon,
                paleCinnamon,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. TV navigation grid ────────────────────────────────────
        sectionBanner('8 \u00b7 TV Navigation Grid Scenario',
            'How directional mode enables spatial navigation',
            blueTeal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightCinnamon),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Grid of TV menu items — arrow keys to navigate:',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: blueTeal)),
              const SizedBox(height: 8),
              for (var row = 0; row < 3; row++)
                Padding(
                  padding: EdgeInsets.only(top: row > 0 ? 6 : 0),
                  child: Row(
                    children: [
                      for (var col = 0; col < 4; col++)
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: col > 0 ? 6 : 0),
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: (row == 1 && col == 2)
                                    ? [blueTeal, blueTeal.withValues(alpha: 0.8)]
                                    : [
                                        Color.lerp(
                                                cinnamon,
                                                nutmeg,
                                                (row * 4 + col) / 11.0) ??
                                            cinnamon,
                                        Color.lerp(
                                                nutmeg,
                                                warmSpice,
                                                (row * 4 + col) / 11.0) ??
                                            nutmeg,
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: (row == 1 && col == 2)
                                  ? Border.all(color: Colors.white, width: 2)
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  [
                                    Icons.tv,
                                    Icons.movie,
                                    Icons.music_note,
                                    Icons.photo,
                                    Icons.sports_esports,
                                    Icons.settings,
                                    Icons.search,
                                    Icons.person,
                                    Icons.favorite,
                                    Icons.bookmark,
                                    Icons.history,
                                    Icons.star,
                                  ][row * 4 + col],
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Text(
                                  [
                                    'TV',
                                    'Films',
                                    'Music',
                                    'Photos',
                                    'Games',
                                    'Settings',
                                    'Search',
                                    'Profile',
                                    'Likes',
                                    'Saved',
                                    'History',
                                    'Top',
                                  ][row * 4 + col],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: (row == 1 && col == 2)
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_upward, size: 14, color: blueTeal),
                  Icon(Icons.arrow_downward, size: 14, color: blueTeal),
                  Icon(Icons.arrow_back, size: 14, color: blueTeal),
                  Icon(Icons.arrow_forward, size: 14, color: blueTeal),
                  const SizedBox(width: 6),
                  Text('D-pad navigation',
                      style: TextStyle(
                          fontSize: 10, color: darkEspresso)),
                ],
              ),
            ],
          ),
        ),
        noteBox(
          'In directional mode, arrow keys navigate the grid spatially. '
          'The highlighted item (Search) can be reached from any neighbor. '
          'Even disabled items stay in the grid so navigation remains predictable.',
          blueTeal,
          creamSpice,
        ),
        const SizedBox(height: 14),

        // ── 10. Platform defaults ────────────────────────────────────
        sectionBanner('9 \u00b7 Platform Defaults',
            'Which platforms use which mode',
            cinnamon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final platform in [
                ('Android', Icons.phone_android, 'traditional', sageGreen),
                ('iOS', Icons.phone_iphone, 'traditional', sageGreen),
                ('macOS', Icons.laptop_mac, 'traditional', sageGreen),
                ('Windows', Icons.desktop_windows, 'traditional', sageGreen),
                ('Linux', Icons.computer, 'traditional', sageGreen),
                ('Web', Icons.language, 'traditional', sageGreen),
                ('Android TV', Icons.tv, 'directional', blueTeal),
                ('tvOS / Apple TV', Icons.connected_tv, 'directional', blueTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: platform.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(platform.$2, size: 18, color: platform.$4),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 100,
                        child: Text(platform.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: darkEspresso)),
                      ),
                      Text(platform.$3,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: platform.$4)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Focus traversal details ──────────────────────────────
        sectionBanner('10 \u00b7 Focus Traversal Details',
            'How focus moves in each mode',
            nutmeg, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final detail in [
                ('Tab key', 'Moves to next focusable node',
                    'Not typically used', Icons.tab, cinnamon),
                ('Shift+Tab', 'Moves to previous node',
                    'Not typically used', Icons.tab, nutmeg),
                ('Arrow Up', 'Not standard traversal',
                    'Moves to nearest node above', Icons.arrow_upward, deepCinnamon),
                ('Arrow Down', 'Not standard traversal',
                    'Moves to nearest node below', Icons.arrow_downward, warmSpice),
                ('Arrow Left', 'Not standard traversal',
                    'Moves to nearest node left', Icons.arrow_back, lightCinnamon),
                ('Arrow Right', 'Not standard traversal',
                    'Moves to nearest node right', Icons.arrow_forward, darkEspresso),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: detail.$5, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(detail.$4, size: 16, color: detail.$5),
                      const SizedBox(width: 6),
                      SizedBox(
                        width: 70,
                        child: Text(detail.$1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: detail.$5)),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(detail.$2,
                                  style: TextStyle(
                                      fontSize: 9, color: sageGreen)),
                            ),
                            Expanded(
                              child: Text(detail.$3,
                                  style: TextStyle(
                                      fontSize: 9, color: blueTeal)),
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
        const SizedBox(height: 14),

        // ── 12. MediaQuery integration ───────────────────────────────
        sectionBanner('11 \u00b7 MediaQuery Integration',
            'How NavigationMode fits in MediaQueryData',
            deepCinnamon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final field in [
                ('size', 'Screen dimensions', cinnamon),
                ('devicePixelRatio', 'Pixel density', nutmeg),
                ('padding', 'Safe area insets', warmSpice),
                ('viewInsets', 'Keyboard insets', lightCinnamon),
                ('platformBrightness', 'Light/dark mode', deepCinnamon),
                ('textScaler', 'Text size scaling', darkEspresso),
                ('navigationMode', 'Traditional or directional', blueTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: field.$1 == 'navigationMode'
                        ? blueTeal.withValues(alpha: 0.06)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: field.$1 == 'navigationMode'
                        ? Border.all(color: blueTeal, width: 2)
                        : Border(
                            left: BorderSide(
                                color: field.$3, width: 2)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(field.$1,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                fontWeight: field.$1 == 'navigationMode'
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: field.$3)),
                      ),
                      Expanded(
                        child: Text(field.$2,
                            style: TextStyle(
                                fontSize: 11, color: darkEspresso)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Widgets that check NavigationMode ────────────────────
        sectionBanner('12 \u00b7 Widgets That Check NavigationMode',
            'Framework widgets that adapt based on mode',
            cinnamon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final widget in [
                ('Focus', 'Skips disabled nodes in traditional, includes them in directional',
                    Icons.center_focus_strong, deepCinnamon),
                ('FocusTraversalGroup', 'Policy adapts traversal order per mode',
                    Icons.account_tree, cinnamon),
                ('Actions', 'Some actions only active in specific modes',
                    Icons.touch_app, nutmeg),
                ('Shortcuts', 'Arrow key shortcuts enabled in directional mode',
                    Icons.keyboard, warmSpice),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: widget.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(widget.$3, size: 20, color: widget.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: widget.$4)),
                            Text(widget.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkEspresso)),
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

        // ── 14. Live demo: focus row ─────────────────────────────────
        sectionBanner('13 \u00b7 Live Demo: Focus Row',
            'Buttons showing enabled and disabled states',
            nutmeg, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightCinnamon),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current mode: ${mode.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: deepCinnamon)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: sageGreen),
                    child: const Text('Enabled 1'),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: const Text('Disabled'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: cinnamon),
                    child: const Text('Enabled 2'),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: const Text('Disabled'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blueTeal),
                    child: const Text('Enabled 3'),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(mode == NavigationMode.traditional
                  ? 'In traditional mode: Tab skips disabled buttons'
                  : 'In directional mode: arrows can reach disabled buttons',
                  style: TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                      color: darkEspresso)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Enum definition ──────────────────────────────────────
        sectionBanner('14 \u00b7 Enum Definition',
            'The complete enum as defined in the SDK',
            deepCinnamon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamSpice,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepCinnamon.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepCinnamon.withValues(alpha: 0.3)),
            ),
            child: Text(
                'enum NavigationMode {\n'
                '  /// Default mode — Tab/mouse navigation.\n'
                '  /// Disabled widgets cannot receive focus.\n'
                '  traditional,\n'
                '\n'
                '  /// Arrow-key navigation for TV/gamepad.\n'
                '  /// Disabled widgets retain focus.\n'
                '  directional,\n'
                '}',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: deepCinnamon)),
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepCinnamon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepCinnamon, cinnamon],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Enum with two values: traditional and directional',
                'Part of MediaQueryData, accessed via MediaQuery.navigationModeOf()',
                'Traditional: keyboard + mouse, disabled widgets lose focus',
                'Directional: TV remote + gamepad, disabled widgets retain focus',
                'Ensures spatial navigation continuity for lean-back UIs',
                'Arrow keys are primary navigation in directional mode',
                'Default is traditional on all desktop/mobile platforms',
                'Directional used on Android TV, tvOS, and similar',
                'Focus, FocusTraversalGroup, Actions adapt to the mode',
                'Set via MediaQuery.copyWith(navigationMode: ...)',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightCinnamon,
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

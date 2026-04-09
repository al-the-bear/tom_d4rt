// ignore_for_file: avoid_print
// D4rt deep demo: ThemeMode — controls whether the MaterialApp uses
// light theme, dark theme, or follows the system brightness setting.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ThemeMode deep demo executing');
  print('=' * 60);

  for (final v in ThemeMode.values) {
    print('  ${v.name} (index ${v.index})');
  }
  print('Total values: ${ThemeMode.values.length}');
  print('=' * 60);

  // ── colour palette ──────────────────────────────────────────
  const tmPrimary = Color(0xFF37474F);   // charcoal
  const tmAccent = Color(0xFF90A4AE);    // silver
  const tmLight = Color(0xFFECEFF1);     // pale silver
  const tmDark = Color(0xFF1C2830);      // deep charcoal
  const tmSurface = Color(0xFFFAFAFA);
  const tmOnSurface = Color(0xFF263238);
  const tmMuted = Color(0xFF607D8B);

  // Light theme sample colours
  const ltBg = Color(0xFFF5F5F5);
  const ltCard = Color(0xFFFFFFFF);
  const ltText = Color(0xFF212121);
  const ltAccent = Color(0xFF1976D2);

  // Dark theme sample colours
  const dkBg = Color(0xFF121212);
  const dkCard = Color(0xFF1E1E1E);
  const dkText = Color(0xFFE0E0E0);
  const dkAccent = Color(0xFF82B1FF);

  // ── data ────────────────────────────────────────────────────
  final List<Map<String, String>> tmModes = [
    {
      'value': 'system',
      'title': 'System',
      'icon': '🔄',
      'desc': 'Follows the platform brightness setting. On Android, '
          'this respects the system dark mode toggle; on iOS, it '
          'follows the Appearance setting. When the platform switches, '
          'the app transitions automatically.',
      'resolves': 'Light OR Dark depending on platform setting',
      'parameter': 'Uses theme when light, darkTheme when dark',
      'default': 'Default for MaterialApp.themeMode',
    },
    {
      'value': 'light',
      'title': 'Light',
      'icon': '☀',
      'desc': 'Always uses the light theme, regardless of platform '
          'brightness. The app will display MaterialApp.theme even '
          'if the operating system is in dark mode.',
      'resolves': 'Always MaterialApp.theme (light)',
      'parameter': 'Ignores darkTheme entirely',
      'default': 'Common for apps without dark mode support',
    },
    {
      'value': 'dark',
      'title': 'Dark',
      'icon': '🌙',
      'desc': 'Always uses the dark theme, regardless of platform '
          'brightness. The app will display MaterialApp.darkTheme '
          'even if the OS is in light mode. Falls back to theme if '
          'darkTheme is not provided.',
      'resolves': 'Always MaterialApp.darkTheme (dark)',
      'parameter': 'Uses darkTheme, fallback to theme',
      'default': 'Used in user-preference dark mode',
    },
  ];

  // ── helpers ─────────────────────────────────────────────────
  Widget tmSection(String title, {Widget? child, List<Widget>? children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tmAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: tmPrimary.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tmPrimary, tmDark],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child ??
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children ?? []),
          ),
        ],
      ),
    );
  }

  Widget tmLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: tmOnSurface)),
    );
  }

  Widget tmBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: tmMuted, height: 1.5)),
    );
  }

  Widget tmChip(String label, {Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? tmLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tmAccent.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget tmDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: tmAccent.withValues(alpha: 0.2), height: 1),
    );
  }

  // Mini app preview rendered in a theme context
  Widget tmAppPreview({
    required String label,
    required Color bg,
    required Color cardBg,
    required Color textColor,
    required Color accentColor,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tmAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: tmPrimary.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fake app bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            color: accentColor,
            child: Row(
              children: [
                Icon(Icons.arrow_back, size: 16, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                ),
                Icon(Icons.more_vert, size: 16, color: Colors.white),
              ],
            ),
          ),
          // Body area
          Container(
            width: double.infinity,
            color: bg,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sample Card',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: textColor)),
                      const SizedBox(height: 4),
                      Text('Content text on $label surface',
                          style: TextStyle(
                              fontSize: 11, color: textColor.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Action row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Button',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: accentColor),
                      ),
                      child: Text('Outline',
                          style: TextStyle(
                              color: accentColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: textColor.withValues(alpha: 0.5))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Colour swatch
  Widget tmSwatch(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: tmAccent.withValues(alpha: 0.3)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ),
          Text('#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
              style: TextStyle(fontSize: 11, color: tmMuted, fontFamily: 'monospace')),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // BUILD
  // ══════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    child: Container(
      color: tmSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Title Banner ──────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 42, 24, 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [tmDark, tmPrimary, tmAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ThemeMode',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  'Controls whether the app uses the light theme, '
                  'dark theme, or follows the operating system setting.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    tmChip('enum', bg: Colors.white.withValues(alpha: 0.2)),
                    tmChip('MaterialApp',
                        bg: Colors.white.withValues(alpha: 0.2)),
                    tmChip('brightness',
                        bg: Colors.white.withValues(alpha: 0.2)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 2. Enum Overview ─────────────────────────────────
          tmSection('Enum Overview',
            children: [
              tmBody(
                'ThemeMode is a simple three-value enum that tells '
                'MaterialApp how to resolve its active ThemeData. '
                'It interacts with three MaterialApp parameters: '
                'theme (light), darkTheme, and themeMode.'),
              tmBody(
                'The default is ThemeMode.system, which follows the '
                'platform brightness. This allows the OS dark-mode '
                'toggle to control the app appearance automatically.'),
              Wrap(
                children: [
                  for (final v in ThemeMode.values)
                    tmChip(v.name),
                ],
              ),
            ],
          ),

          // ── 3. Individual Value Cards ────────────────────────
          for (final m in tmModes)
            tmSection('${m['icon']}  ${m['title']}',
              children: [
                tmLabel('Value'),
                tmChip('ThemeMode.${m['value']}'),
                const SizedBox(height: 8),
                tmLabel('Description'),
                tmBody(m['desc']!),
                tmLabel('Theme Resolution'),
                tmBody(m['resolves']!),
                tmLabel('Parameter Behaviour'),
                tmBody(m['parameter']!),
                tmLabel('Typical Usage'),
                tmBody(m['default']!),
              ],
            ),

          // ── 4. Live Theme Previews ───────────────────────────
          tmSection('Live Theme Previews',
            children: [
              tmBody(
                'Each preview shows the same mini app rendered under '
                'the corresponding theme mode. Notice the surface '
                'colours, text contrast, and button styles:'),
              tmAppPreview(
                label: 'Light Mode',
                bg: ltBg,
                cardBg: ltCard,
                textColor: ltText,
                accentColor: ltAccent,
                subtitle: 'ThemeMode.light — always uses MaterialApp.theme',
              ),
              tmAppPreview(
                label: 'Dark Mode',
                bg: dkBg,
                cardBg: dkCard,
                textColor: dkText,
                accentColor: dkAccent,
                subtitle: 'ThemeMode.dark — always uses MaterialApp.darkTheme',
              ),
              tmAppPreview(
                label: 'System Mode',
                bg: ltBg,
                cardBg: ltCard,
                textColor: ltText,
                accentColor: const Color(0xFF00897B),
                subtitle: 'ThemeMode.system — resolved to light (current platform)',
              ),
            ],
          ),

          // ── 5. Surface Colour Palettes ───────────────────────
          tmSection('Surface Colour Comparison',
            children: [
              tmBody(
                'The main difference between light and dark themes is '
                'the surface, background, and text colours:'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ltBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: tmAccent.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Light Theme',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: ltText)),
                          const SizedBox(height: 8),
                          tmSwatch('Background', ltBg),
                          tmSwatch('Card', ltCard),
                          tmSwatch('Primary Text', ltText),
                          tmSwatch('Accent', ltAccent),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: dkBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: tmAccent.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Dark Theme',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: dkText)),
                          const SizedBox(height: 8),
                          tmSwatch('Background', dkBg),
                          tmSwatch('Card', dkCard),
                          tmSwatch('Primary Text', dkText),
                          tmSwatch('Accent', dkAccent),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── 6. Component Gallery ─────────────────────────────
          tmSection('Component Appearance by Mode',
            children: [
              tmBody(
                'Flutter automatically adapts Material component '
                'surfaces, icon colours, and text contrast based on '
                'the resolved brightness:'),
              for (final comp in [
                {
                  'name': 'AppBar',
                  'light': 'White surface, dark text, light elevation shadow',
                  'dark': 'Dark surface (#1E1E1E), white text, no visible shadow',
                },
                {
                  'name': 'Card',
                  'light': 'White background, subtle shadow on light surface',
                  'dark': 'Dark (#2C2C2C) with lighter elevation overlay',
                },
                {
                  'name': 'TextField',
                  'light': 'Dark input text, grey label on white fill',
                  'dark': 'White input text, light grey label on dark fill',
                },
                {
                  'name': 'Switch / Checkbox',
                  'light': 'Primary accent on white track',
                  'dark': 'Lighter accent on dark track',
                },
                {
                  'name': 'ElevatedButton',
                  'light': 'Primary coloured surface with white text',
                  'dark': 'Lighter accent surface with dark text',
                },
                {
                  'name': 'Divider',
                  'light': 'Light grey line on white surface',
                  'dark': 'Subtle grey line on dark surface',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tmLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comp['name']!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFC107),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text('Light: ${comp['light']}',
                                style: TextStyle(
                                    fontSize: 11, color: tmMuted)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF5C6BC0),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text('Dark: ${comp['dark']}',
                                style: TextStyle(
                                    fontSize: 11, color: tmMuted)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 7. MaterialApp Parameters ────────────────────────
          tmSection('MaterialApp Parameter Relationships',
            children: [
              tmBody(
                'ThemeMode resolves to either theme or darkTheme at '
                'runtime. Here is how the three parameters interact:'),
              SizedBox(
                width: double.infinity,
                child: Table(
                  border: TableBorder.all(
                      color: tmAccent.withValues(alpha: 0.3), width: 1),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      decoration:
                          BoxDecoration(color: tmPrimary.withValues(alpha: 0.1)),
                      children: [
                        for (final h in ['Parameter', 'Purpose'])
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(h,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11)),
                          ),
                      ],
                    ),
                    for (final row in [
                      ['theme', 'The ThemeData to use when light brightness is resolved'],
                      ['darkTheme', 'The ThemeData to use when dark brightness is resolved'],
                      ['themeMode', 'Controls which brightness is resolved (system/light/dark)'],
                      ['highContrastTheme', 'High contrast override for light (accessibility)'],
                      ['highContrastDarkTheme', 'High contrast override for dark (accessibility)'],
                    ])
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(row[0],
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'monospace',
                                    color: tmDark)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(row[1],
                                style: TextStyle(
                                    fontSize: 11, color: tmMuted)),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 8. Platform Brightness Detection ─────────────────
          tmSection('Platform Brightness Detection',
            children: [
              tmBody(
                'When ThemeMode.system is active, Flutter reads the '
                'platform brightness to decide which theme to apply. '
                'This value comes from the host operating system:'),
              for (final platform in [
                {
                  'os': 'Android',
                  'setting': 'Settings → Display → Dark theme',
                  'api': 'platformBrightness from system',
                },
                {
                  'os': 'iOS',
                  'setting': 'Settings → Display & Brightness → Appearance',
                  'api': 'UITraitCollection.userInterfaceStyle',
                },
                {
                  'os': 'Web',
                  'setting': 'Browser / OS dark mode preference',
                  'api': 'prefers-color-scheme media query',
                },
                {
                  'os': 'Desktop (macOS)',
                  'setting': 'System Preferences → Appearance',
                  'api': 'NSApplication.effectiveAppearance',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tmLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(platform['os']!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 3),
                      Text('Setting: ${platform['setting']}',
                          style: TextStyle(fontSize: 11, color: tmMuted)),
                      Text('Source: ${platform['api']}',
                          style: TextStyle(fontSize: 11, color: tmMuted)),
                    ],
                  ),
                ),
              tmDivider(),
              tmBody(
                'Access the current brightness in code via: '
                'MediaQuery.platformBrightnessOf(context). '
                'This returns Brightness.light or Brightness.dark.'),
            ],
          ),

          // ── 9. ThemeData Brightness Anatomy ──────────────────
          tmSection('ThemeData Brightness Anatomy',
            children: [
              tmBody(
                'Each ThemeData has a brightness property that affects '
                'the default colours of all Material components:'),
              for (final prop in [
                ['brightness', 'Brightness.light or Brightness.dark — master switch'],
                ['colorScheme', 'Complete colour system derived from brightness'],
                ['scaffoldBackgroundColor', 'Background for Scaffold widget'],
                ['cardColor', 'Default Card surface colour'],
                ['dialogBackgroundColor', 'Dialog surface colour'],
                ['dividerColor', 'Colour for Divider widgets'],
                ['textTheme', 'Text styles with appropriate contrast colours'],
                ['iconTheme', 'Icon colours and sizes for the brightness'],
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 5, right: 8),
                        decoration: BoxDecoration(
                          color: tmPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 175,
                        child: Text(prop[0],
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace')),
                      ),
                      Expanded(
                        child: Text(prop[1],
                            style: TextStyle(fontSize: 11, color: tmMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 10. Dynamic Switching Pattern ────────────────────
          tmSection('Dynamic Theme Switching UX Pattern',
            children: [
              tmBody(
                'Most apps offer a settings screen where users choose '
                'their preferred theme mode. The typical pattern stores '
                'the user preference and rebuilds the MaterialApp:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tmLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final step in [
                      '1. Store ThemeMode in shared_preferences / Hive',
                      '2. Read saved preference on app startup',
                      '3. Pass saved ThemeMode to MaterialApp.themeMode',
                      '4. Provide settings UI with 3-option toggle:',
                      '   ☀ Light  |  🔄 System  |  🌙 Dark',
                      '5. On user selection → save + rebuild MaterialApp',
                      '6. App immediately transitions to chosen mode',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(step,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Visual toggle simulation
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tmLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Settings → Appearance',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (final opt in [
                          {'label': 'Light', 'icon': Icons.wb_sunny, 'active': false},
                          {'label': 'System', 'icon': Icons.settings_brightness, 'active': true},
                          {'label': 'Dark', 'icon': Icons.nightlight_round, 'active': false},
                        ])
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: (opt['active'] as bool)
                                  ? tmPrimary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: tmAccent.withValues(alpha: 0.4)),
                            ),
                            child: Row(
                              children: [
                                Icon(opt['icon'] as IconData,
                                    size: 16,
                                    color: (opt['active'] as bool)
                                        ? Colors.white
                                        : tmMuted),
                                const SizedBox(width: 6),
                                Text(opt['label'] as String,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: (opt['active'] as bool)
                                            ? Colors.white
                                            : tmOnSurface)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ── 11. High Contrast Accessibility ──────────────────
          tmSection('High Contrast Accessibility',
            children: [
              tmBody(
                'MaterialApp supports high-contrast theme overrides '
                'for users with vision impairments. These activate '
                'automatically when the OS high-contrast mode is on:'),
              for (final item in [
                {
                  'param': 'highContrastTheme',
                  'when': 'System high-contrast + ThemeMode resolves light',
                  'tip': 'Increase contrast ratios to 7:1 or higher',
                },
                {
                  'param': 'highContrastDarkTheme',
                  'when': 'System high-contrast + ThemeMode resolves dark',
                  'tip': 'Use pure white text on pure black for maximum contrast',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tmLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: tmAccent.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['param']!,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace')),
                      const SizedBox(height: 3),
                      Text('When: ${item['when']}',
                          style: TextStyle(fontSize: 11, color: tmMuted)),
                      Text('Tip: ${item['tip']}',
                          style: TextStyle(fontSize: 11, color: tmMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 12. Common Pitfalls ──────────────────────────────
          tmSection('Common Pitfalls',
            children: [
              for (final pit in [
                {
                  'title': 'Missing darkTheme',
                  'detail':
                      'If ThemeMode.dark is set but darkTheme is null, '
                      'Flutter falls back to theme (light). This produces '
                      'a light appearance despite the dark mode setting.',
                },
                {
                  'title': 'Hard-coded colours',
                  'detail':
                      'Using Color(0xFFFFFFFF) instead of '
                      'Theme.of(context).colorScheme.surface breaks '
                      'dark mode. Always derive colours from ThemeData.',
                },
                {
                  'title': 'System mode not updating',
                  'detail':
                      'Ensure MediaQuery is not overridden higher in the '
                      'tree with a fixed platformBrightness. This prevents '
                      'the system mode from detecting changes.',
                },
                {
                  'title': 'Images not adaptive',
                  'detail':
                      'Dark mode affects widget surfaces but not images. '
                      'Consider providing dark-mode variants for logos '
                      'and illustrations.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECEFF1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: tmPrimary.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: tmDark, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(pit['title']!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(pit['detail']!,
                          style: TextStyle(fontSize: 11, color: tmMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 13. Decision Flow ────────────────────────────────
          tmSection('Decision Guide',
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tmLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final step in [
                      '1. Does your app support dark mode?',
                      '   NO  → ThemeMode.light (ignore darkTheme)',
                      '   YES → Continue...',
                      '',
                      '2. Should users choose their preference?',
                      '   YES → Store preference, offer 3-way toggle',
                      '   NO  → ThemeMode.system (auto-follow OS)',
                      '',
                      '3. Which is the default for new users?',
                      '   Recommended: ThemeMode.system',
                      '   This respects user OS preferences out of the box',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(step,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 14. Persistence Patterns ─────────────────────────
          tmSection('Theme Persistence Patterns',
            children: [
              tmBody(
                'Common approaches for persisting user theme choice:'),
              for (final pat in [
                {
                  'method': 'SharedPreferences',
                  'pros': 'Simple key-value, no dependencies',
                  'cons': 'Async load, brief flash on startup',
                },
                {
                  'method': 'Hive / Isar',
                  'pros': 'Synchronous read, no flash',
                  'cons': 'Heavier dependency for a single setting',
                },
                {
                  'method': 'Provider / Riverpod',
                  'pros': 'Reactive rebuilds, clean separation',
                  'cons': 'Needs state management setup',
                },
                {
                  'method': 'Platform channel',
                  'pros': 'Native settings integration',
                  'cons': 'Platform-specific code needed',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tmLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pat['method']!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 3),
                      Text('✓ ${pat['pros']}',
                          style: TextStyle(
                              fontSize: 11, color: Colors.green.shade700)),
                      Text('✗ ${pat['cons']}',
                          style: TextStyle(
                              fontSize: 11, color: Colors.red.shade600)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 15. Related APIs ─────────────────────────────────
          tmSection('Related APIs',
            children: [
              for (final api in [
                {
                  'name': 'MaterialApp.themeMode',
                  'rel': 'Primary consumer of ThemeMode enum',
                },
                {
                  'name': 'MaterialApp.theme',
                  'rel': 'ThemeData used when brightness is light',
                },
                {
                  'name': 'MaterialApp.darkTheme',
                  'rel': 'ThemeData used when brightness is dark',
                },
                {
                  'name': 'ThemeData',
                  'rel': 'Complete theme specification for Material',
                },
                {
                  'name': 'ColorScheme',
                  'rel': 'Semantic colour tokens within ThemeData',
                },
                {
                  'name': 'Brightness',
                  'rel': 'Two-value enum (light/dark) describing luminance',
                },
                {
                  'name': 'MediaQuery.platformBrightnessOf',
                  'rel': 'Read current OS brightness at runtime',
                },
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text(api['name']!,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: tmDark)),
                      ),
                      Expanded(
                        child: Text(api['rel']!,
                            style: TextStyle(fontSize: 12, color: tmMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 16. Summary Dashboard ────────────────────────────
          tmSection('Summary Dashboard',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: tmPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                                '${ThemeMode.values.length}',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: tmDark)),
                            const Text('Enum Values',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: tmAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('3',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: tmDark)),
                            const Text('App Previews',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: tmLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('16',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: tmDark)),
                            const Text('Sections',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tmLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'ThemeMode is the simplest but most impactful enum '
                    'in Material theming. A three-value switch that '
                    'controls the entire visual appearance of your app.',
                    style: TextStyle(
                        fontSize: 12, color: tmMuted, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Footer ───────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: tmDark,
            child: Column(
              children: [
                const Text('ThemeMode Deep Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Charcoal/Silver theme  •  Batch 62  •  '
                  '${ThemeMode.values.length} mode values  •  '
                  '3 app previews',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

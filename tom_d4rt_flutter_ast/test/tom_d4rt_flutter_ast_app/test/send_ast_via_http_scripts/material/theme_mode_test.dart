// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo of ThemeMode (Material).
// ----------------------------------------------------------------------------
// ThemeMode is a small enum with three values:
//
//   - ThemeMode.system : MaterialApp picks `theme` or `darkTheme` based on the
//                        ambient MediaQuery.platformBrightness, which itself
//                        reflects the OS-level light/dark setting.
//   - ThemeMode.light  : Forces use of `theme` regardless of OS preference.
//   - ThemeMode.dark   : Forces use of `darkTheme` regardless of OS preference.
//
// The MaterialApp resolves like so (pseudo-code):
//
//     final useDark = themeMode == ThemeMode.dark
//         || (themeMode == ThemeMode.system
//             && MediaQuery.platformBrightnessOf(ctx) == Brightness.dark);
//     final activeTheme = useDark ? (darkTheme ?? theme) : theme;
//
// This demo renders nested MaterialApp previews so the user can SEE the live
// difference between modes side-by-side without flipping the OS preference.
// We never call runApp or testWidgets — the script only exposes
// `dynamic build(BuildContext context)` which returns a MaterialApp. The
// harness (the host running this script) inserts the returned widget tree.
//
// Each section is wrapped in a Card and uses a StatefulBuilder when local
// state is needed (selected mode, user preference, etc.). Distinct palettes
// are used per section so the educational difference between sections is
// visually obvious.
// ----------------------------------------------------------------------------

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ThemeMode Deep Demo (Harness-Safe) ===');
  for (final m in ThemeMode.values) {
    print('  ${m.index}: ${m.name}');
  }

  // ===========================================================================
  // PALETTES — one per section so the educational message is colour-coded.
  // ===========================================================================

  // Section 1 — slate (overview / enum members)
  const Color slateBg = Color(0xFFECEFF1);
  const Color slateAccent = Color(0xFF455A64);
  const Color slateInk = Color(0xFF263238);
  const Color slateMuted = Color(0xFF607D8B);

  // Section 2 — side-by-side previews (indigo vs amber)
  const Color indigoLightBg = Color(0xFFE8EAF6);
  const Color indigoLightInk = Color(0xFF1A237E);
  const Color indigoDarkBg = Color(0xFF1A237E);
  const Color amberLightBg = Color(0xFFFFF8E1);
  const Color amberLightInk = Color(0xFFFF6F00);
  const Color amberDarkBg = Color(0xFF3E2723);
  const Color amberDarkInk = Color(0xFFFFB300);

  // Section 3 — segmented toggle preview (teal)
  const Color tealLightBg = Color(0xFFE0F2F1);
  const Color tealLightInk = Color(0xFF004D40);
  const Color tealDarkBg = Color(0xFF004D40);
  const Color tealDarkInk = Color(0xFFB2DFDB);

  // Section 4 — platformBrightness readout (deep purple)
  const Color purpleBg = Color(0xFFEDE7F6);
  const Color purpleInk = Color(0xFF311B92);
  const Color purpleAccent = Color(0xFF5E35B1);
  const Color purpleMuted = Color(0xFF9575CD);

  // Section 5 — brand contrast (rose)
  const Color roseLightBg = Color(0xFFFCE4EC);
  const Color roseLightInk = Color(0xFF880E4F);
  const Color roseLightBrand = Color(0xFFC2185B);
  const Color roseDarkBg = Color(0xFF4A0E2A);
  const Color roseDarkBrand = Color(0xFFF06292);

  // Section 6 — auto-tinted vs manual (forest)
  const Color forestSeed = Color(0xFF2E7D32);
  const Color forestLightBg = Color(0xFFE8F5E9);
  const Color forestLightInk = Color(0xFF1B5E20);
  const Color forestDarkBg = Color(0xFF0F2F12);
  const Color forestDarkInk = Color(0xFFC8E6C9);

  // Section 7 — settings panel (cyan)
  const Color cyanBg = Color(0xFFE0F7FA);
  const Color cyanLightInk = Color(0xFF006064);
  const Color cyanDarkBg = Color(0xFF00363A);
  const Color cyanDarkInk = Color(0xFFB2EBF2);
  const Color cyanAccent = Color(0xFF00838F);

  // Section 8 — distinct light vs dark design tokens (orange)
  const Color orangeLightBg = Color(0xFFFFF3E0);
  const Color orangeLightInk = Color(0xFFE65100);
  const Color orangeDarkBg = Color(0xFF1B0F00);
  const Color orangeDarkInk = Color(0xFFFFB74D);

  // Section 9 — persisted preference (blue)
  const Color blueLightBg = Color(0xFFE3F2FD);
  const Color blueLightInk = Color(0xFF0D47A1);
  const Color blueDarkBg = Color(0xFF0A1929);
  const Color blueDarkInk = Color(0xFFBBDEFB);

  // Section 10 — system brightness handling (lime)
  const Color limeLightBg = Color(0xFFF9FBE7);
  const Color limeLightInk = Color(0xFF33691E);
  const Color limeDarkBg = Color(0xFF1B2410);
  const Color limeDarkInk = Color(0xFFDCE775);

  // Section 11 — decision guide (brown / sand)
  const Color sandBg = Color(0xFFEFEBE9);
  const Color sandInk = Color(0xFF3E2723);
  const Color sandAccent = Color(0xFF6D4C41);

  // Section 12 — accessibility (red / coral)
  const Color coralBg = Color(0xFFFFEBEE);
  const Color coralInk = Color(0xFFB71C1C);
  const Color coralAccent = Color(0xFFE53935);

  // Section 13 — combining with MediaQuery (grey)
  const Color greyBg = Color(0xFFF5F5F5);
  const Color greyInk = Color(0xFF212121);
  const Color greyAccent = Color(0xFF616161);

  // ===========================================================================
  // Helper: build a small "phone frame" container hosting a nested MaterialApp.
  // Each preview is sandboxed inside a SizedBox so layout is bounded.
  // ===========================================================================

  Widget previewFrame({
    required String caption,
    required Color captionColor,
    required Widget child,
    double height = 200,
    double width = 280,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          caption,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: captionColor,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: captionColor.withOpacity(0.4), width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      ],
    );
  }

  // A reusable "fake app body" we drop into nested previews. It deliberately
  // exercises text, surface, primary, button styling so the theme contrast is
  // obvious.
  Widget fakeAppBody({required String title, required String body}) {
    return Builder(
      builder: (innerCtx) {
        final cs = Theme.of(innerCtx).colorScheme;
        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  body,
                  style: Theme.of(innerCtx).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    FilledButton(onPressed: () {}, child: const Text('Go')),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('More'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'primaryContainer',
                    style: TextStyle(
                      color: cs.onPrimaryContainer,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // SECTION 1 — Enum overview.
  // ===========================================================================

  final section1 = Card(
    color: slateBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1. ThemeMode — the enum at a glance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: slateInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ThemeMode tells MaterialApp which of `theme` or `darkTheme` to '
            'use. It does NOT change colours by itself — it merely selects '
            'which ThemeData object the framework hands down.',
            style: TextStyle(fontSize: 13, color: slateInk),
          ),
          const SizedBox(height: 12),
          for (final m in ThemeMode.values)
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: slateMuted),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: slateAccent,
                    child: Text(
                      '${m.index}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'ThemeMode.${m.name}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: slateInk,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    switch (m) {
                      ThemeMode.system => 'follow OS',
                      ThemeMode.light => 'force light',
                      ThemeMode.dark => 'force dark',
                    },
                    style: TextStyle(fontSize: 12, color: slateMuted),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 2 — Side-by-side previews of light, dark, system.
  // Three nested MaterialApp instances each pinned to a specific themeMode so
  // the user sees exactly what each value renders.
  // ===========================================================================

  ThemeData makeLightTheme(Color seed) =>
      ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: seed), useMaterial3: true);
  ThemeData makeDarkTheme(Color seed) => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );

  final section2 = Card(
    color: indigoLightBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2. Side-by-side: .light vs .dark vs .system',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: indigoLightInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Three identical apps differ only in `themeMode`. .system follows '
            'MediaQuery.platformBrightness, so its rendering matches whichever '
            'OS preference is currently active.',
            style: TextStyle(fontSize: 13, color: indigoLightInk),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                previewFrame(
                  caption: 'ThemeMode.light',
                  captionColor: indigoLightInk,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.light,
                    theme: makeLightTheme(indigoLightInk),
                    darkTheme: makeDarkTheme(indigoLightInk),
                    home: fakeAppBody(
                      title: 'Light',
                      body: 'Forced .light — never asks the OS.',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                previewFrame(
                  caption: 'ThemeMode.dark',
                  captionColor: indigoDarkBg,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.dark,
                    theme: makeLightTheme(indigoDarkBg),
                    darkTheme: makeDarkTheme(indigoDarkBg),
                    home: fakeAppBody(
                      title: 'Dark',
                      body: 'Forced .dark — never asks the OS.',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                previewFrame(
                  caption: 'ThemeMode.system',
                  captionColor: amberLightInk,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.system,
                    theme: makeLightTheme(amberLightInk),
                    darkTheme: makeDarkTheme(amberDarkInk),
                    home: fakeAppBody(
                      title: 'System',
                      body: 'Follows MediaQuery.platformBrightness.',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: amberLightBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: amberLightInk),
            ),
            child: Text(
              'Note: the .system preview renders LIGHT or DARK depending on '
              'this device\'s current platformBrightness. Toggle your OS '
              'theme and rebuild — only the third frame should change.',
              style: TextStyle(
                color: amberDarkBg,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 3 — Live SegmentedButton toggle bound to a nested MaterialApp.
  // ===========================================================================

  final section3 = Card(
    color: tealLightBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3. Live SegmentedButton toggle',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: tealLightInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pick a ThemeMode — the nested preview swaps in real time. Notice '
            'that only `themeMode` changes; the supplied `theme` and '
            '`darkTheme` are constant.',
            style: TextStyle(fontSize: 13, color: tealLightInk),
          ),
          const SizedBox(height: 12),
          StatefulBuilder(
            builder: (ctx, setState) {
              ThemeMode current = ThemeMode.system;
              return StatefulBuilder(
                builder: (innerCtx, innerSet) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SegmentedButton<ThemeMode>(
                        segments: const [
                          ButtonSegment<ThemeMode>(
                            value: ThemeMode.light,
                            label: Text('Light'),
                            icon: Icon(Icons.light_mode),
                          ),
                          ButtonSegment<ThemeMode>(
                            value: ThemeMode.dark,
                            label: Text('Dark'),
                            icon: Icon(Icons.dark_mode),
                          ),
                          ButtonSegment<ThemeMode>(
                            value: ThemeMode.system,
                            label: Text('System'),
                            icon: Icon(Icons.settings_brightness),
                          ),
                        ],
                        selected: {current},
                        onSelectionChanged: (set) {
                          innerSet(() => current = set.first);
                        },
                      ),
                      const SizedBox(height: 12),
                      previewFrame(
                        caption: 'Selected: ThemeMode.${current.name}',
                        captionColor: tealLightInk,
                        width: 320,
                        child: MaterialApp(
                          debugShowCheckedModeBanner: false,
                          themeMode: current,
                          theme: makeLightTheme(tealLightInk),
                          darkTheme: makeDarkTheme(tealDarkInk),
                          home: fakeAppBody(
                            title: 'Live Preview',
                            body:
                                'Currently rendering with ThemeMode.${current.name}',
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            'Implementation: store the chosen ThemeMode in a State / '
            'ValueNotifier, then pass it into MaterialApp.themeMode. No need '
            'to rebuild the ThemeData itself.',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: tealDarkBg,
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 4 — MediaQuery.platformBrightnessOf readout + system resolution.
  // ===========================================================================

  final platformBrightness = MediaQuery.platformBrightnessOf(context);

  final section4 = Card(
    color: purpleBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '4. MediaQuery.platformBrightnessOf — how .system resolves',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: purpleInk,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: purpleAccent),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      platformBrightness == Brightness.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: purpleInk,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'platformBrightness = ${platformBrightness.name}',
                      style: TextStyle(
                        fontSize: 14,
                        color: purpleInk,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Given ThemeMode.system, MaterialApp will currently use '
                  '${platformBrightness == Brightness.dark ? "darkTheme" : "theme"}.',
                  style: TextStyle(fontSize: 13, color: purpleInk),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Resolution table (ThemeMode × platformBrightness):',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: purpleInk,
            ),
          ),
          const SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: purpleMuted),
            children: [
              TableRow(
                decoration: BoxDecoration(color: purpleAccent),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      'mode',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      'pb=light',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      'pb=dark',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              for (final m in ThemeMode.values)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        m.name,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: purpleInk,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        switch (m) {
                          ThemeMode.system => 'theme',
                          ThemeMode.light => 'theme',
                          ThemeMode.dark => 'darkTheme',
                        },
                        style: TextStyle(color: purpleInk),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        switch (m) {
                          ThemeMode.system => 'darkTheme',
                          ThemeMode.light => 'theme',
                          ThemeMode.dark => 'darkTheme',
                        },
                        style: TextStyle(color: purpleInk),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 5 — Brand colours that shift between light/dark for contrast.
  // ===========================================================================

  final section5 = Card(
    color: roseLightBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5. Brand colours: shifting for contrast',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: roseLightInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A common production pattern: the same logical brand colour is '
            'rendered with a darker shade on light backgrounds and a lighter '
            'shade on dark backgrounds. ThemeMode picks which token applies.',
            style: TextStyle(fontSize: 13, color: roseLightInk),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: previewFrame(
                  caption: 'theme: light brand',
                  captionColor: roseLightInk,
                  height: 220,
                  width: 0,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.light,
                    theme: ThemeData(
                      useMaterial3: true,
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: roseLightBrand,
                        primary: roseLightBrand,
                        brightness: Brightness.light,
                      ),
                    ),
                    home: fakeAppBody(
                      title: 'Brand on light',
                      body: 'Brand: $roseLightBrand',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: previewFrame(
                  caption: 'darkTheme: light brand re-shaded',
                  captionColor: roseDarkBg,
                  height: 220,
                  width: 0,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.dark,
                    theme: ThemeData(useMaterial3: true),
                    darkTheme: ThemeData(
                      useMaterial3: true,
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: roseDarkBrand,
                        primary: roseDarkBrand,
                        brightness: Brightness.dark,
                      ),
                    ),
                    home: fakeAppBody(
                      title: 'Brand on dark',
                      body: 'Brand: $roseDarkBrand',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 6 — Auto-tinted (seeded ColorScheme) vs manual configuration.
  // ===========================================================================

  final section6 = Card(
    color: forestLightBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '6. Auto-tinted vs Manual ColorScheme',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: forestLightInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ColorScheme.fromSeed() generates a tonal palette that already '
            'covers light AND dark with proper contrast. Pair with '
            'ThemeMode.system and the user gets a coherent experience for '
            'free.',
            style: TextStyle(fontSize: 13, color: forestLightInk),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: previewFrame(
                  caption: 'fromSeed light (auto)',
                  captionColor: forestLightInk,
                  height: 220,
                  width: 0,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.light,
                    theme: ThemeData(
                      useMaterial3: true,
                      colorScheme: ColorScheme.fromSeed(seedColor: forestSeed),
                    ),
                    home: fakeAppBody(
                      title: 'Seeded light',
                      body: 'Auto-tinted from $forestSeed',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: previewFrame(
                  caption: 'fromSeed dark (auto)',
                  captionColor: forestDarkInk,
                  height: 220,
                  width: 0,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.dark,
                    theme: ThemeData(useMaterial3: true),
                    darkTheme: ThemeData(
                      useMaterial3: true,
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: forestSeed,
                        brightness: Brightness.dark,
                      ),
                    ),
                    home: fakeAppBody(
                      title: 'Seeded dark',
                      body: 'Auto-tinted, dark variant',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: forestDarkBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Manual config: write all 30+ ColorScheme slots by hand for '
              'each brightness. fromSeed() is usually the better starting '
              'point and saves significant maintenance.',
              style: TextStyle(color: forestDarkInk, fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 7 — Settings panel: RadioListTile<ThemeMode> bound to ValueNotifier
  // ===========================================================================

  final settingsNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

  final section7 = Card(
    color: cyanBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7. Settings panel: RadioListTile<ThemeMode>',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: cyanLightInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A typical "App theme" preference page. The notifier drives a '
            'nested MaterialApp via ValueListenableBuilder so the preview '
            'reflects the choice immediately.',
            style: TextStyle(fontSize: 13, color: cyanLightInk),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: settingsNotifier,
            builder: (ctx, mode, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final m in ThemeMode.values)
                    RadioListTile<ThemeMode>(
                      value: m,
                      groupValue: mode,
                      activeColor: cyanAccent,
                      title: Text(
                        switch (m) {
                          ThemeMode.system => 'Match system',
                          ThemeMode.light => 'Always light',
                          ThemeMode.dark => 'Always dark',
                        },
                        style: TextStyle(color: cyanLightInk),
                      ),
                      subtitle: Text(
                        'ThemeMode.${m.name}',
                        style: TextStyle(
                          color: cyanLightInk,
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                      onChanged: (v) {
                        if (v != null) settingsNotifier.value = v;
                      },
                    ),
                  const SizedBox(height: 12),
                  previewFrame(
                    caption: 'Bound preview — ThemeMode.${mode.name}',
                    captionColor: cyanAccent,
                    width: 320,
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      themeMode: mode,
                      theme: makeLightTheme(cyanAccent),
                      darkTheme: makeDarkTheme(cyanDarkInk),
                      home: fakeAppBody(
                        title: 'My App',
                        body: 'User chose: ${mode.name}',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cyanDarkBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'In a real app, wrap MaterialApp itself in a '
              'ValueListenableBuilder so the entire app tree picks up the '
              'change without remounting widgets.',
              style: TextStyle(color: cyanDarkInk, fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 8 — Distinct light vs dark design tokens (different typography,
  // shapes, etc.). Demonstrates that theme and darkTheme can be radically
  // different beyond just colour.
  // ===========================================================================

  final lightTokenTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: orangeLightInk,
      onPrimary: orangeLightBg,
      surface: orangeLightBg,
      onSurface: orangeLightInk,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.w300, letterSpacing: 1.2),
      bodyMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    ),
  );
  final darkTokenTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: orangeDarkInk,
      onPrimary: orangeDarkBg,
      surface: orangeDarkBg,
      onSurface: orangeDarkInk,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.0),
      bodyMedium: TextStyle(fontWeight: FontWeight.w500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );

  final section8 = Card(
    color: orangeLightBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '8. Different design tokens for light vs dark',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: orangeLightInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'theme and darkTheme are independent ThemeData instances. They '
            'can vary in typography, button shape, density — not just '
            'colour. ThemeMode just picks one.',
            style: TextStyle(fontSize: 13, color: orangeLightInk),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: previewFrame(
                  caption: 'light: thin type, square buttons',
                  captionColor: orangeLightInk,
                  height: 220,
                  width: 0,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.light,
                    theme: lightTokenTheme,
                    darkTheme: darkTokenTheme,
                    home: fakeAppBody(
                      title: 'LIGHT TOKENS',
                      body: 'Thin weight + square corners.',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: previewFrame(
                  caption: 'dark: heavy type, pill buttons',
                  captionColor: orangeDarkInk,
                  height: 220,
                  width: 0,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.dark,
                    theme: lightTokenTheme,
                    darkTheme: darkTokenTheme,
                    home: fakeAppBody(
                      title: 'DARK TOKENS',
                      body: 'Heavy weight + pill corners.',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 9 — Persisted preference pseudo-pattern.
  // ===========================================================================

  // In-memory simulation of SharedPreferences. In a real app you would call
  // SharedPreferences.getInstance(), then prefs.getString('themeMode'). On
  // change, prefs.setString('themeMode', mode.name).
  final Map<String, String> fakePrefs = <String, String>{};

  ThemeMode loadFakePrefs() {
    final raw = fakePrefs['themeMode'];
    return switch (raw) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  void saveFakePrefs(ThemeMode m) {
    fakePrefs['themeMode'] = m.name;
  }

  final section9 = Card(
    color: blueLightBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '9. Persisted preference (SharedPreferences slot)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: blueLightInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'The user\'s ThemeMode choice should survive app restart. The '
            'standard pattern is SharedPreferences. Below is an in-memory '
            'simulation showing exactly where the read/write hooks go.',
            style: TextStyle(fontSize: 13, color: blueLightInk),
          ),
          const SizedBox(height: 12),
          StatefulBuilder(
            builder: (ctx, setState) {
              final loaded = loadFakePrefs();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: blueLightInk),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'fakePrefs[themeMode] = ${fakePrefs['themeMode'] ?? "<unset>"}',
                          style: TextStyle(
                            color: blueLightInk,
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Loaded back as ThemeMode.${loaded.name}',
                          style: TextStyle(
                            color: blueLightInk,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final m in ThemeMode.values)
                        OutlinedButton(
                          onPressed: () {
                            setState(() => saveFakePrefs(m));
                          },
                          child: Text('Save .${m.name}'),
                        ),
                      OutlinedButton(
                        onPressed: () {
                          setState(() => fakePrefs.remove('themeMode'));
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  previewFrame(
                    caption: 'App started with persisted .${loaded.name}',
                    captionColor: blueLightInk,
                    width: 320,
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      themeMode: loaded,
                      theme: makeLightTheme(blueLightInk),
                      darkTheme: makeDarkTheme(blueDarkInk),
                      home: fakeAppBody(
                        title: 'Restored',
                        body: 'Loaded ThemeMode.${loaded.name} from prefs.',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: blueDarkBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Real implementation:\n'
              '  final prefs = await SharedPreferences.getInstance();\n'
              '  final stored = prefs.getString("themeMode");\n'
              '  final mode = ThemeMode.values.firstWhere(\n'
              '      (m) => m.name == stored,\n'
              '      orElse: () => ThemeMode.system);\n'
              '  // ... pass `mode` to MaterialApp.themeMode\n'
              '  // on change: await prefs.setString("themeMode", mode.name);',
              style: TextStyle(
                color: blueDarkInk,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 10 — System brightness change handling.
  // ===========================================================================

  final section10 = Card(
    color: limeLightBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '10. System brightness changes — what MaterialApp does',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: limeLightInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'When ThemeMode.system is selected and the OS toggles brightness, '
            'Flutter dispatches a new MediaQueryData with updated '
            'platformBrightness. MaterialApp re-evaluates resolution and '
            'pushes the new ThemeData down. Any widget reading Theme.of(ctx) '
            'rebuilds.',
            style: TextStyle(fontSize: 13, color: limeLightInk),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: limeDarkBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lifecycle (simplified):',
                  style: TextStyle(
                    color: limeDarkInk,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                for (final step in const [
                  '1. OS toggles dark mode',
                  '2. PlatformDispatcher.onPlatformBrightnessChanged fires',
                  '3. WidgetsBinding rebuilds MediaQuery with new value',
                  '4. MaterialApp re-resolves theme vs darkTheme',
                  '5. Theme InheritedWidget pushes update',
                  '6. All Theme.of(ctx) consumers rebuild',
                ])
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      step,
                      style: TextStyle(
                        color: limeDarkInk,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: limeLightInk),
            ),
            child: Text(
              'Caveat: don\'t cache `Theme.of(ctx).brightness` in a '
              'long-lived field. Always read it during build. With '
              'ThemeMode.light or .dark, brightness is fixed and these '
              'changes are ignored — handy when consistency matters more '
              'than OS coupling.',
              style: TextStyle(color: limeLightInk, fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 11 — Decision guide: when to use which.
  // ===========================================================================

  final section11 = Card(
    color: sandBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '11. Decision guide — which mode should you ship?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: sandInk,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: sandAccent),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use ThemeMode.system when:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: sandInk,
                  ),
                ),
                Text(
                  '  • You ship both light and dark themes\n'
                  '  • You trust the OS to know user preference\n'
                  '  • Your brand reads well in both modes\n'
                  '  • You are aiming for Material 3 defaults',
                  style: TextStyle(color: sandInk, fontSize: 12),
                ),
                const SizedBox(height: 12),
                Text(
                  'Use ThemeMode.light when:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: sandInk,
                  ),
                ),
                Text(
                  '  • Your app is content-heavy print work (recipes, docs)\n'
                  '  • You only have a light design system\n'
                  '  • Photo/colour fidelity is paramount',
                  style: TextStyle(color: sandInk, fontSize: 12),
                ),
                const SizedBox(height: 12),
                Text(
                  'Use ThemeMode.dark when:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: sandInk,
                  ),
                ),
                Text(
                  '  • Media playback / video / map / camera-style apps\n'
                  '  • OLED battery savings are a feature\n'
                  '  • Your brand is inherently dark\n'
                  '  • Night-time / astronomy / lab applications',
                  style: TextStyle(color: sandInk, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Best of both worlds: ship .system as default but expose a '
            'three-option preference (system / light / dark) in settings.',
            style: TextStyle(
              color: sandAccent,
              fontStyle: FontStyle.italic,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 12 — Accessibility considerations.
  // ===========================================================================

  final section12 = Card(
    color: coralBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '12. Accessibility — why a manual override matters',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: coralInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Some users — including readers with photophobia, light '
            'sensitivity, certain forms of dyslexia, or migraine — strongly '
            'benefit from forcing a specific mode regardless of OS setting. '
            'Always offer all three options.',
            style: TextStyle(fontSize: 13, color: coralInk),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: coralAccent),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Accessibility checklist:',
                  style: TextStyle(
                    color: coralInk,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                for (final t in const [
                  'Always expose a three-way ThemeMode toggle in settings.',
                  'Pair with MediaQuery.highContrastOf(ctx) for HC variants.',
                  'Verify both themes meet WCAG AA contrast (4.5:1 text).',
                  'Test images, charts, and icons in both modes.',
                  'Never hard-code theme-specific colours in widgets — read '
                      'from ColorScheme so both modes stay consistent.',
                  'Persist the choice; do not silently revert to .system.',
                ])
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check, size: 14, color: coralAccent),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            t,
                            style: TextStyle(
                              color: coralInk,
                              fontSize: 12,
                            ),
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
  );

  // ===========================================================================
  // SECTION 13 — Combining ThemeMode with MediaQuery.
  // ===========================================================================

  final section13 = Card(
    color: greyBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '13. Combining ThemeMode with MediaQuery',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: greyInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You can pre-resolve the effective brightness yourself. This is '
            'useful when you need to feed brightness to a non-Material '
            'subsystem (canvas painters, overlay widgets, splash screens).',
            style: TextStyle(fontSize: 13, color: greyInk),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: greyAccent),
            ),
            child: Text(
              'Brightness resolveBrightness(ThemeMode mode, BuildContext ctx) {\n'
              '  switch (mode) {\n'
              '    case ThemeMode.light: return Brightness.light;\n'
              '    case ThemeMode.dark:  return Brightness.dark;\n'
              '    case ThemeMode.system:\n'
              '      return MediaQuery.platformBrightnessOf(ctx);\n'
              '  }\n'
              '}',
              style: TextStyle(
                color: greyInk,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: greyAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Inside MaterialApp\'s descendants, just use Theme.of(ctx) — '
              'the framework already did this for you. Resolve manually only '
              'when you need brightness BEFORE Theme is in scope (e.g. '
              'before MaterialApp itself).',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 14 — Edge cases & pitfalls summary.
  // ===========================================================================

  final section14 = Card(
    color: slateBg,
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '14. Edge cases & pitfalls',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: slateInk,
            ),
          ),
          const SizedBox(height: 8),
          for (final pitfall in const [
            'No darkTheme provided + ThemeMode.dark → falls back to `theme`. '
                'Always supply both.',
            'Forgetting to wrap nested Navigator with its own MaterialApp '
                'when previewing — settings dialogs sometimes inherit the '
                'wrong theme.',
            'Hard-coding Colors.white / Colors.black in widgets — they '
                'don\'t flip when ThemeMode flips. Use cs.surface / '
                'cs.onSurface instead.',
            'Storing ThemeMode.index in prefs — order changes between '
                'Flutter versions could break it. Persist `name` or '
                '`toString()`, then parse back.',
            'Setting themeMode in a child widget — only MaterialApp.themeMode '
                'is consumed. Lift state up.',
            'Animating between modes — Flutter cross-fades automatically; '
                'don\'t reimplement it manually unless required.',
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_amber, size: 16, color: slateAccent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      pitfall,
                      style: TextStyle(color: slateInk, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // FINAL ASSEMBLY
  // ===========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ThemeMode Deep Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: slateAccent),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('ThemeMode — Deep Demo'),
        backgroundColor: slateAccent,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              section1,
              const SizedBox(height: 12),
              section2,
              const SizedBox(height: 12),
              section3,
              const SizedBox(height: 12),
              section4,
              const SizedBox(height: 12),
              section5,
              const SizedBox(height: 12),
              section6,
              const SizedBox(height: 12),
              section7,
              const SizedBox(height: 12),
              section8,
              const SizedBox(height: 12),
              section9,
              const SizedBox(height: 12),
              section10,
              const SizedBox(height: 12),
              section11,
              const SizedBox(height: 12),
              section12,
              const SizedBox(height: 12),
              section13,
              const SizedBox(height: 12),
              section14,
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'End — ThemeMode Deep Demo (${ThemeMode.values.length} values)',
                  style: TextStyle(
                    color: slateMuted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

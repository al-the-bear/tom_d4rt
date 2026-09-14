// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual deep demo: SystemUiOverlay enum (package:flutter/services.dart).
//
// SystemUiOverlay represents *individual* pieces of system chrome that can be
// shown when SystemUiMode.manual is in effect. The enum has only two members
// and yet it is the lever that controls how a Flutter app shares the screen
// with the OS:
//
//   - SystemUiOverlay.top    -> the status bar (clock, signal, battery,
//                               notch, dynamic island affordances).
//   - SystemUiOverlay.bottom -> the navigation bar (gesture handle on
//                               iPhone, on-screen back/home/recents on
//                               Android with button navigation, gesture
//                               pill on Android with gesture nav).
//
// SystemUiOverlay is consumed exclusively as a List<SystemUiOverlay> by
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [...])
// The list is *orthogonal*: each value can be present or absent independently
// of the other, so for two members there are 2^2 = 4 possible configurations.
//
// This demo VISUALLY narrates that orthogonality:
//   * it never invokes SystemChrome — it draws mock device frames that
//     simulate what each overlay configuration would look like,
//   * it pairs the enum with SystemUiMode.manual conceptually (the only
//     mode where the `overlays:` argument is actually honoured),
//   * it gives platform-specific notes (iOS notch / dynamic island,
//     Android gesture-nav vs button-nav, restoration semantics),
//   * it ends with three real-world recipes (immersive video, drawing app,
//     full-immersive game) that map directly to overlay lists.
//
// File: tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/
//       send_ast_via_http_scripts/services/system_ui_overlay_test.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('=========================================================');
  print(' SystemUiOverlay deep demo executing');
  print(' enum lives in package:flutter/services.dart');
  print(' values: top (status bar), bottom (navigation bar)');
  print('=========================================================');

  // ----- Palette ---------------------------------------------------------
  // We use four palette pairs across the document to keep gradients varied.
  const inkDeep = Color(0xFF0B1020);
  const inkMid = Color(0xFF141A33);
  const inkSoft = Color(0xFF1F2750);

  const auroraA = Color(0xFF00C9A7);
  const auroraB = Color(0xFF1FAB89);

  const sunriseA = Color(0xFFFFB75E);
  const sunriseB = Color(0xFFED8F03);

  const orchidA = Color(0xFFB06AB3);
  const orchidB = Color(0xFF4568DC);

  const cherryA = Color(0xFFF85C70);
  const cherryB = Color(0xFFB22667);

  const skyA = Color(0xFF6DD5FA);
  const skyB = Color(0xFF2980B9);

  const limeA = Color(0xFFA8E063);
  const limeB = Color(0xFF56AB2F);

  // Sanity-print the enum surface, exactly like the original stub did so
  // that the trace logs of older runs still match in spirit.
  print('SystemUiOverlay values discovered at runtime:');
  for (final value in SystemUiOverlay.values) {
    print('  - SystemUiOverlay.${value.name} (index ${value.index})');
  }
  print('SystemUiOverlay.values.length = ${SystemUiOverlay.values.length}');
  final firstValue = SystemUiOverlay.values.first;
  final lastValue = SystemUiOverlay.values.last;
  print('first = $firstValue, last = $lastValue');
  print('Note: order in `values` is a Dart implementation detail — code');
  print('      that matters should index by name, never by .index.');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('--- Section 1: Hero header ---');
  final hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 36.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [inkDeep, inkSoft, orchidB],
      ),
      borderRadius: BorderRadius.circular(28.0),
      boxShadow: [
        BoxShadow(
          color: orchidB.withValues(alpha: 0.45),
          blurRadius: 32.0,
          offset: const Offset(0.0, 18.0),
        ),
        BoxShadow(
          color: inkDeep.withValues(alpha: 0.65),
          blurRadius: 8.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [auroraA, auroraB],
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: auroraA.withValues(alpha: 0.55),
                    blurRadius: 18.0,
                    offset: const Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: const Icon(
                Icons.layers_outlined,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(width: 18.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SystemUiOverlay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Two switches, four worlds.\n'
                    'Each value toggles a single piece of system chrome.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.0,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            _heroChip('package:flutter/services.dart', skyA, skyB),
            _heroChip('enum (2 members)', limeA, limeB),
            _heroChip('used as List<SystemUiOverlay>', sunriseA, sunriseB),
            _heroChip('paired with SystemUiMode.manual', cherryA, cherryB),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of a phone — what each overlay covers
  // ============================================================
  print('--- Section 2: Anatomy ---');
  final anatomy = _section(
    title: 'Anatomy of a phone',
    subtitle:
        'Cross-section view: where the top and bottom overlays actually live.',
    accent: skyB,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mock phone with both overlays highlighted.
        _mockPhone(
          label: 'reference frame',
          showTop: true,
          showBottom: true,
          highlightTop: true,
          highlightBottom: true,
          contentGradient: const [inkSoft, orchidB],
        ),
        const SizedBox(width: 24.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _anatomyRow(
                color: auroraB,
                title: 'Top overlay (status bar)',
                points: const [
                  'Owned by the OS, drawn on top of your app.',
                  'Hosts: time, battery, signal, notification icons.',
                  'On iOS contains the notch / dynamic island region.',
                  'Removing it gives you those vertical pixels back.',
                ],
              ),
              const SizedBox(height: 18.0),
              _anatomyRow(
                color: cherryB,
                title: 'Bottom overlay (navigation bar)',
                points: const [
                  'Hosts the gesture pill (iOS / Android gesture nav)',
                  'Or back / home / recents (Android button nav).',
                  'Hiding it on Android reclaims real estate;',
                  'Hiding it on iOS is largely cosmetic — the OS still',
                  'reserves space for the home-indicator gesture.',
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards
  // ============================================================
  print('--- Section 3: Per-value cards ---');
  final perValueIntro = _section(
    title: 'The two enum members, in detail',
    subtitle:
        'Read these as independent on/off switches — not as a sequence.',
    accent: orchidB,
    child: Wrap(
      spacing: 22.0,
      runSpacing: 22.0,
      children: [
        _valueCard(
          name: 'SystemUiOverlay.top',
          tagline: 'Status bar',
          gradient: const [auroraA, auroraB],
          icon: Icons.signal_cellular_alt,
          definition:
              'Enables the operating system\'s status bar at the top of the '
              'screen. This is where the clock, battery, network indicator, '
              'notification icons and (on iOS) the notch / dynamic island live.',
          contents: const [
            'Time and date',
            'Battery / charging indicator',
            'Network signal, Wi-Fi, Bluetooth glyphs',
            'Notification icons (Android)',
            'Dynamic island affordances (iOS)',
          ],
          ios:
              'iOS draws the notch / dynamic island region inside the top safe '
              'area. Hiding the top overlay still leaves the notch visible — '
              'it is hardware, not chrome. Use MediaQuery.padding to inset.',
          android:
              'Android draws status icons + system notification ticker. '
              'Hiding it places your app in the top inset — combine with a '
              'SafeArea or MediaQuery.viewPadding read.',
          enabledIndex: 0,
        ),
        _valueCard(
          name: 'SystemUiOverlay.bottom',
          tagline: 'Navigation bar',
          gradient: const [cherryA, cherryB],
          icon: Icons.swipe_up_outlined,
          definition:
              'Enables the operating system\'s bottom navigation surface: '
              'the home indicator on iOS, and either the gesture pill or '
              'the three-button back/home/recents bar on Android.',
          contents: const [
            'iOS gesture pill (home indicator)',
            'Android back / home / recents (button nav)',
            'Android gesture pill (gesture nav)',
            'IME (keyboard) caret bar in some skins',
          ],
          ios:
              'On iOS the home indicator is essentially always reserved by '
              'the OS — passing or omitting bottom rarely changes the visible '
              'gesture handle. The user can always swipe up to leave the app.',
          android:
              'On Android with three-button navigation, omitting bottom truly '
              'reclaims the bar. With gesture navigation the OS keeps a thin '
              'gesture-edge active even when the pill is hidden.',
          enabledIndex: 1,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Combination grid — the full power-set
  // ============================================================
  print('--- Section 4: Combination grid ---');
  final combinationGrid = _section(
    title: 'All four configurations',
    subtitle:
        'List<SystemUiOverlay> is just a set: 2 members ⇒ 2² = 4 cases.',
    accent: sunriseB,
    child: Wrap(
      spacing: 20.0,
      runSpacing: 20.0,
      children: [
        _combinationCard(
          label: '[]  (empty)',
          comment: 'No system chrome — full-immersive.',
          gradient: const [inkDeep, inkSoft],
          showTop: false,
          showBottom: false,
          accent: cherryB,
        ),
        _combinationCard(
          label: '[SystemUiOverlay.top]',
          comment: 'Status bar visible, navigation hidden.',
          gradient: const [auroraA, skyB],
          showTop: true,
          showBottom: false,
          accent: auroraB,
        ),
        _combinationCard(
          label: '[SystemUiOverlay.bottom]',
          comment: 'Navigation visible, status hidden.',
          gradient: const [orchidA, orchidB],
          showTop: false,
          showBottom: true,
          accent: orchidB,
        ),
        _combinationCard(
          label: '[SystemUiOverlay.top, SystemUiOverlay.bottom]',
          comment: 'Both visible — equivalent to the default edgeToEdge feel.',
          gradient: const [sunriseA, sunriseB],
          showTop: true,
          showBottom: true,
          accent: sunriseB,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Pairing with SystemUiMode.manual
  // ============================================================
  print('--- Section 5: Pairing with SystemUiMode.manual ---');
  final pairingPanel = _section(
    title: 'Pairs with SystemUiMode.manual',
    subtitle:
        'The `overlays:` argument is only honoured when mode == manual.',
    accent: limeB,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [inkMid, inkSoft],
            ),
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: [
              BoxShadow(
                color: inkDeep.withValues(alpha: 0.55),
                blurRadius: 18.0,
                offset: const Offset(0.0, 8.0),
              ),
            ],
          ),
          child: const Text(
            '// Pseudocode — DO NOT execute in this demo:\n'
            '//\n'
            '// SystemChrome.setEnabledSystemUIMode(\n'
            '//   SystemUiMode.manual,\n'
            '//   overlays: <SystemUiOverlay>[\n'
            '//     SystemUiOverlay.top,    // keep status bar\n'
            '//     // SystemUiOverlay.bottom,  // hide nav bar\n'
            '//   ],\n'
            '// );\n'
            '//\n'
            '// In any other SystemUiMode the `overlays:` list is\n'
            '// silently ignored. Mixing immersive / leanBack / edgeToEdge\n'
            '// with an overlay list is a common newcomer bug.',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 13.0,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _modePairCard(
                title: 'manual + overlays',
                isPair: true,
                color: limeB,
                description:
                    'The only valid combination. `overlays` becomes the '
                    'authoritative list of visible system chrome pieces.',
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _modePairCard(
                title: 'immersive / leanBack',
                isPair: false,
                color: cherryB,
                description:
                    'Hide everything; user gesture restores chrome. The '
                    '`overlays:` list is ignored — this is what people '
                    'mean by "full screen".',
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _modePairCard(
                title: 'edgeToEdge',
                isPair: false,
                color: skyB,
                description:
                    'Both bars stay translucent and visible; your app '
                    'paints under them. `overlays` is ignored here too.',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Recipes
  // ============================================================
  print('--- Section 6: Recipes ---');
  final recipes = _section(
    title: 'Three recipes from the wild',
    subtitle:
        'Map a UX intent to an overlay list. No SystemChrome calls — just plans.',
    accent: cherryB,
    child: Column(
      children: [
        _recipeCard(
          index: 1,
          title: 'Immersive video player — keep status bar',
          intent:
              'Letterboxed video. Designers want the user to still see the '
              'time / battery while watching, but no nav distraction at the '
              'bottom of a 16:9 frame.',
          overlays: const ['SystemUiOverlay.top'],
          notes: const [
            'Drop SystemUiOverlay.bottom to reclaim ~48 dp on Android.',
            'On iOS the home indicator dims automatically after a few seconds.',
            'Pair with WakelockPlus to keep the screen alive.',
          ],
          gradient: const [skyA, skyB],
          showTop: true,
          showBottom: false,
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          index: 2,
          title: 'Drawing app — show only the gesture nav',
          intent:
              'Maximise canvas height while keeping the back gesture obvious. '
              'Time / battery would clutter the canvas top edge.',
          overlays: const ['SystemUiOverlay.bottom'],
          notes: const [
            'Drop SystemUiOverlay.top to free the notch / status row.',
            'Provide an in-app clock / battery widget if the user asks.',
            'Use SafeArea(top: false, bottom: true) for the canvas.',
          ],
          gradient: const [orchidA, orchidB],
          showTop: false,
          showBottom: true,
        ),
        const SizedBox(height: 16.0),
        _recipeCard(
          index: 3,
          title: 'Full-immersive game — show nothing',
          intent:
              'Arcade-style game wants every pixel. The HUD draws its own '
              'time / score and never wants OS chrome to peek in.',
          overlays: const <String>[],
          notes: const [
            'Combine [] with SystemUiMode.manual for explicit "no chrome".',
            'Consider SystemUiMode.immersiveSticky instead if you want the',
            'OS to auto-restore on edge swipe — overlays argument ignored.',
            'Always restore overlays in dispose() of your game route.',
          ],
          gradient: const [inkSoft, cherryB],
          showTop: false,
          showBottom: false,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Pitfalls
  // ============================================================
  print('--- Section 7: Pitfalls ---');
  final pitfalls = _section(
    title: 'Pitfalls and gotchas',
    subtitle:
        'Things that bite teams the first time they ship overlay tweaks.',
    accent: cherryA,
    child: Column(
      children: [
        _pitfallCard(
          title: 'iOS does not really hide the bottom overlay',
          color: cherryB,
          icon: Icons.phone_iphone,
          body:
              'On iOS the home indicator is part of the platform contract, '
              'not part of your app. Even when you omit '
              'SystemUiOverlay.bottom, the OS continues to reserve a thin '
              'gesture region. Plan your bottom-edge hit targets around it; '
              'never put a critical button under the home indicator.',
        ),
        const SizedBox(height: 12.0),
        _pitfallCard(
          title: 'Android gesture-nav vs button-nav diverge',
          color: orchidB,
          icon: Icons.android,
          body:
              'Hiding SystemUiOverlay.bottom reclaims meaningful space on '
              'devices with three-button navigation. On gesture-nav devices '
              'the OS keeps a small swipe-from-bottom region active, so the '
              'user-perceived "extra space" is closer to the height of a '
              'thin pill rather than a full bar.',
        ),
        const SizedBox(height: 12.0),
        _pitfallCard(
          title: 'overlays: is ignored unless mode == manual',
          color: sunriseB,
          icon: Icons.warning_amber_rounded,
          body:
              'The single most common mistake: passing an `overlays:` list '
              'to setEnabledSystemUIMode(immersive, overlays: [...]). The '
              'list is silently dropped. If you want partial chrome, you '
              'must pass SystemUiMode.manual.',
        ),
        const SizedBox(height: 12.0),
        _pitfallCard(
          title: 'You must restore overlays on the way out',
          color: auroraB,
          icon: Icons.restore,
          body:
              'A route that strips chrome on entry must restore '
              '[SystemUiOverlay.top, SystemUiOverlay.bottom] (or whatever '
              'the rest of the app expects) in dispose() / pop. Otherwise '
              'navigating back leaks a half-immersive look into the next '
              'screen and looks like a bug.',
        ),
        const SizedBox(height: 12.0),
        _pitfallCard(
          title: 'Don\'t depend on .index',
          color: skyB,
          icon: Icons.numbers_outlined,
          body:
              'SystemUiOverlay only has two members today, but treat the '
              'enum as opaque. Match by name (top, bottom) and on the '
              'enum value itself, never by index — the order in '
              'SystemUiOverlay.values is not part of the public contract.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Mental model recap
  // ============================================================
  print('--- Section 8: Mental model ---');
  final mentalModel = _section(
    title: 'Mental model',
    subtitle: 'How to remember it without re-reading the docs.',
    accent: auroraB,
    child: Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [inkMid, orchidB],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: orchidB.withValues(alpha: 0.45),
            blurRadius: 22.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Three sentences:',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 14.0),
          Text(
            '1.  SystemUiOverlay names *which strip of OS chrome* you mean.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              height: 1.6,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            '2.  A List<SystemUiOverlay> is a set of *enabled* strips.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              height: 1.6,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            '3.  That set only matters under SystemUiMode.manual; '
            'all other modes hand the chrome decision to the platform.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              height: 1.6,
            ),
          ),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 9: Footer
  // ============================================================
  print('--- Section 9: Footer ---');
  final footer = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 36.0),
    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [inkDeep, inkMid],
      ),
      borderRadius: BorderRadius.circular(22.0),
      border: Border.all(color: Colors.white12, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: inkDeep.withValues(alpha: 0.6),
          blurRadius: 18.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [auroraA, auroraB]),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(
                Icons.code,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Text(
                'tom_d4rt_flutter_ast / send_ast_via_http_scripts /\n'
                'services / system_ui_overlay_test.dart',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Text(
            '+--------------------------------------------------+\n'
            '|  SystemUiOverlay.top     -> status  bar          |\n'
            '|  SystemUiOverlay.bottom  -> navigation bar       |\n'
            '|                                                  |\n'
            '|  combine as a List<SystemUiOverlay> and pass to  |\n'
            '|  SystemChrome.setEnabledSystemUIMode(            |\n'
            '|    SystemUiMode.manual,                          |\n'
            '|    overlays: <SystemUiOverlay>[ ... ],           |\n'
            '|  );                                              |\n'
            '+--------------------------------------------------+',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 12.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  print('=========================================================');
  print(' SystemUiOverlay deep demo composition complete.');
  print(' Sections rendered: 9. Returning root Column.');
  print('=========================================================');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(28.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        const SizedBox(height: 32.0),
        anatomy,
        const SizedBox(height: 32.0),
        perValueIntro,
        const SizedBox(height: 32.0),
        combinationGrid,
        const SizedBox(height: 32.0),
        pairingPanel,
        const SizedBox(height: 32.0),
        recipes,
        const SizedBox(height: 32.0),
        pitfalls,
        const SizedBox(height: 32.0),
        mentalModel,
        footer,
      ],
    ),
  );
}

// ============================================================
// Helpers — pure, stateless widget builders.
// ============================================================

Widget _heroChip(String label, Color a, Color b) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [a, b]),
      borderRadius: BorderRadius.circular(999.0),
      boxShadow: [
        BoxShadow(
          color: b.withValues(alpha: 0.45),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _section({
  required String title,
  required String subtitle,
  required Color accent,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(26.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.0),
      border: Border.all(color: accent.withValues(alpha: 0.25), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 22.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 6.0,
              height: 36.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [accent, accent.withValues(alpha: 0.4)],
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: accent,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        child,
      ],
    ),
  );
}

Widget _mockPhone({
  required String label,
  required bool showTop,
  required bool showBottom,
  bool highlightTop = false,
  bool highlightBottom = false,
  required List<Color> contentGradient,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 180.0,
        height: 320.0,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF111111), Color(0xFF333333)],
          ),
          borderRadius: BorderRadius.circular(36.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.45),
              blurRadius: 16.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28.0),
          child: Column(
            children: [
              _statusBar(visible: showTop, highlighted: highlightTop),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: contentGradient,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'app\ncontent',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ),
              _navBar(visible: showBottom, highlighted: highlightBottom),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10.0),
      Text(
        label,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 12.0,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );
}

Widget _statusBar({required bool visible, bool highlighted = false}) {
  if (!visible) {
    return Container(
      height: 22.0,
      color: Colors.black,
      alignment: Alignment.center,
      child: const Text(
        'top hidden',
        style: TextStyle(color: Colors.white24, fontSize: 9.0),
      ),
    );
  }
  return Container(
    height: 22.0,
    decoration: BoxDecoration(
      color: highlighted
          ? const Color(0xFF1FAB89).withValues(alpha: 0.85)
          : Colors.white.withValues(alpha: 0.92),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      children: [
        Text(
          '9:41',
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: highlighted ? Colors.white : Colors.black87,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.signal_cellular_alt,
          size: 11.0,
          color: highlighted ? Colors.white : Colors.black87,
        ),
        const SizedBox(width: 3.0),
        Icon(
          Icons.wifi,
          size: 11.0,
          color: highlighted ? Colors.white : Colors.black87,
        ),
        const SizedBox(width: 3.0),
        Icon(
          Icons.battery_full,
          size: 11.0,
          color: highlighted ? Colors.white : Colors.black87,
        ),
      ],
    ),
  );
}

Widget _navBar({required bool visible, bool highlighted = false}) {
  if (!visible) {
    return Container(
      height: 28.0,
      color: Colors.black,
      alignment: Alignment.center,
      child: const Text(
        'bottom hidden',
        style: TextStyle(color: Colors.white24, fontSize: 9.0),
      ),
    );
  }
  return Container(
    height: 28.0,
    decoration: BoxDecoration(
      color: highlighted
          ? const Color(0xFFB22667).withValues(alpha: 0.85)
          : Colors.white.withValues(alpha: 0.92),
    ),
    alignment: Alignment.center,
    child: Container(
      width: 60.0,
      height: 4.0,
      decoration: BoxDecoration(
        color: highlighted ? Colors.white : Colors.black87,
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
  );
}

Widget _anatomyRow({
  required Color color,
  required String title,
  required List<String> points,
}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.18),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8.0),
        for (final p in points)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, right: 8.0),
                  child: Container(
                    width: 6.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    p,
                    style: const TextStyle(
                      fontSize: 13.5,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _valueCard({
  required String name,
  required String tagline,
  required List<Color> gradient,
  required IconData icon,
  required String definition,
  required List<String> contents,
  required String ios,
  required String android,
  required int enabledIndex,
}) {
  return Container(
    width: 360.0,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: gradient.last.withValues(alpha: 0.35),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: gradient.last.withValues(alpha: 0.22),
          blurRadius: 18.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradient),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: gradient.last.withValues(alpha: 0.45),
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(icon, size: 22.0, color: Colors.white),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: gradient.last,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    tagline,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: gradient.last.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'index ${enabledIndex == 0 ? 'top' : 'bottom'}',
                style: TextStyle(
                  color: gradient.last,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        // Mock phone showing only this overlay enabled.
        Center(
          child: _mockPhone(
            label: enabledIndex == 0
                ? '[SystemUiOverlay.top]'
                : '[SystemUiOverlay.bottom]',
            showTop: enabledIndex == 0,
            showBottom: enabledIndex == 1,
            highlightTop: enabledIndex == 0,
            highlightBottom: enabledIndex == 1,
            contentGradient: gradient,
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          definition,
          style: const TextStyle(fontSize: 13.5, height: 1.55),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Typical contents',
          style: TextStyle(
            color: gradient.last,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 6.0),
        for (final c in contents)
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 6.0, right: 8.0),
                  child: Icon(Icons.circle, size: 5.0, color: Colors.black45),
                ),
                Expanded(
                  child: Text(
                    c,
                    style: const TextStyle(fontSize: 12.5, height: 1.45),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12.0),
        _platformNote(label: 'iOS', text: ios, color: const Color(0xFF1FAB89)),
        const SizedBox(height: 8.0),
        _platformNote(
          label: 'Android',
          text: android,
          color: const Color(0xFFED8F03),
        ),
      ],
    ),
  );
}

Widget _platformNote({
  required String label,
  required String text,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12.5, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

Widget _combinationCard({
  required String label,
  required String comment,
  required List<Color> gradient,
  required bool showTop,
  required bool showBottom,
  required Color accent,
}) {
  return Container(
    width: 240.0,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.35),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4.0),
        Text(
          comment,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        _mockPhone(
          label: '',
          showTop: showTop,
          showBottom: showBottom,
          highlightTop: showTop,
          highlightBottom: showBottom,
          contentGradient: gradient,
        ),
      ],
    ),
  );
}

Widget _modePairCard({
  required String title,
  required bool isPair,
  required Color color,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isPair ? Icons.check_circle : Icons.cancel,
              color: color,
              size: 18.0,
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          description,
          style: const TextStyle(fontSize: 12.0, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required int index,
  required String title,
  required String intent,
  required List<String> overlays,
  required List<String> notes,
  required List<Color> gradient,
  required bool showTop,
  required bool showBottom,
}) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          gradient.first.withValues(alpha: 0.08),
          gradient.last.withValues(alpha: 0.16),
        ],
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(
        color: gradient.last.withValues(alpha: 0.35),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: gradient.last.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradient),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: gradient.last.withValues(alpha: 0.4),
                blurRadius: 10.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Text(
            '#$index',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: gradient.last,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                intent,
                style: const TextStyle(fontSize: 13.0, height: 1.55),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'overlays: <SystemUiOverlay>[ '
                  '${overlays.isEmpty ? '/* empty */' : overlays.join(', ')} ]',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              for (final n in notes)
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 6.0,
                          right: 8.0,
                        ),
                        child: Container(
                          width: 5.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            color: gradient.last,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          n,
                          style: const TextStyle(
                            fontSize: 12.5,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        _mockPhone(
          label: '',
          showTop: showTop,
          showBottom: showBottom,
          highlightTop: showTop,
          highlightBottom: showBottom,
          contentGradient: gradient,
        ),
      ],
    ),
  );
}

Widget _pitfallCard({
  required String title,
  required Color color,
  required IconData icon,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                body,
                style: const TextStyle(fontSize: 13.0, height: 1.55),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

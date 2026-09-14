// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SystemSoundType from package:flutter/services.dart.
//
// Deep, instructive visual demo. SystemSoundType is the tiny enum the
// Flutter framework uses to ask the host platform to play one of the
// platform's standard, built-in UI sounds via SystemSound.play(...).
// We do NOT actually call SystemSound.play here — D4rt scripts run in a
// sandboxed visual context. Instead we paint mock waveforms, mock device
// frames, comparison tables and recipes that explain the *why* and *when*
// of each value.
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('SystemSoundType Deep Demo executing');
  print('Enumerating SystemSoundType.values...');
  for (final v in SystemSoundType.values) {
    print('  - SystemSoundType.${v.name} (index ${v.index}) toString=$v');
  }
  print('SystemSoundType has ${SystemSoundType.values.length} value(s).');
  print('First: ${SystemSoundType.values.first}');
  print('Last : ${SystemSoundType.values.last}');
  print('Reminder: this demo does NOT call SystemSound.play(...) — it only');
  print('describes the API and renders mock waveforms for each value.');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  final hero = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF0F2027),
          Color(0xFF203A43),
          Color(0xFF2C5364),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: const Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
          blurRadius: 40.0,
          offset: const Offset(0.0, 18.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.graphic_eq, size: 48.0, color: Colors.cyan.shade200),
            const SizedBox(width: 12.0),
            const Icon(Icons.volume_up, size: 56.0, color: Colors.white),
            const SizedBox(width: 12.0),
            Icon(Icons.notifications_active,
                size: 48.0, color: Colors.amber.shade200),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'SystemSoundType',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'package:flutter/services.dart',
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: 'monospace',
            color: Colors.cyan.shade100,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
                color: Colors.cyan.shade200.withValues(alpha: 0.5),
                width: 1.0),
          ),
          child: Text(
            'A tiny enum, a deep platform contract.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.cyan.shade50,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Section 1 (hero) built.');

  // ============================================================
  // SECTION 2: Concept primer — what are system sounds?
  // ============================================================
  final primer = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book,
                size: 24.0, color: Colors.blueGrey.shade700),
            const SizedBox(width: 8.0),
            Text(
              'Concept Primer',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _primerParagraph(
          'A "system sound" is a short audio cue owned by the host '
          'operating system, not by your app. iOS, Android, and the '
          'desktop OSes each ship a handful of these sounds — they are '
          'the keyboard click, the message bing, the dialog ping. They '
          'are intentionally small and consistent across apps so users '
          'recognise them at a subconscious level.',
        ),
        _primerParagraph(
          'Flutter does NOT ship its own audio. SystemSound.play(...) is '
          'a thin platform-channel call that says: "dear platform, please '
          'play your built-in sound of category <X>". The platform picks '
          'the actual file, the actual mixer routing, the actual volume '
          'envelope. SystemSoundType is the category selector.',
        ),
        _primerParagraph(
          'Because the OS owns playback, your app inherits the user\'s '
          'silent mode, Do Not Disturb, accessibility settings, and audio '
          'session policies for free. That is the whole point: never '
          'fight the platform on UI feedback sounds.',
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            border: Border(
              left: BorderSide(color: Colors.amber.shade700, width: 4.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb,
                  color: Colors.amber.shade800, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Rule of thumb: if you find yourself bundling a .wav '
                  'for a button click, you probably want SystemSoundType '
                  'instead. If you need a brand jingle, you do NOT want '
                  'SystemSoundType — use a real audio package.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.amber.shade900,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Section 2 (primer) built.');

  // ============================================================
  // SECTION 3: Per-value cards (one per enum value)
  // ============================================================
  final valueCards = <Widget>[];
  for (final value in SystemSoundType.values) {
    valueCards.add(_buildValueCard(value));
    print('Built value card for SystemSoundType.${value.name}');
  }
  print('Built ${valueCards.length} value cards total.');

  // ============================================================
  // SECTION 4: Mock device frames showing trigger UIs
  // ============================================================
  final triggerFrames = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.phone_iphone,
                size: 24.0, color: Colors.deepPurple.shade700),
            const SizedBox(width: 8.0),
            Text(
              'Mock device frames — what triggers each sound',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            _buildClickDeviceMock(),
            _buildAlertDeviceMock(),
          ],
        ),
      ],
    ),
  );
  print('Section 4 (device frames) built.');

  // ============================================================
  // SECTION 5: Recipes
  // ============================================================
  final recipes = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildRecipeCard(
        index: 1,
        title: 'Haptic-aligned button tap',
        accent: Colors.teal,
        icon: Icons.touch_app,
        description:
            'Pair a click with a light haptic so the press feels '
            'physical even on a glass screen.',
        code:
            '// In an onPressed handler:\n'
            'SystemSound.play(SystemSoundType.click);\n'
            'HapticFeedback.lightImpact();\n'
            '// Together they read as "yes, the button registered".',
        mock: _buildButtonRecipeMock(),
        notes: const [
          'Fire BOTH on the same gesture; ordering does not matter.',
          'On Android, click is intentionally quiet — never expect a',
          '  notification-grade chime.',
          'On iOS, system click respects the silent switch.',
        ],
      ),
      const SizedBox(height: 16.0),
      _buildRecipeCard(
        index: 2,
        title: 'Accessibility cue',
        accent: Colors.indigo,
        icon: Icons.accessibility_new,
        description:
            'Confirm a screen-reader-relevant action with a click '
            'so users with assistive tech get an extra non-visual '
            'confirmation.',
        code:
            '// When user toggles a setting via switch / slider:\n'
            'if (mediaQuery.accessibleNavigation) {\n'
            '  SystemSound.play(SystemSoundType.click);\n'
            '}',
        mock: _buildA11yRecipeMock(),
        notes: const [
          'Gate behind MediaQuery.accessibleNavigation OR an in-app',
          '  preference — never blanket-enable click for every tap.',
          'Pair with semantics labels, not as a replacement for them.',
        ],
      ),
      const SizedBox(height: 16.0),
      _buildRecipeCard(
        index: 3,
        title: 'Error confirmation',
        accent: Colors.red,
        icon: Icons.error_outline,
        description:
            'Use alert ONLY when the user must pause. A failed form '
            'save is alert-worthy; a hover state is not.',
        code:
            '// On a hard validation failure:\n'
            'if (!form.validate()) {\n'
            '  SystemSound.play(SystemSoundType.alert);\n'
            '  HapticFeedback.heavyImpact();\n'
            '  showDialog(...);\n'
            '}',
        mock: _buildErrorRecipeMock(),
        notes: const [
          'Alert is louder and longer than click — budget it carefully.',
          'Never loop alert; users will reach for the volume button.',
          'On web, alert may be a no-op — do NOT depend on it for safety.',
        ],
      ),
    ],
  );
  print('Section 5 (recipes) built — 3 recipes.');

  // ============================================================
  // SECTION 6: Comparison vs HapticFeedback
  // ============================================================
  final comparison = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows,
                size: 24.0, color: Colors.orange.shade800),
            const SizedBox(width: 8.0),
            Text(
              'SystemSound vs HapticFeedback',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'Both are "ask the platform to acknowledge a UI event" APIs. '
          'They are siblings — frequently used together, never '
          'substitutes for each other.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.orange.shade900,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16.0),
        _buildComparisonTable(),
      ],
    ),
  );
  print('Section 6 (comparison) built.');

  // ============================================================
  // SECTION 7: Pitfalls
  // ============================================================
  final pitfalls = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber,
                size: 24.0, color: Colors.red.shade700),
            const SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfallItem(
          'Over-triggering',
          'Firing click on every keystroke or every list-scroll tick '
          'is annoying. Budget click for *intentional* taps: buttons, '
          'switches, segmented controls. Never per-pixel.',
        ),
        _pitfallItem(
          'Silent mode is opaque',
          'You cannot read whether the user has the device on silent. '
          'You also cannot force playback through silent. That is by '
          'design — do not pile on a custom audio package to "fix" it.',
        ),
        _pitfallItem(
          'Web no-ops',
          'On Flutter Web, SystemSound.play(...) is largely a no-op. '
          'Browsers do not expose a uniform UI-sounds API. Treat any '
          'web-side call as best-effort and never gate UX on it.',
        ),
        _pitfallItem(
          'Linux / Windows patchy',
          'Desktop embedders historically have partial coverage. Check '
          'your target embedders before depending on SystemSound on '
          'desktop. The enum still compiles; the playback may not.',
        ),
        _pitfallItem(
          'Async without await',
          'SystemSound.play returns Future<void>. Awaiting blocks the '
          'event loop unnecessarily — fire-and-forget is the norm. '
          'But do NOT swallow exceptions if you wrap it in an async '
          'helper; log them.',
        ),
      ],
    ),
  );
  print('Section 7 (pitfalls) built.');

  // ============================================================
  // SECTION 8: API surface card
  // ============================================================
  final apiSurface = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'API Surface',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _buildCodeBlock(
          '// The enum (Flutter has grown it over time):\n'
          'enum SystemSoundType {\n'
          '  click, // short, low-emphasis tap acknowledgement\n'
          '  alert, // attention-grabbing alert / dialog ping\n'
          '  // additional values may exist on newer Flutter versions\n'
          '  // (e.g. tick) — always iterate .values defensively.\n'
          '}\n'
          '\n'
          '// Reflection — works at runtime:\n'
          'SystemSoundType.values         // List<SystemSoundType>\n'
          'SystemSoundType.values.length  // ${SystemSoundType.values.length}\n'
          'SystemSoundType.click.index    // ${SystemSoundType.click.index}\n'
          'SystemSoundType.click.name     // "${SystemSoundType.click.name}"\n'
          'SystemSoundType.alert.index    // ${SystemSoundType.alert.index}\n'
          'SystemSoundType.alert.name     // "${SystemSoundType.alert.name}"',
          Colors.cyanAccent.shade100,
        ),
        const SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Playback (NOT executed in this demo):\n'
          'await SystemSound.play(SystemSoundType.click);\n'
          'await SystemSound.play(SystemSoundType.alert);\n'
          '\n'
          '// Returns Future<void>. Fire-and-forget is fine.\n'
          '// Errors are platform-side; Dart side rarely throws.',
          Colors.lightGreenAccent.shade100,
        ),
      ],
    ),
  );
  print('Section 8 (API surface) built.');

  // ============================================================
  // SECTION 9: Footer
  // ============================================================
  final footerBox = StringBuffer()
    ..writeln('+----------------------------------------------------------+')
    ..writeln('|  SystemSoundType — deep visual demo                      |')
    ..writeln('|                                                          |')
    ..writeln('|  values   : ${SystemSoundType.values.length.toString().padRight(43)}|')
    ..writeln('|  first    : ${SystemSoundType.values.first.name.padRight(43)}|')
    ..writeln('|  last     : ${SystemSoundType.values.last.name.padRight(43)}|')
    ..writeln('|                                                          |')
    ..writeln('|  file:                                                   |')
    ..writeln('|    test/tom_d4rt_flutter_ast_app/test/                   |')
    ..writeln('|      send_ast_via_http_scripts/services/                 |')
    ..writeln('|        system_sound_type_test.dart                       |')
    ..writeln('+----------------------------------------------------------+');

  final footer = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
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
            Icon(Icons.terminal,
                size: 18.0, color: Colors.greenAccent.shade100),
            const SizedBox(width: 8.0),
            Text(
              'Footer',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.greenAccent.shade100,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          footerBox.toString(),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent.shade200,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
  print('Section 9 (footer) built.');

  print('SystemSoundType Deep Demo composed successfully.');

  // ============================================================
  // Compose
  // ============================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        const SizedBox(height: 24.0),
        _sectionHeading('1. Concept primer', Icons.menu_book),
        primer,
        const SizedBox(height: 24.0),
        _sectionHeading('2. Per-value cards', Icons.list_alt),
        ...valueCards,
        const SizedBox(height: 24.0),
        _sectionHeading('3. Mock device frames', Icons.phone_iphone),
        triggerFrames,
        const SizedBox(height: 24.0),
        _sectionHeading('4. Recipes', Icons.menu_book_outlined),
        recipes,
        const SizedBox(height: 24.0),
        _sectionHeading('5. SystemSound vs HapticFeedback',
            Icons.compare_arrows),
        comparison,
        const SizedBox(height: 24.0),
        _sectionHeading('6. Pitfalls', Icons.warning_amber),
        pitfalls,
        const SizedBox(height: 24.0),
        _sectionHeading('7. API surface', Icons.code),
        apiSurface,
        const SizedBox(height: 24.0),
        _sectionHeading('8. Footer', Icons.terminal),
        footer,
      ],
    ),
  );
}

// ============================================================
// Helpers — section heading
// ============================================================

Widget _sectionHeading(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.cyan.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, size: 18.0, color: Colors.white),
        ),
        const SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            color: Colors.indigo.shade900,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helpers — primer paragraph
// ============================================================

Widget _primerParagraph(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0, right: 8.0),
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade500,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.5,
              color: Colors.blueGrey.shade900,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helpers — per-value card
// ============================================================

Widget _buildValueCard(SystemSoundType value) {
  final meta = _metaFor(value);
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          meta.accent.withValues(alpha: 0.10),
          meta.accent.withValues(alpha: 0.04),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(
          color: meta.accent.withValues(alpha: 0.6), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: meta.accent.withValues(alpha: 0.25),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [meta.accent, meta.accent.withValues(alpha: 0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(
                    color: meta.accent.withValues(alpha: 0.40),
                    blurRadius: 8.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(meta.icon, color: Colors.white, size: 28.0),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SystemSoundType.${value.name}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                      color: meta.accent.shade900OrSelf,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    meta.tagline,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: meta.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                    color: meta.accent.withValues(alpha: 0.4), width: 1.0),
              ),
              child: Text(
                'index ${value.index}',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: meta.accent.shade900OrSelf,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // Definition
        _labelledBlock(
          label: 'Definition',
          accent: meta.accent,
          child: Text(
            meta.definition,
            style: TextStyle(
              fontSize: 13.5,
              color: Colors.grey.shade900,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 12.0),

        // When it fires
        _labelledBlock(
          label: 'When it fires',
          accent: meta.accent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final trigger in meta.triggers)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.arrow_right,
                          size: 18.0, color: meta.accent),
                      Expanded(
                        child: Text(
                          trigger,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey.shade800,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),

        // Mock waveform
        _labelledBlock(
          label: 'Mock waveform (illustration only)',
          accent: meta.accent,
          child: Container(
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10.0),
              border:
                  Border.all(color: meta.accent.withValues(alpha: 0.5)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CustomPaint(
                painter: _WaveformPainter(
                  kind: value,
                  color: meta.accent,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),

        // Platform notes
        _labelledBlock(
          label: 'Platform notes',
          accent: meta.accent,
          child: Column(
            children: [
              _platformRow('iOS', meta.iOSNote, Icons.phone_iphone),
              _platformRow('Android', meta.androidNote, Icons.android),
              _platformRow('Web', meta.webNote, Icons.public),
              _platformRow('Linux', meta.linuxNote, Icons.computer),
              _platformRow('Windows', meta.windowsNote, Icons.desktop_windows),
            ],
          ),
        ),
        const SizedBox(height: 12.0),

        // toString surface
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.label_important,
                  size: 16.0, color: Colors.cyan.shade200),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'toString() = "$value"   //  '
                  'name = "${value.name}"   index = ${value.index}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: Colors.cyan.shade100,
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

Widget _labelledBlock({
  required String label,
  required MaterialColor accent,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: accent.shade900OrSelf,
          ),
        ),
        const SizedBox(height: 8.0),
        child,
      ],
    ),
  );
}

Widget _platformRow(String name, String note, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.0,
          child: Row(
            children: [
              Icon(icon, size: 14.0, color: Colors.grey.shade700),
              const SizedBox(width: 6.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            note,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade800,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helpers — meta object
// ============================================================

class _ValueMeta {
  final IconData icon;
  final MaterialColor accent;
  final String tagline;
  final String definition;
  final List<String> triggers;
  final String iOSNote;
  final String androidNote;
  final String webNote;
  final String linuxNote;
  final String windowsNote;
  const _ValueMeta({
    required this.icon,
    required this.accent,
    required this.tagline,
    required this.definition,
    required this.triggers,
    required this.iOSNote,
    required this.androidNote,
    required this.webNote,
    required this.linuxNote,
    required this.windowsNote,
  });
}

_ValueMeta _metaFor(SystemSoundType value) {
  switch (value) {
    case SystemSoundType.click:
      return const _ValueMeta(
        icon: Icons.touch_app,
        accent: Colors.teal,
        tagline: 'A short, low-emphasis tap acknowledgement.',
        definition:
            'A quiet, sub-100ms cue that says "the system noticed your '
            'tap". It is intentionally unmemorable — the user feels it '
            'rather than hears it. Pair with a light haptic for the '
            'illusion of a physical button.',
        triggers: [
          'A user taps a primary button or list item.',
          'A switch or segmented control toggles by user gesture.',
          'A menu item activates from a keyboard accelerator.',
          'An accessibility-driven tap confirms a focused element.',
        ],
        iOSNote:
            'Plays a short keyboard-style click. Respects the silent '
            'switch — if silent, no audio.',
        androidNote:
            'Maps to the platform "key click" sound. Honors the system '
            'touch-sound toggle in Settings → Sounds.',
        webNote:
            'Generally a no-op. Browsers do not expose a uniform UI '
            'click sound. Treat as best-effort.',
        linuxNote:
            'Coverage depends on embedder; many builds no-op. Do not '
            'rely on audible feedback.',
        windowsNote:
            'Coverage depends on embedder; on most Windows builds this '
            'is a no-op or a tiny default click.',
      );
    case SystemSoundType.alert:
      return const _ValueMeta(
        icon: Icons.notifications_active,
        accent: Colors.deepOrange,
        tagline: 'An attention-grabbing alert / dialog ping.',
        definition:
            'A louder, longer cue used by the platform for modal alerts '
            'and dialogs. Reserve it for moments where the user MUST '
            'pause and read. Misusing alert is one of the fastest ways '
            'to make an app feel rude.',
        triggers: [
          'A modal alert dialog appears with a hard error.',
          'A blocking confirmation prompt opens (e.g. "Delete?").',
          'A required field validation fails on save.',
          'A safety-critical confirmation is shown to the user.',
        ],
        iOSNote:
            'Plays a system alert tone. Respects silent switch and Do '
            'Not Disturb — never assume the user heard it.',
        androidNote:
            'Mapped to the platform notification tone. Behavior varies '
            'across OEMs — Samsung, Pixel, and Xiaomi differ subtly.',
        webNote:
            'Largely a no-op on Flutter Web. Do NOT depend on it for '
            'safety-critical confirmations on web.',
        linuxNote:
            'May be a no-op or a generic system bell. Do not assume '
            'consistency across distributions.',
        windowsNote:
            'May map to the Windows default beep, or be silent depending '
            'on embedder version. Treat as advisory.',
      );
    default:
      // SystemSoundType has grown over time (e.g. tick). Treat unknown
      // entries as a generic "platform UI tick" so the demo still
      // describes them meaningfully without hard-coding a fragile list.
      return _ValueMeta(
        icon: Icons.graphic_eq,
        accent: Colors.indigo,
        tagline: 'A platform UI tick — fine-grained navigation cue.',
        definition:
            'A short scroll/selection tick used by the platform for '
            'fine-grained motion feedback (e.g. picker wheel detents '
            'on iOS). Like click, it should be paired with a haptic — '
            'on its own it is too subtle to notice. Falls back to a '
            'click-equivalent on platforms that do not implement it.',
        triggers: const [
          'A picker wheel passes a detent.',
          'A discrete slider snaps between values.',
          'A selection cursor moves between items via gesture.',
          'Any per-item motion that should feel "ratcheted".',
        ],
        iOSNote:
            'Plays the picker-wheel tick. Respects the silent switch.',
        androidNote:
            'May map to the same key-click as click; check device.',
        webNote: 'No-op on Flutter Web in practice.',
        linuxNote: 'Embedder-dependent; usually a no-op.',
        windowsNote: 'Embedder-dependent; usually a no-op.',
      );
  }
}

// MaterialColor extension surrogate via getter approximation.
// (We avoid extension methods to stay sandbox-friendly.)
extension on MaterialColor {
  Color get shade900OrSelf => this[900] ?? this;
}

// ============================================================
// Helpers — waveform painter
// ============================================================

class _WaveformPainter extends CustomPainter {
  final SystemSoundType kind;
  final Color color;
  const _WaveformPainter({required this.kind, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.black,
          color.withValues(alpha: 0.08),
          Colors.black,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    // grid
    final grid = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += size.width / 12) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += size.height / 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // axis
    final axis = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      axis,
    );

    // waveform
    final wave = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final mid = size.height / 2;
    final samples = 240;
    for (int i = 0; i < samples; i++) {
      final t = i / (samples - 1);
      final x = t * size.width;
      double amp;
      if (kind == SystemSoundType.click) {
        // very short, fast-decaying transient near the start
        final envelope = math.exp(-t * 14.0);
        amp = math.sin(t * 60.0) * envelope;
      } else if (kind == SystemSoundType.alert) {
        // alert: longer, two-note ping with slower decay
        final envelope = math.exp(-t * 3.0);
        final tone =
            math.sin(t * 22.0) * 0.6 + math.sin(t * 36.0 + 0.7) * 0.4;
        amp = tone * envelope;
      } else {
        // tick (or future): repeated tiny transients
        final envelope = math.exp(-((t - 0.5).abs()) * 6.0);
        final ratchet = (math.sin(t * 90.0) * 0.5 + 0.5) > 0.7 ? 1.0 : 0.0;
        amp = ratchet * envelope * (math.sin(t * 80.0));
      }
      final y = mid - amp * (size.height * 0.42);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, wave);

    // legend
    final tp = TextPainter(
      text: TextSpan(
        text: kind == SystemSoundType.click
            ? 'click ~ short transient, ~80ms'
            : kind == SystemSoundType.alert
                ? 'alert ~ two-tone ping, ~600ms'
                : '${kind.name} ~ ratcheted tick, ~120ms',
        style: TextStyle(
          color: color.withValues(alpha: 0.9),
          fontSize: 10.0,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 12.0);
    tp.paint(canvas, const Offset(8.0, 6.0));
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) =>
      oldDelegate.kind != kind || oldDelegate.color != color;
}

// ============================================================
// Helpers — mock device frames
// ============================================================

Widget _buildClickDeviceMock() {
  return Container(
    width: 240.0,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade800, Colors.grey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(28.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '9:41',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.signal_cellular_4_bar,
                      size: 12.0, color: Colors.grey.shade700),
                  const SizedBox(width: 4.0),
                  Icon(Icons.battery_full,
                      size: 12.0, color: Colors.grey.shade700),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            'Trigger: click',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800,
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade400, Colors.teal.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withValues(alpha: 0.4),
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.touch_app, color: Colors.white, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  'Tap me',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.teal.shade200),
            ),
            child: Text(
              '→ SystemSound.play(\n  SystemSoundType.click)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.teal.shade900,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAlertDeviceMock() {
  return Container(
    width: 240.0,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade800, Colors.grey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(28.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '9:41',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.signal_cellular_4_bar,
                      size: 12.0, color: Colors.grey.shade700),
                  const SizedBox(width: 4.0),
                  Icon(Icons.battery_full,
                      size: 12.0, color: Colors.grey.shade700),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            'Trigger: alert',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange.shade800,
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange.shade50, Colors.red.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.deepOrange.shade200),
            ),
            child: Column(
              children: [
                Icon(Icons.error,
                    size: 28.0, color: Colors.deepOrange.shade700),
                const SizedBox(height: 6.0),
                Text(
                  'Delete this account?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange.shade900,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'This action cannot be undone.',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.deepOrange.shade800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade50,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.deepOrange.shade200),
            ),
            child: Text(
              '→ SystemSound.play(\n  SystemSoundType.alert)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers — recipe card
// ============================================================

Widget _buildRecipeCard({
  required int index,
  required String title,
  required MaterialColor accent,
  required IconData icon,
  required String description,
  required String code,
  required Widget mock,
  required List<String> notes,
}) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.08),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
          color: accent.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent.shade400, accent.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Icon(icon, color: accent.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                  color: accent.shade900OrSelf,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.grey.shade800,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: _buildCodeBlock(code, accent.shade100),
            ),
            const SizedBox(width: 12.0),
            Expanded(flex: 2, child: mock),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: accent.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.notes,
                      size: 14.0, color: accent.shade700),
                  const SizedBox(width: 6.0),
                  Text(
                    'NOTES',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: accent.shade900OrSelf,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              for (final n in notes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    '• $n',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                      height: 1.35,
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

Widget _buildButtonRecipeMock() {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 18.0, vertical: 10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade400, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withValues(alpha: 0.4),
                blurRadius: 8.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check, color: Colors.white, size: 18.0),
              SizedBox(width: 6.0),
              Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'click + lightImpact',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.teal.shade800,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildA11yRecipeMock() {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'High contrast',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.indigo.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 32.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: Colors.indigo.shade600,
                borderRadius: BorderRadius.circular(9.0),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 14.0,
                  height: 14.0,
                  margin: const EdgeInsets.all(2.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'click on toggle change',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.indigo.shade800,
          ),
        ),
      ],
    ),
  );
}

Widget _buildErrorRecipeMock() {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      children: [
        Icon(Icons.error_outline,
            size: 28.0, color: Colors.red.shade700),
        const SizedBox(height: 6.0),
        Text(
          'Save failed',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.red.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'alert + heavyImpact',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.red.shade800,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helpers — comparison table
// ============================================================

Widget _buildComparisonTable() {
  final rows = <List<String>>[
    ['Channel', 'Audio (system speaker)', 'Vibration motor / Taptic'],
    ['Class', 'SystemSound', 'HapticFeedback'],
    ['Selector enum', 'SystemSoundType', 'no enum, distinct methods'],
    ['Variant count', '2-3 (click, alert, [tick])', '5+ (light/medium/heavy/...)'],
    ['User-controllable', 'Volume + silent switch', 'Vibrate setting'],
    ['Web support', 'Mostly no-op', 'Mostly no-op'],
    ['Best paired with', 'HapticFeedback', 'SystemSound'],
    ['Common abuse', 'Per-keystroke clicks', 'Per-scroll-pixel ticks'],
  ];

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade300),
    ),
    child: Column(
      children: [
        for (int i = 0; i < rows.length; i++)
          Container(
            decoration: BoxDecoration(
              color: i == 0
                  ? Colors.orange.shade100
                  : (i.isEven
                      ? Colors.orange.shade50
                      : Colors.white),
              border: Border(
                bottom: BorderSide(
                  color: Colors.orange.shade200,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: [
                _comparisonCell(rows[i][0],
                    width: 130.0,
                    bold: i == 0,
                    textColor: Colors.orange.shade900),
                _comparisonCell(rows[i][1],
                    width: 180.0,
                    bold: i == 0,
                    textColor: Colors.grey.shade900),
                _comparisonCell(rows[i][2],
                    width: 220.0,
                    bold: i == 0,
                    textColor: Colors.grey.shade900),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _comparisonCell(
  String text, {
  required double width,
  required bool bold,
  required Color textColor,
}) {
  return Container(
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: textColor,
        height: 1.3,
      ),
    ),
  );
}

// ============================================================
// Helpers — pitfall item
// ============================================================

Widget _pitfallItem(String title, String body) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0, right: 10.0),
          child: Icon(Icons.dangerous,
              size: 18.0, color: Colors.red.shade600),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey.shade900,
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

// ============================================================
// Helpers — code block
// ============================================================

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade700),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

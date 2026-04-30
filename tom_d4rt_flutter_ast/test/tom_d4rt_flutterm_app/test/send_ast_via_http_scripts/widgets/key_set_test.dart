// ignore_for_file: avoid_print
// D4rt deep demo: KeySet — keyboard key combination sets for shortcuts
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ── Mauve / Lavender palette ───────────────────────────────────────
  final deepMauve = const Color(0xFF6A3D7B);
  final softLavender = const Color(0xFFB39DDB);
  final heatherPurple = const Color(0xFF8E6FA0);
  final wisteria = const Color(0xFFA17BB8);
  final lilacGray = const Color(0xFFB0A4C7);
  final amethystHaze = const Color(0xFF9C89B8);
  final violetMist = const Color(0xFFD1C4E9);
  final dustyMauve = const Color(0xFF957DAA);
  final lavenderBlush = const Color(0xFFF3E5F5);
  final grapeLight = const Color(0xFFCE93D8);

  // ── helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: fg,
                  letterSpacing: 0.3)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: fg.withValues(alpha: 0.75),
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: border, height: 1.5)),
    );
  }

  Widget infoCard(String label, String value, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: accent)),
          ),
          Text(value,
              style: TextStyle(
                  fontSize: 11,
                  color: accent.withValues(alpha: 0.8),
                  fontFamily: 'monospace')),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          Text(text, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
    );
  }

  Widget dataRow(String key, String val, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(key,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: accent)),
          ),
          Expanded(
            child: Text(val,
                style: TextStyle(
                    fontSize: 11,
                    color: accent.withValues(alpha: 0.8),
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black12),
          ),
        ),
        const SizedBox(height: 3),
        Text(label,
            style: const TextStyle(fontSize: 8, color: Colors.black54)),
      ],
    );
  }

  Widget keyChip(String key, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 4, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(key,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: fg,
              fontFamily: 'monospace')),
    );
  }

  Widget shortcutRow(String combo, String action, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 130,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(combo,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: accent,
                    fontFamily: 'monospace')),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(action,
                style: TextStyle(
                    fontSize: 11,
                    color: accent.withValues(alpha: 0.8))),
          ),
        ],
      ),
    );
  }

  Widget metricTile(String label, String value, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: fg)),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(fontSize: 9, color: fg.withValues(alpha: 0.7))),
        ],
      ),
    );
  }

  // ── data ───────────────────────────────────────────────────────────
  print('KeySet deep demo executing');
  print('=' * 60);

  // Section 3 — single key
  final singleA = KeySet<LogicalKeyboardKey>(LogicalKeyboardKey.keyA);
  print('\n--- Single-key KeySet ---');
  print('KeySet(keyA).keys.length: ${singleA.keys.length}');
  print('Keys: ${singleA.keys}');

  // Section 4 — two-key modifier combos
  final ctrlC = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control, LogicalKeyboardKey.keyC);
  final ctrlV = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control, LogicalKeyboardKey.keyV);
  final ctrlX = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control, LogicalKeyboardKey.keyX);
  final ctrlZ = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ);
  final altTab = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.alt, LogicalKeyboardKey.tab);
  final shiftTab = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.shift, LogicalKeyboardKey.tab);
  print('\n--- Two-key combos ---');
  print('Ctrl+C keys: ${ctrlC.keys.length}');
  print('Ctrl+V keys: ${ctrlV.keys.length}');
  print('Ctrl+X keys: ${ctrlX.keys.length}');
  print('Alt+Tab keys: ${altTab.keys.length}');

  // Section 5 — triple combos
  final ctrlShiftS = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.keyS);
  final ctrlShiftN = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.keyN);
  final ctrlAltDel = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.delete);
  print('\n--- Triple combos ---');
  print('Ctrl+Shift+S keys: ${ctrlShiftS.keys.length}');
  print('Ctrl+Shift+N keys: ${ctrlShiftN.keys.length}');
  print('Ctrl+Alt+Del keys: ${ctrlAltDel.keys.length}');

  // Section 6 — quad combos
  final quadCombo = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.keyF);
  print('\n--- Quad combo ---');
  print('Ctrl+Shift+Alt+F keys: ${quadCombo.keys.length}');

  // Section 7 — fromSet
  final fromSetCombo = KeySet<LogicalKeyboardKey>.fromSet({
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.keyV,
  });
  final fromSetTriple = KeySet<LogicalKeyboardKey>.fromSet({
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.keyP,
  });
  print('\n--- fromSet factory ---');
  print('fromSet(meta+V) keys: ${fromSetCombo.keys.length}');
  print('fromSet(ctrl+shift+P) keys: ${fromSetTriple.keys.length}');

  // Section 8 — equality
  final copyA = KeySet<LogicalKeyboardKey>(LogicalKeyboardKey.keyA);
  final copyCtrlC = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control, LogicalKeyboardKey.keyC);
  print('\n--- Equality ---');
  print('singleA == copyA: ${singleA == copyA}');
  print('ctrlC == copyCtrlC: ${ctrlC == copyCtrlC}');
  print('singleA == ctrlC: ${singleA == ctrlC}');

  // Section 9 — hashCode
  print('\n--- HashCode ---');
  print('singleA.hashCode: ${singleA.hashCode}');
  print('copyA.hashCode: ${copyA.hashCode}');
  print('Match: ${singleA.hashCode == copyA.hashCode}');
  print('ctrlC.hashCode: ${ctrlC.hashCode}');
  print('copyCtrlC.hashCode: ${copyCtrlC.hashCode}');
  print('Match: ${ctrlC.hashCode == copyCtrlC.hashCode}');

  // Section 10 — keys getter
  final keysResult = singleA.keys;
  print('\n--- Keys getter ---');
  print('keysResult is Set: true (Set<LogicalKeyboardKey>)');
  print('keysResult.length: ${keysResult.length}');
  print('ctrlShiftS.keys: ${ctrlShiftS.keys}');

  // Section 11 — common shortcuts
  print('\n--- Common shortcuts ---');
  final ctrlA = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control, LogicalKeyboardKey.keyA);
  final ctrlS = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control, LogicalKeyboardKey.keyS);
  final ctrlF = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control, LogicalKeyboardKey.keyF);
  print('Select all: Ctrl+A (${ctrlA.keys.length} keys)');
  print('Save: Ctrl+S (${ctrlS.keys.length} keys)');
  print('Find: Ctrl+F (${ctrlF.keys.length} keys)');

  // Section 12 — platform shortcuts
  final metaC = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.meta, LogicalKeyboardKey.keyC);
  final metaV = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.meta, LogicalKeyboardKey.keyV);
  print('\n--- Platform shortcuts ---');
  print('macOS Cmd+C: ${metaC.keys.length} keys');
  print('macOS Cmd+V: ${metaV.keys.length} keys');

  // Section 13 — navigation keys
  final ctrlHome = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control, LogicalKeyboardKey.home);
  final ctrlEnd = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control, LogicalKeyboardKey.end);
  print('\n--- Navigation keys ---');
  print('Ctrl+Home: ${ctrlHome.keys.length} keys');
  print('Ctrl+End: ${ctrlEnd.keys.length} keys');

  // Section 14 — text editing
  final ctrlShiftLeft = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.arrowLeft);
  final ctrlShiftRight = KeySet<LogicalKeyboardKey>(
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.arrowRight);
  print('\n--- Text editing ---');
  print('Ctrl+Shift+Left: ${ctrlShiftLeft.keys.length} keys');
  print('Ctrl+Shift+Right: ${ctrlShiftRight.keys.length} keys');

  // Section 15 — comparison matrix
  final allSets = [singleA, ctrlC, ctrlShiftS, quadCombo, fromSetCombo];
  print('\n--- Comparison matrix ---');
  for (final s in allSets) {
    print('  ${s.keys.length} keys → hashCode ${s.hashCode}');
  }

  print('\n${'=' * 60}');
  print('KeySet deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        sectionBanner(
          '1 · KeySet Showcase',
          'Keyboard key combination sets for shortcut definitions',
          deepMauve,
          Colors.white,
        ),

        // ── 2. Concept overview ──────────────────────────────────────
        sectionBanner('2 · Concept Overview',
            'Understanding keyboard key sets', heatherPurple, Colors.white),
        noteBox(
          'KeySet<T extends KeyboardKey> encapsulates a set of keys that '
          'together form a keyboard shortcut. It supports 1–4 keys in the '
          'positional constructor and any number via KeySet.fromSet(). '
          'It provides value-based equality so two KeySets with the same '
          'keys are considered equal regardless of construction order.',
          deepMauve,
          lavenderBlush,
        ),
        noteBox(
          'KeySet is commonly used with ShortcutActivator and CallbackShortcuts '
          'to bind keyboard combinations to actions in Flutter applications. '
          'Modifier keys (Ctrl, Shift, Alt, Meta) are typically combined with '
          'character keys to form meaningful shortcuts.',
          heatherPurple,
          violetMist,
        ),
        infoCard('Class', 'KeySet<T extends KeyboardKey>', deepMauve),
        infoCard('Package', 'package:flutter/widgets.dart', wisteria),
        infoCard('Equality', 'Value-based (same keys = equal)', amethystHaze),
        infoCard('Max positional', '4 keys', dustyMauve),
        const SizedBox(height: 14),

        // ── 3. Single key display ────────────────────────────────────
        sectionBanner('3 · Single-Key Sets',
            'KeySet with one key', softLavender, deepMauve),
        noteBox(
          'A KeySet can hold a single key. This is useful for shortcuts '
          'that respond to a single key press without modifiers, such as '
          'function keys or special keys.',
          wisteria,
          lavenderBlush,
        ),
        dataRow('Constructor', 'KeySet(LogicalKeyboardKey.keyA)', deepMauve),
        dataRow('keys.length', '${singleA.keys.length}', heatherPurple),
        dataRow('keys', '${singleA.keys}', wisteria),
        dataRow('runtimeType', '${singleA.runtimeType}', amethystHaze),
        const SizedBox(height: 8),
        Wrap(children: [
          keyChip('A', deepMauve, Colors.white),
        ]),
        const SizedBox(height: 6),
        noteBox(
          'Single-key sets are used for function key shortcuts (F1-F12), '
          'Escape key handling, Delete, Backspace, and other standalone keys.',
          dustyMauve,
          violetMist,
        ),
        const SizedBox(height: 14),

        // ── 4. Two-key modifier grid ─────────────────────────────────
        sectionBanner('4 · Two-Key Modifier Combos',
            'Modifier + character key pairs', wisteria, Colors.white),
        noteBox(
          'The most common shortcut pattern is a modifier key combined with '
          'a character key. Ctrl+C for copy, Ctrl+V for paste, Alt+Tab for '
          'switching — these are all two-key KeySets.',
          deepMauve,
          lavenderBlush,
        ),
        dataRow('Ctrl+C', '${ctrlC.keys.length} keys → ${ctrlC.keys}', deepMauve),
        dataRow('Ctrl+V', '${ctrlV.keys.length} keys → ${ctrlV.keys}', heatherPurple),
        dataRow('Ctrl+X', '${ctrlX.keys.length} keys → ${ctrlX.keys}', wisteria),
        dataRow('Ctrl+Z', '${ctrlZ.keys.length} keys → ${ctrlZ.keys}', amethystHaze),
        dataRow('Alt+Tab', '${altTab.keys.length} keys → ${altTab.keys}', dustyMauve),
        dataRow('Shift+Tab', '${shiftTab.keys.length} keys → ${shiftTab.keys}', grapeLight),
        const SizedBox(height: 8),
        Wrap(children: [
          keyChip('Ctrl', deepMauve, Colors.white),
          keyChip('+', lilacGray, deepMauve),
          keyChip('C', softLavender, deepMauve),
          const SizedBox(width: 12),
          keyChip('Ctrl', deepMauve, Colors.white),
          keyChip('+', lilacGray, deepMauve),
          keyChip('V', softLavender, deepMauve),
          const SizedBox(width: 12),
          keyChip('Alt', heatherPurple, Colors.white),
          keyChip('+', lilacGray, deepMauve),
          keyChip('Tab', softLavender, deepMauve),
        ]),
        const SizedBox(height: 14),

        // ── 5. Triple combos ─────────────────────────────────────────
        sectionBanner('5 · Triple-Key Combinations',
            'Three keys pressed simultaneously', amethystHaze, Colors.white),
        noteBox(
          'Triple-key combos use two modifiers plus a character key. '
          'Ctrl+Shift+S for "Save As", Ctrl+Alt+Delete for system interrupt — '
          'these require three keys in the KeySet.',
          deepMauve,
          lavenderBlush,
        ),
        dataRow('Ctrl+Shift+S', '${ctrlShiftS.keys.length} keys', deepMauve),
        dataRow('keys', '${ctrlShiftS.keys}', heatherPurple),
        dataRow('Ctrl+Shift+N', '${ctrlShiftN.keys.length} keys', wisteria),
        dataRow('keys', '${ctrlShiftN.keys}', amethystHaze),
        dataRow('Ctrl+Alt+Del', '${ctrlAltDel.keys.length} keys', dustyMauve),
        dataRow('keys', '${ctrlAltDel.keys}', grapeLight),
        const SizedBox(height: 8),
        Wrap(children: [
          keyChip('Ctrl', deepMauve, Colors.white),
          keyChip('+', lilacGray, deepMauve),
          keyChip('Shift', heatherPurple, Colors.white),
          keyChip('+', lilacGray, deepMauve),
          keyChip('S', softLavender, deepMauve),
        ]),
        const SizedBox(height: 14),

        // ── 6. Quad combos ───────────────────────────────────────────
        sectionBanner('6 · Quad-Key Combinations',
            'Maximum positional constructor capacity', dustyMauve, Colors.white),
        noteBox(
          'The positional constructor accepts up to 4 keys. For combos with '
          'more than 4 keys, use KeySet.fromSet(). Four-key combos are rare '
          'but exist in power-user applications.',
          deepMauve,
          lavenderBlush,
        ),
        dataRow('Ctrl+Shift+Alt+F', '${quadCombo.keys.length} keys', deepMauve),
        dataRow('keys', '${quadCombo.keys}', heatherPurple),
        const SizedBox(height: 8),
        Wrap(children: [
          keyChip('Ctrl', deepMauve, Colors.white),
          keyChip('+', lilacGray, deepMauve),
          keyChip('Shift', heatherPurple, Colors.white),
          keyChip('+', lilacGray, deepMauve),
          keyChip('Alt', wisteria, Colors.white),
          keyChip('+', lilacGray, deepMauve),
          keyChip('F', softLavender, deepMauve),
        ]),
        noteBox(
          'Four-key shortcuts are uncommon in standard applications but can '
          'be useful in professional software like IDEs, video editors, and '
          'music production tools where keybinding space is limited.',
          heatherPurple,
          violetMist,
        ),
        const SizedBox(height: 14),

        // ── 7. fromSet factory ───────────────────────────────────────
        sectionBanner('7 · KeySet.fromSet Factory',
            'Creating key sets from Set<T>', lilacGray, deepMauve),
        noteBox(
          'KeySet.fromSet() creates a KeySet from a Dart Set. This is useful '
          'when the keys are determined at runtime or when you need more than '
          '4 keys (though >4 modifiers is extremely rare).',
          deepMauve,
          lavenderBlush,
        ),
        dataRow('fromSet({meta,V})', '${fromSetCombo.keys.length} keys', deepMauve),
        dataRow('keys', '${fromSetCombo.keys}', heatherPurple),
        dataRow('fromSet({ctrl,shift,P})', '${fromSetTriple.keys.length} keys', wisteria),
        dataRow('keys', '${fromSetTriple.keys}', amethystHaze),
        noteBox(
          'The fromSet constructor is particularly useful in shortcut '
          'configuration systems where key combinations are loaded from '
          'user preferences or configuration files.',
          dustyMauve,
          violetMist,
        ),
        const SizedBox(height: 14),

        // ── 8. Equality checker ──────────────────────────────────────
        sectionBanner('8 · Equality Behavior',
            'Value-based equality comparison', softLavender, deepMauve),
        noteBox(
          'KeySet uses value-based equality. Two KeySets containing the same '
          'keys are equal regardless of construction method or order. This is '
          'essential for shortcut lookup tables.',
          deepMauve,
          lavenderBlush,
        ),
        dataRow('singleA == copyA', '${singleA == copyA}', deepMauve),
        dataRow('ctrlC == copyCtrlC', '${ctrlC == copyCtrlC}', heatherPurple),
        dataRow('singleA == ctrlC', '${singleA == ctrlC}', wisteria),
        dataRow('Same content', 'Always equal', amethystHaze),
        dataRow('Different content', 'Never equal', dustyMauve),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: deepMauve.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepMauve.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Equality Matrix',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: deepMauve)),
              const SizedBox(height: 6),
              dataRow('KeySet(A) == KeySet(A)', 'true ✓', deepMauve),
              dataRow('KeySet(A) == KeySet(B)', 'false ✗', heatherPurple),
              dataRow('Ctrl+C == Ctrl+C', 'true ✓', wisteria),
              dataRow('Ctrl+C == Ctrl+V', 'false ✗', amethystHaze),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. HashCode inspector ────────────────────────────────────
        sectionBanner('9 · HashCode Behavior',
            'Consistent hashing for map keys', wisteria, Colors.white),
        noteBox(
          'KeySet overrides hashCode to be consistent with equality. '
          'Equal KeySets produce the same hashCode, making them safe to '
          'use as Map keys and in Sets.',
          deepMauve,
          lavenderBlush,
        ),
        dataRow('singleA.hashCode', '${singleA.hashCode}', deepMauve),
        dataRow('copyA.hashCode', '${copyA.hashCode}', heatherPurple),
        dataRow('Hashes match', '${singleA.hashCode == copyA.hashCode}', wisteria),
        dataRow('ctrlC.hashCode', '${ctrlC.hashCode}', amethystHaze),
        dataRow('copyCtrlC.hashCode', '${copyCtrlC.hashCode}', dustyMauve),
        dataRow('Hashes match', '${ctrlC.hashCode == copyCtrlC.hashCode}', grapeLight),
        noteBox(
          'Hash consistency means KeySets can serve as keys in '
          'Map<KeySet, VoidCallback> structures — the foundation of '
          'Flutter\'s shortcut binding system.',
          heatherPurple,
          violetMist,
        ),
        const SizedBox(height: 14),

        // ── 10. Keys access panel ────────────────────────────────────
        sectionBanner('10 · Keys Getter',
            'Accessing the underlying key set', amethystHaze, Colors.white),
        noteBox(
          'The keys getter returns a Set<T> containing all keys in the '
          'KeySet. The returned set is used for display and comparison. '
          'Modifying the returned set does not affect the original KeySet.',
          deepMauve,
          lavenderBlush,
        ),
        dataRow('singleA.keys', '${singleA.keys}', deepMauve),
        dataRow('Type', '${keysResult.runtimeType}', heatherPurple),
        dataRow('Is Set', 'true', wisteria),
        dataRow('ctrlC.keys', '${ctrlC.keys}', amethystHaze),
        dataRow('ctrlShiftS.keys', '${ctrlShiftS.keys}', dustyMauve),
        dataRow('quadCombo.keys', '${quadCombo.keys}', grapeLight),
        const SizedBox(height: 14),

        // ── 11. Common shortcuts table ───────────────────────────────
        sectionBanner('11 · Common Shortcut Patterns',
            'Standard keyboard shortcuts', deepMauve, Colors.white),
        noteBox(
          'Standard shortcuts follow platform conventions. On Linux/Windows, '
          'Ctrl is the primary modifier. On macOS, Meta (Cmd) takes that role. '
          'KeySet represents these combos consistently.',
          heatherPurple,
          lavenderBlush,
        ),
        shortcutRow('Ctrl+A', 'Select all', deepMauve),
        shortcutRow('Ctrl+C', 'Copy', heatherPurple),
        shortcutRow('Ctrl+V', 'Paste', wisteria),
        shortcutRow('Ctrl+X', 'Cut', amethystHaze),
        shortcutRow('Ctrl+Z', 'Undo', dustyMauve),
        shortcutRow('Ctrl+S', 'Save', grapeLight),
        shortcutRow('Ctrl+F', 'Find', lilacGray),
        shortcutRow('Ctrl+N', 'New', softLavender),
        dataRow('Select all keys', '${ctrlA.keys.length}', deepMauve),
        dataRow('Save keys', '${ctrlS.keys.length}', heatherPurple),
        dataRow('Find keys', '${ctrlF.keys.length}', wisteria),
        const SizedBox(height: 14),

        // ── 12. Platform shortcuts grid ──────────────────────────────
        sectionBanner('12 · Platform-Specific Shortcuts',
            'macOS Meta vs Linux/Windows Ctrl', softLavender, deepMauve),
        noteBox(
          'Different platforms use different modifier keys. Flutter\'s '
          'shortcut system allows defining platform-specific bindings '
          'using different KeySets for the same action.',
          deepMauve,
          lavenderBlush,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: heatherPurple.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Copy Action',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepMauve)),
              const SizedBox(height: 6),
              dataRow('Linux/Windows', 'Ctrl+C (${ctrlC.keys.length} keys)', deepMauve),
              dataRow('macOS', 'Meta+C (${metaC.keys.length} keys)', heatherPurple),
              const SizedBox(height: 8),
              Text('Paste Action',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepMauve)),
              const SizedBox(height: 6),
              dataRow('Linux/Windows', 'Ctrl+V (${ctrlV.keys.length} keys)', wisteria),
              dataRow('macOS', 'Meta+V (${metaV.keys.length} keys)', amethystHaze),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Navigation keys panel ────────────────────────────────
        sectionBanner('13 · Navigation Key Combinations',
            'Movement and scrolling shortcuts', heatherPurple, Colors.white),
        noteBox(
          'Navigation shortcuts combine modifiers with arrow keys, Home, '
          'End, Page Up, and Page Down. These are crucial for text editing '
          'and document navigation.',
          deepMauve,
          lavenderBlush,
        ),
        shortcutRow('Ctrl+Home', 'Go to beginning', deepMauve),
        shortcutRow('Ctrl+End', 'Go to end', heatherPurple),
        shortcutRow('Ctrl+←', 'Word left', wisteria),
        shortcutRow('Ctrl+→', 'Word right', amethystHaze),
        shortcutRow('Alt+↑', 'Move line up', dustyMauve),
        shortcutRow('Alt+↓', 'Move line down', grapeLight),
        dataRow('Ctrl+Home count', '${ctrlHome.keys.length}', deepMauve),
        dataRow('Ctrl+End count', '${ctrlEnd.keys.length}', heatherPurple),
        const SizedBox(height: 14),

        // ── 14. Text editing keys card ───────────────────────────────
        sectionBanner('14 · Text Editing Shortcuts',
            'Selection and manipulation combos', dustyMauve, Colors.white),
        noteBox(
          'Text editing shortcuts often use three keys: Ctrl+Shift+arrow '
          'for word selection, Ctrl+Shift+Home/End for document selection. '
          'These triple-key combos are common in text editors.',
          deepMauve,
          lavenderBlush,
        ),
        shortcutRow('Ctrl+Shift+←', 'Select word left', deepMauve),
        shortcutRow('Ctrl+Shift+→', 'Select word right', heatherPurple),
        shortcutRow('Ctrl+Shift+S', 'Save as', wisteria),
        shortcutRow('Ctrl+Shift+N', 'New window', amethystHaze),
        shortcutRow('Ctrl+Shift+F', 'Find in files', dustyMauve),
        shortcutRow('Ctrl+Shift+P', 'Command palette', grapeLight),
        dataRow('Ctrl+Shift+Left', '${ctrlShiftLeft.keys.length} keys', deepMauve),
        dataRow('Ctrl+Shift+Right', '${ctrlShiftRight.keys.length} keys', heatherPurple),
        const SizedBox(height: 14),

        // ── 15. Comparison matrix ────────────────────────────────────
        sectionBanner('15 · KeySet Comparison Matrix',
            'Comparing different key set sizes', lilacGray, deepMauve),
        noteBox(
          'KeySets of different sizes are never equal. The comparison is '
          'strictly based on the contained keys — size, identity, and '
          'completeness all matter.',
          deepMauve,
          lavenderBlush,
        ),
        ...allSets.asMap().entries.map((entry) {
          final s = entry.value;
          final colors = [deepMauve, heatherPurple, wisteria, amethystHaze, dustyMauve];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors[entry.key].withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors[entry.key].withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors[entry.key],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('${entry.key + 1}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${s.keys.length} key(s)',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colors[entry.key])),
                      Text('hashCode: ${s.hashCode}',
                          style: TextStyle(
                              fontSize: 10,
                              color: colors[entry.key].withValues(alpha: 0.7),
                              fontFamily: 'monospace')),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 14),

        // ── 16. Summary dashboard ────────────────────────────────────
        sectionBanner('16 · Summary Dashboard',
            'KeySet metrics and patterns', deepMauve, Colors.white),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            metricTile('Single sets', '1', lavenderBlush, deepMauve),
            metricTile('Two-key sets', '6', violetMist, heatherPurple),
            metricTile('Triple sets', '3', lavenderBlush, wisteria),
            metricTile('Quad sets', '1', violetMist, amethystHaze),
            metricTile('fromSet', '2', lavenderBlush, dustyMauve),
            metricTile('Equality ✓', '3', violetMist, grapeLight),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          children: [
            tag('KeySet', deepMauve, Colors.white),
            tag('LogicalKeyboardKey', heatherPurple, Colors.white),
            tag('Shortcuts', wisteria, Colors.white),
            tag('Value equality', amethystHaze, Colors.white),
            tag('fromSet', dustyMauve, Colors.white),
            tag('Modifiers', grapeLight, Colors.white),
            tag('Platform keys', lilacGray, deepMauve),
            tag('Navigation', softLavender, deepMauve),
          ],
        ),
        const SizedBox(height: 12),

        // Palette display
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: lavenderBlush,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepMauve.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mauve / Lavender Palette',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: deepMauve)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  colorSwatch('deepMauve', deepMauve),
                  colorSwatch('softLavender', softLavender),
                  colorSwatch('heather', heatherPurple),
                  colorSwatch('wisteria', wisteria),
                  colorSwatch('lilacGray', lilacGray),
                  colorSwatch('amethyst', amethystHaze),
                  colorSwatch('violetMist', violetMist),
                  colorSwatch('dustyMauve', dustyMauve),
                  colorSwatch('lavBlush', lavenderBlush),
                  colorSwatch('grapeLight', grapeLight),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}

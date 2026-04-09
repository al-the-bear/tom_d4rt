// ignore_for_file: avoid_print, deprecated_member_use
// D4rt deep demo: LogicalKeySet — keyboard shortcut key combinations
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ── Palette: Onyx / Obsidian ───────────────────────────────────────
  const onyx = Color(0xFF0D0D0D);
  const obsidian = Color(0xFF1A1A2E);
  const darkSlate = Color(0xFF16213E);
  const midnight = Color(0xFF0F3460);
  const steelAccent = Color(0xFF533483);
  const neonCyan = Color(0xFF00D9FF);
  const glowPurple = Color(0xFFE94560);
  const surfaceGrey = Color(0xFF1E1E2E);
  const dimText = Color(0xFFCDD6F4);
  const brightWhite = Color(0xFFF5F5F5);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.82)],
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
                      color: fg.withValues(alpha: 0.8), fontSize: 12)),
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
      child: Text(text, style: TextStyle(fontSize: 13, color: dimText)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
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
                style: TextStyle(fontSize: 13, color: dimText)),
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

  Widget keyChip(String label, {bool isModifier = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 4, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isModifier ? midnight : surfaceGrey,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: isModifier ? neonCyan.withValues(alpha: 0.5) : steelAccent.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: (isModifier ? neonCyan : steelAccent).withValues(alpha: 0.12),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: isModifier ? neonCyan : dimText)),
    );
  }

  // ── Gather data ────────────────────────────────────────────────────
  print('LogicalKeySet deep demo executing');
  print('=' * 60);

  // Create various key sets
  final singleKey = LogicalKeySet(LogicalKeyboardKey.keyA);
  final ctrlC = LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC);
  final ctrlShiftZ = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.keyZ,
  );
  final ctrlAltDel = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.delete,
  );
  final fromSetExample = LogicalKeySet.fromSet({
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.keyN,
  });

  // Section 1
  print('\n--- What is LogicalKeySet ---');
  print('A set of LogicalKeyboardKey objects used as ShortcutActivator');
  print('Extends KeySet<LogicalKeyboardKey>');

  // Section 2
  print('\n--- Key sets created ---');
  print('singleKey (A): keys=${singleKey.keys}');
  print('ctrlC: keys=${ctrlC.keys}');
  print('ctrlShiftZ: keys=${ctrlShiftZ.keys}');

  // Section 3 — triggers
  print('\n--- Triggers ---');
  print('singleKey triggers: ${singleKey.triggers}');
  print('ctrlC triggers: ${ctrlC.triggers}');

  // Section 4 — equality
  print('\n--- Equality ---');
  final ctrlC2 = LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC);
  print('ctrlC == ctrlC2: ${ctrlC == ctrlC2}');
  print('ctrlC == ctrlShiftZ: ${ctrlC == ctrlShiftZ}');

  print('\n${'=' * 60}');
  print('LogicalKeySet deep demo completed');

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
              colors: [onyx, obsidian, darkSlate],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: steelAccent.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.keyboard, size: 28, color: neonCyan),
                  const SizedBox(width: 10),
                  const Text('LogicalKeySet',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              Text('Keyboard shortcut key combinations for the Shortcuts widget',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('ShortcutActivator', midnight, neonCyan),
                tag('KeySet', darkSlate, dimText),
                tag('Deprecated', glowPurple.withValues(alpha: 0.3), glowPurple),
                tag('Shortcuts Widget', steelAccent, dimText),
              ]),
            ],
          ),
        ),

        // ── 2. What is LogicalKeySet ─────────────────────────────────
        sectionBanner('1 \u00b7 What Is LogicalKeySet',
            'A set of logical keys that defines a keyboard shortcut',
            obsidian, brightWhite),
        noteBox(
          'LogicalKeySet represents a combination of keyboard keys that, '
          'when all pressed simultaneously, should trigger a shortcut '
          'action. It extends KeySet<LogicalKeyboardKey> and implements '
          'ShortcutActivator, making it directly usable in the Shortcuts '
          'widget. While now deprecated in favor of SingleActivator, it '
          'remains widely used in existing codebases.',
          neonCyan,
          surfaceGrey,
        ),
        dataRow('Superclass', 'KeySet<LogicalKeyboardKey>', neonCyan),
        dataRow('Implements', 'ShortcutActivator, Diagnosticable', steelAccent),
        dataRow('Location', 'package:flutter/widgets.dart (shortcuts.dart)', midnight),
        dataRow('Status', 'Deprecated — use SingleActivator instead', glowPurple),
        const SizedBox(height: 14),

        // ── 3. Creating key sets ─────────────────────────────────────
        sectionBanner('2 \u00b7 Creating Key Sets',
            'Positional constructor and fromSet factory',
            darkSlate, brightWhite),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Positional Constructor (up to 4 keys):',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: neonCyan)),
              const SizedBox(height: 8),
              for (final entry in [
                ('Single key', [('A', false)], 'LogicalKeySet(keyA)'),
                ('Two keys',
                    [('Ctrl', true), ('C', false)],
                    'LogicalKeySet(control, keyC)'),
                ('Three keys',
                    [('Ctrl', true), ('Shift', true), ('Z', false)],
                    'LogicalKeySet(control, shift, keyZ)'),
                ('Four keys',
                    [('Ctrl', true), ('Alt', true), ('Shift', true), ('N', false)],
                    'LogicalKeySet(control, alt, shift, keyN)'),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: steelAccent, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.$1,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: dimText)),
                      const SizedBox(height: 6),
                      Wrap(
                        children: [
                          for (final k in entry.$2)
                            keyChip(k.$1, isModifier: k.$2),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(entry.$3,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: neonCyan.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              Text('fromSet Constructor (unlimited keys):',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: neonCyan)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                      left: BorderSide(color: midnight, width: 3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(children: [
                      keyChip('Meta', isModifier: true),
                      keyChip('Shift', isModifier: true),
                      keyChip('N'),
                    ]),
                    const SizedBox(height: 4),
                    Text('LogicalKeySet.fromSet({meta, shift, keyN})',
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                            color: neonCyan.withValues(alpha: 0.7))),
                    Text('keys count: ${fromSetExample.keys.length}',
                        style: TextStyle(fontSize: 11, color: dimText)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. The .keys property ────────────────────────────────────
        sectionBanner('3 \u00b7 The keys Property',
            'All logical keys in the set',
            midnight, brightWhite),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final pair in [
                ('LogicalKeySet(keyA)', singleKey),
                ('Ctrl + C', ctrlC),
                ('Ctrl + Shift + Z', ctrlShiftZ),
                ('Ctrl + Alt + Delete', ctrlAltDel),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: obsidian.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(pair.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: neonCyan)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: midnight.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('${pair.$2.keys.length} keys',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: steelAccent)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                            pair.$2.keys
                                .map((k) => k.keyLabel.isEmpty
                                    ? k.debugName ?? 'unknown'
                                    : k.keyLabel)
                                .join(', '),
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: dimText)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Triggers vs modifiers ─────────────────────────────────
        sectionBanner('4 \u00b7 Triggers vs Modifiers',
            'How LogicalKeySet separates trigger keys from modifier keys',
            steelAccent, brightWhite),
        noteBox(
          'The .triggers property returns the non-modifier keys in the set — '
          'these are the keys that actually fire the shortcut when pressed. '
          'Modifier keys (Ctrl, Shift, Alt, Meta) are required to be held '
          'but are not triggers themselves. LogicalKeySet also expands '
          'synonym modifiers: e.g. LogicalKeyboardKey.control becomes both '
          'controlLeft and controlRight as valid triggers.',
          steelAccent,
          surfaceGrey,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: obsidian),
                children: [
                  for (final h in ['Key Set', 'Triggers', 'Modifier Keys'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: neonCyan,
                              fontWeight: FontWeight.bold,
                              fontSize: 11)),
                    ),
                ],
              ),
              for (final combo in [
                ('A only', singleKey),
                ('Ctrl + C', ctrlC),
                ('Ctrl+Shift+Z', ctrlShiftZ),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(combo.$1,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: dimText)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final t in combo.$2.triggers)
                            Text(
                                t.keyLabel.isEmpty
                                    ? (t.debugName ?? 'key')
                                    : t.keyLabel,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: neonCyan)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                          combo.$2.keys
                              .where((k) => [
                                    LogicalKeyboardKey.control,
                                    LogicalKeyboardKey.shift,
                                    LogicalKeyboardKey.alt,
                                    LogicalKeyboardKey.meta,
                                  ].contains(k))
                              .map((k) => k.keyLabel.isEmpty
                                  ? (k.debugName ?? '')
                                  : k.keyLabel)
                              .join(', '),
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: steelAccent)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Synonym expansion ─────────────────────────────────────
        sectionBanner('5 \u00b7 Synonym Expansion',
            'Left/Right modifier keys are treated as equivalent',
            obsidian, brightWhite),
        noteBox(
          'When you use LogicalKeyboardKey.control, LogicalKeySet internally '
          'expands it to accept both controlLeft AND controlRight. This means '
          'pressing either physical Ctrl key will match. The same applies to '
          'shift, alt, and meta. This expansion happens in the .triggers '
          'getter via _unmapSynonyms.',
          midnight,
          surfaceGrey,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final synonym in [
                ('control', 'controlLeft + controlRight', Icons.keyboard_arrow_left),
                ('shift', 'shiftLeft + shiftRight', Icons.keyboard_arrow_up),
                ('alt', 'altLeft + altRight', Icons.keyboard_tab),
                ('meta', 'metaLeft + metaRight', Icons.laptop_mac),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: neonCyan, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(synonym.$3, size: 18, color: neonCyan),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 70,
                        child: Text(synonym.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                color: neonCyan)),
                      ),
                      Text('\u2192  ',
                          style: TextStyle(color: dimText, fontSize: 14)),
                      Expanded(
                        child: Text(synonym.$2,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: dimText)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Visual keyboard layout ────────────────────────────────
        sectionBanner('6 \u00b7 Keyboard Shortcut Visualizer',
            'Visual representation of key combinations',
            darkSlate, brightWhite),
        for (final combo in [
          ('Copy', [('Ctrl', true), ('C', false)], neonCyan),
          ('Undo', [('Ctrl', true), ('Z', false)], steelAccent),
          ('Redo', [('Ctrl', true), ('Shift', true), ('Z', false)], midnight),
          ('Save', [('Ctrl', true), ('S', false)], glowPurple),
          ('Select All', [('Ctrl', true), ('A', false)], neonCyan),
          ('Find', [('Ctrl', true), ('F', false)], steelAccent),
        ])
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: surfaceGrey,
              borderRadius: BorderRadius.circular(8),
              border: Border(
                  left: BorderSide(color: combo.$3, width: 3)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(combo.$1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: combo.$3)),
                ),
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (var i = 0; i < combo.$2.length; i++) ...[
                        if (i > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text('+',
                                style: TextStyle(
                                    color: dimText.withValues(alpha: 0.5),
                                    fontWeight: FontWeight.bold)),
                          ),
                        keyChip(combo.$2[i].$1,
                            isModifier: combo.$2[i].$2),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 14),

        // ── 8. accepts() method ──────────────────────────────────────
        sectionBanner('7 \u00b7 The accepts() Method',
            'How LogicalKeySet matches keyboard events',
            midnight, brightWhite),
        noteBox(
          'The accepts(KeyEvent event, HardwareKeyboard state) method checks '
          'two conditions: (1) the event must be a KeyDownEvent or '
          'KeyRepeatEvent, and (2) the event\'s logical key must be in '
          '.triggers, AND all keys in the set must match the currently '
          'pressed keys (after synonym collapsing). This is how the '
          'Shortcuts widget determines which shortcut to fire.',
          neonCyan,
          surfaceGrey,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Event type check', 'Must be KeyDownEvent or KeyRepeatEvent', obsidian),
                (2, 'Trigger match', 'event.logicalKey must be in .triggers', darkSlate),
                (3, 'Synonym collapse', 'Collapse both required and pressed keys', midnight),
                (4, 'Set comparison', 'Collapsed required == collapsed pressed', steelAccent),
                (5, 'Result', 'true = shortcut accepted, Intent fires', neonCyan),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$4.withValues(alpha: 0.15),
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
                                    color: brightWhite)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 11, color: dimText)),
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

        // ── 9. Shortcuts widget integration ──────────────────────────
        sectionBanner('8 \u00b7 Shortcuts Widget Integration',
            'Using LogicalKeySet in the Shortcuts widget tree',
            steelAccent, brightWhite),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Widget Tree Structure:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: neonCyan)),
              const SizedBox(height: 10),
              for (final level in [
                (0, 'Shortcuts', 'Defines shortcut-to-intent mapping', Icons.shortcut),
                (1, 'LogicalKeySet \u2192 Intent', 'Key combo maps to an Intent', Icons.keyboard),
                (1, 'LogicalKeySet \u2192 Intent', 'Multiple mappings possible', Icons.keyboard),
                (0, 'Actions', 'Defines intent-to-action mapping', Icons.play_arrow),
                (1, 'Intent \u2192 Action', 'Intent maps to a callback', Icons.arrow_forward),
                (0, 'Focus', 'Must be focused to receive key events', Icons.center_focus_strong),
              ])
                Padding(
                  padding: EdgeInsets.only(left: level.$1 * 20.0, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      Icon(level.$4,
                          size: 16,
                          color: level.$1 == 0 ? neonCyan : steelAccent),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(level.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: level.$1 == 0
                                        ? brightWhite
                                        : dimText)),
                            Text(level.$3,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: dimText.withValues(alpha: 0.7))),
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

        // ── 10. Common shortcuts gallery ─────────────────────────────
        sectionBanner('9 \u00b7 Common Shortcuts Gallery',
            'Standard keyboard shortcuts used in apps',
            obsidian, brightWhite),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: obsidian),
                children: [
                  for (final h in ['Action', 'Keys', 'Category'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: neonCyan,
                              fontWeight: FontWeight.bold,
                              fontSize: 11)),
                    ),
                ],
              ),
              for (final row in [
                ('Copy', 'Ctrl + C', 'Clipboard'),
                ('Cut', 'Ctrl + X', 'Clipboard'),
                ('Paste', 'Ctrl + V', 'Clipboard'),
                ('Undo', 'Ctrl + Z', 'History'),
                ('Redo', 'Ctrl + Shift + Z', 'History'),
                ('Save', 'Ctrl + S', 'File'),
                ('New', 'Ctrl + N', 'File'),
                ('Find', 'Ctrl + F', 'Navigation'),
                ('Select All', 'Ctrl + A', 'Selection'),
                ('Close', 'Ctrl + W', 'Window'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: brightWhite)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: neonCyan)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: steelAccent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(row.$3,
                            style: TextStyle(
                                fontSize: 10,
                                color: steelAccent)),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Comparison: LogicalKeySet vs SingleActivator ─────────
        sectionBanner('10 \u00b7 LogicalKeySet vs SingleActivator',
            'Why SingleActivator replaced LogicalKeySet',
            glowPurple, brightWhite),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceGrey,
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
                decoration: BoxDecoration(color: obsidian),
                children: [
                  for (final h in ['Aspect', 'LogicalKeySet', 'SingleActivator'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: neonCyan,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('Status', 'Deprecated', 'Recommended'),
                ('Lock keys', 'No support', 'capsLock, numLock params'),
                ('Key repeat', 'Accepts repeats', 'includeRepeats param'),
                ('Trigger', 'All non-modifier keys', 'Exactly one trigger key'),
                ('Modifiers', 'Set-based', 'Named bool params'),
                ('Performance', 'Set operations', 'Direct comparisons'),
                ('Readability', 'Verbose', 'Concise named params'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: dimText)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10,
                              color: row.$2 == 'Deprecated'
                                  ? glowPurple
                                  : dimText)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10,
                              color: row.$3 == 'Recommended'
                                  ? neonCyan
                                  : dimText)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Equality and hashCode ────────────────────────────────
        sectionBanner('11 \u00b7 Equality and HashCode',
            'Set-based equality regardless of order',
            darkSlate, brightWhite),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              noteBox(
                'LogicalKeySet uses set-based equality: two key sets are equal '
                'if they contain exactly the same keys, regardless of the order '
                'they were specified. This means LogicalKeySet(keyA, control) '
                'equals LogicalKeySet(control, keyA).',
                steelAccent,
                obsidian,
              ),
              const SizedBox(height: 8),
              for (final test in [
                ('Ctrl+C == Ctrl+C', ctrlC == ctrlC2, 'Same keys, same object pattern'),
                ('Ctrl+C == Ctrl+Shift+Z', ctrlC == ctrlShiftZ, 'Different key count'),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        test.$2 ? Icons.check_circle : Icons.cancel,
                        size: 18,
                        color: test.$2 ? neonCyan : glowPurple,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(test.$1,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.w600,
                                    color: dimText)),
                            Text('${test.$2} — ${test.$3}',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: dimText.withValues(alpha: 0.7))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: obsidian.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('HashCode values:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: neonCyan)),
                    const SizedBox(height: 4),
                    for (final setEntry in [
                      ('singleKey (A)', singleKey),
                      ('Ctrl+C', ctrlC),
                      ('Ctrl+Shift+Z', ctrlShiftZ),
                      ('Ctrl+Alt+Del', ctrlAltDel),
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: Text(setEntry.$1,
                                  style: TextStyle(
                                      fontSize: 11, color: dimText)),
                            ),
                            Text('${setEntry.$2.hashCode}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: steelAccent)),
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

        // ── 13. Migration guide ──────────────────────────────────────
        sectionBanner('12 \u00b7 Migration to SingleActivator',
            'Step-by-step migration from LogicalKeySet',
            glowPurple, brightWhite),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final migration in [
                ('LogicalKeySet(control, keyC)', 'SingleActivator(keyC, control: true)',
                    'Simple modifier + key'),
                ('LogicalKeySet(control, shift, keyZ)', 'SingleActivator(keyZ, control: true, shift: true)',
                    'Multiple modifiers + key'),
                ('LogicalKeySet(keyA)', 'SingleActivator(keyA)',
                    'Single key, no modifiers'),
                ('LogicalKeySet(meta, keyS)', 'SingleActivator(keyS, meta: true)',
                    'Platform-specific modifier'),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: glowPurple, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(migration.$3,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: dimText)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: glowPurple.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('OLD',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: glowPurple)),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(migration.$1,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: glowPurple.withValues(alpha: 0.8))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: neonCyan.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('NEW',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: neonCyan)),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(migration.$2,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: neonCyan)),
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

        // ── 14. ShortcutActivator interface ──────────────────────────
        sectionBanner('13 \u00b7 ShortcutActivator Interface',
            'The contract that LogicalKeySet fulfills',
            midnight, brightWhite),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final member in [
                ('triggers', 'Iterable<LogicalKeyboardKey>', 'Keys that can fire the shortcut', neonCyan),
                ('accepts()', 'bool', 'Check if event + state matches shortcut', steelAccent),
                ('debugDescribeKeys()', 'String', 'Human-readable debug description', midnight),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: member.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        child: Text(member.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: member.$4)),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(member.$2,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: dimText.withValues(alpha: 0.7))),
                      ),
                      Expanded(
                        child: Text(member.$3,
                            style: TextStyle(
                                fontSize: 11, color: dimText)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Inheritance tree ─────────────────────────────────────
        sectionBanner('14 \u00b7 Inheritance Hierarchy',
            'Where LogicalKeySet sits in the class hierarchy',
            obsidian, brightWhite),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', 0, Colors.grey),
                ('\u2514\u2500 KeySet<LogicalKeyboardKey>', 1, steelAccent),
                ('     \u2514\u2500 LogicalKeySet', 2, neonCyan),
              ])
                Padding(
                  padding: EdgeInsets.only(
                      left: level.$2 * 12.0, top: 4, bottom: 4),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          fontWeight: level.$2 == 2
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: level.$3)),
                ),
              const SizedBox(height: 8),
              Text('Implements: ShortcutActivator, Diagnosticable',
                  style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: dimText)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', obsidian, brightWhite),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [onyx, obsidian, darkSlate],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: steelAccent.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Defines keyboard shortcut combos as sets of LogicalKeyboardKey',
                'Extends KeySet and implements ShortcutActivator',
                'Positional constructor (up to 4 keys) or fromSet (unlimited)',
                'Automatically expands modifier synonyms (left/right equivalence)',
                '.triggers returns non-modifier keys; .keys returns all keys',
                '.accepts() checks event type + trigger + pressed key match',
                'Set-based equality — key order doesn\'t matter',
                'Used in Shortcuts widget for key combo to Intent mapping',
                'Deprecated in favor of SingleActivator for new code',
                'Still functional and widely used in existing codebases',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: neonCyan,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
                                color: dimText, fontSize: 13)),
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

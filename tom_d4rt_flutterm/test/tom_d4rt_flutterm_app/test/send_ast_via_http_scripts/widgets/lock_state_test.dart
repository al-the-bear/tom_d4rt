// ignore_for_file: avoid_print
// D4rt deep demo: LockState — enum for keyboard lock key requirements in shortcuts
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Graphite / Titanium ───────────────────────────────────
  const deepGraphite = Color(0xFF263238);
  const charcoal = Color(0xFF37474F);
  const gunmetal = Color(0xFF455A64);
  const titanium = Color(0xFF607D8B);
  const pewter = Color(0xFF78909C);
  const silver = Color(0xFF90A4AE);
  const platinum = Color(0xFFB0BEC5);
  const titaniumWhite = Color(0xFFECEFF1);
  const electricBlue = Color(0xFF2979FF);
  const signalGreen = Color(0xFF00C853);

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
      child:
          Text(text, style: TextStyle(fontSize: 13, color: deepGraphite)),
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
                style: TextStyle(fontSize: 13, color: deepGraphite)),
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

  Color stateColor(LockState state) {
    switch (state) {
      case LockState.locked:
        return signalGreen;
      case LockState.unlocked:
        return titanium;
      case LockState.ignored:
        return electricBlue;
    }
  }

  IconData stateIcon(LockState state) {
    switch (state) {
      case LockState.locked:
        return Icons.lock;
      case LockState.unlocked:
        return Icons.lock_open;
      case LockState.ignored:
        return Icons.do_not_disturb;
    }
  }

  // ── Gather data ────────────────────────────────────────────────────
  print('LockState deep demo executing');
  print('=' * 60);

  // Section 1 — what is it
  print('\n--- What is LockState ---');
  print('Enum for keyboard lock key requirements in SingleActivator');
  print('Three values: ignored, locked, unlocked');

  // Section 2 — all values
  print('\n--- All values ---');
  for (final value in LockState.values) {
    print('  ${value.name}: index=${value.index}');
  }

  // Section 3 — each value
  print('\n--- Ignored ---');
  final ignored = LockState.ignored;
  print('ignored: $ignored (index: ${ignored.index})');

  print('\n--- Locked ---');
  final locked = LockState.locked;
  print('locked: $locked (index: ${locked.index})');

  print('\n--- Unlocked ---');
  final unlocked = LockState.unlocked;
  print('unlocked: $unlocked (index: ${unlocked.index})');

  // Section 4 — usage context
  print('\n--- Usage context ---');
  print('Used with SingleActivator to specify lock key requirements');
  print('Determines if CapsLock/NumLock must be on, off, or irrelevant');

  // Section 5 — comparisons
  print('\n--- Comparisons ---');
  print('locked == locked: ${locked == LockState.locked}');
  print('locked == unlocked: ${locked == unlocked}');
  print('ignored != locked: ${ignored != locked}');

  print('\n${'=' * 60}');
  print('LockState deep demo completed');

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
              colors: [deepGraphite, charcoal, gunmetal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('LockState',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(
                  'Enum for keyboard lock key requirements in shortcut activators',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Enum', gunmetal, Colors.white),
                tag('3 Values', titanium, Colors.white),
                tag('Shortcuts', pewter, Colors.white),
                tag('SingleActivator', silver, deepGraphite),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is LockState',
            'Lock key requirements for keyboard shortcut matching',
            deepGraphite, Colors.white),
        noteBox(
          'LockState is an enum with three values that specify whether a '
          'keyboard lock key (CapsLock, NumLock) must be in a particular '
          'state for a SingleActivator shortcut to trigger. When set to '
          'ignored, the lock key state does not affect matching. When set '
          'to locked or unlocked, the shortcut only fires if the lock key '
          'matches the required state.',
          deepGraphite,
          titaniumWhite,
        ),
        dataRow('Type', 'enum', charcoal),
        dataRow('Values count', '${LockState.values.length}', gunmetal),
        dataRow('Used by', 'SingleActivator (shortcuts)', titanium),
        dataRow('Purpose', 'Lock key requirement for shortcut matching', pewter),
        const SizedBox(height: 14),

        // ── 3. All three values ──────────────────────────────────────
        sectionBanner('2 \u00b7 The Three States',
            'Each value represents a different lock key requirement',
            charcoal, Colors.white),
        for (final state in LockState.values)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: titaniumWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border(
                  left: BorderSide(color: stateColor(state), width: 4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: stateColor(state).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(stateIcon(state),
                      size: 26, color: stateColor(state)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(state.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: deepGraphite)),
                          const SizedBox(width: 8),
                          tag('index ${state.index}',
                              stateColor(state).withValues(alpha: 0.12),
                              stateColor(state)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state == LockState.ignored
                            ? 'Lock key state is not considered — shortcut fires regardless'
                            : state == LockState.locked
                                ? 'Lock key must be ON for the shortcut to trigger'
                                : 'Lock key must be OFF for the shortcut to trigger',
                        style: TextStyle(fontSize: 12, color: gunmetal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 14),

        // ── 4. Properties table ──────────────────────────────────────
        sectionBanner('3 \u00b7 Enum Properties',
            'Standard Dart enum properties for each value',
            gunmetal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: titaniumWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepGraphite),
                children: [
                  for (final h in ['Value', 'Index', 'Name', 'toString()'])
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
              for (final state in LockState.values)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(stateIcon(state),
                              size: 14, color: stateColor(state)),
                          const SizedBox(width: 4),
                          Text(state.name,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: deepGraphite)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('${state.index}',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: gunmetal)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(state.name,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: titanium)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('$state',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: deepGraphite)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. SingleActivator integration ───────────────────────────
        sectionBanner('4 \u00b7 SingleActivator Integration',
            'How LockState is used in keyboard shortcuts',
            deepGraphite, Colors.white),
        noteBox(
          'SingleActivator has numLock and capsLock parameters that accept '
          'LockState values. By default both are LockState.ignored, meaning '
          'the shortcut fires regardless of lock key states. Set them to '
          'locked or unlocked to require specific lock key states for the '
          'shortcut to match.',
          deepGraphite,
          titaniumWhite,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: titaniumWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final param in [
                ('capsLock:', 'LockState', 'CapsLock requirement (default: ignored)', deepGraphite),
                ('numLock:', 'LockState', 'NumLock requirement (default: ignored)', charcoal),
                ('trigger:', 'LogicalKeyboardKey', 'The key that triggers the shortcut', gunmetal),
                ('control:', 'bool', 'Whether Ctrl must be held', titanium),
                ('shift:', 'bool', 'Whether Shift must be held', pewter),
                ('alt:', 'bool', 'Whether Alt must be held', silver),
                ('meta:', 'bool', 'Whether Meta/Cmd must be held', platinum),
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
                        width: 80,
                        child: Text(param.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: param.$4)),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(param.$2,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: electricBlue)),
                      ),
                      Expanded(
                        child: Text(param.$3,
                            style: TextStyle(
                                fontSize: 11, color: gunmetal)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Shortcut scenarios ────────────────────────────────────
        sectionBanner('5 \u00b7 Shortcut Matching Scenarios',
            'Examples of CapsLock-sensitive shortcuts',
            charcoal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: titaniumWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepGraphite),
                children: [
                  for (final h in ['Shortcut', 'CapsLock', 'Behavior'])
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
                ('Ctrl+S', 'ignored', 'Fires with CapsLock on or off'),
                ('Ctrl+S', 'locked', 'Only fires when CapsLock is ON'),
                ('Ctrl+S', 'unlocked', 'Only fires when CapsLock is OFF'),
                ('Ctrl+A', 'ignored', 'Standard select-all, always works'),
                ('Ctrl+Shift+Z', 'locked', 'Only when CapsLock engaged'),
                ('F5', 'ignored', 'Function keys typically ignore locks'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'monospace',
                              color: deepGraphite)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: row.$2 == 'locked'
                              ? signalGreen.withValues(alpha: 0.1)
                              : row.$2 == 'unlocked'
                                  ? titanium.withValues(alpha: 0.1)
                                  : electricBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(row.$2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: row.$2 == 'locked'
                                    ? signalGreen
                                    : row.$2 == 'unlocked'
                                        ? titanium
                                        : electricBlue)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 11, color: gunmetal)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Keyboard dashboard ────────────────────────────────────
        sectionBanner('6 \u00b7 Lock Key Dashboard',
            'Visual status panel for lock key states',
            gunmetal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepGraphite.withValues(alpha: 0.05), titaniumWhite],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: platinum),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.keyboard, size: 20, color: deepGraphite),
                  const SizedBox(width: 8),
                  Text('Lock Key Requirement Monitor',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: deepGraphite)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  for (final state in LockState.values)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              stateColor(state).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: stateColor(state)
                                  .withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          children: [
                            Icon(stateIcon(state),
                                size: 28, color: stateColor(state)),
                            const SizedBox(height: 6),
                            Text(state.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: stateColor(state))),
                            const SizedBox(height: 2),
                            Text('index: ${state.index}',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Equality and comparison ───────────────────────────────
        sectionBanner('7 \u00b7 Equality and Comparison',
            'How enum values compare to each other',
            titanium, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: titaniumWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final pair in [
                (ignored, ignored, true),
                (ignored, locked, false),
                (ignored, unlocked, false),
                (locked, locked, true),
                (locked, unlocked, false),
                (unlocked, unlocked, true),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text(pair.$1.name,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: stateColor(pair.$1))),
                      ),
                      Text(pair.$3 ? ' == ' : ' != ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: deepGraphite)),
                      SizedBox(
                        width: 70,
                        child: Text(pair.$2.name,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: stateColor(pair.$2))),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        pair.$3 ? Icons.check : Icons.close,
                        size: 16,
                        color: pair.$3
                            ? signalGreen
                            : const Color(0xFFE53935),
                      ),
                      const SizedBox(width: 4),
                      Text('${pair.$3}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: pair.$3
                                  ? signalGreen
                                  : const Color(0xFFE53935))),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Pattern matching ──────────────────────────────────────
        sectionBanner('8 \u00b7 Pattern Matching',
            'Using switch expressions with LockState',
            deepGraphite, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: titaniumWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Switch expression results:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: deepGraphite)),
              const SizedBox(height: 8),
              for (final state in LockState.values)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: stateColor(state).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(state.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: stateColor(state))),
                      ),
                      const SizedBox(width: 8),
                      Text('\u2192',
                          style: TextStyle(
                              color: gunmetal, fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          switch (state) {
                            LockState.ignored =>
                              'Don\'t care — shortcut fires regardless of lock state',
                            LockState.locked =>
                              'Require lock key ON to trigger shortcut',
                            LockState.unlocked =>
                              'Require lock key OFF to trigger shortcut',
                          },
                          style: TextStyle(
                              fontSize: 12, color: deepGraphite),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Simulated keyboard keys ──────────────────────────────
        sectionBanner('9 \u00b7 Simulated Keyboard Section',
            'Lock key area of a keyboard layout',
            charcoal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: titaniumWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: platinum),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final keyInfo in [
                    ('CAPS', LockState.locked),
                    ('NUM', LockState.unlocked),
                    ('SCROLL', LockState.ignored),
                  ])
                    Container(
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: deepGraphite.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: stateColor(keyInfo.$2)
                                .withValues(alpha: 0.5),
                            width: 2),
                      ),
                      child: Column(
                        children: [
                          Text(keyInfo.$1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: deepGraphite)),
                          const SizedBox(height: 6),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: keyInfo.$2 == LockState.locked
                                  ? signalGreen
                                  : keyInfo.$2 == LockState.unlocked
                                      ? Colors.grey.shade400
                                      : electricBlue.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: keyInfo.$2 == LockState.locked
                                  ? [
                                      BoxShadow(
                                          color: signalGreen
                                              .withValues(alpha: 0.5),
                                          blurRadius: 6),
                                    ]
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(keyInfo.$2.name,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: stateColor(keyInfo.$2))),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              noteBox(
                'Green LED = locked (ON). Grey LED = unlocked (OFF). '
                'Blue = ignored (don\'t care). These represent the '
                'requirement for shortcut matching, not the actual key state.',
                gunmetal,
                titaniumWhite,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Comparison with other enums ──────────────────────────
        sectionBanner('10 \u00b7 Comparison With Related Types',
            'LockState vs other keyboard-related types',
            gunmetal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: titaniumWhite,
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
                decoration: BoxDecoration(color: deepGraphite),
                children: [
                  for (final h in ['Type', 'Values', 'Purpose'])
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
                ('LockState', 'ignored, locked, unlocked', 'Lock key requirement for shortcuts'),
                ('KeyEventType', 'down, up, repeat', 'Type of keyboard event'),
                ('KeyboardSide', 'any, left, right, all', 'Side of keyboard for modifiers'),
                ('ModifierKey', 'control, shift, alt...', 'Modifier key identification'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: row.$1 == 'LockState'
                                  ? deepGraphite
                                  : Colors.grey.shade700)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: titanium)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: gunmetal)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Shortcut pipeline ────────────────────────────────────
        sectionBanner('11 \u00b7 Shortcut Matching Pipeline',
            'How LockState fits in the keyboard event flow',
            deepGraphite, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: titaniumWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Key event received', 'HardwareKeyboard dispatches event', deepGraphite),
                (2, 'Shortcuts widget checks', 'Iterates registered ShortcutActivators', charcoal),
                (3, 'Trigger key matches?', 'Compares logical key from event', gunmetal),
                (4, 'Modifiers match?', 'Checks ctrl/shift/alt/meta state', titanium),
                (5, 'Lock state matches?', 'LockState.ignored always passes', electricBlue),
                (6, 'Shortcut triggered', 'Associated Intent is invoked', signalGreen),
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
                                    color: deepGraphite)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 11, color: pewter)),
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

        // ── 13. Use cases ────────────────────────────────────────────
        sectionBanner('12 \u00b7 Common Use Cases',
            'When to specify lock state requirements',
            charcoal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: titaniumWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final useCase in [
                ('Default shortcuts', Icons.keyboard, 'Use ignored — most shortcuts don\'t care', deepGraphite),
                ('CapsLock-aware', Icons.text_fields, 'Require locked/unlocked for case-sensitive ops', charcoal),
                ('NumLock-dependent', Icons.dialpad, 'Numpad shortcuts that differ by NumLock state', gunmetal),
                ('Accessibility', Icons.accessibility_new, 'Lock key indicators for screen readers', titanium),
                ('Games', Icons.videogame_asset, 'NumLock affects numpad as arrows vs numbers', pewter),
                ('Editor modes', Icons.edit, 'CapsLock as visual mode indicator', silver),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: useCase.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(useCase.$2, size: 22, color: useCase.$4),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(useCase.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: deepGraphite)),
                            Text(useCase.$3,
                                style: TextStyle(
                                    fontSize: 12, color: gunmetal)),
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

        // ── 14. HashCode and identity ────────────────────────────────
        sectionBanner('13 \u00b7 Identity and HashCode',
            'Enum singleton guarantees',
            titanium, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: titaniumWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              for (final state in LockState.values)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(stateIcon(state),
                          size: 16, color: stateColor(state)),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 80,
                        child: Text(state.name,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: deepGraphite)),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: platinum.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('hashCode: ${state.hashCode}',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: gunmetal)),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        noteBox(
          'Each LockState value is a singleton. Using == for comparison '
          'is both correct and efficient — it checks object identity. '
          'The enum is used in map keys and switch expressions safely.',
          titanium,
          titaniumWhite,
        ),
        const SizedBox(height: 14),

        // ── 15. Inheritance hierarchy ────────────────────────────────
        sectionBanner('14 \u00b7 Inheritance Hierarchy',
            'Where LockState sits in the framework',
            deepGraphite, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: titaniumWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', 0, Colors.grey),
                ('\u2514\u2500 Enum', 1, pewter),
                ('     \u2514\u2500 LockState', 2, deepGraphite),
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
            ],
          ),
        ),
        noteBox(
          'LockState is defined in package:flutter/widgets.dart (shortcuts.dart). '
          'It extends Enum. The enum is part of the shortcuts system, '
          'used by SingleActivator and ShortcutActivator to specify '
          'lock key requirements for keyboard shortcut matching.',
          deepGraphite,
          titaniumWhite,
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepGraphite, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepGraphite, charcoal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Enum with 3 values: ignored, locked, unlocked',
                'Specifies lock key requirements for keyboard shortcuts',
                'Used by SingleActivator\'s capsLock and numLock parameters',
                'ignored (default) means shortcut fires regardless of lock state',
                'locked requires the lock key to be ON for the shortcut to match',
                'unlocked requires the lock key to be OFF for matching',
                'Part of the Shortcuts widget system in Flutter',
                'Singleton identity — fast == comparison and exhaustive matching',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: silver,
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

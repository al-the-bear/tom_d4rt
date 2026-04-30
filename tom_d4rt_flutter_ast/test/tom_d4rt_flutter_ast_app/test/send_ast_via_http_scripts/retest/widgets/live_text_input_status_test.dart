// ignore_for_file: avoid_print
// D4rt deep demo: LiveTextInputStatus — enum for Live Text input availability
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Dusk / Twilight ───────────────────────────────────────
  const deepDusk = Color(0xFF311B92);
  const richPurple = Color(0xFF4527A0);
  const twilight = Color(0xFF5E35B1);
  const amethyst = Color(0xFF7E57C2);
  const lavender = Color(0xFF9575CD);
  const orchid = Color(0xFFB39DDB);
  const lilac = Color(0xFFD1C4E9);
  const moonGlow = Color(0xFFEDE7F6);
  const sunsetPink = Color(0xFFEC407A);
  const dawnGold = Color(0xFFFFB300);

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
      child: Text(text, style: TextStyle(fontSize: 13, color: deepDusk)),
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
                style: TextStyle(fontSize: 13, color: deepDusk)),
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

  Color statusColor(LiveTextInputStatus status) {
    switch (status) {
      case LiveTextInputStatus.enabled:
        return const Color(0xFF2E7D32);
      case LiveTextInputStatus.disabled:
        return sunsetPink;
      case LiveTextInputStatus.unknown:
        return dawnGold;
      default: // D4RT-LIMITATION: enum exhaustiveness
        return dawnGold;
    }
  }

  IconData statusIcon(LiveTextInputStatus status) {
    switch (status) {
      case LiveTextInputStatus.enabled:
        return Icons.check_circle;
      case LiveTextInputStatus.disabled:
        return Icons.cancel;
      case LiveTextInputStatus.unknown:
        return Icons.help_outline;
      default: // D4RT-LIMITATION: enum exhaustiveness
        return Icons.help_outline;
    }
  }

  // ── Gather data ────────────────────────────────────────────────────
  print('LiveTextInputStatus deep demo executing');
  print('=' * 60);

  // Section 1 — what is it
  print('\n--- What is LiveTextInputStatus ---');
  print('Enum representing Live Text input availability');
  print('Three states: unknown, enabled, disabled');
  print('Used by LiveTextInputStatusNotifier');

  // Section 2 — all values
  print('\n--- All values ---');
  for (final value in LiveTextInputStatus.values) {
    print('  ${value.name}: index=${value.index}');
  }

  // Section 3 — each value
  print('\n--- Unknown ---');
  final unknown = LiveTextInputStatus.unknown;
  print('unknown: $unknown (index: ${unknown.index})');

  print('\n--- Enabled ---');
  final enabled = LiveTextInputStatus.enabled;
  print('enabled: $enabled (index: ${enabled.index})');

  print('\n--- Disabled ---');
  final disabled = LiveTextInputStatus.disabled;
  print('disabled: $disabled (index: ${disabled.index})');

  // Section 4 — comparisons
  print('\n--- Comparisons ---');
  print('enabled == enabled: ${enabled == LiveTextInputStatus.enabled}');
  print('enabled == disabled: ${enabled == disabled}');
  print('unknown != enabled: ${unknown != enabled}');

  // Section 5 — usage
  print('\n--- Usage context ---');
  print('ValueNotifier<LiveTextInputStatus>');
  print('Controls camera OCR button visibility');

  print('\n${'=' * 60}');
  print('LiveTextInputStatus deep demo completed');

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
              colors: [deepDusk, richPurple, twilight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('LiveTextInputStatus',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Enum representing camera-based text input availability',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Enum', twilight, Colors.white),
                tag('3 Values', amethyst, Colors.white),
                tag('Live Text', lavender, deepDusk),
                tag('iOS', orchid, deepDusk),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is LiveTextInputStatus',
            'The state of platform Live Text (camera OCR) capability',
            deepDusk, Colors.white),
        noteBox(
          'LiveTextInputStatus is an enum with three values that represent '
          'whether the device supports Live Text input — the iOS feature '
          'that lets users point their camera at text and insert it into '
          'text fields. The status starts as unknown (async check needed), '
          'then resolves to enabled or disabled.',
          deepDusk,
          moonGlow,
        ),
        dataRow('Type', 'enum', richPurple),
        dataRow('Values count', '${LiveTextInputStatus.values.length}', twilight),
        dataRow('Used by', 'LiveTextInputStatusNotifier', amethyst),
        dataRow('Controls', 'Camera OCR button in text fields', lavender),
        const SizedBox(height: 14),

        // ── 3. All three values ──────────────────────────────────────
        sectionBanner('2 \u00b7 The Three States',
            'Each value represents a distinct availability state',
            richPurple, Colors.white),
        for (final status in LiveTextInputStatus.values)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: moonGlow,
              borderRadius: BorderRadius.circular(10),
              border: Border(
                  left: BorderSide(color: statusColor(status), width: 4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: statusColor(status).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(statusIcon(status),
                      size: 26, color: statusColor(status)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(status.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: deepDusk)),
                          const SizedBox(width: 8),
                          tag('index ${status.index}',
                              statusColor(status).withValues(alpha: 0.12),
                              statusColor(status)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        status == LiveTextInputStatus.unknown
                            ? 'Initial state — async platform check not yet complete'
                            : status == LiveTextInputStatus.enabled
                                ? 'Device confirmed to support Live Text input'
                                : 'Device does not support Live Text input',
                        style: TextStyle(fontSize: 12, color: twilight),
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
            twilight, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: moonGlow,
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
                decoration: BoxDecoration(color: deepDusk),
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
              for (final status in LiveTextInputStatus.values)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(statusIcon(status),
                              size: 14, color: statusColor(status)),
                          const SizedBox(width: 4),
                          Text(status.name,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: deepDusk)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('${status.index}',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: twilight)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(status.name,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: amethyst)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('$status',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: deepDusk)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. State transitions ─────────────────────────────────────
        sectionBanner('4 \u00b7 State Transition Diagram',
            'How the status changes during app lifecycle',
            deepDusk, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: moonGlow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final transition in [
                ('App starts', 'unknown', dawnGold, '\u2192', 'Notifier created'),
                ('Platform check', 'enabled', const Color(0xFF2E7D32), '\u2192', 'Device supports Live Text'),
                ('  \u2514\u2500 or', 'disabled', sunsetPink, '\u2192', 'Device lacks Live Text'),
                ('App backgrounds', '(no change)', Colors.grey, '\u2022', 'Value preserved'),
                ('App resumes', 're-check', dawnGold, '\u2192', 'update() called again'),
                ('Re-check done', 'enabled/disabled', twilight, '\u2192', 'Updated from platform'),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        child: Text(transition.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: deepDusk)),
                      ),
                      Text(transition.$4,
                          style: TextStyle(
                              fontSize: 16, color: transition.$3)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: transition.$3.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(transition.$2,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: transition.$3)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(transition.$5,
                            style: TextStyle(
                                fontSize: 11, color: amethyst)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Equality and comparison ───────────────────────────────
        sectionBanner('5 \u00b7 Equality and Comparison',
            'How enum values compare to each other',
            richPurple, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: moonGlow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final pair in [
                (unknown, unknown, true),
                (unknown, enabled, false),
                (unknown, disabled, false),
                (enabled, enabled, true),
                (enabled, disabled, false),
                (disabled, disabled, true),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(pair.$1.name,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: statusColor(pair.$1))),
                      ),
                      Text(pair.$3 ? ' == ' : ' != ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: deepDusk)),
                      SizedBox(
                        width: 80,
                        child: Text(pair.$2.name,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: statusColor(pair.$2))),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        pair.$3 ? Icons.check : Icons.close,
                        size: 16,
                        color: pair.$3
                            ? const Color(0xFF2E7D32)
                            : sunsetPink,
                      ),
                      const SizedBox(width: 4),
                      Text('${pair.$3}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: pair.$3
                                  ? const Color(0xFF2E7D32)
                                  : sunsetPink)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. UI mapping ────────────────────────────────────────────
        sectionBanner('6 \u00b7 Mapping Status to UI',
            'How each state drives the text field appearance',
            twilight, Colors.white),
        for (final mapping in [
          (LiveTextInputStatus.unknown, 'Loading...', Icons.hourglass_empty,
              'Show placeholder or shimmer', dawnGold),
          (LiveTextInputStatus.enabled, 'Scan Text', Icons.camera_alt,
              'Show camera button in toolbar', const Color(0xFF2E7D32)),
          (LiveTextInputStatus.disabled, '(hidden)', Icons.visibility_off,
              'Hide camera button entirely', sunsetPink),
        ])
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: moonGlow,
              borderRadius: BorderRadius.circular(8),
              border: Border(left: BorderSide(color: mapping.$5, width: 3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: mapping.$5.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(mapping.$3, size: 22, color: mapping.$5),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(mapping.$1.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: deepDusk)),
                          const SizedBox(width: 8),
                          Text(mapping.$2,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: mapping.$5)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(mapping.$4,
                          style: TextStyle(
                              fontSize: 12, color: amethyst)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 14),

        // ── 8. Simulated text field states ───────────────────────────
        sectionBanner('7 \u00b7 Simulated Text Field States',
            'How the text field toolbar changes per status',
            deepDusk, Colors.white),
        for (final status in LiveTextInputStatus.values)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4, left: 4),
                  child: Row(
                    children: [
                      Icon(statusIcon(status),
                          size: 14, color: statusColor(status)),
                      const SizedBox(width: 4),
                      Text('Status: ${status.name}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: statusColor(status))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: lilac),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Type or scan text...',
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 14)),
                      ),
                      if (status == LiveTextInputStatus.enabled)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(Icons.camera_alt,
                              size: 18,
                              color: const Color(0xFF2E7D32)),
                        )
                      else if (status == LiveTextInputStatus.unknown)
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: dawnGold,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 14),

        // ── 9. Platform availability ─────────────────────────────────
        sectionBanner('8 \u00b7 Platform Availability',
            'Expected status per platform', richPurple, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: moonGlow,
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
                decoration: BoxDecoration(color: deepDusk),
                children: [
                  for (final h in ['Platform', 'Expected', 'Notes'])
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
                ('iOS 15+', 'enabled', 'Full camera OCR support'),
                ('iOS < 15', 'disabled', 'Feature not available'),
                ('iPadOS 15+', 'enabled', 'Full support with larger viewfinder'),
                ('macOS 12+', 'enabled', 'Camera-based text recognition'),
                ('Android', 'disabled', 'Not an Apple platform feature'),
                ('Web', 'disabled', 'No native camera access'),
                ('Windows', 'disabled', 'Not supported'),
                ('Linux', 'disabled', 'Not supported'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: deepDusk)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: row.$2 == 'enabled'
                              ? const Color(0xFF2E7D32).withValues(alpha: 0.1)
                              : sunsetPink.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(row.$2,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: row.$2 == 'enabled'
                                    ? const Color(0xFF2E7D32)
                                    : sunsetPink)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(fontSize: 11, color: amethyst)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Switch/pattern matching ──────────────────────────────
        sectionBanner('9 \u00b7 Pattern Matching',
            'Using switch expressions with this enum',
            twilight, Colors.white),
        noteBox(
          'As a Dart enum, LiveTextInputStatus works perfectly with '
          'switch expressions and pattern matching. The compiler ensures '
          'all cases are handled, making it safe to use without a default '
          'case — the exhaustiveness checker guarantees coverage.',
          twilight,
          moonGlow,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: moonGlow,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Switch expression results:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: deepDusk)),
              const SizedBox(height: 8),
              for (final status in LiveTextInputStatus.values)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor(status).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(status.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: statusColor(status))),
                      ),
                      const SizedBox(width: 8),
                      Text('\u2192',
                          style: TextStyle(color: twilight, fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          switch (status) {
                            LiveTextInputStatus.unknown =>
                              'Show loading indicator',
                            LiveTextInputStatus.enabled =>
                              'Show camera scan button',
                            LiveTextInputStatus.disabled =>
                              'Remove camera option from toolbar',
                            _ => 'Unknown', // D4RT-LIMITATION: enum exhaustiveness
                          },
                          style: TextStyle(fontSize: 12, color: deepDusk),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Status dashboard ─────────────────────────────────────
        sectionBanner('10 \u00b7 Live Status Dashboard',
            'Visual monitoring panel for all states',
            deepDusk, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepDusk.withValues(alpha: 0.05), moonGlow],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lilac),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.monitor_heart, size: 20, color: deepDusk),
                  const SizedBox(width: 8),
                  Text('Live Text Status Monitor',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: deepDusk)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  for (final status in LiveTextInputStatus.values)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: statusColor(status).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: statusColor(status).withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          children: [
                            Icon(statusIcon(status),
                                size: 28, color: statusColor(status)),
                            const SizedBox(height: 6),
                            Text(status.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor(status))),
                            const SizedBox(height: 2),
                            Text('index: ${status.index}',
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

        // ── 12. Feature detection flow ───────────────────────────────
        sectionBanner('11 \u00b7 Feature Detection Flow',
            'Decision tree from app start to UI update',
            richPurple, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: moonGlow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'App creates notifier', 'Status starts as unknown', dawnGold),
                (2, 'Async platform check', 'LiveText.isLiveTextInputAvailable()', twilight),
                (3, 'Platform responds', 'Returns true or false', amethyst),
                (4, 'Status updated', 'Changes to enabled or disabled', const Color(0xFF2E7D32)),
                (5, 'Listeners notified', 'UI rebuilds with new state', deepDusk),
                (6, 'TextField updates', 'Camera button shown or hidden', richPurple),
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
                                    color: deepDusk)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 11, color: amethyst)),
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

        // ── 13. Relationship with notifier ───────────────────────────
        sectionBanner('12 \u00b7 Relationship with Notifier',
            'How enum and notifier work together',
            twilight, Colors.white),
        noteBox(
          'LiveTextInputStatus is the value type. '
          'LiveTextInputStatusNotifier is the ValueNotifier that holds '
          'and updates this value. The notifier manages the lifecycle '
          '(adding/removing observers, checking platform), while the '
          'enum simply represents the three possible states.',
          twilight,
          moonGlow,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: moonGlow,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in [
                'LiveTextInputStatusNotifier (manages)',
                '  \u2514\u2500 value: LiveTextInputStatus (state)',
                '       \u251c\u2500 .unknown',
                '       \u251c\u2500 .enabled',
                '       \u2514\u2500 .disabled',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(line,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: line.contains('unknown')
                              ? dawnGold
                              : line.contains('enabled')
                                  ? const Color(0xFF2E7D32)
                                  : line.contains('disabled')
                                      ? sunsetPink
                                      : deepDusk)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. HashCode visualization ───────────────────────────────
        sectionBanner('13 \u00b7 Identity and HashCode',
            'Enum identity guarantees', amethyst, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: moonGlow,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              for (final status in LiveTextInputStatus.values)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(statusIcon(status),
                          size: 16, color: statusColor(status)),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 80,
                        child: Text(status.name,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: deepDusk)),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: lilac.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('hashCode: ${status.hashCode}',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: twilight)),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        noteBox(
          'Dart enums are singletons — each value has exactly one instance. '
          'This means == compares identity (same object), which is both '
          'fast and correct. No need for .equals() or deep comparison.',
          amethyst,
          moonGlow,
        ),
        const SizedBox(height: 14),

        // ── 15. When to check ────────────────────────────────────────
        sectionBanner('14 \u00b7 When to Check Status',
            'Timing considerations', deepDusk, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: moonGlow,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final timing in [
                ('App start', 'Initial unknown \u2192 async check', true),
                ('Resume from bg', 'Re-check (capabilities may change)', true),
                ('Every frame', 'NOT needed — use listener', false),
                ('On button press', 'NOT needed — pre-resolved', false),
                ('On text field focus', 'NOT needed — already known', false),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        timing.$3 ? Icons.check : Icons.close,
                        size: 16,
                        color: timing.$3
                            ? const Color(0xFF2E7D32)
                            : sunsetPink,
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 110,
                        child: Text(timing.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: deepDusk)),
                      ),
                      Expanded(
                        child: Text(timing.$2,
                            style: TextStyle(
                                fontSize: 12,
                                color: timing.$3 ? twilight : Colors.grey)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepDusk, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepDusk, richPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Enum with 3 values: unknown, enabled, disabled',
                'Represents iOS Live Text (camera OCR) availability',
                'unknown is the initial state before async platform check',
                'enabled means the camera text scan button should appear',
                'disabled means hide the camera option entirely',
                'Used as value type for LiveTextInputStatusNotifier',
                'Supports exhaustive switch expressions',
                'Singleton identity — fast == comparison',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: orchid,
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

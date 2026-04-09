// ignore_for_file: avoid_print
// D4rt test script: Deep demo of TargetPlatform from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Theme: Forest Green / Emerald ──────────────────────────────
  const tpPrimary = Color(0xFF2E7D32);
  const tpSecondary = Color(0xFF43A047);
  const tpAccent = Color(0xFF66BB6A);
  const tpSurface = Color(0xFFE8F5E9);
  const tpDark = Color(0xFF1B5E20);
  const tpOnSurface = Color(0xFF1B5E20);
  final tpDarkened = Color.lerp(tpPrimary, Colors.black, 0.3)!;

  // ── 1. Enum overview ──────────────────────────────────────────
  print('=== TargetPlatform Deep Demo ===');
  print('TargetPlatform is a foundation enum with ${TargetPlatform.values.length} values');
  for (final p in TargetPlatform.values) {
    print('  ${p.name} (index ${p.index})');
  }

  // ── 2. All platform values ────────────────────────────────────
  final android = TargetPlatform.android;
  final fuchsia = TargetPlatform.fuchsia;
  final ios = TargetPlatform.iOS;
  final linux = TargetPlatform.linux;
  final macos = TargetPlatform.macOS;
  final windows = TargetPlatform.windows;
  print('\nPlatform details:');
  print('  android: index=${android.index}, name=${android.name}');
  print('  fuchsia: index=${fuchsia.index}, name=${fuchsia.name}');
  print('  iOS: index=${ios.index}, name=${ios.name}');
  print('  linux: index=${linux.index}, name=${linux.name}');
  print('  macOS: index=${macos.index}, name=${macos.name}');
  print('  windows: index=${windows.index}, name=${windows.name}');

  // ── 3. defaultTargetPlatform ──────────────────────────────────
  final current = defaultTargetPlatform;
  print('\ndefaultTargetPlatform: $current');
  print('  name: ${current.name}, index: ${current.index}');

  // ── 4. Platform categorization ────────────────────────────────
  String tpCategory(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return 'Mobile';
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return 'Desktop';
    }
  }
  print('\nPlatform categories:');
  for (final p in TargetPlatform.values) {
    print('  ${p.name}: ${tpCategory(p)}');
  }

  // ── 5. Equality and identity ──────────────────────────────────
  print('\nEquality:');
  print('  android == android: ${android == TargetPlatform.android}');
  print('  android == iOS: ${android == ios}');
  print('  identical(android, TargetPlatform.android): ${identical(android, TargetPlatform.android)}');
  print('  hashCode android: ${android.hashCode}');
  print('  hashCode iOS: ${ios.hashCode}');

  // ── 6. String/name conversions ────────────────────────────────
  print('\ntoString vs name:');
  for (final p in TargetPlatform.values) {
    print('  toString: $p  |  name: ${p.name}');
  }

  // ── 7. Platform-specific icon mapping ─────────────────────────
  IconData tpIcon(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.android:
        return Icons.android;
      case TargetPlatform.fuchsia:
        return Icons.devices_other;
      case TargetPlatform.iOS:
        return Icons.phone_iphone;
      case TargetPlatform.linux:
        return Icons.computer;
      case TargetPlatform.macOS:
        return Icons.laptop_mac;
      case TargetPlatform.windows:
        return Icons.desktop_windows;
    }
  }
  print('\nPlatform icon mappings assigned');

  // ── 8. Platform feature matrix ────────────────────────────────
  bool tpHasMaterialMotion(TargetPlatform p) =>
      p == TargetPlatform.android || p == TargetPlatform.fuchsia;
  bool tpHasCupertinoOverscroll(TargetPlatform p) =>
      p == TargetPlatform.iOS || p == TargetPlatform.macOS;
  bool tpHasDesktopScrollbar(TargetPlatform p) =>
      p == TargetPlatform.linux || p == TargetPlatform.macOS || p == TargetPlatform.windows;
  print('\nFeature matrix:');
  for (final p in TargetPlatform.values) {
    print('  ${p.name}: material_motion=${tpHasMaterialMotion(p)}, '
        'cupertino_overscroll=${tpHasCupertinoOverscroll(p)}, '
        'desktop_scrollbar=${tpHasDesktopScrollbar(p)}');
  }

  // ── 9. debugDefaultTargetPlatformOverride ─────────────────────
  print('\ndebugDefaultTargetPlatformOverride: $debugDefaultTargetPlatformOverride');
  print('This is null unless explicitly set for testing');

  // ── 10. Index-based access ────────────────────────────────────
  print('\nIndex-based access:');
  for (var i = 0; i < TargetPlatform.values.length; i++) {
    final p = TargetPlatform.values[i];
    print('  values[$i] = ${p.name}');
  }
  final first = TargetPlatform.values.first;
  final last = TargetPlatform.values.last;
  print('  first: ${first.name}, last: ${last.name}');

  // ── 11. Platform-specific colors ──────────────────────────────
  Color tpPlatformColor(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.android:
        return const Color(0xFF3DDC84);
      case TargetPlatform.fuchsia:
        return const Color(0xFFE040FB);
      case TargetPlatform.iOS:
        return const Color(0xFF007AFF);
      case TargetPlatform.linux:
        return const Color(0xFFF9A825);
      case TargetPlatform.macOS:
        return const Color(0xFF757575);
      case TargetPlatform.windows:
        return const Color(0xFF0078D4);
    }
  }
  print('\nPlatform brand colors assigned');

  // ── 12. Sorting platforms ─────────────────────────────────────
  final sorted = List<TargetPlatform>.from(TargetPlatform.values)
    ..sort((a, b) => a.name.compareTo(b.name));
  print('\nAlphabetically sorted:');
  for (final p in sorted) {
    print('  ${p.name}');
  }

  // ── 13. Index comparison ──────────────────────────────────────
  print('\nIndex comparisons:');
  print('  android.index < windows.index: ${android.index < windows.index}');
  print('  iOS.index > linux.index: ${ios.index > linux.index}');
  print('  macOS.index: ${macos.index}');

  // ── 14. Platform description labels ───────────────────────────
  String tpDescription(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.android:
        return 'Google mobile OS with Material Design';
      case TargetPlatform.fuchsia:
        return 'Google experimental OS';
      case TargetPlatform.iOS:
        return 'Apple mobile OS with Cupertino style';
      case TargetPlatform.linux:
        return 'Open-source desktop OS';
      case TargetPlatform.macOS:
        return 'Apple desktop OS';
      case TargetPlatform.windows:
        return 'Microsoft desktop OS with Fluent style';
    }
  }
  print('\nPlatform descriptions:');
  for (final p in TargetPlatform.values) {
    print('  ${p.name}: ${tpDescription(p)}');
  }

  // ── 15. Filtering platforms ───────────────────────────────────
  final mobilePlatforms = TargetPlatform.values
      .where((p) => tpCategory(p) == 'Mobile')
      .toList();
  final desktopPlatforms = TargetPlatform.values
      .where((p) => tpCategory(p) == 'Desktop')
      .toList();
  print('\nMobile: ${mobilePlatforms.map((p) => p.name).join(', ')}');
  print('Desktop: ${desktopPlatforms.map((p) => p.name).join(', ')}');

  // ── 16. Visual builder ────────────────────────────────────────
  print('\nTargetPlatform deep demo completed');

  Widget tpPlatformCard(TargetPlatform platform) {
    final color = tpPlatformColor(platform);
    final isCurrent = platform == current;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrent ? color.withValues(alpha: 0.15) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCurrent ? color : Colors.grey.withValues(alpha: 0.3),
          width: isCurrent ? 2.5 : 1,
        ),
        boxShadow: isCurrent
            ? [BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 8, offset: const Offset(0, 2))]
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(tpIcon(platform), color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      platform.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.lerp(color, Colors.black, 0.3),
                      ),
                    ),
                    if (isCurrent) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('CURRENT', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  tpDescription(platform),
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('index: ${platform.index}', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: tpCategory(platform) == 'Mobile'
                            ? const Color(0xFFE3F2FD)
                            : const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tpCategory(platform),
                        style: TextStyle(
                          fontSize: 10,
                          color: tpCategory(platform) == 'Mobile'
                              ? const Color(0xFF1565C0)
                              : const Color(0xFFE65100),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tpFeatureRow(String label, List<bool> values) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
          ),
          ...values.map((v) => Expanded(
                child: Center(
                  child: Icon(
                    v ? Icons.check_circle : Icons.cancel,
                    size: 16,
                    color: v ? tpAccent : Colors.grey[300],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget tpStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
        ],
      ),
    );
  }

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [tpPrimary, tpSecondary, tpAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: tpPrimary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [
              const Icon(Icons.devices, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              const Text('TargetPlatform', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                'Foundation enum — ${TargetPlatform.values.length} supported platforms',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Stats row ──
        Row(
          children: [
            Expanded(child: tpStatChip('Total', '${TargetPlatform.values.length}', tpPrimary)),
            const SizedBox(width: 8),
            Expanded(child: tpStatChip('Mobile', '${mobilePlatforms.length}', const Color(0xFF1565C0))),
            const SizedBox(width: 8),
            Expanded(child: tpStatChip('Desktop', '${desktopPlatforms.length}', const Color(0xFFE65100))),
          ],
        ),
        const SizedBox(height: 16),

        // ── Current platform ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: tpSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tpPrimary.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(tpIcon(current), color: tpPrimary, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('defaultTargetPlatform', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    Text(current.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: tpDark)),
                    Text(tpDescription(current), style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Platform cards ──
        Text('All Platforms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: tpDarkened)),
        const SizedBox(height: 8),
        ...TargetPlatform.values.map(tpPlatformCard),
        const SizedBox(height: 16),

        // ── Feature matrix ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Feature Matrix', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: tpDark)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 130),
                  ...TargetPlatform.values.map((p) => Expanded(
                        child: Center(
                          child: Text(p.name.substring(0, 3), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                        ),
                      )),
                ],
              ),
              const Divider(height: 12),
              tpFeatureRow('Material Motion', TargetPlatform.values.map(tpHasMaterialMotion).toList()),
              tpFeatureRow('Cupertino Scroll', TargetPlatform.values.map(tpHasCupertinoOverscroll).toList()),
              tpFeatureRow('Desktop Scrollbar', TargetPlatform.values.map(tpHasDesktopScrollbar).toList()),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Sorted display ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Alphabetical Order', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: tpDark)),
              const SizedBox(height: 8),
              ...sorted.asMap().entries.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(color: tpAccent.withValues(alpha: 0.2), shape: BoxShape.circle),
                          child: Center(child: Text('${e.key + 1}', style: TextStyle(fontSize: 10, color: tpDark, fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(width: 8),
                        Text(e.value.name, style: const TextStyle(fontSize: 13)),
                        const Spacer(),
                        Text('index ${e.value.index}', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Debug override info ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.bug_report, color: Colors.amber, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('debugDefaultTargetPlatformOverride', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Text(
                      'Currently: ${debugDefaultTargetPlatformOverride ?? "null (not overridden)"}',
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Footer ──
        Center(
          child: Text(
            'TargetPlatform — ${TargetPlatform.values.length} platforms | ${mobilePlatforms.length} mobile | ${desktopPlatforms.length} desktop',
            style: TextStyle(fontSize: 10, color: tpOnSurface.withValues(alpha: 0.5)),
          ),
        ),
      ],
    ),
  );
}

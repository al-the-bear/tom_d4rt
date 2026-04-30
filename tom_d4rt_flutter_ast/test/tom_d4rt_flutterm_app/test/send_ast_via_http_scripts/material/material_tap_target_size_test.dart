// ignore_for_file: avoid_print, deprecated_member_use
// D4rt deep-demo: MaterialTapTargetSize — Slate / Graphite theme
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialTapTargetSize deep-demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────
  // 1. Enum overview & catalogue
  // ──────────────────────────────────────────────
  print('\n[1] Enum overview & catalogue');
  final mtAllValues = MaterialTapTargetSize.values;
  print('  Total enum values: ${mtAllValues.length}');
  for (final v in mtAllValues) {
    print('  ${v.index}: ${v.name} (${v.runtimeType})');
  }

  const mtPadded = MaterialTapTargetSize.padded;
  const mtShrinkWrap = MaterialTapTargetSize.shrinkWrap;

  // ──────────────────────────────────────────────
  // 2. Identity & equality checks
  // ──────────────────────────────────────────────
  print('\n[2] Identity & equality checks');
  print('  padded == padded: ${mtPadded == MaterialTapTargetSize.padded}');
  print('  padded == shrinkWrap: ${mtPadded == mtShrinkWrap}');
  print('  shrinkWrap == shrinkWrap: ${mtShrinkWrap == MaterialTapTargetSize.shrinkWrap}');
  print('  identical(padded, values[0]): ${identical(mtPadded, mtAllValues[0])}');
  print('  identical(shrinkWrap, values[1]): ${identical(mtShrinkWrap, mtAllValues[1])}');

  // ──────────────────────────────────────────────
  // 3. Index arithmetic & round-trip
  // ──────────────────────────────────────────────
  print('\n[3] Index arithmetic & round-trip');
  for (final v in mtAllValues) {
    final roundTrip = MaterialTapTargetSize.values[v.index];
    print('  ${v.name} -> index ${v.index} -> values[${v.index}] = ${roundTrip.name} (match: ${roundTrip == v})');
  }
  final mtFirst = mtAllValues.first;
  final mtLast = mtAllValues.last;
  print('  First: ${mtFirst.name}, Last: ${mtLast.name}');
  print('  Toggle: padded -> ${mtAllValues[1 - mtPadded.index].name}');
  print('  Toggle: shrinkWrap -> ${mtAllValues[1 - mtShrinkWrap.index].name}');

  // ──────────────────────────────────────────────
  // 4. String ↔ enum conversion
  // ──────────────────────────────────────────────
  print('\n[4] String / enum conversion');
  final mtTestNames = ['padded', 'shrinkWrap', 'compact', 'large', 'unknown'];
  for (final name in mtTestNames) {
    final found = mtAllValues.where((v) => v.name == name);
    print('  "$name" -> ${found.isNotEmpty ? found.first : "not found"}');
  }

  // ──────────────────────────────────────────────
  // 5. Sorting & ordering
  // ──────────────────────────────────────────────
  print('\n[5] Sorting & ordering');
  print('  Natural: ${mtAllValues.map((v) => v.name).join(", ")}');
  final mtAlpha = List<MaterialTapTargetSize>.from(mtAllValues)..sort((a, b) => a.name.compareTo(b.name));
  print('  Alpha  : ${mtAlpha.map((v) => v.name).join(", ")}');
  final mtRev = List<MaterialTapTargetSize>.from(mtAllValues)..sort((a, b) => b.index.compareTo(a.index));
  print('  Reverse: ${mtRev.map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 6. Map-based description & sizing
  // ──────────────────────────────────────────────
  print('\n[6] Map-based description & sizing');
  final mtDescMap = <MaterialTapTargetSize, String>{
    mtPadded: 'Enforces 48x48dp minimum (Material guideline)',
    mtShrinkWrap: 'No minimum, shrinks to content size',
  };
  final mtSizeMap = <MaterialTapTargetSize, double>{
    mtPadded: 48.0,
    mtShrinkWrap: 0.0,
  };
  for (final entry in mtDescMap.entries) {
    print('  ${entry.key.name}: ${entry.value}');
    print('    Min target: ${mtSizeMap[entry.key]}dp');
  }

  // ──────────────────────────────────────────────
  // 7. Pattern matching / switch expression
  // ──────────────────────────────────────────────
  print('\n[7] Pattern matching / switch expression');
  for (final v in mtAllValues) {
    final desc = switch (v) {
      MaterialTapTargetSize.padded => 'accessible: 48x48dp minimum touch area',
      MaterialTapTargetSize.shrinkWrap => 'compact: no padding around widget',
    };
    print('  ${v.name} -> $desc');
  }

  // ──────────────────────────────────────────────
  // 8. ThemeData integration
  // ──────────────────────────────────────────────
  print('\n[8] ThemeData integration');
  for (final size in mtAllValues) {
    final theme = ThemeData(materialTapTargetSize: size, useMaterial3: true);
    print('  ThemeData with ${size.name}:');
    print('    materialTapTargetSize: ${theme.materialTapTargetSize}');
    print('    brightness: ${theme.brightness}');
  }

  // ──────────────────────────────────────────────
  // 9. Button style comparison
  // ──────────────────────────────────────────────
  print('\n[9] Button style comparison');
  for (final size in mtAllValues) {
    final style = ElevatedButton.styleFrom(tapTargetSize: size);
    print('  ElevatedButton.styleFrom(tapTargetSize: ${size.name}):');
    print('    tapTargetSize: ${style.tapTargetSize}');
  }
  for (final size in mtAllValues) {
    final style = TextButton.styleFrom(tapTargetSize: size);
    print('  TextButton.styleFrom(tapTargetSize: ${size.name}):');
    print('    tapTargetSize: ${style.tapTargetSize}');
  }
  for (final size in mtAllValues) {
    final style = OutlinedButton.styleFrom(tapTargetSize: size);
    print('  OutlinedButton.styleFrom(tapTargetSize: ${size.name}):');
    print('    tapTargetSize: ${style.tapTargetSize}');
  }

  // ──────────────────────────────────────────────
  // 10. Accessibility scenario simulation
  // ──────────────────────────────────────────────
  print('\n[10] Accessibility scenario simulation');
  final mtContentSizes = [20.0, 30.0, 40.0, 48.0, 56.0];
  for (final contentSize in mtContentSizes) {
    for (final size in mtAllValues) {
      final effectiveSize = switch (size) {
        MaterialTapTargetSize.padded => contentSize < 48.0 ? 48.0 : contentSize,
        MaterialTapTargetSize.shrinkWrap => contentSize,
      };
      final accessible = effectiveSize >= 48.0;
      print('  Content ${contentSize}dp + ${size.name} -> effective: ${effectiveSize}dp, accessible: $accessible');
    }
  }

  // ──────────────────────────────────────────────
  // 11. Checkbox / Switch / Radio sizing
  // ──────────────────────────────────────────────
  print('\n[11] Checkbox / Switch / Radio sizing');
  for (final size in mtAllValues) {
    final checkbox = Checkbox(value: true, onChanged: (_) {}, materialTapTargetSize: size);
    print('  Checkbox(${size.name}): ${checkbox.runtimeType}, materialTapTargetSize: ${checkbox.materialTapTargetSize}');
  }
  for (final size in mtAllValues) {
    final radio = Radio<int>(value: 1, groupValue: 1, onChanged: (_) {}, materialTapTargetSize: size);
    print('  Radio(${size.name}): ${radio.runtimeType}, materialTapTargetSize: ${radio.materialTapTargetSize}');
  }
  for (final size in mtAllValues) {
    final sw = Switch(value: true, onChanged: (_) {}, materialTapTargetSize: size);
    print('  Switch(${size.name}): ${sw.runtimeType}, materialTapTargetSize: ${sw.materialTapTargetSize}');
  }

  // ──────────────────────────────────────────────
  // 12. IconButton sizing
  // ──────────────────────────────────────────────
  print('\n[12] IconButton sizing');
  for (final size in mtAllValues) {
    final style = IconButton.styleFrom(tapTargetSize: size);
    print('  IconButton.styleFrom(${size.name}): tapTargetSize: ${style.tapTargetSize}');
  }
  final mtIconBtnPadded = IconButton(
    icon: const Icon(Icons.star),
    onPressed: () {},
    style: IconButton.styleFrom(tapTargetSize: mtPadded),
  );
  final mtIconBtnShrink = IconButton(
    icon: const Icon(Icons.star),
    onPressed: () {},
    style: IconButton.styleFrom(tapTargetSize: mtShrinkWrap),
  );
  print('  Padded IconButton: ${mtIconBtnPadded.runtimeType}');
  print('  ShrinkWrap IconButton: ${mtIconBtnShrink.runtimeType}');

  // ──────────────────────────────────────────────
  // 13. Theme integration colour palette
  // ──────────────────────────────────────────────
  print('\n[13] Theme integration colour palette');
  const mtSlate = Color(0xFF607D8B);
  const mtGraphite = Color(0xFF37474F);
  const mtSlateLight = Color(0xFFCFD8DC);
  final mtColors = <String, Color>{'slate': mtSlate, 'graphite': mtGraphite, 'slateLight': mtSlateLight};
  for (final entry in mtColors.entries) {
    final c = entry.value;
    print('  ${entry.key}: a=${c.a.toStringAsFixed(2)}, r=${c.r.toStringAsFixed(2)}, g=${c.g.toStringAsFixed(2)}, b=${c.b.toStringAsFixed(2)}');
  }

  // ──────────────────────────────────────────────
  // 14. Dense vs comfortable layout simulation
  // ──────────────────────────────────────────────
  print('\n[14] Dense vs comfortable layout simulation');
  final mtLayoutItems = ['Save', 'Edit', 'Delete', 'Share', 'Copy'];
  for (final size in mtAllValues) {
    final spacing = size == mtPadded ? 12.0 : 4.0;
    final totalHeight = mtLayoutItems.length * (size == mtPadded ? 48.0 : 28.0) + (mtLayoutItems.length - 1) * spacing;
    print('  ${size.name} layout:');
    print('    Items: ${mtLayoutItems.length}, spacing: ${spacing}dp');
    print('    Total height: ${totalHeight}dp');
  }

  // ──────────────────────────────────────────────
  // 15. Visual comparison builder
  // ──────────────────────────────────────────────
  print('\n[15] Visual comparison builder');

  Widget mtBuildColumn(MaterialTapTargetSize size, Color accent) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(size.name.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: accent)),
          const SizedBox(height: 4),
          Text(mtDescMap[size] ?? '', textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
          const SizedBox(height: 10),
          Text('Min target: ${mtSizeMap[size]}dp', style: TextStyle(fontSize: 12, color: accent)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(tapTargetSize: size, backgroundColor: accent),
            child: const Text('Button', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 8),
          Checkbox(value: true, onChanged: (_) {}, materialTapTargetSize: size, activeColor: accent),
          Switch(value: true, onChanged: (_) {}, materialTapTargetSize: size, activeColor: accent),
          Radio<int>(value: 1, groupValue: 1, onChanged: (_) {}, materialTapTargetSize: size, activeColor: accent),
        ],
      ),
    );
  }

  final mtPaddedCol = mtBuildColumn(mtPadded, mtSlate);
  final mtShrinkCol = mtBuildColumn(mtShrinkWrap, mtGraphite);
  print('  Built comparison columns for padded and shrinkWrap');

  // ──────────────────────────────────────────────
  // 16. Summary dashboard widget
  // ──────────────────────────────────────────────
  print('\n[16] Summary dashboard widget');
  print('  Building full visual demo...');
  print('=' * 60);
  print('MaterialTapTargetSize deep-demo completed');

  // -- Visual UI --
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [mtSlate, mtGraphite]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'MaterialTapTargetSize\nDeep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),
        const SizedBox(height: 16),

        // Enum info
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: mtSlateLight.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: mtSlate.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enum Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: mtGraphite)),
              const SizedBox(height: 8),
              Text('Total values: ${mtAllValues.length}', style: const TextStyle(fontSize: 13)),
              Text('Type: ${mtPadded.runtimeType}', style: const TextStyle(fontSize: 13)),
              const Text('Default: padded (48x48dp minimum)', style: TextStyle(fontSize: 13)),
              const Text('Purpose: Controls minimum touch target area', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Side-by-side comparison
        const Text('Side-by-Side Comparison', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: mtPaddedCol),
            const SizedBox(width: 10),
            Expanded(child: mtShrinkCol),
          ],
        ),
        const SizedBox(height: 14),

        // Accessibility guidelines
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Accessibility Guidelines', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...mtContentSizes.map((sz) {
                final accessible = sz >= 48.0;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(accessible ? Icons.check_circle : Icons.warning,
                          size: 16, color: accessible ? Colors.green : Colors.orange),
                      const SizedBox(width: 8),
                      Text('${sz}dp: ${accessible ? "meets" : "below"} 48dp guideline',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Layout density
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: mtSlate.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Layout Density Comparison', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...mtAllValues.map((sz) {
                final h = sz == mtPadded ? 48.0 : 28.0;
                final total = mtLayoutItems.length * h;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(width: 90, child: Text(sz.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                      Expanded(
                        child: Container(
                          height: 14,
                          decoration: BoxDecoration(
                            color: mtGraphite.withValues(alpha: total / 300),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${total}dp', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Footer
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [mtGraphite, mtSlate]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'MaterialTapTargetSize  ${mtAllValues.length} values  Slate/Graphite',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

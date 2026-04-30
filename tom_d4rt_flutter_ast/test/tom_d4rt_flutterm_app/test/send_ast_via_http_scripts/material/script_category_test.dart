// ignore_for_file: avoid_print
// D4rt deep-demo: ScriptCategory — Magenta / Fuchsia theme
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScriptCategory deep-demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────
  // 1. Enum overview & catalogue
  // ──────────────────────────────────────────────
  print('\n[1] Enum overview & catalogue');
  final scAllValues = ScriptCategory.values;
  print('  Total enum values: ${scAllValues.length}');
  for (final v in scAllValues) {
    print('  ${v.index}: ${v.name} (${v.runtimeType})');
  }

  const scEnglishLike = ScriptCategory.englishLike;
  const scDense = ScriptCategory.dense;
  const scTall = ScriptCategory.tall;

  // ──────────────────────────────────────────────
  // 2. Identity & equality checks
  // ──────────────────────────────────────────────
  print('\n[2] Identity & equality checks');
  print('  englishLike == englishLike: ${scEnglishLike == ScriptCategory.englishLike}');
  print('  englishLike == dense: ${scEnglishLike == scDense}');
  print('  dense == tall: ${scDense == scTall}');
  print('  identical(englishLike, values[0]): ${identical(scEnglishLike, scAllValues[0])}');
  print('  identical(dense, values[1]): ${identical(scDense, scAllValues[1])}');
  print('  identical(tall, values[2]): ${identical(scTall, scAllValues[2])}');

  // ──────────────────────────────────────────────
  // 3. Index arithmetic & round-trip
  // ──────────────────────────────────────────────
  print('\n[3] Index arithmetic & round-trip');
  for (final v in scAllValues) {
    final roundTrip = ScriptCategory.values[v.index];
    print('  ${v.name} -> index ${v.index} -> values[${v.index}] = ${roundTrip.name} (match: ${roundTrip == v})');
  }

  // ──────────────────────────────────────────────
  // 4. String / enum conversion
  // ──────────────────────────────────────────────
  print('\n[4] String / enum conversion');
  final scTestNames = ['englishLike', 'dense', 'tall', 'compact', 'wide', 'latin'];
  for (final name in scTestNames) {
    final found = scAllValues.where((v) => v.name == name);
    print('  "$name" -> ${found.isNotEmpty ? found.first : "not found"}');
  }

  // ──────────────────────────────────────────────
  // 5. Sorting & ordering
  // ──────────────────────────────────────────────
  print('\n[5] Sorting & ordering');
  print('  Natural: ${scAllValues.map((v) => v.name).join(", ")}');
  final scAlpha = List<ScriptCategory>.from(scAllValues)..sort((a, b) => a.name.compareTo(b.name));
  print('  Alpha  : ${scAlpha.map((v) => v.name).join(", ")}');
  final scRev = List<ScriptCategory>.from(scAllValues)..sort((a, b) => b.index.compareTo(a.index));
  print('  Reverse: ${scRev.map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 6. Map-based behaviour description
  // ──────────────────────────────────────────────
  print('\n[6] Map-based behaviour description');
  final scDescMap = <ScriptCategory, String>{
    scEnglishLike: 'Latin, Greek, Cyrillic — standard Western metrics and x-height',
    scDense: 'CJK scripts (Chinese, Japanese, Korean) — compact square glyphs',
    scTall: 'Arabic, Hindi, Thai — taller ascenders, wider vertical extent',
  };
  for (final entry in scDescMap.entries) {
    print('  ${entry.key.name}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 7. Pattern matching / switch expression
  // ──────────────────────────────────────────────
  print('\n[7] Pattern matching / switch expression');
  for (final v in scAllValues) {
    final desc = switch (v) {
      ScriptCategory.englishLike => 'moderate height, standard spacing',
      ScriptCategory.dense => 'uniform glyph box, tighter horizontal spacing',
      ScriptCategory.tall => 'increased vertical metrics, looser lines',
    };
    print('  ${v.name} -> $desc');
  }

  // ──────────────────────────────────────────────
  // 8. Script families per category
  // ──────────────────────────────────────────────
  print('\n[8] Script families per category');
  final scFamilies = <ScriptCategory, List<String>>{
    scEnglishLike: ['Latin', 'Greek', 'Cyrillic', 'Armenian', 'Georgian'],
    scDense: ['Chinese (Simplified)', 'Chinese (Traditional)', 'Japanese', 'Korean'],
    scTall: ['Arabic', 'Devanagari (Hindi)', 'Thai', 'Telugu', 'Tamil', 'Bengali'],
  };
  for (final entry in scFamilies.entries) {
    print('  ${entry.key.name}: ${entry.value.join(", ")}');
  }

  // ──────────────────────────────────────────────
  // 9. Typography metrics
  // ──────────────────────────────────────────────
  print('\n[9] Typography metrics');
  final scMetrics = <ScriptCategory, Map<String, double>>{
    scEnglishLike: {'bodyFontSize': 14.0, 'lineHeight': 1.43, 'letterSpacing': 0.25},
    scDense: {'bodyFontSize': 14.0, 'lineHeight': 1.43, 'letterSpacing': 0.0},
    scTall: {'bodyFontSize': 14.0, 'lineHeight': 1.57, 'letterSpacing': 0.25},
  };
  for (final entry in scMetrics.entries) {
    print('  ${entry.key.name}:');
    for (final m in entry.value.entries) {
      print('    ${m.key}: ${m.value}');
    }
  }

  // ──────────────────────────────────────────────
  // 10. Typography object exploration
  // ──────────────────────────────────────────────
  print('\n[10] Typography object exploration');
  final scTypography = Typography.material2021();
  final scEngTheme = scTypography.englishLike;
  final scDenseTheme = scTypography.dense;
  final scTallTheme = scTypography.tall;
  print('  englishLike.bodyMedium: ${scEngTheme.bodyMedium}');
  print('  dense.bodyMedium: ${scDenseTheme.bodyMedium}');
  print('  tall.bodyMedium: ${scTallTheme.bodyMedium}');

  // ──────────────────────────────────────────────
  // 11. Line height comparison
  // ──────────────────────────────────────────────
  print('\n[11] Line height comparison');
  final scLineHeights = <ScriptCategory, double>{
    scEnglishLike: 1.43,
    scDense: 1.43,
    scTall: 1.57,
  };
  for (final entry in scLineHeights.entries) {
    final bar = '#' * (entry.value * 10).toInt();
    print('  ${entry.key.name}: ${entry.value} $bar');
  }
  final scMaxLine = scLineHeights.values.reduce((a, b) => a > b ? a : b);
  final scMinLine = scLineHeights.values.reduce((a, b) => a < b ? a : b);
  print('  Range: $scMinLine - $scMaxLine (diff: ${(scMaxLine - scMinLine).toStringAsFixed(2)})');

  // ──────────────────────────────────────────────
  // 12. Sample text per category
  // ──────────────────────────────────────────────
  print('\n[12] Sample text per category');
  final scSamples = <ScriptCategory, Map<String, String>>{
    scEnglishLike: {'English': 'The quick brown fox jumps over the lazy dog', 'Greek': 'Ο γρήγορος αλεπούδες'},
    scDense: {'Chinese': '快速的棕色狐狸跳过懒狗', 'Japanese': '素早い茶色の狐'},
    scTall: {'Arabic': 'الثعلب البني السريع', 'Hindi': 'तेज भूरी लोमड़ी'},
  };
  for (final entry in scSamples.entries) {
    print('  ${entry.key.name}:');
    for (final sample in entry.value.entries) {
      print('    ${sample.key}: ${sample.value}');
    }
  }

  // ──────────────────────────────────────────────
  // 13. Set operations & grouping
  // ──────────────────────────────────────────────
  print('\n[13] Set operations & grouping');
  final scStandard = {scEnglishLike};
  final scSpecial = {scDense, scTall};
  print('  Standard: ${scStandard.map((v) => v.name).join(", ")}');
  print('  Special : ${scSpecial.map((v) => v.name).join(", ")}');
  print('  All     : ${scStandard.union(scSpecial).map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 14. Theme colour palette
  // ──────────────────────────────────────────────
  print('\n[14] Theme colour palette');
  const scMagenta = Color(0xFFAD1457);
  const scFuchsia = Color(0xFFC2185B);
  const scMagentaLight = Color(0xFFFCE4EC);
  final scColors = <String, Color>{'magenta': scMagenta, 'fuchsia': scFuchsia, 'magentaLight': scMagentaLight};
  for (final entry in scColors.entries) {
    final c = entry.value;
    print('  ${entry.key}: a=${c.a.toStringAsFixed(2)}, r=${c.r.toStringAsFixed(2)}, '
        'g=${c.g.toStringAsFixed(2)}, b=${c.b.toStringAsFixed(2)}');
  }

  // ──────────────────────────────────────────────
  // 15. Locale to category mapping
  // ──────────────────────────────────────────────
  print('\n[15] Locale to category mapping');
  final scLocaleMap = <String, ScriptCategory>{
    'en': scEnglishLike,
    'de': scEnglishLike,
    'fr': scEnglishLike,
    'ru': scEnglishLike,
    'zh': scDense,
    'ja': scDense,
    'ko': scDense,
    'ar': scTall,
    'hi': scTall,
    'th': scTall,
  };
  for (final entry in scLocaleMap.entries) {
    print('  ${entry.key} -> ${entry.value.name}');
  }
  // Count per category
  final scCategoryCounts = <ScriptCategory, int>{};
  for (final cat in scLocaleMap.values) {
    scCategoryCounts[cat] = (scCategoryCounts[cat] ?? 0) + 1;
  }
  for (final entry in scCategoryCounts.entries) {
    print('  ${entry.key.name}: ${entry.value} locales');
  }

  // ──────────────────────────────────────────────
  // 16. Summary dashboard widget
  // ──────────────────────────────────────────────
  print('\n[16] Summary dashboard widget');
  print('  Building full visual demo...');
  print('=' * 60);
  print('ScriptCategory deep-demo completed');

  // -- Helper: category card --
  Widget scBuildCard(ScriptCategory cat, Color bg, IconData icon) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 6),
          Text(cat.name,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 4),
          Text(scDescMap[cat] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 9)),
        ],
      ),
    );
  }

  // -- Helper: sample text card --
  Widget scBuildSampleCard(ScriptCategory cat, Map<String, String> samples) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scMagentaLight.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scMagenta.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cat.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: scMagenta)),
          const SizedBox(height: 6),
          ...samples.entries.map((s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.key, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                    Text(s.value, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  final scCardIcons = <ScriptCategory, IconData>{
    scEnglishLike: Icons.language,
    scDense: Icons.grid_view,
    scTall: Icons.text_fields,
  };

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
            gradient: const LinearGradient(colors: [scMagenta, scFuchsia]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'ScriptCategory\nDeep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),
        const SizedBox(height: 16),

        // Enum info
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scMagentaLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: scMagenta.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enum Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: scMagenta)),
              const SizedBox(height: 8),
              Text('Total values: ${scAllValues.length}', style: const TextStyle(fontSize: 13)),
              Text('Type: ${scEnglishLike.runtimeType}', style: const TextStyle(fontSize: 13)),
              const Text('Purpose: Groups scripts by typographic characteristics', style: TextStyle(fontSize: 13)),
              const Text('Used by: Typography class for Material Design', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Category cards
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: scAllValues.map((v) {
            final cardColors = [scMagenta, scFuchsia, Color.lerp(scMagenta, Colors.black, 0.15)!];
            return scBuildCard(v, cardColors[v.index], scCardIcons[v] ?? Icons.help);
          }).toList(),
        ),
        const SizedBox(height: 14),

        // Script families
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Script Families', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...scFamilies.entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.key.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: scMagenta)),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: entry.value.map((f) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: scMagenta.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(f, style: const TextStyle(fontSize: 10)),
                              )).toList(),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Sample text
        const Text('Sample Text Per Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        ...scSamples.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: scBuildSampleCard(entry.key, entry.value),
            )),
        const SizedBox(height: 8),

        // Metrics comparison
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scMagenta.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Typography Metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...scMetrics.entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.key.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                        ...entry.value.entries.map((m) => Padding(
                              padding: const EdgeInsets.only(left: 12, top: 2),
                              child: Text('${m.key}: ${m.value}', style: const TextStyle(fontSize: 11)),
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Line height bars
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scFuchsia.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Line Height Comparison', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...scLineHeights.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        SizedBox(width: 85, child: Text(entry.key.name,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                        Expanded(
                          child: Container(
                            height: 14,
                            decoration: BoxDecoration(
                              color: scMagenta.withValues(alpha: entry.value / 2),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(entry.value.toStringAsFixed(2), style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Locale mapping
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scMagentaLight.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Locale Mapping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: scLocaleMap.entries.map((entry) {
                  final catIndex = entry.value.index;
                  final colors = [scMagenta, scFuchsia, Color.lerp(scMagenta, Colors.black, 0.15)!];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: colors[catIndex].withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: colors[catIndex].withValues(alpha: 0.3)),
                    ),
                    child: Text('${entry.key} (${entry.value.name})', style: TextStyle(fontSize: 10, color: colors[catIndex])),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Footer
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [scFuchsia, scMagenta]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'ScriptCategory  ${scAllValues.length} values  Magenta/Fuchsia',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

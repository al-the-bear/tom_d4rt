// ignore_for_file: avoid_print
// D4rt deep-demo: DynamicSchemeVariant — Copper / Bronze theme
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DynamicSchemeVariant deep-demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────
  // 1. Enum overview & catalogue
  // ──────────────────────────────────────────────
  print('\n[1] Enum overview & catalogue');
  final dsAllValues = DynamicSchemeVariant.values;
  print('  Total enum values: ${dsAllValues.length}');
  for (final v in dsAllValues) {
    print('  ${v.index}: ${v.name} (${v.runtimeType})');
  }

  const dsTonalSpot = DynamicSchemeVariant.tonalSpot;
  const dsFidelity = DynamicSchemeVariant.fidelity;
  const dsMonochrome = DynamicSchemeVariant.monochrome;
  const dsNeutral = DynamicSchemeVariant.neutral;
  const dsVibrant = DynamicSchemeVariant.vibrant;
  const dsExpressive = DynamicSchemeVariant.expressive;
  const dsContent = DynamicSchemeVariant.content;
  const dsRainbow = DynamicSchemeVariant.rainbow;
  const dsFruitSalad = DynamicSchemeVariant.fruitSalad;

  // ──────────────────────────────────────────────
  // 2. Identity & equality checks
  // ──────────────────────────────────────────────
  print('\n[2] Identity & equality checks');
  print('  tonalSpot == tonalSpot: ${dsTonalSpot == DynamicSchemeVariant.tonalSpot}');
  print('  tonalSpot == fidelity: ${dsTonalSpot == dsFidelity}');
  print('  vibrant == expressive: ${dsVibrant == dsExpressive}');
  print('  rainbow == fruitSalad: ${dsRainbow == dsFruitSalad}');
  print('  identical(tonalSpot, values[0]): ${identical(dsTonalSpot, dsAllValues[0])}');
  print('  identical(fruitSalad, values.last): ${identical(dsFruitSalad, dsAllValues.last)}');

  // ──────────────────────────────────────────────
  // 3. Index arithmetic & round-trip
  // ──────────────────────────────────────────────
  print('\n[3] Index arithmetic & round-trip');
  for (final v in dsAllValues) {
    final roundTrip = DynamicSchemeVariant.values[v.index];
    print('  ${v.name} -> index ${v.index} -> values[${v.index}] = ${roundTrip.name} (match: ${roundTrip == v})');
  }

  // ──────────────────────────────────────────────
  // 4. String ↔ enum conversion
  // ──────────────────────────────────────────────
  print('\n[4] String / enum conversion');
  final dsTestNames = ['tonalSpot', 'fidelity', 'monochrome', 'vibrant', 'rainbow', 'unknown'];
  for (final name in dsTestNames) {
    final found = dsAllValues.where((v) => v.name == name);
    print('  "$name" -> ${found.isNotEmpty ? found.first : "not found"}');
  }

  // ──────────────────────────────────────────────
  // 5. Sorting & ordering
  // ──────────────────────────────────────────────
  print('\n[5] Sorting & ordering');
  print('  Natural order: ${dsAllValues.map((v) => v.name).join(", ")}');
  final dsAlpha = List<DynamicSchemeVariant>.from(dsAllValues)..sort((a, b) => a.name.compareTo(b.name));
  print('  Alphabetical : ${dsAlpha.map((v) => v.name).join(", ")}');
  final dsRevIdx = List<DynamicSchemeVariant>.from(dsAllValues)..sort((a, b) => b.index.compareTo(a.index));
  print('  Reverse index: ${dsRevIdx.map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 6. Categorisation (chroma groups)
  // ──────────────────────────────────────────────
  print('\n[6] Categorisation (chroma groups)');
  final dsHighChroma = [dsVibrant, dsExpressive, dsRainbow, dsFruitSalad];
  final dsLowChroma = [dsMonochrome, dsNeutral];
  final dsMidChroma = [dsTonalSpot, dsFidelity, dsContent];
  print('  High chroma : ${dsHighChroma.map((v) => v.name).join(", ")}');
  print('  Mid chroma  : ${dsMidChroma.map((v) => v.name).join(", ")}');
  print('  Low chroma  : ${dsLowChroma.map((v) => v.name).join(", ")}');
  print('  Totals: ${dsHighChroma.length} + ${dsMidChroma.length} + ${dsLowChroma.length} = ${dsHighChroma.length + dsMidChroma.length + dsLowChroma.length}');

  // ──────────────────────────────────────────────
  // 7. ColorScheme generation per variant
  // ──────────────────────────────────────────────
  print('\n[7] ColorScheme generation per variant');
  const dsSeedColor = Color(0xFFB87333); // copper
  for (final variant in dsAllValues) {
    final scheme = ColorScheme.fromSeed(
      seedColor: dsSeedColor,
      dynamicSchemeVariant: variant,
    );
    print('  ${variant.name}:');
    print('    primary: #${scheme.primary.toARGB32().toRadixString(16).padLeft(8, '0')}');
    print('    secondary: #${scheme.secondary.toARGB32().toRadixString(16).padLeft(8, '0')}');
    print('    surface: #${scheme.surface.toARGB32().toRadixString(16).padLeft(8, '0')}');
  }

  // ──────────────────────────────────────────────
  // 8. Dark mode ColorScheme generation
  // ──────────────────────────────────────────────
  print('\n[8] Dark mode ColorScheme generation');
  for (final variant in [dsTonalSpot, dsVibrant, dsMonochrome]) {
    final lightScheme = ColorScheme.fromSeed(
      seedColor: dsSeedColor,
      dynamicSchemeVariant: variant,
      brightness: Brightness.light,
    );
    final darkScheme = ColorScheme.fromSeed(
      seedColor: dsSeedColor,
      dynamicSchemeVariant: variant,
      brightness: Brightness.dark,
    );
    print('  ${variant.name} light primary: #${lightScheme.primary.toARGB32().toRadixString(16).padLeft(8, '0')}');
    print('  ${variant.name} dark  primary: #${darkScheme.primary.toARGB32().toRadixString(16).padLeft(8, '0')}');
  }

  // ──────────────────────────────────────────────
  // 9. Pattern matching / switch expression
  // ──────────────────────────────────────────────
  print('\n[9] Pattern matching / switch expression');
  for (final v in dsAllValues) {
    final desc = switch (v) {
      DynamicSchemeVariant.tonalSpot => 'default balanced M3 palette',
      DynamicSchemeVariant.fidelity => 'high fidelity to seed',
      DynamicSchemeVariant.monochrome => 'grayscale, zero chroma',
      DynamicSchemeVariant.neutral => 'muted, low chroma',
      DynamicSchemeVariant.vibrant => 'saturated, high chroma',
      DynamicSchemeVariant.expressive => 'creative hue shifts',
      DynamicSchemeVariant.content => 'image-derived theming',
      DynamicSchemeVariant.rainbow => 'multi-hue spread',
      DynamicSchemeVariant.fruitSalad => 'playful colour mix',
    };
    print('  ${v.name} -> $desc');
  }

  // ──────────────────────────────────────────────
  // 10. Map-based lookup table
  // ──────────────────────────────────────────────
  print('\n[10] Map-based lookup table');
  final dsUseCaseMap = <DynamicSchemeVariant, String>{
    dsTonalSpot: 'General-purpose apps',
    dsFidelity: 'Brand-colour apps',
    dsMonochrome: 'Reading / document apps',
    dsNeutral: 'Photo gallery apps',
    dsVibrant: 'Games / entertainment',
    dsExpressive: 'Creative / art apps',
    dsContent: 'Image wallpaper theming',
    dsRainbow: 'Dashboard widgets',
    dsFruitSalad: 'Kids / playful apps',
  };
  for (final entry in dsUseCaseMap.entries) {
    print('  ${entry.key.name}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 11. Set operations on variant groups
  // ──────────────────────────────────────────────
  print('\n[11] Set operations on variant groups');
  final dsSetHigh = dsHighChroma.toSet();
  final dsSetLow = dsLowChroma.toSet();
  final dsSetAll = dsAllValues.toSet();
  print('  High chroma count: ${dsSetHigh.length}');
  print('  Low chroma count: ${dsSetLow.length}');
  print('  Mid chroma (all - high - low): ${dsSetAll.difference(dsSetHigh).difference(dsSetLow).map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 12. Multiple seed color comparison
  // ──────────────────────────────────────────────
  print('\n[12] Multiple seed color comparison');
  final dsSeedColors = <String, Color>{
    'copper': dsSeedColor,
    'blue': const Color(0xFF2962FF),
    'green': const Color(0xFF2E7D32),
  };
  for (final seedEntry in dsSeedColors.entries) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedEntry.value,
      dynamicSchemeVariant: dsTonalSpot,
    );
    print('  Seed ${seedEntry.key} -> primary: #${scheme.primary.toARGB32().toRadixString(16).padLeft(8, '0')}');
  }

  // ──────────────────────────────────────────────
  // 13. Theme integration colour palette
  // ──────────────────────────────────────────────
  print('\n[13] Theme integration colour palette');
  const dsCopper = Color(0xFFB87333);
  const dsBronze = Color(0xFFCD7F32);
  const dsBronzeLight = Color(0xFFDEB887);
  final dsThemeColors = <String, Color>{'copper': dsCopper, 'bronze': dsBronze, 'bronzeLight': dsBronzeLight};
  for (final entry in dsThemeColors.entries) {
    final c = entry.value;
    print('  ${entry.key}: a=${c.a.toStringAsFixed(2)}, r=${c.r.toStringAsFixed(2)}, g=${c.g.toStringAsFixed(2)}, b=${c.b.toStringAsFixed(2)}');
  }

  // ──────────────────────────────────────────────
  // 14. ThemeData construction per variant
  // ──────────────────────────────────────────────
  print('\n[14] ThemeData construction per variant');
  for (final variant in [dsTonalSpot, dsVibrant, dsMonochrome]) {
    final scheme = ColorScheme.fromSeed(seedColor: dsCopper, dynamicSchemeVariant: variant);
    final theme = ThemeData(colorScheme: scheme, useMaterial3: true);
    print('  ${variant.name}: brightness=${theme.brightness}, primarySwatch unavailable in M3');
    print('    appBarTheme bg: ${theme.appBarTheme.backgroundColor}');
  }

  // ──────────────────────────────────────────────
  // 15. Visual swatch grid builder
  // ──────────────────────────────────────────────
  print('\n[15] Visual swatch grid builder');
  final dsSwatchWidgets = <Widget>[];
  for (final variant in dsAllValues) {
    final scheme = ColorScheme.fromSeed(seedColor: dsCopper, dynamicSchemeVariant: variant);
    dsSwatchWidgets.add(
      Container(
        width: 90,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: scheme.outline),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(variant.name, style: TextStyle(color: scheme.onPrimary, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Container(width: 30, height: 12, decoration: BoxDecoration(color: scheme.secondary, borderRadius: BorderRadius.circular(3))),
            const SizedBox(height: 3),
            Container(width: 30, height: 12, decoration: BoxDecoration(color: scheme.tertiary, borderRadius: BorderRadius.circular(3))),
          ],
        ),
      ),
    );
    print('  Built swatch for ${variant.name}');
  }

  // ──────────────────────────────────────────────
  // 16. Summary dashboard widget
  // ──────────────────────────────────────────────
  print('\n[16] Summary dashboard widget');
  print('  Building full visual demo...');
  print('=' * 60);
  print('DynamicSchemeVariant deep-demo completed');

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
            gradient: const LinearGradient(colors: [dsCopper, dsBronze]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'DynamicSchemeVariant\nDeep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),
        const SizedBox(height: 16),

        // Enum info
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: dsBronzeLight.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: dsCopper.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enum Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: dsCopper)),
              const SizedBox(height: 8),
              Text('Total values: ${dsAllValues.length}', style: const TextStyle(fontSize: 13)),
              Text('Type: ${dsTonalSpot.runtimeType}', style: const TextStyle(fontSize: 13)),
              const Text('Default: tonalSpot', style: TextStyle(fontSize: 13)),
              const Text('Purpose: Controls M3 palette generation algorithm', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Chroma groups
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Chroma Groups', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              Text('High: ${dsHighChroma.map((v) => v.name).join(", ")}', style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              Text('Mid : ${dsMidChroma.map((v) => v.name).join(", ")}', style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              Text('Low : ${dsLowChroma.map((v) => v.name).join(", ")}', style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Swatch grid
        const Text('Color Swatches per Variant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(spacing: 0, runSpacing: 0, children: dsSwatchWidgets),
        const SizedBox(height: 14),

        // Use case table
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: dsCopper.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Recommended Use Cases', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...dsUseCaseMap.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(entry.key.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                        ),
                        Expanded(child: Text(entry.value, style: const TextStyle(fontSize: 12))),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Footer
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [dsBronze, dsCopper]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'DynamicSchemeVariant  ${dsAllValues.length} values  Copper/Bronze',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

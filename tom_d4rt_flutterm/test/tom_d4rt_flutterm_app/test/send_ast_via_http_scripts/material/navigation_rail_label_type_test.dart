// ignore_for_file: avoid_print
// D4rt deep-demo: NavigationRailLabelType — Teal / Cyan theme
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationRailLabelType deep-demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────
  // 1. Enum overview & catalogue
  // ──────────────────────────────────────────────
  print('\n[1] Enum overview & catalogue');
  final nrAllValues = NavigationRailLabelType.values;
  print('  Total enum values: ${nrAllValues.length}');
  for (final v in nrAllValues) {
    print('  ${v.index}: ${v.name} (${v.runtimeType})');
  }

  const nrNone = NavigationRailLabelType.none;
  const nrSelected = NavigationRailLabelType.selected;
  const nrAll = NavigationRailLabelType.all;

  // ──────────────────────────────────────────────
  // 2. Identity & equality checks
  // ──────────────────────────────────────────────
  print('\n[2] Identity & equality checks');
  print('  none == none: ${nrNone == NavigationRailLabelType.none}');
  print('  none == selected: ${nrNone == nrSelected}');
  print('  selected == all: ${nrSelected == nrAll}');
  print('  identical(none, values[0]): ${identical(nrNone, nrAllValues[0])}');
  print('  identical(selected, values[1]): ${identical(nrSelected, nrAllValues[1])}');
  print('  identical(all, values[2]): ${identical(nrAll, nrAllValues[2])}');

  // ──────────────────────────────────────────────
  // 3. Index arithmetic & round-trip
  // ──────────────────────────────────────────────
  print('\n[3] Index arithmetic & round-trip');
  for (final v in nrAllValues) {
    final roundTrip = NavigationRailLabelType.values[v.index];
    print('  ${v.name} -> index ${v.index} -> values[${v.index}] = ${roundTrip.name} (match: ${roundTrip == v})');
  }
  final nrMiddle = nrAllValues[nrAllValues.length ~/ 2];
  print('  Middle value: ${nrMiddle.name} at index ${nrMiddle.index}');

  // ──────────────────────────────────────────────
  // 4. String / enum conversion
  // ──────────────────────────────────────────────
  print('\n[4] String / enum conversion');
  final nrTestNames = ['none', 'selected', 'all', 'hover', 'unknown'];
  for (final name in nrTestNames) {
    final found = nrAllValues.where((v) => v.name == name);
    print('  "$name" -> ${found.isNotEmpty ? found.first : "not found"}');
  }

  // ──────────────────────────────────────────────
  // 5. Sorting & ordering
  // ──────────────────────────────────────────────
  print('\n[5] Sorting & ordering');
  print('  Natural: ${nrAllValues.map((v) => v.name).join(", ")}');
  final nrAlpha = List<NavigationRailLabelType>.from(nrAllValues)..sort((a, b) => a.name.compareTo(b.name));
  print('  Alpha  : ${nrAlpha.map((v) => v.name).join(", ")}');
  final nrRev = List<NavigationRailLabelType>.from(nrAllValues)..sort((a, b) => b.index.compareTo(a.index));
  print('  Reverse: ${nrRev.map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 6. Map-based behaviour description
  // ──────────────────────────────────────────────
  print('\n[6] Map-based behaviour description');
  final nrDescMap = <NavigationRailLabelType, String>{
    nrNone: 'No labels shown — icons only, most compact rail',
    nrSelected: 'Label appears only under the selected destination',
    nrAll: 'Labels visible under every destination always',
  };
  for (final entry in nrDescMap.entries) {
    print('  ${entry.key.name}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 7. Pattern matching / switch expression
  // ──────────────────────────────────────────────
  print('\n[7] Pattern matching / switch expression');
  for (final v in nrAllValues) {
    final desc = switch (v) {
      NavigationRailLabelType.none => 'compact, tooltip-reliant',
      NavigationRailLabelType.selected => 'balanced, moderate width',
      NavigationRailLabelType.all => 'informative, widest rail',
    };
    print('  ${v.name} -> $desc');
  }

  // ──────────────────────────────────────────────
  // 8. Simulated label visibility
  // ──────────────────────────────────────────────
  print('\n[8] Simulated label visibility');
  final nrDestNames = ['Home', 'Search', 'Library', 'Settings'];
  final nrDestIcons = [Icons.home, Icons.search, Icons.library_books, Icons.settings];
  const nrSelIdx = 1;
  for (final labelType in nrAllValues) {
    print('  labelType: ${labelType.name} (selected index: $nrSelIdx)');
    for (var i = 0; i < nrDestNames.length; i++) {
      final isSel = i == nrSelIdx;
      final showLabel = switch (labelType) {
        NavigationRailLabelType.none => false,
        NavigationRailLabelType.selected => isSel,
        NavigationRailLabelType.all => true,
      };
      print('    [$i] ${nrDestNames[i]}: selected=$isSel, label=$showLabel');
    }
  }

  // ──────────────────────────────────────────────
  // 9. NavigationRail widget per label type
  // ──────────────────────────────────────────────
  print('\n[9] NavigationRail widget per label type');
  final nrDestinations = List.generate(nrDestNames.length, (i) {
    return NavigationRailDestination(
      icon: Icon(nrDestIcons[i]),
      selectedIcon: Icon(nrDestIcons[i], color: const Color(0xFF00897B)),
      label: Text(nrDestNames[i]),
    );
  });

  final nrRails = <NavigationRailLabelType, Widget>{};
  for (final labelType in nrAllValues) {
    final rail = SizedBox(
      height: 320,
      child: NavigationRail(
        selectedIndex: nrSelIdx,
        labelType: labelType,
        destinations: nrDestinations,
        backgroundColor: const Color(0xFFE0F2F1),
      ),
    );
    nrRails[labelType] = rail;
    print('  Built NavigationRail(${labelType.name}): destinations=${nrDestNames.length}');
  }

  // ──────────────────────────────────────────────
  // 10. Comparison with NavigationDestinationLabelBehavior
  // ──────────────────────────────────────────────
  print('\n[10] Comparison with NavigationDestinationLabelBehavior');
  final nrBarValues = NavigationDestinationLabelBehavior.values;
  print('  NavigationRailLabelType: ${nrAllValues.length} values');
  print('  NavigationDestinationLabelBehavior: ${nrBarValues.length} values');
  final nrRailNames = nrAllValues.map((v) => v.name).toSet();
  final nrBarNames = nrBarValues.map((v) => v.name).toSet();
  final nrShared = nrRailNames.intersection(nrBarNames);
  print('  Shared names: ${nrShared.isEmpty ? "(none)" : nrShared.join(", ")}');
  print('  Rail-only: ${nrRailNames.difference(nrBarNames).join(", ")}');
  print('  Bar-only : ${nrBarNames.difference(nrRailNames).join(", ")}');
  // Conceptual mapping
  final nrMapping = <String, String>{
    'none -> alwaysHide': 'no labels in rail / no labels in bar',
    'selected -> onlyShowSelected': 'selected only in rail / selected only in bar',
    'all -> alwaysShow': 'all labels in rail / all labels in bar',
  };
  for (final entry in nrMapping.entries) {
    print('  ${entry.key}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 11. NavigationRailThemeData integration
  // ──────────────────────────────────────────────
  print('\n[11] NavigationRailThemeData integration');
  for (final labelType in nrAllValues) {
    final themeData = NavigationRailThemeData(labelType: labelType);
    print('  NavigationRailThemeData(${labelType.name}): labelType=${themeData.labelType}');
  }
  final nrFullTheme = ThemeData(
    navigationRailTheme: const NavigationRailThemeData(
      labelType: NavigationRailLabelType.selected,
    ),
    useMaterial3: true,
  );
  print('  ThemeData.navigationRailTheme.labelType: ${nrFullTheme.navigationRailTheme.labelType}');

  // ──────────────────────────────────────────────
  // 12. Set operations & grouping
  // ──────────────────────────────────────────────
  print('\n[12] Set operations & grouping');
  final nrShowAny = {nrSelected, nrAll};
  final nrShowNone = {nrNone};
  print('  Shows some labels: ${nrShowAny.map((v) => v.name).join(", ")}');
  print('  Shows no labels  : ${nrShowNone.map((v) => v.name).join(", ")}');
  print('  Union: ${nrShowAny.union(nrShowNone).map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 13. Accessibility scoring
  // ──────────────────────────────────────────────
  print('\n[13] Accessibility scoring');
  final nrAccessScores = <NavigationRailLabelType, int>{
    nrAll: 100,
    nrSelected: 65,
    nrNone: 25,
  };
  for (final entry in nrAccessScores.entries) {
    final bar = '*' * (entry.value ~/ 10);
    print('  ${entry.key.name}: ${entry.value}/100 $bar');
  }

  // ──────────────────────────────────────────────
  // 14. Theme integration colour palette
  // ──────────────────────────────────────────────
  print('\n[14] Theme integration colour palette');
  const nrTeal = Color(0xFF00897B);
  const nrCyan = Color(0xFF00ACC1);
  const nrTealLight = Color(0xFFB2DFDB);
  final nrColors = <String, Color>{'teal': nrTeal, 'cyan': nrCyan, 'tealLight': nrTealLight};
  for (final entry in nrColors.entries) {
    final c = entry.value;
    print('  ${entry.key}: a=${c.a.toStringAsFixed(2)}, r=${c.r.toStringAsFixed(2)}, '
        'g=${c.g.toStringAsFixed(2)}, b=${c.b.toStringAsFixed(2)}');
  }

  // ──────────────────────────────────────────────
  // 15. Width estimation per label type
  // ──────────────────────────────────────────────
  print('\n[15] Width estimation per label type');
  final nrWidthEstimates = <NavigationRailLabelType, double>{
    nrNone: 56.0,
    nrSelected: 72.0,
    nrAll: 88.0,
  };
  for (final entry in nrWidthEstimates.entries) {
    print('  ${entry.key.name}: estimated width ~${entry.value}dp');
  }
  final nrTotalWidths = nrWidthEstimates.values.reduce((a, b) => a + b);
  print('  All three side-by-side: ${nrTotalWidths}dp');

  // ──────────────────────────────────────────────
  // 16. Summary dashboard widget
  // ──────────────────────────────────────────────
  print('\n[16] Summary dashboard widget');
  print('  Building full visual demo...');
  print('=' * 60);
  print('NavigationRailLabelType deep-demo completed');

  // -- Helper: behaviour card --
  Widget nrBuildCard(NavigationRailLabelType lt, Color bg) {
    final icon = switch (lt) {
      NavigationRailLabelType.none => Icons.label_off,
      NavigationRailLabelType.selected => Icons.label_important,
      NavigationRailLabelType.all => Icons.label,
    };
    return Container(
      width: 135,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 6),
          Text(lt.name.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 4),
          Text(nrDescMap[lt] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 9)),
        ],
      ),
    );
  }

  final nrCards = <Widget>[];
  final nrCardColors = [nrTeal, nrCyan, Color.lerp(nrTeal, Colors.black, 0.15)!];
  for (var i = 0; i < nrAllValues.length; i++) {
    nrCards.add(nrBuildCard(nrAllValues[i], nrCardColors[i]));
  }

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
            gradient: const LinearGradient(colors: [nrTeal, nrCyan]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'NavigationRailLabelType\nDeep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),
        const SizedBox(height: 16),

        // Enum info
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: nrTealLight.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: nrTeal.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enum Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: nrTeal)),
              const SizedBox(height: 8),
              Text('Total values: ${nrAllValues.length}', style: const TextStyle(fontSize: 13)),
              Text('Type: ${nrNone.runtimeType}', style: const TextStyle(fontSize: 13)),
              const Text('Default: none (icons only)', style: TextStyle(fontSize: 13)),
              const Text('Purpose: Controls NavigationRail label visibility', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Behaviour cards
        Wrap(spacing: 10, runSpacing: 10, children: nrCards),
        const SizedBox(height: 14),

        // Live NavigationRails side-by-side
        const Text('Live NavigationRails', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        SizedBox(
          height: 340,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...nrAllValues.map((lt) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    children: [
                      Text(lt.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: nrTeal)),
                      const SizedBox(height: 4),
                      Expanded(child: nrRails[lt]!),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Visibility grid
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Label Visibility (selected: Search)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...nrAllValues.map((lt) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lt.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(nrDestNames.length, (i) {
                          final isSel = i == nrSelIdx;
                          final showLabel = switch (lt) {
                            NavigationRailLabelType.none => false,
                            NavigationRailLabelType.selected => isSel,
                            NavigationRailLabelType.all => true,
                          };
                          return Expanded(
                            child: Column(
                              children: [
                                Icon(nrDestIcons[i], size: 20, color: isSel ? nrTeal : Colors.grey),
                                if (showLabel)
                                  Text(nrDestNames[i],
                                      style: TextStyle(fontSize: 9, color: isSel ? nrTeal : Colors.grey)),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Accessibility
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: nrTeal.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Accessibility Score', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...nrAccessScores.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        SizedBox(width: 80, child: Text(entry.key.name,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                        Expanded(
                          child: Container(
                            height: 14,
                            decoration: BoxDecoration(
                              color: nrTeal.withValues(alpha: entry.value / 100),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('${entry.value}%', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Width estimates
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: nrCyan.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Estimated Rail Width', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...nrWidthEstimates.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        SizedBox(width: 80, child: Text(entry.key.name,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                        Expanded(
                          child: Container(
                            height: 14,
                            decoration: BoxDecoration(
                              color: nrCyan.withValues(alpha: entry.value / 100),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('~${entry.value.toStringAsFixed(0)}dp', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // NavigationBar comparison
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: nrTealLight.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('vs NavigationDestinationLabelBehavior', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 8),
              ...nrMapping.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('${entry.key}: ${entry.value}', style: const TextStyle(fontSize: 11)),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Footer
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [nrCyan, nrTeal]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'NavigationRailLabelType  ${nrAllValues.length} values  Teal/Cyan',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

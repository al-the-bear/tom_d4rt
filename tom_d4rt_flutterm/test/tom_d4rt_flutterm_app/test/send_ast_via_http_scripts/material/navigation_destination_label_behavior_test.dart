// ignore_for_file: avoid_print
// D4rt deep-demo: NavigationDestinationLabelBehavior — Lavender / Lilac theme
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationDestinationLabelBehavior deep-demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────
  // 1. Enum overview & catalogue
  // ──────────────────────────────────────────────
  print('\n[1] Enum overview & catalogue');
  final ndAllValues = NavigationDestinationLabelBehavior.values;
  print('  Total enum values: ${ndAllValues.length}');
  for (final v in ndAllValues) {
    print('  ${v.index}: ${v.name} (${v.runtimeType})');
  }

  const ndAlwaysShow = NavigationDestinationLabelBehavior.alwaysShow;
  const ndAlwaysHide = NavigationDestinationLabelBehavior.alwaysHide;
  const ndOnlySelected = NavigationDestinationLabelBehavior.onlyShowSelected;

  // ──────────────────────────────────────────────
  // 2. Identity & equality checks
  // ──────────────────────────────────────────────
  print('\n[2] Identity & equality checks');
  print('  alwaysShow == alwaysShow: ${ndAlwaysShow == NavigationDestinationLabelBehavior.alwaysShow}');
  print('  alwaysShow == alwaysHide: ${ndAlwaysShow == ndAlwaysHide}');
  print('  alwaysHide == onlyShowSelected: ${ndAlwaysHide == ndOnlySelected}');
  print('  identical(alwaysShow, values[0]): ${identical(ndAlwaysShow, ndAllValues[0])}');
  print('  identical(alwaysHide, values[1]): ${identical(ndAlwaysHide, ndAllValues[1])}');
  print('  identical(onlyShowSelected, values[2]): ${identical(ndOnlySelected, ndAllValues[2])}');

  // ──────────────────────────────────────────────
  // 3. Index arithmetic & round-trip
  // ──────────────────────────────────────────────
  print('\n[3] Index arithmetic & round-trip');
  for (final v in ndAllValues) {
    final roundTrip = NavigationDestinationLabelBehavior.values[v.index];
    print('  ${v.name} -> index ${v.index} -> values[${v.index}] = ${roundTrip.name} (match: ${roundTrip == v})');
  }
  final ndMiddle = ndAllValues[ndAllValues.length ~/ 2];
  print('  Middle value: ${ndMiddle.name} at index ${ndMiddle.index}');

  // ──────────────────────────────────────────────
  // 4. String ↔ enum conversion
  // ──────────────────────────────────────────────
  print('\n[4] String / enum conversion');
  final ndTestNames = ['alwaysShow', 'alwaysHide', 'onlyShowSelected', 'showOnHover', 'unknown'];
  for (final name in ndTestNames) {
    final found = ndAllValues.where((v) => v.name == name);
    print('  "$name" -> ${found.isNotEmpty ? found.first : "not found"}');
  }
  print('  toString() round-trips:');
  for (final v in ndAllValues) {
    print('    $v  name="${v.name}"');
  }

  // ──────────────────────────────────────────────
  // 5. Sorting & ordering
  // ──────────────────────────────────────────────
  print('\n[5] Sorting & ordering');
  print('  Natural: ${ndAllValues.map((v) => v.name).join(", ")}');
  final ndAlpha = List<NavigationDestinationLabelBehavior>.from(ndAllValues)..sort((a, b) => a.name.compareTo(b.name));
  print('  Alpha  : ${ndAlpha.map((v) => v.name).join(", ")}');
  final ndRev = List<NavigationDestinationLabelBehavior>.from(ndAllValues)..sort((a, b) => b.index.compareTo(a.index));
  print('  Reverse: ${ndRev.map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 6. Set / collection operations
  // ──────────────────────────────────────────────
  print('\n[6] Set / collection operations');
  final ndShowLabels = {ndAlwaysShow, ndOnlySelected};
  final ndHideLabels = {ndAlwaysHide};
  print('  Shows labels: ${ndShowLabels.map((v) => v.name).join(", ")}');
  print('  Hides labels: ${ndHideLabels.map((v) => v.name).join(", ")}');
  print('  Union: ${ndShowLabels.union(ndHideLabels).map((v) => v.name).join(", ")}');
  print('  Intersection: ${ndShowLabels.intersection(ndHideLabels).map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 7. Map-based behaviour description
  // ──────────────────────────────────────────────
  print('\n[7] Map-based behaviour description');
  final ndDescMap = <NavigationDestinationLabelBehavior, String>{
    ndAlwaysShow: 'Labels visible for all destinations always',
    ndAlwaysHide: 'Labels hidden for all destinations (icons only)',
    ndOnlySelected: 'Label visible only for the selected destination',
  };
  for (final entry in ndDescMap.entries) {
    print('  ${entry.key.name}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 8. Pattern matching / switch expression
  // ──────────────────────────────────────────────
  print('\n[8] Pattern matching / switch expression');
  for (final v in ndAllValues) {
    final desc = switch (v) {
      NavigationDestinationLabelBehavior.alwaysShow => 'full labels, best accessibility',
      NavigationDestinationLabelBehavior.alwaysHide => 'icons only, compact design',
      NavigationDestinationLabelBehavior.onlyShowSelected => 'selected label only, saves space',
    };
    print('  ${v.name} -> $desc');
  }

  // ──────────────────────────────────────────────
  // 9. Simulated destination visibility
  // ──────────────────────────────────────────────
  print('\n[9] Simulated destination visibility');
  final ndDestinations = ['Home', 'Search', 'Favorites', 'Profile'];
  const ndSelectedIdx = 2;
  for (final behaviour in ndAllValues) {
    print('  Behaviour: ${behaviour.name} (selected index: $ndSelectedIdx)');
    for (var i = 0; i < ndDestinations.length; i++) {
      final isSelected = i == ndSelectedIdx;
      final showLabel = switch (behaviour) {
        NavigationDestinationLabelBehavior.alwaysShow => true,
        NavigationDestinationLabelBehavior.alwaysHide => false,
        NavigationDestinationLabelBehavior.onlyShowSelected => isSelected,
      };
      print('    [$i] ${ndDestinations[i]}: selected=$isSelected, label=$showLabel');
    }
  }

  // ──────────────────────────────────────────────
  // 10. NavigationBar widget per behaviour
  // ──────────────────────────────────────────────
  print('\n[10] NavigationBar widget per behaviour');
  final ndIcons = [Icons.home, Icons.search, Icons.favorite, Icons.person];
  final ndNavBars = <NavigationDestinationLabelBehavior, Widget>{};
  for (final behaviour in ndAllValues) {
    final navBar = NavigationBar(
      selectedIndex: ndSelectedIdx,
      labelBehavior: behaviour,
      destinations: List.generate(ndDestinations.length, (i) {
        return NavigationDestination(
          icon: Icon(ndIcons[i]),
          selectedIcon: Icon(ndIcons[i], color: const Color(0xFF7E57C2)),
          label: ndDestinations[i],
        );
      }),
    );
    ndNavBars[behaviour] = navBar;
    print('  NavigationBar(${behaviour.name}): ${navBar.runtimeType}, destinations: ${ndDestinations.length}');
  }

  // ──────────────────────────────────────────────
  // 11. Comparison with NavigationRailLabelType
  // ──────────────────────────────────────────────
  print('\n[11] Comparison with NavigationRailLabelType');
  final ndRailValues = NavigationRailLabelType.values;
  print('  NavigationDestinationLabelBehavior: ${ndAllValues.length} values');
  print('  NavigationRailLabelType: ${ndRailValues.length} values');
  final ndBarNames = ndAllValues.map((v) => v.name).toSet();
  final ndRailNames = ndRailValues.map((v) => v.name).toSet();
  final ndShared = ndBarNames.intersection(ndRailNames);
  final ndBarOnly = ndBarNames.difference(ndRailNames);
  final ndRailOnly = ndRailNames.difference(ndBarNames);
  print('  Shared: ${ndShared.isEmpty ? "(none)" : ndShared.join(", ")}');
  print('  Bar-only: ${ndBarOnly.isEmpty ? "(none)" : ndBarOnly.join(", ")}');
  print('  Rail-only: ${ndRailOnly.isEmpty ? "(none)" : ndRailOnly.join(", ")}');

  // ──────────────────────────────────────────────
  // 12. NavigationBarThemeData integration
  // ──────────────────────────────────────────────
  print('\n[12] NavigationBarThemeData integration');
  for (final behaviour in ndAllValues) {
    final themeData = NavigationBarThemeData(labelBehavior: behaviour);
    print('  NavigationBarThemeData(${behaviour.name}): labelBehavior=${themeData.labelBehavior}');
  }
  final ndFullTheme = ThemeData(
    navigationBarTheme: const NavigationBarThemeData(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),
    useMaterial3: true,
  );
  print('  ThemeData.navigationBarTheme.labelBehavior: ${ndFullTheme.navigationBarTheme.labelBehavior}');

  // ──────────────────────────────────────────────
  // 13. Accessibility scoring
  // ──────────────────────────────────────────────
  print('\n[13] Accessibility scoring');
  final ndAccessScores = <NavigationDestinationLabelBehavior, int>{
    ndAlwaysShow: 100,
    ndOnlySelected: 60,
    ndAlwaysHide: 20,
  };
  for (final entry in ndAccessScores.entries) {
    final stars = entry.value ~/ 20;
    print('  ${entry.key.name}: score ${entry.value}/100 ${"*" * stars}');
  }

  // ──────────────────────────────────────────────
  // 14. Theme integration colour palette
  // ──────────────────────────────────────────────
  print('\n[14] Theme integration colour palette');
  const ndLavender = Color(0xFF7E57C2);
  const ndLilac = Color(0xFFB39DDB);
  const ndLilacLight = Color(0xFFEDE7F6);
  final ndColors = <String, Color>{'lavender': ndLavender, 'lilac': ndLilac, 'lilacLight': ndLilacLight};
  for (final entry in ndColors.entries) {
    final c = entry.value;
    print('  ${entry.key}: a=${c.a.toStringAsFixed(2)}, r=${c.r.toStringAsFixed(2)}, g=${c.g.toStringAsFixed(2)}, b=${c.b.toStringAsFixed(2)}');
  }

  // ──────────────────────────────────────────────
  // 15. Visual card builder per behaviour
  // ──────────────────────────────────────────────
  print('\n[15] Visual card builder per behaviour');
  Widget ndBuildCard(NavigationDestinationLabelBehavior b, Color bg) {
    final icon = switch (b) {
      NavigationDestinationLabelBehavior.alwaysShow => Icons.label,
      NavigationDestinationLabelBehavior.alwaysHide => Icons.label_off,
      NavigationDestinationLabelBehavior.onlyShowSelected => Icons.label_important,
    };
    return Container(
      width: 135,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 6),
          Text(b.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(height: 4),
          Text(ndDescMap[b] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 9)),
        ],
      ),
    );
  }

  final ndCards = <Widget>[];
  final ndCardColors = [ndLavender, ndLilac, Color.lerp(ndLavender, Colors.black, 0.15)!];
  for (var i = 0; i < ndAllValues.length; i++) {
    ndCards.add(ndBuildCard(ndAllValues[i], ndCardColors[i]));
    print('  Built card for ${ndAllValues[i].name}');
  }

  // ──────────────────────────────────────────────
  // 16. Summary dashboard widget
  // ──────────────────────────────────────────────
  print('\n[16] Summary dashboard widget');
  print('  Building full visual demo...');
  print('=' * 60);
  print('NavigationDestinationLabelBehavior deep-demo completed');

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
            gradient: const LinearGradient(colors: [ndLavender, ndLilac]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'NavigationDestinationLabelBehavior\nDeep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),
        const SizedBox(height: 16),

        // Enum info
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: ndLilacLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ndLavender.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enum Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: ndLavender)),
              const SizedBox(height: 8),
              Text('Total values: ${ndAllValues.length}', style: const TextStyle(fontSize: 13)),
              Text('Type: ${ndAlwaysShow.runtimeType}', style: const TextStyle(fontSize: 13)),
              const Text('Default: alwaysShow', style: TextStyle(fontSize: 13)),
              const Text('Purpose: Controls navigation label visibility', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Behaviour cards
        Wrap(spacing: 10, runSpacing: 10, children: ndCards),
        const SizedBox(height: 14),

        // Destination visibility grid
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Label Visibility (selected: Favorites)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...ndAllValues.map((b) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(b.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(ndDestinations.length, (i) {
                          final isSelected = i == ndSelectedIdx;
                          final showLabel = switch (b) {
                            NavigationDestinationLabelBehavior.alwaysShow => true,
                            NavigationDestinationLabelBehavior.alwaysHide => false,
                            NavigationDestinationLabelBehavior.onlyShowSelected => isSelected,
                          };
                          return Expanded(
                            child: Column(
                              children: [
                                Icon(ndIcons[i], size: 20, color: isSelected ? ndLavender : Colors.grey),
                                if (showLabel)
                                  Text(ndDestinations[i],
                                      style: TextStyle(fontSize: 9, color: isSelected ? ndLavender : Colors.grey)),
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

        // Live NavigationBar widgets
        const Text('Live NavigationBar Widgets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        ...ndAllValues.map((b) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ndLilac),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                    child: Text('labelBehavior: ${b.name}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: ndLavender)),
                  ),
                  ndNavBars[b]!,
                ],
              ),
            ),
          );
        }),

        // Accessibility
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: ndLavender.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Accessibility Score', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...ndAccessScores.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        SizedBox(width: 120, child: Text(entry.key.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                        Expanded(
                          child: Container(
                            height: 14,
                            decoration: BoxDecoration(
                              color: ndLavender.withValues(alpha: entry.value / 100),
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

        // Rail comparison
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: ndLilac.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('vs NavigationRailLabelType', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              Text('Shared: ${ndShared.isEmpty ? "(none)" : ndShared.join(", ")}', style: const TextStyle(fontSize: 12)),
              Text('Bar-only: ${ndBarOnly.isEmpty ? "(none)" : ndBarOnly.join(", ")}', style: const TextStyle(fontSize: 12)),
              Text('Rail-only: ${ndRailOnly.isEmpty ? "(none)" : ndRailOnly.join(", ")}', style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Footer
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [ndLilac, ndLavender]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'NavigationDestinationLabelBehavior  ${ndAllValues.length} values  Lavender/Lilac',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

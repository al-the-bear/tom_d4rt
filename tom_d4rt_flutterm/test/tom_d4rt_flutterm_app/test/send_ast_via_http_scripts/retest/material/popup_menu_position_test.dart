// ignore_for_file: avoid_print
// D4rt deep-demo: PopupMenuPosition — Amber / Honey theme
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PopupMenuPosition deep-demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────
  // 1. Enum overview & catalogue
  // ──────────────────────────────────────────────
  print('\n[1] Enum overview & catalogue');
  final pmAllValues = PopupMenuPosition.values;
  print('  Total enum values: ${pmAllValues.length}');
  for (final v in pmAllValues) {
    print('  ${v.index}: ${v.name} (${v.runtimeType})');
  }

  const pmOver = PopupMenuPosition.over;
  const pmUnder = PopupMenuPosition.under;

  // ──────────────────────────────────────────────
  // 2. Identity & equality checks
  // ──────────────────────────────────────────────
  print('\n[2] Identity & equality checks');
  print('  over == over: ${pmOver == PopupMenuPosition.over}');
  print('  over == under: ${pmOver == pmUnder}');
  print('  identical(over, values[0]): ${identical(pmOver, pmAllValues[0])}');
  print('  identical(under, values[1]): ${identical(pmUnder, pmAllValues[1])}');

  // ──────────────────────────────────────────────
  // 3. Index arithmetic & round-trip
  // ──────────────────────────────────────────────
  print('\n[3] Index arithmetic & round-trip');
  for (final v in pmAllValues) {
    final roundTrip = PopupMenuPosition.values[v.index];
    print('  ${v.name} -> index ${v.index} -> values[${v.index}] = ${roundTrip.name} (match: ${roundTrip == v})');
  }

  // ──────────────────────────────────────────────
  // 4. String / enum conversion
  // ──────────────────────────────────────────────
  print('\n[4] String / enum conversion');
  final pmTestNames = ['over', 'under', 'above', 'beside', 'left'];
  for (final name in pmTestNames) {
    final found = pmAllValues.where((v) => v.name == name);
    print('  "$name" -> ${found.isNotEmpty ? found.first : "not found"}');
  }

  // ──────────────────────────────────────────────
  // 5. Sorting & ordering
  // ──────────────────────────────────────────────
  print('\n[5] Sorting & ordering');
  print('  Natural: ${pmAllValues.map((v) => v.name).join(", ")}');
  final pmAlpha = List<PopupMenuPosition>.from(pmAllValues)..sort((a, b) => a.name.compareTo(b.name));
  print('  Alpha  : ${pmAlpha.map((v) => v.name).join(", ")}');
  final pmRev = List<PopupMenuPosition>.from(pmAllValues)..sort((a, b) => b.index.compareTo(a.index));
  print('  Reverse: ${pmRev.map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 6. Map-based behaviour description
  // ──────────────────────────────────────────────
  print('\n[6] Map-based behaviour description');
  final pmDescMap = <PopupMenuPosition, String>{
    pmOver: 'Menu overlays the trigger button, covering it from above',
    pmUnder: 'Menu appears below the trigger button, preserving context',
  };
  for (final entry in pmDescMap.entries) {
    print('  ${entry.key.name}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 7. Pattern matching / switch expression
  // ──────────────────────────────────────────────
  print('\n[7] Pattern matching / switch expression');
  for (final v in pmAllValues) {
    final desc = switch (v) {
      PopupMenuPosition.over => 'classic overlay — item selection replaces button',
      PopupMenuPosition.under => 'context-preserving — button remains visible',
      _ => 'unknown', // D4RT-LIMITATION: enum exhaustiveness
    };
    print('  ${v.name} -> $desc');
  }

  // ──────────────────────────────────────────────
  // 8. Simulated placement geometry
  // ──────────────────────────────────────────────
  print('\n[8] Simulated placement geometry');
  const pmBtnTop = 200.0;
  const pmBtnHeight = 48.0;
  const pmMenuHeight = 180.0;
  for (final pos in pmAllValues) {
    final menuTop = switch (pos) {
      PopupMenuPosition.over => pmBtnTop,
      PopupMenuPosition.under => pmBtnTop + pmBtnHeight,
      _ => pmBtnTop, // D4RT-LIMITATION: enum exhaustiveness
    };
    print('  ${pos.name}: button@y=$pmBtnTop h=$pmBtnHeight -> menu@y=$menuTop h=$pmMenuHeight');
    final overlap = pos == pmOver;
    print('    Overlaps button: $overlap');
  }

  // ──────────────────────────────────────────────
  // 9. PopupMenuButton widgets per position
  // ──────────────────────────────────────────────
  print('\n[9] PopupMenuButton widgets per position');
  final pmMenuItems = ['Copy', 'Paste', 'Cut', 'Select All', 'Share'];

  Widget pmBuildButton(PopupMenuPosition pos, String label, IconData icon) {
    return PopupMenuButton<String>(
      position: pos,
      icon: Icon(icon, color: const Color(0xFFFF8F00)),
      tooltip: '$label (${pos.name})',
      itemBuilder: (ctx) => pmMenuItems.map((item) {
        return PopupMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      onSelected: (val) => print('  Selected: $val from $label'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFFFB300)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: const Color(0xFFFF8F00)),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  final pmOverBtn = pmBuildButton(pmOver, 'Position: over', Icons.arrow_upward);
  final pmUnderBtn = pmBuildButton(pmUnder, 'Position: under', Icons.arrow_downward);
  print('  Built PopupMenuButton(over): items=${pmMenuItems.length}');
  print('  Built PopupMenuButton(under): items=${pmMenuItems.length}');

  // ──────────────────────────────────────────────
  // 10. PopupMenuThemeData integration
  // ──────────────────────────────────────────────
  print('\n[10] PopupMenuThemeData integration');
  for (final pos in pmAllValues) {
    final themeData = PopupMenuThemeData(position: pos);
    print('  PopupMenuThemeData(${pos.name}): position=${themeData.position}');
  }
  final pmFullTheme = ThemeData(
    popupMenuTheme: const PopupMenuThemeData(
      position: PopupMenuPosition.under,
      color: Color(0xFFFFF8E1),
    ),
    useMaterial3: true,
  );
  print('  ThemeData.popupMenuTheme.position: ${pmFullTheme.popupMenuTheme.position}');

  // ──────────────────────────────────────────────
  // 11. Use-case scenarios
  // ──────────────────────────────────────────────
  print('\n[11] Use-case scenarios');
  final pmUseCases = <PopupMenuPosition, List<String>>{
    pmOver: ['Main menu buttons', 'Dropdown selectors', 'Toolbar menus'],
    pmUnder: ['Context menus', 'Action buttons in cards', 'FAB menus'],
  };
  for (final entry in pmUseCases.entries) {
    print('  ${entry.key.name}:');
    for (final use in entry.value) {
      print('    - $use');
    }
  }

  // ──────────────────────────────────────────────
  // 12. Set operations & grouping
  // ──────────────────────────────────────────────
  print('\n[12] Set operations & grouping');
  final pmOverlap = {pmOver};
  final pmNoOverlap = {pmUnder};
  print('  Overlapping: ${pmOverlap.map((v) => v.name).join(", ")}');
  print('  Non-overlap : ${pmNoOverlap.map((v) => v.name).join(", ")}');
  print('  All: ${pmOverlap.union(pmNoOverlap).map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 13. Interaction simulation
  // ──────────────────────────────────────────────
  print('\n[13] Interaction simulation');
  for (final pos in pmAllValues) {
    print('  Scenario: user taps button with position=${pos.name}');
    final steps = switch (pos) {
      PopupMenuPosition.over => ['Menu appears at button top', 'Button obscured by menu', 'Tap item to dismiss'],
      PopupMenuPosition.under => ['Menu appears below button', 'Button stays visible above', 'Tap item to dismiss'],
      _ => ['Unknown position'], // D4RT-LIMITATION: enum exhaustiveness
    };
    for (var i = 0; i < steps.length; i++) {
      print('    Step ${i + 1}: ${steps[i]}');
    }
  }

  // ──────────────────────────────────────────────
  // 14. Theme colour palette
  // ──────────────────────────────────────────────
  print('\n[14] Theme colour palette');
  const pmAmber = Color(0xFFFF8F00);
  const pmHoney = Color(0xFFFFB300);
  const pmAmberLight = Color(0xFFFFF8E1);
  final pmColors = <String, Color>{'amber': pmAmber, 'honey': pmHoney, 'amberLight': pmAmberLight};
  for (final entry in pmColors.entries) {
    final c = entry.value;
    print('  ${entry.key}: a=${c.a.toStringAsFixed(2)}, r=${c.r.toStringAsFixed(2)}, '
        'g=${c.g.toStringAsFixed(2)}, b=${c.b.toStringAsFixed(2)}');
  }

  // ──────────────────────────────────────────────
  // 15. Visual offset diagrams
  // ──────────────────────────────────────────────
  print('\n[15] Visual offset diagrams');
  final pmOffsets = <PopupMenuPosition, Offset>{
    pmOver: Offset.zero,
    pmUnder: const Offset(0, pmBtnHeight),
  };
  for (final entry in pmOffsets.entries) {
    print('  ${entry.key.name}: offset=(${entry.value.dx}, ${entry.value.dy})');
  }

  // ──────────────────────────────────────────────
  // 16. Summary dashboard widget
  // ──────────────────────────────────────────────
  print('\n[16] Summary dashboard widget');
  print('  Building full visual demo...');
  print('=' * 60);
  print('PopupMenuPosition deep-demo completed');

  // -- Helper: placement diagram --
  Widget pmDiagram(PopupMenuPosition pos) {
    final isOver = pos == pmOver;
    return Container(
      width: 180,
      height: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: pmAmberLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: pmHoney),
      ),
      child: Stack(
        children: [
          // Button representation
          Positioned(
            top: isOver ? 80 : 40,
            left: 30,
            child: Container(
              width: 120,
              height: 36,
              decoration: BoxDecoration(
                color: pmAmber,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: const Text('Button', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ),
          // Menu representation
          Positioned(
            top: isOver ? 60 : 80,
            left: 30,
            child: Container(
              width: 120,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: pmHoney),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 6)],
              ),
              child: Column(
                children: pmMenuItems.take(3).map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(item, style: const TextStyle(fontSize: 10)),
                )).toList(),
              ),
            ),
          ),
          // Label
          Positioned(
            bottom: 2,
            left: 0,
            right: 0,
            child: Text(pos.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color.lerp(pmAmber, Colors.black, 0.2))),
          ),
        ],
      ),
    );
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
            gradient: LinearGradient(colors: [pmAmber, pmHoney]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'PopupMenuPosition\nDeep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),
        const SizedBox(height: 16),

        // Enum info
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: pmAmberLight.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: pmAmber.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enum Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color.lerp(pmAmber, Colors.black, 0.15))),
              const SizedBox(height: 8),
              Text('Total values: ${pmAllValues.length}', style: const TextStyle(fontSize: 13)),
              Text('Type: ${pmOver.runtimeType}', style: const TextStyle(fontSize: 13)),
              const Text('Default: over (Material Design classic)', style: TextStyle(fontSize: 13)),
              const Text('Purpose: Controls popup menu placement relative to trigger', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Behaviour cards
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: pmAllValues.map((v) {
            final icon = v == pmOver ? Icons.vertical_align_top : Icons.vertical_align_bottom;
            return Container(
              width: 165,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: v == pmOver ? pmAmber : pmHoney,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.white, size: 28),
                  const SizedBox(height: 6),
                  Text(v.name.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(pmDescMap[v] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70, fontSize: 10)),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),

        // Placement diagrams
        const Text('Placement Diagrams', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: pmAllValues.map((v) => pmDiagram(v)).toList(),
        ),
        const SizedBox(height: 14),

        // Live popup buttons
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Live PopupMenuButtons', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(spacing: 14, runSpacing: 10, children: [pmOverBtn, pmUnderBtn]),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Geometry table
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: pmAmber.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Placement Geometry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...pmAllValues.map((pos) {
                final menuTop = switch (pos) {
                  PopupMenuPosition.over => pmBtnTop,
                  PopupMenuPosition.under => pmBtnTop + pmBtnHeight,
                  _ => pmBtnTop, // D4RT-LIMITATION: enum exhaustiveness
                };
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(width: 70, child: Text(pos.name,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                      Expanded(
                        child: Text('button@y=${pmBtnTop.toStringAsFixed(0)} -> menu@y=${menuTop.toStringAsFixed(0)}',
                            style: const TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Use cases
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: pmHoney.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Use-Case Scenarios', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...pmUseCases.entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.key.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color.lerp(pmAmber, Colors.black, 0.15))),
                        ...entry.value.map((use) => Padding(
                              padding: const EdgeInsets.only(left: 12, top: 2),
                              child: Text('• $use', style: const TextStyle(fontSize: 11)),
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Interaction flow
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: pmAmberLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Interaction Flow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...pmAllValues.map((pos) {
                final steps = switch (pos) {
                  PopupMenuPosition.over => ['Menu at button top', 'Button obscured', 'Tap to dismiss'],
                  PopupMenuPosition.under => ['Menu below button', 'Button visible', 'Tap to dismiss'],
                  _ => ['Unknown'], // D4RT-LIMITATION: enum exhaustiveness
                };
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pos.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                      ...steps.asMap().entries.map((s) => Padding(
                            padding: const EdgeInsets.only(left: 12, top: 2),
                            child: Text('${s.key + 1}. ${s.value}', style: const TextStyle(fontSize: 11)),
                          )),
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
            gradient: LinearGradient(colors: [pmHoney, pmAmber]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'PopupMenuPosition  ${pmAllValues.length} values  Amber/Honey',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

// ignore_for_file: avoid_print
// D4rt deep-demo: DropdownMenuCloseBehavior — Indigo / Periwinkle theme
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DropdownMenuCloseBehavior deep-demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────
  // 1. Enum overview & catalogue
  // ──────────────────────────────────────────────
  print('\n[1] Enum overview & catalogue');
  final dmAllValues = DropdownMenuCloseBehavior.values;
  print('  Total enum values: ${dmAllValues.length}');
  for (final v in dmAllValues) {
    print('  ${v.index}: ${v.name} (${v.runtimeType})');
  }

  const dmAll = DropdownMenuCloseBehavior.all;
  const dmSelf = DropdownMenuCloseBehavior.self;
  const dmNone = DropdownMenuCloseBehavior.none;

  // ──────────────────────────────────────────────
  // 2. Identity & equality checks
  // ──────────────────────────────────────────────
  print('\n[2] Identity & equality checks');
  print('  all == all: ${dmAll == DropdownMenuCloseBehavior.all}');
  print('  all == self: ${dmAll == dmSelf}');
  print('  all == none: ${dmAll == dmNone}');
  print('  self == none: ${dmSelf == dmNone}');
  print('  identical(all, values[0]): ${identical(dmAll, dmAllValues[0])}');
  print('  identical(self, values[1]): ${identical(dmSelf, dmAllValues[1])}');
  print('  identical(none, values[2]): ${identical(dmNone, dmAllValues[2])}');

  // ──────────────────────────────────────────────
  // 3. Index arithmetic & round-trip
  // ──────────────────────────────────────────────
  print('\n[3] Index arithmetic & round-trip');
  for (final v in dmAllValues) {
    final roundTrip = DropdownMenuCloseBehavior.values[v.index];
    print('  ${v.name} -> index ${v.index} -> values[${v.index}] = ${roundTrip.name} (match: ${roundTrip == v})');
  }
  final dmMiddle = DropdownMenuCloseBehavior.values[dmAllValues.length ~/ 2];
  print('  Middle value: ${dmMiddle.name} at index ${dmMiddle.index}');

  // ──────────────────────────────────────────────
  // 4. String ↔ enum conversion
  // ──────────────────────────────────────────────
  print('\n[4] String / enum conversion');
  final dmNames = ['all', 'self', 'none'];
  for (final name in dmNames) {
    final found = dmAllValues.where((v) => v.name == name);
    print('  "$name" -> ${found.isNotEmpty ? found.first : "not found"}');
  }
  print('  toString() examples:');
  for (final v in dmAllValues) {
    print('    $v  name="${v.name}"');
  }

  // ──────────────────────────────────────────────
  // 5. Sorting & ordering
  // ──────────────────────────────────────────────
  print('\n[5] Sorting & ordering');
  final dmReversed = List<DropdownMenuCloseBehavior>.from(dmAllValues)..sort((a, b) => b.index.compareTo(a.index));
  print('  Natural order : ${dmAllValues.map((v) => v.name).join(", ")}');
  print('  Reversed order: ${dmReversed.map((v) => v.name).join(", ")}');
  final dmAlpha = List<DropdownMenuCloseBehavior>.from(dmAllValues)..sort((a, b) => a.name.compareTo(b.name));
  print('  Alphabetical  : ${dmAlpha.map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 6. Set / collection operations
  // ──────────────────────────────────────────────
  print('\n[6] Set / collection operations');
  final dmSetA = {dmAll, dmSelf};
  final dmSetB = {dmSelf, dmNone};
  print('  Set A: ${dmSetA.map((v) => v.name).join(", ")}');
  print('  Set B: ${dmSetB.map((v) => v.name).join(", ")}');
  print('  Union: ${dmSetA.union(dmSetB).map((v) => v.name).join(", ")}');
  print('  Intersection: ${dmSetA.intersection(dmSetB).map((v) => v.name).join(", ")}');
  print('  A - B: ${dmSetA.difference(dmSetB).map((v) => v.name).join(", ")}');
  print('  B - A: ${dmSetB.difference(dmSetA).map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 7. Map-based behaviour lookup
  // ──────────────────────────────────────────────
  print('\n[7] Map-based behaviour lookup');
  final dmBehaviourMap = <DropdownMenuCloseBehavior, String>{
    dmAll: 'Closes every open menu in the hierarchy',
    dmSelf: 'Closes only the triggered sub-menu',
    dmNone: 'Keeps all menus open (multi-select)',
  };
  for (final entry in dmBehaviourMap.entries) {
    print('  ${entry.key.name}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 8. Simulated menu-close scenario
  // ──────────────────────────────────────────────
  print('\n[8] Simulated menu-close scenario');
  final dmMenuStack = ['RootMenu', 'SubMenu', 'ItemMenu'];
  for (final behaviour in dmAllValues) {
    final closedMenus = <String>[];
    switch (behaviour) {
      case DropdownMenuCloseBehavior.all:
        closedMenus.addAll(dmMenuStack);
      case DropdownMenuCloseBehavior.self:
        closedMenus.add(dmMenuStack.last);
      case DropdownMenuCloseBehavior.none:
        break;
    }
    print('  Behaviour ${behaviour.name}:');
    print('    Stack: ${dmMenuStack.join(" > ")}');
    print('    Closed: ${closedMenus.isEmpty ? "(none)" : closedMenus.join(", ")}');
    print('    Remaining: ${dmMenuStack.where((m) => !closedMenus.contains(m)).join(", ").padRight(1)}');
  }

  // ──────────────────────────────────────────────
  // 9. Pattern matching / switch expression
  // ──────────────────────────────────────────────
  print('\n[9] Pattern matching / switch expression');
  for (final v in dmAllValues) {
    final desc = switch (v) {
      DropdownMenuCloseBehavior.all => 'dismiss full cascade',
      DropdownMenuCloseBehavior.self => 'dismiss current only',
      DropdownMenuCloseBehavior.none => 'keep open for multi-select',
    };
    print('  ${v.name} -> $desc');
  }

  // ──────────────────────────────────────────────
  // 10. Multi-select simulation with .none
  // ──────────────────────────────────────────────
  print('\n[10] Multi-select simulation with .none');
  final dmSelectedItems = <String>{};
  final dmMenuItems = ['Pizza', 'Burger', 'Sushi', 'Pasta', 'Salad'];
  final dmBehaviour = dmNone;
  for (final item in dmMenuItems) {
    dmSelectedItems.add(item);
    final menuStillOpen = dmBehaviour == DropdownMenuCloseBehavior.none;
    print('  Selected "$item"  menu open: $menuStillOpen, selected: ${dmSelectedItems.length}');
  }
  print('  Final selection: ${dmSelectedItems.join(", ")}');

  // ──────────────────────────────────────────────
  // 11. Real DropdownMenu widget construction
  // ──────────────────────────────────────────────
  print('\n[11] Real DropdownMenu widget construction');
  final dmEntries = <DropdownMenuEntry<String>>[
    const DropdownMenuEntry(value: 'apple', label: 'Apple'),
    const DropdownMenuEntry(value: 'banana', label: 'Banana'),
    const DropdownMenuEntry(value: 'cherry', label: 'Cherry'),
    const DropdownMenuEntry(value: 'date', label: 'Date'),
    const DropdownMenuEntry(value: 'elderberry', label: 'Elderberry'),
  ];
  for (final behaviour in dmAllValues) {
    final widget = DropdownMenu<String>(
      dropdownMenuEntries: dmEntries,
      initialSelection: 'apple',
      label: const Text('Fruit'),
      width: 200,
      closeBehavior: behaviour,
    );
    print('  DropdownMenu with behaviour=${behaviour.name}: ${widget.runtimeType}');
    print('    entries: ${dmEntries.length}, initial: apple, width: 200');
  }

  // ──────────────────────────────────────────────
  // 12. Edge cases and boundary values
  // ──────────────────────────────────────────────
  print('\n[12] Edge cases and boundary values');
  print('  First value: ${dmAllValues.first.name} (index ${dmAllValues.first.index})');
  print('  Last value: ${dmAllValues.last.name} (index ${dmAllValues.last.index})');
  print('  values.length: ${dmAllValues.length}');
  final dmCycle = dmAllValues[(dmAllValues.last.index + 1) % dmAllValues.length];
  print('  Cycle wrap (last+1): ${dmCycle.name} (index ${dmCycle.index})');
  print('  Contains check "all": ${dmAllValues.any((v) => v.name == "all")}');
  print('  Contains check "xyz": ${dmAllValues.any((v) => v.name == "xyz")}');

  // ──────────────────────────────────────────────
  // 13. Theme integration colour palette
  // ──────────────────────────────────────────────
  print('\n[13] Theme integration colour palette');
  const dmIndigo = Color(0xFF3949AB);
  const dmPeriwinkle = Color(0xFF7986CB);
  const dmIndigoLight = Color(0xFFC5CAE9);
  final dmColors = <String, Color>{
    'indigo': dmIndigo,
    'periwinkle': dmPeriwinkle,
    'indigoLight': dmIndigoLight,
  };
  for (final entry in dmColors.entries) {
    final c = entry.value;
    print('  ${entry.key}: alpha=${c.a.toStringAsFixed(2)}, '
        'r=${c.r.toStringAsFixed(2)}, g=${c.g.toStringAsFixed(2)}, b=${c.b.toStringAsFixed(2)}');
  }

  // ──────────────────────────────────────────────
  // 14. Conditional widget builder per behaviour
  // ──────────────────────────────────────────────
  print('\n[14] Conditional widget builder per behaviour');
  Widget dmBuildCard(DropdownMenuCloseBehavior b, Color bg) {
    final icon = switch (b) {
      DropdownMenuCloseBehavior.all => Icons.close_fullscreen,
      DropdownMenuCloseBehavior.self => Icons.close,
      DropdownMenuCloseBehavior.none => Icons.check_box_outline_blank,
    };
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 6),
          Text(
            b.name.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            dmBehaviourMap[b] ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }

  final dmCards = <Widget>[];
  final dmCardColors = [dmIndigo, dmPeriwinkle, const Color(0xFF5C6BC0)];
  for (var i = 0; i < dmAllValues.length; i++) {
    dmCards.add(dmBuildCard(dmAllValues[i], dmCardColors[i]));
    print('  Built card for ${dmAllValues[i].name} with colour ${dmCardColors[i]}');
  }

  // ──────────────────────────────────────────────
  // 15. Animated icon mapping
  // ──────────────────────────────────────────────
  print('\n[15] Animated icon mapping');
  final dmAnimIcons = <DropdownMenuCloseBehavior, IconData>{
    dmAll: Icons.layers_clear,
    dmSelf: Icons.flip_to_back,
    dmNone: Icons.layers,
  };
  for (final entry in dmAnimIcons.entries) {
    print('  ${entry.key.name}  icon codePoint: 0x${entry.value.codePoint.toRadixString(16)}');
  }

  // ──────────────────────────────────────────────
  // 16. Summary dashboard widget
  // ──────────────────────────────────────────────
  print('\n[16] Summary dashboard widget');
  print('  Building full visual demo...');
  print('=' * 60);
  print('DropdownMenuCloseBehavior deep-demo completed');

  // -- Visual UI --
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [dmIndigo, dmPeriwinkle]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'DropdownMenuCloseBehavior\nDeep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),
        const SizedBox(height: 16),

        // Enum info card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: dmIndigoLight.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: dmIndigo.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enum Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: dmIndigo)),
              const SizedBox(height: 8),
              Text('Total values: ${dmAllValues.length}', style: const TextStyle(fontSize: 13)),
              Text('Type: ${dmAll.runtimeType}', style: const TextStyle(fontSize: 13)),
              const Text('Default: all (closes entire hierarchy)', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Behaviour cards row
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: dmCards,
        ),
        const SizedBox(height: 14),

        // Menu simulation section
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Menu Stack Simulation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...dmAllValues.map((b) {
                final closed = switch (b) {
                  DropdownMenuCloseBehavior.all => 'All 3 menus close',
                  DropdownMenuCloseBehavior.self => 'Only ItemMenu closes',
                  DropdownMenuCloseBehavior.none => 'Nothing closes',
                };
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 10, height: 10,
                        decoration: BoxDecoration(color: dmIndigo, borderRadius: BorderRadius.circular(5)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text('${b.name}: $closed', style: const TextStyle(fontSize: 12))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // DropdownMenu widgets with each behaviour
        ...dmAllValues.map((b) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: dmPeriwinkle),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('closeBehavior: ${b.name}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: dmIndigo)),
                  const SizedBox(height: 8),
                  DropdownMenu<String>(
                    dropdownMenuEntries: dmEntries,
                    initialSelection: 'apple',
                    label: Text('Fruit (${b.name})'),
                    width: 240,
                    closeBehavior: b,
                  ),
                ],
              ),
            ),
          );
        }),

        // Multi-select results
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: dmIndigo.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Multi-Select (behaviour: none)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 6),
              ...dmSelectedItems.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, size: 16, color: dmIndigo),
                        const SizedBox(width: 8),
                        Text(item, style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Icon mapping
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: dmPeriwinkle.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Icon Mapping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...dmAnimIcons.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(entry.value, size: 22, color: dmIndigo),
                        const SizedBox(width: 10),
                        Text(entry.key.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
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
            gradient: const LinearGradient(colors: [dmPeriwinkle, dmIndigo]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'DropdownMenuCloseBehavior  ${dmAllValues.length} values  Indigo/Periwinkle',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

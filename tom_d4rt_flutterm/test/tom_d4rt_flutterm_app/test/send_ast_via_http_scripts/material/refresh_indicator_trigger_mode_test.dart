// ignore_for_file: avoid_print
// D4rt deep-demo: RefreshIndicatorTriggerMode — Marine / Navy theme
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RefreshIndicatorTriggerMode deep-demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────
  // 1. Enum overview & catalogue
  // ──────────────────────────────────────────────
  print('\n[1] Enum overview & catalogue');
  final rtAllValues = RefreshIndicatorTriggerMode.values;
  print('  Total enum values: ${rtAllValues.length}');
  for (final v in rtAllValues) {
    print('  ${v.index}: ${v.name} (${v.runtimeType})');
  }

  const rtAnywhere = RefreshIndicatorTriggerMode.anywhere;
  const rtOnEdge = RefreshIndicatorTriggerMode.onEdge;

  // ──────────────────────────────────────────────
  // 2. Identity & equality checks
  // ──────────────────────────────────────────────
  print('\n[2] Identity & equality checks');
  print('  anywhere == anywhere: ${rtAnywhere == RefreshIndicatorTriggerMode.anywhere}');
  print('  anywhere == onEdge: ${rtAnywhere == rtOnEdge}');
  print('  identical(anywhere, values[0]): ${identical(rtAnywhere, rtAllValues[0])}');
  print('  identical(onEdge, values[1]): ${identical(rtOnEdge, rtAllValues[1])}');

  // ──────────────────────────────────────────────
  // 3. Index arithmetic & round-trip
  // ──────────────────────────────────────────────
  print('\n[3] Index arithmetic & round-trip');
  for (final v in rtAllValues) {
    final roundTrip = RefreshIndicatorTriggerMode.values[v.index];
    print('  ${v.name} -> index ${v.index} -> values[${v.index}] = ${roundTrip.name} (match: ${roundTrip == v})');
  }

  // ──────────────────────────────────────────────
  // 4. String / enum conversion
  // ──────────────────────────────────────────────
  print('\n[4] String / enum conversion');
  final rtTestNames = ['anywhere', 'onEdge', 'atTop', 'always', 'never'];
  for (final name in rtTestNames) {
    final found = rtAllValues.where((v) => v.name == name);
    print('  "$name" -> ${found.isNotEmpty ? found.first : "not found"}');
  }

  // ──────────────────────────────────────────────
  // 5. Sorting & ordering
  // ──────────────────────────────────────────────
  print('\n[5] Sorting & ordering');
  print('  Natural: ${rtAllValues.map((v) => v.name).join(", ")}');
  final rtAlpha = List<RefreshIndicatorTriggerMode>.from(rtAllValues)..sort((a, b) => a.name.compareTo(b.name));
  print('  Alpha  : ${rtAlpha.map((v) => v.name).join(", ")}');
  final rtRev = List<RefreshIndicatorTriggerMode>.from(rtAllValues)..sort((a, b) => b.index.compareTo(a.index));
  print('  Reverse: ${rtRev.map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 6. Map-based behaviour description
  // ──────────────────────────────────────────────
  print('\n[6] Map-based behaviour description');
  final rtDescMap = <RefreshIndicatorTriggerMode, String>{
    rtAnywhere: 'Pull-to-refresh activates from any scroll position in the list',
    rtOnEdge: 'Pull-to-refresh only activates when scrolled to the top edge',
  };
  for (final entry in rtDescMap.entries) {
    print('  ${entry.key.name}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 7. Pattern matching / switch expression
  // ──────────────────────────────────────────────
  print('\n[7] Pattern matching / switch expression');
  for (final v in rtAllValues) {
    final desc = switch (v) {
      RefreshIndicatorTriggerMode.anywhere => 'flexible — may trigger mid-scroll',
      RefreshIndicatorTriggerMode.onEdge => 'precise — only at scroll boundary',
    };
    print('  ${v.name} -> $desc');
  }

  // ──────────────────────────────────────────────
  // 8. Scroll position simulation
  // ──────────────────────────────────────────────
  print('\n[8] Scroll position simulation');
  final rtScrollPositions = [0.0, 50.0, 150.0, 300.0, 500.0];
  for (final mode in rtAllValues) {
    print('  triggerMode: ${mode.name}');
    for (final pos in rtScrollPositions) {
      final canTrigger = switch (mode) {
        RefreshIndicatorTriggerMode.anywhere => true,
        RefreshIndicatorTriggerMode.onEdge => pos <= 0.0,
      };
      print('    scrollOffset=$pos -> canTrigger=$canTrigger');
    }
  }

  // ──────────────────────────────────────────────
  // 9. Live RefreshIndicator widgets
  // ──────────────────────────────────────────────
  print('\n[9] Live RefreshIndicator widgets');
  final rtListItems = List.generate(15, (i) => 'Item ${i + 1}');

  Widget rtBuildIndicator(RefreshIndicatorTriggerMode mode, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 200,
          child: RefreshIndicator(
            triggerMode: mode,
            color: const Color(0xFF1565C0),
            backgroundColor: const Color(0xFFE3F2FD),
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.builder(
              itemCount: rtListItems.length,
              itemBuilder: (ctx, i) => ListTile(
                dense: true,
                leading: CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFF1565C0).withValues(alpha: 0.12),
                  child: Text('${i + 1}', style: const TextStyle(fontSize: 10, color: Color(0xFF0D47A1))),
                ),
                title: Text(rtListItems[i], style: const TextStyle(fontSize: 12)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  final rtAnywhereWidget = rtBuildIndicator(rtAnywhere, 'anywhere — pull from any position');
  final rtOnEdgeWidget = rtBuildIndicator(rtOnEdge, 'onEdge — pull only at top');
  print('  Built RefreshIndicator(anywhere): items=${rtListItems.length}');
  print('  Built RefreshIndicator(onEdge): items=${rtListItems.length}');

  // ──────────────────────────────────────────────
  // 10. Use-case scenarios
  // ──────────────────────────────────────────────
  print('\n[10] Use-case scenarios');
  final rtUseCases = <RefreshIndicatorTriggerMode, List<String>>{
    rtAnywhere: [
      'Chat apps (refresh from mid-conversation)',
      'Social feeds (refresh without scrolling back)',
      'Custom gesture-heavy UIs',
    ],
    rtOnEdge: [
      'Standard list views',
      'Email-style inboxes',
      'News feeds',
      'Content that scrolls naturally',
    ],
  };
  for (final entry in rtUseCases.entries) {
    print('  ${entry.key.name}:');
    for (final use in entry.value) {
      print('    - $use');
    }
  }

  // ──────────────────────────────────────────────
  // 11. Conflict analysis
  // ──────────────────────────────────────────────
  print('\n[11] Conflict analysis');
  final rtConflicts = <RefreshIndicatorTriggerMode, List<String>>{
    rtAnywhere: [
      'May interfere with normal scrolling gestures',
      'Can accidentally trigger during fast scrolling',
      'Consider adding scroll lock threshold',
    ],
    rtOnEdge: [
      'No scroll conflicts — only triggers at boundary',
      'May frustrate users who expect mid-pull refresh',
      'Works best with natural scroll-to-top behaviour',
    ],
  };
  for (final entry in rtConflicts.entries) {
    print('  ${entry.key.name}:');
    for (final note in entry.value) {
      print('    - $note');
    }
  }

  // ──────────────────────────────────────────────
  // 12. Set operations & grouping
  // ──────────────────────────────────────────────
  print('\n[12] Set operations & grouping');
  final rtFlexible = {rtAnywhere};
  final rtStrict = {rtOnEdge};
  print('  Flexible: ${rtFlexible.map((v) => v.name).join(", ")}');
  print('  Strict  : ${rtStrict.map((v) => v.name).join(", ")}');
  print('  All: ${rtFlexible.union(rtStrict).map((v) => v.name).join(", ")}');
  print('  Default: onEdge');

  // ──────────────────────────────────────────────
  // 13. Performance notes
  // ──────────────────────────────────────────────
  print('\n[13] Performance notes');
  final rtPerfNotes = <RefreshIndicatorTriggerMode, String>{
    rtAnywhere: 'Higher gesture detection overhead — monitors all scroll events',
    rtOnEdge: 'Lower overhead — only checks boundary conditions',
  };
  for (final entry in rtPerfNotes.entries) {
    print('  ${entry.key.name}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 14. Theme colour palette
  // ──────────────────────────────────────────────
  print('\n[14] Theme colour palette');
  const rtMarine = Color(0xFF1565C0);
  const rtNavy = Color(0xFF0D47A1);
  const rtMarineLight = Color(0xFFE3F2FD);
  final rtColors = <String, Color>{'marine': rtMarine, 'navy': rtNavy, 'marineLight': rtMarineLight};
  for (final entry in rtColors.entries) {
    final c = entry.value;
    print('  ${entry.key}: a=${c.a.toStringAsFixed(2)}, r=${c.r.toStringAsFixed(2)}, '
        'g=${c.g.toStringAsFixed(2)}, b=${c.b.toStringAsFixed(2)}');
  }

  // ──────────────────────────────────────────────
  // 15. Trigger zone visualization
  // ──────────────────────────────────────────────
  print('\n[15] Trigger zone visualization');
  const rtTotalHeight = 800.0;
  for (final mode in rtAllValues) {
    final zone = switch (mode) {
      RefreshIndicatorTriggerMode.anywhere => 'entire scrollable (0-${rtTotalHeight.toStringAsFixed(0)}px)',
      RefreshIndicatorTriggerMode.onEdge => 'top edge only (0px)',
    };
    print('  ${mode.name}: $zone');
  }

  // ──────────────────────────────────────────────
  // 16. Summary dashboard widget
  // ──────────────────────────────────────────────
  print('\n[16] Summary dashboard widget');
  print('  Building full visual demo...');
  print('=' * 60);
  print('RefreshIndicatorTriggerMode deep-demo completed');

  // -- Helper: trigger zone diagram --
  Widget rtZoneDiagram(RefreshIndicatorTriggerMode mode) {
    final isAnywhere = mode == rtAnywhere;
    return Container(
      width: 160,
      height: 180,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: rtMarineLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: rtMarine.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Text(mode.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: rtNavy)),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isAnywhere
                      ? [rtMarine.withValues(alpha: 0.3), rtMarine.withValues(alpha: 0.3)]
                      : [rtMarine.withValues(alpha: 0.4), rtMarineLight.withValues(alpha: 0.1)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isAnywhere ? Icons.swap_vert : Icons.vertical_align_top,
                    color: rtNavy,
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isAnywhere ? 'Active\neverywhere' : 'Active\nat top only',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10, color: rtNavy),
                  ),
                ],
              ),
            ),
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
            gradient: const LinearGradient(colors: [rtMarine, rtNavy]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'RefreshIndicatorTriggerMode\nDeep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),
        const SizedBox(height: 16),

        // Enum info
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: rtMarineLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: rtMarine.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enum Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: rtNavy)),
              const SizedBox(height: 8),
              Text('Total values: ${rtAllValues.length}', style: const TextStyle(fontSize: 13)),
              Text('Type: ${rtAnywhere.runtimeType}', style: const TextStyle(fontSize: 13)),
              const Text('Default: onEdge (standard pull-to-refresh)', style: TextStyle(fontSize: 13)),
              const Text('Purpose: Controls where pull gesture activates refresh', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Behaviour cards
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: rtAllValues.map((v) {
            final icon = v == rtAnywhere ? Icons.swap_vert : Icons.vertical_align_top;
            return Container(
              width: 165,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: v == rtAnywhere ? rtMarine : rtNavy,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.white, size: 28),
                  const SizedBox(height: 6),
                  Text(v.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(rtDescMap[v] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70, fontSize: 10)),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),

        // Trigger zone diagrams
        const Text('Trigger Zone Diagram', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: rtAllValues.map((v) => rtZoneDiagram(v)).toList(),
        ),
        const SizedBox(height: 14),

        // Live widgets
        const Text('Live RefreshIndicators', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        ClipRRect(borderRadius: BorderRadius.circular(10), child: rtAnywhereWidget),
        const SizedBox(height: 12),
        ClipRRect(borderRadius: BorderRadius.circular(10), child: rtOnEdgeWidget),
        const SizedBox(height: 14),

        // Scroll position table
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: rtMarine.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Scroll Position Check', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...rtAllValues.map((mode) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mode.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: rtNavy)),
                        ...rtScrollPositions.take(4).map((pos) {
                          final can = switch (mode) {
                            RefreshIndicatorTriggerMode.anywhere => true,
                            RefreshIndicatorTriggerMode.onEdge => pos <= 0.0,
                          };
                          return Padding(
                            padding: const EdgeInsets.only(left: 12, top: 2),
                            child: Row(
                              children: [
                                Icon(can ? Icons.check : Icons.close, size: 12, color: can ? Colors.green : Colors.red),
                                const SizedBox(width: 4),
                                Text('offset=${pos.toStringAsFixed(0)}: ${can ? "trigger" : "no trigger"}',
                                    style: const TextStyle(fontSize: 11)),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Use cases
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: rtNavy.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Use-Case Scenarios', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...rtUseCases.entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.key.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: rtNavy)),
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

        // Conflict analysis
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: rtMarineLight.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Conflict Analysis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...rtConflicts.entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.key.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                        ...entry.value.map((note) => Padding(
                              padding: const EdgeInsets.only(left: 12, top: 2),
                              child: Text('- $note', style: const TextStyle(fontSize: 11)),
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Performance
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: rtMarine.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Performance Notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...rtPerfNotes.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.speed, size: 14, color: rtMarine),
                        const SizedBox(width: 6),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: '${entry.key.name}: ', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black)),
                                TextSpan(text: entry.value, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                              ],
                            ),
                          ),
                        ),
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
            gradient: const LinearGradient(colors: [rtNavy, rtMarine]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'RefreshIndicatorTriggerMode  ${rtAllValues.length} values  Marine/Navy',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

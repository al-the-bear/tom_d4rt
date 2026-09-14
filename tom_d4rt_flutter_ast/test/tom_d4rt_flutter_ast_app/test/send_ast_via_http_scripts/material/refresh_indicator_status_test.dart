// ignore_for_file: avoid_print
// D4rt deep-demo: RefreshIndicator lifecycle — Coral / Salmon theme
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RefreshIndicator lifecycle deep-demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────
  // 1. Internal enum overview (RefreshIndicatorMode)
  // ──────────────────────────────────────────────
  print('\n[1] Internal enum overview (RefreshIndicatorMode)');
  print('  RefreshIndicatorMode is an INTERNAL enum — not publicly exported.');
  print('  It tracks the lifecycle state of the RefreshIndicator widget.');
  final riModes = ['drag', 'armed', 'snap', 'refresh', 'done', 'canceled'];
  print('  Known internal values: ${riModes.length}');
  for (var i = 0; i < riModes.length; i++) {
    print('  $i: ${riModes[i]}');
  }

  // ──────────────────────────────────────────────
  // 2. State descriptions & semantics
  // ──────────────────────────────────────────────
  print('\n[2] State descriptions & semantics');
  final riDescMap = <String, String>{
    'drag': 'User is pulling down — indicator follows finger movement',
    'armed': 'Pulled far enough — ready to trigger refresh on release',
    'snap': 'Indicator snapping to circular spinner position',
    'refresh': 'onRefresh callback executing — spinner spinning',
    'done': 'Refresh completed — indicator hiding with fade',
    'canceled': 'User released too early — indicator retreating',
  };
  for (final entry in riDescMap.entries) {
    print('  ${entry.key}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 3. State transitions (graph)
  // ──────────────────────────────────────────────
  print('\n[3] State transitions (graph)');
  final riTransitions = <String, List<String>>{
    'idle': ['drag'],
    'drag': ['armed', 'canceled'],
    'armed': ['snap', 'canceled'],
    'snap': ['refresh'],
    'refresh': ['done'],
    'done': ['idle'],
    'canceled': ['idle'],
  };
  for (final entry in riTransitions.entries) {
    print('  ${entry.key} -> ${entry.value.join(", ")}');
  }
  print('  Happy path: idle -> drag -> armed -> snap -> refresh -> done -> idle');
  print('  Cancel path: idle -> drag -> canceled -> idle');

  // ──────────────────────────────────────────────
  // 4. Duration estimates per state
  // ──────────────────────────────────────────────
  print('\n[4] Duration estimates per state');
  final riDurations = <String, String>{
    'drag': 'user-controlled (touch held)',
    'armed': 'instant (threshold crossed)',
    'snap': '~250ms animation',
    'refresh': 'async callback duration',
    'done': '~150ms fade-out',
    'canceled': '~200ms retract',
  };
  for (final entry in riDurations.entries) {
    print('  ${entry.key}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 5. RefreshIndicator constructor properties
  // ──────────────────────────────────────────────
  print('\n[5] RefreshIndicator constructor properties');
  final riProps = <String, String>{
    'onRefresh': 'Future<void> Function() — the refresh callback',
    'displacement': 'How far to push content down (default 40.0)',
    'edgeOffset': 'Space from top before indicator starts (default 0.0)',
    'color': 'Spinner color',
    'backgroundColor': 'Circle background color',
    'strokeWidth': 'Width of the spinner arc (default 2.5)',
    'triggerMode': 'RefreshIndicatorTriggerMode — when to activate',
  };
  for (final entry in riProps.entries) {
    print('  ${entry.key}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 6. Live RefreshIndicator widget
  // ──────────────────────────────────────────────
  print('\n[6] Live RefreshIndicator widget');
  final riItems = List.generate(20, (i) => 'Item ${i + 1}');
  final riIndicator = SizedBox(
    height: 350,
    child: RefreshIndicator(
      color: const Color(0xFFFF6F61),
      backgroundColor: const Color(0xFFFFE0DB),
      displacement: 40.0,
      strokeWidth: 3.0,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: ListView.builder(
        itemCount: riItems.length,
        itemBuilder: (ctx, i) => ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFFF6F61).withValues(alpha: 0.15),
            child: Text('${i + 1}', style: const TextStyle(color: Color(0xFFFF6F61), fontSize: 13)),
          ),
          title: Text(riItems[i]),
          subtitle: Text('Pull down to refresh', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        ),
      ),
    ),
  );
  print('  Built RefreshIndicator: items=${riItems.length}, displacement=40.0, strokeWidth=3.0');

  // ──────────────────────────────────────────────
  // 7. Displacement & edge offset variations
  // ──────────────────────────────────────────────
  print('\n[7] Displacement & edge offset variations');
  final riDisplacements = [20.0, 40.0, 60.0, 80.0];
  for (final d in riDisplacements) {
    print('  displacement=$d: indicator center at ${d}px from edge');
  }
  final riEdgeOffsets = [0.0, 50.0, 100.0];
  for (final e in riEdgeOffsets) {
    print('  edgeOffset=$e: starts listening at ${e}px from top');
  }

  // ──────────────────────────────────────────────
  // 8. Stroke-width visual comparison
  // ──────────────────────────────────────────────
  print('\n[8] Stroke-width visual comparison');
  final riStrokeWidths = [1.5, 2.5, 3.5, 5.0];
  for (final sw in riStrokeWidths) {
    final bar = '=' * (sw * 4).toInt();
    print('  strokeWidth=$sw: $bar');
  }

  // ──────────────────────────────────────────────
  // 9. Color theme exploration
  // ──────────────────────────────────────────────
  print('\n[9] Color theme exploration');
  const riCoral = Color(0xFFFF6F61);
  const riSalmon = Color(0xFFFA8072);
  const riCoralLight = Color(0xFFFFE0DB);
  final riColors = <String, Color>{
    'coral': riCoral,
    'salmon': riSalmon,
    'coralLight': riCoralLight,
  };
  for (final entry in riColors.entries) {
    final c = entry.value;
    print('  ${entry.key}: a=${c.a.toStringAsFixed(2)}, r=${c.r.toStringAsFixed(2)}, '
        'g=${c.g.toStringAsFixed(2)}, b=${c.b.toStringAsFixed(2)}');
  }

  // ──────────────────────────────────────────────
  // 10. Lifecycle animation timeline
  // ──────────────────────────────────────────────
  print('\n[10] Lifecycle animation timeline');
  final riTimeline = <String, double>{
    'drag': 0.0,
    'armed': 0.3,
    'snap': 0.4,
    'refresh': 0.5,
    'done': 0.9,
    'idle': 1.0,
  };
  for (final entry in riTimeline.entries) {
    final progress = (entry.value * 20).toInt();
    final bar = '#' * progress + '.' * (20 - progress);
    print('  ${entry.key.padRight(8)} [$bar] ${(entry.value * 100).toStringAsFixed(0)}%');
  }

  // ──────────────────────────────────────────────
  // 11. RefreshIndicator vs CupertinoSliverRefreshControl
  // ──────────────────────────────────────────────
  print('\n[11] RefreshIndicator vs CupertinoSliverRefreshControl');
  final riComparison = <String, List<String>>{
    'RefreshIndicator': ['Material spinner', 'Wraps ScrollView', 'displacement param', 'strokeWidth param'],
    'CupertinoSliverRefreshControl': ['iOS-style arrow', 'Sliver-based', 'refreshTriggerPullDistance', 'refreshIndicatorExtent'],
  };
  for (final entry in riComparison.entries) {
    print('  ${entry.key}:');
    for (final feature in entry.value) {
      print('    - $feature');
    }
  }

  // ──────────────────────────────────────────────
  // 12. Common patterns & anti-patterns
  // ──────────────────────────────────────────────
  print('\n[12] Common patterns & anti-patterns');
  final riPatterns = <String, bool>{
    'Wrap ListView in RefreshIndicator': true,
    'Use with SingleChildScrollView': true,
    'Nest inside another scrollable': false,
    'Use without onRefresh callback': false,
    'Return completed Future immediately': false,
    'Set reasonable timeout in onRefresh': true,
  };
  for (final entry in riPatterns.entries) {
    final tag = entry.value ? 'GOOD' : 'BAD ';
    print('  [$tag] ${entry.key}');
  }

  // ──────────────────────────────────────────────
  // 13. State indicator icons
  // ──────────────────────────────────────────────
  print('\n[13] State indicator icons');
  final riStateIcons = <String, IconData>{
    'drag': Icons.touch_app,
    'armed': Icons.check_circle_outline,
    'snap': Icons.animation,
    'refresh': Icons.refresh,
    'done': Icons.done,
    'canceled': Icons.cancel_outlined,
  };
  for (final entry in riStateIcons.entries) {
    print('  ${entry.key}: icon(${entry.value.codePoint})');
  }

  // ──────────────────────────────────────────────
  // 14. Grouped states by user interaction
  // ──────────────────────────────────────────────
  print('\n[14] Grouped states by user interaction');
  final riUserDriven = {'drag', 'armed', 'canceled'};
  final riSystemDriven = {'snap', 'refresh', 'done'};
  print('  User-driven : ${riUserDriven.join(", ")}');
  print('  System-driven: ${riSystemDriven.join(", ")}');
  print('  Total: ${riUserDriven.union(riSystemDriven).length} active states (+idle)');

  // ──────────────────────────────────────────────
  // 15. Accessibility considerations
  // ──────────────────────────────────────────────
  print('\n[15] Accessibility considerations');
  final riAccessNotes = [
    'Announces "Refresh" to screen readers when armed',
    'Spinner visible for low-vision users when contrast is sufficient',
    'Pull-to-refresh may not be discoverable for all users',
    'Consider adding explicit refresh button for accessibility',
    'backgroundColor improves visibility against content',
  ];
  for (var i = 0; i < riAccessNotes.length; i++) {
    print('  ${i + 1}. ${riAccessNotes[i]}');
  }

  // ──────────────────────────────────────────────
  // 16. Summary dashboard widget
  // ──────────────────────────────────────────────
  print('\n[16] Summary dashboard widget');
  print('  Building full visual demo...');
  print('=' * 60);
  print('RefreshIndicator lifecycle deep-demo completed');

  // -- Helper: state card --
  Widget riBuildStateCard(String state, String desc, IconData icon, Color bg) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 6),
          Text(state.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(height: 4),
          Text(desc,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 9)),
        ],
      ),
    );
  }

  // Build state cards with gradient colors
  final riCardData = <Map<String, dynamic>>[];
  for (var i = 0; i < riModes.length; i++) {
    final t = i / (riModes.length - 1);
    final color = Color.lerp(riCoral, riSalmon, t)!;
    riCardData.add({
      'state': riModes[i],
      'desc': riDescMap[riModes[i]] ?? '',
      'icon': riStateIcons[riModes[i]] ?? Icons.help,
      'color': Color.lerp(color, Colors.black, 0.1)!,
    });
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
            gradient: const LinearGradient(colors: [riCoral, riSalmon]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'RefreshIndicator Lifecycle\nDeep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),
        const SizedBox(height: 16),

        // Internal enum note
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: riCoralLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: riCoral.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('RefreshIndicatorMode (internal)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: riCoral)),
              const SizedBox(height: 8),
              Text('Internal states: ${riModes.length}', style: const TextStyle(fontSize: 13)),
              const Text('This enum is NOT publicly exported.', style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
              const Text('States tracked internally by RefreshIndicator widget.', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // State cards
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: riCardData.map((data) {
            return riBuildStateCard(
              data['state'] as String,
              data['desc'] as String,
              data['icon'] as IconData,
              data['color'] as Color,
            );
          }).toList(),
        ),
        const SizedBox(height: 14),

        // State transition diagram
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('State Transitions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...riTransitions.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        SizedBox(width: 75, child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                        const Icon(Icons.arrow_forward, size: 14, color: riCoral),
                        const SizedBox(width: 6),
                        Text(entry.value.join(', '), style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Live RefreshIndicator
        const Text('Live RefreshIndicator (pull to try)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: riIndicator,
        ),
        const SizedBox(height: 14),

        // Timeline
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: riCoral.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Animation Timeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...riTimeline.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        SizedBox(width: 60, child: Text(entry.key,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                        Expanded(
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: riCoral.withValues(alpha: entry.value.clamp(0.1, 1.0)),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('${(entry.value * 100).toStringAsFixed(0)}%', style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Grouping
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: riSalmon.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('State Grouping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.touch_app, size: 16, color: riCoral),
                  const SizedBox(width: 6),
                  Text('User: ${riUserDriven.join(", ")}', style: const TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.settings, size: 16, color: riSalmon),
                  const SizedBox(width: 6),
                  Text('System: ${riSystemDriven.join(", ")}', style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Patterns
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: riCoralLight.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Patterns & Anti-Patterns', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...riPatterns.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(entry.value ? Icons.check_circle : Icons.cancel,
                            size: 14, color: entry.value ? Colors.green : Colors.red),
                        const SizedBox(width: 6),
                        Expanded(child: Text(entry.key, style: const TextStyle(fontSize: 11))),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Accessibility
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: riCoral.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Accessibility Notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...riAccessNotes.asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('${entry.key + 1}. ${entry.value}', style: const TextStyle(fontSize: 11)),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Footer
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [riSalmon, riCoral]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'RefreshIndicator  ${riModes.length} internal states  Coral/Salmon',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

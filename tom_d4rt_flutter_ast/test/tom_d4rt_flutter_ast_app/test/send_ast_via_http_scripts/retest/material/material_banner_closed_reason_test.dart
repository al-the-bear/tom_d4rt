// ignore_for_file: avoid_print
// D4rt deep-demo: MaterialBannerClosedReason — Crimson / Ruby theme
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialBannerClosedReason deep-demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────
  // 1. Enum overview & catalogue
  // ──────────────────────────────────────────────
  print('\n[1] Enum overview & catalogue');
  final mbAllValues = MaterialBannerClosedReason.values;
  print('  Total enum values: ${mbAllValues.length}');
  for (final v in mbAllValues) {
    print('  ${v.index}: ${v.name} (${v.runtimeType})');
  }

  const mbDismiss = MaterialBannerClosedReason.dismiss;
  const mbSwipe = MaterialBannerClosedReason.swipe;
  const mbHide = MaterialBannerClosedReason.hide;
  const mbRemove = MaterialBannerClosedReason.remove;

  // ──────────────────────────────────────────────
  // 2. Identity & equality checks
  // ──────────────────────────────────────────────
  print('\n[2] Identity & equality checks');
  print('  dismiss == dismiss: ${mbDismiss == MaterialBannerClosedReason.dismiss}');
  print('  dismiss == swipe: ${mbDismiss == mbSwipe}');
  print('  hide == remove: ${mbHide == mbRemove}');
  print('  swipe == hide: ${mbSwipe == mbHide}');
  print('  identical(dismiss, values[0]): ${identical(mbDismiss, mbAllValues[0])}');
  print('  identical(remove, values.last): ${identical(mbRemove, mbAllValues.last)}');

  // ──────────────────────────────────────────────
  // 3. Index arithmetic & round-trip
  // ──────────────────────────────────────────────
  print('\n[3] Index arithmetic & round-trip');
  for (final v in mbAllValues) {
    final roundTrip = MaterialBannerClosedReason.values[v.index];
    print('  ${v.name} -> index ${v.index} -> values[${v.index}] = ${roundTrip.name} (match: ${roundTrip == v})');
  }
  final mbMiddle = MaterialBannerClosedReason.values[mbAllValues.length ~/ 2];
  print('  Middle value: ${mbMiddle.name} at index ${mbMiddle.index}');

  // ──────────────────────────────────────────────
  // 4. String ↔ enum conversion
  // ──────────────────────────────────────────────
  print('\n[4] String / enum conversion');
  final mbTestNames = ['dismiss', 'swipe', 'hide', 'remove', 'timeout', 'unknown'];
  for (final name in mbTestNames) {
    final found = mbAllValues.where((v) => v.name == name);
    print('  "$name" -> ${found.isNotEmpty ? found.first : "not found"}');
  }

  // ──────────────────────────────────────────────
  // 5. Sorting & ordering
  // ──────────────────────────────────────────────
  print('\n[5] Sorting & ordering');
  print('  Natural order: ${mbAllValues.map((v) => v.name).join(", ")}');
  final mbAlpha = List<MaterialBannerClosedReason>.from(mbAllValues)..sort((a, b) => a.name.compareTo(b.name));
  print('  Alphabetical : ${mbAlpha.map((v) => v.name).join(", ")}');
  final mbRevIdx = List<MaterialBannerClosedReason>.from(mbAllValues)..sort((a, b) => b.index.compareTo(a.index));
  print('  Reverse index: ${mbRevIdx.map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 6. Set / collection operations
  // ──────────────────────────────────────────────
  print('\n[6] Set / collection operations');
  final mbUserActions = {mbDismiss, mbSwipe};
  final mbProgrammatic = {mbHide, mbRemove};
  print('  User-initiated: ${mbUserActions.map((v) => v.name).join(", ")}');
  print('  Programmatic  : ${mbProgrammatic.map((v) => v.name).join(", ")}');
  print('  Union: ${mbUserActions.union(mbProgrammatic).map((v) => v.name).join(", ")}');
  print('  Intersection: ${mbUserActions.intersection(mbProgrammatic).map((v) => v.name).join(", ")}');
  print('  User - Prog: ${mbUserActions.difference(mbProgrammatic).map((v) => v.name).join(", ")}');

  // ──────────────────────────────────────────────
  // 7. Map-based behaviour description
  // ──────────────────────────────────────────────
  print('\n[7] Map-based behaviour description');
  final mbDescMap = <MaterialBannerClosedReason, String>{
    mbDismiss: 'User tapped the dismiss action button',
    mbSwipe: 'User swiped the banner away with a gesture',
    mbHide: 'Banner hidden via hideCurrentMaterialBanner (stays in queue)',
    mbRemove: 'Banner removed via removeCurrentMaterialBanner (gone from queue)',
  };
  for (final entry in mbDescMap.entries) {
    print('  ${entry.key.name}: ${entry.value}');
  }

  // ──────────────────────────────────────────────
  // 8. Pattern matching / switch expression
  // D4RT-LIMITATION: enum exhaustiveness - interpreter cannot match bridged enum values exhaustively
  // ──────────────────────────────────────────────
  print('\n[8] Pattern matching / switch expression');
  for (final v in mbAllValues) {
    final emoji = switch (v) {
      MaterialBannerClosedReason.dismiss => '[x] dismissed by user',
      MaterialBannerClosedReason.swipe => '[<-] swiped away',
      MaterialBannerClosedReason.hide => '[_] hidden programmatically',
      MaterialBannerClosedReason.remove => '[!] removed from queue',
      _ => '[?] unknown reason',
    };
    print('  ${v.name} -> $emoji');
  }

  // ──────────────────────────────────────────────
  // 9. Simulated banner lifecycle
  // ──────────────────────────────────────────────
  print('\n[9] Simulated banner lifecycle');
  final mbEventLog = <String>[];
  final mbScenarios = <String, MaterialBannerClosedReason>{
    'Login prompt': mbDismiss,
    'Cookie notice': mbSwipe,
    'Version update': mbHide,
    'Error alert': mbRemove,
  };
  for (final entry in mbScenarios.entries) {
    final bannerName = entry.key;
    final reason = entry.value;
    mbEventLog.add('Banner "$bannerName" closed: ${reason.name}');
    final isInQueue = reason == mbHide;
    print('  $bannerName -> ${reason.name}, still in queue: $isInQueue');
  }
  print('  Event log entries: ${mbEventLog.length}');
  for (final event in mbEventLog) {
    print('    $event');
  }

  // ──────────────────────────────────────────────
  // 10. Comparison with SnackBarClosedReason
  // ──────────────────────────────────────────────
  print('\n[10] Comparison with SnackBarClosedReason');
  final mbSnackReasons = SnackBarClosedReason.values;
  print('  MaterialBannerClosedReason values: ${mbAllValues.length}');
  print('  SnackBarClosedReason values: ${mbSnackReasons.length}');
  final mbBannerNames = mbAllValues.map((v) => v.name).toSet();
  final mbSnackNames = mbSnackReasons.map((v) => v.name).toSet();
  final mbShared = mbBannerNames.intersection(mbSnackNames);
  final mbBannerOnly = mbBannerNames.difference(mbSnackNames);
  final mbSnackOnly = mbSnackNames.difference(mbBannerNames);
  print('  Shared names: ${mbShared.join(", ")}');
  print('  Banner-only : ${mbBannerOnly.isEmpty ? "(none)" : mbBannerOnly.join(", ")}');
  print('  Snack-only  : ${mbSnackOnly.isEmpty ? "(none)" : mbSnackOnly.join(", ")}');

  // ──────────────────────────────────────────────
  // 11. MaterialBanner widget construction
  // ──────────────────────────────────────────────
  print('\n[11] MaterialBanner widget construction');
  final mbBanner = MaterialBanner(
    content: const Text('This is a sample banner'),
    leading: const Icon(Icons.info_outline),
    backgroundColor: const Color(0xFFFFF3F3),
    actions: [
      TextButton(onPressed: () {}, child: const Text('DISMISS')),
      TextButton(onPressed: () {}, child: const Text('LEARN MORE')),
    ],
  );
  print('  Created MaterialBanner: ${mbBanner.runtimeType}');
  print('  Actions count: 2');
  print('  Has leading icon: true');

  // ──────────────────────────────────────────────
  // 12. Queue behaviour simulation
  // ──────────────────────────────────────────────
  print('\n[12] Queue behaviour simulation');
  final mbQueue = ['Banner-A', 'Banner-B', 'Banner-C'];
  print('  Initial queue: ${mbQueue.join(" -> ")}');
  // hide = hides but stays in queue
  print('  Action: hide Banner-A -> still in queue');
  print('  Queue after hide: ${mbQueue.join(" -> ")}');
  // remove = gone from queue
  mbQueue.removeAt(0);
  print('  Action: remove Banner-A -> removed from queue');
  print('  Queue after remove: ${mbQueue.join(" -> ")}');
  // dismiss via user
  mbQueue.removeAt(0);
  print('  Action: user dismisses Banner-B');
  print('  Queue after dismiss: ${mbQueue.join(" -> ")}');

  // ──────────────────────────────────────────────
  // 13. Counting reasons by category
  // ──────────────────────────────────────────────
  print('\n[13] Counting reasons by category');
  final mbHistory = [mbDismiss, mbSwipe, mbDismiss, mbRemove, mbHide, mbDismiss, mbSwipe, mbRemove, mbHide, mbHide];
  final mbCounts = <MaterialBannerClosedReason, int>{};
  for (final reason in mbHistory) {
    mbCounts[reason] = (mbCounts[reason] ?? 0) + 1;
  }
  print('  History length: ${mbHistory.length}');
  for (final entry in mbCounts.entries) {
    final pct = (entry.value / mbHistory.length * 100).toStringAsFixed(1);
    print('  ${entry.key.name}: ${entry.value} occurrences ($pct%)');
  }
  final mbUserCount = mbHistory.where((r) => r == mbDismiss || r == mbSwipe).length;
  final mbProgCount = mbHistory.where((r) => r == mbHide || r == mbRemove).length;
  print('  User-initiated total: $mbUserCount');
  print('  Programmatic total: $mbProgCount');

  // ──────────────────────────────────────────────
  // 14. Theme integration colour palette
  // ──────────────────────────────────────────────
  print('\n[14] Theme integration colour palette');
  const mbCrimson = Color(0xFFDC143C);
  const mbRuby = Color(0xFFE0115F);
  const mbRubyLight = Color(0xFFF8D7DA);
  final mbColors = <String, Color>{'crimson': mbCrimson, 'ruby': mbRuby, 'rubyLight': mbRubyLight};
  for (final entry in mbColors.entries) {
    final c = entry.value;
    print('  ${entry.key}: a=${c.a.toStringAsFixed(2)}, r=${c.r.toStringAsFixed(2)}, g=${c.g.toStringAsFixed(2)}, b=${c.b.toStringAsFixed(2)}');
  }

  // ──────────────────────────────────────────────
  // 15. Visual card builder per reason
  // ──────────────────────────────────────────────
  // D4RT-LIMITATION: enum exhaustiveness
  print('\n[15] Visual card builder per reason');
  Widget mbBuildCard(MaterialBannerClosedReason reason, Color bg) {
    final icon = switch (reason) {
      MaterialBannerClosedReason.dismiss => Icons.close,
      MaterialBannerClosedReason.swipe => Icons.swipe_left,
      MaterialBannerClosedReason.hide => Icons.visibility_off,
      MaterialBannerClosedReason.remove => Icons.delete_outline,
      _ => Icons.help_outline,
    };
    return Container(
      width: 130,
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
          Text(reason.name.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 4),
          Text(mbDescMap[reason] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 9)),
        ],
      ),
    );
  }

  final mbCards = <Widget>[];
  final mbCardColors = [mbCrimson, mbRuby, Color.lerp(mbCrimson, Colors.black, 0.2)!, Color.lerp(mbRuby, Colors.black, 0.2)!];
  for (var i = 0; i < mbAllValues.length; i++) {
    mbCards.add(mbBuildCard(mbAllValues[i], mbCardColors[i]));
    print('  Built card for ${mbAllValues[i].name}');
  }

  // ──────────────────────────────────────────────
  // 16. Summary dashboard widget
  // ──────────────────────────────────────────────
  print('\n[16] Summary dashboard widget');
  print('  Building full visual demo...');
  print('=' * 60);
  print('MaterialBannerClosedReason deep-demo completed');

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
            gradient: const LinearGradient(colors: [mbCrimson, mbRuby]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'MaterialBannerClosedReason\nDeep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),
        const SizedBox(height: 16),

        // Enum info
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: mbRubyLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: mbCrimson.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enum Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: mbCrimson)),
              const SizedBox(height: 8),
              Text('Total values: ${mbAllValues.length}', style: const TextStyle(fontSize: 13)),
              Text('Type: ${mbDismiss.runtimeType}', style: const TextStyle(fontSize: 13)),
              const Text('Purpose: Indicates why a MaterialBanner was closed', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Reason cards
        Wrap(spacing: 10, runSpacing: 10, children: mbCards),
        const SizedBox(height: 14),

        // User vs Programmatic
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Action Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(width: 12, height: 12, decoration: BoxDecoration(color: mbCrimson, borderRadius: BorderRadius.circular(6))),
                  const SizedBox(width: 8),
                  Text('User-initiated: ${mbUserActions.map((v) => v.name).join(", ")}', style: const TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(width: 12, height: 12, decoration: BoxDecoration(color: mbRuby, borderRadius: BorderRadius.circular(6))),
                  const SizedBox(width: 8),
                  Text('Programmatic: ${mbProgrammatic.map((v) => v.name).join(", ")}', style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // SnackBar comparison
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: mbCrimson.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('vs SnackBarClosedReason', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              Text('Shared: ${mbShared.join(", ")}', style: const TextStyle(fontSize: 12)),
              Text('Banner-only: ${mbBannerOnly.isEmpty ? "(none)" : mbBannerOnly.join(", ")}', style: const TextStyle(fontSize: 12)),
              Text('Snack-only: ${mbSnackOnly.isEmpty ? "(none)" : mbSnackOnly.join(", ")}', style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Statistics
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: mbRuby.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sample Statistics (10 events)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...mbCounts.entries.map((entry) {
                final pct = (entry.value / mbHistory.length * 100).toStringAsFixed(0);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(width: 70, child: Text(entry.key.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                      Expanded(
                        child: Container(
                          height: 16,
                          decoration: BoxDecoration(
                            color: mbCrimson.withValues(alpha: entry.value / mbHistory.length),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('$pct%', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Sample MaterialBanner
        mbBanner,
        const SizedBox(height: 14),

        // Event log
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Event Log', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ...mbEventLog.map((event) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(event, style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Footer
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [mbRuby, mbCrimson]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'MaterialBannerClosedReason  ${mbAllValues.length} values  Crimson/Ruby',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

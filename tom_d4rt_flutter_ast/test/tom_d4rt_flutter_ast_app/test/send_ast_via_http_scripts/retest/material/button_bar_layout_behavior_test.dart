// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Deep demo of ButtonBarLayoutBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Theme: Burgundy / Wine ─────────────────────────────────────
  const bbPrimary = Color(0xFF880E4F);
  const bbSecondary = Color(0xFFC2185B);
  const bbAccent = Color(0xFFF48FB1);
  const bbSurface = Color(0xFFFCE4EC);
  const bbDark = Color(0xFF560027);
  final bbDarkened = Color.lerp(bbPrimary, Colors.black, 0.3)!;

  // ── 1. Enum overview ──────────────────────────────────────────
  print('=== ButtonBarLayoutBehavior Deep Demo ===');
  print('ButtonBarLayoutBehavior is a Material enum with ${ButtonBarLayoutBehavior.values.length} values');
  for (final v in ButtonBarLayoutBehavior.values) {
    print('  ${v.name} (index ${v.index})');
  }

  // ── 2. constrained value ──────────────────────────────────────
  const constrained = ButtonBarLayoutBehavior.constrained;
  print('\nconstrained:');
  print('  name: ${constrained.name}');
  print('  index: ${constrained.index}');
  print('  toString: $constrained');
  print('  Minimum height of 52 logical pixels');
  print('  Conforms to Material Design button bar spec');

  // ── 3. padded value ───────────────────────────────────────────
  const padded = ButtonBarLayoutBehavior.padded;
  print('\npadded:');
  print('  name: ${padded.name}');
  print('  index: ${padded.index}');
  print('  toString: $padded');
  print('  Height calculated from button theme padding');
  print('  More flexible sizing approach');

  // ── 4. Equality checks ───────────────────────────────────────
  print('\nEquality:');
  print('  constrained == constrained: ${constrained == ButtonBarLayoutBehavior.constrained}');
  print('  constrained == padded: ${constrained == padded}');
  print('  identical: ${identical(constrained, ButtonBarLayoutBehavior.constrained)}');
  print('  hashCode constrained: ${constrained.hashCode}');
  print('  hashCode padded: ${padded.hashCode}');

  // ── 5. Index ordering ────────────────────────────────────────
  print('\nIndex ordering:');
  final first = ButtonBarLayoutBehavior.values.first;
  final last = ButtonBarLayoutBehavior.values.last;
  print('  first: ${first.name} (index ${first.index})');
  print('  last: ${last.name} (index ${last.index})');
  print('  constrained.index < padded.index: ${constrained.index < padded.index}');

  // ── 6. Usage in ButtonTheme ───────────────────────────────────
  print('\nUsage in ButtonTheme:');
  final constrainedTheme = ButtonTheme(
    layoutBehavior: ButtonBarLayoutBehavior.constrained,
    child: Container(),
  );
  final paddedTheme = ButtonTheme(
    layoutBehavior: ButtonBarLayoutBehavior.padded,
    child: Container(),
  );
  print('  constrainedTheme: ${constrainedTheme.runtimeType}');
  print('  paddedTheme: ${paddedTheme.runtimeType}');
  print('  Both valid ButtonTheme configurations');

  // ── 7. ButtonThemeData integration ────────────────────────────
  const constrainedData = ButtonThemeData(layoutBehavior: ButtonBarLayoutBehavior.constrained);
  const paddedData = ButtonThemeData(layoutBehavior: ButtonBarLayoutBehavior.padded);
  print('\nButtonThemeData:');
  print('  constrained data: layoutBehavior=${constrainedData.layoutBehavior}');
  print('  padded data: layoutBehavior=${paddedData.layoutBehavior}');

  // ── 8. Default behavior ───────────────────────────────────────
  const defaultData = ButtonThemeData();
  print('\nDefault behavior:');
  print('  default layoutBehavior: ${defaultData.layoutBehavior}');

  // ── 9. Switch pattern ─────────────────────────────────────────
  // D4RT-LIMITATION: enum exhaustiveness - interpreter cannot match bridged enum values exhaustively
  String bbDescribe(ButtonBarLayoutBehavior behavior) {
    switch (behavior) {
      case ButtonBarLayoutBehavior.constrained:
        return 'Fixed 52px minimum height, Material spec';
      case ButtonBarLayoutBehavior.padded:
        return 'Flexible height from theme padding';
      default:
        return 'Unknown layout behavior: ${behavior.name}';
    }
  }
  print('\nDescriptions:');
  for (final v in ButtonBarLayoutBehavior.values) {
    print('  ${v.name}: ${bbDescribe(v)}');
  }

  // ── 10. String / name conversions ─────────────────────────────
  print('\ntoString vs name:');
  for (final v in ButtonBarLayoutBehavior.values) {
    print('  toString: $v  |  name: ${v.name}');
  }

  // ── 11. Visual properties ─────────────────────────────────────
  // D4RT-LIMITATION: enum exhaustiveness - interpreter cannot match bridged enum values exhaustively
  double bbMinHeight(ButtonBarLayoutBehavior behavior) {
    switch (behavior) {
      case ButtonBarLayoutBehavior.constrained:
        return 52.0;
      case ButtonBarLayoutBehavior.padded:
        return 0.0;
      default:
        return 0.0;
    }
  }
  print('\nMinimum heights:');
  for (final v in ButtonBarLayoutBehavior.values) {
    print('  ${v.name}: ${bbMinHeight(v)}px');
  }

  // ── 12. Material 3 deprecation note ───────────────────────────
  print('\nMaterial 3 deprecation:');
  print('  ButtonBar is deprecated in Material 3');
  print('  Replacement: OverflowBar or Row with MainAxisAlignment.end');
  print('  ButtonBarLayoutBehavior remains for legacy compatibility');
  print('  New apps should use OverflowBar directly');

  // ── 13. Comparison with OverflowBar ───────────────────────────
  print('\nOverflowBar comparison:');
  print('  ButtonBar + constrained ~ OverflowBar with constraints');
  print('  ButtonBar + padded ~ OverflowBar with padding');
  print('  OverflowBar is more flexible and not deprecated');

  // ── 14. ButtonBar with both behaviors ─────────────────────────
  print('\nButtonBar configurations:');
  print('  ButtonBar(layoutBehavior: constrained)');
  print('  ButtonBar(layoutBehavior: padded)');
  print('  Both affect only the bar height, not button arrangement');

  // ── 15. Sorting and filtering ─────────────────────────────────
  final sorted = List<ButtonBarLayoutBehavior>.from(ButtonBarLayoutBehavior.values)
    ..sort((a, b) => a.name.compareTo(b.name));
  print('\nAlphabetically sorted:');
  for (final v in sorted) {
    print('  ${v.name}');
  }

  // ── 16. Visual builder ────────────────────────────────────────
  print('\nButtonBarLayoutBehavior deep demo completed');

  Widget bbBehaviorCard(ButtonBarLayoutBehavior behavior) {
    final isConstrained = behavior == ButtonBarLayoutBehavior.constrained;
    final icon = isConstrained ? Icons.straighten : Icons.padding;
    final subtitle = bbDescribe(behavior);
    final height = bbMinHeight(behavior);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isConstrained ? bbPrimary.withValues(alpha: 0.4) : bbSecondary.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [BoxShadow(color: (isConstrained ? bbPrimary : bbSecondary).withValues(alpha: 0.1), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (isConstrained ? bbPrimary : bbSecondary).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: isConstrained ? bbPrimary : bbSecondary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      behavior.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isConstrained ? bbPrimary : bbSecondary),
                    ),
                    Text('index: ${behavior.index}', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isConstrained ? const Color(0xFFFFF3E0) : const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  height > 0 ? '${height.toInt()}px min' : 'flexible',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isConstrained ? const Color(0xFFE65100) : const Color(0xFF2E7D32),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 10),
          // Visual height indicator
          Container(
            width: double.infinity,
            height: isConstrained ? 52 : 36,
            decoration: BoxDecoration(
              color: (isConstrained ? bbPrimary : bbSecondary).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: (isConstrained ? bbPrimary : bbSecondary).withValues(alpha: 0.2),
                style: isConstrained ? BorderStyle.solid : BorderStyle.none,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Cancel', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                ),
                Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: isConstrained ? bbPrimary : bbSecondary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('OK', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bbInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600]))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [bbPrimary, bbSecondary, bbAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: bbPrimary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [
              const Icon(Icons.table_rows, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              const Text('ButtonBarLayoutBehavior', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                'Material enum — ${ButtonBarLayoutBehavior.values.length} layout modes',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Stats ──
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: bbPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: bbPrimary.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text('${ButtonBarLayoutBehavior.values.length}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: bbPrimary)),
                    Text('Values', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: bbSecondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: bbSecondary.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text('52', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: bbSecondary)),
                    Text('Min Height px', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: bbAccent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: bbAccent.withValues(alpha: 0.4)),
                ),
                child: Column(
                  children: [
                    Text('M2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.lerp(bbAccent, Colors.black, 0.3))),
                    Text('Design Era', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Behavior cards ──
        Text('Layout Behaviors', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: bbDarkened)),
        const SizedBox(height: 8),
        ...ButtonBarLayoutBehavior.values.map(bbBehaviorCard),
        const SizedBox(height: 16),

        // ── ButtonThemeData info ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: bbSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: bbPrimary.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ButtonThemeData Integration', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: bbDark)),
              const SizedBox(height: 8),
              bbInfoRow('Default', defaultData.layoutBehavior.name),
              bbInfoRow('constrained data', constrainedData.layoutBehavior.name),
              bbInfoRow('padded data', paddedData.layoutBehavior.name),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Deprecation notice ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.amber, size: 18),
                  const SizedBox(width: 8),
                  Text('Material 3 Note', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.amber[900])),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'ButtonBar is deprecated in Material 3. Use OverflowBar or Row with MainAxisAlignment.end instead. '
                'ButtonBarLayoutBehavior remains available for legacy apps.',
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Comparison table ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Constrained vs Padded', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: bbDark)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 110),
                  Expanded(child: Center(child: Text('constrained', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: bbPrimary)))),
                  Expanded(child: Center(child: Text('padded', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: bbSecondary)))),
                ],
              ),
              const Divider(height: 12),
              Row(
                children: [
                  SizedBox(width: 110, child: Text('Min height', style: TextStyle(fontSize: 11, color: Colors.grey[600]))),
                  const Expanded(child: Center(child: Text('52px', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)))),
                  const Expanded(child: Center(child: Text('0px', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)))),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(width: 110, child: Text('Sizing', style: TextStyle(fontSize: 11, color: Colors.grey[600]))),
                  const Expanded(child: Center(child: Text('Fixed', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)))),
                  const Expanded(child: Center(child: Text('Flexible', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)))),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(width: 110, child: Text('Spec compliant', style: TextStyle(fontSize: 11, color: Colors.grey[600]))),
                  Expanded(child: Center(child: Icon(Icons.check_circle, size: 16, color: const Color(0xFF2E7D32)))),
                  Expanded(child: Center(child: Icon(Icons.remove_circle_outline, size: 16, color: Colors.grey[400]))),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Footer ──
        Center(
          child: Text(
            'ButtonBarLayoutBehavior — ${ButtonBarLayoutBehavior.values.length} modes | Material 2 legacy',
            style: TextStyle(fontSize: 10, color: bbDark.withValues(alpha: 0.5)),
          ),
        ),
      ],
    ),
  );
}

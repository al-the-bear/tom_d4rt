// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Deep demo of ButtonTextTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Theme: Olive / Sage ────────────────────────────────────────
  const btPrimary = Color(0xFF558B2F);
  const btSecondary = Color(0xFF689F38);
  const btAccent = Color(0xFFAED581);
  const btSurface = Color(0xFFF1F8E9);
  const btDark = Color(0xFF33691E);
  final btDarkened = Color.lerp(btPrimary, Colors.black, 0.3)!;

  // ── 1. Enum overview ──────────────────────────────────────────
  print('=== ButtonTextTheme Deep Demo ===');
  print('ButtonTextTheme is a Material enum with ${ButtonTextTheme.values.length} values');
  for (final v in ButtonTextTheme.values) {
    print('  ${v.name} (index ${v.index})');
  }

  // ── 2. normal value ───────────────────────────────────────────
  const normal = ButtonTextTheme.normal;
  print('\nnormal:');
  print('  name: ${normal.name}');
  print('  index: ${normal.index}');
  print('  toString: $normal');
  print('  Text color: black or white depending on brightness');
  print('  Default for most button types');

  // ── 3. accent value ───────────────────────────────────────────
  const accent = ButtonTextTheme.accent;
  print('\naccent:');
  print('  name: ${accent.name}');
  print('  index: ${accent.index}');
  print('  toString: $accent');
  print('  Uses ColorScheme.secondary');
  print('  Legacy Material 2 terminology');

  // ── 4. primary value ──────────────────────────────────────────
  const primary = ButtonTextTheme.primary;
  print('\nprimary:');
  print('  name: ${primary.name}');
  print('  index: ${primary.index}');
  print('  toString: $primary');
  print('  Based on ThemeData.primaryColor');
  print('  High-visibility action buttons');

  // ── 5. Equality checks ───────────────────────────────────────
  print('\nEquality:');
  print('  normal == normal: ${normal == ButtonTextTheme.normal}');
  print('  normal == accent: ${normal == accent}');
  print('  normal == primary: ${normal == primary}');
  print('  identical(accent, ButtonTextTheme.accent): ${identical(accent, ButtonTextTheme.accent)}');
  print('  hashCode normal: ${normal.hashCode}');
  print('  hashCode accent: ${accent.hashCode}');
  print('  hashCode primary: ${primary.hashCode}');

  // ── 6. Index ordering ────────────────────────────────────────
  print('\nIndex ordering:');
  final first = ButtonTextTheme.values.first;
  final last = ButtonTextTheme.values.last;
  print('  first: ${first.name} (index ${first.index})');
  print('  last: ${last.name} (index ${last.index})');
  print('  normal < accent: ${normal.index < accent.index}');
  print('  accent < primary: ${accent.index < primary.index}');

  // ── 7. ButtonThemeData integration ────────────────────────────
  const normalData = ButtonThemeData(textTheme: ButtonTextTheme.normal);
  const accentData = ButtonThemeData(textTheme: ButtonTextTheme.accent);
  const primaryData = ButtonThemeData(textTheme: ButtonTextTheme.primary);
  print('\nButtonThemeData:');
  print('  normal data: textTheme=${normalData.textTheme}');
  print('  accent data: textTheme=${accentData.textTheme}');
  print('  primary data: textTheme=${primaryData.textTheme}');

  // ── 8. Default behavior ───────────────────────────────────────
  const defaultData = ButtonThemeData();
  print('\nDefault: ${defaultData.textTheme}');

  // ── 9. Color resolution per theme ─────────────────────────────
  // D4RT-LIMITATION: enum exhaustiveness - interpreter cannot match bridged enum values exhaustively
  Color btResolveColor(ButtonTextTheme theme, Brightness brightness) {
    switch (theme) {
      case ButtonTextTheme.normal:
        return brightness == Brightness.dark ? Colors.white : Colors.black87;
      case ButtonTextTheme.accent:
        return const Color(0xFF03DAC6);
      case ButtonTextTheme.primary:
        return const Color(0xFF6200EE);
      default:
        return Colors.grey;
    }
  }
  print('\nColor resolution (light):');
  for (final v in ButtonTextTheme.values) {
    final c = btResolveColor(v, Brightness.light);
    print('  ${v.name}: #${c.value.toRadixString(16).padLeft(8, '0')}');
  }
  print('Color resolution (dark):');
  for (final v in ButtonTextTheme.values) {
    final c = btResolveColor(v, Brightness.dark);
    print('  ${v.name}: #${c.value.toRadixString(16).padLeft(8, '0')}');
  }

  // ── 10. Switch pattern ────────────────────────────────────────
  // D4RT-LIMITATION: enum exhaustiveness - interpreter cannot match bridged enum values exhaustively
  String btDescribe(ButtonTextTheme theme) {
    switch (theme) {
      case ButtonTextTheme.normal:
        return 'Brightness-dependent black/white text';
      case ButtonTextTheme.accent:
        return 'ColorScheme.secondary-based text';
      case ButtonTextTheme.primary:
        return 'ThemeData.primaryColor-based text';
      default:
        return 'Unknown theme: ${theme.name}';
    }
  }
  print('\nDescriptions:');
  for (final v in ButtonTextTheme.values) {
    print('  ${v.name}: ${btDescribe(v)}');
  }

  // ── 11. String / name conversions ─────────────────────────────
  print('\ntoString vs name:');
  for (final v in ButtonTextTheme.values) {
    print('  toString: $v  |  name: ${v.name}');
  }

  // ── 12. Material 2 vs Material 3 context ──────────────────────
  print('\nMaterial evolution:');
  print('  Material 2: ButtonTheme + ButtonTextTheme for text color');
  print('  Material 3: ButtonStyle + MaterialStateProperty for text');
  print('  ElevatedButton.styleFrom() replaces ButtonTextTheme.primary');
  print('  TextButton.styleFrom() replaces ButtonTextTheme.normal');

  // ── 13. Use case mapping ──────────────────────────────────────
  // D4RT-LIMITATION: enum exhaustiveness - interpreter cannot match bridged enum values exhaustively
  String btUseCase(ButtonTextTheme theme) {
    switch (theme) {
      case ButtonTextTheme.normal:
        return 'Default text buttons, neutral actions';
      case ButtonTextTheme.accent:
        return 'Secondary calls-to-action, highlights';
      case ButtonTextTheme.primary:
        return 'Primary actions, submit buttons';
      default:
        return 'Unknown use case';
    }
  }
  print('\nUse cases:');
  for (final v in ButtonTextTheme.values) {
    print('  ${v.name}: ${btUseCase(v)}');
  }

  // ── 14. Icon mapping ──────────────────────────────────────────
  // D4RT-LIMITATION: enum exhaustiveness - interpreter cannot match bridged enum values exhaustively
  IconData btIcon(ButtonTextTheme theme) {
    switch (theme) {
      case ButtonTextTheme.normal:
        return Icons.text_fields;
      case ButtonTextTheme.accent:
        return Icons.star;
      case ButtonTextTheme.primary:
        return Icons.priority_high;
      default:
        return Icons.help_outline;
    }
  }
  print('\nIcon mappings assigned');

  // ── 15. Sorting ───────────────────────────────────────────────
  final sorted = List<ButtonTextTheme>.from(ButtonTextTheme.values)
    ..sort((a, b) => a.name.compareTo(b.name));
  print('\nAlphabetically sorted:');
  for (final v in sorted) {
    print('  ${v.name}');
  }

  // ── 16. Visual builder ────────────────────────────────────────
  print('\nButtonTextTheme deep demo completed');

  Widget btThemeCard(ButtonTextTheme theme) {
    final color = btResolveColor(theme, Brightness.light);
    final darkColor = btResolveColor(theme, Brightness.dark);
    final desc = btDescribe(theme);
    final useCase = btUseCase(theme);
    final icon = btIcon(theme);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: btPrimary.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: btPrimary.withValues(alpha: 0.08), blurRadius: 6, offset: const Offset(0, 2))],
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
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      theme.name,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: btDark),
                    ),
                    Text('index: ${theme.index}', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
          const SizedBox(height: 4),
          Text(useCase, style: TextStyle(fontSize: 11, color: Colors.grey[500], fontStyle: FontStyle.italic)),
          const SizedBox(height: 10),
          // Color preview for light and dark
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Text('Light Mode', style: TextStyle(fontSize: 9, color: Colors.grey[500])),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: color.withValues(alpha: 0.3)),
                        ),
                        child: Text('Button', style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF303030),
                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Text('Dark Mode', style: TextStyle(fontSize: 9, color: Colors.grey[400])),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: darkColor.withValues(alpha: 0.3)),
                        ),
                        child: Text('Button', style: TextStyle(color: darkColor, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget btInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600]))),
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
              colors: [btPrimary, btSecondary, btAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: btPrimary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [
              const Icon(Icons.format_color_text, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              const Text('ButtonTextTheme', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                'Material enum — ${ButtonTextTheme.values.length} text color themes',
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
                  color: btPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: btPrimary.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text('${ButtonTextTheme.values.length}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: btPrimary)),
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
                  color: btSecondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: btSecondary.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text('M2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: btSecondary)),
                    Text('Design Era', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: btAccent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: btAccent.withValues(alpha: 0.4)),
                ),
                child: Column(
                  children: [
                    Text('2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.lerp(btAccent, Colors.black, 0.4))),
                    Text('Brightness', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Theme cards ──
        Text('Text Theme Values', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: btDarkened)),
        const SizedBox(height: 8),
        ...ButtonTextTheme.values.map(btThemeCard),
        const SizedBox(height: 16),

        // ── ButtonThemeData defaults ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: btSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: btPrimary.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ButtonThemeData Integration', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: btDark)),
              const SizedBox(height: 8),
              btInfoRow('Default', defaultData.textTheme.name),
              btInfoRow('normal data', normalData.textTheme.name),
              btInfoRow('accent data', accentData.textTheme.name),
              btInfoRow('primary data', primaryData.textTheme.name),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Material 3 migration ──
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
                  const Icon(Icons.swap_horiz, color: Colors.amber, size: 18),
                  const SizedBox(width: 8),
                  Text('Material 3 Migration', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.amber[900])),
                ],
              ),
              const SizedBox(height: 8),
              btInfoRow('normal \u2192', 'TextButton.styleFrom()'),
              btInfoRow('accent \u2192', 'OutlinedButton.styleFrom()'),
              btInfoRow('primary \u2192', 'ElevatedButton.styleFrom()'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Alphabetical order ──
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
              Text('Alphabetical Order', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: btDark)),
              const SizedBox(height: 8),
              ...sorted.asMap().entries.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(color: btAccent.withValues(alpha: 0.3), shape: BoxShape.circle),
                          child: Center(child: Text('${e.key + 1}', style: TextStyle(fontSize: 10, color: btDark, fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(width: 8),
                        Text(e.value.name, style: const TextStyle(fontSize: 13)),
                        const Spacer(),
                        Text('index ${e.value.index}', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Footer ──
        Center(
          child: Text(
            'ButtonTextTheme — ${ButtonTextTheme.values.length} themes | normal, accent, primary',
            style: TextStyle(fontSize: 10, color: btDark.withValues(alpha: 0.5)),
          ),
        ),
      ],
    ),
  );
}

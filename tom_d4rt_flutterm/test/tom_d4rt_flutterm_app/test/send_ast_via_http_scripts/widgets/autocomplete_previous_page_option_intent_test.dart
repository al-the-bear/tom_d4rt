// ignore_for_file: avoid_print
// Deep demo: AutocompletePreviousPageOptionIntent — page-jump backward
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Warm Burgundy / Rose Mist
// ─────────────────────────────────────────────────────────────
const Color _ppBurgundy = Color(0xFF880E4F);
const Color _ppRoseMist = Color(0xFFFCE4EC);
const Color _ppDarkBurgundy = Color(0xFF560027);
const Color _ppMedBurgundy = Color(0xFFAD1457);
const Color _ppLightRose = Color(0xFFF8BBD0);
const Color _ppWhite = Color(0xFFFFFFFF);
const Color _ppGray = Color(0xFFC2185B);
const Color _ppAccentGreen = Color(0xFF2E7D32);
const Color _ppAccentOrange = Color(0xFFE65100);
const Color _ppAccentTeal = Color(0xFF00796B);
const Color _ppAccentIndigo = Color(0xFF283593);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _ppSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _ppWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _ppLightRose, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x1A880E4F), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _ppBurgundy,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _ppWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _ppLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _ppDarkBurgundy,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _ppBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _ppGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _ppCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF0F3),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _ppLightRose.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _ppDarkBurgundy,
            height: 1.45)),
  );
}

Widget _ppChip(String text, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(text,
        style:
            TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _ppDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _ppLightRose.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: AutocompletePreviousPageOptionIntent');
  print('  Page-jump backward through autocomplete options');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _ppRoseMist,
      appBarTheme: const AppBarTheme(
        backgroundColor: _ppBurgundy,
        foregroundColor: _ppWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutocompletePreviousPageOptionIntent',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Banner
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_ppDarkBurgundy, _ppBurgundy, _ppMedBurgundy],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _ppWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.keyboard_double_arrow_up_rounded,
                        color: _ppWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('PreviousPageOptionIntent',
                      style: TextStyle(
                          color: _ppWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Jump backward by one page in autocomplete options',
                      style: TextStyle(
                          color: _ppWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ppChip('Intent', _ppWhite.withValues(alpha: 0.25), _ppWhite),
                      _ppChip('Page Up', _ppWhite.withValues(alpha: 0.25), _ppWhite),
                      _ppChip('Backward', _ppWhite.withValues(alpha: 0.25), _ppWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('1 · What Is PreviousPageOptionIntent?', [
              _ppBody(
                'AutocompletePreviousPageOptionIntent is the backward page-jump '
                'complement to AutocompleteNextPageOptionIntent. Where the Next '
                'variant skips forward by a viewport\'s worth of items, this '
                'intent skips backward, letting users return quickly to '
                'options they scrolled past.',
              ),
              _ppLabel('Class hierarchy'),
              _ppCodeBlock(
                'Intent  (abstract base)\n'
                '  └─ AutocompletePreviousPageOptionIntent\n'
                '       • Concrete, no extra fields\n'
                '       • const constructor\n'
                '       • Moves highlight by -(pageSize) items\n'
                '       • Wraps or clamps at boundary 0',
              ),
              _ppDivider(),
              _ppBody(
                'This intent is essential for long option lists (100+ items) '
                'where single-step ↑ navigation is impractical. The Page Up '
                'key binding makes it a natural counterpart to Page Down.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Page size calculation
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('2 · Page Size Calculation', [
              _ppBody(
                'Page size is computed from the dropdown viewport, not the '
                'full list. The framework divides viewport height by item '
                'height to determine how many items fit in one "page".',
              ),
              _buildViewportDiagram(),
              _ppDivider(),
              _ppLabel('Calculation formula'),
              _ppCodeBlock(
                'pageSize = (viewportHeight / itemHeight).floor()\n'
                '\n'
                '// Example:\n'
                '//   viewport = 240px, item = 48px\n'
                '//   pageSize = (240 / 48).floor() = 5\n'
                '//   PgUp jumps backward by 5 items',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Backward jump arithmetic
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('3 · Backward Jump Arithmetic', [
              _ppBody(
                'With 20 items and a page size of 5, pressing PgUp from '
                'various positions shows how the index moves backward.',
              ),
              _buildJumpArithmetic(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Page jump vs single step
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('4 · Page Jump vs Single Step — Backward', [
              _ppBody(
                'Comparing the backward navigation from index 18 in a '
                '20-item list using different strategies.',
              ),
              _buildBackwardComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Boundary behavior at index 0
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('5 · Boundary Behavior at the Top', [
              _ppBody(
                'When the current index is less than the page size, the '
                'framework must decide: clamp to 0 or wrap to the end? '
                'This matches the NextPageOption boundary strategy.',
              ),
              _buildBoundaryVisual(),
              _ppDivider(),
              _ppLabel('Implementation pattern'),
              _ppCodeBlock(
                '// Clamp strategy:\n'
                'newIndex = max(0, currentIndex - pageSize);\n'
                '\n'
                '// Wrap strategy:\n'
                'newIndex = (currentIndex - pageSize + length) % length;\n'
                '\n'
                '// Clamp variant (Flutter default):\n'
                '//   At index 2, pageSize 5 → clamp to 0\n'
                '//   Rather than wrapping to index 17',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Key bindings
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('6 · Platform Key Bindings', [
              _ppBody(
                'PreviousPageOptionIntent is bound to the Page Up key on '
                'all desktop platforms. Some platforms also support '
                'alternative bindings.',
              ),
              ..._buildPlatformBindingsCards(),
              _ppDivider(),
              _ppLabel('Custom binding example'),
              _ppCodeBlock(
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    // Shift+↑ for page-up as alternative\n'
                '    const SingleActivator(\n'
                '      LogicalKeyboardKey.arrowUp,\n'
                '      shift: true,\n'
                '    ): AutocompletePreviousPageOptionIntent(),\n'
                '  },\n'
                '  child: autocompleteField,\n'
                ')',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Scroll position sync
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('7 · Scroll Position Synchronization', [
              _ppBody(
                'When PgUp jumps the highlight backward by 5 items, the '
                'scrollable dropdown must scroll to keep the highlighted '
                'item visible. This requires coordinating highlight index '
                'with the ScrollController.',
              ),
              _buildScrollSyncDiagram(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Complete navigation matrix
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('8 · Complete Navigation Intent Matrix', [
              _ppBody(
                'All six autocomplete navigation intents form a 3×2 grid '
                'organized by granularity (single/page/boundary) and '
                'direction (forward/backward).',
              ),
              _buildFullMatrix(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Timezone picker
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('9 · Real-World: Timezone Picker', [
              _ppBody(
                'Timezone lists typically have 400+ entries. PgUp/PgDn '
                'navigation is essential for quickly moving through zones '
                'grouped alphabetically.',
              ),
              _buildTimezonePickerDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Font family browser
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('10 · Scenario: Font Family Browser', [
              _ppBody(
                'Designers browsing fonts with an autocomplete field. After '
                'PgDn past the target group, PgUp brings them back quickly.',
              ),
              _buildFontBrowserDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Keystroke savings
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('11 · Backward Navigation Efficiency', [
              _ppBody(
                'Comparison of backward navigation methods to reach item #3 '
                'from item #18 in a 20-item list (page size 5).',
              ),
              _buildEfficiencyChart(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _ppSection('12 · Summary', [
              _ppBody(
                'AutocompletePreviousPageOptionIntent completes the backward '
                'page-jump capability for autocomplete keyboard navigation.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_ppBurgundy, _ppMedBurgundy],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _ppSummaryRow(Icons.keyboard_double_arrow_up, 'Page-jump backward navigation'),
                    _ppSummaryRow(Icons.calculate, 'Page size = viewport / item height'),
                    _ppSummaryRow(Icons.keyboard, 'Mapped to Page Up by default'),
                    _ppSummaryRow(Icons.swap_vert, 'Mirror of NextPageOptionIntent'),
                    _ppSummaryRow(Icons.vertical_align_top, 'Clamps at boundary index 0'),
                    _ppSummaryRow(Icons.speed, 'Essential for long lists (100+ items)'),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 2: Viewport diagram
// ─────────────────────────────────────────────────────────────
Widget _buildViewportDiagram() {
  final allItems = List.generate(16, (i) => 'Item ${i + 1}');
  const vpStart = 8;
  const vpEnd = 12;
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _ppRoseMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _ppLightRose),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full list
        Expanded(
          child: Column(
            children: [
              _ppLabel('Full List (16 items)'),
              ...allItems.asMap().entries.map((e) {
                final inVp = e.key >= vpStart && e.key < vpEnd;
                return Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: inVp ? _ppBurgundy.withValues(alpha: 0.1) : _ppWhite,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                        color: inVp ? _ppBurgundy : _ppLightRose),
                  ),
                  child: Text(e.value,
                      style: TextStyle(
                          color: inVp ? _ppBurgundy : _ppGray,
                          fontSize: 9,
                          fontWeight:
                              inVp ? FontWeight.w700 : FontWeight.w400)),
                );
              }),
            ],
          ),
        ),
        const SizedBox(width: 10),
        // Viewport
        Expanded(
          child: Column(
            children: [
              _ppLabel('Viewport (4 visible)'),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _ppWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _ppBurgundy, width: 2),
                ),
                child: Column(
                  children: allItems
                      .sublist(vpStart, vpEnd)
                      .asMap()
                      .entries
                      .map((e) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _ppBurgundy.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(allItems[vpStart + e.key],
                          style: const TextStyle(
                              color: _ppDarkBurgundy,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _ppBurgundy.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('pageSize = 4',
                    style: TextStyle(
                        color: _ppBurgundy,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Jump arithmetic
// ─────────────────────────────────────────────────────────────
Widget _buildJumpArithmetic() {
  final jumps = <Map<String, dynamic>>[
    {'from': 18, 'page': 5, 'to': 13, 'note': '18 - 5 = 13'},
    {'from': 13, 'page': 5, 'to': 8, 'note': '13 - 5 = 8'},
    {'from': 8, 'page': 5, 'to': 3, 'note': '8 - 5 = 3'},
    {'from': 3, 'page': 5, 'to': 0, 'note': '3 - 5 → clamp to 0'},
  ];
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _ppRoseMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _ppLightRose),
    ),
    child: Column(
      children: [
        Row(
          children: [
            const Expanded(
                flex: 2,
                child: Text('From',
                    style: TextStyle(
                        color: _ppDarkBurgundy,
                        fontSize: 10,
                        fontWeight: FontWeight.w700))),
            const Expanded(
                flex: 2,
                child: Text('Jump',
                    style: TextStyle(
                        color: _ppDarkBurgundy,
                        fontSize: 10,
                        fontWeight: FontWeight.w700))),
            const Expanded(
                flex: 2,
                child: Text('To',
                    style: TextStyle(
                        color: _ppDarkBurgundy,
                        fontSize: 10,
                        fontWeight: FontWeight.w700))),
            Expanded(
                flex: 4,
                child: Text('Calculation',
                    style: TextStyle(
                        color: _ppDarkBurgundy.withValues(alpha: 0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.w700))),
          ],
        ),
        _ppDivider(),
        ...jumps.asMap().entries.map((entry) {
          final j = entry.value;
          final isClamped = (j['note'] as String).contains('clamp');
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: _ppLightRose.withValues(alpha: 0.4))),
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text('#${j['from']}',
                        style: const TextStyle(
                            color: _ppBurgundy,
                            fontSize: 11,
                            fontWeight: FontWeight.w700))),
                Expanded(
                    flex: 2,
                    child: Text('-${j['page']}',
                        style: const TextStyle(
                            color: _ppAccentOrange,
                            fontSize: 11,
                            fontWeight: FontWeight.w700))),
                Expanded(
                    flex: 2,
                    child: Text('#${j['to']}',
                        style: TextStyle(
                            color: isClamped
                                ? _ppAccentOrange
                                : _ppAccentGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.w700))),
                Expanded(
                    flex: 4,
                    child: Text(j['note'] as String,
                        style: TextStyle(
                            color: isClamped
                                ? _ppAccentOrange
                                : _ppGray.withValues(alpha: 0.7),
                            fontSize: 10,
                            fontFamily: 'monospace'))),
              ],
            ),
          );
        }),
        const SizedBox(height: 8),
        _buildJumpVisualBar(20, [18, 13, 8, 3, 0]),
      ],
    ),
  );
}

Widget _buildJumpVisualBar(int total, List<int> positions) {
  return SizedBox(
    height: 28,
    child: Row(
      children: List.generate(total, (i) {
        final isPos = positions.contains(i);
        final posIdx = positions.indexOf(i);
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            decoration: BoxDecoration(
              color: isPos ? _ppBurgundy : _ppLightRose.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(2),
            ),
            alignment: Alignment.center,
            child: isPos
                ? Text('${posIdx + 1}',
                    style: const TextStyle(
                        color: _ppWhite,
                        fontSize: 8,
                        fontWeight: FontWeight.w700))
                : null,
          ),
        );
      }),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 4: Backward comparison
// ─────────────────────────────────────────────────────────────
Widget _buildBackwardComparison() {
  final strategies = <Map<String, dynamic>>[
    {
      'name': '↑ Single step',
      'keys': 15,
      'color': _ppGray,
      'desc': '15 presses of ↑',
    },
    {
      'name': 'PgUp Page jump',
      'keys': 3,
      'color': _ppBurgundy,
      'desc': '3 PgUp + 0 ↑ adjustments',
    },
    {
      'name': 'Combined PgUp + ↑',
      'keys': 4,
      'color': _ppAccentGreen,
      'desc': '2 PgUp + 2 ↑ fine-tune',
    },
  ];
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _ppRoseMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _ppLightRose),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Goal: index 18 → index 3 (backward 15 positions)',
            style: TextStyle(
                color: _ppDarkBurgundy,
                fontSize: 11,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        ...strategies.map((s) {
          final maxKeys = 15;
          final barWidth = (s['keys'] as int) / maxKeys;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: s['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(s['name'] as String,
                        style: TextStyle(
                            color: s['color'] as Color,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 4),
                Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: _ppWhite,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: barWidth,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: (s['color'] as Color).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 6),
                        child: Text('${s['keys']} keystrokes',
                            style: TextStyle(
                                color: s['color'] as Color,
                                fontSize: 9,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
                Text(s['desc'] as String,
                    style: TextStyle(
                        color: _ppGray.withValues(alpha: 0.7), fontSize: 10)),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 5: Boundary visual
// ─────────────────────────────────────────────────────────────
Widget _buildBoundaryVisual() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _ppRoseMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _ppLightRose),
    ),
    child: Column(
      children: [
        _ppLabel('Current: index 2, pageSize: 5'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _ppAccentGreen.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _ppAccentGreen.withValues(alpha: 0.3)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.vertical_align_top,
                        color: _ppAccentGreen, size: 24),
                    SizedBox(height: 4),
                    Text('Clamp Strategy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _ppAccentGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 2),
                    Text('→ index 0',
                        style: TextStyle(
                            color: _ppAccentGreen,
                            fontSize: 10,
                            fontFamily: 'monospace')),
                    Text('Stops at top',
                        style: TextStyle(
                            color: _ppAccentGreen,
                            fontSize: 9)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _ppAccentOrange.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _ppAccentOrange.withValues(alpha: 0.3)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.loop, color: _ppAccentOrange, size: 24),
                    SizedBox(height: 4),
                    Text('Wrap Strategy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _ppAccentOrange,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 2),
                    Text('→ index 17',
                        style: TextStyle(
                            color: _ppAccentOrange,
                            fontSize: 10,
                            fontFamily: 'monospace')),
                    Text('Cycles to end',
                        style: TextStyle(
                            color: _ppAccentOrange,
                            fontSize: 9)),
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

// ─────────────────────────────────────────────────────────────
// Section 6: Platform bindings
// ─────────────────────────────────────────────────────────────
List<Widget> _buildPlatformBindingsCards() {
  final platforms = <Map<String, dynamic>>[
    {'platform': 'macOS', 'key': 'Fn+↑ (Page Up)', 'alt': 'Ctrl+Shift+P', 'icon': Icons.desktop_mac},
    {'platform': 'Windows', 'key': 'Page Up', 'alt': '—', 'icon': Icons.desktop_windows},
    {'platform': 'Linux', 'key': 'Page Up', 'alt': 'Ctrl+Shift+P', 'icon': Icons.computer},
    {'platform': 'Web', 'key': 'Page Up', 'alt': 'Follows host OS', 'icon': Icons.language},
  ];
  return platforms.map((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _ppRoseMist,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _ppLightRose.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(p['icon'] as IconData, size: 18, color: _ppBurgundy),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['platform'] as String,
                    style: const TextStyle(
                        color: _ppDarkBurgundy,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    Text('Primary: ${p['key']}',
                        style: const TextStyle(
                            color: _ppGray, fontSize: 10)),
                    const SizedBox(width: 10),
                    Text('Alt: ${p['alt']}',
                        style: TextStyle(
                            color: _ppGray.withValues(alpha: 0.7),
                            fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 7: Scroll sync diagram
// ─────────────────────────────────────────────────────────────
Widget _buildScrollSyncDiagram() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _ppRoseMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _ppLightRose),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _ppLabel('Before PgUp'),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _ppWhite,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _ppLightRose),
                    ),
                    child: Column(
                      children: [
                        _buildScrollItem('Item 14', false),
                        _buildScrollItem('Item 15', true),
                        _buildScrollItem('Item 16', false),
                        _buildScrollItem('Item 17', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Highlight: #15',
                      style: TextStyle(
                          color: _ppBurgundy,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Column(
              children: [
                const Icon(Icons.keyboard_double_arrow_up,
                    color: _ppBurgundy, size: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _ppBurgundy.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('PgUp',
                      style: TextStyle(
                          color: _ppBurgundy,
                          fontSize: 9,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  _ppLabel('After PgUp'),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _ppWhite,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _ppBurgundy, width: 2),
                    ),
                    child: Column(
                      children: [
                        _buildScrollItem('Item 10', false),
                        _buildScrollItem('Item 11', true),
                        _buildScrollItem('Item 12', false),
                        _buildScrollItem('Item 13', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Highlight: #11',
                      style: TextStyle(
                          color: _ppAccentGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _ppCodeBlock(
          'scrollController.animateTo(\n'
          '  newIndex * itemHeight,\n'
          '  duration: Duration(milliseconds: 200),\n'
          '  curve: Curves.easeOut,\n'
          ');',
        ),
      ],
    ),
  );
}

Widget _buildScrollItem(String label, bool isHighlighted) {
  return Container(
    margin: const EdgeInsets.only(bottom: 3),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: isHighlighted ? _ppBurgundy : _ppRoseMist,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(label,
        style: TextStyle(
            color: isHighlighted ? _ppWhite : _ppDarkBurgundy,
            fontSize: 10,
            fontWeight:
                isHighlighted ? FontWeight.w700 : FontWeight.w400)),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 8: Full matrix
// ─────────────────────────────────────────────────────────────
Widget _buildFullMatrix() {
  final cells = <List<String>>[
    ['', 'Forward ↓', 'Backward ↑'],
    ['Single', 'NextOption', 'PreviousOption'],
    ['Page', 'NextPageOption', 'PreviousPageOption ★'],
    ['Boundary', 'LastOption', 'FirstOption'],
  ];
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _ppLightRose),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: cells.asMap().entries.map((rowEntry) {
        final isHeader = rowEntry.key == 0;
        final row = rowEntry.value;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: isHeader
              ? _ppBurgundy
              : rowEntry.key.isEven
                  ? _ppRoseMist
                  : _ppWhite,
          child: Row(
            children: row.asMap().entries.map((colEntry) {
              final isStarred = colEntry.value.contains('★');
              return Expanded(
                flex: colEntry.key == 0 ? 2 : 3,
                child: Text(colEntry.value,
                    style: TextStyle(
                        color: isHeader
                            ? _ppWhite
                            : isStarred
                                ? _ppBurgundy
                                : _ppGray,
                        fontSize: 11,
                        fontWeight: isHeader || isStarred
                            ? FontWeight.w700
                            : FontWeight.w400)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 9: Timezone picker
// ─────────────────────────────────────────────────────────────
Widget _buildTimezonePickerDemo() {
  final zones = [
    'Africa/Cairo', 'Africa/Lagos', 'America/Chicago',
    'America/Denver', 'America/Los_Angeles', 'America/New_York',
    'Asia/Dubai', 'Asia/Kolkata', 'Asia/Shanghai',
    'Asia/Tokyo', 'Europe/Berlin', 'Europe/London',
    'Europe/Paris', 'Pacific/Auckland', 'Pacific/Honolulu',
  ];
  const hlIdx = 5; // After PgDn + PgDn, then PgUp back to New_York

  return Container(
    decoration: BoxDecoration(
      color: _ppWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _ppLightRose),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: _ppRoseMist,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              const Icon(Icons.schedule, color: _ppBurgundy, size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('Select timezone: America|',
                    style: TextStyle(
                        color: _ppDarkBurgundy,
                        fontSize: 12,
                        fontFamily: 'monospace')),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _ppBurgundy.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('PgDn×2 PgUp×1',
                    style: TextStyle(
                        color: _ppBurgundy,
                        fontSize: 9,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 210,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: zones.length,
            itemBuilder: (context, i) {
              final isHl = i == hlIdx;
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isHl ? _ppBurgundy : _ppWhite,
                  border: Border(
                      bottom: BorderSide(
                          color: _ppLightRose.withValues(alpha: 0.3))),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text('${i + 1}',
                          style: TextStyle(
                              color: isHl
                                  ? _ppWhite.withValues(alpha: 0.7)
                                  : _ppGray.withValues(alpha: 0.5),
                              fontSize: 9,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(zones[i],
                          style: TextStyle(
                              color: isHl ? _ppWhite : _ppDarkBurgundy,
                              fontSize: 12,
                              fontWeight: isHl
                                  ? FontWeight.w700
                                  : FontWeight.w400)),
                    ),
                    if (isHl)
                      const Icon(Icons.check_circle,
                          size: 14, color: _ppWhite),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: _ppRoseMist,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: const Text(
              'PgDn jumped to Asia group, PgUp returned to America',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _ppBurgundy,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Font browser
// ─────────────────────────────────────────────────────────────
Widget _buildFontBrowserDemo() {
  final fonts = [
    'Abril Fatface', 'Bebas Neue', 'Crimson Text', 'Dancing Script',
    'EB Garamond', 'Fira Code', 'Garamond Premier', 'Helvetica Neue',
    'Inconsolata', 'JetBrains Mono', 'Karla', 'Lato',
    'Merriweather', 'Noto Sans', 'Open Sans', 'Playfair Display',
  ];
  const hlIdx = 5; // After PgDn past monospace group, PgUp back

  return Container(
    decoration: BoxDecoration(
      color: _ppWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _ppLightRose),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: _ppRoseMist,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: const Row(
            children: [
              Icon(Icons.text_fields, color: _ppBurgundy, size: 18),
              SizedBox(width: 8),
              Text('Font family: F|',
                  style: TextStyle(
                      color: _ppDarkBurgundy,
                      fontSize: 12,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
        ...fonts.sublist(3, 9).asMap().entries.map((e) {
          final actualIdx = e.key + 3;
          final isHl = actualIdx == hlIdx;
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isHl ? _ppBurgundy.withValues(alpha: 0.1) : _ppWhite,
              border: Border(
                  bottom: BorderSide(
                      color: _ppLightRose.withValues(alpha: 0.3))),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  child: Text('${actualIdx + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: isHl
                              ? _ppBurgundy
                              : _ppGray.withValues(alpha: 0.5),
                          fontSize: 9)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fonts[actualIdx],
                          style: TextStyle(
                              color: isHl
                                  ? _ppBurgundy
                                  : _ppDarkBurgundy,
                              fontSize: 13,
                              fontWeight: isHl
                                  ? FontWeight.w700
                                  : FontWeight.w500)),
                      Text('The quick brown fox jumps over the lazy dog',
                          style: TextStyle(
                              color: _ppGray.withValues(alpha: 0.5),
                              fontSize: 10)),
                    ],
                  ),
                ),
                if (isHl)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _ppBurgundy,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text('◄ PgUp',
                        style: TextStyle(
                            color: _ppWhite,
                            fontSize: 9,
                            fontWeight: FontWeight.w700)),
                  ),
              ],
            ),
          );
        }),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: _ppRoseMist,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ppKeyHint('PgUp', 'Prev page'),
              const SizedBox(width: 10),
              _ppKeyHint('PgDn', 'Next page'),
              const SizedBox(width: 10),
              _ppKeyHint('↑', 'Prev'),
              const SizedBox(width: 10),
              _ppKeyHint('↓', 'Next'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _ppKeyHint(String key, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: _ppWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _ppLightRose),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0F880E4F),
                blurRadius: 2,
                offset: Offset(0, 1)),
          ],
        ),
        child: Text(key,
            style: const TextStyle(
                color: _ppDarkBurgundy,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace')),
      ),
      const SizedBox(width: 4),
      Text(label,
          style: const TextStyle(color: _ppGray, fontSize: 9.5)),
    ],
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Efficiency chart
// ─────────────────────────────────────────────────────────────
Widget _buildEfficiencyChart() {
  final methods = <Map<String, dynamic>>[
    {'name': 'Arrow ↑ only', 'keys': 15, 'bar': 1.0, 'color': _ppGray},
    {'name': 'PgUp only', 'keys': 4, 'bar': 0.27, 'color': _ppBurgundy},
    {'name': 'PgUp + ↑', 'keys': 4, 'bar': 0.27, 'color': _ppAccentTeal},
    {'name': 'Home + ↓×3', 'keys': 4, 'bar': 0.27, 'color': _ppAccentIndigo},
  ];
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _ppRoseMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _ppLightRose),
    ),
    child: Column(
      children: methods.map((m) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: 85,
                child: Text(m['name'] as String,
                    style: TextStyle(
                        color: m['color'] as Color,
                        fontSize: 10,
                        fontWeight: FontWeight.w600)),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 22,
                      decoration: BoxDecoration(
                        color: _ppWhite,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: m['bar'] as double,
                      child: Container(
                        height: 22,
                        decoration: BoxDecoration(
                          color:
                              (m['color'] as Color).withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: (m['color'] as Color)
                                  .withValues(alpha: 0.5)),
                        ),
                        alignment: Alignment.center,
                        child: Text('${m['keys']} keys',
                            style: TextStyle(
                                color: m['color'] as Color,
                                fontSize: 9,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _ppSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _ppWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _ppWhite.withValues(alpha: 0.95),
                  fontSize: 12.5)),
        ),
      ],
    ),
  );
}

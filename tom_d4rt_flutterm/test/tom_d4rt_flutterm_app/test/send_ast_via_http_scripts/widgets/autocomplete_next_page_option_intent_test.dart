// ignore_for_file: avoid_print
// Deep demo: AutocompleteNextPageOptionIntent — jump forward by a page
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Steel Teal / Frost
// ─────────────────────────────────────────────────────────────
const Color _npTeal = Color(0xFF00695C);
const Color _npFrost = Color(0xFFE0F2F1);
const Color _npDarkTeal = Color(0xFF003D33);
const Color _npMedTeal = Color(0xFF00897B);
const Color _npLightTeal = Color(0xFF80CBC4);
const Color _npWhite = Color(0xFFFFFFFF);
const Color _npGray = Color(0xFF546E7A);
const Color _npAccentOrange = Color(0xFFE65100);
const Color _npAccentBlue = Color(0xFF1565C0);
const Color _npAccentGreen = Color(0xFF2E7D32);
const Color _npAccentAmber = Color(0xFFFF8F00);
const Color _npAccentRed = Color(0xFFC62828);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _npSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _npWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _npLightTeal, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x1A00695C), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _npTeal,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _npWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _npLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _npDarkTeal,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _npBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _npGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _npCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF0F7F6),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _npLightTeal.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _npDarkTeal,
            height: 1.45)),
  );
}

Widget _npChip(String text, Color bg, Color fg) {
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

Widget _npDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _npLightTeal.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: AutocompleteNextPageOptionIntent');
  print('  Jump forward by one page in autocomplete results');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _npFrost,
      appBarTheme: const AppBarTheme(
        backgroundColor: _npTeal,
        foregroundColor: _npWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutocompleteNextPageOptionIntent',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
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
                  colors: [_npDarkTeal, _npTeal, _npMedTeal],
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
                      color: _npWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.keyboard_double_arrow_down,
                        color: _npWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('AutocompleteNextPageOptionIntent',
                      style: TextStyle(
                          color: _npWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Rapid traversal of long autocomplete lists',
                      style: TextStyle(
                          color: _npWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _npChip('Intent', _npWhite.withValues(alpha: 0.25), _npWhite),
                      _npChip('Page Jump', _npWhite.withValues(alpha: 0.25), _npWhite),
                      _npChip('Page Down', _npWhite.withValues(alpha: 0.25), _npWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is AutocompleteNextPageOptionIntent?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('1 · What Is NextPageOptionIntent?', [
              _npBody(
                'AutocompleteNextPageOptionIntent is an Intent subclass that '
                'represents a request to jump forward by an entire page of '
                'options in an Autocomplete dropdown. Unlike NextOptionIntent '
                'which moves one item at a time, this intent leaps over '
                'multiple items in a single keystroke—essential for navigating '
                'long lists efficiently.',
              ),
              _npLabel('Class hierarchy'),
              _npCodeBlock(
                'Intent  (abstract base)\n'
                '  └─ AutocompleteNextPageOptionIntent\n'
                '       • Concrete, no extra fields\n'
                '       • const constructor\n'
                '       • Paired with matching Action inside Autocomplete<T>',
              ),
              _npDivider(),
              _npLabel('When this intent matters'),
              _npBody(
                'Most autocomplete dropdowns display 5-10 visible items. With '
                'a list of 200+ options (like a country picker or font '
                'selector), pressing ↓ two hundred times is impractical. '
                'Page Down covers the visible window in one jump.',
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _npFrost,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _npLightTeal),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.arrow_downward,
                              color: _npGray, size: 20),
                          const SizedBox(height: 4),
                          const Text('NextOption',
                              style: TextStyle(
                                  color: _npGray,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          Text('+1 step',
                              style: TextStyle(
                                  color: _npGray.withValues(alpha: 0.7),
                                  fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('vs',
                        style: TextStyle(
                            color: _npGray,
                            fontWeight: FontWeight.w600)),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _npTeal.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _npTeal, width: 2),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.keyboard_double_arrow_down,
                              color: _npTeal, size: 20),
                          const SizedBox(height: 4),
                          const Text('NextPageOption',
                              style: TextStyle(
                                  color: _npTeal,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          Text('+pageSize steps',
                              style: TextStyle(
                                  color: _npTeal.withValues(alpha: 0.8),
                                  fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Page Size Calculation
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('2 · How Page Size Is Determined', [
              _npBody(
                'The "page" in NextPageOption is defined by how many items '
                'are visible in the dropdown viewport. This is calculated from '
                'the overlay height and individual option height.',
              ),
              _npLabel('Calculation formula'),
              _npCodeBlock(
                'pageSize = (viewportHeight / optionHeight).floor();\n'
                '\n'
                '// Example:\n'
                '//   viewportHeight = 250 px\n'
                '//   optionHeight   = 48 px\n'
                '//   pageSize       = (250 / 48).floor() = 5\n'
                '\n'
                '// Result: Page Down jumps 5 options forward',
              ),
              _npDivider(),
              _npLabel('Visual: viewport vs page size'),
              ..._buildViewportDiagram(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Jump Arithmetic
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('3 · Jump Arithmetic with Long Lists', [
              _npBody(
                'With 20 items and a page size of 5, the intent navigates '
                'in jumps that can be tracked precisely.',
              ),
              _npLabel('Jumping through 20 items (pageSize=5)'),
              ..._buildJumpArithmeticVisual(),
              _npDivider(),
              _npCodeBlock(
                'nextIndex = min(currentIndex + pageSize, lastIndex);\n'
                '// If already at/near end, wraps to:\n'
                'nextIndex = (currentIndex + pageSize) % options.length;\n'
                '\n'
                '// Example with pageSize=5, 20 options:\n'
                '//   current=0   →  next=5\n'
                '//   current=5   →  next=10\n'
                '//   current=15  →  next=0 (or 19, impl-dependent)',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Single Step vs Page Jump
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('4 · Single Step vs Page Jump — Visual', [
              _npBody(
                'A side-by-side comparison showing how many keystrokes it '
                'takes to reach the same target item.',
              ),
              _buildSideBySideComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Page Boundary Wrapping
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('5 · Boundary Behavior at List End', [
              _npBody(
                'When a page jump would exceed the list, the behavior depends '
                'on the implementation: clamp to last, or wrap around. '
                'Flutter\'s default Autocomplete wraps circularly.',
              ),
              _npLabel('Scenario: 12 items, pageSize=5, at index 10'),
              ..._buildBoundaryScenarios(),
              _npDivider(),
              _npBody(
                'The wrapping behavior ensures users can always reach any '
                'item with repeated Page Down presses.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Key Binding Details
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('6 · Key Bindings Across Platforms', [
              _npBody(
                'NextPageOptionIntent is mapped to Page Down on desktop '
                'platforms. Mobile platforms typically don\'t use this intent '
                'directly since dropdowns are touch-scrolled.',
              ),
              ..._buildKeyBindingCards(),
              _npDivider(),
              _npLabel('Custom binding example'),
              _npCodeBlock(
                '// Add Shift+↓ as page-jump shortcut\n'
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    const SingleActivator(\n'
                '      LogicalKeyboardKey.arrowDown,\n'
                '      shift: true,\n'
                '    ): AutocompleteNextPageOptionIntent(),\n'
                '    const SingleActivator(\n'
                '      LogicalKeyboardKey.pageDown,\n'
                '    ): AutocompleteNextPageOptionIntent(),\n'
                '  },\n'
                '  child: myAutocomplete,\n'
                ')',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Scroll position relationship
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('7 · Scroll Position & Viewport Sync', [
              _npBody(
                'When a page jump moves the highlight beyond the visible '
                'viewport, the options list must scroll to keep the '
                'highlighted item visible. This scroll-sync happens '
                'automatically via the overlay builder.',
              ),
              _npLabel('Scroll behavior'),
              _buildScrollDiagram(),
              _npDivider(),
              _npCodeBlock(
                '// Inside optionsViewBuilder:\n'
                'if (highlighted != null) {\n'
                '  final offset = highlighted * itemHeight;\n'
                '  scrollController.animateTo(\n'
                '    offset,\n'
                '    duration: Duration(milliseconds: 200),\n'
                '    curve: Curves.easeOut,\n'
                '  );\n'
                '}',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Comparison matrix — all nav intents
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('8 · Full Navigation Intent Matrix', [
              _npBody(
                'All six autocomplete intents placed on a direction × granularity '
                'grid.',
              ),
              _buildNavigationMatrix(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Country picker scenario
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('9 · Real-World: Country Picker', [
              _npBody(
                'A country picker with 195 entries. Page Down jumps through '
                'the alphabet efficiently without hundreds of arrow presses.',
              ),
              _buildCountryPickerDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Simulated Long-List Dropdown
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('10 · Simulated Long-List Dropdown', [
              _npBody(
                'A font selector showing 30 fonts. After two Page Down '
                'presses (pageSize=6), the highlight jumps to index 12.',
              ),
              _buildFontSelectorDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Keystroke efficiency
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('11 · Keystroke Efficiency Analysis', [
              _npBody(
                'Comparing keystrokes needed to reach item #50 in a 200-item '
                'list using different intent strategies.',
              ),
              _buildEfficiencyChart(),
              _npDivider(),
              _npBody(
                'Power users combine Page Down with single ↓ for precision: '
                'jump near the target, then fine-tune with arrow keys.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _npSection('12 · Summary', [
              _npBody(
                'AutocompleteNextPageOptionIntent is the essential navigation '
                'accelerator for autocomplete lists with many entries.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_npTeal, _npMedTeal],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _npSummaryRow(Icons.keyboard_double_arrow_down,
                        'Jumps forward by one viewport page'),
                    _npSummaryRow(Icons.calculate,
                        'Page size = viewport height / item height'),
                    _npSummaryRow(Icons.keyboard,
                        'Mapped to Page Down by default'),
                    _npSummaryRow(Icons.loop,
                        'Wraps around at list boundaries'),
                    _npSummaryRow(Icons.speed,
                        'Reduces keystrokes for long lists dramatically'),
                    _npSummaryRow(Icons.accessible,
                        'Critical for accessible navigation of large datasets'),
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
List<Widget> _buildViewportDiagram() {
  final allItems = List.generate(12, (i) => 'Option ${i + 1}');
  return [
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _npFrost,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _npLightTeal),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: full list
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Full List (12 items)',
                    style: TextStyle(
                        color: _npDarkTeal,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                ...allItems.asMap().entries.map((entry) {
                  final inViewport = entry.key < 5;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: inViewport
                          ? _npTeal.withValues(alpha: 0.12)
                          : _npWhite,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          color: inViewport
                              ? _npTeal.withValues(alpha: 0.3)
                              : _npLightTeal.withValues(alpha: 0.3)),
                    ),
                    child: Text(entry.value,
                        style: TextStyle(
                            color: inViewport ? _npDarkTeal : _npGray,
                            fontSize: 9.5)),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Right: viewport bracket
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Viewport',
                    style: TextStyle(
                        color: _npTeal,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _npTeal.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _npTeal, width: 2),
                  ),
                  child: Column(
                    children: List.generate(5, (i) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: _npWhite,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text('Option ${i + 1}',
                            style: const TextStyle(
                                color: _npDarkTeal, fontSize: 9.5)),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _npAccentOrange.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _npAccentOrange),
                  ),
                  child: const Text(
                    'pageSize = 5\n'
                    '1 Page Down = 5 items',
                    style: TextStyle(
                        color: _npAccentOrange,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ];
}

// ─────────────────────────────────────────────────────────────
// Section 3: Jump arithmetic visual
// ─────────────────────────────────────────────────────────────
List<Widget> _buildJumpArithmeticVisual() {
  final jumps = <Map<String, dynamic>>[
    {'press': 'PgDn #1', 'from': 0, 'to': 5},
    {'press': 'PgDn #2', 'from': 5, 'to': 10},
    {'press': 'PgDn #3', 'from': 10, 'to': 15},
    {'press': 'PgDn #4', 'from': 15, 'to': 0},
  ];
  return [
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _npFrost,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _npLightTeal),
      ),
      child: Column(
        children: jumps.map((j) {
          final isWrap = (j['from'] as int) > (j['to'] as int);
          return Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isWrap
                  ? _npAccentAmber.withValues(alpha: 0.08)
                  : _npWhite,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: isWrap ? _npAccentAmber : _npLightTeal),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Text(j['press'] as String,
                      style: TextStyle(
                          color: isWrap ? _npAccentAmber : _npTeal,
                          fontWeight: FontWeight.w700,
                          fontSize: 11)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _npGray.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('idx ${j['from']}',
                      style: const TextStyle(
                          color: _npGray,
                          fontSize: 10,
                          fontFamily: 'monospace')),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.arrow_forward,
                      size: 14, color: _npTeal),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _npTeal.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('idx ${j['to']}',
                      style: const TextStyle(
                          color: _npTeal,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace')),
                ),
                if (isWrap) ...[
                  const Spacer(),
                  _npChip('WRAP', _npAccentAmber, _npWhite),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    ),
  ];
}

// ─────────────────────────────────────────────────────────────
// Section 4: Side-by-side comparison
// ─────────────────────────────────────────────────────────────
Widget _buildSideBySideComparison() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _npFrost,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _npLightTeal),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Arrow Down side
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _npGray.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.arrow_downward, color: _npGray, size: 20),
                    SizedBox(height: 4),
                    Text('Arrow ↓',
                        style: TextStyle(
                            color: _npGray,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(10, (i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _npWhite,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                        color: _npLightTeal.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${i + 1}',
                          style: const TextStyle(
                              color: _npGray,
                              fontSize: 9,
                              fontFamily: 'monospace')),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_downward,
                          size: 8,
                          color: _npGray.withValues(alpha: 0.5)),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 4),
              const Text('10 keystrokes to item 10',
                  style: TextStyle(
                      color: _npAccentRed,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Page Down side
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _npTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _npTeal),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.keyboard_double_arrow_down,
                        color: _npTeal, size: 20),
                    SizedBox(height: 4),
                    Text('Page Down',
                        style: TextStyle(
                            color: _npTeal,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _npTeal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: _npTeal),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('1',
                        style: TextStyle(
                            color: _npTeal,
                            fontSize: 9,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700)),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_double_arrow_down,
                        size: 8, color: _npTeal),
                    SizedBox(width: 2),
                    Text('+5',
                        style: TextStyle(
                            color: _npTeal,
                            fontSize: 8,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _npTeal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: _npTeal),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('2',
                        style: TextStyle(
                            color: _npTeal,
                            fontSize: 9,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700)),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_double_arrow_down,
                        size: 8, color: _npTeal),
                    SizedBox(width: 2),
                    Text('+5',
                        style: TextStyle(
                            color: _npTeal,
                            fontSize: 8,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('2 keystrokes to item 10',
                  style: TextStyle(
                      color: _npAccentGreen,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
              const Text('5× more efficient',
                  style: TextStyle(
                      color: _npTeal,
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 5: Boundary scenarios
// ─────────────────────────────────────────────────────────────
List<Widget> _buildBoundaryScenarios() {
  final scenarios = <Map<String, dynamic>>[
    {
      'title': 'Clamp strategy',
      'desc': 'Jump to last item, then stop',
      'from': 10,
      'result': 11,
      'resultLabel': 'idx 11 (last)',
      'color': _npAccentBlue,
    },
    {
      'title': 'Wrap strategy (Flutter default)',
      'desc': 'Overflow wraps to beginning',
      'from': 10,
      'result': 3,
      'resultLabel': 'idx 3 (wrapped)',
      'color': _npTeal,
    },
  ];
  return scenarios.map((s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (s['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s['title'] as String,
              style: TextStyle(
                  color: s['color'] as Color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12)),
          Text(s['desc'] as String,
              style: const TextStyle(color: _npGray, fontSize: 11)),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _npGray.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('idx ${s['from']}',
                    style: const TextStyle(
                        color: _npGray,
                        fontSize: 10.5,
                        fontFamily: 'monospace')),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text('+ PgDn(5) →',
                    style: TextStyle(color: _npGray, fontSize: 10)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (s['color'] as Color).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(s['resultLabel'] as String,
                    style: TextStyle(
                        color: s['color'] as Color,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace')),
              ),
            ],
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 6: Key binding cards
// ─────────────────────────────────────────────────────────────
List<Widget> _buildKeyBindingCards() {
  final bindings = <Map<String, dynamic>>[
    {
      'platform': 'macOS',
      'key': 'Page Down (Fn+↓)',
      'icon': Icons.desktop_mac,
    },
    {
      'platform': 'Windows',
      'key': 'Page Down',
      'icon': Icons.desktop_windows,
    },
    {
      'platform': 'Linux',
      'key': 'Page Down',
      'icon': Icons.computer,
    },
    {
      'platform': 'Web',
      'key': 'Page Down (host OS)',
      'icon': Icons.language,
    },
  ];
  return bindings.map((b) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _npFrost,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _npLightTeal.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(b['icon'] as IconData, size: 20, color: _npTeal),
          const SizedBox(width: 10),
          Text(b['platform'] as String,
              style: const TextStyle(
                  color: _npDarkTeal,
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _npWhite,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _npLightTeal),
            ),
            child: Text(b['key'] as String,
                style: const TextStyle(
                    color: _npDarkTeal,
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 7: Scroll diagram
// ─────────────────────────────────────────────────────────────
Widget _buildScrollDiagram() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _npFrost,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _npLightTeal),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Before
            Expanded(
              child: Column(
                children: [
                  const Text('Before PgDn',
                      style: TextStyle(
                          color: _npGray,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  ...List.generate(5, (i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: i == 0
                            ? _npTeal.withValues(alpha: 0.15)
                            : _npWhite,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                            color: i == 0 ? _npTeal : _npLightTeal),
                      ),
                      child: Text('Item ${i + 1}',
                          style: TextStyle(
                              color: i == 0 ? _npTeal : _npGray,
                              fontSize: 9.5,
                              fontWeight: i == 0
                                  ? FontWeight.w700
                                  : FontWeight.w400)),
                    );
                  }),
                  const Text('▽ highlight at idx 0',
                      style: TextStyle(
                          color: _npGray, fontSize: 9)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Icon(Icons.arrow_forward,
                  color: _npTeal, size: 20),
            ),
            // After
            Expanded(
              child: Column(
                children: [
                  const Text('After PgDn',
                      style: TextStyle(
                          color: _npTeal,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  ...List.generate(5, (i) {
                    final itemIdx = i + 5;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: i == 0
                            ? _npTeal.withValues(alpha: 0.15)
                            : _npWhite,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                            color: i == 0 ? _npTeal : _npLightTeal),
                      ),
                      child: Text('Item ${itemIdx + 1}',
                          style: TextStyle(
                              color: i == 0 ? _npTeal : _npGray,
                              fontSize: 9.5,
                              fontWeight: i == 0
                                  ? FontWeight.w700
                                  : FontWeight.w400)),
                    );
                  }),
                  const Text('▽ highlight at idx 5',
                      style: TextStyle(
                          color: _npTeal, fontSize: 9)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _npAccentAmber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _npAccentAmber.withValues(alpha: 0.3)),
          ),
          child: const Text(
            'Viewport scrolls so highlighted item stays visible',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _npAccentAmber,
                fontSize: 10.5,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 8: Navigation matrix
// ─────────────────────────────────────────────────────────────
Widget _buildNavigationMatrix() {
  final rows = <List<String>>[
    ['', 'Forward ↓', 'Backward ↑'],
    ['Single', 'NextOption', 'PreviousOption'],
    ['Page', 'NextPageOption ★', 'PreviousPageOption'],
    ['Boundary', 'LastOption', 'FirstOption'],
  ];
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _npLightTeal),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        final row = entry.value;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          color: isHeader
              ? _npTeal
              : entry.key.isEven
                  ? _npFrost
                  : _npWhite,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(row[0],
                      style: TextStyle(
                          color: isHeader ? _npWhite : _npDarkTeal,
                          fontSize: 11,
                          fontWeight: FontWeight.w700))),
              Expanded(
                  flex: 3,
                  child: Text(row[1],
                      style: TextStyle(
                          color: isHeader
                              ? _npWhite
                              : row[1].contains('★')
                                  ? _npTeal
                                  : _npGray,
                          fontSize: 11,
                          fontWeight: row[1].contains('★')
                              ? FontWeight.w800
                              : isHeader
                                  ? FontWeight.w700
                                  : FontWeight.w400))),
              Expanded(
                  flex: 3,
                  child: Text(row[2],
                      style: TextStyle(
                          color: isHeader ? _npWhite : _npGray,
                          fontSize: 11,
                          fontWeight:
                              isHeader ? FontWeight.w700 : FontWeight.w400))),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 9: Country picker demo
// ─────────────────────────────────────────────────────────────
Widget _buildCountryPickerDemo() {
  final countries = [
    '🇦🇫 Afghanistan',
    '🇦🇱 Albania',
    '🇩🇿 Algeria',
    '🇦🇩 Andorra',
    '🇦🇴 Angola',
    '🇦🇷 Argentina',
    '🇦🇲 Armenia',
    '🇦🇺 Australia',
    '🇦🇹 Austria',
    '🇦🇿 Azerbaijan',
    '🇧🇸 Bahamas',
    '🇧🇭 Bahrain',
  ];
  const highlightIdx = 5; // After 1 PgDn with pageSize=5

  return Container(
    decoration: BoxDecoration(
      color: _npWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _npLightTeal),
    ),
    child: Column(
      children: [
        // Search field
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: _npFrost,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              const Icon(Icons.public, color: _npTeal, size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('A|',
                    style: TextStyle(
                        color: _npDarkTeal,
                        fontSize: 14,
                        fontFamily: 'monospace')),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _npTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('PgDn ×1',
                    style: TextStyle(
                        color: _npTeal,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        // Options list
        ...countries.asMap().entries.map((e) {
          final isHl = e.key == highlightIdx;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isHl ? _npTeal : _npWhite,
              border: Border(
                  bottom: BorderSide(
                      color: _npLightTeal.withValues(alpha: 0.3))),
            ),
            child: Row(
              children: [
                Text(e.value,
                    style: TextStyle(
                        color: isHl ? _npWhite : _npDarkTeal,
                        fontSize: 12,
                        fontWeight:
                            isHl ? FontWeight.w700 : FontWeight.w400)),
                if (isHl) ...[
                  const Spacer(),
                  const Icon(Icons.check, size: 14, color: _npWhite),
                ],
              ],
            ),
          );
        }),
        // Footer
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: _npFrost,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: const Text('Jumped from Afghanistan → Argentina in 1 press',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _npTeal,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Font selector demo
// ─────────────────────────────────────────────────────────────
Widget _buildFontSelectorDemo() {
  final fonts = [
    'Arial',
    'Avenir',
    'Baskerville',
    'Bodoni',
    'Calibri',
    'Cambria',
    'Courier New',
    'Didot',
    'Futura',
    'Garamond',
    'Georgia',
    'Gill Sans',
    'Helvetica',
    'Impact',
    'Lato',
    'Menlo',
    'Monaco',
    'Montserrat',
  ];
  const hlIdx = 12; // After 2 PgDn (pageSize=6)
  const viewStart = 10; // Scrolled viewport

  return Container(
    decoration: BoxDecoration(
      color: _npWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _npLightTeal),
    ),
    child: Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: _npFrost,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              const Icon(Icons.font_download, color: _npTeal, size: 18),
              const SizedBox(width: 8),
              const Text('Select Font',
                  style: TextStyle(
                      color: _npDarkTeal,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              _npChip('PgDn ×2', _npTeal, _npWhite),
            ],
          ),
        ),
        // Visible viewport (items 10-15)
        ...List.generate(6, (i) {
          final fontIdx = viewStart + i;
          if (fontIdx >= fonts.length) return const SizedBox.shrink();
          final isHl = fontIdx == hlIdx;
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isHl ? _npTeal : _npWhite,
              border: Border(
                  bottom: BorderSide(
                      color: _npLightTeal.withValues(alpha: 0.3))),
            ),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isHl
                        ? _npWhite.withValues(alpha: 0.2)
                        : _npFrost,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text('${fontIdx + 1}',
                      style: TextStyle(
                          color: isHl ? _npWhite : _npGray,
                          fontSize: 9,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 10),
                Text(fonts[fontIdx],
                    style: TextStyle(
                        color: isHl ? _npWhite : _npDarkTeal,
                        fontSize: 13,
                        fontWeight:
                            isHl ? FontWeight.w700 : FontWeight.w400)),
                if (isHl) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _npWhite.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text('Aa',
                        style: TextStyle(
                            color: _npWhite,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ],
            ),
          );
        }),
        // Scroll indicator
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: _npFrost,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Showing ${viewStart + 1}-${viewStart + 6} of ${fonts.length}',
                  style: const TextStyle(color: _npGray, fontSize: 10)),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: _npLightTeal,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  widthFactor: 6.0 / fonts.length,
                  alignment: Alignment(
                      -1.0 + 2.0 * viewStart / (fonts.length - 6), 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _npTeal,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Keystroke efficiency chart
// ─────────────────────────────────────────────────────────────
Widget _buildEfficiencyChart() {
  final methods = <Map<String, dynamic>>[
    {
      'method': 'Arrow ↓ only',
      'keystrokes': 50,
      'bar': 1.0,
      'color': _npAccentRed,
    },
    {
      'method': 'Page Down only',
      'keystrokes': 10,
      'bar': 0.2,
      'color': _npAccentAmber,
    },
    {
      'method': 'PgDn + Arrow ↓',
      'keystrokes': 5,
      'bar': 0.1,
      'color': _npTeal,
    },
    {
      'method': 'First + Arrow ↓ × 50',
      'keystrokes': 51,
      'bar': 1.02,
      'color': _npGray,
    },
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _npFrost,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _npLightTeal),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Keystrokes to reach item #50 (pageSize=5)',
            style: TextStyle(
                color: _npDarkTeal,
                fontSize: 11,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        ...methods.map((m) {
          final barWidth = (m['bar'] as double).clamp(0.0, 1.0);
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(m['method'] as String,
                        style: const TextStyle(
                            color: _npDarkTeal,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600)),
                    Text('${m['keystrokes']} keys',
                        style: TextStyle(
                            color: m['color'] as Color,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 3),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: _npWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: barWidth,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: m['color'] as Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _npSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _npWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _npWhite.withValues(alpha: 0.95),
                  fontSize: 12.5)),
        ),
      ],
    ),
  );
}

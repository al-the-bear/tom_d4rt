// ignore_for_file: avoid_print
// Deep demo: AutocompleteNextOptionIntent — move to next autocomplete suggestion
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Warm Coral / Cream
// ─────────────────────────────────────────────────────────────
const Color _anCoral = Color(0xFFD84315);
const Color _anCream = Color(0xFFFBE9E7);
const Color _anDarkCoral = Color(0xFF6D2109);
const Color _anMedCoral = Color(0xFFE64A19);
const Color _anLightCoral = Color(0xFFFFAB91);
const Color _anWhite = Color(0xFFFFFFFF);
const Color _anGray = Color(0xFF6D4C41);
const Color _anAccentBlue = Color(0xFF1565C0);
const Color _anAccentTeal = Color(0xFF00796B);
const Color _anAccentAmber = Color(0xFFFF8F00);
const Color _anAccentGreen = Color(0xFF2E7D32);
const Color _anAccentPurple = Color(0xFF6A1B9A);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _anSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _anWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _anLightCoral, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x1AD84315), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _anCoral,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _anWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _anLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _anDarkCoral,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _anBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _anGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _anCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F0EE),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _anLightCoral.withValues(alpha: 0.5)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _anDarkCoral,
            height: 1.45)),
  );
}

Widget _anChip(String text, Color bg, Color fg) {
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

Widget _anDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _anLightCoral.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: AutocompleteNextOptionIntent');
  print('  Move to the next option in autocomplete results');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _anCream,
      appBarTheme: const AppBarTheme(
        backgroundColor: _anCoral,
        foregroundColor: _anWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutocompleteNextOptionIntent',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
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
                  colors: [_anDarkCoral, _anCoral, _anMedCoral],
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
                      color: _anWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_downward_rounded,
                        color: _anWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('AutocompleteNextOptionIntent',
                      style: TextStyle(
                          color: _anWhite,
                          fontSize: 22,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Navigate forward through autocomplete suggestions',
                      style: TextStyle(
                          color: _anWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _anChip('Intent', _anWhite.withValues(alpha: 0.25), _anWhite),
                      _anChip('Keyboard Nav', _anWhite.withValues(alpha: 0.25), _anWhite),
                      _anChip('Arrow ↓', _anWhite.withValues(alpha: 0.25), _anWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is AutocompleteNextOptionIntent?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('1 · What Is AutocompleteNextOptionIntent?', [
              _anBody(
                'AutocompleteNextOptionIntent is an Intent subclass that '
                'represents the user\'s desire to move the highlight to the '
                'next suggestion in an Autocomplete dropdown. It is the most '
                'commonly triggered autocomplete navigation intent—fired every '
                'time the user presses the down-arrow key while the options '
                'overlay is visible.',
              ),
              _anLabel('Class hierarchy'),
              _anCodeBlock(
                'Intent                          (abstract base)\n'
                '  └─ AutocompleteNextOptionIntent\n'
                '       • Concrete, no extra fields\n'
                '       • const constructor\n'
                '       • Paired with AutocompleteNextOptionAction',
              ),
              _anBody(
                'Unlike page-based intents that jump multiple items at once, '
                'this intent always moves exactly one position forward. When '
                'the highlight reaches the last option it wraps around to the '
                'first, creating a circular navigation experience.',
              ),
              _anDivider(),
              _anLabel('Key characteristics'),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _anCream,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _anLightCoral),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Direction',
                              style: TextStyle(
                                  color: _anCoral,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11)),
                          Text('Forward (↓)',
                              style: TextStyle(
                                  color: _anDarkCoral, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _anCream,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _anLightCoral),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Step size',
                              style: TextStyle(
                                  color: _anCoral,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11)),
                          Text('1 option',
                              style: TextStyle(
                                  color: _anDarkCoral, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _anCream,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _anLightCoral),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Wraps?',
                              style: TextStyle(
                                  color: _anCoral,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11)),
                          Text('Yes, circular',
                              style: TextStyle(
                                  color: _anDarkCoral, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: The Autocomplete Navigation Intent Family
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('2 · The Autocomplete Navigation Intent Family', [
              _anBody(
                'Flutter provides six autocomplete intents that form a complete '
                'keyboard navigation system. AutocompleteNextOptionIntent sits '
                'at the center as the primary forward-one-step navigator.',
              ),
              ..._buildIntentFamilyCards(),
              _anDivider(),
              _anBody(
                'Together they handle all expected keyboard shortcuts: single-step '
                'arrows, page jumps, and boundary jumps. On most platforms the '
                'down-arrow maps directly to AutocompleteNextOptionIntent.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Intent → Action → Shortcut chain
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('3 · Intent → Action → Shortcut Chain', [
              _anBody(
                'When the user presses ↓ inside a focused Autocomplete field, '
                'Flutter\'s shortcut system creates an AutocompleteNextOptionIntent '
                'and dispatches it through the action tree.',
              ),
              _anLabel('3-layer dispatch'),
              ..._buildDispatchLayers(),
              _anDivider(),
              _anLabel('Code wiring'),
              _anCodeBlock(
                'Shortcuts(\n'
                '  shortcuts: <ShortcutActivator, Intent>{\n'
                '    const SingleActivator(LogicalKeyboardKey.arrowDown):\n'
                '        AutocompleteNextOptionIntent(),\n'
                '  },\n'
                '  child: Actions(\n'
                '    actions: <Type, Action<Intent>>{\n'
                '      AutocompleteNextOptionIntent:\n'
                '          _NextOptionAction(highlightNotifier),\n'
                '    },\n'
                '    child: autocompleteField,\n'
                '  ),\n'
                ')',
              ),
              _anBody(
                'Autocomplete<T> installs this wiring automatically. You only '
                'need custom Shortcuts if overriding the default key binding '
                '(e.g., mapping Tab to "next option").',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Arrow-Down Step Flow
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('4 · Arrow-Down: Step-by-Step Flow', [
              _anBody(
                'Pressing the arrow-down key initiates a precisely ordered '
                'sequence that updates the highlighted option and repaints '
                'the overlay.',
              ),
              ..._buildStepFlow(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Wrap-around behavior
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('5 · Circular Wrap-Around Behavior', [
              _anBody(
                'When the highlighted index reaches the end of the options list, '
                'the next ↓ press wraps back to index 0. This circular navigation '
                'is the default Autocomplete behavior.',
              ),
              _anLabel('Wrap cycle with 5 options'),
              ..._buildWrapCycleVisual(),
              _anDivider(),
              _anLabel('Index formula'),
              _anCodeBlock(
                'nextIndex = (currentIndex + 1) % options.length;\n'
                '\n'
                '// Example with 5 options:\n'
                '//   current=0  →  next=1\n'
                '//   current=3  →  next=4\n'
                '//   current=4  →  next=0  (wrap!)',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Next vs NextPage comparison
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('6 · Next vs NextPage Comparison', [
              _anBody(
                'Two forward-moving intents exist: "Next" (single step) and '
                '"NextPage" (multi-step jump). Understanding the difference '
                'is essential for keyboard accessibility.',
              ),
              _buildComparisonTable(),
              _anDivider(),
              _anBody(
                'Users typically press ↓ repeatedly for nearby options or '
                'Page Down when the dropdown has many entries. Both intents '
                'wrap at boundaries, but at different jump sizes.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Platform key bindings
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('7 · Platform Key Bindings', [
              _anBody(
                'The default shortcut that dispatches '
                'AutocompleteNextOptionIntent varies slightly by platform, '
                'though the arrow-down key is universal.',
              ),
              ..._buildPlatformBindings(),
              _anDivider(),
              _anLabel('Custom binding example'),
              _anCodeBlock(
                '// Map Tab to "next option" for power-user UX\n'
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    const SingleActivator(LogicalKeyboardKey.tab):\n'
                '        AutocompleteNextOptionIntent(),\n'
                '    const SingleActivator(LogicalKeyboardKey.arrowDown):\n'
                '        AutocompleteNextOptionIntent(),\n'
                '  },\n'
                '  child: myAutocomplete,\n'
                ')',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Filtering + Navigation Interaction
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('8 · Filtering + Navigation Interaction', [
              _anBody(
                'As the user types, the options list shrinks. The highlighted '
                'index resets to 0 on each filter update, then ↓ moves from '
                'this fresh baseline. This interaction is crucial for usability.',
              ),
              _anLabel('Scenario: Typing "Al" then pressing ↓'),
              ..._buildFilterFlowCards(),
              _anDivider(),
              _anBody(
                'If a highlighted option is removed by filtering, the index '
                'clamps to the last valid position. The next ↓ then moves '
                'forward from that clamped position.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Real-world search suggestions
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('9 · Real-World: Search Suggestions', [
              _anBody(
                'The most common use case is a search bar with auto-suggestions. '
                'Each ↓ press updates the preview as the user scans results.',
              ),
              _buildSearchSuggestionsDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Simulated Dropdown with Next Navigation
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('10 · Simulated Dropdown with ↓ Navigation', [
              _anBody(
                'A full autocomplete simulation showing the visual state after '
                'pressing ↓ three times from the initial position.',
              ),
              _buildSimulatedDropdown(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Multi-field form navigation
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('11 · Multi-Field Form with Autocomplete', [
              _anBody(
                'In forms with multiple autocomplete fields, each field '
                'maintains its own highlighted index. Pressing ↓ moves within '
                'the active field\'s dropdown only.',
              ),
              _buildMultiFieldForm(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _anSection('12 · Summary', [
              _anBody(
                'AutocompleteNextOptionIntent is the fundamental building block '
                'of keyboard-accessible autocomplete navigation in Flutter.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_anCoral, _anMedCoral],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _anSummaryRow(Icons.arrow_downward, 'Single-step forward navigation'),
                    _anSummaryRow(Icons.loop, 'Circular wrap-around at list end'),
                    _anSummaryRow(Icons.keyboard, 'Mapped to Arrow Down by default'),
                    _anSummaryRow(Icons.filter_list, 'Resets on filter changes'),
                    _anSummaryRow(Icons.widgets, 'Auto-wired by Autocomplete<T>'),
                    _anSummaryRow(Icons.accessible, 'Essential for keyboard accessibility'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _anBody('Part of the six-intent family that enables full '
                  'keyboard navigation of autocomplete dropdowns.'),
            ]),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 2 helpers: Intent family cards
// ─────────────────────────────────────────────────────────────
List<Widget> _buildIntentFamilyCards() {
  final intents = <Map<String, dynamic>>[
    {
      'name': 'NextOption',
      'icon': Icons.arrow_downward,
      'desc': 'Move ↓ one item',
      'highlight': true,
    },
    {
      'name': 'PreviousOption',
      'icon': Icons.arrow_upward,
      'desc': 'Move ↑ one item',
      'highlight': false,
    },
    {
      'name': 'NextPageOption',
      'icon': Icons.keyboard_double_arrow_down,
      'desc': 'Jump ↓ one page',
      'highlight': false,
    },
    {
      'name': 'PreviousPageOption',
      'icon': Icons.keyboard_double_arrow_up,
      'desc': 'Jump ↑ one page',
      'highlight': false,
    },
    {
      'name': 'FirstOption',
      'icon': Icons.vertical_align_top,
      'desc': 'Jump to first',
      'highlight': false,
    },
    {
      'name': 'LastOption',
      'icon': Icons.vertical_align_bottom,
      'desc': 'Jump to last',
      'highlight': false,
    },
  ];
  return [
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: intents.map((data) {
        final isHighlighted = data['highlight'] as bool;
        return Container(
          width: 155,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isHighlighted ? _anCoral : _anCream,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isHighlighted ? _anCoral : _anLightCoral,
              width: isHighlighted ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(data['icon'] as IconData,
                  size: 18,
                  color: isHighlighted ? _anWhite : _anCoral),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['name'] as String,
                        style: TextStyle(
                            color: isHighlighted ? _anWhite : _anDarkCoral,
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                    Text(data['desc'] as String,
                        style: TextStyle(
                            color: isHighlighted
                                ? _anWhite.withValues(alpha: 0.85)
                                : _anGray,
                            fontSize: 9.5)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  ];
}

// ─────────────────────────────────────────────────────────────
// Section 3 helpers: Dispatch layers
// ─────────────────────────────────────────────────────────────
List<Widget> _buildDispatchLayers() {
  final layers = <Map<String, dynamic>>[
    {
      'layer': 'Shortcut',
      'detail': 'Arrow ↓ → AutocompleteNextOptionIntent()',
      'color': _anAccentBlue,
      'icon': Icons.keyboard,
    },
    {
      'layer': 'Intent',
      'detail': 'Carries "move to next" semantics, no state',
      'color': _anCoral,
      'icon': Icons.telegram,
    },
    {
      'layer': 'Action',
      'detail': 'Reads highlightedIndex, increments by 1, wraps',
      'color': _anAccentGreen,
      'icon': Icons.play_circle_fill,
    },
  ];
  return layers.map((data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (data['color'] as Color).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: (data['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: data['color'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(data['icon'] as IconData,
                color: _anWhite, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['layer'] as String,
                    style: TextStyle(
                        color: data['color'] as Color,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
                Text(data['detail'] as String,
                    style:
                        const TextStyle(color: _anGray, fontSize: 11.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 4 helpers: Step flow
// ─────────────────────────────────────────────────────────────
List<Widget> _buildStepFlow() {
  final steps = <Map<String, String>>[
    {
      'num': '1',
      'title': 'Key event received',
      'desc': 'RawKeyboard dispatches arrow-down to FocusManager'
    },
    {
      'num': '2',
      'title': 'Shortcut lookup',
      'desc': 'SingleActivator(arrowDown) matches → creates Intent'
    },
    {
      'num': '3',
      'title': 'Intent dispatched',
      'desc': 'AutocompleteNextOptionIntent() sent to Actions widget'
    },
    {
      'num': '4',
      'title': 'Action invoked',
      'desc': 'NextOptionAction.invoke() called with the intent'
    },
    {
      'num': '5',
      'title': 'Index computed',
      'desc': 'newIndex = (current + 1) % options.length'
    },
    {
      'num': '6',
      'title': 'Notifier updated',
      'desc': 'AutocompleteHighlightedOption.value = newIndex'
    },
    {
      'num': '7',
      'title': 'Overlay rebuilt',
      'desc': 'optionsViewBuilder receives new highlighted index'
    },
  ];
  return steps.map((step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _anCoral,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(step['num']!,
                style: const TextStyle(
                    color: _anWhite,
                    fontSize: 12,
                    fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _anCream,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _anLightCoral.withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step['title']!,
                      style: const TextStyle(
                          color: _anDarkCoral,
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(step['desc']!,
                      style: const TextStyle(
                          color: _anGray, fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 5 helpers: Wrap cycle visual
// ─────────────────────────────────────────────────────────────
List<Widget> _buildWrapCycleVisual() {
  final options = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  final presses = [
    {'from': -1, 'to': 0, 'label': 'Initial → ↓'},
    {'from': 0, 'to': 1, 'label': '↓ press 1'},
    {'from': 1, 'to': 2, 'label': '↓ press 2'},
    {'from': 2, 'to': 3, 'label': '↓ press 3'},
    {'from': 3, 'to': 4, 'label': '↓ press 4'},
    {'from': 4, 'to': 0, 'label': '↓ press 5 (WRAP)'},
  ];
  return [
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _anCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _anLightCoral),
      ),
      child: Column(
        children: presses.map((press) {
          final toIdx = press['to'] as int;
          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 110,
                  child: Text(press['label'] as String,
                      style: TextStyle(
                          color: toIdx == 0 && press['from'] as int == 4
                              ? _anAccentAmber
                              : _anDarkCoral,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
                const Icon(Icons.arrow_right_alt,
                    size: 16, color: _anCoral),
                const SizedBox(width: 6),
                ...List.generate(options.length, (i) {
                  final isHighlighted = i == toIdx;
                  return Container(
                    margin: const EdgeInsets.only(right: 3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: isHighlighted ? _anCoral : _anWhite,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: isHighlighted ? _anCoral : _anLightCoral),
                    ),
                    child: Text(options[i][0],
                        style: TextStyle(
                            color: isHighlighted ? _anWhite : _anGray,
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                  );
                }),
              ],
            ),
          );
        }).toList(),
      ),
    ),
  ];
}

// ─────────────────────────────────────────────────────────────
// Section 6 helpers: Comparison table
// ─────────────────────────────────────────────────────────────
Widget _buildComparisonTable() {
  final rows = <List<String>>[
    ['Aspect', 'NextOption', 'NextPageOption'],
    ['Step size', '1 item', '~5-10 items'],
    ['Default key', 'Arrow ↓', 'Page Down'],
    ['Wrap-around', 'Yes', 'Yes'],
    ['Use case', 'Browse nearby', 'Skip sections'],
    ['Frequency', 'Very common', 'Less common'],
  ];
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _anLightCoral),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        final row = entry.value;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          color: isHeader
              ? _anCoral
              : entry.key.isEven
                  ? _anCream
                  : _anWhite,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(row[0],
                      style: TextStyle(
                          color: isHeader ? _anWhite : _anDarkCoral,
                          fontSize: 11,
                          fontWeight:
                              isHeader ? FontWeight.w700 : FontWeight.w500))),
              Expanded(
                  flex: 3,
                  child: Text(row[1],
                      style: TextStyle(
                          color: isHeader ? _anWhite : _anGray,
                          fontSize: 11,
                          fontWeight:
                              isHeader ? FontWeight.w700 : FontWeight.w400))),
              Expanded(
                  flex: 3,
                  child: Text(row[2],
                      style: TextStyle(
                          color: isHeader ? _anWhite : _anGray,
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
// Section 7 helpers: Platform bindings
// ─────────────────────────────────────────────────────────────
List<Widget> _buildPlatformBindings() {
  final platforms = <Map<String, dynamic>>[
    {
      'platform': 'Desktop (macOS)',
      'key': 'Arrow ↓',
      'alt': 'Ctrl+N (Emacs)',
      'icon': Icons.desktop_mac,
    },
    {
      'platform': 'Desktop (Windows)',
      'key': 'Arrow ↓',
      'alt': '—',
      'icon': Icons.desktop_windows,
    },
    {
      'platform': 'Desktop (Linux)',
      'key': 'Arrow ↓',
      'alt': 'Ctrl+N',
      'icon': Icons.computer,
    },
    {
      'platform': 'Mobile',
      'key': 'N/A (scroll)',
      'alt': 'External keyboard: ↓',
      'icon': Icons.phone_android,
    },
    {
      'platform': 'Web',
      'key': 'Arrow ↓',
      'alt': 'Follows host OS',
      'icon': Icons.language,
    },
  ];
  return platforms.map((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _anCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _anLightCoral.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(p['icon'] as IconData, size: 20, color: _anCoral),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['platform'] as String,
                    style: const TextStyle(
                        color: _anDarkCoral,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    Text('Primary: ${p['key']}',
                        style: const TextStyle(
                            color: _anGray, fontSize: 10.5)),
                    const SizedBox(width: 12),
                    Text('Alt: ${p['alt']}',
                        style: TextStyle(
                            color: _anGray.withValues(alpha: 0.7),
                            fontSize: 10.5)),
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
// Section 8 helpers: Filter flow cards
// ─────────────────────────────────────────────────────────────
List<Widget> _buildFilterFlowCards() {
  final steps = <Map<String, dynamic>>[
    {
      'step': 'Type "A"',
      'options': ['Alice', 'Alex', 'Amanda', 'Andrew'],
      'highlight': 0,
      'color': _anAccentTeal,
    },
    {
      'step': 'Type "Al"',
      'options': ['Alice', 'Alex'],
      'highlight': 0,
      'color': _anAccentBlue,
    },
    {
      'step': 'Press ↓',
      'options': ['Alice', 'Alex'],
      'highlight': 1,
      'color': _anCoral,
    },
    {
      'step': 'Type "Ali"',
      'options': ['Alice'],
      'highlight': 0,
      'color': _anAccentPurple,
    },
  ];
  return steps.map((s) {
    final options = s['options'] as List<String>;
    final hlIdx = s['highlight'] as int;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (s['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s['step'] as String,
              style: TextStyle(
                  color: s['color'] as Color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            children: List.generate(options.length, (i) {
              final isHl = i == hlIdx;
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isHl ? _anCoral : _anWhite,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: isHl ? _anCoral : _anLightCoral),
                ),
                child: Text(options[i],
                    style: TextStyle(
                        color: isHl ? _anWhite : _anDarkCoral,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              );
            }),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 9: Search suggestions demo
// ─────────────────────────────────────────────────────────────
Widget _buildSearchSuggestionsDemo() {
  final suggestions = [
    {'icon': Icons.access_time, 'text': 'flutter autocomplete', 'type': 'Recent'},
    {'icon': Icons.trending_up, 'text': 'flutter autocomplete widget', 'type': 'Trending'},
    {'icon': Icons.search, 'text': 'flutter autocomplete example', 'type': 'Suggestion'},
    {'icon': Icons.search, 'text': 'flutter autocomplete custom', 'type': 'Suggestion'},
    {'icon': Icons.trending_up, 'text': 'flutter intent system', 'type': 'Trending'},
  ];

  return Container(
    decoration: BoxDecoration(
      color: _anWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _anLightCoral),
    ),
    child: Column(
      children: [
        // Search bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _anCream,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: _anCoral, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('flutter autocom|',
                    style: TextStyle(
                        color: _anDarkCoral,
                        fontSize: 14,
                        fontFamily: 'monospace')),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _anCoral.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('↓ x2',
                    style: TextStyle(
                        color: _anCoral,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        // Suggestions list
        ...suggestions.asMap().entries.map((entry) {
          final isHighlighted = entry.key == 2; // After pressing ↓ twice
          final item = entry.value;
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isHighlighted
                  ? _anCoral.withValues(alpha: 0.1)
                  : _anWhite,
              border: Border(
                bottom: BorderSide(
                    color: _anLightCoral.withValues(alpha: 0.3)),
              ),
            ),
            child: Row(
              children: [
                Icon(item['icon'] as IconData,
                    size: 16,
                    color: isHighlighted ? _anCoral : _anGray),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(item['text'] as String,
                      style: TextStyle(
                          color:
                              isHighlighted ? _anDarkCoral : _anGray,
                          fontSize: 12.5,
                          fontWeight: isHighlighted
                              ? FontWeight.w600
                              : FontWeight.w400)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _anCream,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(item['type'] as String,
                      style: const TextStyle(
                          color: _anGray, fontSize: 9)),
                ),
                if (isHighlighted)
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(Icons.arrow_back,
                        size: 12, color: _anCoral),
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
// Section 10: Simulated dropdown
// ─────────────────────────────────────────────────────────────
Widget _buildSimulatedDropdown() {
  final cities = [
    'San Francisco',
    'San Diego',
    'San Antonio',
    'San Jose',
    'Santa Monica',
    'Santiago',
    'Santa Fe',
  ];
  const highlightedIdx = 3; // After 3 presses of ↓

  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF7F3F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _anLightCoral),
    ),
    child: Column(
      children: [
        // Field
        Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: _anWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_city, color: _anCoral, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('San',
                    style: TextStyle(
                        color: _anDarkCoral,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _anAccentAmber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('7 matches',
                    style: TextStyle(
                        color: _anAccentAmber,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        Container(height: 1, color: _anLightCoral),
        // Options
        ...cities.asMap().entries.map((entry) {
          final isHl = entry.key == highlightedIdx;
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isHl ? _anCoral : _anWhite,
            ),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isHl
                        ? _anWhite.withValues(alpha: 0.25)
                        : _anCream,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text('${entry.key}',
                      style: TextStyle(
                          color: isHl ? _anWhite : _anGray,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(entry.value,
                      style: TextStyle(
                          color: isHl ? _anWhite : _anDarkCoral,
                          fontSize: 13,
                          fontWeight:
                              isHl ? FontWeight.w700 : FontWeight.w400)),
                ),
                if (isHl)
                  const Icon(Icons.check_circle,
                      size: 16, color: _anWhite),
              ],
            ),
          );
        }),
        // Keyboard hint
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: _anCream,
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _anKeyHint('↓', 'Next'),
              const SizedBox(width: 14),
              _anKeyHint('↑', 'Prev'),
              const SizedBox(width: 14),
              _anKeyHint('Enter', 'Select'),
              const SizedBox(width: 14),
              _anKeyHint('Esc', 'Close'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anKeyHint(String key, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: _anWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _anLightCoral),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0FD84315),
                blurRadius: 2,
                offset: Offset(0, 1)),
          ],
        ),
        child: Text(key,
            style: const TextStyle(
                color: _anDarkCoral,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace')),
      ),
      const SizedBox(width: 4),
      Text(label,
          style: const TextStyle(color: _anGray, fontSize: 9.5)),
    ],
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Multi-field form
// ─────────────────────────────────────────────────────────────
Widget _buildMultiFieldForm() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _anCream,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _anLightCoral),
    ),
    child: Column(
      children: [
        // Field 1: Country — not active
        _buildFormField(
          label: 'Country',
          value: 'United States',
          icon: Icons.flag,
          isActive: false,
          options: <String>[],
          highlightedIdx: -1,
        ),
        const SizedBox(height: 12),
        // Field 2: City — active with dropdown
        _buildFormField(
          label: 'City',
          value: 'New',
          icon: Icons.location_on,
          isActive: true,
          options: ['New York', 'New Orleans', 'New Haven', 'Newark'],
          highlightedIdx: 1, // After one ↓ press
        ),
        const SizedBox(height: 12),
        // Field 3: Zip — not yet focused
        _buildFormField(
          label: 'Zip Code',
          value: '',
          icon: Icons.markunread_mailbox,
          isActive: false,
          options: <String>[],
          highlightedIdx: -1,
        ),
        const SizedBox(height: 10),
        _anBody(
          'Each field\'s autocomplete has its own highlighted index. '
          'Pressing ↓ in "City" doesn\'t affect "Country" or "Zip". '
          'Focus determines which dropdown receives the intent.',
        ),
      ],
    ),
  );
}

Widget _buildFormField({
  required String label,
  required String value,
  required IconData icon,
  required bool isActive,
  required List<String> options,
  required int highlightedIdx,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _anWhite,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
          color: isActive ? _anCoral : _anLightCoral,
          width: isActive ? 2 : 1),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(icon,
                  size: 18, color: isActive ? _anCoral : _anGray),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                      color: isActive ? _anCoral : _anGray,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              Text(value.isEmpty ? 'Enter value...' : value,
                  style: TextStyle(
                      color: value.isEmpty
                          ? _anGray.withValues(alpha: 0.5)
                          : _anDarkCoral,
                      fontSize: 13)),
              if (isActive)
                const Text('|',
                    style: TextStyle(color: _anCoral, fontSize: 14)),
            ],
          ),
        ),
        if (options.isNotEmpty) ...[
          Container(height: 1, color: _anLightCoral),
          ...options.asMap().entries.map((entry) {
            final isHl = entry.key == highlightedIdx;
            return Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              color: isHl ? _anCoral.withValues(alpha: 0.12) : _anWhite,
              child: Row(
                children: [
                  Text(entry.value,
                      style: TextStyle(
                          color: isHl ? _anCoral : _anDarkCoral,
                          fontSize: 12,
                          fontWeight:
                              isHl ? FontWeight.w700 : FontWeight.w400)),
                  if (isHl) ...[
                    const Spacer(),
                    const Icon(Icons.arrow_forward,
                        size: 12, color: _anCoral),
                  ],
                ],
              ),
            );
          }),
        ],
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 12: Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _anSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _anWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _anWhite.withValues(alpha: 0.95),
                  fontSize: 12.5)),
        ),
      ],
    ),
  );
}

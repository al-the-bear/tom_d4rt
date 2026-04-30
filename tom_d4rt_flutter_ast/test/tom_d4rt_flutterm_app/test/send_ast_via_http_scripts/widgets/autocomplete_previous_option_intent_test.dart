// ignore_for_file: avoid_print
// Deep demo: AutocompletePreviousOptionIntent — move to previous suggestion
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Midnight Indigo / Periwinkle
// ─────────────────────────────────────────────────────────────
const Color _apIndigo = Color(0xFF283593);
const Color _apPeriwinkle = Color(0xFFE8EAF6);
const Color _apDarkIndigo = Color(0xFF121858);
const Color _apMedIndigo = Color(0xFF3949AB);
const Color _apLightIndigo = Color(0xFF9FA8DA);
const Color _apWhite = Color(0xFFFFFFFF);
const Color _apGray = Color(0xFF5C6BC0);
const Color _apAccentGreen = Color(0xFF2E7D32);
const Color _apAccentOrange = Color(0xFFE65100);
const Color _apAccentTeal = Color(0xFF00796B);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _apSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _apWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _apLightIndigo, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x1A283593), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _apIndigo,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _apWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _apLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _apDarkIndigo,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _apBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _apGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _apCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF2F3FA),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _apLightIndigo.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _apDarkIndigo,
            height: 1.45)),
  );
}

Widget _apChip(String text, Color bg, Color fg) {
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

Widget _apDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _apLightIndigo.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: AutocompletePreviousOptionIntent');
  print('  Move up to the previous autocomplete option');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _apPeriwinkle,
      appBarTheme: const AppBarTheme(
        backgroundColor: _apIndigo,
        foregroundColor: _apWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutocompletePreviousOptionIntent',
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
                  colors: [_apDarkIndigo, _apIndigo, _apMedIndigo],
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
                      color: _apWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_upward_rounded,
                        color: _apWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('AutocompletePreviousOptionIntent',
                      style: TextStyle(
                          color: _apWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Navigate backward through autocomplete suggestions',
                      style: TextStyle(
                          color: _apWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _apChip('Intent', _apWhite.withValues(alpha: 0.25), _apWhite),
                      _apChip('Arrow ↑', _apWhite.withValues(alpha: 0.25), _apWhite),
                      _apChip('Backward', _apWhite.withValues(alpha: 0.25), _apWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('1 · What Is PreviousOptionIntent?', [
              _apBody(
                'AutocompletePreviousOptionIntent is the backward counterpart '
                'to AutocompleteNextOptionIntent. It moves the highlighted '
                'option one position up in the autocomplete dropdown, giving '
                'users the ability to step backward through suggestions '
                'when they overshoot with the down-arrow.',
              ),
              _apLabel('Class definition'),
              _apCodeBlock(
                'Intent  (abstract base)\n'
                '  └─ AutocompletePreviousOptionIntent\n'
                '       • Concrete, no extra fields\n'
                '       • const constructor\n'
                '       • Moves highlight index by -1\n'
                '       • Wraps from first → last item',
              ),
              _apDivider(),
              _apBody(
                'Without backward navigation, users who pass their target '
                'would need to loop through the entire list again. This '
                'intent makes autocomplete keyboard navigation bidirectional.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Forward vs Backward contrast
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('2 · Forward vs Backward — Mirror Intents', [
              _apBody(
                'Next and Previous intents form a symmetric pair. They share '
                'the same dispatch mechanism but operate in opposite '
                'directions.',
              ),
              _buildMirrorComparison(),
              _apDivider(),
              _apLabel('Symmetry principle'),
              _apCodeBlock(
                '// Next:     newIndex = (current + 1) % length\n'
                '// Previous: newIndex = (current - 1 + length) % length\n'
                '\n'
                '// Both wrap circularly\n'
                '// Both use the same notifier\n'
                '// Both trigger the same overlay rebuild',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Arrow-Up dispatch flow
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('3 · Arrow-Up Dispatch Flow', [
              _apBody(
                'The journey from keystroke to highlight change follows the '
                'same 3-layer pattern as all Flutter intents.',
              ),
              ..._buildDispatchSteps(),
              _apDivider(),
              _apLabel('Wiring code'),
              _apCodeBlock(
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    const SingleActivator(LogicalKeyboardKey.arrowUp):\n'
                '        AutocompletePreviousOptionIntent(),\n'
                '  },\n'
                '  child: Actions(\n'
                '    actions: {\n'
                '      AutocompletePreviousOptionIntent:\n'
                '          _PreviousOptionAction(highlightNotifier),\n'
                '    },\n'
                '    child: autocompleteField,\n'
                '  ),\n'
                ')',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Reverse index calculation
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('4 · Reverse Index Calculation', [
              _apBody(
                'Unlike simple subtraction, the index must handle the case '
                'where current index is 0. Adding length before modulo '
                'prevents negative indices.',
              ),
              _apLabel('Formula'),
              _apCodeBlock(
                'previousIndex = (currentIndex - 1 + options.length)\n'
                '                    % options.length;\n'
                '\n'
                '// Examples with 6 options:\n'
                '//   current=3  →  prev = (3-1+6) % 6 = 2\n'
                '//   current=1  →  prev = (1-1+6) % 6 = 0\n'
                '//   current=0  →  prev = (0-1+6) % 6 = 5  (wrap!)',
              ),
              _apDivider(),
              _apLabel('Visual: stepping backward through 6 options'),
              _buildBackwardSteppingVisual(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Wrap from first to last
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('5 · Edge Case: Wrapping from First to Last', [
              _apBody(
                'The most important edge case for PreviousOptionIntent: when '
                'the highlight is at index 0, pressing ↑ jumps to the last '
                'item. This creates seamless circular navigation.',
              ),
              _buildWrapVisual(),
              _apDivider(),
              _apBody(
                'This wrap-around is symmetric with NextOptionIntent\'s wrap '
                'from last to first. Together they create an infinite loop '
                'through the options list.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Keyboard UX pairs
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('6 · Keyboard Navigation Pairs', [
              _apBody(
                'Autocomplete intents always come in forward/backward pairs. '
                'The Previous variants let users correct overshoots.',
              ),
              _buildNavigationPairsTable(),
              _apDivider(),
              _apLabel('Platform bindings for ↑'),
              ..._buildPlatformCards(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Overshoot-and-correct pattern
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('7 · Overshoot-and-Correct Pattern', [
              _apBody(
                'The most common use of PreviousOptionIntent is the '
                '"overshoot-and-correct" pattern: the user presses ↓ '
                'repeatedly, passes their target, then presses ↑ to go back.',
              ),
              _buildOvershootScenario(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Filtering interaction
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('8 · Interaction with Filtering', [
              _apBody(
                'When the user types while navigating, the options list '
                'changes and the highlight resets. Previous navigation '
                'then operates on the fresh filtered list.',
              ),
              _apLabel('Scenario: Navigate, type, navigate back'),
              _buildFilterInteractionDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Simulated dropdown with ↑ navigation
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('9 · Simulated Dropdown with ↑ Navigation', [
              _apBody(
                'A complete autocomplete mockup showing the state after the '
                'user pressed ↓ four times and then ↑ twice to go back.',
              ),
              _buildSimulatedDropdown(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Real-world email field
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('10 · Real-World: Email Recipient Field', [
              _apBody(
                'In an email "To:" field with contact suggestions, users '
                'frequently overshoot and press ↑ to find the right '
                'contact. The backward navigation is essential.',
              ),
              _buildEmailFieldDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Accessibility
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('11 · Accessibility Significance', [
              _apBody(
                'Bidirectional navigation is a WCAG requirement for '
                'accessible autocomplete widgets. Users with motor '
                'impairments rely heavily on ↑ to correct movements.',
              ),
              _buildAccessibilityChecklistVisual(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _apSection('12 · Summary', [
              _apBody(
                'AutocompletePreviousOptionIntent completes the bidirectional '
                'keyboard navigation for autocomplete dropdowns.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_apIndigo, _apMedIndigo],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _apSummaryRow(Icons.arrow_upward, 'Single-step backward navigation'),
                    _apSummaryRow(Icons.loop, 'Wraps from first → last item'),
                    _apSummaryRow(Icons.keyboard, 'Mapped to Arrow ↑ by default'),
                    _apSummaryRow(Icons.swap_vert, 'Symmetric mirror of NextOptionIntent'),
                    _apSummaryRow(Icons.undo, 'Enables overshoot-and-correct UX'),
                    _apSummaryRow(Icons.accessible, 'WCAG-required bidirectional navigation'),
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
// Section 2: Mirror comparison
// ─────────────────────────────────────────────────────────────
Widget _buildMirrorComparison() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _apPeriwinkle,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _apLightIndigo),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _apAccentGreen.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _apAccentGreen.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.arrow_downward,
                    size: 24, color: _apAccentGreen),
                const SizedBox(height: 6),
                const Text('NextOptionIntent',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _apAccentGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                Text('index + 1',
                    style: TextStyle(
                        color: _apAccentGreen.withValues(alpha: 0.8),
                        fontSize: 10,
                        fontFamily: 'monospace')),
                Text('Key: Arrow ↓',
                    style: TextStyle(
                        color: _apAccentGreen.withValues(alpha: 0.7),
                        fontSize: 10)),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const Icon(Icons.swap_horiz,
                  color: _apIndigo, size: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _apIndigo.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('mirror',
                    style: TextStyle(
                        color: _apIndigo,
                        fontSize: 9,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _apIndigo.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _apIndigo, width: 2),
            ),
            child: Column(
              children: [
                const Icon(Icons.arrow_upward,
                    size: 24, color: _apIndigo),
                const SizedBox(height: 6),
                const Text('PreviousOptionIntent',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _apIndigo,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                Text('index - 1',
                    style: TextStyle(
                        color: _apIndigo.withValues(alpha: 0.8),
                        fontSize: 10,
                        fontFamily: 'monospace')),
                Text('Key: Arrow ↑',
                    style: TextStyle(
                        color: _apIndigo.withValues(alpha: 0.7),
                        fontSize: 10)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Dispatch steps
// ─────────────────────────────────────────────────────────────
List<Widget> _buildDispatchSteps() {
  final steps = <Map<String, dynamic>>[
    {
      'icon': Icons.keyboard,
      'title': 'Shortcut layer',
      'detail': 'Arrow ↑ → AutocompletePreviousOptionIntent()',
      'color': _apAccentTeal,
    },
    {
      'icon': Icons.send,
      'title': 'Intent layer',
      'detail': 'Carries "move to previous" semantics, immutable',
      'color': _apIndigo,
    },
    {
      'icon': Icons.play_circle,
      'title': 'Action layer',
      'detail': 'Decrements highlighted index by 1 (with wrap)',
      'color': _apAccentOrange,
    },
  ];
  return steps.map((s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (s['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: s['color'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                Icon(s['icon'] as IconData, color: _apWhite, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['title'] as String,
                    style: TextStyle(
                        color: s['color'] as Color,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
                Text(s['detail'] as String,
                    style: const TextStyle(
                        color: _apGray, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 4: Backward stepping visual
// ─────────────────────────────────────────────────────────────
Widget _buildBackwardSteppingVisual() {
  final items = ['Red', 'Orange', 'Yellow', 'Green', 'Blue', 'Violet'];
  final steps = <Map<String, dynamic>>[
    {'label': 'Start', 'idx': 4},
    {'label': '↑ press 1', 'idx': 3},
    {'label': '↑ press 2', 'idx': 2},
    {'label': '↑ press 3', 'idx': 1},
    {'label': '↑ press 4', 'idx': 0},
    {'label': '↑ press 5 (WRAP)', 'idx': 5},
  ];
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _apPeriwinkle,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _apLightIndigo),
    ),
    child: Column(
      children: steps.map((step) {
        final hlIdx = step['idx'] as int;
        final isWrap = (step['label'] as String).contains('WRAP');
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              SizedBox(
                width: 105,
                child: Text(step['label'] as String,
                    style: TextStyle(
                        color: isWrap ? _apAccentOrange : _apDarkIndigo,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600)),
              ),
              const Icon(Icons.arrow_right_alt,
                  size: 14, color: _apIndigo),
              const SizedBox(width: 4),
              ...items.asMap().entries.map((e) {
                final isHl = e.key == hlIdx;
                return Container(
                  margin: const EdgeInsets.only(right: 3),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: isHl ? _apIndigo : _apWhite,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: isHl ? _apIndigo : _apLightIndigo),
                  ),
                  child: Text(e.value[0],
                      style: TextStyle(
                          color: isHl ? _apWhite : _apGray,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                );
              }),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 5: Wrap visual
// ─────────────────────────────────────────────────────────────
Widget _buildWrapVisual() {
  final items = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _apPeriwinkle,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _apLightIndigo),
    ),
    child: Column(
      children: [
        _apLabel('Before ↑ (at index 0)'),
        Row(
          children: items.asMap().entries.map((e) {
            final isHl = e.key == 0;
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isHl ? _apIndigo : _apWhite,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: isHl ? _apIndigo : _apLightIndigo),
                ),
                child: Text(e.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: isHl ? _apWhite : _apDarkIndigo,
                        fontSize: 9.5,
                        fontWeight:
                            isHl ? FontWeight.w700 : FontWeight.w400)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_upward,
                size: 16, color: _apAccentOrange),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _apAccentOrange.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('↑ Press — WRAPS!',
                  style: TextStyle(
                      color: _apAccentOrange,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _apLabel('After ↑ (jumped to index 4)'),
        Row(
          children: items.asMap().entries.map((e) {
            final isHl = e.key == 4;
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isHl ? _apIndigo : _apWhite,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: isHl ? _apIndigo : _apLightIndigo),
                ),
                child: Text(e.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: isHl ? _apWhite : _apDarkIndigo,
                        fontSize: 9.5,
                        fontWeight:
                            isHl ? FontWeight.w700 : FontWeight.w400)),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Navigation pairs table
// ─────────────────────────────────────────────────────────────
Widget _buildNavigationPairsTable() {
  final rows = <List<String>>[
    ['Granularity', 'Forward (↓)', 'Backward (↑)'],
    ['Single', 'NextOption', 'PreviousOption ★'],
    ['Page', 'NextPageOption', 'PreviousPageOption'],
    ['Boundary', 'LastOption', 'FirstOption'],
  ];
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _apLightIndigo),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        final row = entry.value;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          color: isHeader
              ? _apIndigo
              : entry.key.isEven
                  ? _apPeriwinkle
                  : _apWhite,
          child: Row(
            children: row.asMap().entries.map((col) {
              final isStarred = col.value.contains('★');
              return Expanded(
                flex: col.key == 0 ? 2 : 3,
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader
                            ? _apWhite
                            : isStarred
                                ? _apIndigo
                                : _apGray,
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

List<Widget> _buildPlatformCards() {
  final platforms = <Map<String, dynamic>>[
    {'platform': 'macOS', 'key': 'Arrow ↑', 'alt': 'Ctrl+P (Emacs)', 'icon': Icons.desktop_mac},
    {'platform': 'Windows', 'key': 'Arrow ↑', 'alt': '—', 'icon': Icons.desktop_windows},
    {'platform': 'Linux', 'key': 'Arrow ↑', 'alt': 'Ctrl+P', 'icon': Icons.computer},
    {'platform': 'Web', 'key': 'Arrow ↑', 'alt': 'Follows host OS', 'icon': Icons.language},
  ];
  return platforms.map((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _apPeriwinkle,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _apLightIndigo.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(p['icon'] as IconData, size: 18, color: _apIndigo),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['platform'] as String,
                    style: const TextStyle(
                        color: _apDarkIndigo,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    Text('Primary: ${p['key']}',
                        style: const TextStyle(
                            color: _apGray, fontSize: 10)),
                    const SizedBox(width: 10),
                    Text('Alt: ${p['alt']}',
                        style: TextStyle(
                            color: _apGray.withValues(alpha: 0.7),
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
// Section 7: Overshoot scenario
// ─────────────────────────────────────────────────────────────
Widget _buildOvershootScenario() {
  final items = ['Alice', 'Bob', 'Carol', 'David', 'Eve', 'Frank'];
  final timeline = <Map<String, dynamic>>[
    {'action': '↓ ↓ ↓ ↓', 'idx': 4, 'desc': 'Overshot! Wanted "Carol"'},
    {'action': '↑', 'idx': 3, 'desc': 'Back to David'},
    {'action': '↑', 'idx': 2, 'desc': 'Found Carol! ✓'},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _apPeriwinkle,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _apLightIndigo),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Target: Carol (index 2)',
            style: TextStyle(
                color: _apDarkIndigo,
                fontSize: 12,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        ...timeline.map((t) {
          final hlIdx = t['idx'] as int;
          final isTarget = hlIdx == 2;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isTarget
                  ? _apAccentGreen.withValues(alpha: 0.08)
                  : _apWhite,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: isTarget
                      ? _apAccentGreen
                      : _apLightIndigo),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isTarget ? _apAccentGreen : _apIndigo,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(t['action'] as String,
                          style: const TextStyle(
                              color: _apWhite,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace')),
                    ),
                    const SizedBox(width: 8),
                    Text(t['desc'] as String,
                        style: TextStyle(
                            color: isTarget
                                ? _apAccentGreen
                                : _apGray,
                            fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: items.asMap().entries.map((e) {
                    final isHl = e.key == hlIdx;
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: isHl ? _apIndigo : _apWhite,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              color: isHl ? _apIndigo : _apLightIndigo),
                        ),
                        child: Text(e.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: isHl ? _apWhite : _apGray,
                                fontSize: 9,
                                fontWeight: FontWeight.w600)),
                      ),
                    );
                  }).toList(),
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
// Section 8: Filter interaction demo
// ─────────────────────────────────────────────────────────────
Widget _buildFilterInteractionDemo() {
  final stages = <Map<String, dynamic>>[
    {
      'step': '1. Type "D" — 3 matches',
      'options': ['Dallas', 'Denver', 'Detroit'],
      'hlIdx': 0,
      'color': _apAccentTeal,
    },
    {
      'step': '2. Press ↓ ↓ — highlight at Detroit',
      'options': ['Dallas', 'Denver', 'Detroit'],
      'hlIdx': 2,
      'color': _apIndigo,
    },
    {
      'step': '3. Type "De" — 2 matches, reset to 0',
      'options': ['Denver', 'Detroit'],
      'hlIdx': 0,
      'color': _apAccentOrange,
    },
    {
      'step': '4. Press ↓ then ↑ — back to 0',
      'options': ['Denver', 'Detroit'],
      'hlIdx': 0,
      'color': _apAccentGreen,
    },
  ];
  return Column(
    children: stages.map((s) {
      final opts = s['options'] as List<String>;
      final hlIdx = s['hlIdx'] as int;
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
                    fontSize: 11.5)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              children: opts.asMap().entries.map((e) {
                final isHl = e.key == hlIdx;
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isHl ? _apIndigo : _apWhite,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: isHl ? _apIndigo : _apLightIndigo),
                  ),
                  child: Text(e.value,
                      style: TextStyle(
                          color: isHl ? _apWhite : _apDarkIndigo,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 9: Simulated dropdown
// ─────────────────────────────────────────────────────────────
Widget _buildSimulatedDropdown() {
  final items = [
    'JavaScript',
    'Java',
    'Python',
    'C++',
    'TypeScript',
    'Go',
    'Rust',
  ];
  const hlIdx = 2; // After ↓↓↓↓ then ↑↑

  return Container(
    decoration: BoxDecoration(
      color: _apWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _apLightIndigo),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: _apPeriwinkle,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _apIndigo, size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('Programming Language|',
                    style: TextStyle(
                        color: _apDarkIndigo,
                        fontSize: 13,
                        fontFamily: 'monospace')),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _apIndigo.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('↓×4 ↑×2',
                    style: TextStyle(
                        color: _apIndigo,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        ...items.asMap().entries.map((e) {
          final isHl = e.key == hlIdx;
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isHl ? _apIndigo : _apWhite,
              border: Border(
                  bottom: BorderSide(
                      color: _apLightIndigo.withValues(alpha: 0.3))),
            ),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isHl
                        ? _apWhite.withValues(alpha: 0.2)
                        : _apPeriwinkle,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text('${e.key}',
                      style: TextStyle(
                          color: isHl ? _apWhite : _apGray,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(e.value,
                      style: TextStyle(
                          color: isHl ? _apWhite : _apDarkIndigo,
                          fontSize: 13,
                          fontWeight:
                              isHl ? FontWeight.w700 : FontWeight.w400)),
                ),
                if (isHl)
                  const Icon(Icons.check_circle,
                      size: 16, color: _apWhite),
              ],
            ),
          );
        }),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: _apPeriwinkle,
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _apKeyHint('↑', 'Prev'),
              const SizedBox(width: 12),
              _apKeyHint('↓', 'Next'),
              const SizedBox(width: 12),
              _apKeyHint('Enter', 'Select'),
              const SizedBox(width: 12),
              _apKeyHint('Esc', 'Close'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _apKeyHint(String key, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: _apWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _apLightIndigo),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0F283593),
                blurRadius: 2,
                offset: Offset(0, 1)),
          ],
        ),
        child: Text(key,
            style: const TextStyle(
                color: _apDarkIndigo,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace')),
      ),
      const SizedBox(width: 4),
      Text(label,
          style: const TextStyle(color: _apGray, fontSize: 9.5)),
    ],
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Email field demo
// ─────────────────────────────────────────────────────────────
Widget _buildEmailFieldDemo() {
  final contacts = [
    {'name': 'Alice Chen', 'email': 'alice@example.com', 'avatar': 'AC'},
    {'name': 'Alex Rivera', 'email': 'alex@company.org', 'avatar': 'AR'},
    {'name': 'Amanda Park', 'email': 'amanda@startup.io', 'avatar': 'AP'},
    {'name': 'Andrew Kim', 'email': 'andrew@tech.dev', 'avatar': 'AK'},
    {'name': 'Anna Lopez', 'email': 'anna@design.co', 'avatar': 'AL'},
  ];
  const hlIdx = 2; // User wanted Alex, overshot to Amanda, pressed ↑... arrived

  return Container(
    decoration: BoxDecoration(
      color: _apWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _apLightIndigo),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: _apPeriwinkle,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: const Row(
            children: [
              Text('To: ',
                  style: TextStyle(
                      color: _apGray,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              Expanded(
                child: Text('A|',
                    style: TextStyle(
                        color: _apDarkIndigo,
                        fontSize: 14,
                        fontFamily: 'monospace')),
              ),
            ],
          ),
        ),
        ...contacts.asMap().entries.map((e) {
          final isHl = e.key == hlIdx;
          final contact = e.value;
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color:
                  isHl ? _apIndigo.withValues(alpha: 0.1) : _apWhite,
              border: Border(
                  bottom: BorderSide(
                      color: _apLightIndigo.withValues(alpha: 0.3))),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isHl
                        ? _apIndigo
                        : _apLightIndigo.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text(contact['avatar']!,
                      style: TextStyle(
                          color: isHl ? _apWhite : _apIndigo,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact['name']!,
                          style: TextStyle(
                              color: isHl
                                  ? _apIndigo
                                  : _apDarkIndigo,
                              fontSize: 12,
                              fontWeight: isHl
                                  ? FontWeight.w700
                                  : FontWeight.w500)),
                      Text(contact['email']!,
                          style: TextStyle(
                              color: _apGray.withValues(alpha: 0.7),
                              fontSize: 10.5)),
                    ],
                  ),
                ),
                if (isHl)
                  const Icon(Icons.arrow_back,
                      size: 14, color: _apIndigo),
              ],
            ),
          );
        }),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: _apPeriwinkle,
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: const Text('Overshot Amanda (↓×3), corrected with ↑ to Amanda',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _apIndigo,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Accessibility checklist
// ─────────────────────────────────────────────────────────────
Widget _buildAccessibilityChecklistVisual() {
  final items = <Map<String, dynamic>>[
    {
      'check': 'Arrow ↑ navigates backward',
      'status': 'Required',
      'icon': Icons.check_circle,
      'color': _apAccentGreen,
    },
    {
      'check': 'Circular wrap at boundaries',
      'status': 'Required',
      'icon': Icons.check_circle,
      'color': _apAccentGreen,
    },
    {
      'check': 'Visual focus indicator',
      'status': 'Required',
      'icon': Icons.check_circle,
      'color': _apAccentGreen,
    },
    {
      'check': 'Screen reader announcement',
      'status': 'Recommended',
      'icon': Icons.info,
      'color': _apAccentOrange,
    },
    {
      'check': 'Focus trap in dropdown',
      'status': 'Required',
      'icon': Icons.check_circle,
      'color': _apAccentGreen,
    },
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _apPeriwinkle,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _apLightIndigo),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('WCAG Autocomplete Navigation Checklist',
            style: TextStyle(
                color: _apDarkIndigo,
                fontSize: 12,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        ...items.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _apWhite,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: (item['color'] as Color).withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(item['icon'] as IconData,
                    size: 18, color: item['color'] as Color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(item['check'] as String,
                      style: const TextStyle(
                          color: _apDarkIndigo,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(item['status'] as String,
                      style: TextStyle(
                          color: item['color'] as Color,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600)),
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
Widget _apSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _apWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _apWhite.withValues(alpha: 0.95),
                  fontSize: 12.5)),
        ),
      ],
    ),
  );
}

// ignore_for_file: avoid_print
// Deep demo: AutocompleteLastOptionIntent — select last autocomplete option
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Royal Purple / Lavender
// ─────────────────────────────────────────────────────────────
const Color _alPurple = Color(0xFF4527A0);
const Color _alLavender = Color(0xFFEDE7F6);
const Color _alDarkPurple = Color(0xFF1A0A4A);
const Color _alMedPurple = Color(0xFF5E35B1);
const Color _alLightPurple = Color(0xFFB39DDB);
const Color _alWhite = Color(0xFFFFFFFF);
const Color _alGray = Color(0xFF5C527F);
const Color _alAccentBlue = Color(0xFF1565C0);
const Color _alAccentTeal = Color(0xFF00695C);
const Color _alAccentOrange = Color(0xFFEF6C00);
const Color _alAccentRed = Color(0xFFC62828);
const Color _alAccentGreen = Color(0xFF2E7D32);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _alSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _alWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _alLightPurple, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x1A4527A0), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _alPurple,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _alWhite, fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _alLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _alDarkPurple, fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

Widget _alBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _alGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _alChip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _alInfoRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(key,
              style: const TextStyle(
                  color: _alDarkPurple, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: _alGray, fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _alDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 1,
    color: _alLightPurple.withValues(alpha: 0.5),
  );
}

// ─────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════');
  print('  AutocompleteLastOptionIntent — Deep Demo');
  print('  Keyboard-driven last-option selection in Autocomplete');
  print('═══════════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _alLavender,
      appBarTheme: const AppBarTheme(
        backgroundColor: _alPurple,
        foregroundColor: _alWhite,
        elevation: 3,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutocompleteLastOptionIntent'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _buildBanner(),
            _buildWhatIsIt(),
            _buildAutocompleteSystem(),
            _buildIntentActionArchitecture(),
            _buildAllAutocompleteIntents(),
            _buildKeyboardNavigation(),
            _buildOptionSelectionFlow(),
            _buildOptionsListAnatomy(),
            _buildVisualKeyboardNav(),
            _buildRealWorldExamples(),
            _buildSimulatedDropdown(),
            _buildSummary(),
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 1 — Banner
// ═══════════════════════════════════════════════════════════════
Widget _buildBanner() {
  print('[Section 1] Banner');
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_alPurple, _alMedPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x404527A0), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.keyboard_double_arrow_down, size: 52, color: _alWhite),
        const SizedBox(height: 12),
        const Text('AutocompleteLastOptionIntent',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _alWhite, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _alWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Intent · Action · Keyboard Navigation · Last Option',
            style: TextStyle(color: _alWhite, fontSize: 11),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            _alChip('widgets', _alWhite),
            _alChip('autocomplete', _alWhite),
            _alChip('intent', _alWhite),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 2 — What Is It?
// ═══════════════════════════════════════════════════════════════
Widget _buildWhatIsIt() {
  print('[Section 2] What is AutocompleteLastOptionIntent?');
  return _alSection('What Is AutocompleteLastOptionIntent?', [
    _alBody(
      'AutocompleteLastOptionIntent is an Intent that, when dispatched, '
      'tells the Autocomplete widget to jump to and highlight the last '
      'option in its results list. It is one of several keyboard navigation '
      'intents that let users navigate autocomplete results without a mouse.',
    ),
    _alDivider(),
    _alLabel('In Plain Terms'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _alLavender,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _alPurple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.keyboard, size: 20, color: _alWhite),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'User presses a keyboard shortcut → '
              'AutocompleteLastOptionIntent is dispatched → '
              'Autocomplete highlights the last suggestion',
              style: TextStyle(color: _alDarkPurple, fontSize: 12),
            ),
          ),
        ],
      ),
    ),
    _alDivider(),
    _alLabel('Why It Exists'),
    _alBody(
      '• Accessibility: screen readers need keyboard-first navigation\n'
      '• Efficiency: power users navigate faster with keyboard shortcuts\n'
      '• Completeness: provides End/Home-style navigation for lists\n'
      '• Consistency: matches standard OS autocomplete behavior',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 3 — Autocomplete Widget System
// ═══════════════════════════════════════════════════════════════
Widget _buildAutocompleteSystem() {
  print('[Section 3] Autocomplete widget system');
  return _alSection('The Autocomplete Widget System', [
    _alBody(
      'Flutter\'s Autocomplete widget provides a complete text-suggestion '
      'experience with customizable options, field, and overlay:',
    ),
    _alDivider(),
    _alLabel('Architecture'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _alDarkPurple.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildComponentBox('Autocomplete<T>',
              'Top-level widget, manages state and keyboard intents',
              _alPurple, Icons.auto_awesome),
          const SizedBox(height: 6),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    _buildComponentBox('fieldViewBuilder',
                        'The text input field (usually TextField)',
                        _alMedPurple, Icons.text_fields),
                    const SizedBox(height: 6),
                    _buildComponentBox('optionsViewBuilder',
                        'Dropdown/overlay showing matching options',
                        _alAccentBlue, Icons.list),
                    const SizedBox(height: 6),
                    _buildComponentBox('optionsBuilder',
                        'Function that filters options from query text',
                        _alAccentTeal, Icons.filter_list),
                    const SizedBox(height: 6),
                    _buildComponentBox('onSelected',
                        'Callback when user picks an option',
                        _alAccentGreen, Icons.check_circle),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    _alDivider(),
    _alLabel('Options Flow'),
    _alBody(
      'User types → optionsBuilder filters → optionsViewBuilder displays '
      '→ keyboard/mouse selects → onSelected callback fires.',
    ),
  ]);
}

Widget _buildComponentBox(
    String name, String desc, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _alGray, fontSize: 10.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 4 — Intent/Action/Shortcut Architecture
// ═══════════════════════════════════════════════════════════════
Widget _buildIntentActionArchitecture() {
  print('[Section 4] Intent/Action/Shortcut architecture');
  return _alSection('Intent / Action / Shortcut Architecture', [
    _alBody(
      'Flutter\'s shortcut system has three layers. '
      'AutocompleteLastOptionIntent is an Intent:',
    ),
    _alDivider(),
    _buildArchLayer('Shortcuts', 'Maps key combinations to Intents',
        'Ctrl+End → AutocompleteLastOptionIntent',
        Icons.keyboard, _alPurple),
    _buildArchArrow(),
    _buildArchLayer('Intents', 'Semantic description of user action',
        'AutocompleteLastOptionIntent()',
        Icons.description, _alMedPurple),
    _buildArchArrow(),
    _buildArchLayer('Actions', 'Handlers that execute the intent',
        'Autocomplete registers the handler internally',
        Icons.play_arrow, _alAccentGreen),
    _alDivider(),
    _alLabel('Why This Layering?'),
    _alBody(
      '• Shortcuts can be remapped without changing logic\n'
      '• Intents are testable and composable\n'
      '• Actions can be context-dependent (different handlers per widget)\n'
      '• Accessibility: intents can be triggered programmatically',
    ),
  ]);
}

Widget _buildArchLayer(
    String name, String desc, String example, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color, fontSize: 13, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _alGray, fontSize: 11)),
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(example,
                    style: TextStyle(
                        color: color, fontSize: 10, fontFamily: 'monospace')),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildArchArrow() {
  return Container(
    margin: const EdgeInsets.only(left: 24),
    height: 12,
    width: 2,
    color: _alLightPurple.withValues(alpha: 0.5),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 5 — All Autocomplete Intents
// ═══════════════════════════════════════════════════════════════
Widget _buildAllAutocompleteIntents() {
  print('[Section 5] All autocomplete intents');
  return _alSection('Autocomplete Intent Family', [
    _alBody(
      'AutocompleteLastOptionIntent is one of four navigation intents '
      'in the Autocomplete system:',
    ),
    _alDivider(),
    _buildIntentCard(
      'AutocompleteNextOptionIntent',
      'Move highlight to the next option in the list',
      Icons.keyboard_arrow_down,
      _alAccentBlue,
      false,
    ),
    _buildIntentCard(
      'AutocompletePreviousOptionIntent',
      'Move highlight to the previous option in the list',
      Icons.keyboard_arrow_up,
      _alAccentTeal,
      false,
    ),
    _buildIntentCard(
      'AutocompleteFirstOptionIntent',
      'Jump highlight to the first option in the list',
      Icons.vertical_align_top,
      _alAccentOrange,
      false,
    ),
    _buildIntentCard(
      'AutocompleteLastOptionIntent ★',
      'Jump highlight to the last option in the list',
      Icons.vertical_align_bottom,
      _alPurple,
      true,
    ),
    _alDivider(),
    _alLabel('Navigation Model'),
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _alLavender,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.vertical_align_top, size: 14, color: _alAccentOrange),
              SizedBox(width: 4),
              Text('First', style: TextStyle(color: _alAccentOrange, fontSize: 10)),
              SizedBox(width: 20),
              Icon(Icons.keyboard_arrow_up, size: 14, color: _alAccentTeal),
              SizedBox(width: 4),
              Text('Previous', style: TextStyle(color: _alAccentTeal, fontSize: 10)),
              SizedBox(width: 20),
              Icon(Icons.keyboard_arrow_down, size: 14, color: _alAccentBlue),
              SizedBox(width: 4),
              Text('Next', style: TextStyle(color: _alAccentBlue, fontSize: 10)),
              SizedBox(width: 20),
              Icon(Icons.vertical_align_bottom, size: 14, color: _alPurple),
              SizedBox(width: 4),
              Text('Last ★', style: TextStyle(color: _alPurple, fontSize: 10,
                  fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    ),
  ]);
}

Widget _buildIntentCard(
    String name, String desc, IconData icon, Color color, bool highlight) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: highlight ? 0.1 : 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: color.withValues(alpha: highlight ? 0.5 : 0.15),
        width: highlight ? 2 : 1,
      ),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _alGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 6 — Keyboard Navigation Mapping
// ═══════════════════════════════════════════════════════════════
Widget _buildKeyboardNavigation() {
  print('[Section 6] Keyboard navigation mapping');
  return _alSection('Keyboard Shortcut Mapping', [
    _alBody(
      'These intents are bound to keyboard shortcuts inside the '
      'Autocomplete widget:',
    ),
    _alDivider(),
    _buildKeyMapping('↓ Arrow Down', 'AutocompleteNextOptionIntent', _alAccentBlue),
    _buildKeyMapping('↑ Arrow Up', 'AutocompletePreviousOptionIntent', _alAccentTeal),
    _buildKeyMapping('Ctrl + Home', 'AutocompleteFirstOptionIntent', _alAccentOrange),
    _buildKeyMapping('Ctrl + End', 'AutocompleteLastOptionIntent ★', _alPurple),
    _buildKeyMapping('Enter', 'Select highlighted option', _alAccentGreen),
    _buildKeyMapping('Escape', 'Close the options overlay', _alAccentRed),
    _alDivider(),
    _alLabel('Platform Differences'),
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _alAccentBlue.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Icon(Icons.desktop_windows, size: 18, color: _alAccentBlue),
                const SizedBox(height: 4),
                const Text('Desktop',
                    style: TextStyle(color: _alAccentBlue, fontSize: 11,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _alBody('Full keyboard\nnavigation\nCtrl+Home/End'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _alAccentTeal.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Icon(Icons.phone_android, size: 18, color: _alAccentTeal),
                const SizedBox(height: 4),
                const Text('Mobile',
                    style: TextStyle(color: _alAccentTeal, fontSize: 11,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _alBody('Touch-first\nSoft keyboard limited\nScroll to select'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _alPurple.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Icon(Icons.web, size: 18, color: _alPurple),
                const SizedBox(height: 4),
                const Text('Web',
                    style: TextStyle(color: _alPurple, fontSize: 11,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _alBody('Keyboard +\ntouch support\nBrowser shortcuts'),
              ],
            ),
          ),
        ),
      ],
    ),
  ]);
}

Widget _buildKeyMapping(String keys, String intent, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _alDarkPurple.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _alLightPurple.withValues(alpha: 0.3)),
          ),
          child: Text(keys,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: _alDarkPurple, fontSize: 11,
                  fontWeight: FontWeight.w600, fontFamily: 'monospace')),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward, size: 12, color: _alLightPurple),
        const SizedBox(width: 8),
        Expanded(
          child: Text(intent,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 7 — Option Selection Flow
// ═══════════════════════════════════════════════════════════════
Widget _buildOptionSelectionFlow() {
  print('[Section 7] Option selection flow');
  return _alSection('Option Selection Flow', [
    _alBody(
      'When the user triggers AutocompleteLastOptionIntent, here\'s '
      'exactly what happens:',
    ),
    _alDivider(),
    _buildFlowStep(1, 'Key event captured',
        'Shortcuts widget receives Ctrl+End keystroke', _alPurple),
    _buildFlowStep(2, 'Intent dispatched',
        'AutocompleteLastOptionIntent() created', _alMedPurple),
    _buildFlowStep(3, 'Action invoked',
        'Autocomplete\'s registered Action receives the intent', _alAccentBlue),
    _buildFlowStep(4, 'Index updated',
        'Highlighted option index set to options.length - 1', _alAccentTeal),
    _buildFlowStep(5, 'UI rebuilt',
        'optionsViewBuilder called with new highlighted index', _alAccentGreen),
    _buildFlowStep(6, 'Scroll adjustment',
        'Options list scrolls to show the last item', _alAccentOrange),
    _alDivider(),
    _alLabel('State Tracking'),
    _alInfoRow('_highlightedIndex', 'Current highlighted option (0-based)'),
    _alInfoRow('_options', 'List of filtered options shown in dropdown'),
    _alInfoRow('_selection', 'Currently selected option (null until chosen)'),
  ]);
}

Widget _buildFlowStep(int num, String title, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: _alWhite, fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _alGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 8 — Options List Anatomy
// ═══════════════════════════════════════════════════════════════
Widget _buildOptionsListAnatomy() {
  print('[Section 8] Options list anatomy');
  return _alSection('Options List Anatomy', [
    _alBody(
      'The options list is built by optionsViewBuilder and tracks '
      'which item is highlighted:',
    ),
    _alDivider(),
    _buildOptionItem(0, 'Apple', false, false),
    _buildOptionItem(1, 'Banana', false, false),
    _buildOptionItem(2, 'Cherry', false, false),
    _buildOptionItem(3, 'Date', false, false),
    _buildOptionItem(4, 'Elderberry', false, true),
    _alDivider(),
    _alLabel('Index Semantics'),
    _alInfoRow('index = 0', 'First option (AutocompleteFirstOptionIntent)'),
    _alInfoRow('index = length-1', 'Last option (AutocompleteLastOptionIntent ★)'),
    _alInfoRow('index + 1', 'Next option (AutocompleteNextOptionIntent)'),
    _alInfoRow('index - 1', 'Previous option (AutocompletePreviousOptionIntent)'),
    _alDivider(),
    _alLabel('Wrap-Around Behavior'),
    _alBody(
      'When at the last option and Next is pressed, behavior depends on '
      'implementation:\n'
      '• Some wrap to first\n'
      '• Some stay at last\n'
      '• AutocompleteLastOptionIntent always jumps directly to last',
    ),
  ]);
}

Widget _buildOptionItem(int index, String text, bool selected, bool highlighted) {
  final color = highlighted ? _alPurple : (selected ? _alAccentGreen : _alGray);
  return Container(
    margin: const EdgeInsets.only(bottom: 2),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: highlighted
          ? _alPurple.withValues(alpha: 0.12)
          : selected
              ? _alAccentGreen.withValues(alpha: 0.08)
              : _alLavender.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(6),
      border: highlighted
          ? Border.all(color: _alPurple, width: 2)
          : null,
    ),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text('$index',
                style: TextStyle(
                    color: color, fontSize: 10, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: highlighted ? FontWeight.w700 : FontWeight.w500)),
        ),
        if (highlighted)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _alPurple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('LAST ★',
                style: TextStyle(
                    color: _alWhite, fontSize: 9, fontWeight: FontWeight.w700)),
          ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 9 — Visual Keyboard Navigation
// ═══════════════════════════════════════════════════════════════
Widget _buildVisualKeyboardNav() {
  print('[Section 9] Visual keyboard navigation');
  return _alSection('Visual Keyboard Navigation', [
    _alBody(
      'This demonstrates how keyboard shortcuts move the highlight '
      'through the options list:',
    ),
    _alDivider(),
    // Step-by-step navigation
    _buildNavScenario('Initial State', 'No highlight',
        [false, false, false, false, false]),
    _buildNavScenario('↓ Arrow Down', 'Highlight first',
        [true, false, false, false, false]),
    _buildNavScenario('↓ Arrow Down', 'Highlight second',
        [false, true, false, false, false]),
    _buildNavScenario('Ctrl + End ★', 'Jump to last!',
        [false, false, false, false, true]),
    _buildNavScenario('↑ Arrow Up', 'Move up one',
        [false, false, false, true, false]),
    _buildNavScenario('Ctrl + Home', 'Jump to first',
        [true, false, false, false, false]),
    _alDivider(),
    _alLabel('Direct Jump vs Sequential'),
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _alPurple.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.vertical_align_bottom, size: 16, color: _alPurple),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'AutocompleteLastOptionIntent jumps directly to the end, '
                  'regardless of current position. No intermediate steps.',
                  style: TextStyle(color: _alDarkPurple, fontSize: 11),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ]);
}

Widget _buildNavScenario(String key, String desc, List<bool> highlights) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 90,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: _alDarkPurple.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(key,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: _alDarkPurple, fontSize: 10,
                  fontWeight: FontWeight.w600, fontFamily: 'monospace')),
        ),
        const SizedBox(width: 6),
        ...highlights.map((h) => Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 3),
              decoration: BoxDecoration(
                color: h ? _alPurple : _alLightPurple.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  h ? '★' : '·',
                  style: TextStyle(
                      color: h ? _alWhite : _alGray,
                      fontSize: h ? 10 : 8,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )),
        const SizedBox(width: 6),
        Expanded(
          child: Text(desc,
              style: const TextStyle(color: _alGray, fontSize: 10)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 10 — Real-World Examples
// ═══════════════════════════════════════════════════════════════
Widget _buildRealWorldExamples() {
  print('[Section 10] Real-world examples');
  return _alSection('Real-World Autocomplete Examples', [
    _alBody(
      'Autocomplete with keyboard navigation is common in these '
      'scenarios:',
    ),
    _alDivider(),
    _buildExampleCard(
      'Search Bar',
      Icons.search,
      _alAccentBlue,
      ['flutter widgets', 'flutter animation', 'flutter platform views',
       'flutter layout', 'flutter testing'],
      4,
    ),
    _buildExampleCard(
      'Email Autocomplete',
      Icons.email,
      _alAccentTeal,
      ['alice@example.com', 'bob@example.com', 'carol@example.com',
       'dave@example.com', 'eve@example.com'],
      4,
    ),
    _buildExampleCard(
      'City Picker',
      Icons.location_city,
      _alAccentOrange,
      ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix'],
      4,
    ),
  ]);
}

Widget _buildExampleCard(
    String name, IconData icon, Color color, List<String> options, int lastIdx) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(name,
                  style: TextStyle(
                      color: color, fontSize: 13, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        // Input field
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _alWhite,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color, width: 1.5),
          ),
          child: Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 8),
              const Text('fl...',
                  style: TextStyle(color: _alGray, fontSize: 12)),
            ],
          ),
        ),
        // Options dropdown
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _alWhite,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: options.asMap().entries.map((e) {
              final isLast = e.key == lastIdx;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isLast ? _alPurple.withValues(alpha: 0.1) : null,
                  border: isLast
                      ? Border.all(color: _alPurple.withValues(alpha: 0.3))
                      : null,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Text(e.value,
                        style: TextStyle(
                            color: isLast ? _alPurple : _alGray,
                            fontSize: 11,
                            fontWeight: isLast ? FontWeight.w700 : FontWeight.w400)),
                    if (isLast) ...[
                      const Spacer(),
                      const Text('← Ctrl+End',
                          style: TextStyle(color: _alPurple, fontSize: 9)),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 11 — Simulated Autocomplete Dropdown
// ═══════════════════════════════════════════════════════════════
Widget _buildSimulatedDropdown() {
  print('[Section 11] Simulated autocomplete dropdown');
  return _alSection('Simulated Autocomplete Dropdown', [
    _alBody(
      'This simulates a complete autocomplete experience showing the '
      'Last Option highlight in context:',
    ),
    _alDivider(),
    Container(
      decoration: BoxDecoration(
        color: _alLavender.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _alLightPurple),
      ),
      child: Column(
        children: [
          // Simulated app bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: _alPurple,
              borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, size: 16, color: _alWhite),
                SizedBox(width: 8),
                Text('Search Demo',
                    style: TextStyle(color: _alWhite, fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search field
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: _alWhite,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _alPurple, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: _alPurple.withValues(alpha: 0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 18, color: _alPurple),
                      const SizedBox(width: 8),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Flut',
                              style: TextStyle(
                                  color: _alDarkPurple,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: '│',
                              style: TextStyle(
                                  color: _alPurple,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                // Dropdown
                Container(
                  decoration: BoxDecoration(
                    color: _alWhite,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: _alPurple.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildDropdownItem('Flutter widgets', false),
                      _buildDropdownItem('Flutter animation', false),
                      _buildDropdownItem('Flutter layout', false),
                      _buildDropdownItem('Flutter state management', false),
                      _buildDropdownItem('Flutter platform views', false),
                      _buildDropdownItem('Flutter testing', false),
                      _buildDropdownItem('Flutter performance', true),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Keyboard legend
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _alPurple.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildKeyLegend('↑↓', 'Navigate'),
                      const SizedBox(width: 12),
                      _buildKeyLegend('Ctrl+End', 'Last ★'),
                      const SizedBox(width: 12),
                      _buildKeyLegend('Enter', 'Select'),
                      const SizedBox(width: 12),
                      _buildKeyLegend('Esc', 'Close'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ]);
}

Widget _buildDropdownItem(String text, bool isLast) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: isLast ? _alPurple.withValues(alpha: 0.12) : null,
      border: isLast
          ? const Border(left: BorderSide(color: _alPurple, width: 3))
          : null,
    ),
    child: Row(
      children: [
        Icon(
          isLast ? Icons.vertical_align_bottom : Icons.search,
          size: 14,
          color: isLast ? _alPurple : _alGray,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: isLast ? _alPurple : _alDarkPurple,
                  fontSize: 12,
                  fontWeight: isLast ? FontWeight.w700 : FontWeight.w400)),
        ),
        if (isLast)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _alPurple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('LAST',
                style: TextStyle(
                    color: _alWhite, fontSize: 8, fontWeight: FontWeight.w700)),
          ),
      ],
    ),
  );
}

Widget _buildKeyLegend(String key, String desc) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: _alWhite,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: _alLightPurple),
        ),
        child: Text(key,
            style: const TextStyle(
                color: _alDarkPurple, fontSize: 9,
                fontFamily: 'monospace', fontWeight: FontWeight.w600)),
      ),
      const SizedBox(width: 3),
      Text(desc,
          style: const TextStyle(color: _alGray, fontSize: 9)),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 12 — Summary
// ═══════════════════════════════════════════════════════════════
Widget _buildSummary() {
  print('[Section 12] Summary');
  print('AutocompleteLastOptionIntent deep demo complete.');
  return _alSection('Summary', [
    _alBody(
      'AutocompleteLastOptionIntent provides direct keyboard navigation '
      'to the last option in an Autocomplete dropdown. It\'s part of '
      'Flutter\'s Intent/Action/Shortcut system, ensuring accessible '
      'and efficient autocomplete interaction.',
    ),
    _alDivider(),
    _alLabel('Key Takeaways'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _alPurple.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _alBody('✦ Intent for jumping to the last autocomplete option'),
          _alBody('✦ Part of 4-intent navigation: First/Prev/Next/Last'),
          _alBody('✦ Triggered by Ctrl+End keyboard shortcut'),
          _alBody('✦ Uses Flutter\'s Intent → Action → Shortcuts system'),
          _alBody('✦ Integrated into the Autocomplete widget'),
          _alBody('✦ Essential for keyboard accessibility'),
          _alBody('✦ Direct jump — not sequential navigation'),
          _alBody('✦ Works across desktop, mobile, and web platforms'),
        ],
      ),
    ),
    _alDivider(),
    Wrap(
      children: [
        _alChip('AutocompleteLastOptionIntent', _alPurple),
        _alChip('Intent', _alMedPurple),
        _alChip('Keyboard', _alAccentBlue),
        _alChip('Navigation', _alAccentTeal),
        _alChip('Accessibility', _alAccentGreen),
      ],
    ),
  ]);
}

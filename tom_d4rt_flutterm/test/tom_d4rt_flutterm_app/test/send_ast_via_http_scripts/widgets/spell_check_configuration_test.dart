import 'package:flutter/material.dart';

const Color _bg = Color(0xFF121018);
const Color _surface = Color(0xFF211B2D);
const Color _surface2 = Color(0xFF312944);
const Color _text = Color(0xFFE7DAFF);
const Color _lavender = Color(0xFFBEA8FF);
const Color _mint = Color(0xFF7FE8C9);
const Color _peach = Color(0xFFFFB28C);
const Color _rose = Color(0xFFFF7FA0);
const Color _sky = Color(0xFF92C8FF);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _lavender,
        secondary: _mint,
        surface: _surface,
      ),
    ),
    home: const _SpellCheckConfigurationDemo(),
  );
}

class _SpellCheckConfigurationDemo extends StatefulWidget {
  const _SpellCheckConfigurationDemo();

  @override
  State<_SpellCheckConfigurationDemo> createState() => _SpellCheckConfigurationDemoState();
}

class _SpellCheckConfigurationDemoState extends State<_SpellCheckConfigurationDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _surface,
        title: const Text(
          'SpellCheckConfiguration Deep Demo',
          style: TextStyle(color: _mint, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _mint,
          labelColor: _mint,
          unselectedLabelColor: _text,
          tabs: const [
            Tab(text: 'Profiles'),
            Tab(text: 'Misspelling Canvas'),
            Tab(text: 'Toolbar Flow'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ProfilesTab(),
          _MisspellingCanvasTab(),
          _ToolbarFlowTab(),
        ],
      ),
    );
  }
}

class _ProfilesTab extends StatefulWidget {
  const _ProfilesTab();

  @override
  State<_ProfilesTab> createState() => _ProfilesTabState();
}

class _ProfilesTabState extends State<_ProfilesTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _ConfigProfile profile = _profiles[_selected];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section('What SpellCheckConfiguration Controls'),
          const SizedBox(height: 8),
          _panel(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Dot('Defines spell-check behavior for editable text surfaces.'),
                _Dot('Provides misspelled text style and selection highlight customization.'),
                _Dot('Can disable spell checking entirely using SpellCheckConfiguration.disabled().'),
                _Dot('Acts as a policy object: text widgets consume it to decide spell-check UX.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _section('Configuration Profiles'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_profiles.length, (int index) {
                    final bool active = index == _selected;
                    final _ConfigProfile item = _profiles[index];
                    return GestureDetector(
                      onTap: () => setState(() => _selected = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? item.color.withValues(alpha: 0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: active ? item.color : _surface2),
                        ),
                        child: Text(
                          item.name,
                          style: TextStyle(
                            color: active ? item.color : _text,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _profileCard(profile),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _section('Configuration Object Preview'),
          const SizedBox(height: 8),
          _panel(
            child: _code(
              profile.code,
            ),
          ),
          const SizedBox(height: 14),
          _section('copyWith Strategy'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Dot('Start with a baseline profile (for product consistency).'),
                _Dot('Use copyWith to adjust misspelledSelectionColor for context-specific affordance.'),
                _Dot('Adjust misspelledTextStyle per text density and accessibility constraints.'),
                _Dot('Keep semantic meaning stable across forms and editors.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _section('Live Style Tile'),
          const SizedBox(height: 8),
          _panel(
            child: _styleTile(profile),
          ),
        ],
      ),
    );
  }

  Widget _profileCard(_ConfigProfile profile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: profile.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: profile.color.withValues(alpha: 0.85)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(profile.summary, style: const TextStyle(color: _text, fontSize: 11)),
          const SizedBox(height: 8),
          ...profile.notes.map(
            (String note) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.chevron_right_rounded, color: profile.color, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(note, style: const TextStyle(color: _text, fontSize: 10))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _styleTile(_ConfigProfile profile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _surface2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: profile.color.withValues(alpha: 0.8)),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Spell-check demo sentence with a ',
              style: TextStyle(color: _text, fontSize: 12),
            ),
            TextSpan(
              text: 'mispeld',
              style: profile.misspelledStyle,
            ),
            const TextSpan(
              text: ' token highlighted according to profile policy.',
              style: TextStyle(color: _text, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _MisspellingCanvasTab extends StatefulWidget {
  const _MisspellingCanvasTab();

  @override
  State<_MisspellingCanvasTab> createState() => _MisspellingCanvasTabState();
}

class _MisspellingCanvasTabState extends State<_MisspellingCanvasTab>
    with AutomaticKeepAliveClientMixin {
  int _profileIndex = 1;
  bool _showSelectionOverlay = true;
  bool _showUnderline = true;
  bool _showBadges = true;

  final TextEditingController _editorController = TextEditingController(
    text: 'Ths sentence hass a few misspelled words and a confg typo in this editor canvas.',
  );

  final List<String> _knownTypos = <String>[
    'ths',
    'hass',
    'mispeld',
    'confg',
    'teh',
    'recieve',
    'adress',
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _editorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _ConfigProfile profile = _profiles[_profileIndex];
    final List<_TokenSegment> segments = _segmentText(_editorController.text, _knownTypos);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section('Misspelling Visualization Canvas'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Profile:', style: TextStyle(color: _text, fontSize: 11)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton<int>(
                        value: _profileIndex,
                        dropdownColor: _surface2,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        items: List.generate(_profiles.length, (int index) {
                          return DropdownMenuItem<int>(
                            value: index,
                            child: Text(_profiles[index].name, style: const TextStyle(color: _text, fontSize: 11)),
                          );
                        }),
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() => _profileIndex = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _showSelectionOverlay,
                  activeThumbColor: _sky,
                  title: const Text('Show misspelled selection overlay', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool value) => setState(() => _showSelectionOverlay = value),
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _showUnderline,
                  activeThumbColor: _rose,
                  title: const Text('Show underline emphasis', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool value) => setState(() => _showUnderline = value),
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _showBadges,
                  activeThumbColor: _mint,
                  title: const Text('Show typo badges', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool value) => setState(() => _showBadges = value),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _editorController,
                  minLines: 3,
                  maxLines: 5,
                  style: const TextStyle(color: _text),
                  decoration: InputDecoration(
                    labelText: 'Editable sample text',
                    labelStyle: const TextStyle(color: _text),
                    filled: true,
                    fillColor: _surface2,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _section('Rendered Preview'),
          const SizedBox(height: 8),
          _panel(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _surface2,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: profile.color.withValues(alpha: 0.85)),
              ),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: segments.map((segment) {
                  if (!segment.misspelled) {
                    return Text(segment.text, style: const TextStyle(color: _text, fontSize: 13));
                  }

                  TextStyle style = profile.misspelledStyle;
                  if (!_showUnderline) {
                    style = style.copyWith(decoration: TextDecoration.none);
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    decoration: BoxDecoration(
                      color: _showSelectionOverlay
                          ? profile.selectionColor.withValues(alpha: 0.33)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(segment.text, style: style),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 14),
          if (_showBadges) ...[
            _section('Detected Typo Tokens'),
            const SizedBox(height: 8),
            _panel(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: segments
                    .where((s) => s.misspelled)
                    .map(
                      (s) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                        decoration: BoxDecoration(
                          color: profile.color.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: profile.color.withValues(alpha: 0.85)),
                        ),
                        child: Text(
                          s.text,
                          style: TextStyle(color: profile.color, fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 14),
          ],
          _section('Interpretation'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Dot('misspelledTextStyle should be visible but still readable in long-form content.'),
                _Dot('misspelledSelectionColor should provide contrast against both light and dark editor themes.'),
                _Dot('Profile choices can communicate severity: subtle for drafts, stronger for final review.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<_TokenSegment> _segmentText(String text, List<String> typos) {
    final List<_TokenSegment> segments = <_TokenSegment>[];
    final RegExp split = RegExp(r'(\s+)');
    final List<String> pieces = text.split(split);
    for (final String piece in pieces) {
      if (piece.trim().isEmpty) {
        segments.add(_TokenSegment(piece, false));
        continue;
      }
      final String canonical = piece.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');
      final bool misspelled = typos.contains(canonical);
      segments.add(_TokenSegment(piece, misspelled));
    }
    return segments;
  }
}

class _ToolbarFlowTab extends StatefulWidget {
  const _ToolbarFlowTab();

  @override
  State<_ToolbarFlowTab> createState() => _ToolbarFlowTabState();
}

class _ToolbarFlowTabState extends State<_ToolbarFlowTab>
    with AutomaticKeepAliveClientMixin {
  int _step = 0;
  bool _autoReplace = false;
  bool _includeIgnore = true;
  bool _includeAddToDictionary = true;
  final List<String> _timeline = <String>[];

  @override
  void initState() {
    super.initState();
    _timeline.add('Spell-check toolbar flow initialized.');
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _FlowStep flow = _flow[_step];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section('Suggestions Toolbar Flow'),
          const SizedBox(height: 8),
          _panel(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Dot('A spell-check toolbar presents candidate fixes and policy actions for misspelled selections.'),
                _Dot('SpellCheckConfiguration can provide custom toolbar behavior through builder configuration.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _section('Flow Step Control'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_flow.length, (int index) {
                    final bool active = index == _step;
                    final _FlowStep item = _flow[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() => _step = index);
                        _push('step -> ${item.name}');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? item.color.withValues(alpha: 0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: active ? item.color : _surface2),
                        ),
                        child: Text(
                          item.name,
                          style: TextStyle(
                            color: active ? item.color : _text,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _autoReplace,
                  activeThumbColor: _mint,
                  title: const Text('Auto-replace top suggestion', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool value) {
                    setState(() => _autoReplace = value);
                    _push('auto replace -> $value');
                  },
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _includeIgnore,
                  activeThumbColor: _sky,
                  title: const Text('Include Ignore option', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool value) {
                    setState(() => _includeIgnore = value);
                    _push('include ignore -> $value');
                  },
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _includeAddToDictionary,
                  activeThumbColor: _peach,
                  title: const Text('Include Add to Dictionary option', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool value) {
                    setState(() => _includeAddToDictionary = value);
                    _push('include add-to-dictionary -> $value');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _section('Toolbar Preview'),
          const SizedBox(height: 8),
          _panel(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: flow.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: flow.color.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(flow.name, style: TextStyle(color: flow.color, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(flow.description, style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _actionChip('replace: misspelled -> misspelled', _mint),
                      _actionChip('replace: confg -> config', _mint),
                      if (_includeIgnore) _actionChip('ignore', _sky),
                      if (_includeAddToDictionary) _actionChip('add to dictionary', _peach),
                      if (_autoReplace) _actionChip('auto-apply top suggestion', _rose),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _section('Flow Notes'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Dot(_autoReplace
                    ? 'Auto-replace is enabled: confirm this aligns with user expectations in high-risk input contexts.'
                    : 'Auto-replace disabled: user confirmation remains explicit for each correction.'),
                _Dot(_includeIgnore
                    ? 'Ignore action is available for domain-specific terms.'
                    : 'Ignore action hidden; consider discoverability implications.'),
                _Dot(_includeAddToDictionary
                    ? 'Add-to-dictionary supports personalization and reduces repeated false positives.'
                    : 'No dictionary add path; repeated suggestions may annoy advanced users.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _section('Timeline'),
          const SizedBox(height: 8),
          _panel(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _surface2),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _timeline.length,
                itemBuilder: (BuildContext context, int index) {
                  final String row = _timeline[_timeline.length - 1 - index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: _surface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(row, style: const TextStyle(color: _lavender, fontFamily: 'monospace', fontSize: 10)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }

  void _push(String event) {
    final String t = TimeOfDay.now().format(context);
    setState(() {
      _timeline.add('$t | $event');
      if (_timeline.length > 40) {
        _timeline.removeAt(0);
      }
    });
  }
}

class _ConfigProfile {
  const _ConfigProfile({
    required this.name,
    required this.summary,
    required this.notes,
    required this.misspelledStyle,
    required this.selectionColor,
    required this.color,
    required this.code,
  });

  final String name;
  final String summary;
  final List<String> notes;
  final TextStyle misspelledStyle;
  final Color selectionColor;
  final Color color;
  final String code;
}

class _TokenSegment {
  const _TokenSegment(this.text, this.misspelled);

  final String text;
  final bool misspelled;
}

class _FlowStep {
  const _FlowStep({
    required this.name,
    required this.description,
    required this.color,
  });

  final String name;
  final String description;
  final Color color;
}

const List<_FlowStep> _flow = [
  _FlowStep(
    name: 'Detect',
    description: 'Text input marks suspicious token ranges as misspelled candidates.',
    color: _sky,
  ),
  _FlowStep(
    name: 'Select',
    description: 'User selects misspelled token and requests correction options.',
    color: _lavender,
  ),
  _FlowStep(
    name: 'Suggest',
    description: 'Suggestions toolbar appears with replacements and policy actions.',
    color: _mint,
  ),
  _FlowStep(
    name: 'Apply',
    description: 'Replacement or ignore action updates text and spell-check state.',
    color: _peach,
  ),
  _FlowStep(
    name: 'Review',
    description: 'Next pass validates remaining text and clears resolved highlights.',
    color: _rose,
  ),
];

const List<_ConfigProfile> _profiles = [
  _ConfigProfile(
    name: 'Disabled',
    summary: 'Spell checking is intentionally disabled for this editing context.',
    notes: [
      'Useful for code blocks, commands, or identifiers with non-dictionary tokens.',
      'Avoids noisy false positives in highly technical text.',
    ],
    misspelledStyle: TextStyle(
      color: _text,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
    ),
    selectionColor: Color(0x00000000),
    color: _sky,
    code: 'const SpellCheckConfiguration.disabled()',
  ),
  _ConfigProfile(
    name: 'Writer Draft',
    summary: 'Balanced visibility with light underlines and soft overlays for drafting.',
    notes: [
      'Encourages flow without harsh interruption.',
      'Good default for general note-taking and content drafting.',
    ],
    misspelledStyle: TextStyle(
      color: _text,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.wavy,
      decorationColor: _peach,
      fontWeight: FontWeight.w600,
    ),
    selectionColor: Color(0x44FFB28C),
    color: _peach,
    code: 'SpellCheckConfiguration(\n'
        '  misspelledTextStyle: TextStyle(\n'
        '    decoration: TextDecoration.underline,\n'
        '    decorationStyle: TextDecorationStyle.wavy,\n'
        '    decorationColor: Color(0xFFFFB28C),\n'
        '  ),\n'
        '  misspelledSelectionColor: Color(0x44FFB28C),\n'
        ')',
  ),
  _ConfigProfile(
    name: 'Strict Review',
    summary: 'High-contrast emphasis for QA pass and final proofreading stages.',
    notes: [
      'Highlights aggressively to reduce missed errors before publishing.',
      'Pairs well with mandatory review workflows.',
    ],
    misspelledStyle: TextStyle(
      color: _rose,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.wavy,
      decorationColor: _rose,
      fontWeight: FontWeight.w800,
    ),
    selectionColor: Color(0x55FF7FA0),
    color: _rose,
    code: 'SpellCheckConfiguration(\n'
        '  misspelledTextStyle: TextStyle(\n'
        '    color: Color(0xFFFF7FA0),\n'
        '    decoration: TextDecoration.underline,\n'
        '    decorationStyle: TextDecorationStyle.wavy,\n'
        '    decorationColor: Color(0xFFFF7FA0),\n'
        '    fontWeight: FontWeight.w800,\n'
        '  ),\n'
        '  misspelledSelectionColor: Color(0x55FF7FA0),\n'
        ')',
  ),
  _ConfigProfile(
    name: 'Accessible Contrast',
    summary: 'Accessibility-first style for strong visibility across varied displays.',
    notes: [
      'Increases thickness and color contrast for low-vision support.',
      'Recommended in enterprise accessibility presets.',
    ],
    misspelledStyle: TextStyle(
      color: _mint,
      decoration: TextDecoration.underline,
      decorationThickness: 2,
      decorationColor: _mint,
      fontWeight: FontWeight.w700,
    ),
    selectionColor: Color(0x557FE8C9),
    color: _mint,
    code: 'SpellCheckConfiguration(\n'
        '  misspelledTextStyle: TextStyle(\n'
        '    color: Color(0xFF7FE8C9),\n'
        '    decoration: TextDecoration.underline,\n'
        '    decorationThickness: 2,\n'
        '    decorationColor: Color(0xFF7FE8C9),\n'
        '  ),\n'
        '  misspelledSelectionColor: Color(0x557FE8C9),\n'
        ')',
  ),
];

class _Dot extends StatelessWidget {
  const _Dot(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(color: _mint, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _text, fontSize: 11))),
        ],
      ),
    );
  }
}

Widget _section(String text) {
  return Text(
    text,
    style: const TextStyle(color: _mint, fontSize: 14, fontWeight: FontWeight.w700),
  );
}

Widget _panel({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _surface2),
    ),
    child: child,
  );
}

Widget _code(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _surface2),
    ),
    child: Text(
      text,
      style: const TextStyle(color: _lavender, fontSize: 10, fontFamily: 'monospace'),
    ),
  );
}

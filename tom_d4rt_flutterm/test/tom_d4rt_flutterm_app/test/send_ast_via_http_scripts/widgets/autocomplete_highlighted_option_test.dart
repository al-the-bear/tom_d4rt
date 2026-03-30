import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _Palette {
  final String name;
  final Color shell;
  final Color canvas;
  final Color card;
  final Color ink;
  final Color muted;
  final Color accent;
  final Color accent2;
  final Color accent3;

  const _Palette({
    required this.name,
    required this.shell,
    required this.canvas,
    required this.card,
    required this.ink,
    required this.muted,
    required this.accent,
    required this.accent2,
    required this.accent3,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Studio Cyan',
    shell: Color(0xFF111C24),
    canvas: Color(0xFFF2F8FB),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF1E2B35),
    muted: Color(0xFF6B7F91),
    accent: Color(0xFF1677FF),
    accent2: Color(0xFF08A88A),
    accent3: Color(0xFFF29F05),
  ),
  _Palette(
    name: 'Moss Ember',
    shell: Color(0xFF1B2417),
    canvas: Color(0xFFF5FAF2),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF283323),
    muted: Color(0xFF74836E),
    accent: Color(0xFF2C7A37),
    accent2: Color(0xFF1A9773),
    accent3: Color(0xFFD48A2D),
  ),
  _Palette(
    name: 'Noir Rose',
    shell: Color(0xFF221628),
    canvas: Color(0xFFFAF5FB),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF2F2138),
    muted: Color(0xFF8A7397),
    accent: Color(0xFF7452E5),
    accent2: Color(0xFFC43C88),
    accent3: Color(0xFF3DA69B),
  ),
];

class _CommandItem {
  final String id;
  final String title;
  final String category;
  final String description;
  final String shortcut;
  final int complexity;

  const _CommandItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.shortcut,
    required this.complexity,
  });
}

const _catalog = <_CommandItem>[
  _CommandItem(
    id: 'open-file',
    title: 'Open File',
    category: 'Navigation',
    description: 'Jump to any file in the workspace from a searchable modal.',
    shortcut: 'Ctrl+P',
    complexity: 1,
  ),
  _CommandItem(
    id: 'go-symbol',
    title: 'Go to Symbol',
    category: 'Navigation',
    description: 'Find and navigate to symbols in the current document.',
    shortcut: 'Ctrl+Shift+O',
    complexity: 2,
  ),
  _CommandItem(
    id: 'go-definition',
    title: 'Go to Definition',
    category: 'Navigation',
    description: 'Open the definition of the symbol under cursor.',
    shortcut: 'F12',
    complexity: 2,
  ),
  _CommandItem(
    id: 'peek-definition',
    title: 'Peek Definition',
    category: 'Navigation',
    description: 'Inspect symbol definition inline without leaving current file.',
    shortcut: 'Alt+F12',
    complexity: 2,
  ),
  _CommandItem(
    id: 'find-references',
    title: 'Find References',
    category: 'Navigation',
    description: 'Locate all usages for selected symbol in the workspace.',
    shortcut: 'Shift+F12',
    complexity: 3,
  ),
  _CommandItem(
    id: 'rename-symbol',
    title: 'Rename Symbol',
    category: 'Refactor',
    description: 'Safely rename symbol and update all references.',
    shortcut: 'F2',
    complexity: 3,
  ),
  _CommandItem(
    id: 'extract-method',
    title: 'Extract Method',
    category: 'Refactor',
    description: 'Move selected logic into a reusable function.',
    shortcut: 'Ctrl+.',
    complexity: 4,
  ),
  _CommandItem(
    id: 'inline-variable',
    title: 'Inline Variable',
    category: 'Refactor',
    description: 'Replace variable references with assigned expression.',
    shortcut: 'Ctrl+.',
    complexity: 4,
  ),
  _CommandItem(
    id: 'reformat-file',
    title: 'Format Document',
    category: 'Editing',
    description: 'Apply formatter rules to entire current document.',
    shortcut: 'Shift+Alt+F',
    complexity: 1,
  ),
  _CommandItem(
    id: 'format-selection',
    title: 'Format Selection',
    category: 'Editing',
    description: 'Format only the selected code region.',
    shortcut: 'Ctrl+K Ctrl+F',
    complexity: 1,
  ),
  _CommandItem(
    id: 'toggle-comment',
    title: 'Toggle Line Comment',
    category: 'Editing',
    description: 'Comment or uncomment selected lines.',
    shortcut: 'Ctrl+/',
    complexity: 1,
  ),
  _CommandItem(
    id: 'multi-cursor',
    title: 'Add Cursor Above',
    category: 'Editing',
    description: 'Create a new cursor on line above for parallel edits.',
    shortcut: 'Ctrl+Alt+Up',
    complexity: 2,
  ),
  _CommandItem(
    id: 'search-files',
    title: 'Search in Files',
    category: 'Search',
    description: 'Global text search with include and exclude patterns.',
    shortcut: 'Ctrl+Shift+F',
    complexity: 2,
  ),
  _CommandItem(
    id: 'replace-files',
    title: 'Replace in Files',
    category: 'Search',
    description: 'Workspace-wide replacement with preview support.',
    shortcut: 'Ctrl+Shift+H',
    complexity: 3,
  ),
  _CommandItem(
    id: 'regex-toggle',
    title: 'Toggle Regex Search',
    category: 'Search',
    description: 'Enable regular expression mode in search panel.',
    shortcut: 'Alt+R',
    complexity: 2,
  ),
  _CommandItem(
    id: 'open-terminal',
    title: 'Toggle Terminal',
    category: 'Terminal',
    description: 'Open or hide integrated terminal panel.',
    shortcut: 'Ctrl+`',
    complexity: 1,
  ),
  _CommandItem(
    id: 'split-terminal',
    title: 'Split Terminal',
    category: 'Terminal',
    description: 'Create another terminal pane in the same panel.',
    shortcut: 'Ctrl+Shift+5',
    complexity: 2,
  ),
  _CommandItem(
    id: 'clear-terminal',
    title: 'Clear Terminal',
    category: 'Terminal',
    description: 'Clear terminal scrollback output for a clean run.',
    shortcut: 'Ctrl+L',
    complexity: 1,
  ),
  _CommandItem(
    id: 'run-task',
    title: 'Run Task',
    category: 'Build',
    description: 'Execute configured task from project task list.',
    shortcut: 'Ctrl+Shift+B',
    complexity: 2,
  ),
  _CommandItem(
    id: 'debug-start',
    title: 'Start Debugging',
    category: 'Debug',
    description: 'Launch debug session using active launch config.',
    shortcut: 'F5',
    complexity: 2,
  ),
  _CommandItem(
    id: 'debug-step',
    title: 'Step Over',
    category: 'Debug',
    description: 'Advance debugger to next statement in current frame.',
    shortcut: 'F10',
    complexity: 2,
  ),
  _CommandItem(
    id: 'toggle-breakpoint',
    title: 'Toggle Breakpoint',
    category: 'Debug',
    description: 'Enable or disable breakpoint on active line.',
    shortcut: 'F9',
    complexity: 1,
  ),
  _CommandItem(
    id: 'source-control',
    title: 'Open Source Control',
    category: 'Git',
    description: 'Focus source control panel with staged and unstaged changes.',
    shortcut: 'Ctrl+Shift+G',
    complexity: 2,
  ),
  _CommandItem(
    id: 'stage-all',
    title: 'Stage All Changes',
    category: 'Git',
    description: 'Stage every modified file in the repository.',
    shortcut: 'UI Action',
    complexity: 2,
  ),
  _CommandItem(
    id: 'commit',
    title: 'Commit Changes',
    category: 'Git',
    description: 'Create commit from staged changes with message.',
    shortcut: 'UI Action',
    complexity: 3,
  ),
  _CommandItem(
    id: 'pull',
    title: 'Pull from Remote',
    category: 'Git',
    description: 'Fetch and merge latest remote branch changes.',
    shortcut: 'UI Action',
    complexity: 2,
  ),
  _CommandItem(
    id: 'push',
    title: 'Push to Remote',
    category: 'Git',
    description: 'Upload local commits to tracked remote branch.',
    shortcut: 'UI Action',
    complexity: 2,
  ),
  _CommandItem(
    id: 'open-settings',
    title: 'Open Settings',
    category: 'Workbench',
    description: 'Open settings UI with search and scopes.',
    shortcut: 'Ctrl+,',
    complexity: 1,
  ),
  _CommandItem(
    id: 'color-theme',
    title: 'Select Color Theme',
    category: 'Workbench',
    description: 'Switch editor theme from command picker.',
    shortcut: 'Ctrl+K Ctrl+T',
    complexity: 1,
  ),
  _CommandItem(
    id: 'zen-mode',
    title: 'Toggle Zen Mode',
    category: 'Workbench',
    description: 'Hide UI chrome for focused editing.',
    shortcut: 'Ctrl+K Z',
    complexity: 1,
  ),
  _CommandItem(
    id: 'panel-position',
    title: 'Move Panel Right',
    category: 'Workbench',
    description: 'Relocate panel to right side of workbench.',
    shortcut: 'Command Palette',
    complexity: 2,
  ),
  _CommandItem(
    id: 'extensions-view',
    title: 'Open Extensions',
    category: 'Extensions',
    description: 'Browse and install marketplace extensions.',
    shortcut: 'Ctrl+Shift+X',
    complexity: 1,
  ),
  _CommandItem(
    id: 'reload-window',
    title: 'Developer Reload Window',
    category: 'Extensions',
    description: 'Reload the current window after extension changes.',
    shortcut: 'Command Palette',
    complexity: 2,
  ),
  _CommandItem(
    id: 'snippet-config',
    title: 'Configure User Snippets',
    category: 'Extensions',
    description: 'Create reusable snippet definitions for languages.',
    shortcut: 'Command Palette',
    complexity: 2,
  ),
  _CommandItem(
    id: 'problems-view',
    title: 'Open Problems',
    category: 'Quality',
    description: 'Inspect diagnostics from analyzers and linters.',
    shortcut: 'Ctrl+Shift+M',
    complexity: 1,
  ),
  _CommandItem(
    id: 'quick-fix',
    title: 'Quick Fix',
    category: 'Quality',
    description: 'Apply suggested fix for selected diagnostic.',
    shortcut: 'Ctrl+.',
    complexity: 2,
  ),
  _CommandItem(
    id: 'run-tests',
    title: 'Run Tests',
    category: 'Quality',
    description: 'Execute test suite and collect result output.',
    shortcut: 'Testing Panel',
    complexity: 2,
  ),
  _CommandItem(
    id: 'coverage-view',
    title: 'Toggle Coverage',
    category: 'Quality',
    description: 'Display line coverage from latest test run.',
    shortcut: 'Testing Panel',
    complexity: 3,
  ),
  _CommandItem(
    id: 'remote-ssh',
    title: 'Connect to Host',
    category: 'Remote',
    description: 'Start remote SSH workspace session.',
    shortcut: 'Command Palette',
    complexity: 3,
  ),
  _CommandItem(
    id: 'port-forward',
    title: 'Forward Port',
    category: 'Remote',
    description: 'Forward remote service port to local machine.',
    shortcut: 'Ports View',
    complexity: 3,
  ),
  _CommandItem(
    id: 'dev-container',
    title: 'Reopen in Container',
    category: 'Remote',
    description: 'Rebuild and reopen project inside development container.',
    shortcut: 'Command Palette',
    complexity: 4,
  ),
];

enum _Stage {
  spotlight,
  catalog,
  styleLab,
  keyboardArena,
  diagnostics,
  compendium,
}

enum _LaneStyle {
  listCards,
  chipGrid,
  splitPreview,
}

enum _Density {
  sparse,
  normal,
  dense,
}

class _TraceEvent {
  final DateTime time;
  final String lane;
  final String message;
  final Color tone;

  const _TraceEvent({
    required this.time,
    required this.lane,
    required this.message,
    required this.tone,
  });
}

dynamic build(BuildContext context) {
  return const _AutocompleteHighlightedOptionDemo();
}

class _AutocompleteHighlightedOptionDemo extends StatefulWidget {
  const _AutocompleteHighlightedOptionDemo();

  @override
  State<_AutocompleteHighlightedOptionDemo> createState() => _AutocompleteHighlightedOptionDemoState();
}

class _AutocompleteHighlightedOptionDemoState extends State<_AutocompleteHighlightedOptionDemo> {
  _Stage _stage = _Stage.spotlight;
  _Density _density = _Density.normal;
  int _paletteIndex = 0;

  bool _caseSensitive = false;
  bool _prefixOnly = false;
  bool _showTimeline = true;
  bool _showHints = true;
  bool _showMetrics = true;
  bool _verboseLogs = false;

  int _maxResults = 8;
  double _timelineHeight = 260;
  double _laneHeight = 360;
  double _arenaHeight = 340;

  int _selectionCount = 0;
  int _highlightEvents = 0;

  final List<_TraceEvent> _trace = <_TraceEvent>[];
  final Map<String, int> _highlightIndexByLane = <String, int>{};
  final Map<String, _CommandItem?> _selectedByLane = <String, _CommandItem?>{};
  final Map<String, List<_CommandItem>> _lastOptionsByLane = <String, List<_CommandItem>>{};

  static const _stageTitles = <String>[
    '1 Command Spotlight',
    '2 Multi-Lane Catalog',
    '3 Highlight Styling Lab',
    '4 Keyboard Arena',
    '5 Diagnostics Deck',
    '6 Verification Compendium',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  int get _effectiveMaxResults {
    switch (_density) {
      case _Density.sparse:
        return (_maxResults * 0.7).round().clamp(3, 20);
      case _Density.normal:
        return _maxResults;
      case _Density.dense:
        return (_maxResults * 1.5).round().clamp(3, 20);
    }
  }

  @override
  void initState() {
    super.initState();
    _pushTrace('system', 'AutocompleteHighlightedOption demo initialized.', _p.accent);
  }

  void _pushTrace(String lane, String message, Color tone) {
    final event = _TraceEvent(time: DateTime.now(), lane: lane, message: message, tone: tone);
    setState(() {
      _trace.insert(0, event);
      if (_trace.length > 50) {
        _trace.removeRange(50, _trace.length);
      }
    });
    if (_verboseLogs) {
      debugPrint('[AutocompleteHighlightedOption][$lane] $message');
    }
  }

  void _onHighlightChanged(String lane, int index, List<_CommandItem> options) {
    final previousIndex = _highlightIndexByLane[lane];
    final previousList = _lastOptionsByLane[lane];
    if (previousIndex == index && listEquals(previousList, options)) {
      return;
    }
    setState(() {
      _highlightIndexByLane[lane] = index;
      _lastOptionsByLane[lane] = List<_CommandItem>.from(options);
      _highlightEvents += 1;
    });
    final label = index >= 0 && index < options.length ? options[index].title : 'none';
    _pushTrace(lane, 'highlight index -> $index ($label)', _p.accent2);
  }

  void _onSelected(String lane, _CommandItem item) {
    setState(() {
      _selectionCount += 1;
      _selectedByLane[lane] = item;
    });
    _pushTrace(lane, 'selected: ${item.title}', _p.accent3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.canvas,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _header(),
            _toolbar(),
            Expanded(child: _body()),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_p.shell, _p.accent.withValues(alpha: 0.88)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.auto_awesome_motion_rounded, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'AutocompleteHighlightedOption Deep Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'RawAutocomplete Focus Index',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'AutocompleteHighlightedOption exposes the keyboard-highlighted option '
            'inside a custom optionsViewBuilder. This demo shows multiple visual '
            'patterns driven by that highlighted index.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.94),
              fontSize: 12.3,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      width: double.infinity,
      color: _p.accent.withValues(alpha: 0.07),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text('Stage', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _stageTitles.length; i++) _stageChip(i),
          const SizedBox(width: 10),
          Text('Density', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          _densityChip('Sparse', _Density.sparse),
          _densityChip('Normal', _Density.normal),
          _densityChip('Dense', _Density.dense),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
        ],
      ),
    );
  }

  Widget _stageChip(int index) {
    return ChoiceChip(
      selected: _stage.index == index,
      selectedColor: _p.accent,
      backgroundColor: Colors.white,
      label: Text('${index + 1}'),
      labelStyle: TextStyle(
        color: _stage.index == index ? Colors.white : _p.ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => setState(() => _stage = _Stage.values[index]),
    );
  }

  Widget _densityChip(String label, _Density value) {
    return ChoiceChip(
      selected: _density == value,
      selectedColor: _p.accent2,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _density == value ? Colors.white : _p.ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => setState(() => _density = value),
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () => setState(() => _paletteIndex = index),
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].accent,
          border: Border.all(
            color: _paletteIndex == index ? _palettes[index].accent3 : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _body() {
    switch (_stage) {
      case _Stage.spotlight:
        return _spotlightStage();
      case _Stage.catalog:
        return _catalogStage();
      case _Stage.styleLab:
        return _styleLabStage();
      case _Stage.keyboardArena:
        return _keyboardArenaStage();
      case _Stage.diagnostics:
        return _diagnosticsStage();
      case _Stage.compendium:
        return _compendiumStage();
    }
  }

  Widget _spotlightStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Command Spotlight'),
          const SizedBox(height: 8),
          Text(
            'This baseline lane demonstrates AutocompleteHighlightedOption.of(context) '
            'inside a custom optionsViewBuilder. Navigate with arrow keys to see '
            'the highlighted option drive visual emphasis.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Global Controls',
            subtitle: 'Tune filtering and telemetry behavior.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'max results',
                  value: _maxResults.toDouble(),
                  min: 3,
                  max: 20,
                  divisions: 17,
                  color: _p.accent,
                  onChanged: (v) => setState(() => _maxResults = v.round()),
                ),
                _slider(
                  label: 'lane height',
                  value: _laneHeight,
                  min: 260,
                  max: 540,
                  divisions: 28,
                  color: _p.accent2,
                  onChanged: (v) => setState(() => _laneHeight = v),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _toggleChip('case sensitive', _caseSensitive, (v) => _caseSensitive = v),
                    _toggleChip('prefix only', _prefixOnly, (v) => _prefixOnly = v),
                    _toggleChip('show hints', _showHints, (v) => _showHints = v),
                    _toggleChip('show metrics', _showMetrics, (v) => _showMetrics = v),
                    _toggleChip('show timeline', _showTimeline, (v) => _showTimeline = v),
                    _toggleChip('verbose logs', _verboseLogs, (v) => _verboseLogs = v),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Spotlight Lane',
            subtitle: 'Arrow keys update highlighted index via AutocompleteHighlightedOption.',
            tint: _p.accent.withValues(alpha: 0.04),
            child: SizedBox(
              height: _laneHeight,
              child: _HighlightLane(
                laneId: 'spotlight',
                title: 'Command Spotlight',
                subtitle: 'Try typing "go", "debug", or "terminal" then navigate with arrows.',
                style: _LaneStyle.listCards,
                catalog: _catalog,
                palette: _p,
                maxResults: _effectiveMaxResults,
                caseSensitive: _caseSensitive,
                prefixOnly: _prefixOnly,
                showHints: _showHints,
                onHighlightChanged: _onHighlightChanged,
                onSelected: _onSelected,
              ),
            ),
          ),
          if (_showMetrics) ...<Widget>[
            const SizedBox(height: 12),
            _metricsBoard(),
          ],
        ],
      ),
    );
  }

  Widget _catalogStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Multi-Lane Catalog'),
          const SizedBox(height: 8),
          Text(
            'The highlighted index can drive different visual structures: '
            'classic option rows, chip-grid cards, and split preview layouts.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              SizedBox(
                width: 500,
                child: _panel(
                  title: 'List Card Renderer',
                  subtitle: 'Highlight row with side accent and detailed metadata.',
                  tint: _p.accent.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _laneHeight,
                    child: _HighlightLane(
                      laneId: 'catalog-list',
                      title: 'List renderer',
                      subtitle: 'Focus index animates card border and category stripe.',
                      style: _LaneStyle.listCards,
                      catalog: _catalog,
                      palette: _p,
                      maxResults: _effectiveMaxResults,
                      caseSensitive: _caseSensitive,
                      prefixOnly: _prefixOnly,
                      showHints: _showHints,
                      onHighlightChanged: _onHighlightChanged,
                      onSelected: _onSelected,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 500,
                child: _panel(
                  title: 'Chip Grid Renderer',
                  subtitle: 'Highlight index controls chip elevation and ring.',
                  tint: _p.accent2.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _laneHeight,
                    child: _HighlightLane(
                      laneId: 'catalog-grid',
                      title: 'Chip grid renderer',
                      subtitle: 'Highlight state appears as halo around active chip.',
                      style: _LaneStyle.chipGrid,
                      catalog: _catalog,
                      palette: _p,
                      maxResults: _effectiveMaxResults,
                      caseSensitive: _caseSensitive,
                      prefixOnly: _prefixOnly,
                      showHints: _showHints,
                      onHighlightChanged: _onHighlightChanged,
                      onSelected: _onSelected,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _styleLabStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Highlight Styling Lab'),
          const SizedBox(height: 8),
          Text(
            'The same highlighted index can orchestrate complex UI patterns. '
            'This stage uses split preview and category-rich cards.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Split Preview Lane',
            subtitle: 'Left options panel and right highlight preview driven by AutocompleteHighlightedOption.',
            tint: _p.accent3.withValues(alpha: 0.06),
            child: SizedBox(
              height: _laneHeight + 50,
              child: _HighlightLane(
                laneId: 'style-split',
                title: 'Split preview renderer',
                subtitle: 'Highlighted option updates preview card in real-time.',
                style: _LaneStyle.splitPreview,
                catalog: _catalog,
                palette: _p,
                maxResults: _effectiveMaxResults,
                caseSensitive: _caseSensitive,
                prefixOnly: _prefixOnly,
                showHints: _showHints,
                onHighlightChanged: _onHighlightChanged,
                onSelected: _onSelected,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Usage Notes',
            subtitle: 'Practical styling guidance for highlighted option visuals.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _bullet('Read AutocompleteHighlightedOption.of(context) only inside optionsViewBuilder subtree.'),
                _bullet('Use highlighted index to style rows, chips, previews, and detail panes.'),
                _bullet('Keep option list deterministic so index-to-item mapping remains stable.'),
                _bullet('Include keyboard hints so users understand highlight navigation behavior.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _keyboardArenaStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Keyboard Arena'),
          const SizedBox(height: 8),
          Text(
            'Arena mode compares two independent lanes. Both expose highlight '
            'state telemetry to confirm index transitions while typing and pressing arrows.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Arena Height',
            subtitle: 'Adjust for long option lists and compact/expanded panels.',
            child: _slider(
              label: 'arena lane height',
              value: _arenaHeight,
              min: 240,
              max: 520,
              divisions: 28,
              color: _p.accent2,
              onChanged: (v) => setState(() => _arenaHeight = v),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              SizedBox(
                width: 500,
                child: _panel(
                  title: 'Arena A',
                  subtitle: 'List-focused renderer.',
                  tint: _p.accent.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _arenaHeight,
                    child: _HighlightLane(
                      laneId: 'arena-a',
                      title: 'Arena lane A',
                      subtitle: 'Classic list cards with keyboard highlight flow.',
                      style: _LaneStyle.listCards,
                      catalog: _catalog,
                      palette: _p,
                      maxResults: _effectiveMaxResults,
                      caseSensitive: _caseSensitive,
                      prefixOnly: _prefixOnly,
                      showHints: _showHints,
                      onHighlightChanged: _onHighlightChanged,
                      onSelected: _onSelected,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 500,
                child: _panel(
                  title: 'Arena B',
                  subtitle: 'Chip-focused renderer.',
                  tint: _p.accent2.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _arenaHeight,
                    child: _HighlightLane(
                      laneId: 'arena-b',
                      title: 'Arena lane B',
                      subtitle: 'Chip grid with highlighted halo and index board.',
                      style: _LaneStyle.chipGrid,
                      catalog: _catalog,
                      palette: _p,
                      maxResults: _effectiveMaxResults,
                      caseSensitive: _caseSensitive,
                      prefixOnly: _prefixOnly,
                      showHints: _showHints,
                      onHighlightChanged: _onHighlightChanged,
                      onSelected: _onSelected,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showMetrics) ...<Widget>[
            const SizedBox(height: 12),
            _panel(
              title: 'Arena Metrics',
              subtitle: 'Current highlight and selection snapshots by lane.',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (final lane in <String>['arena-a', 'arena-b']) _laneMetric(lane),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _laneMetric(String lane) {
    final index = _highlightIndexByLane[lane] ?? -1;
    final selected = _selectedByLane[lane];
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(lane, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.8)),
          const SizedBox(height: 4),
          Text('highlight index: $index', style: TextStyle(color: _p.muted, fontFamily: 'monospace', fontSize: 10.8)),
          Text('selected: ${selected?.title ?? '-'}', style: TextStyle(color: _p.muted, fontSize: 10.8)),
        ],
      ),
    );
  }

  Widget _diagnosticsStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Diagnostics Deck'),
          const SizedBox(height: 8),
          Text(
            'Diagnostics captures highlight transitions and selections in a timeline. '
            'This helps validate interpreter-side interaction behavior.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Timeline Controls',
            subtitle: 'Inspect and manage event feed.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'timeline height',
                  value: _timelineHeight,
                  min: 170,
                  max: 430,
                  divisions: 26,
                  color: _p.accent3,
                  onChanged: (v) => setState(() => _timelineHeight = v),
                ),
                Row(
                  children: <Widget>[
                    TextButton.icon(
                      onPressed: () => setState(_trace.clear),
                      icon: const Icon(Icons.delete_sweep_outlined),
                      label: const Text('Clear timeline'),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () => _pushTrace('manual', 'Manual marker added.', _p.accent3),
                      icon: const Icon(Icons.bookmark_add_outlined),
                      label: const Text('Add marker'),
                    ),
                    const Spacer(),
                    if (_showMetrics) _chip('events', '${_trace.length}', _p.accent3),
                  ],
                ),
              ],
            ),
          ),
          if (_showTimeline) ...<Widget>[
            const SizedBox(height: 12),
            _panel(
              title: 'Event Timeline',
              subtitle: 'Highlight index updates emitted by option builders.',
              tint: _p.accent.withValues(alpha: 0.04),
              child: SizedBox(
                height: _timelineHeight,
                child: _trace.isEmpty
                    ? Center(
                        child: Text(
                          'Timeline is empty. Interact with autocomplete lanes to populate events.',
                          style: TextStyle(color: _p.muted, fontSize: 11.6),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _trace.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final event = _trace[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: event.tone.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: event.tone.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _chip('lane', event.lane, event.tone),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    event.message,
                                    style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.33),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _clock(event.time),
                                  style: TextStyle(color: _p.muted, fontFamily: 'monospace', fontSize: 10.1),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          _panel(
            title: 'Diagnostics Probe Lane',
            subtitle: 'Small lane dedicated to event generation checks.',
            tint: _p.accent2.withValues(alpha: 0.04),
            child: SizedBox(
              height: 280,
              child: _HighlightLane(
                laneId: 'diagnostics-probe',
                title: 'Diagnostics probe',
                subtitle: 'Generate highlight events quickly for timeline verification.',
                style: _LaneStyle.listCards,
                catalog: _catalog,
                palette: _p,
                maxResults: _effectiveMaxResults,
                caseSensitive: _caseSensitive,
                prefixOnly: _prefixOnly,
                showHints: _showHints,
                onHighlightChanged: _onHighlightChanged,
                onSelected: _onSelected,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _compendiumStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Verification Compendium'),
          const SizedBox(height: 12),
          _panel(
            title: 'AutocompleteHighlightedOption Matrix',
            subtitle: 'Concept, usage, and integration points.',
            child: Column(
              children: <Widget>[
                _matrix('Role', 'Expose highlighted option index within optionsViewBuilder subtree.'),
                _matrix('Access pattern', 'Use AutocompleteHighlightedOption.of(context) while building options list UI.'),
                _matrix('Primary pair', 'RawAutocomplete + custom optionsViewBuilder.'),
                _matrix('Typical visuals', 'Highlighted row, chip halo, split preview, metadata pane.'),
                _matrix('Input modality', 'Keyboard arrows, mouse hover/select, and touch selection.'),
                _matrix('Interpreter test goal', 'Validate interaction wiring, highlight flow, and visual feedback.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Implementation guidance for robust demos.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do style from highlighted index',
                  detail: 'Use index to produce obvious visual state transitions for users.',
                ),
                _doDont(
                  good: true,
                  title: 'Do keep options stable per query',
                  detail: 'Stable ordering prevents confusing highlight jumps.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont query highlighted option outside builder subtree',
                  detail: 'AutocompleteHighlightedOption.of(context) depends on inherited scope.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont hide keyboard instructions',
                  detail: 'Users need clear guidance for up/down navigation semantics.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common questions while building custom autocomplete UIs.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'When should I use AutocompleteHighlightedOption?',
                  a: 'When custom optionsViewBuilder needs to know which option is highlighted by keyboard navigation.',
                ),
                _qa(
                  q: 'Can this drive complex layouts like split previews?',
                  a: 'Yes. Highlighted index can control any visual widget in the options overlay subtree.',
                ),
                _qa(
                  q: 'Does highlighted index equal selected option?',
                  a: 'No. Highlight indicates focus; selection occurs when user confirms an option.',
                ),
                _qa(
                  q: 'How do I debug highlight changes?',
                  a: 'Emit timeline events when highlighted index changes and monitor lane telemetry.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo acceptance points.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Spotlight lane demonstrates highlighted index in list card renderer.'),
                _check('Catalog stage compares list and chip-grid renderers side-by-side.'),
                _check('Styling lab shows split preview controlled by highlight index.'),
                _check('Keyboard arena validates index transitions across independent lanes.'),
                _check('Diagnostics deck logs highlight events and selections in timeline.'),
                _check('Compendium includes matrix, do/dont, FAQ, and completion checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _notice(
            'AutocompleteHighlightedOption is the core hook for keyboard-focused option '
            'state in custom autocomplete overlays. This deep demo visualizes that state '
            'across multiple renderer patterns for interpreter interaction validation.',
          ),
        ],
      ),
    );
  }

  Widget _metricsBoard() {
    return _panel(
      title: 'Highlight Telemetry',
      subtitle: 'Global metrics and selected values by lane.',
      child: Column(
        children: <Widget>[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _chip('events', '$_highlightEvents', _p.accent),
              _chip('selections', '$_selectionCount', _p.accent2),
              _chip('tracked lanes', '${_highlightIndexByLane.length}', _p.accent3),
              _chip('max results', '$_effectiveMaxResults', _p.accent),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedByLane.entries
                .map(
                  (entry) => Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
                    ),
                    child: Text(
                      '${entry.key}: ${entry.value?.title ?? '-'}',
                      style: TextStyle(color: _p.ink, fontSize: 11.1),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _toggleChip(String label, bool value, void Function(bool value) assign) {
    return FilterChip(
      selected: value,
      selectedColor: _p.accent.withValues(alpha: 0.18),
      backgroundColor: Colors.white,
      checkmarkColor: _p.accent,
      label: Text(label),
      labelStyle: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11),
      onSelected: (selected) => setState(() => assign(selected)),
    );
  }

  Widget _slider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 190,
          child: Text(
            '$label: ${value.toStringAsFixed(0)}',
            style: TextStyle(color: _p.ink, fontSize: 12),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: color,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: <Widget>[
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(color: _p.accent, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: _p.ink, fontSize: 18, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _panel({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? _p.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 14)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 11.3)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _chip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.34)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _p.ink,
          fontFamily: 'monospace',
          fontSize: 10.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _matrix(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Text(
              key,
              style: TextStyle(color: _p.accent, fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 11.2),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.33))),
        ],
      ),
    );
  }

  Widget _doDont({required bool good, required String title, required String detail}) {
    final tone = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(good ? Icons.check_circle : Icons.cancel, color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 11.3, height: 1.33)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qa({required String q, required String a}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Q: $q', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text('A: $a', style: TextStyle(color: _p.muted, fontSize: 11.4, height: 1.34)),
        ],
      ),
    );
  }

  Widget _check(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: _p.accent),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.9, height: 1.32))),
        ],
      ),
    );
  }

  Widget _notice(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _p.accent3.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.accent3.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.info_outline, color: _p.accent3, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12, height: 1.34))),
        ],
      ),
    );
  }

  String _clock(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    final s = t.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _p.shell.withValues(alpha: 0.06),
      child: Row(
        children: <Widget>[
          Text(_stageTitles[_stage.index], style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _HighlightLane extends StatefulWidget {
  const _HighlightLane({
    required this.laneId,
    required this.title,
    required this.subtitle,
    required this.style,
    required this.catalog,
    required this.palette,
    required this.maxResults,
    required this.caseSensitive,
    required this.prefixOnly,
    required this.showHints,
    required this.onHighlightChanged,
    required this.onSelected,
  });

  final String laneId;
  final String title;
  final String subtitle;
  final _LaneStyle style;
  final List<_CommandItem> catalog;
  final _Palette palette;
  final int maxResults;
  final bool caseSensitive;
  final bool prefixOnly;
  final bool showHints;
  final void Function(String lane, int index, List<_CommandItem> options) onHighlightChanged;
  final void Function(String lane, _CommandItem item) onSelected;

  @override
  State<_HighlightLane> createState() => _HighlightLaneState();
}

class _HighlightLaneState extends State<_HighlightLane> {
  _CommandItem? _selected;
  int _lastReportedIndex = -999;
  List<String> _lastReportedIds = <String>[];

  Iterable<_CommandItem> _optionsFor(TextEditingValue value) {
    final query = widget.caseSensitive ? value.text.trim() : value.text.trim().toLowerCase();
    final source = widget.catalog;
    final filtered = source.where((item) {
      if (query.isEmpty) {
        return true;
      }
      final title = widget.caseSensitive ? item.title : item.title.toLowerCase();
      final category = widget.caseSensitive ? item.category : item.category.toLowerCase();
      final description = widget.caseSensitive ? item.description : item.description.toLowerCase();
      if (widget.prefixOnly) {
        return title.startsWith(query) || category.startsWith(query);
      }
      return title.contains(query) || category.contains(query) || description.contains(query);
    }).toList();

    filtered.sort((a, b) {
      final c = a.category.compareTo(b.category);
      if (c != 0) {
        return c;
      }
      return a.title.compareTo(b.title);
    });

    return filtered.take(widget.maxResults);
  }

  void _reportHighlight(int index, List<_CommandItem> options) {
    final ids = options.map((item) => item.id).toList();
    if (_lastReportedIndex == index && listEquals(_lastReportedIds, ids)) {
      return;
    }
    _lastReportedIndex = index;
    _lastReportedIds = ids;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      widget.onHighlightChanged(widget.laneId, index, options);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w800, fontSize: 13.5)),
            const SizedBox(height: 4),
            Text(widget.subtitle, style: TextStyle(color: widget.palette.muted, fontSize: 11.2)),
            const SizedBox(height: 10),
            RawAutocomplete<_CommandItem>(
              displayStringForOption: (item) => item.title,
              optionsBuilder: _optionsFor,
              onSelected: (item) {
                setState(() => _selected = item);
                widget.onSelected(widget.laneId, item);
              },
              fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Type command, category, or feature',
                    hintStyle: TextStyle(color: widget.palette.muted),
                    prefixIcon: Icon(Icons.search, color: widget.palette.accent),
                    suffixIcon: widget.showHints
                        ? Tooltip(
                            message: 'Use arrow keys to move highlight',
                            child: Icon(Icons.keyboard_arrow_down_rounded, color: widget.palette.accent2),
                          )
                        : null,
                    filled: true,
                    fillColor: widget.palette.canvas,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                final list = options.toList();
                final highlighted = AutocompleteHighlightedOption.of(context);
                _reportHighlight(highlighted, list);

                switch (widget.style) {
                  case _LaneStyle.listCards:
                    return _listOptions(list, highlighted, onSelected);
                  case _LaneStyle.chipGrid:
                    return _chipOptions(list, highlighted, onSelected);
                  case _LaneStyle.splitPreview:
                    return _splitOptions(list, highlighted, onSelected);
                }
              },
            ),
            const SizedBox(height: 10),
            _selectedSummary(),
          ],
        ),
      ),
    );
  }

  Widget _selectedSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.palette.accent2.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _selected == null
            ? 'No selection yet. Choose an option to record selection telemetry.'
            : 'Selected: ${_selected!.title} • ${_selected!.category} • ${_selected!.shortcut}',
        style: TextStyle(color: widget.palette.ink, fontSize: 11),
      ),
    );
  }

  Widget _listOptions(
    List<_CommandItem> options,
    int highlighted,
    AutocompleteOnSelected<_CommandItem> onSelected,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620, maxHeight: 250),
          child: options.isEmpty
              ? _emptyBoard()
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final item = options[index];
                    final isHighlighted = index == highlighted;
                    return InkWell(
                      onTap: () => onSelected(item),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: isHighlighted
                              ? widget.palette.accent.withValues(alpha: 0.15)
                              : widget.palette.canvas,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isHighlighted
                                ? widget.palette.accent.withValues(alpha: 0.6)
                                : widget.palette.muted.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 4,
                              height: 42,
                              decoration: BoxDecoration(
                                color: isHighlighted ? widget.palette.accent : widget.palette.accent2,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(item.title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 12.3)),
                                  const SizedBox(height: 2),
                                  Text(item.description, style: TextStyle(color: widget.palette.muted, fontSize: 10.9)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                _tinyChip(item.category, widget.palette.accent2),
                                const SizedBox(height: 4),
                                Text(item.shortcut, style: TextStyle(color: widget.palette.muted, fontFamily: 'monospace', fontSize: 10.3)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Widget _chipOptions(
    List<_CommandItem> options,
    int highlighted,
    AutocompleteOnSelected<_CommandItem> onSelected,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620, maxHeight: 260),
          child: options.isEmpty
              ? _emptyBoard()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (var i = 0; i < options.length; i++)
                        GestureDetector(
                          onTap: () => onSelected(options[i]),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 160),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: i == highlighted
                                  ? widget.palette.accent2.withValues(alpha: 0.2)
                                  : widget.palette.canvas,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: i == highlighted
                                    ? widget.palette.accent2
                                    : widget.palette.muted.withValues(alpha: 0.22),
                                width: i == highlighted ? 1.8 : 1,
                              ),
                              boxShadow: i == highlighted
                                  ? <BoxShadow>[
                                      BoxShadow(
                                        color: widget.palette.accent2.withValues(alpha: 0.18),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : const <BoxShadow>[],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(options[i].title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 11.1)),
                                const SizedBox(width: 6),
                                Text(
                                  options[i].shortcut,
                                  style: TextStyle(color: widget.palette.muted, fontFamily: 'monospace', fontSize: 9.8),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _splitOptions(
    List<_CommandItem> options,
    int highlighted,
    AutocompleteOnSelected<_CommandItem> onSelected,
  ) {
    final active = highlighted >= 0 && highlighted < options.length ? options[highlighted] : null;
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760, maxHeight: 280),
          child: options.isEmpty
              ? _emptyBoard()
              : Row(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final item = options[index];
                          final selected = index == highlighted;
                          return ListTile(
                            dense: true,
                            onTap: () => onSelected(item),
                            tileColor: selected ? widget.palette.accent.withValues(alpha: 0.12) : null,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            title: Text(item.title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 12)),
                            subtitle: Text(item.category, style: TextStyle(color: widget.palette.muted, fontSize: 10.4)),
                            trailing: Text(item.shortcut, style: TextStyle(color: widget.palette.muted, fontFamily: 'monospace', fontSize: 9.8)),
                          );
                        },
                      ),
                    ),
                    Container(width: 1, color: widget.palette.muted.withValues(alpha: 0.2)),
                    SizedBox(
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: active == null
                            ? Text('No highlighted option.', style: TextStyle(color: widget.palette.muted, fontSize: 11.2))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Highlighted Preview', style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w800, fontSize: 12.6)),
                                  const SizedBox(height: 8),
                                  _tinyChip(active.category, widget.palette.accent2),
                                  const SizedBox(height: 8),
                                  Text(active.title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w800, fontSize: 14)),
                                  const SizedBox(height: 6),
                                  Text(active.description, style: TextStyle(color: widget.palette.muted, fontSize: 11.1, height: 1.34)),
                                  const Spacer(),
                                  Text(
                                    'Shortcut: ${active.shortcut}',
                                    style: TextStyle(color: widget.palette.ink, fontFamily: 'monospace', fontSize: 10.8),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: <Widget>[
                                      const Icon(Icons.auto_graph_rounded, size: 16),
                                      const SizedBox(width: 6),
                                      Text('Complexity ${active.complexity}/4', style: TextStyle(color: widget.palette.muted, fontSize: 10.8)),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _emptyBoard() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        'No options for current query.',
        style: TextStyle(color: widget.palette.muted, fontSize: 11.4),
      ),
    );
  }

  Widget _tinyChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.36)),
      ),
      child: Text(
        label,
        style: TextStyle(color: widget.palette.ink, fontSize: 10.1, fontWeight: FontWeight.w700),
      ),
    );
  }
}

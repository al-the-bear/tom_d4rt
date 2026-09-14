import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _BottomNavigationBarItemDeepDemo();
}

enum _DemoStage {
  anatomy,
  modeLab,
  activeIconTheater,
  keyDeck,
  cupertinoBridge,
  compendium,
}

enum _CanvasPattern {
  wave,
  grid,
  orbit,
}

class _Palette {
  final String name;
  final Color shell;
  final Color canvas;
  final Color card;
  final Color ink;
  final Color muted;
  final Color accentA;
  final Color accentB;
  final Color accentC;

  const _Palette({
    required this.name,
    required this.shell,
    required this.canvas,
    required this.card,
    required this.ink,
    required this.muted,
    required this.accentA,
    required this.accentB,
    required this.accentC,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Harbor Navy',
    shell: Color(0xFF122532),
    canvas: Color(0xFFF1F8FC),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF213644),
    muted: Color(0xFF6E8697),
    accentA: Color(0xFF1E88E5),
    accentB: Color(0xFF1A9B7D),
    accentC: Color(0xFFD2901C),
  ),
  _Palette(
    name: 'Forest Stone',
    shell: Color(0xFF182420),
    canvas: Color(0xFFF3FAF5),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF29362D),
    muted: Color(0xFF738578),
    accentA: Color(0xFF2F8E3C),
    accentB: Color(0xFF1C8E94),
    accentC: Color(0xFFB98629),
  ),
  _Palette(
    name: 'Copper Sand',
    shell: Color(0xFF2A211D),
    canvas: Color(0xFFFDF5EE),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF3A2E28),
    muted: Color(0xFF8A7B72),
    accentA: Color(0xFFB86335),
    accentB: Color(0xFF2F89A1),
    accentC: Color(0xFF9D8619),
  ),
];

class _LogEvent {
  final DateTime at;
  final String source;
  final String message;
  final Color tone;

  const _LogEvent({
    required this.at,
    required this.source,
    required this.message,
    required this.tone,
  });
}

class _ItemSpec {
  final String id;
  final String label;
  final String tooltip;
  final IconData icon;
  final IconData activeIcon;
  final Color backgroundColor;

  const _ItemSpec({
    required this.id,
    required this.label,
    required this.tooltip,
    required this.icon,
    required this.activeIcon,
    required this.backgroundColor,
  });
}

const _seedSpecs = <_ItemSpec>[
  _ItemSpec(
    id: 'home',
    label: 'Home',
    tooltip: 'Open the dashboard overview',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    backgroundColor: Color(0xFF1565C0),
  ),
  _ItemSpec(
    id: 'search',
    label: 'Explore',
    tooltip: 'Search content and categories',
    icon: Icons.travel_explore_outlined,
    activeIcon: Icons.travel_explore,
    backgroundColor: Color(0xFF00897B),
  ),
  _ItemSpec(
    id: 'inbox',
    label: 'Inbox',
    tooltip: 'Review messages and alerts',
    icon: Icons.mark_chat_unread_outlined,
    activeIcon: Icons.mark_chat_unread,
    backgroundColor: Color(0xFF7B1FA2),
  ),
  _ItemSpec(
    id: 'wallet',
    label: 'Wallet',
    tooltip: 'Inspect payment and billing state',
    icon: Icons.account_balance_wallet_outlined,
    activeIcon: Icons.account_balance_wallet,
    backgroundColor: Color(0xFFE65100),
  ),
  _ItemSpec(
    id: 'profile',
    label: 'Profile',
    tooltip: 'Manage account and preferences',
    icon: Icons.person_outline,
    activeIcon: Icons.person,
    backgroundColor: Color(0xFF2E7D32),
  ),
];

class _DynamicItem {
  final String id;
  final BottomNavigationBarItem item;

  const _DynamicItem({required this.id, required this.item});
}

class _BottomNavigationBarItemDeepDemo extends StatefulWidget {
  const _BottomNavigationBarItemDeepDemo();

  @override
  State<_BottomNavigationBarItemDeepDemo> createState() => _BottomNavigationBarItemDeepDemoState();
}

class _BottomNavigationBarItemDeepDemoState extends State<_BottomNavigationBarItemDeepDemo> {
  _DemoStage _stage = _DemoStage.anatomy;
  final _CanvasPattern _pattern = _CanvasPattern.wave;
  int _paletteIndex = 0;

  bool _showTimeline = true;
  bool _showGuidance = true;
  bool _showCounters = true;
  bool _verboseLog = false;

  bool _useDistinctActiveIcons = true;
  bool _showSelectedLabels = true;
  bool _showUnselectedLabels = true;
  bool _showTooltips = true;
  bool _showIconOutline = false;

  int _anatomyIndex = 0;
  int _fixedIndex = 0;
  int _shiftingIndex = 0;
  int _theaterIndex = 0;
  int _bridgeMaterialIndex = 0;
  int _bridgeCupertinoIndex = 0;

  int _tapEvents = 0;
  int _specChanges = 0;
  int _keyMutations = 0;
  int _tooltipToggles = 0;

  double _iconSize = 24;
  double _fontSize = 12;
  double _phoneHeight = 390;

  int _idSeed = 0;
  final List<_LogEvent> _events = <_LogEvent>[];
  final List<_DynamicItem> _dynamicItems = <_DynamicItem>[];

  _Palette get _p => _palettes[_paletteIndex];

  static const _stageTitles = <String>[
    '1 Item Anatomy Studio',
    '2 Fixed vs Shifting Lab',
    '3 Active Icon Theater',
    '4 Dynamic Key Stability Deck',
    '5 Material and Cupertino Bridge',
    '6 Verification Compendium',
  ];

  @override
  void initState() {
    super.initState();
    _dynamicItems.addAll(_seedDynamicItems(4));
    _log('system', 'BottomNavigationBarItem deep demo initialized.', _p.accentA);
  }

  List<_DynamicItem> _seedDynamicItems(int count) {
    final seed = <_DynamicItem>[];
    for (var i = 0; i < count; i++) {
      seed.add(_createDynamicFromSpec(_seedSpecs[i % _seedSpecs.length]));
    }
    return seed;
  }

  _DynamicItem _createDynamicFromSpec(_ItemSpec spec) {
    _idSeed += 1;
    final id = '${spec.id}-${_idSeed.toString().padLeft(2, '0')}';
    return _DynamicItem(
      id: id,
      item: BottomNavigationBarItem(
        key: ValueKey<String>(id),
        icon: Icon(spec.icon),
        activeIcon: Icon(spec.activeIcon),
        label: spec.label,
        tooltip: spec.tooltip,
        backgroundColor: spec.backgroundColor,
      ),
    );
  }

  void _log(String source, String message, Color tone) {
    final event = _LogEvent(at: DateTime.now(), source: source, message: message, tone: tone);
    setState(() {
      _events.insert(0, event);
      if (_events.length > 120) {
        _events.removeRange(120, _events.length);
      }
    });
    if (_verboseLog) {
      debugPrint('[BottomNavigationBarItem][$source] $message');
    }
  }

  void _recordTap(String source, int index, String label) {
    setState(() => _tapEvents += 1);
    _log(source, 'selected index $index ($label)', _p.accentA);
  }

  void _recordSpecChange(String source, String message) {
    setState(() => _specChanges += 1);
    _log(source, message, _p.accentB);
  }

  void _recordKeyMutation(String message) {
    setState(() => _keyMutations += 1);
    _log('key-deck', message, _p.accentC);
  }

  List<BottomNavigationBarItem> _materialItemsFromSpecs({bool useBackground = true}) {
    return _seedSpecs
        .map(
          (spec) => BottomNavigationBarItem(
            key: ValueKey<String>('spec-${spec.id}'),
            icon: _icon(spec.icon),
            activeIcon: _useDistinctActiveIcons ? _icon(spec.activeIcon) : _icon(spec.icon),
            label: spec.label,
            tooltip: _showTooltips ? spec.tooltip : null,
            backgroundColor: useBackground ? spec.backgroundColor : null,
          ),
        )
        .toList();
  }

  Widget _icon(IconData data) {
    return Icon(
      data,
      size: _iconSize,
      shadows: _showIconOutline
          ? const <Shadow>[Shadow(blurRadius: 2, color: Colors.black45, offset: Offset(0, 1))]
          : null,
    );
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
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: _stageBody()),
                  if (_showTimeline)
                    SizedBox(
                      width: 360,
                      child: _timelinePanel(),
                    ),
                ],
              ),
            ),
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
          colors: <Color>[_p.shell, _p.accentA.withValues(alpha: 0.88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.navigation_outlined, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'BottomNavigationBarItem Deep Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Navigation Item Modeling',
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
            'BottomNavigationBarItem defines tab icon, active icon, label, tooltip, and shifting background behavior. '
            'This deep demo uses multiple visual labs to show how item definitions shape Material and Cupertino tab surfaces.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 12.2,
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
      color: _p.accentA.withValues(alpha: 0.08),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text('Stage', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _stageTitles.length; i++) _stageChip(i),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
          const SizedBox(width: 10),
          _toggleChip('timeline', _showTimeline, (v) => _showTimeline = v),
          _toggleChip('guidance', _showGuidance, (v) => _showGuidance = v),
          _toggleChip('counters', _showCounters, (v) => _showCounters = v),
          _toggleChip('verbose', _verboseLog, (v) => _verboseLog = v),
        ],
      ),
    );
  }

  Widget _stageChip(int index) {
    final active = _stage.index == index;
    return ChoiceChip(
      selected: active,
      selectedColor: _p.accentA,
      backgroundColor: Colors.white,
      label: Text('${index + 1}'),
      labelStyle: TextStyle(
        color: active ? Colors.white : _p.ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) {
        setState(() => _stage = _DemoStage.values[index]);
        _log('stage', 'switched to ${_stageTitles[index]}', _p.accentB);
      },
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () {
        setState(() => _paletteIndex = index);
        _log('palette', 'palette changed to ${_palettes[index].name}', _palettes[index].accentA);
      },
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].accentA,
          border: Border.all(
            color: _paletteIndex == index ? _palettes[index].accentC : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _toggleChip(String label, bool value, void Function(bool value) assign) {
    return FilterChip(
      selected: value,
      selectedColor: _p.accentA.withValues(alpha: 0.19),
      backgroundColor: Colors.white,
      checkmarkColor: _p.accentA,
      label: Text(label),
      labelStyle: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11),
      onSelected: (selected) => setState(() => assign(selected)),
    );
  }

  Widget _stageBody() {
    switch (_stage) {
      case _DemoStage.anatomy:
        return _anatomyStage();
      case _DemoStage.modeLab:
        return _modeLabStage();
      case _DemoStage.activeIconTheater:
        return _activeIconTheaterStage();
      case _DemoStage.keyDeck:
        return _keyDeckStage();
      case _DemoStage.cupertinoBridge:
        return _bridgeStage();
      case _DemoStage.compendium:
        return _compendiumStage();
    }
  }

  Widget _anatomyStage() {
    final items = _materialItemsFromSpecs();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Item Anatomy Studio'),
          const SizedBox(height: 8),
          Text(
            'Break down BottomNavigationBarItem fields and inspect live effects in a navigation preview shell.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Item Spec Controls',
            subtitle: 'Toggle active icon, labels, tooltips, and icon presentation.',
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _toggleChip('distinct activeIcon', _useDistinctActiveIcons, (v) {
                      _useDistinctActiveIcons = v;
                      _recordSpecChange('anatomy', 'distinct activeIcon -> $v');
                    }),
                    _toggleChip('show selected labels', _showSelectedLabels, (v) {
                      _showSelectedLabels = v;
                      _recordSpecChange('anatomy', 'showSelectedLabels -> $v');
                    }),
                    _toggleChip('show unselected labels', _showUnselectedLabels, (v) {
                      _showUnselectedLabels = v;
                      _recordSpecChange('anatomy', 'showUnselectedLabels -> $v');
                    }),
                    _toggleChip('tooltips', _showTooltips, (v) {
                      _showTooltips = v;
                      _tooltipToggles += 1;
                      _recordSpecChange('anatomy', 'tooltips -> $v');
                    }),
                    _toggleChip('icon shadow', _showIconOutline, (v) {
                      _showIconOutline = v;
                      _recordSpecChange('anatomy', 'icon shadow -> $v');
                    }),
                  ],
                ),
                _slider(
                  label: 'icon size',
                  value: _iconSize,
                  min: 18,
                  max: 36,
                  divisions: 18,
                  color: _p.accentA,
                  onChanged: (v) {
                    setState(() => _iconSize = v);
                    _recordSpecChange('anatomy', 'icon size -> ${v.toStringAsFixed(1)}');
                  },
                ),
                _slider(
                  label: 'label font',
                  value: _fontSize,
                  min: 10,
                  max: 16,
                  divisions: 12,
                  color: _p.accentB,
                  onChanged: (v) {
                    setState(() => _fontSize = v);
                    _recordSpecChange('anatomy', 'font size -> ${v.toStringAsFixed(1)}');
                  },
                ),
                _slider(
                  label: 'phone height',
                  value: _phoneHeight,
                  min: 330,
                  max: 470,
                  divisions: 14,
                  color: _p.accentC,
                  onChanged: (v) => setState(() => _phoneHeight = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Item Field Catalog',
                  subtitle: 'Each card maps to BottomNavigationBarItem properties.',
                  child: Column(
                    children: <Widget>[
                      _itemFieldCard(
                        icon: Icons.image,
                        title: 'icon',
                        detail: 'Default visual when item is not selected.',
                        tone: _p.accentA,
                      ),
                      _itemFieldCard(
                        icon: Icons.check_circle_outline,
                        title: 'activeIcon',
                        detail: 'Optional selected-state icon. Falls back to icon if omitted.',
                        tone: _p.accentB,
                      ),
                      _itemFieldCard(
                        icon: Icons.label_outline,
                        title: 'label',
                        detail: 'Text shown under icon in Material and beside icon in Cupertino tab bars.',
                        tone: _p.accentC,
                      ),
                      _itemFieldCard(
                        icon: Icons.info_outline,
                        title: 'tooltip',
                        detail: 'Hover/long-press helper text in BottomNavigationBar when non-empty.',
                        tone: _p.accentA,
                      ),
                      _itemFieldCard(
                        icon: Icons.palette_outlined,
                        title: 'backgroundColor',
                        detail: 'Used by shifting type for bar flood animation per selected item.',
                        tone: _p.accentB,
                      ),
                      _itemFieldCard(
                        icon: Icons.key_outlined,
                        title: 'key',
                        detail: 'Preserves item identity across list size/order changes for ink effects.',
                        tone: _p.accentC,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _panel(
                  title: 'Live Preview Shell',
                  subtitle: 'Tap tabs and inspect selected-state transitions.',
                  tint: _p.accentA.withValues(alpha: 0.04),
                  child: _phoneShell(
                    title: 'Anatomy Preview',
                    selectedLabel: _seedSpecs[_anatomyIndex].label,
                    body: _stageCanvas(
                      label: 'Anatomy canvas',
                      child: Center(
                        child: Container(
                          width: 230,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.86),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _p.muted.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Selected Item', style: TextStyle(color: _p.muted, fontSize: 10.4)),
                              const SizedBox(height: 6),
                              Text(
                                _seedSpecs[_anatomyIndex].label,
                                style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _showTooltips ? _seedSpecs[_anatomyIndex].tooltip : 'Tooltip disabled',
                                style: TextStyle(color: _p.muted, fontSize: 10.6),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    bar: Theme(
                      data: ThemeData(
                        textTheme: TextTheme(
                          bodySmall: TextStyle(fontSize: _fontSize),
                        ),
                      ),
                      child: BottomNavigationBar(
                        currentIndex: _anatomyIndex,
                        type: BottomNavigationBarType.fixed,
                        showSelectedLabels: _showSelectedLabels,
                        showUnselectedLabels: _showUnselectedLabels,
                        items: items,
                        onTap: (value) {
                          setState(() => _anatomyIndex = value);
                          _recordTap('anatomy', value, _seedSpecs[value].label);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showCounters) ...<Widget>[
            const SizedBox(height: 12),
            _counterPanel(),
          ],
        ],
      ),
    );
  }

  Widget _modeLabStage() {
    final fixedItems = _materialItemsFromSpecs(useBackground: false).take(4).toList();
    final shiftingItems = _materialItemsFromSpecs(useBackground: true).take(4).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Fixed vs Shifting Lab'),
          const SizedBox(height: 8),
          Text(
            'BottomNavigationBarItem.backgroundColor appears in shifting mode; fixed mode keeps a stable bar background.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Mode Controls',
            subtitle: 'Tap each bar separately and compare behavior.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _fixedIndex = 0;
                      _shiftingIndex = 0;
                    });
                    _recordSpecChange('mode-lab', 'reset both bars to index 0');
                  },
                  icon: const Icon(Icons.restart_alt, size: 15),
                  label: const Text('Reset Indices'),
                ),
                _miniMetric('fixed index', '$_fixedIndex', _p.accentA),
                _miniMetric('shifting index', '$_shiftingIndex', _p.accentC),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Fixed Type Preview',
                  subtitle: 'backgroundColor on items does not flood bar in fixed mode.',
                  tint: _p.accentA.withValues(alpha: 0.04),
                  child: _phoneShell(
                    title: 'Fixed mode',
                    selectedLabel: _seedSpecs[_fixedIndex].label,
                    body: _stageCanvas(
                      label: 'Fixed mode body',
                      child: Center(
                        child: _explainCard(
                          title: 'Fixed Behavior',
                          detail: 'Item background colors are not used as full-bar flood animations.',
                        ),
                      ),
                    ),
                    bar: BottomNavigationBar(
                      currentIndex: _fixedIndex,
                      type: BottomNavigationBarType.fixed,
                      items: fixedItems,
                      onTap: (value) {
                        setState(() => _fixedIndex = value);
                        _recordTap('fixed-mode', value, _seedSpecs[value].label);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _panel(
                  title: 'Shifting Type Preview',
                  subtitle: 'Item backgroundColor drives selected flood color in shifting mode.',
                  tint: _p.accentC.withValues(alpha: 0.05),
                  child: _phoneShell(
                    title: 'Shifting mode',
                    selectedLabel: _seedSpecs[_shiftingIndex].label,
                    body: _stageCanvas(
                      label: 'Shifting mode body',
                      child: Center(
                        child: _explainCard(
                          title: 'Shifting Behavior',
                          detail: 'Selected item backgroundColor floods the bar while icons animate emphasis.',
                        ),
                      ),
                    ),
                    bar: BottomNavigationBar(
                      currentIndex: _shiftingIndex,
                      type: BottomNavigationBarType.shifting,
                      items: shiftingItems,
                      onTap: (value) {
                        setState(() => _shiftingIndex = value);
                        _recordTap('shifting-mode', value, _seedSpecs[value].label);
                      },
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

  Widget _activeIconTheaterStage() {
    final items = _materialItemsFromSpecs().take(5).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Active Icon Theater'),
          const SizedBox(height: 8),
          Text(
            'Switch active icon handling and label visibility to highlight how item definitions affect selection semantics.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Theater Controls',
            subtitle: 'Compare selected and unselected presentations in one place.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _toggleChip('distinct activeIcon', _useDistinctActiveIcons, (v) {
                  _useDistinctActiveIcons = v;
                  _recordSpecChange('active-theater', 'distinct activeIcon -> $v');
                }),
                _toggleChip('selected labels', _showSelectedLabels, (v) {
                  _showSelectedLabels = v;
                  _recordSpecChange('active-theater', 'selected labels -> $v');
                }),
                _toggleChip('unselected labels', _showUnselectedLabels, (v) {
                  _showUnselectedLabels = v;
                  _recordSpecChange('active-theater', 'unselected labels -> $v');
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Preview Shell',
                  subtitle: 'Tap through tabs to observe active icon swaps.',
                  tint: _p.accentB.withValues(alpha: 0.04),
                  child: _phoneShell(
                    title: 'Active icon theater',
                    selectedLabel: _seedSpecs[_theaterIndex].label,
                    body: _stageCanvas(
                      label: 'Icon theater body',
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              _useDistinctActiveIcons
                                  ? _seedSpecs[_theaterIndex].activeIcon
                                  : _seedSpecs[_theaterIndex].icon,
                              size: 56,
                              color: _p.accentA,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _seedSpecs[_theaterIndex].label,
                              style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _useDistinctActiveIcons
                                  ? 'Using activeIcon for selected state'
                                  : 'activeIcon disabled, using icon',
                              style: TextStyle(color: _p.muted, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    bar: BottomNavigationBar(
                      currentIndex: _theaterIndex,
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: _showSelectedLabels,
                      showUnselectedLabels: _showUnselectedLabels,
                      items: items,
                      onTap: (value) {
                        setState(() => _theaterIndex = value);
                        _recordTap('active-theater', value, _seedSpecs[value].label);
                      },
                    ),
                  ),
                ),
              ),
              if (_showGuidance) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 330,
                  child: _panel(
                    title: 'Guidance Notes',
                    subtitle: 'Design choices for icons and labels.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('Pair outlined and filled icon variants when possible.'),
                        _bullet('Keep labels concise and task-oriented.'),
                        _bullet('Show at least selected labels for discoverability.'),
                        _bullet('Use tooltips for desktop/hover discoverability.'),
                        _bullet('Avoid unrelated icon swaps across selected state.'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _keyDeckStage() {
    var selected = _anatomyIndex;
    if (_dynamicItems.isEmpty) {
      selected = 0;
    } else if (selected >= _dynamicItems.length) {
      selected = _dynamicItems.length - 1;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Dynamic Key Stability Deck'),
          const SizedBox(height: 8),
          Text(
            'BottomNavigationBarItem.key helps keep ink/splash identity stable during list mutations.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Mutation Controls',
            subtitle: 'Add, remove, rotate, and reset item lists while preserving keyed identity.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: () {
                    final next = _createDynamicFromSpec(_seedSpecs[_dynamicItems.length % _seedSpecs.length]);
                    setState(() => _dynamicItems.add(next));
                    _recordKeyMutation('added ${next.id}');
                  },
                  icon: const Icon(Icons.add, size: 15),
                  label: const Text('Add Item'),
                ),
                OutlinedButton.icon(
                  onPressed: _dynamicItems.isEmpty
                      ? null
                      : () {
                          final removed = _dynamicItems.removeLast();
                          setState(() {});
                          _recordKeyMutation('removed ${removed.id}');
                        },
                  icon: const Icon(Icons.remove, size: 15),
                  label: const Text('Remove Last'),
                ),
                OutlinedButton.icon(
                  onPressed: _dynamicItems.length < 2
                      ? null
                      : () {
                          final first = _dynamicItems.removeAt(0);
                          _dynamicItems.add(first);
                          setState(() {});
                          _recordKeyMutation('rotated list order');
                        },
                  icon: const Icon(Icons.swap_horiz, size: 15),
                  label: const Text('Rotate Order'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _dynamicItems
                        ..clear()
                        ..addAll(_seedDynamicItems(4));
                      _anatomyIndex = 0;
                    });
                    _recordKeyMutation('reset dynamic list to seed items');
                  },
                  icon: const Icon(Icons.restart_alt, size: 15),
                  label: const Text('Reset'),
                ),
                _miniMetric('items', '${_dynamicItems.length}', _p.accentA),
                _miniMetric('mutations', '$_keyMutations', _p.accentC),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Dynamic Bar Preview',
                  subtitle: 'Observe keyed identity text below the bar.',
                  tint: _p.accentC.withValues(alpha: 0.05),
                  child: _phoneShell(
                    title: 'Key deck preview',
                    selectedLabel: _dynamicItems.isEmpty ? 'None' : _dynamicItems[selected].item.label ?? 'item',
                    body: _stageCanvas(
                      label: 'Key deck canvas',
                      child: _dynamicItems.isEmpty
                          ? Center(
                              child: Text('No items left. Add items to continue.', style: TextStyle(color: _p.muted)),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Current item keys',
                                    style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12.3),
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: _dynamicItems.length,
                                      itemBuilder: (context, index) {
                                        final item = _dynamicItems[index];
                                        final selectedRow = index == selected;
                                        return Container(
                                          margin: const EdgeInsets.only(bottom: 6),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: selectedRow
                                                ? _p.accentA.withValues(alpha: 0.16)
                                                : Colors.white.withValues(alpha: 0.8),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  '${item.id} -> ${item.item.label}',
                                                  style: TextStyle(
                                                    color: _p.ink,
                                                    fontFamily: 'monospace',
                                                    fontSize: 10.4,
                                                    fontWeight: selectedRow ? FontWeight.w700 : FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              if (selectedRow)
                                                Icon(Icons.radio_button_checked, size: 14, color: _p.accentA),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    bar: _dynamicItems.length < 2
                        ? const SizedBox(height: 56)
                        : BottomNavigationBar(
                            currentIndex: selected,
                            type: BottomNavigationBarType.fixed,
                            items: _dynamicItems.map((entry) => entry.item).toList(),
                            onTap: (value) {
                              setState(() => _anatomyIndex = value);
                              _recordTap('key-deck', value, _dynamicItems[value].item.label ?? 'item');
                            },
                          ),
                  ),
                ),
              ),
              if (_showGuidance) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 320,
                  child: _panel(
                    title: 'Key Guidance',
                    subtitle: 'Why item keys matter in mutable bars.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('Provide stable keys when item order/length changes on tap.'),
                        _bullet('Stable keys help preserve splash origin and state continuity.'),
                        _bullet('Avoid using transient random keys each build.'),
                        _bullet('Tie key identity to stable item IDs from your model layer.'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _bridgeStage() {
    final bridgeItems = _materialItemsFromSpecs().take(4).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Material and Cupertino Bridge'),
          const SizedBox(height: 8),
          Text(
            'BottomNavigationBarItem is shared across BottomNavigationBar and CupertinoTabBar use cases.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Material Preview',
                  subtitle: 'BottomNavigationBar with same item definitions.',
                  tint: _p.accentA.withValues(alpha: 0.04),
                  child: _phoneShell(
                    title: 'Material tab shell',
                    selectedLabel: _seedSpecs[_bridgeMaterialIndex].label,
                    body: _stageCanvas(
                      label: 'Material body',
                      child: Center(
                        child: _explainCard(
                          title: _seedSpecs[_bridgeMaterialIndex].label,
                          detail: _seedSpecs[_bridgeMaterialIndex].tooltip,
                        ),
                      ),
                    ),
                    bar: BottomNavigationBar(
                      currentIndex: _bridgeMaterialIndex,
                      type: BottomNavigationBarType.fixed,
                      items: bridgeItems,
                      onTap: (value) {
                        setState(() => _bridgeMaterialIndex = value);
                        _recordTap('bridge-material', value, _seedSpecs[value].label);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _panel(
                  title: 'Cupertino Preview',
                  subtitle: 'CupertinoTabBar consuming the same BottomNavigationBarItem list.',
                  tint: _p.accentB.withValues(alpha: 0.04),
                  child: SizedBox(
                    height: _phoneHeight,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        brightness: Brightness.light,
                        primaryColor: _p.accentA,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 34,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: _p.muted.withValues(alpha: 0.25))),
                              ),
                              child: Text(
                                'Cupertino tab shell',
                                style: TextStyle(color: _p.muted, fontSize: 10.8),
                              ),
                            ),
                            Expanded(
                              child: _stageCanvas(
                                label: 'Cupertino body',
                                child: Center(
                                  child: _explainCard(
                                    title: _seedSpecs[_bridgeCupertinoIndex].label,
                                    detail: 'CupertinoTabBar uses BottomNavigationBarItem icon/label pair.',
                                  ),
                                ),
                              ),
                            ),
                            CupertinoTabBar(
                              currentIndex: _bridgeCupertinoIndex,
                              items: bridgeItems,
                              onTap: (value) {
                                setState(() => _bridgeCupertinoIndex = value);
                                _recordTap('bridge-cupertino', value, _seedSpecs[value].label);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showGuidance) ...<Widget>[
            const SizedBox(height: 12),
            _panel(
              title: 'Bridge Notes',
              subtitle: 'Shared item model patterns across frameworks.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _bullet('Keep item labels reusable across Material and Cupertino contexts.'),
                  _bullet('Use icon pairs that communicate selected state clearly.'),
                  _bullet('Platform bars differ visually but share item semantics.'),
                  _bullet('Build from one item model to keep navigation definitions consistent.'),
                ],
              ),
            ),
          ],
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
            title: 'BottomNavigationBarItem Matrix',
            subtitle: 'API behavior and design intent summary.',
            child: Column(
              children: <Widget>[
                _matrix('icon', 'Base icon for unselected state.'),
                _matrix('activeIcon', 'Selected-state icon; defaults to icon when omitted.'),
                _matrix('label', 'Primary text for tab meaning in Material/Cupertino bars.'),
                _matrix('tooltip', 'Assistive hint shown on hover/long-press for Material bar.'),
                _matrix('backgroundColor', 'Used by shifting type to flood selected bar background.'),
                _matrix('key', 'Identity anchor during dynamic item list mutations.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Practical quality guidance for tab item design.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do pair icon and activeIcon semantically',
                  detail: 'Outline/filled icon pairs improve selection clarity and accessibility.',
                ),
                _doDont(
                  good: true,
                  title: 'Do keep labels short and stable',
                  detail: 'Concise labels improve scanability and avoid layout jitter.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont rely on backgroundColor outside shifting mode',
                  detail: 'backgroundColor does not flood bar in fixed mode.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont mutate item order without stable keys',
                  detail: 'Stable keys help preserve splash/ink identity across mutations.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common BottomNavigationBarItem questions.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'When should I define activeIcon?',
                  a: 'Whenever selected state requires stronger visual emphasis than tint changes alone.',
                ),
                _qa(
                  q: 'How does tooltip affect touch devices?',
                  a: 'Tooltip is mainly hover/long-press assistive text; labels remain primary for touch clarity.',
                ),
                _qa(
                  q: 'Can I reuse item lists in CupertinoTabBar?',
                  a: 'Yes. CupertinoTabBar accepts BottomNavigationBarItem lists and uses icon/label fields.',
                ),
                _qa(
                  q: 'What if my item list changes at runtime?',
                  a: 'Use meaningful keys on each BottomNavigationBarItem for consistent identity handling.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Coverage Checklist',
            subtitle: 'Deep-demo scenarios covered in this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Anatomy Studio visualizes all core item fields with a live bar.'),
                _check('Fixed vs Shifting Lab demonstrates backgroundColor behavior differences.'),
                _check('Active Icon Theater demonstrates activeIcon and label visibility interplay.'),
                _check('Key Stability Deck demonstrates dynamic list mutation with keyed items.'),
                _check('Bridge Stage demonstrates shared item definitions in Material and Cupertino bars.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _p.accentC.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _p.accentC.withValues(alpha: 0.32)),
            ),
            child: Text(
              'BottomNavigationBarItem is a compact but high-impact model object. Carefully authored item definitions '
              'make tab bars clearer, more stable, and easier to adapt across platform styles and dynamic state changes.',
              style: TextStyle(color: _p.ink, fontSize: 11.8, height: 1.36),
            ),
          ),
        ],
      ),
    );
  }

  Widget _phoneShell({
    required String title,
    required String selectedLabel,
    required Widget body,
    required Widget bar,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
      ),
      child: SizedBox(
        height: _phoneHeight,
        child: Column(
          children: <Widget>[
            Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: _p.canvas,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                border: Border(bottom: BorderSide(color: _p.muted.withValues(alpha: 0.24))),
              ),
              child: Row(
                children: <Widget>[
                  Text(title, style: TextStyle(color: _p.muted, fontSize: 10.8)),
                  const Spacer(),
                  Text(
                    'selected: $selectedLabel',
                    style: TextStyle(color: _p.muted, fontSize: 10.4, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
            Expanded(child: body),
            bar,
          ],
        ),
      ),
    );
  }

  Widget _stageCanvas({required String label, required Widget child}) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: _background(pattern: _pattern, label: label)),
        Positioned.fill(child: child),
      ],
    );
  }

  Widget _background({required _CanvasPattern pattern, required String label}) {
    switch (pattern) {
      case _CanvasPattern.wave:
        return _waveBackground(label);
      case _CanvasPattern.grid:
        return _gridBackground(label);
      case _CanvasPattern.orbit:
        return _orbitBackground(label);
    }
  }

  Widget _waveBackground(String label) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentA.withValues(alpha: 0.25), _p.accentB.withValues(alpha: 0.25)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(painter: _WavePainter(color: Colors.white.withValues(alpha: 0.2))),
          ),
          Positioned(
            left: 8,
            top: 8,
            child: _backgroundTag(label),
          ),
        ],
      ),
    );
  }

  Widget _gridBackground(String label) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentB.withValues(alpha: 0.23), _p.accentC.withValues(alpha: 0.23)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter(color: Colors.white.withValues(alpha: 0.22))),
          ),
          Positioned(
            left: 8,
            top: 8,
            child: _backgroundTag(label),
          ),
        ],
      ),
    );
  }

  Widget _orbitBackground(String label) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentC.withValues(alpha: 0.23), _p.accentA.withValues(alpha: 0.23)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(left: 26, top: 26, child: _orb(90, Colors.white.withValues(alpha: 0.18))),
          Positioned(right: 34, top: 40, child: _orb(70, Colors.white.withValues(alpha: 0.16))),
          Positioned(left: 130, bottom: 30, child: _orb(110, Colors.white.withValues(alpha: 0.14))),
          Positioned(
            left: 8,
            top: 8,
            child: _backgroundTag(label),
          ),
        ],
      ),
    );
  }

  Widget _orb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _backgroundTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 9.6, fontWeight: FontWeight.w700),
      ),
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
        border: Border.all(color: _p.muted.withValues(alpha: 0.23)),
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
          Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13.8)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 11.1)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: <Widget>[
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(color: _p.accentA, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: _p.ink, fontSize: 18, fontWeight: FontWeight.w800)),
      ],
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
          width: 164,
          child: Text('$label: ${value.toStringAsFixed(1)}', style: TextStyle(color: _p.ink, fontSize: 12)),
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

  Widget _itemFieldCard({
    required IconData icon,
    required String title,
    required String detail,
    required Color tone,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 3),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 10.8, height: 1.33)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _explainCard({required String title, required String detail}) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(title, style: TextStyle(color: _p.ink, fontSize: 15, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(detail, style: TextStyle(color: _p.muted, fontSize: 10.8, height: 1.34), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _counterPanel() {
    return _panel(
      title: 'Global Counters',
      subtitle: 'Interaction counters accumulated across stage actions.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _miniMetric('tap events', '$_tapEvents', _p.accentA),
          _miniMetric('spec changes', '$_specChanges', _p.accentB),
          _miniMetric('key mutations', '$_keyMutations', _p.accentC),
          _miniMetric('tooltip toggles', '$_tooltipToggles', _p.accentA),
        ],
      ),
    );
  }

  Widget _miniMetric(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(color: _p.ink, fontSize: 10.2, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.chevron_right, size: 16, color: _p.accentA),
          const SizedBox(width: 4),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.1))),
        ],
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
            width: 140,
            child: Text(
              key,
              style: TextStyle(
                color: _p.accentA,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 10.8,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: _p.ink, fontSize: 11.2, height: 1.33))),
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
        border: Border.all(color: tone.withValues(alpha: 0.26)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(good ? Icons.check_circle : Icons.cancel, color: tone, size: 17),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 11.1, height: 1.32)),
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
          Text('Q: $q', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.9)),
          const SizedBox(height: 4),
          Text('A: $a', style: TextStyle(color: _p.muted, fontSize: 11.1, height: 1.33)),
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
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 17),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.3))),
        ],
      ),
    );
  }

  Widget _timelinePanel() {
    return Container(
      decoration: BoxDecoration(
        color: _p.card,
        border: Border(left: BorderSide(color: _p.muted.withValues(alpha: 0.25))),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: _p.accentA.withValues(alpha: 0.08),
              border: Border(bottom: BorderSide(color: _p.muted.withValues(alpha: 0.24))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Interaction Timeline', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13.2)),
                const SizedBox(height: 4),
                Text(
                  'Logs from item selection, mode changes, and dynamic key mutations.',
                  style: TextStyle(color: _p.muted, fontSize: 10.7),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _miniMetric('events', '${_events.length}', _p.accentA),
                    _miniMetric('taps', '$_tapEvents', _p.accentB),
                    _miniMetric('mutations', '$_keyMutations', _p.accentC),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: event.tone.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: event.tone.withValues(alpha: 0.26)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              event.source,
                              style: TextStyle(
                                color: _p.ink,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w700,
                                fontSize: 10.4,
                              ),
                            ),
                          ),
                          Text(
                            _clock(event.at),
                            style: TextStyle(
                              color: _p.muted,
                              fontFamily: 'monospace',
                              fontSize: 10.1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(event.message, style: TextStyle(color: _p.ink, fontSize: 11.1, height: 1.31)),
                    ],
                  ),
                );
              },
            ),
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: _p.shell.withValues(alpha: 0.07),
      child: Row(
        children: <Widget>[
          Text(_stageTitles[_stage.index], style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11.1)),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  const _WavePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 7; i++) {
      final path = Path();
      final baseY = 22.0 + i * 28;
      path.moveTo(0, baseY);
      for (var x = 0.0; x <= size.width; x += 20) {
        final y = baseY + 8 * (i.isEven ? 1 : -1) * math.sin(x / 40);
        path.lineTo(x, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    var x = 0.0;
    while (x <= size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += 24;
    }

    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += 24;
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

// Deep visual demo for RenderTapRegionSurface
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

/// -------------------------------------------------------------------
/// RenderTapRegionSurface — Deep Visual Demo
///
/// Palette : Teal 700 (#00796B) / DeepOrange 300 (#FF8A65)
/// Tabs    : Theory · Tap Detection Lab · Group Behavior
/// Topics  : TapRegionRegistry interface, region registration,
///           hit testing, inside/outside determination,
///           group handling, consumeOutsideTaps
/// -------------------------------------------------------------------

// ── colour constants ──────────────────────────────────────────────
const Color _kPrimary = Color(0xFF00796B);
const Color _kAccent = Color(0xFFFF8A65);
const Color _kBg = Color(0xFFE0F2F1);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kDarkText = Color(0xFF212121);
const Color _kSubtle = Color(0xFF757575);
const Color _kCodeBg = Color(0xFFE8F5E9);
const Color _kDivider = Color(0xFFB2DFDB);

// ── entry point ───────────────────────────────────────────────────
dynamic build(BuildContext context) {
  return _RenderTapRegionSurfaceDemo();
}

class _RenderTapRegionSurfaceDemo extends StatefulWidget {
  @override
  State<_RenderTapRegionSurfaceDemo> createState() =>
      _RenderTapRegionSurfaceDemoState();
}

class _RenderTapRegionSurfaceDemoState
    extends State<_RenderTapRegionSurfaceDemo>
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
      backgroundColor: _kBg,
      appBar: AppBar(
        title: Text('RenderTapRegionSurface',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(text: 'Theory'),
            Tab(text: 'Tap Detection Lab'),
            Tab(text: 'Group Behavior'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _TheoryTab(),
          _TapDetectionLabTab(),
          _GroupBehaviorTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  TAB 1 — Theory
// ═══════════════════════════════════════════════════════════════════
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Class Overview ──
        _sectionCard(
          title: 'Class Overview',
          children: [
            Text(
              'RenderTapRegionSurface is the root render object that manages '
              'tap-outside detection for descendant TapRegion widgets. It '
              'implements TapRegionRegistry to track all registered regions.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'class RenderTapRegionSurface\n'
              '    extends\n'
              '      RenderProxyBoxWithHitTestBehavior\n'
              '    implements TapRegionRegistry {\n'
              '  // Registry + hit test logic\n'
              '}',
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── Inheritance ──
        _sectionCard(
          title: 'Inheritance & Interfaces',
          children: [
            _hierarchyRow('RenderProxyBoxWithHitTestBehavior',
                'Pass-through box with configurable hit behavior'),
            Divider(color: _kDivider, height: 20),
            _hierarchyRow('TapRegionRegistry',
                'Interface for region registration & lookup'),
          ],
        ),
        SizedBox(height: 16),

        // ── Registry Interface ──
        _sectionCard(
          title: 'TapRegionRegistry Interface',
          children: [
            _codeBlock(
              'abstract interface class\n'
              '    TapRegionRegistry {\n'
              '  void registerTapRegion(\n'
              '      RenderTapRegion region);\n'
              '  void unregisterTapRegion(\n'
              '      RenderTapRegion region);\n'
              '}',
            ),
            SizedBox(height: 10),
            Text(
              'TapRegion render objects call these methods when they attach '
              'and detach. The surface tracks all regions to determine which '
              'ones are hit when a tap occurs.',
              style: TextStyle(fontSize: 12, color: _kSubtle, height: 1.5),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── Internal Data Structures ──
        _sectionCard(
          title: 'Internal Data Structures',
          children: [
            _dataRow('_registeredRegions', 'Set<RenderTapRegion>',
                'All attached tap regions'),
            SizedBox(height: 8),
            _dataRow('_groupIdToRegions', 'Map<Object?, Set<RenderTapRegion>>',
                'Groups by groupId'),
            SizedBox(height: 8),
            _dataRow('_cachedResults', 'Expando<BoxHitTestResult>',
                'Cached hit test results per event'),
          ],
        ),
        SizedBox(height: 16),

        // ── Hit Test Flow ──
        _sectionCard(
          title: 'Hit Test & Event Flow',
          children: [
            _flowStep(1, 'hitTest() called',
                'Caches BoxHitTestResult for PointerDownEvent',
                Icons.touch_app, _kPrimary),
            _flowStep(2, 'handleEvent() invoked',
                'Uses cached result to find hit regions',
                Icons.smart_button, Colors.blue.shade700),
            _flowStep(3, 'Compute insideRegions',
                'hitRegions + all group members',
                Icons.group, Colors.purple),
            _flowStep(4, 'Compute outsideRegions',
                'All registered - insideRegions',
                Icons.group_off, Colors.deepOrange),
            _flowStep(5, 'Call callbacks',
                'onTapOutside/onTapInside on regions',
                Icons.notifications, _kAccent),
          ],
        ),
        SizedBox(height: 16),

        // ── Inside/Outside Logic ──
        _sectionCard(
          title: 'Inside vs Outside Determination',
          children: [
            _codeBlock(
              '// hitRegions = regions in hit path\n'
              '// insideRegions = hitRegions +\n'
              '//   all their group members\n'
              '// outsideRegions = registered - inside\n'
              '\n'
              'for (final region in insideRegions) {\n'
              '  region.onTapInside?.call(event);\n'
              '}\n'
              'for (final region in outsideRegions) {\n'
              '  region.onTapOutside?.call(event);\n'
              '}',
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, size: 16, color: _kPrimary),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Group members are always considered together — tap '
                      'inside any member means tap inside all of them.',
                      style: TextStyle(fontSize: 11, color: _kDarkText, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── consumeOutsideTaps ──
        _sectionCard(
          title: 'consumeOutsideTaps',
          children: [
            Text(
              'When an outside region has consumeOutsideTaps=true, the '
              'surface adds a dummy gesture recognizer that immediately wins '
              'the gesture arena. This prevents other recognizers from '
              'receiving the tap.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'if (shouldConsume) {\n'
              '  final dummy = _DummyTapRecognizer();\n'
              '  entry.resolve(GestureDisposition\n'
              '    .accepted);\n'
              '}',
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── Finding the Surface ──
        _sectionCard(
          title: 'Finding the Surface',
          children: [
            _codeBlock(
              'TapRegionRegistry.of(context);\n'
              '// Returns nearest ancestor\n'
              '// RenderTapRegionSurface\n'
              '\n'
              'TapRegionSurface(\n'
              '  child: TapRegion(\n'
              '    onTapOutside: (_) =>\n'
              '      print(\'tap outside!\'),\n'
              '    child: MyWidget(),\n'
              '  ),\n'
              ')',
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── Event Types ──
        _sectionCard(
          title: 'Handled Event Types',
          children: [
            _eventRow('PointerDownEvent', 'onTapOutside / onTapInside'),
            Divider(color: _kDivider, height: 16),
            _eventRow('PointerUpEvent', 'onTapUpOutside / onTapUpInside'),
            SizedBox(height: 10),
            Text(
              'Other pointer events are ignored by the surface.',
              style: TextStyle(fontSize: 11, color: _kSubtle),
            ),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  TAB 2 — Tap Detection Lab
// ═══════════════════════════════════════════════════════════════════
class _TapDetectionLabTab extends StatefulWidget {
  @override
  State<_TapDetectionLabTab> createState() => _TapDetectionLabTabState();
}

class _TapDetectionLabTabState extends State<_TapDetectionLabTab> {
  final List<String> _events = [];
  int _regionACount = 0;
  int _regionBCount = 0;
  int _regionCCount = 0;
  int _outsideCount = 0;

  void _addEvent(String msg) {
    setState(() {
      _events.insert(0, msg);
      if (_events.length > 30) _events.removeLast();
    });
  }

  void _reset() {
    setState(() {
      _events.clear();
      _regionACount = 0;
      _regionBCount = 0;
      _regionCCount = 0;
      _outsideCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── instructions ──
        _sectionCard(
          title: 'Interactive Tap Detection',
          children: [
            Text(
              'Tap inside or outside the colored regions below. The surface '
              'tracks which regions are hit and fires the appropriate callbacks.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: Icon(Icons.restart_alt, size: 16),
                  label: Text('Reset Counters'),
                  style: OutlinedButton.styleFrom(foregroundColor: _kPrimary),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── tap area ──
        _sectionCard(
          title: 'Tap Area (Surface)',
          children: [
            TapRegionSurface(
              child: GestureDetector(
                onTapDown: (_) {
                  _addEvent('Surface: tap outside all regions');
                  setState(() => _outsideCount++);
                },
                child: Container(
                  height: 280,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kDivider, width: 2),
                  ),
                  child: Stack(
                    children: [
                      // Region A — top left
                      Positioned(
                        left: 20,
                        top: 20,
                        child: TapRegion(
                          onTapInside: (_) {
                            _addEvent('Region A: TAP INSIDE');
                            setState(() => _regionACount++);
                          },
                          child: GestureDetector(
                            onTap: () {}, // absorb
                            child: _regionBox('A', _kPrimary, 90),
                          ),
                        ),
                      ),
                      // Region B — top right
                      Positioned(
                        right: 20,
                        top: 20,
                        child: TapRegion(
                          onTapInside: (_) {
                            _addEvent('Region B: TAP INSIDE');
                            setState(() => _regionBCount++);
                          },
                          child: GestureDetector(
                            onTap: () {},
                            child: _regionBox('B', _kAccent, 90),
                          ),
                        ),
                      ),
                      // Region C — center bottom
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 20,
                        child: Center(
                          child: TapRegion(
                            onTapInside: (_) {
                              _addEvent('Region C: TAP INSIDE');
                              setState(() => _regionCCount++);
                            },
                            child: GestureDetector(
                              onTap: () {},
                              child: _regionBox('C', Colors.purple, 110),
                            ),
                          ),
                        ),
                      ),
                      // Label
                      Positioned(
                        bottom: 8,
                        right: 12,
                        child: Text('Tap anywhere',
                            style: TextStyle(fontSize: 10, color: _kSubtle, fontStyle: FontStyle.italic)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── counters ──
        _sectionCard(
          title: 'Tap Counters',
          children: [
            Row(
              children: [
                Expanded(child: _counter('Region A', _regionACount, _kPrimary)),
                SizedBox(width: 8),
                Expanded(child: _counter('Region B', _regionBCount, _kAccent)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _counter('Region C', _regionCCount, Colors.purple)),
                SizedBox(width: 8),
                Expanded(child: _counter('Outside', _outsideCount, Colors.grey)),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── event log ──
        _sectionCard(
          title: 'Event Log',
          children: [
            if (_events.isEmpty)
              Text('Tap regions to see events...',
                  style: TextStyle(fontSize: 12, color: _kSubtle, fontStyle: FontStyle.italic)),
            ..._events.take(12).map((e) => Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_right, size: 14, color: _kPrimary),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(e, style: TextStyle(fontSize: 11, color: _kDarkText)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
        SizedBox(height: 16),

        // ── hit test path ──
        _sectionCard(
          title: 'Hit Test Path Visualization',
          children: [
            Text(
              'When a tap occurs, the hit test walks the render tree. '
              'RenderTapRegionSurface collects all RenderTapRegion objects '
              'in the hit path.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _pathStep('PointerDownEvent', 'Tap at (x, y)', _kPrimary),
            _pathArrow(),
            _pathStep('hitTest()', 'Walk tree → collect entries', Colors.blue.shade700),
            _pathArrow(),
            _pathStep('Cache result', '_cachedResults[event] = result', Colors.purple),
            _pathArrow(),
            _pathStep('handleEvent()', 'Process from cache', Colors.teal),
            _pathArrow(),
            _pathStep('Fire callbacks', 'onTapInside / onTapOutside', _kAccent),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }

  Widget _regionBox(String label, Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 3),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: color)),
          Text('TapRegion',
              style: TextStyle(fontSize: 9, color: color.withOpacity(0.7))),
        ],
      ),
    );
  }

  Widget _counter(String label, int count, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.touch_app, size: 18, color: color),
          SizedBox(width: 8),
          Expanded(
            child: Text(label,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
          ),
          Text('$count',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }

  Widget _pathStep(String title, String detail, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: color),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
                Text(detail, style: TextStyle(fontSize: 11, color: _kSubtle)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pathArrow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Center(child: Icon(Icons.arrow_downward, size: 16, color: _kSubtle)),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  TAB 3 — Group Behavior
// ═══════════════════════════════════════════════════════════════════
class _GroupBehaviorTab extends StatefulWidget {
  @override
  State<_GroupBehaviorTab> createState() => _GroupBehaviorTabState();
}

class _GroupBehaviorTabState extends State<_GroupBehaviorTab> {
  final List<String> _events = [];
  bool _sameGroup = true;
  bool _consumeTaps = false;
  int _group1Taps = 0;
  int _group2Taps = 0;

  void _addEvent(String msg) {
    setState(() {
      _events.insert(0, msg);
      if (_events.length > 25) _events.removeLast();
    });
  }

  void _reset() {
    setState(() {
      _events.clear();
      _group1Taps = 0;
      _group2Taps = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupIdA = _sameGroup ? 'shared' : 'groupA';
    final groupIdB = _sameGroup ? 'shared' : 'groupB';

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── explanation ──
        _sectionCard(
          title: 'Group Behavior',
          children: [
            Text(
              'Regions with the same groupId are treated as a single '
              'logical region. A tap inside ANY member is considered inside '
              'ALL members of that group.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'TapRegion(\n'
              '  groupId: \'my-group\',\n'
              '  onTapOutside: (_) =>\n'
              '    print(\'outside group\'),\n'
              '  child: widget,\n'
              ')',
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── controls ──
        _sectionCard(
          title: 'Demo Controls',
          children: [
            Row(
              children: [
                Switch(
                  value: _sameGroup,
                  activeColor: _kPrimary,
                  onChanged: (v) {
                    setState(() => _sameGroup = v);
                    _addEvent('Group mode: ${v ? 'SAME group' : 'DIFFERENT groups'}');
                  },
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _sameGroup
                        ? 'Same groupId — regions act as one'
                        : 'Different groupIds — independent regions',
                    style: TextStyle(fontSize: 12, color: _kDarkText),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Switch(
                  value: _consumeTaps,
                  activeColor: Colors.deepOrange,
                  onChanged: (v) {
                    setState(() => _consumeTaps = v);
                    _addEvent('consumeOutsideTaps: $v');
                  },
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _consumeTaps
                        ? 'consumeOutsideTaps = true'
                        : 'consumeOutsideTaps = false',
                    style: TextStyle(fontSize: 12, color: _kDarkText),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _reset,
              icon: Icon(Icons.restart_alt, size: 16),
              label: Text('Reset'),
              style: OutlinedButton.styleFrom(foregroundColor: _kPrimary),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── interactive area ──
        _sectionCard(
          title: 'Tap the Regions',
          children: [
            TapRegionSurface(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kDivider, width: 2),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: TapRegion(
                          groupId: groupIdA,
                          consumeOutsideTaps: _consumeTaps,
                          onTapInside: (_) {
                            _addEvent('Region 1 ($groupIdA): inside');
                            setState(() => _group1Taps++);
                          },
                          onTapOutside: (_) {
                            _addEvent('Region 1 ($groupIdA): OUTSIDE');
                          },
                          child: GestureDetector(
                            onTap: () {},
                            child: _groupBox('1', groupIdA, _kPrimary),
                          ),
                        ),
                      ),
                    ),
                    Container(width: 2, color: _kDivider),
                    Expanded(
                      child: Center(
                        child: TapRegion(
                          groupId: groupIdB,
                          consumeOutsideTaps: _consumeTaps,
                          onTapInside: (_) {
                            _addEvent('Region 2 ($groupIdB): inside');
                            setState(() => _group2Taps++);
                          },
                          onTapOutside: (_) {
                            _addEvent('Region 2 ($groupIdB): OUTSIDE');
                          },
                          child: GestureDetector(
                            onTap: () {},
                            child: _groupBox('2', groupIdB, _kAccent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── counters ──
        _sectionCard(
          title: 'Inside Tap Counts',
          children: [
            Row(
              children: [
                Expanded(
                  child: _groupCounter('Region 1', _group1Taps, _kPrimary),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _groupCounter('Region 2', _group2Taps, _kAccent),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── group logic explanation ──
        _sectionCard(
          title: _sameGroup ? 'Same Group Logic' : 'Different Group Logic',
          children: [
            if (_sameGroup) ...[
              Text(
                'Both regions share groupId = "shared". Tap inside either:',
                style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
              ),
              SizedBox(height: 8),
              _bulletPoint('Both receive onTapInside'),
              _bulletPoint('Neither receives onTapOutside'),
              SizedBox(height: 8),
              Text(
                'Tap outside both:',
                style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
              ),
              SizedBox(height: 4),
              _bulletPoint('Both receive onTapOutside'),
            ] else ...[
              Text(
                'Regions have different groupIds. Tap inside one:',
                style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
              ),
              SizedBox(height: 8),
              _bulletPoint('That region receives onTapInside'),
              _bulletPoint('Other region receives onTapOutside'),
            ],
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _consumeTaps ? Colors.deepOrange.shade50 : _kBg,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _consumeTaps ? Colors.deepOrange.shade200 : _kDivider,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _consumeTaps ? Icons.block : Icons.info_outline,
                    size: 16,
                    color: _consumeTaps ? Colors.deepOrange : _kPrimary,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _consumeTaps
                          ? 'consumeOutsideTaps is ON — outside taps are '
                            'consumed, preventing other gesture recognizers.'
                          : 'consumeOutsideTaps is OFF — taps propagate normally.',
                      style: TextStyle(
                          fontSize: 11,
                          color: _consumeTaps ? Colors.deepOrange.shade800 : _kSubtle,
                          height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── event log ──
        _sectionCard(
          title: 'Event Log',
          children: [
            if (_events.isEmpty)
              Text('Tap regions to see events...',
                  style: TextStyle(fontSize: 12, color: _kSubtle, fontStyle: FontStyle.italic)),
            ..._events.take(10).map((e) => Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_right, size: 14, color: _kPrimary),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(e, style: TextStyle(fontSize: 11, color: _kDarkText)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
        SizedBox(height: 16),

        // ── use cases ──
        _sectionCard(
          title: 'Common Use Cases',
          children: [
            _useCase(Icons.menu, 'Dropdown menus',
                'Tap outside to close — all menu items share a groupId'),
            SizedBox(height: 10),
            _useCase(Icons.edit, 'Form fields',
                'Tap outside to unfocus — group related inputs'),
            SizedBox(height: 10),
            _useCase(Icons.chat_bubble_outline, 'Popovers / tooltips',
                'Dismiss on outside tap with consumeOutsideTaps'),
            SizedBox(height: 10),
            _useCase(Icons.dashboard, 'Modal dialogs',
                'Multiple floating elements as one dismissal zone'),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }

  Widget _groupBox(String label, String groupId, Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: color)),
          Container(
            margin: EdgeInsets.only(top: 4),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(groupId,
                style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _groupCounter(String label, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
          SizedBox(height: 4),
          Text('$count',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 12, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 12, color: _kPrimary)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 12, color: _kDarkText)),
          ),
        ],
      ),
    );
  }

  Widget _useCase(IconData icon, String title, String detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: _kPrimary),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
              Text(detail, style: TextStyle(fontSize: 11, color: _kSubtle)),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  Shared helpers
// ═══════════════════════════════════════════════════════════════════

Widget _sectionCard({required String title, required List<Widget> children}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 18, color: _kPrimary),
            SizedBox(width: 8),
            Expanded(
              child: Text(title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(code,
        style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _kDarkText, height: 1.5)),
  );
}

Widget _hierarchyRow(String name, String description) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.account_tree, size: 16, color: _kPrimary),
      SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                    fontFamily: 'monospace', color: _kDarkText)),
            Text(description, style: TextStyle(fontSize: 11, color: _kSubtle)),
          ],
        ),
      ),
    ],
  );
}

Widget _dataRow(String name, String type, String desc) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.data_object, size: 14, color: _kPrimary),
      SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(name,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                        fontFamily: 'monospace', color: _kPrimary)),
                SizedBox(width: 6),
                Text(type,
                    style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _kSubtle)),
              ],
            ),
            Text(desc, style: TextStyle(fontSize: 11, color: _kDarkText)),
          ],
        ),
      ),
    ],
  );
}

Widget _flowStep(int number, String title, String detail, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          alignment: Alignment.center,
          child: Text('$number',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16, color: color),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(title,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
                  ),
                ],
              ),
              Text(detail, style: TextStyle(fontSize: 11, color: _kSubtle)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _eventRow(String eventType, String callbacks) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _kPrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(eventType,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                fontFamily: 'monospace', color: _kPrimary)),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text('→ $callbacks', style: TextStyle(fontSize: 11, color: _kDarkText)),
      ),
    ],
  );
}

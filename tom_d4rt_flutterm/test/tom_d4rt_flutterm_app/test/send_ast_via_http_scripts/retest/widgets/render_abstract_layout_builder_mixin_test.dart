// Deep visual demo for RenderAbstractLayoutBuilderMixin
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

/// -------------------------------------------------------------------
/// RenderAbstractLayoutBuilderMixin — Deep Visual Demo
///
/// Palette : Pink 800 (#AD1457) / LightGreen 400 (#9CCC65)
/// Tabs    : Theory · Constraint Flow Lab · Custom LayoutInfo
/// Topics  : Mixin anatomy, type parameters, callback mechanism,
///           layoutInfo property, LayoutBuilder integration,
///           custom layoutInfo override, performLayout cycle
/// -------------------------------------------------------------------

// ── colour constants ──────────────────────────────────────────────
const Color _kPrimary = Color(0xFFAD1457);
const Color _kAccent = Color(0xFF9CCC65);
const Color _kBg = Color(0xFFFCE4EC);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kDarkText = Color(0xFF212121);
const Color _kSubtle = Color(0xFF757575);
const Color _kCodeBg = Color(0xFFF3E5F5);
const Color _kDivider = Color(0xFFE0E0E0);

// ── entry point ───────────────────────────────────────────────────
dynamic build(BuildContext context) {
  return _RenderAbstractLayoutBuilderMixinDemo();
}

class _RenderAbstractLayoutBuilderMixinDemo extends StatefulWidget {
  @override
  State<_RenderAbstractLayoutBuilderMixinDemo> createState() =>
      _RenderAbstractLayoutBuilderMixinDemoState();
}

class _RenderAbstractLayoutBuilderMixinDemoState
    extends State<_RenderAbstractLayoutBuilderMixinDemo>
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
        title: Text('RenderAbstractLayoutBuilderMixin',
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
            Tab(text: 'Constraint Flow Lab'),
            Tab(text: 'Custom LayoutInfo'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _TheoryTab(),
          _ConstraintFlowLabTab(),
          _CustomLayoutInfoTab(),
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
        // ── Mixin signature ──
        _sectionCard(
          title: 'Mixin Signature',
          children: [
            Text(
              'RenderAbstractLayoutBuilderMixin is a mixin applied to '
              'RenderObjects that need to invoke a builder callback during '
              'layout, enabling responsive widgets like LayoutBuilder.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'mixin RenderAbstractLayoutBuilderMixin<\n'
              '    LayoutInfoType, ChildType extends RenderObject>\n'
              '  on RenderObjectWithChildMixin<ChildType>,\n'
              '     RenderObjectWithLayoutCallbackMixin {\n'
              '  // ...\n'
              '}',
            ),
            SizedBox(height: 10),
            _typeBadge('LayoutInfoType', 'Info passed to builder callback'),
            SizedBox(height: 6),
            _typeBadge('ChildType', 'Type of child RenderObject'),
          ],
        ),

        SizedBox(height: 16),

        // ── Super-mixins ──
        _sectionCard(
          title: 'Super-Mixin Requirements',
          children: [
            _hierarchyRow('RenderObjectWithChildMixin<ChildType>',
                'Single-child protocol (child getter/setter)'),
            Divider(color: _kDivider, height: 20),
            _hierarchyRow('RenderObjectWithLayoutCallbackMixin',
                'Schedules layout callbacks during performLayout'),
          ],
        ),

        SizedBox(height: 16),

        // ── Callback mechanism ──
        _sectionCard(
          title: 'Callback Mechanism',
          children: [
            Text(
              'The mixin stores a LayoutCallback and invokes it during '
              'performLayout. The framework sets this callback via '
              'updateCallback().',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'LayoutCallback<LayoutInfoType>? _callback;\n'
              '\n'
              'void updateCallback(\n'
              '    LayoutCallback<LayoutInfoType>? value) {\n'
              '  if (value == _callback) return;\n'
              '  _callback = value;\n'
              '  markNeedsLayout();\n'
              '}',
            ),
            SizedBox(height: 12),
            _flowArrow('Widget rebuilds', 'updateCallback() called'),
            _flowArrow('Callback changes', 'markNeedsLayout()'),
            _flowArrow('performLayout runs', 'layoutCallback() invoked'),
          ],
        ),

        SizedBox(height: 16),

        // ── layoutCallback method ──
        _sectionCard(
          title: 'layoutCallback() Method',
          children: [
            _codeBlock(
              '@visibleForOverriding\n'
              'void layoutCallback() {\n'
              '  assert(_callback != null);\n'
              '  invokeLayoutCallback<LayoutInfoType>(\n'
              '    (LayoutInfoType info) {\n'
              '      _callback!(info);\n'
              '    },\n'
              '  );\n'
              '}',
            ),
            SizedBox(height: 10),
            Text(
              'Called during performLayout. The default passes layoutInfo '
              'to the builder callback. Subclasses may override to customise '
              'the invocation.',
              style: TextStyle(fontSize: 12, color: _kSubtle, height: 1.5),
            ),
          ],
        ),

        SizedBox(height: 16),

        // ── layoutInfo property ──
        _sectionCard(
          title: 'layoutInfo Property',
          children: [
            _codeBlock(
              '@protected\n'
              'LayoutInfoType get layoutInfo;\n'
              '\n'
              '// RenderConstrainedLayoutBuilder default:\n'
              'BoxConstraints get layoutInfo => constraints;',
            ),
            SizedBox(height: 10),
            Text(
              'Returns the data passed to the builder callback. '
              'For standard LayoutBuilder this is the incoming constraints. '
              'Override to provide richer data.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
          ],
        ),

        SizedBox(height: 16),

        // ── LayoutBuilder usage ──
        _sectionCard(
          title: 'LayoutBuilder Widget',
          children: [
            Text(
              'LayoutBuilder is the primary consumer of this mixin. '
              'Its RenderObject mixes in RenderAbstractLayoutBuilderMixin '
              'to receive constraints in the builder callback.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'LayoutBuilder(\n'
              '  builder: (context, constraints) {\n'
              '    if (constraints.maxWidth > 600) {\n'
              '      return _WideLayout();\n'
              '    }\n'
              '    return _NarrowLayout();\n'
              '  },\n'
              ')',
            ),
          ],
        ),

        SizedBox(height: 16),

        // ── performLayout cycle ──
        _sectionCard(
          title: 'performLayout Cycle',
          children: [
            _cycleStep(1, 'Parent provides constraints',
                'RenderObject receives BoxConstraints'),
            _cycleStep(2, 'layoutCallback() invoked',
                'Builder callback runs with layoutInfo'),
            _cycleStep(3, 'Builder creates widget subtree',
                'New widgets are built and elements created'),
            _cycleStep(4, 'Child laid out',
                'child!.layout(constraints, parentUsesSize: true)'),
            _cycleStep(5, 'Size determined',
                'size = constraints.constrain(child!.size)'),
          ],
        ),

        SizedBox(height: 16),

        // ── RenderConstrainedLayoutBuilder alias ──
        _sectionCard(
          title: 'RenderConstrainedLayoutBuilder',
          children: [
            Text(
              'The concrete subclass that specialises LayoutInfoType to '
              'BoxConstraints. This is what LayoutBuilder actually uses.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'abstract class\n'
              '  _RenderLayoutBuilder extends RenderBox\n'
              '  with RenderObjectWithChildMixin<RenderBox>,\n'
              '       RenderObjectWithLayoutCallbackMixin,\n'
              '       RenderAbstractLayoutBuilderMixin<\n'
              '         BoxConstraints, RenderBox> {\n'
              '  @override\n'
              '  BoxConstraints get layoutInfo =>\n'
              '      constraints;\n'
              '}',
            ),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  TAB 2 — Constraint Flow Lab
// ═══════════════════════════════════════════════════════════════════
class _ConstraintFlowLabTab extends StatefulWidget {
  @override
  State<_ConstraintFlowLabTab> createState() => _ConstraintFlowLabTabState();
}

class _ConstraintFlowLabTabState extends State<_ConstraintFlowLabTab> {
  double _parentWidth = 320;
  double _parentHeight = 200;
  bool _tight = false;
  final List<String> _log = [];

  BoxConstraints get _currentConstraints => _tight
      ? BoxConstraints.tightFor(width: _parentWidth, height: _parentHeight)
      : BoxConstraints(
          maxWidth: _parentWidth,
          maxHeight: _parentHeight,
          minWidth: 0,
          minHeight: 0,
        );

  void _addLog(String msg) {
    setState(() {
      _log.insert(0, msg);
      if (_log.length > 40) _log.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── controls ──
        _sectionCard(
          title: 'Parent Constraint Controls',
          children: [
            _sliderRow('Max Width', _parentWidth, 80, 400, (v) {
              setState(() => _parentWidth = v);
              _addLog('Width → ${v.toStringAsFixed(0)}');
            }),
            SizedBox(height: 8),
            _sliderRow('Max Height', _parentHeight, 60, 400, (v) {
              setState(() => _parentHeight = v);
              _addLog('Height → ${v.toStringAsFixed(0)}');
            }),
            SizedBox(height: 12),
            Row(
              children: [
                Switch(
                  value: _tight,
                  activeColor: _kPrimary,
                  onChanged: (v) {
                    setState(() => _tight = v);
                    _addLog('Tight: $v');
                  },
                ),
                SizedBox(width: 8),
                Text('Tight constraints',
                    style: TextStyle(fontSize: 12, color: _kDarkText)),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── constraint display ──
        _sectionCard(
          title: 'Incoming BoxConstraints',
          children: [
            _constraintBox(_currentConstraints),
          ],
        ),
        SizedBox(height: 16),

        // ── live LayoutBuilder ──
        _sectionCard(
          title: 'LayoutBuilder Receives Constraints',
          children: [
            Text(
              'The box below uses LayoutBuilder. As you change the sliders, '
              'the builder callback receives updated constraints and adapts.',
              style: TextStyle(fontSize: 12, color: _kSubtle, height: 1.5),
            ),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: _kPrimary, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ConstrainedBox(
                constraints: _currentConstraints,
                child: LayoutBuilder(
                  builder: (ctx, constraints) {
                    final w = constraints.maxWidth;
                    final h = constraints.maxHeight;
                    final isWide = w > 200;
                    final isTall = h > 150;
                    return Container(
                      width: w,
                      height: h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            _kPrimary.withOpacity(0.15),
                            _kAccent.withOpacity(0.25),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isWide ? Icons.aspect_ratio : Icons.crop_portrait,
                            color: _kPrimary,
                            size: 28,
                          ),
                          SizedBox(height: 6),
                          Text(
                            '${w.toStringAsFixed(0)} × ${h.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _kPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            isWide && isTall
                                ? 'Wide + Tall → full layout'
                                : isWide
                                    ? 'Wide → horizontal layout'
                                    : isTall
                                        ? 'Tall → vertical layout'
                                        : 'Compact → minimal layout',
                            style: TextStyle(
                                fontSize: 11, color: _kSubtle),
                          ),
                          if (constraints.isTight) ...[
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _kAccent.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text('TIGHT',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: _kPrimary)),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── flow diagram ──
        _sectionCard(
          title: 'Constraint Flow Pipeline',
          children: [
            _pipelineStep('Parent', 'Provides constraints to child',
                Icons.account_tree, _kPrimary),
            _pipelineArrow(),
            _pipelineStep('performLayout()', 'Calls layoutCallback()',
                Icons.settings, Colors.deepOrange),
            _pipelineArrow(),
            _pipelineStep('layoutCallback()', 'Invokes builder with layoutInfo',
                Icons.build_circle, Colors.blue.shade700),
            _pipelineArrow(),
            _pipelineStep('Builder callback', 'Receives constraints, returns widget',
                Icons.widgets, _kAccent),
            _pipelineArrow(),
            _pipelineStep('Child layout', 'child.layout(constraints)',
                Icons.crop_free, Colors.teal),
          ],
        ),
        SizedBox(height: 16),

        // ── event log ──
        _sectionCard(
          title: 'Constraint Change Log',
          children: [
            if (_log.isEmpty)
              Text('Move sliders to see events...',
                  style: TextStyle(fontSize: 12, color: _kSubtle, fontStyle: FontStyle.italic)),
            ..._log.take(15).map((e) => Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_right, size: 14, color: _kPrimary),
                      SizedBox(width: 4),
                      Text(e, style: TextStyle(fontSize: 11, color: _kDarkText)),
                    ],
                  ),
                )),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }

  Widget _sliderRow(
      String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(label,
              style: TextStyle(fontSize: 12, color: _kDarkText, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            activeColor: _kPrimary,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(value.toStringAsFixed(0),
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _kPrimary)),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  TAB 3 — Custom LayoutInfo
// ═══════════════════════════════════════════════════════════════════
class _CustomLayoutInfoTab extends StatefulWidget {
  @override
  State<_CustomLayoutInfoTab> createState() => _CustomLayoutInfoTabState();
}

class _CustomLayoutInfoTabState extends State<_CustomLayoutInfoTab> {
  double _width = 300;
  double _density = 1.0;
  bool _rtl = false;
  String _theme = 'light';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── why custom layoutInfo ──
        _sectionCard(
          title: 'Why Override layoutInfo?',
          children: [
            Text(
              'The default layoutInfo returns BoxConstraints. But some widgets '
              'need richer data: device density, text direction, theme mode, or '
              'custom metrics computed during layout.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'class MyLayoutInfo {\n'
              '  final BoxConstraints constraints;\n'
              '  final double devicePixelRatio;\n'
              '  final TextDirection textDirection;\n'
              '  final String themeMode;\n'
              '\n'
              '  const MyLayoutInfo({\n'
              '    required this.constraints,\n'
              '    required this.devicePixelRatio,\n'
              '    required this.textDirection,\n'
              '    required this.themeMode,\n'
              '  });\n'
              '}',
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── override example ──
        _sectionCard(
          title: 'Overriding layoutInfo',
          children: [
            _codeBlock(
              'mixin _RenderMyLayoutBuilder\n'
              '  on RenderBox,\n'
              '     RenderObjectWithChildMixin<RenderBox>,\n'
              '     RenderObjectWithLayoutCallbackMixin,\n'
              '     RenderAbstractLayoutBuilderMixin<\n'
              '       MyLayoutInfo, RenderBox> {\n'
              '\n'
              '  @override\n'
              '  MyLayoutInfo get layoutInfo =>\n'
              '    MyLayoutInfo(\n'
              '      constraints: constraints,\n'
              '      devicePixelRatio: _ratio,\n'
              '      textDirection: _dir,\n'
              '      themeMode: _mode,\n'
              '    );\n'
              '}',
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── interactive controls ──
        _sectionCard(
          title: 'Simulate Custom LayoutInfo',
          children: [
            Text(
              'Adjust the parameters below to see how a custom layoutInfo '
              'might carry additional data beyond constraints.',
              style: TextStyle(fontSize: 12, color: _kSubtle, height: 1.5),
            ),
            SizedBox(height: 12),
            // Width slider
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text('maxWidth',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
                ),
                Expanded(
                  child: Slider(
                    value: _width,
                    min: 100,
                    max: 400,
                    activeColor: _kPrimary,
                    onChanged: (v) => setState(() => _width = v),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(_width.toStringAsFixed(0),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _kPrimary)),
                ),
              ],
            ),
            // Density slider
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text('devicePixelRatio',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
                ),
                Expanded(
                  child: Slider(
                    value: _density,
                    min: 1.0,
                    max: 4.0,
                    divisions: 6,
                    activeColor: _kPrimary,
                    onChanged: (v) => setState(() => _density = v),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(_density.toStringAsFixed(1),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _kPrimary)),
                ),
              ],
            ),
            // RTL toggle
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text('textDirection',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
                ),
                Switch(
                  value: _rtl,
                  activeColor: _kPrimary,
                  onChanged: (v) => setState(() => _rtl = v),
                ),
                Text(_rtl ? 'RTL' : 'LTR',
                    style: TextStyle(fontSize: 12, color: _kDarkText)),
              ],
            ),
            // Theme selector
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text('themeMode',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
                ),
                SegmentedButton<String>(
                  segments: [
                    ButtonSegment(value: 'light', label: Text('Light', style: TextStyle(fontSize: 11))),
                    ButtonSegment(value: 'dark', label: Text('Dark', style: TextStyle(fontSize: 11))),
                    ButtonSegment(value: 'system', label: Text('System', style: TextStyle(fontSize: 11))),
                  ],
                  selected: {_theme},
                  onSelectionChanged: (s) => setState(() => _theme = s.first),
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── resulting layoutInfo object ──
        _sectionCard(
          title: 'Resulting LayoutInfo Object',
          children: [
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kCodeBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kPrimary.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoField('constraints',
                      'BoxConstraints(0.0 ≤ w ≤ ${_width.toStringAsFixed(0)}, unbounded h)'),
                  SizedBox(height: 6),
                  _infoField('devicePixelRatio', _density.toStringAsFixed(1)),
                  SizedBox(height: 6),
                  _infoField('textDirection', _rtl ? 'TextDirection.rtl' : 'TextDirection.ltr'),
                  SizedBox(height: 6),
                  _infoField('themeMode', _theme),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── visual preview ──
        _sectionCard(
          title: 'Builder Preview (Simulated)',
          children: [
            Text(
              'This preview shows how a builder might adapt its UI based '
              'on the full layoutInfo rather than constraints alone.',
              style: TextStyle(fontSize: 12, color: _kSubtle, height: 1.5),
            ),
            SizedBox(height: 12),
            Container(
              width: _width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _theme == 'dark' ? Color(0xFF303030) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kPrimary.withOpacity(0.4), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Directionality(
                textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.dashboard_customize,
                            color: _theme == 'dark' ? _kAccent : _kPrimary,
                            size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Custom Builder Output',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _theme == 'dark' ? Colors.white : _kDarkText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _previewMetric('Width', '${_width.toStringAsFixed(0)}px',
                        _theme == 'dark' ? Colors.white70 : _kSubtle),
                    _previewMetric('Density', '${_density.toStringAsFixed(1)}x',
                        _theme == 'dark' ? Colors.white70 : _kSubtle),
                    _previewMetric('Direction', _rtl ? 'RTL' : 'LTR',
                        _theme == 'dark' ? Colors.white70 : _kSubtle),
                    _previewMetric('Theme', _theme,
                        _theme == 'dark' ? Colors.white70 : _kSubtle),
                    SizedBox(height: 10),
                    // density bar
                    Row(
                      children: [
                        Text('Pixel density: ',
                            style: TextStyle(
                                fontSize: 10,
                                color: _theme == 'dark' ? Colors.white54 : _kSubtle)),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: _density / 4.0,
                              backgroundColor: _kDivider,
                              valueColor: AlwaysStoppedAnimation(_kAccent),
                              minHeight: 6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── comparison table ──
        _sectionCard(
          title: 'Default vs Custom layoutInfo',
          children: [
            _comparisonHeader(),
            _comparisonRow('Data type', 'BoxConstraints', 'Custom class'),
            _comparisonRow('Contains', 'min/max width & height', 'Constraints + extras'),
            _comparisonRow('Override needed', 'No', 'Yes — get layoutInfo'),
            _comparisonRow('Use case', 'LayoutBuilder', 'Custom layout widgets'),
            _comparisonRow('Complexity', 'Simple', 'More flexible'),
          ],
        ),
        SizedBox(height: 16),

        // ── best practices ──
        _sectionCard(
          title: 'Best Practices',
          children: [
            _bestPractice(Icons.check_circle, 'Keep layoutInfo immutable',
                'Create new instances each time, never mutate.'),
            SizedBox(height: 8),
            _bestPractice(Icons.check_circle, 'Override layoutCallback() sparingly',
                'The default invocation is correct for most cases.'),
            SizedBox(height: 8),
            _bestPractice(Icons.check_circle, 'Use markNeedsLayout()',
                'When external data changes that affects layoutInfo.'),
            SizedBox(height: 8),
            _bestPractice(Icons.warning_amber, 'Avoid side effects in builder',
                'The builder runs during layout — keep it pure.'),
            SizedBox(height: 8),
            _bestPractice(Icons.warning_amber, 'Do not read layoutInfo outside layout',
                'It may not be computed yet.'),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }

  Widget _previewMetric(String label, String value, Color textColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$label: ',
              style: TextStyle(fontSize: 11, color: textColor)),
          Text(value,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700, color: textColor)),
        ],
      ),
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

Widget _typeBadge(String name, String description) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _kAccent.withOpacity(0.25),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(name,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: _kPrimary)),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(description, style: TextStyle(fontSize: 11, color: _kSubtle)),
      ),
    ],
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

Widget _flowArrow(String from, String to) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _kPrimary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(from, style: TextStyle(fontSize: 10, color: _kPrimary, fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.arrow_forward, size: 14, color: _kSubtle),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _kAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(to, style: TextStyle(fontSize: 10, color: _kDarkText, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

Widget _cycleStep(int number, String title, String detail) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(shape: BoxShape.circle, color: _kPrimary),
          alignment: Alignment.center,
          child: Text('$number',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
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

Widget _constraintBox(BoxConstraints c) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kPrimary.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kPrimary.withOpacity(0.3)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _constraintCell('minWidth', c.minWidth.toStringAsFixed(0)),
            _constraintCell('maxWidth', c.maxWidth.toStringAsFixed(0)),
          ],
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _constraintCell('minHeight', c.minHeight.toStringAsFixed(0)),
            _constraintCell('maxHeight', c.maxHeight.toStringAsFixed(0)),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: c.isTight ? _kAccent.withOpacity(0.3) : _kDivider,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            c.isTight ? 'TIGHT' : 'LOOSE',
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: c.isTight ? _kPrimary : _kSubtle),
          ),
        ),
      ],
    ),
  );
}

Widget _constraintCell(String label, String value) {
  return Column(
    children: [
      Text(label, style: TextStyle(fontSize: 10, color: _kSubtle)),
      Text(value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kPrimary)),
    ],
  );
}

Widget _pipelineStep(String title, String subtitle, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20, color: color),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
              Text(subtitle, style: TextStyle(fontSize: 11, color: _kSubtle)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pipelineArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Center(
      child: Icon(Icons.arrow_downward, size: 18, color: _kSubtle),
    ),
  );
}

Widget _infoField(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 120,
        child: Text('$label:',
            style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: _kPrimary,
                fontWeight: FontWeight.w600)),
      ),
      Expanded(
        child: Text(value,
            style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _kDarkText)),
      ),
    ],
  );
}

Widget _comparisonHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: _kPrimary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text('Aspect',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _kPrimary)),
        ),
        Expanded(
          flex: 3,
          child: Text('Default (BoxConstraints)',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _kPrimary)),
        ),
        Expanded(
          flex: 3,
          child: Text('Custom LayoutInfo',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _kPrimary)),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(String aspect, String defaultVal, String customVal) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(aspect,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _kDarkText)),
        ),
        Expanded(
          flex: 3,
          child: Text(defaultVal, style: TextStyle(fontSize: 11, color: _kSubtle)),
        ),
        Expanded(
          flex: 3,
          child: Text(customVal, style: TextStyle(fontSize: 11, color: _kSubtle)),
        ),
      ],
    ),
  );
}

Widget _bestPractice(IconData icon, String title, String detail) {
  final isWarning = icon == Icons.warning_amber;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 18, color: isWarning ? Colors.orange.shade700 : _kAccent),
      SizedBox(width: 8),
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

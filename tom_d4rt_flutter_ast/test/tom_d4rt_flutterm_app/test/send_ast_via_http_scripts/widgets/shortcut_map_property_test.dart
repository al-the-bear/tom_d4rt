// Deep visual demo for d4rt AST harness: ShortcutMapProperty.
//
// ShortcutMapProperty is a DiagnosticsProperty<Map<ShortcutActivator, Intent>>
// that formats Shortcuts.shortcuts for debug trees. This file exercises it
// across several diagnostic tree styles, side-by-side comparisons, and a
// hand-drawn "blueprint" information-architecture diagram.
//
// Palette: ivory #FEFEFE, cobalt #1D4ED8, graphite #111827.
// Harness: `dynamic build(BuildContext)` returning MaterialApp/Scaffold.

import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Palette and layout constants
// ---------------------------------------------------------------------------

const Color _kIvory = Color(0xFFFEFEFE);
const Color _kCobalt = Color(0xFF1D4ED8);
const Color _kGraphite = Color(0xFF111827);
const Color _kCobaltSoft = Color(0xFFDBE4FB);
const Color _kGraphiteSoft = Color(0xFF374151);
const Color _kBlueprintGrid = Color(0x1F1D4ED8);
const Color _kBlueprintGridStrong = Color(0x3F1D4ED8);

const double _kCardRadius = 14;
const double _kSectionGap = 22;
const double _kInnerPadding = 18;

const TextStyle _kMonoStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  height: 1.32,
  color: _kGraphite,
);

const TextStyle _kMonoDim = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11.5,
  height: 1.3,
  color: _kGraphiteSoft,
);

const TextStyle _kMonoAccent = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  height: 1.32,
  color: _kCobalt,
  fontWeight: FontWeight.w600,
);

const TextStyle _kHeadingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
  color: _kGraphite,
  letterSpacing: -0.3,
);

const TextStyle _kSubHeadingStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: _kGraphite,
  letterSpacing: -0.1,
);

const TextStyle _kBodyStyle = TextStyle(
  fontSize: 13.5,
  height: 1.45,
  color: _kGraphiteSoft,
);

const TextStyle _kLabelStyle = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.1,
  color: _kCobalt,
);

// ---------------------------------------------------------------------------
// Top-level harness entry
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('ShortcutMapProperty visual demo: build() invoked.');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ShortcutMapProperty Visual Demo',
    home: _ShortcutMapDemoHome(),
  );
}

// ---------------------------------------------------------------------------
// Demo home
// ---------------------------------------------------------------------------

class _ShortcutMapDemoHome extends StatefulWidget {
  const _ShortcutMapDemoHome();

  @override
  State<_ShortcutMapDemoHome> createState() => _ShortcutMapDemoHomeState();
}

class _ShortcutMapDemoHomeState extends State<_ShortcutMapDemoHome> {
  DiagnosticsTreeStyle _selectedStyle = DiagnosticsTreeStyle.sparse;
  int _activeMapIndex = 0;

  static final List<_LabeledShortcutMap> _maps = _buildSampleMaps();

  void _selectStyle(DiagnosticsTreeStyle style) {
    debugPrint('ShortcutMapProperty visual demo: style -> $style');
    setState(() {
      _selectedStyle = style;
    });
  }

  void _selectMap(int index) {
    debugPrint('ShortcutMapProperty visual demo: map -> $index');
    setState(() {
      _activeMapIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _LabeledShortcutMap active = _maps[_activeMapIndex];

    return Scaffold(
      backgroundColor: _kIvory,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 28,
              ),
              children: <Widget>[
                const _DiagnosticBlueprintHero(),
                const SizedBox(height: _kSectionGap),
                _ShortcutMapRenderCard(labeledMap: active),
                const SizedBox(height: _kSectionGap),
                _MapPickerPanel(
                  maps: _maps,
                  activeIndex: _activeMapIndex,
                  onSelect: _selectMap,
                ),
                const SizedBox(height: _kSectionGap),
                _StyleSelectorPanel(
                  activeStyle: _selectedStyle,
                  onStyleSelected: _selectStyle,
                ),
                const SizedBox(height: _kSectionGap),
                _StyledRenderCard(
                  labeledMap: active,
                  style: _selectedStyle,
                ),
                const SizedBox(height: _kSectionGap),
                _BeforeAfterComparisonCard(
                  primary: _maps[0],
                  secondary: _maps[1],
                  style: _selectedStyle,
                ),
                const SizedBox(height: _kSectionGap),
                const _DiagnosticTreeVisualPanel(),
                const SizedBox(height: _kSectionGap),
                const _WhereYouSeeItPanel(),
                const SizedBox(height: _kSectionGap),
                const _FieldReferenceTable(),
                const SizedBox(height: _kSectionGap),
                const _HarnessFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1) Hero — blueprint-style painter
// ---------------------------------------------------------------------------

class _DiagnosticBlueprintHero extends StatelessWidget {
  const _DiagnosticBlueprintHero();

  @override
  Widget build(BuildContext context) {
    return _FramedCard(
      accent: _kCobalt,
      child: SizedBox(
        height: 320,
        child: Stack(
          children: <Widget>[
            const Positioned.fill(
              child: _BlueprintBackdrop(),
            ),
            Padding(
              padding: const EdgeInsets.all(_kInnerPadding + 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _BadgeRow(
                    tag: 'DIAGNOSTIC PANEL',
                    subtitle: 'flutter/foundation · widgets/shortcuts',
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'ShortcutMapProperty',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: _kGraphite,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'DiagnosticsProperty<Map<ShortcutActivator, Intent>>',
                    style: _kMonoAccent,
                  ),
                  const SizedBox(height: 12),
                  const Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Text(
                            'A hand-authored tour of how ShortcutMapProperty '
                            'serializes a Shortcuts map for debug output. '
                            'The property overrides valueToString() so every '
                            'ShortcutActivator key is rendered via its own '
                            'debugDescribeKeys() and each Intent value uses '
                            'its own toString(). The result embeds cleanly '
                            'into a parent DiagnosticsNode tree.',
                            style: _kBodyStyle,
                          ),
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          flex: 3,
                          child: _BlueprintCalloutList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlueprintBackdrop extends StatelessWidget {
  const _BlueprintBackdrop();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_kCardRadius),
      child: CustomPaint(
        painter: _BlueprintPainter(),
      ),
    );
  }
}

class _BlueprintPainter extends CustomPainter {
  _BlueprintPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint background = Paint()..color = _kIvory;
    canvas.drawRect(Offset.zero & size, background);

    final Paint gridMinor = Paint()
      ..color = _kBlueprintGrid
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;
    final Paint gridMajor = Paint()
      ..color = _kBlueprintGridStrong
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;

    const double minorStep = 16;
    const double majorStep = 96;

    for (double x = 0; x <= size.width; x += minorStep) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridMinor);
    }
    for (double y = 0; y <= size.height; y += minorStep) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridMinor);
    }
    for (double x = 0; x <= size.width; x += majorStep) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridMajor);
    }
    for (double y = 0; y <= size.height; y += majorStep) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridMajor);
    }

    // Decorative callout arrow pointing at title area.
    final Path arrow = Path()
      ..moveTo(size.width - 150, 70)
      ..lineTo(size.width - 40, 44)
      ..lineTo(size.width - 62, 52)
      ..moveTo(size.width - 40, 44)
      ..lineTo(size.width - 54, 28);
    final Paint arrowPaint = Paint()
      ..color = _kCobalt.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(arrow, arrowPaint);

    // Corner crosshairs.
    final Paint crossPaint = Paint()
      ..color = _kCobalt.withValues(alpha: 0.45)
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke;
    const double crossLength = 10;
    const List<Offset> corners = <Offset>[
      Offset(16, 16),
      Offset(0, 16),
      Offset(16, 0),
    ];
    for (final Offset c in corners) {
      canvas.drawLine(
        Offset(c.dx - crossLength, c.dy),
        Offset(c.dx + crossLength, c.dy),
        crossPaint,
      );
      canvas.drawLine(
        Offset(c.dx, c.dy - crossLength),
        Offset(c.dx, c.dy + crossLength),
        crossPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BlueprintPainter oldDelegate) => false;
}

class _BlueprintCalloutList extends StatelessWidget {
  const _BlueprintCalloutList();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kIvory,
        border: Border.all(color: _kCobalt.withValues(alpha: 0.4), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          _CalloutBullet(
            index: '01',
            label: 'debugDescribeKeys()',
            hint: 'Activator -> key label',
          ),
          SizedBox(height: 6),
          _CalloutBullet(
            index: '02',
            label: 'Intent.toString()',
            hint: 'Value -> intent tag',
          ),
          SizedBox(height: 6),
          _CalloutBullet(
            index: '03',
            label: 'DiagnosticsNode',
            hint: 'Parent tree fragment',
          ),
        ],
      ),
    );
  }
}

class _CalloutBullet extends StatelessWidget {
  const _CalloutBullet({
    required this.index,
    required this.label,
    required this.hint,
  });

  final String index;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kCobaltSoft,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            index,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: _kCobalt,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: _kMonoAccent),
              Text(hint, style: _kMonoDim),
            ],
          ),
        ),
      ],
    );
  }
}

class _BadgeRow extends StatelessWidget {
  const _BadgeRow({required this.tag, required this.subtitle});
  final String tag;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _kCobalt,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: _kIvory,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(child: Text(subtitle, style: _kMonoDim)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 2) ShortcutMapProperty render card
// ---------------------------------------------------------------------------

class _ShortcutMapRenderCard extends StatelessWidget {
  const _ShortcutMapRenderCard({required this.labeledMap});

  final _LabeledShortcutMap labeledMap;

  @override
  Widget build(BuildContext context) {
    final ShortcutMapProperty prop = ShortcutMapProperty(
      labeledMap.propertyName,
      labeledMap.map,
    );
    final String rendered = prop.toString();
    final String rawValueToString = prop.valueToString();
    final List<MapEntry<String, String>> breakdown = _breakdownEntries(
      labeledMap.map,
    );

    return _FramedCard(
      accent: _kCobalt,
      title: 'Live ShortcutMapProperty inspection',
      subtitle:
          'Construct a ShortcutMapProperty and show how it renders via its own '
          'toString() and valueToString() along with per-entry details.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _PropertyHeaderChip(labeledMap: labeledMap),
          const SizedBox(height: 14),
          const _MiniSectionHeader(label: 'prop.toString()'),
          _CodeBox(text: rendered),
          const SizedBox(height: 10),
          const _MiniSectionHeader(label: 'prop.valueToString()'),
          _CodeBox(text: rawValueToString),
          const SizedBox(height: 10),
          const _MiniSectionHeader(label: 'Per-entry breakdown'),
          _EntryBreakdownList(entries: breakdown),
        ],
      ),
    );
  }
}

class _PropertyHeaderChip extends StatelessWidget {
  const _PropertyHeaderChip({required this.labeledMap});

  final _LabeledShortcutMap labeledMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _kCobaltSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kCobalt.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.keyboard_alt_outlined, size: 20, color: _kCobalt),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(labeledMap.title, style: _kSubHeadingStyle),
                Text(labeledMap.description, style: _kMonoDim),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _kIvory,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _kCobalt, width: 0.8),
            ),
            child: Text(
              '${labeledMap.map.length} bindings',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _kCobalt,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryBreakdownList extends StatelessWidget {
  const _EntryBreakdownList({required this.entries});

  final List<MapEntry<String, String>> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (final MapEntry<String, String> e in entries)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _kIvory,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _kCobalt.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _kCobalt,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    e.key,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: _kIvory,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_right_alt,
                  size: 16,
                  color: _kGraphiteSoft,
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(e.value, style: _kMonoStyle)),
              ],
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 3) Map picker panel (so scene 2 has input)
// ---------------------------------------------------------------------------

class _MapPickerPanel extends StatelessWidget {
  const _MapPickerPanel({
    required this.maps,
    required this.activeIndex,
    required this.onSelect,
  });

  final List<_LabeledShortcutMap> maps;
  final int activeIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return _FramedCard(
      accent: _kCobalt,
      title: 'Choose a sample map',
      subtitle:
          'Swap between hand-authored shortcut tables to see how the renderer '
          'behaves with SingleActivator, CharacterActivator, and LogicalKeySet.',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          for (int i = 0; i < maps.length; i++)
            _PickerChip(
              label: maps[i].title,
              active: i == activeIndex,
              onTap: () => onSelect(i),
            ),
        ],
      ),
    );
  }
}

class _PickerChip extends StatelessWidget {
  const _PickerChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? _kCobalt : _kIvory,
          border: Border.all(
            color: active ? _kCobalt : _kCobalt.withValues(alpha: 0.4),
            width: active ? 1.4 : 1,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: active ? _kIvory : _kCobalt,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4) Style selector panel
// ---------------------------------------------------------------------------

class _StyleSelectorPanel extends StatelessWidget {
  const _StyleSelectorPanel({
    required this.activeStyle,
    required this.onStyleSelected,
  });

  final DiagnosticsTreeStyle activeStyle;
  final ValueChanged<DiagnosticsTreeStyle> onStyleSelected;

  static const List<_StyleDescriptor> _options = <_StyleDescriptor>[
    _StyleDescriptor(
      DiagnosticsTreeStyle.sparse,
      'sparse',
      'Classic tree with indentation.',
    ),
    _StyleDescriptor(
      DiagnosticsTreeStyle.singleLine,
      'singleLine',
      'Collapsed into one line.',
    ),
    _StyleDescriptor(
      DiagnosticsTreeStyle.errorProperty,
      'errorProperty',
      'Name on its own line, then value.',
    ),
    _StyleDescriptor(
      DiagnosticsTreeStyle.whitespace,
      'whitespace',
      'Tree with whitespace indentation only.',
    ),
    _StyleDescriptor(
      DiagnosticsTreeStyle.flat,
      'flat',
      'No indentation at all.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _FramedCard(
      accent: _kCobalt,
      title: 'DiagnosticsTreeStyle switcher',
      subtitle:
          'ShortcutMapProperty embeds cleanly in parent Diagnosticables that '
          'pick a style. Tap to re-render below.',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          for (final _StyleDescriptor d in _options)
            _StyleToggle(
              descriptor: d,
              active: d.style == activeStyle,
              onTap: () => onStyleSelected(d.style),
            ),
        ],
      ),
    );
  }
}

class _StyleToggle extends StatelessWidget {
  const _StyleToggle({
    required this.descriptor,
    required this.active,
    required this.onTap,
  });

  final _StyleDescriptor descriptor;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 210,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: active ? _kCobaltSoft : _kIvory,
          border: Border.all(
            color: active ? _kCobalt : _kCobalt.withValues(alpha: 0.25),
            width: active ? 1.4 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  active
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  size: 16,
                  color: active ? _kCobalt : _kGraphiteSoft,
                ),
                const SizedBox(width: 8),
                Text(
                  descriptor.label,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kGraphite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(descriptor.hint, style: _kMonoDim),
          ],
        ),
      ),
    );
  }
}

class _StyleDescriptor {
  const _StyleDescriptor(this.style, this.label, this.hint);
  final DiagnosticsTreeStyle style;
  final String label;
  final String hint;
}

// ---------------------------------------------------------------------------
// 5) Styled render card — re-renders based on selected style.
// ---------------------------------------------------------------------------

class _StyledRenderCard extends StatelessWidget {
  const _StyledRenderCard({required this.labeledMap, required this.style});

  final _LabeledShortcutMap labeledMap;
  final DiagnosticsTreeStyle style;

  @override
  Widget build(BuildContext context) {
    final _ShortcutHost host = _ShortcutHost(
      shortcuts: labeledMap.map,
      style: style,
      tag: labeledMap.title,
    );
    final String dumped = host.toStringDeep();
    final String singleLine = host.toString();

    return _FramedCard(
      accent: _kCobalt,
      title: 'Live re-rendered dump (style: ${_describeStyle(style)})',
      subtitle:
          'The ShortcutMapProperty embeds into a synthetic Diagnosticable that '
          "uses the selected tree style — its toStringDeep() output is shown below.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _MiniSectionHeader(label: 'host.toStringDeep()'),
          _CodeBox(text: dumped),
          const SizedBox(height: 10),
          const _MiniSectionHeader(label: 'host.toString() (single line)'),
          _CodeBox(text: singleLine),
          const SizedBox(height: 10),
          _StyleFingerprintRow(style: style),
        ],
      ),
    );
  }
}

class _StyleFingerprintRow extends StatelessWidget {
  const _StyleFingerprintRow({required this.style});

  final DiagnosticsTreeStyle style;

  @override
  Widget build(BuildContext context) {
    final _StyleFingerprint fp = _fingerprintFor(style);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _kCobaltSoft.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.insights, size: 16, color: _kCobalt),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(fp.summary, style: _kMonoAccent),
                const SizedBox(height: 2),
                Text(fp.description, style: _kMonoDim),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StyleFingerprint {
  const _StyleFingerprint(this.summary, this.description);
  final String summary;
  final String description;
}

_StyleFingerprint _fingerprintFor(DiagnosticsTreeStyle style) {
  switch (style) {
    case DiagnosticsTreeStyle.sparse:
      return const _StyleFingerprint(
        'sparse — default tree style',
        'Uses | and + connectors, indented children. Common for RenderObject.',
      );
    case DiagnosticsTreeStyle.dense:
      return const _StyleFingerprint(
        'dense — compact tree',
        'Similar to sparse but tighter spacing. Used by Element.',
      );
    case DiagnosticsTreeStyle.offstage:
      return const _StyleFingerprint(
        'offstage — dashed connectors',
        'Indicates offstage / inactive subtrees.',
      );
    case DiagnosticsTreeStyle.transition:
      return const _StyleFingerprint(
        'transition — style bridge',
        'Allows transition between parents/children with different styles.',
      );
    case DiagnosticsTreeStyle.error:
      return const _StyleFingerprint(
        'error — root of an error tree',
        'Used by FlutterError for crash-dump root nodes.',
      );
    case DiagnosticsTreeStyle.whitespace:
      return const _StyleFingerprint(
        'whitespace — whitespace-only indent',
        'No connector characters; indentation conveys hierarchy.',
      );
    case DiagnosticsTreeStyle.flat:
      return const _StyleFingerprint(
        'flat — no indentation',
        'Children render flush to the left; used for stack traces.',
      );
    case DiagnosticsTreeStyle.singleLine:
      return const _StyleFingerprint(
        'singleLine — one line, no children',
        'Everything on a single line; children are suppressed.',
      );
    case DiagnosticsTreeStyle.errorProperty:
      return const _StyleFingerprint(
        'errorProperty — name on its own line',
        'Name on the first line; value and properties follow on the next.',
      );
    case DiagnosticsTreeStyle.shallow:
      return const _StyleFingerprint(
        'shallow — only immediate properties',
        'Does not descend further.',
      );
    case DiagnosticsTreeStyle.truncateChildren:
      return const _StyleFingerprint(
        'truncateChildren — cap child count',
        'Cuts children once tree gets too big.',
      );
    case DiagnosticsTreeStyle.none:
      return const _StyleFingerprint(
        'none — release-mode hidden',
        'Renders nothing; used to skip diagnostics entirely.',
      );
  }
}

String _describeStyle(DiagnosticsTreeStyle style) =>
    style.toString().split('.').last;

// ---------------------------------------------------------------------------
// 6) Before/after comparison
// ---------------------------------------------------------------------------

class _BeforeAfterComparisonCard extends StatelessWidget {
  const _BeforeAfterComparisonCard({
    required this.primary,
    required this.secondary,
    required this.style,
  });

  final _LabeledShortcutMap primary;
  final _LabeledShortcutMap secondary;
  final DiagnosticsTreeStyle style;

  @override
  Widget build(BuildContext context) {
    return _FramedCard(
      accent: _kCobalt,
      title: 'Side-by-side comparison',
      subtitle:
          "Two ShortcutMapProperty instances rendered with the current style, "
          'so structural differences jump out.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool stacked = constraints.maxWidth < 620;
          final Widget left = _ComparisonColumn(
            title: primary.title,
            body: _renderDeep(primary.map, primary.propertyName, style),
            footnote: 'Keys: ${primary.map.length}',
          );
          final Widget right = _ComparisonColumn(
            title: secondary.title,
            body: _renderDeep(secondary.map, secondary.propertyName, style),
            footnote: 'Keys: ${secondary.map.length}',
          );
          if (stacked) {
            return Column(
              children: <Widget>[
                left,
                const SizedBox(height: 12),
                right,
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: left),
              const SizedBox(width: 14),
              Expanded(child: right),
            ],
          );
        },
      ),
    );
  }

  String _renderDeep(
    Map<ShortcutActivator, Intent> map,
    String name,
    DiagnosticsTreeStyle style,
  ) {
    final _ShortcutHost host =
        _ShortcutHost(shortcuts: map, style: style, tag: name);
    return host.toStringDeep();
  }
}

class _ComparisonColumn extends StatelessWidget {
  const _ComparisonColumn({
    required this.title,
    required this.body,
    required this.footnote,
  });

  final String title;
  final String body;
  final String footnote;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kIvory,
        border: Border.all(color: _kCobalt.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: _kSubHeadingStyle),
          const SizedBox(height: 8),
          _CodeBox(text: body, compact: true),
          const SizedBox(height: 8),
          Text(footnote, style: _kMonoDim),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 7) Nested diagnostic tree painter
// ---------------------------------------------------------------------------

class _DiagnosticTreeVisualPanel extends StatelessWidget {
  const _DiagnosticTreeVisualPanel();

  @override
  Widget build(BuildContext context) {
    return _FramedCard(
      accent: _kCobalt,
      title: 'Nested diagnostic tree',
      subtitle:
          'A hand-drawn visualization of the DiagnosticsNode hierarchy: '
          'Shortcuts -> ShortcutMapProperty -> (activator key, intent value) '
          'leaves connected with curvy links.',
      child: SizedBox(
        height: 360,
        child: CustomPaint(
          painter: _DiagnosticTreePainter(),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _DiagnosticTreePainter extends CustomPainter {
  _DiagnosticTreePainter();

  static const List<_TreeLeaf> _leaves = <_TreeLeaf>[
    _TreeLeaf('Ctrl+S', 'SaveIntent'),
    _TreeLeaf("Ctrl+'?'", 'HelpIntent'),
    _TreeLeaf('Meta+Shift+Z', 'RedoIntent'),
    _TreeLeaf('Esc', 'DismissIntent'),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kIvory;
    canvas.drawRect(Offset.zero & size, bg);

    // Subtle grid.
    final Paint gridPaint = Paint()
      ..color = _kBlueprintGrid
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;
    const double step = 20;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Root node (Shortcuts).
    final Offset root = Offset(size.width / 2, 40);
    _drawNode(canvas, root, 'Shortcuts', 'Widget', wide: true);

    // Mid node (ShortcutMapProperty).
    final Offset mid = Offset(size.width / 2, 130);
    _drawNode(
      canvas,
      mid,
      'ShortcutMapProperty',
      'DiagnosticsProperty<Map<…>>',
      wide: true,
      emphasized: true,
    );

    // Connect root -> mid.
    _drawCurvyLink(canvas, root, mid);

    // Leaves.
    final double laneStart = 60;
    final double laneEnd = size.width - 60;
    final double laneStep = (laneEnd - laneStart) / (_leaves.length - 1);
    const double leafY = 270;

    for (int i = 0; i < _leaves.length; i++) {
      final Offset pos = Offset(laneStart + laneStep * i, leafY);
      _drawNode(
        canvas,
        pos,
        _leaves[i].activator,
        _leaves[i].intent,
      );
      _drawCurvyLink(canvas, mid, pos);
    }

    // Tag label in corner.
    final TextPainter tag = TextPainter(
      text: const TextSpan(
        text: 'DiagnosticsNode tree',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.5,
          color: _kCobalt,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tag.paint(canvas, const Offset(14, 10));
  }

  void _drawNode(
    Canvas canvas,
    Offset center,
    String title,
    String subtitle, {
    bool wide = false,
    bool emphasized = false,
  }) {
    final double w = wide ? 210 : 150;
    const double h = 56;
    final Rect rect = Rect.fromCenter(center: center, width: w, height: h);
    final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(10));

    final Paint fill = Paint()
      ..color = emphasized ? _kCobalt : _kIvory;
    final Paint border = Paint()
      ..color = _kCobalt
      ..style = PaintingStyle.stroke
      ..strokeWidth = emphasized ? 1.6 : 1.1;

    canvas.drawRRect(rr, fill);
    canvas.drawRRect(rr, border);

    final Color titleColor = emphasized ? _kIvory : _kGraphite;
    final Color subColor = emphasized
        ? _kIvory.withValues(alpha: 0.85)
        : _kGraphiteSoft;

    final TextPainter titlePainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: titleColor,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: w - 16);

    final TextPainter subPainter = TextPainter(
      text: TextSpan(
        text: subtitle,
        style: TextStyle(
          fontSize: 10.5,
          color: subColor,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: w - 16);

    final double totalH = titlePainter.height + subPainter.height + 4;
    final double topY = center.dy - totalH / 2;
    titlePainter.paint(
      canvas,
      Offset(center.dx - titlePainter.width / 2, topY),
    );
    subPainter.paint(
      canvas,
      Offset(
        center.dx - subPainter.width / 2,
        topY + titlePainter.height + 4,
      ),
    );
  }

  void _drawCurvyLink(Canvas canvas, Offset from, Offset to) {
    final Paint linkPaint = Paint()
      ..color = _kCobalt.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round;
    final double midY = (from.dy + to.dy) / 2;
    final Path path = Path()
      ..moveTo(from.dx, from.dy + 28)
      ..cubicTo(
        from.dx,
        midY,
        to.dx,
        midY,
        to.dx,
        to.dy - 28,
      );
    canvas.drawPath(path, linkPaint);

    // Arrow head.
    final double dx = to.dx - from.dx;
    final double dy = to.dy - from.dy;
    final double angle = math.atan2(dy, dx);
    final Offset tip = Offset(to.dx, to.dy - 28);
    const double arrowLen = 7;
    final Path head = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(
        tip.dx - arrowLen * math.cos(angle - math.pi / 7),
        tip.dy - arrowLen * math.sin(angle - math.pi / 7),
      )
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(
        tip.dx - arrowLen * math.cos(angle + math.pi / 7),
        tip.dy - arrowLen * math.sin(angle + math.pi / 7),
      );
    canvas.drawPath(head, linkPaint);
  }

  @override
  bool shouldRepaint(covariant _DiagnosticTreePainter oldDelegate) => false;
}

class _TreeLeaf {
  const _TreeLeaf(this.activator, this.intent);
  final String activator;
  final String intent;
}

// ---------------------------------------------------------------------------
// 8) "Where you'll see this" panel
// ---------------------------------------------------------------------------

class _WhereYouSeeItPanel extends StatelessWidget {
  const _WhereYouSeeItPanel();

  @override
  Widget build(BuildContext context) {
    const List<_SeeItEntry> entries = <_SeeItEntry>[
      _SeeItEntry(
        icon: Icons.bug_report_outlined,
        title: 'Shortcuts.debugFillProperties',
        detail:
            "The Shortcuts widget adds ShortcutMapProperty('shortcuts', …) "
            'to its DiagnosticPropertiesBuilder.',
      ),
      _SeeItEntry(
        icon: Icons.extension_outlined,
        title: 'Flutter DevTools inspector',
        detail:
            'The inspector consumes DiagnosticsNode trees so the shortcuts '
            'map shows up directly under the widget row.',
      ),
      _SeeItEntry(
        icon: Icons.error_outline,
        title: 'FlutterError diagnostics',
        detail:
            'Framework assertions sometimes embed a ShortcutMapProperty when '
            'describing keyboard binding conflicts.',
      ),
      _SeeItEntry(
        icon: Icons.terminal,
        title: 'debugPrint / toStringDeep',
        detail:
            'Calling toStringDeep() on a parent Diagnosticable surfaces the '
            'ShortcutMapProperty inline.',
      ),
    ];
    return _FramedCard(
      accent: _kCobalt,
      title: "Where you'll see it",
      subtitle:
          'The same property is reused across diagnostic surfaces — from '
          'debugPrint output to the Flutter inspector.',
      child: Column(
        children: <Widget>[
          for (final _SeeItEntry e in entries)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kIvory,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _kCobalt.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _kCobaltSoft,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(e.icon, size: 18, color: _kCobalt),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(e.title, style: _kSubHeadingStyle),
                        const SizedBox(height: 4),
                        Text(e.detail, style: _kBodyStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SeeItEntry {
  const _SeeItEntry({
    required this.icon,
    required this.title,
    required this.detail,
  });
  final IconData icon;
  final String title;
  final String detail;
}

// ---------------------------------------------------------------------------
// 9) Field-reference table
// ---------------------------------------------------------------------------

class _FieldReferenceTable extends StatelessWidget {
  const _FieldReferenceTable();

  @override
  Widget build(BuildContext context) {
    const List<_FieldRow> rows = <_FieldRow>[
      _FieldRow(
        field: 'name',
        type: 'String (required)',
        note:
            'Property name rendered as prefix, e.g. "shortcuts: …". Forwarded '
            'to DiagnosticsProperty.',
      ),
      _FieldRow(
        field: 'value',
        type: 'Map<ShortcutActivator, Intent>',
        note:
            'The actual shortcuts map. valueToString() walks the keys in '
            'insertion order.',
      ),
      _FieldRow(
        field: 'showName',
        type: 'bool = true',
        note:
            'When false, the "name:" prefix is hidden — handy for inline '
            'embeds.',
      ),
      _FieldRow(
        field: 'defaultValue',
        type: 'Object = kNoDefaultValue',
        note:
            'Suppresses output when the map equals this default — useful for '
            'widgets with a canonical empty map.',
      ),
      _FieldRow(
        field: 'level',
        type: 'DiagnosticLevel = info',
        note:
            'Controls filtering in diagnostic dumps (hidden, fine, info, '
            'warning, hint, summary, error, off).',
      ),
      _FieldRow(
        field: 'description',
        type: 'String?',
        note: 'Optional human summary; replaces the default value formatting.',
      ),
      _FieldRow(
        field: 'valueToString',
        type: 'override',
        note:
            'Builds "{{keys}: Intent, …}" — keys via '
            'ShortcutActivator.debugDescribeKeys().',
      ),
      _FieldRow(
        field: 'style',
        type: 'inherited (singleLine default)',
        note:
            'Not exposed on ShortcutMapProperty\'s constructor — inherited '
            "from the parent Diagnosticable's tree style.",
      ),
    ];

    return _FramedCard(
      accent: _kCobalt,
      title: 'Field reference',
      subtitle:
          'Constructor parameters and the valueToString override, along with '
          'one-line notes.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _FieldHeaderRow(),
          for (int i = 0; i < rows.length; i++)
            _FieldBodyRow(row: rows[i], zebra: i.isOdd),
        ],
      ),
    );
  }
}

class _FieldHeaderRow extends StatelessWidget {
  const _FieldHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        color: _kCobalt,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'FIELD',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _kIvory,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'TYPE / DEFAULT',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _kIvory,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              'NOTE',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _kIvory,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldBodyRow extends StatelessWidget {
  const _FieldBodyRow({required this.row, required this.zebra});
  final _FieldRow row;
  final bool zebra;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: zebra ? _kCobaltSoft.withValues(alpha: 0.45) : _kIvory,
        border: Border(
          left: BorderSide(color: _kCobalt.withValues(alpha: 0.4)),
          right: BorderSide(color: _kCobalt.withValues(alpha: 0.4)),
          bottom: BorderSide(color: _kCobalt.withValues(alpha: 0.25)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(row.field, style: _kMonoAccent),
          ),
          Expanded(
            flex: 3,
            child: Text(row.type, style: _kMonoStyle),
          ),
          Expanded(
            flex: 6,
            child: Text(row.note, style: _kBodyStyle),
          ),
        ],
      ),
    );
  }
}

class _FieldRow {
  const _FieldRow({
    required this.field,
    required this.type,
    required this.note,
  });
  final String field;
  final String type;
  final String note;
}

// ---------------------------------------------------------------------------
// 10) Harness footer
// ---------------------------------------------------------------------------

class _HarnessFooter extends StatelessWidget {
  const _HarnessFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kGraphite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.keyboard_command_key_outlined,
              color: _kIvory, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'd4rt AST harness demo',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kIvory,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'ShortcutMapProperty — palette ivory/cobalt/graphite. '
                  'Rendered via the tom_d4rt_flutterm_app test harness to '
                  'verify Flutter 3.41.6 behavior.',
                  style: TextStyle(
                    color: _kIvory,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared card chrome
// ---------------------------------------------------------------------------

class _FramedCard extends StatelessWidget {
  const _FramedCard({
    required this.child,
    required this.accent,
    this.title,
    this.subtitle,
  });

  final Widget child;
  final Color accent;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kIvory,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                _kInnerPadding,
                _kInnerPadding,
                _kInnerPadding,
                6,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 4,
                    height: 22,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(title!, style: _kHeadingStyle),
                        if (subtitle != null) ...<Widget>[
                          const SizedBox(height: 4),
                          Text(subtitle!, style: _kBodyStyle),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              _kInnerPadding,
              title == null ? _kInnerPadding : 6,
              _kInnerPadding,
              _kInnerPadding,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _MiniSectionHeader extends StatelessWidget {
  const _MiniSectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 2),
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: _kCobalt,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(label, style: _kLabelStyle),
        ],
      ),
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox({required this.text, this.compact = false});

  final String text;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 10 : 12),
      decoration: BoxDecoration(
        color: _kGraphite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: compact ? 11.2 : 12,
          height: 1.38,
          color: _kIvory,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Data: sample maps
// ---------------------------------------------------------------------------

class _LabeledShortcutMap {
  const _LabeledShortcutMap({
    required this.title,
    required this.propertyName,
    required this.description,
    required this.map,
  });

  final String title;
  final String propertyName;
  final String description;
  final Map<ShortcutActivator, Intent> map;
}

List<_LabeledShortcutMap> _buildSampleMaps() {
  return <_LabeledShortcutMap>[
    _LabeledShortcutMap(
      title: 'Editor essentials',
      propertyName: 'shortcuts',
      description: 'Save / Undo / Redo / Dismiss — mixed activator types.',
      map: <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.keyS, control: true):
            const _SaveIntent(),
        const SingleActivator(LogicalKeyboardKey.keyZ, control: true):
            const _UndoIntent(),
        const SingleActivator(
          LogicalKeyboardKey.keyZ,
          control: true,
          shift: true,
        ): const _RedoIntent(),
        const SingleActivator(LogicalKeyboardKey.escape):
            const DismissIntent(),
      },
    ),
    _LabeledShortcutMap(
      title: 'Help & navigation',
      propertyName: 'helpShortcuts',
      description:
          'CharacterActivator + LogicalKeySet alongside SingleActivator — '
          'shows every activator path through valueToString().',
      map: <ShortcutActivator, Intent>{
        const CharacterActivator('?'): const _HelpIntent(),
        LogicalKeySet(
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.keyF,
        ): const _FindIntent(),
        const SingleActivator(LogicalKeyboardKey.f1): const _HelpIntent(),
      },
    ),
    _LabeledShortcutMap(
      title: 'Mac-flavor palette',
      propertyName: 'commandShortcuts',
      description:
          'Meta-based bindings that typical macOS users expect — '
          'illustrates modifier-heavy SingleActivator output.',
      map: <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.keyK, meta: true):
            const _OpenPaletteIntent(),
        const SingleActivator(LogicalKeyboardKey.keyP, meta: true):
            const _OpenPaletteIntent(),
        const SingleActivator(LogicalKeyboardKey.comma, meta: true):
            const _OpenSettingsIntent(),
        const SingleActivator(
          LogicalKeyboardKey.keyT,
          meta: true,
          shift: true,
        ): const _ReopenTabIntent(),
      },
    ),
  ];
}

List<MapEntry<String, String>> _breakdownEntries(
  Map<ShortcutActivator, Intent> map,
) {
  final List<MapEntry<String, String>> out = <MapEntry<String, String>>[];
  for (final MapEntry<ShortcutActivator, Intent> entry in map.entries) {
    out.add(
      MapEntry<String, String>(
        '{${entry.key.debugDescribeKeys()}}',
        entry.value.toString(),
      ),
    );
  }
  return out;
}

// ---------------------------------------------------------------------------
// Diagnosticable host: wraps a ShortcutMapProperty with selectable tree style.
// ---------------------------------------------------------------------------

class _ShortcutHost with DiagnosticableTreeMixin {
  _ShortcutHost({
    required this.shortcuts,
    required this.style,
    required this.tag,
  });

  final Map<ShortcutActivator, Intent> shortcuts;
  final DiagnosticsTreeStyle style;
  final String tag;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<String>('tag', tag));
    properties.add(ShortcutMapProperty('shortcuts', shortcuts));
    properties.add(
      DiagnosticsProperty<int>('size', shortcuts.length, showName: true),
    );
  }

  @override
  DiagnosticsNode toDiagnosticsNode({
    String? name,
    DiagnosticsTreeStyle? style,
  }) {
    return super.toDiagnosticsNode(
      name: name ?? 'ShortcutHost',
      style: style ?? this.style,
    );
  }

  @override
  String toStringShort() => 'ShortcutHost#${tag.hashCode.toRadixString(16)}';
}

// ---------------------------------------------------------------------------
// Intent subclasses used in the samples.
// ---------------------------------------------------------------------------

class _SaveIntent extends Intent {
  const _SaveIntent();
  @override
  String toStringShort() => 'SaveIntent';
}

class _UndoIntent extends Intent {
  const _UndoIntent();
  @override
  String toStringShort() => 'UndoIntent';
}

class _RedoIntent extends Intent {
  const _RedoIntent();
  @override
  String toStringShort() => 'RedoIntent';
}

class _HelpIntent extends Intent {
  const _HelpIntent();
  @override
  String toStringShort() => 'HelpIntent';
}

class _FindIntent extends Intent {
  const _FindIntent();
  @override
  String toStringShort() => 'FindIntent';
}

class _OpenPaletteIntent extends Intent {
  const _OpenPaletteIntent();
  @override
  String toStringShort() => 'OpenPaletteIntent';
}

class _OpenSettingsIntent extends Intent {
  const _OpenSettingsIntent();
  @override
  String toStringShort() => 'OpenSettingsIntent';
}

class _ReopenTabIntent extends Intent {
  const _ReopenTabIntent();
  @override
  String toStringShort() => 'ReopenTabIntent';
}


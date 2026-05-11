// ignore_for_file: avoid_print, deprecated_member_use, unused_local_variable, unused_element, sort_child_properties_last
// D4rt deep visual demo — IntProperty (foundation)
//
// This file presents `IntProperty` as a diagnostics inspector dashboard.
// Each example renders not only the formatted toString output but also the
// surrounding configuration: unit, level, defaultValue, ifNull, showName,
// style.  The intent is that a developer reading the rendered widget tree
// can connect the formatted text in a Flutter inspector back to the exact
// constructor arguments that produced it.
//
// Eleven numbered sections cover dossier, anatomy, gallery, comparison,
// level filtering, embedded diagnosticable, JSON projection, recipes,
// comparison table, glossary, and a final composed tree.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=' * 64);
  print('IntProperty deep visual demo');
  print('=' * 64);

  // ==========================================================================
  // SECTION 1 — DOSSIER
  // ==========================================================================
  //
  // IntProperty is a `DiagnosticsProperty<int>` specialized for integer
  // values.  It exists for three reasons:
  //   1. It formats integers in a stable, locale-free way for tooling.
  //   2. It carries a semantic unit string (`px`, `ms`, `%`, `dB`, ...)
  //      so the inspector can render "width: 320px" instead of "width: 320".
  //   3. It participates in level-based filtering — a property whose value
  //      matches its `defaultValue` is automatically hidden by demoting its
  //      `level` to `DiagnosticLevel.fine`.
  //
  // IntProperty is widely used in `Widget.debugFillProperties`, where it
  // provides a uniform vocabulary for diagnosing integer-valued fields like
  // `maxLines`, `flex`, `itemCount`, `elevation`, `tabIndex`.

  final dossierLines = <String>[
    'IntProperty extends DiagnosticsProperty<int>',
    'Specialised formatter for integer diagnostic fields',
    'Carries a semantic unit string for inspector display',
    'Auto-masks values that equal `defaultValue`',
    'Supports null with an optional `ifNull` placeholder',
    'Honours `DiagnosticLevel` for filterable inspector trees',
    'Used heavily inside Widget.debugFillProperties overrides',
    'JSON-serialisable via `toJsonMap` for IDE bridges',
  ];

  // ==========================================================================
  // SECTION 2 — ANATOMY
  // ==========================================================================

  final constructorParams = <Map<String, String>>[
    {
      'param': 'name',
      'type': 'String?',
      'role': 'Field name shown before the value (or hidden via showName).',
    },
    {
      'param': 'value',
      'type': 'int?',
      'role': 'The integer value being described; may be null.',
    },
    {
      'param': 'ifNull',
      'type': 'String?',
      'role': 'Placeholder rendered when value is null (e.g. "auto").',
    },
    {
      'param': 'showName',
      'type': 'bool',
      'role': 'When false, only the value (and unit) is rendered.',
    },
    {
      'param': 'unit',
      'type': 'String?',
      'role': 'Suffix appended after the value (e.g. "px", "ms", "%").',
    },
    {
      'param': 'defaultValue',
      'type': 'Object',
      'role': 'When value equals this, level becomes fine (hidden).',
    },
    {
      'param': 'tooltip',
      'type': 'String?',
      'role': 'Long-form description shown on hover in inspectors.',
    },
    {
      'param': 'level',
      'type': 'DiagnosticLevel',
      'role': 'Severity / visibility hint, demoted when default matches.',
    },
    {
      'param': 'style',
      'type': 'DiagnosticsTreeStyle?',
      'role': 'Tree rendering style (rare for leaf properties).',
    },
    {
      'param': 'showSeparator',
      'type': 'bool',
      'role': 'Whether the ":" separator is drawn between name and value.',
    },
  ];

  final inheritedGetters = <Map<String, String>>[
    {'getter': 'name', 'returns': 'Same as constructor arg.'},
    {'getter': 'value', 'returns': 'The held int (or null).'},
    {'getter': 'level', 'returns': 'Effective level after defaultValue check.'},
    {'getter': 'showName', 'returns': 'Whether the name prefix renders.'},
    {'getter': 'showSeparator', 'returns': 'Whether ":" prefix renders.'},
    {'getter': 'defaultValue', 'returns': 'Configured masking sentinel.'},
    {'getter': 'tooltip', 'returns': 'Inspector hover text.'},
    {'getter': 'unit', 'returns': 'The semantic unit suffix.'},
    {'getter': 'ifNull', 'returns': 'Null placeholder string.'},
    {'getter': 'toDescription()', 'returns': 'Formatted value-with-unit text.'},
    {'getter': 'toString()', 'returns': 'name + separator + description.'},
    {'getter': 'toJsonMap', 'returns': 'Map serialisation for IDE bridges.'},
  ];

  // ==========================================================================
  // SECTION 3 — LIVE GALLERY (12 IntProperty instances)
  // ==========================================================================

  final pCount = IntProperty('count', 42);
  final pZero = IntProperty('zero', 0);
  final pNegative = IntProperty('temperature', -12, unit: '°C');
  final pLarge = IntProperty('bytesWritten', 999999999, unit: 'B');
  final pPixels = IntProperty('width', 320, unit: 'px');
  final pPercent = IntProperty('progress', 75, unit: '%');
  final pMillis = IntProperty('duration', 250, unit: 'ms');
  final pDecibel = IntProperty('volume', -6, unit: 'dB');
  final pNull = IntProperty('size', null, ifNull: 'auto');
  final pDefaultMatch = IntProperty('flex', 1, defaultValue: 1);
  final pDefaultDiffer = IntProperty('flex', 3, defaultValue: 1);
  final pHidden = IntProperty(
    'internalIndex',
    7,
    level: DiagnosticLevel.hidden,
  );

  final galleryEntries = <_PropEntry>[
    _PropEntry(label: 'count (no unit)', property: pCount),
    _PropEntry(label: 'zero (no unit, no default)', property: pZero),
    _PropEntry(label: 'temperature (°C, negative)', property: pNegative),
    _PropEntry(label: 'bytesWritten (B, large)', property: pLarge),
    _PropEntry(label: 'width (px)', property: pPixels),
    _PropEntry(label: 'progress (%)', property: pPercent),
    _PropEntry(label: 'duration (ms)', property: pMillis),
    _PropEntry(label: 'volume (dB, negative)', property: pDecibel),
    _PropEntry(label: 'size (null with ifNull)', property: pNull),
    _PropEntry(label: 'flex (matches default → demoted)', property: pDefaultMatch),
    _PropEntry(label: 'flex (differs from default)', property: pDefaultDiffer),
    _PropEntry(label: 'internalIndex (hidden level)', property: pHidden),
  ];

  // ==========================================================================
  // SECTION 4 — COMPARISON WITH NEIGHBOURING PROPERTY TYPES
  // ==========================================================================

  final cmpInt = IntProperty('size', 42, unit: 'px');
  final cmpDouble = DoubleProperty('size', 42.5, unit: 'px');
  final cmpPercent = PercentProperty('ratio', 0.42);
  final cmpString = StringProperty('label', 'forty-two');
  final cmpFlag = FlagProperty('visible', value: true, ifTrue: 'visible');

  final comparisonRows = <Map<String, String>>[
    {
      'kind': 'IntProperty',
      'value': cmpInt.value.toString(),
      'rendered': cmpInt.toString(),
    },
    {
      'kind': 'DoubleProperty',
      'value': cmpDouble.value.toString(),
      'rendered': cmpDouble.toString(),
    },
    {
      'kind': 'PercentProperty',
      'value': cmpPercent.value.toString(),
      'rendered': cmpPercent.toString(),
    },
    {
      'kind': 'StringProperty',
      'value': cmpString.value.toString(),
      'rendered': cmpString.toString(),
    },
    {
      'kind': 'FlagProperty',
      'value': cmpFlag.value.toString(),
      'rendered': cmpFlag.toString(),
    },
  ];

  // ==========================================================================
  // SECTION 5 — LEVEL FILTERING
  // ==========================================================================

  final levelInfo = IntProperty(
    'visibleField',
    10,
    level: DiagnosticLevel.info,
  );
  final levelDebug = IntProperty(
    'debugField',
    20,
    level: DiagnosticLevel.debug,
  );
  final levelFine = IntProperty('fineField', 30, level: DiagnosticLevel.fine);
  final levelHidden = IntProperty(
    'hiddenField',
    40,
    level: DiagnosticLevel.hidden,
  );
  final levelWarning = IntProperty(
    'warningField',
    50,
    level: DiagnosticLevel.warning,
  );
  final levelError = IntProperty(
    'errorField',
    60,
    level: DiagnosticLevel.error,
  );
  final levelSummary = IntProperty(
    'summaryField',
    70,
    level: DiagnosticLevel.summary,
  );

  final levelGroups = <_LevelGroup>[
    _LevelGroup(
      name: 'info',
      tint: const Color(0xFFE3F2FD),
      properties: <IntProperty>[levelInfo, pCount, pPixels],
    ),
    _LevelGroup(
      name: 'debug',
      tint: const Color(0xFFF3E5F5),
      properties: <IntProperty>[levelDebug, pMillis],
    ),
    _LevelGroup(
      name: 'fine',
      tint: const Color(0xFFF1F8E9),
      properties: <IntProperty>[levelFine, pDefaultMatch],
    ),
    _LevelGroup(
      name: 'hidden',
      tint: const Color(0xFFFAFAFA),
      properties: <IntProperty>[levelHidden, pHidden],
    ),
    _LevelGroup(
      name: 'warning',
      tint: const Color(0xFFFFF8E1),
      properties: <IntProperty>[levelWarning],
    ),
    _LevelGroup(
      name: 'error',
      tint: const Color(0xFFFFEBEE),
      properties: <IntProperty>[levelError],
    ),
    _LevelGroup(
      name: 'summary',
      tint: const Color(0xFFE0F7FA),
      properties: <IntProperty>[levelSummary],
    ),
  ];

  // ==========================================================================
  // SECTION 6 — DIAGNOSTICABLE EMBEDDING
  // ==========================================================================
  //
  // Build a small description manually so we can show how IntProperty would
  // appear inside a Diagnosticable's `debugFillProperties`.

  final fakeWidgetProps = <IntProperty>[
    IntProperty('maxLines', 3, defaultValue: 1),
    IntProperty('minLines', 1, defaultValue: 1),
    IntProperty('flex', 2, defaultValue: 1),
    IntProperty('elevation', 4, unit: 'dp', defaultValue: 0),
    IntProperty('itemCount', 24),
    IntProperty('tabIndex', null, ifNull: 'auto'),
  ];

  final treeLines = <String>[
    'FakeListTile',
    ' ├── ${fakeWidgetProps[0]}',
    ' ├── ${fakeWidgetProps[1]}',
    ' ├── ${fakeWidgetProps[2]}',
    ' ├── ${fakeWidgetProps[3]}',
    ' ├── ${fakeWidgetProps[4]}',
    ' └── ${fakeWidgetProps[5]}',
  ];

  // ==========================================================================
  // SECTION 7 — toJsonMap VIEWER
  // ==========================================================================

  final jsonDelegate = const DiagnosticsSerializationDelegate();
  final jsonEntries = <_JsonEntry>[];
  for (final entry in galleryEntries) {
    final Map<String, Object?> map = entry.property.toJsonMap(jsonDelegate);
    final keys = map.keys.toList();
    final preview = StringBuffer('{');
    for (var i = 0; i < keys.length && i < 6; i++) {
      if (i > 0) preview.write(', ');
      preview.write('${keys[i]}: ${map[keys[i]]}');
    }
    if (keys.length > 6) preview.write(', …');
    preview.write('}');
    jsonEntries.add(
      _JsonEntry(label: entry.label, jsonPreview: preview.toString()),
    );
  }

  // ==========================================================================
  // SECTION 8 — RECIPE CARDS
  // ==========================================================================

  final recipes = <_Recipe>[
    _Recipe(
      title: 'Render a pixel-valued field',
      snippet: "IntProperty('width', 320, unit: 'px')",
      explanation: 'Adds the "px" suffix to the formatted output.',
    ),
    _Recipe(
      title: 'Hide values that match their default',
      snippet: "IntProperty('flex', 1, defaultValue: 1)",
      explanation: 'Level is demoted to fine — value is filtered out by inspector.',
    ),
    _Recipe(
      title: 'Show a friendly placeholder for null',
      snippet: "IntProperty('size', null, ifNull: 'auto')",
      explanation: 'Renders "size: auto" instead of "size: null".',
    ),
    _Recipe(
      title: 'Suppress the field name',
      snippet: "IntProperty(null, 7, showName: false)",
      explanation: 'Renders only "7" — useful inside list-like nodes.',
    ),
    _Recipe(
      title: 'Express a percentage in integer points',
      snippet: "IntProperty('progress', 75, unit: '%')",
      explanation: 'Distinct from PercentProperty which expects 0..1 doubles.',
    ),
    _Recipe(
      title: 'Annotate with a tooltip',
      snippet: "IntProperty('zIndex', 4, tooltip: 'render order')",
      explanation: 'Tooltip is surfaced by the inspector on hover.',
    ),
    _Recipe(
      title: 'Force-hide a debug-only field',
      snippet: "IntProperty('internalId', 7, level: DiagnosticLevel.hidden)",
      explanation: 'Always skipped by inspectors at info/summary level.',
    ),
    _Recipe(
      title: 'Promote a critical value',
      snippet: "IntProperty('overflowCount', 999, level: DiagnosticLevel.error)",
      explanation: 'Inspector renders it with the error palette.',
    ),
  ];

  // ==========================================================================
  // SECTION 9 — COMPARISON TABLE
  // ==========================================================================

  final comparisonTable = <Map<String, String>>[
    {
      'feature': 'value type',
      'IntProperty': 'int?',
      'DoubleProperty': 'double?',
      'PercentProperty': 'double? (0..1)',
      'StringProperty': 'String?',
    },
    {
      'feature': 'unit support',
      'IntProperty': 'yes',
      'DoubleProperty': 'yes',
      'PercentProperty': 'auto "%"',
      'StringProperty': 'no',
    },
    {
      'feature': 'auto-mask defaultValue',
      'IntProperty': 'yes',
      'DoubleProperty': 'yes',
      'PercentProperty': 'yes',
      'StringProperty': 'yes',
    },
    {
      'feature': 'ifNull placeholder',
      'IntProperty': 'yes',
      'DoubleProperty': 'yes',
      'PercentProperty': 'yes',
      'StringProperty': 'yes',
    },
    {
      'feature': 'quote string values',
      'IntProperty': 'n/a',
      'DoubleProperty': 'n/a',
      'PercentProperty': 'n/a',
      'StringProperty': 'optional',
    },
    {
      'feature': 'level demotion when default matches',
      'IntProperty': 'yes',
      'DoubleProperty': 'yes',
      'PercentProperty': 'yes',
      'StringProperty': 'yes',
    },
  ];

  // ==========================================================================
  // SECTION 10 — GLOSSARY
  // ==========================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'DiagnosticsProperty',
      'meaning':
          'Generic base class linking a name to a value with formatting metadata.',
    },
    {
      'term': 'DiagnosticLevel',
      'meaning':
          'Enum (hidden, fine, debug, info, warning, hint, summary, error) '
          'controlling whether/how a property is rendered.',
    },
    {
      'term': 'defaultValue',
      'meaning':
          'Sentinel that, when matched by value, demotes the property level '
          'to fine — effectively hiding it from default inspector views.',
    },
    {
      'term': 'ifNull',
      'meaning':
          'String shown in place of "null" when the underlying value is null.',
    },
    {
      'term': 'showName',
      'meaning': 'Whether the field name prefix renders before the value.',
    },
    {
      'term': 'showSeparator',
      'meaning': 'Whether the ":" separator renders between name and value.',
    },
    {
      'term': 'unit',
      'meaning':
          'Semantic suffix appended after the formatted value (e.g. "px", "ms").',
    },
    {
      'term': 'tooltip',
      'meaning':
          'Long-form description surfaced by inspectors on hover; never part of toString.',
    },
    {
      'term': 'toJsonMap',
      'meaning':
          'Serialises the property into a map consumed by IDE bridges and '
          'remote tooling such as the Flutter DevTools widget inspector.',
    },
    {
      'term': 'DiagnosticsTreeStyle',
      'meaning':
          'Enum hint guiding how a tree of nodes should be rendered '
          '(sparse, dense, transition, error, whitespace, flat, singleLine).',
    },
    {
      'term': 'Diagnosticable',
      'meaning':
          'Mixin contributing a `debugDescribeChildren` and `debugFillProperties` '
          'API for surfacing structure to the inspector.',
    },
  ];

  // ==========================================================================
  // FINAL COMPOSED TREE
  // ==========================================================================

  print('Sections prepared: 11');
  print('Gallery entries: ${galleryEntries.length}');
  print('Recipes: ${recipes.length}');
  print('Glossary entries: ${glossary.length}');

  return Scaffold(
    backgroundColor: const Color(0xFFF5F7FA),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTitle(),
            const SizedBox(height: 18),

            _section(
              number: 1,
              title: 'Dossier — what IntProperty exists for',
              intro:
                  'IntProperty is the diagnostics formatter for integer fields. '
                  'It carries a unit, an optional null placeholder, and a '
                  'defaultValue used to auto-hide unchanged values.',
              child: _buildDossier(dossierLines),
            ),

            _section(
              number: 2,
              title: 'Anatomy — constructor parameters and inherited getters',
              intro:
                  'IntProperty inherits from DiagnosticsProperty<int>. '
                  'These are the constructor arguments and the getter surface '
                  'callers most often use.',
              child: _buildAnatomy(constructorParams, inheritedGetters),
            ),

            _section(
              number: 3,
              title: 'Live gallery — twelve IntProperty instances',
              intro:
                  'Each card displays the formatted toString output, the raw '
                  'value, and the constructor configuration as chips.',
              child: _buildGallery(galleryEntries),
            ),

            _section(
              number: 4,
              title: 'Comparison with neighbouring property types',
              intro:
                  'IntProperty side-by-side with DoubleProperty, PercentProperty, '
                  'StringProperty, and FlagProperty for the same conceptual value.',
              child: _buildComparison(comparisonRows),
            ),

            _section(
              number: 5,
              title: 'Level filtering — DiagnosticLevel grouping',
              intro:
                  'Properties grouped by their effective level. Inspector '
                  'filtering decides which groups are rendered.',
              child: _buildLevelGroups(levelGroups),
            ),

            _section(
              number: 6,
              title: 'Diagnosticable embedding — tree-shaped output',
              intro:
                  'IntProperty values rendered as if produced by '
                  'Widget.debugFillProperties.',
              child: _buildTree(treeLines),
            ),

            _section(
              number: 7,
              title: 'toJsonMap viewer — IDE bridge projection',
              intro:
                  'Each IntProperty serialised to its JSON map, which DevTools '
                  'and other inspectors consume over the wire.',
              child: _buildJson(jsonEntries),
            ),

            _section(
              number: 8,
              title: 'Recipe cards — common usage patterns',
              intro:
                  'Eight ready-to-copy patterns covering units, defaults, '
                  'null handling, tooltips, and level overrides.',
              child: _buildRecipes(recipes),
            ),

            _section(
              number: 9,
              title: 'Comparison table — property class capabilities',
              intro:
                  'Feature matrix across IntProperty, DoubleProperty, '
                  'PercentProperty, and StringProperty.',
              child: _buildComparisonTable(comparisonTable),
            ),

            _section(
              number: 10,
              title: 'Glossary — diagnostics vocabulary',
              intro: 'Eleven terms that the rest of the demo relies on.',
              child: _buildGlossary(glossary),
            ),

            _section(
              number: 11,
              title: 'Final composed view',
              intro:
                  'A condensed inspector-style panel summarising the '
                  'demonstration.',
              child: _buildFinal(galleryEntries, comparisonRows),
            ),

            const SizedBox(height: 24),
            _buildFooter(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Internal helper widgets and small data classes
// ============================================================================

class _PropEntry {
  final String label;
  final IntProperty property;
  const _PropEntry({required this.label, required this.property});
}

class _LevelGroup {
  final String name;
  final Color tint;
  final List<IntProperty> properties;
  const _LevelGroup({
    required this.name,
    required this.tint,
    required this.properties,
  });
}

class _JsonEntry {
  final String label;
  final String jsonPreview;
  const _JsonEntry({required this.label, required this.jsonPreview});
}

class _Recipe {
  final String title;
  final String snippet;
  final String explanation;
  const _Recipe({
    required this.title,
    required this.snippet,
    required this.explanation,
  });
}

Widget _buildTitle() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1A237E), Color(0xFF3949AB)],
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'IntProperty — diagnostics inspector dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'A hand-crafted deep visual demo for the d4rt analyzer-free corpus.',
          style: TextStyle(
            color: Color(0xFFC5CAE9),
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _section({
  required int number,
  required String title,
  required String intro,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'SECTION $number',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 10),
          child: Text(
            intro,
            style: const TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: Color(0xFF455A64),
            ),
          ),
        ),
        child,
      ],
    ),
  );
}

Widget _buildDossier(List<String> lines) {
  return Card(
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 6, right: 8),
                    child: Icon(
                      Icons.fiber_manual_record,
                      size: 8,
                      color: Color(0xFF3949AB),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      line,
                      style: const TextStyle(fontSize: 13.5),
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

Widget _buildAnatomy(
  List<Map<String, String>> constructorParams,
  List<Map<String, String>> inheritedGetters,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _miniHeader('Constructor parameters'),
      Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const _AnatomyHeaderRow(),
              const Divider(height: 12),
              for (final row in constructorParams)
                _AnatomyRow(
                  param: row['param'] ?? '',
                  type: row['type'] ?? '',
                  role: row['role'] ?? '',
                ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      _miniHeader('Getter surface'),
      Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              for (final row in inheritedGetters)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 130,
                        child: Text(
                          row['getter'] ?? '',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.5,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          row['returns'] ?? '',
                          style: const TextStyle(fontSize: 12.5),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _AnatomyHeaderRow extends StatelessWidget {
  const _AnatomyHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        SizedBox(
          width: 110,
          child: Text(
            'param',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            'type',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            'role',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  final String param;
  final String type;
  final String role;
  const _AnatomyRow({
    required this.param,
    required this.type,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              param,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Color(0xFF1A237E),
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Color(0xFF455A64),
              ),
            ),
          ),
          Expanded(
            child: Text(role, style: const TextStyle(fontSize: 12.5)),
          ),
        ],
      ),
    );
  }
}

Widget _buildGallery(List<_PropEntry> entries) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[for (final entry in entries) _InspectorCard(entry: entry)],
  );
}

class _InspectorCard extends StatelessWidget {
  final _PropEntry entry;
  const _InspectorCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final p = entry.property;
    final chips = <Widget>[
      _kvChip('value', '${p.value}'),
      _kvChip('unit', p.unit ?? '—'),
      _kvChip('level', p.level.name),
      _kvChip('showName', '${p.showName}'),
      _kvChip('showSeparator', '${p.showSeparator}'),
      _kvChip('ifNull', p.ifNull ?? '—'),
      _kvChip(
        'defaultValue',
        p.defaultValue == kNoDefaultValue ? '—' : '${p.defaultValue}',
      ),
      _kvChip('tooltip', p.tooltip ?? '—'),
    ];
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              entry.label,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF1F8),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                p.toString(),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(spacing: 6, runSpacing: 6, children: chips),
          ],
        ),
      ),
    );
  }
}

Widget _kvChip(String key, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFC5CAE9)),
    ),
    child: Text(
      '$key: $value',
      style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
    ),
  );
}

Widget _buildComparison(List<Map<String, String>> rows) {
  return Card(
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    row['kind'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      'value:   ${row['value']}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF1F8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      row['rendered'] ?? '',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Divider(height: 6),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildLevelGroups(List<_LevelGroup> groups) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (final g in groups)
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: g.tint,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFB0BEC5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'DiagnosticLevel.${g.name}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF263238),
                ),
              ),
              const SizedBox(height: 4),
              for (final p in g.properties)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '• ${p.toString()}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                    ),
                  ),
                ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildTree(List<String> lines) {
  return Card(
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final l in lines)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              child: Text(
                l,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildJson(List<_JsonEntry> entries) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (final e in entries)
        Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  e.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFFFE082)),
                  ),
                  child: Text(
                    e.jsonPreview,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

Widget _buildRecipes(List<_Recipe> recipes) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (final r in recipes)
        Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  r.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF1F8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    r.snippet,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  r.explanation,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

Widget _buildComparisonTable(List<Map<String, String>> rows) {
  const cols = <String>[
    'feature',
    'IntProperty',
    'DoubleProperty',
    'PercentProperty',
    'StringProperty',
  ];
  return Card(
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              for (final c in cols)
                Expanded(
                  child: Text(
                    c,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                ),
            ],
          ),
          const Divider(height: 10),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: <Widget>[
                  for (final c in cols)
                    Expanded(
                      child: Text(
                        row[c] ?? '',
                        style: const TextStyle(fontSize: 11.5),
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

Widget _buildGlossary(List<Map<String, String>> entries) {
  return Card(
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final e in entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    e['term'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    e['meaning'] ?? '',
                    style: const TextStyle(fontSize: 12.5),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildFinal(
  List<_PropEntry> gallery,
  List<Map<String, String>> comparisonRows,
) {
  return Card(
    elevation: 2,
    color: const Color(0xFFE8EAF6),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Inspector summary',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Color(0xFF1A237E),
            ),
          ),
          const SizedBox(height: 8),
          Text('Gallery entries inspected: ${gallery.length}'),
          Text('Comparison rows: ${comparisonRows.length}'),
          const SizedBox(height: 6),
          const Text(
            'Key takeaway: IntProperty is the canonical way to expose an '
            'integer-valued field to Flutter\'s diagnostics infrastructure. '
            'Use unit for semantic suffixes, defaultValue for noise '
            'suppression, and ifNull for graceful null handling.',
            style: TextStyle(fontSize: 12.5),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFooter() {
  return Center(
    child: Text(
      'IntProperty deep visual demo — generated for the d4rt corpus.',
      style: TextStyle(
        fontSize: 11,
        color: Colors.grey.shade600,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

Widget _miniHeader(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
      ),
    ),
  );
}

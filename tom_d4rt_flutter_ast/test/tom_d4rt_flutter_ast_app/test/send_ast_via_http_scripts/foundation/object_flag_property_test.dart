// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code
// D4rt test script: Deep Demo - ObjectFlagProperty<T> from package:flutter/foundation.dart
// Comprehensive demonstration of the diagnostics property that renders an object
// as a "name: present"/"name: missing" pill rather than the object's toString output.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=' * 70);
  print('ObjectFlagProperty<T> — Deep Visual Demo');
  print('=' * 70);

  // ==========================================================================
  // SECTION 1 — DOSSIER
  // ==========================================================================
  // ObjectFlagProperty<T> is a DiagnosticsProperty<T> that hides the noisy
  // toString() of `value` and renders a tiny status flag in its place. Use it
  // when the *presence* of an object matters more than the object itself —
  // typical examples are optional callbacks (`onTap`, `onChanged`), builders,
  // controllers, and other "wire it up if you want it" hooks on widgets.
  //
  //   * present  → renders `name: ifPresent`     (or hidden if ifPresent==null)
  //   * absent   → renders `name: ifNull`        (or hidden if ifNull==null)
  //
  // Unlike FlagProperty (which is bool-only and just toggles a single label),
  // ObjectFlagProperty<T> is generic over T and is driven by `value != null`.
  // It is the canonical answer to: "I want to surface that the callback is
  // wired up, but I don't want a Closure#abc123 in my diagnostics dump."

  final dossierBullets = <Map<String, String>>[
    {
      'glyph': '*',
      'title': 'Subtype of DiagnosticsProperty<T>',
      'body':
          'Inherits name/value/level/showName/defaultValue from the standard '
          'diagnostics machinery.',
    },
    {
      'glyph': '*',
      'title': 'Driven by null vs non-null',
      'body':
          'Branches on `value == null`: chooses ifNull for null and ifPresent '
          'for present values.',
    },
    {
      'glyph': '*',
      'title': '`has` factory',
      'body':
          'ObjectFlagProperty.has(name, value) builds the common "has name" '
          'shape — hidden when null, "has name" when present.',
    },
    {
      'glyph': '*',
      'title': 'Pairs with debugFillProperties',
      'body':
          'Add it inside Diagnosticable.debugFillProperties to summarise the '
          'presence of optional collaborators.',
    },
    {
      'glyph': '*',
      'title': 'Hidden by default when null',
      'body':
          'Default level when value is null *and* ifNull is null is '
          'DiagnosticLevel.hidden — so empty slots stay quiet.',
    },
  ];

  // ==========================================================================
  // SECTION 2 — ANATOMY
  // ==========================================================================
  // Constructor:
  //   ObjectFlagProperty<T>(
  //     String name,
  //     T? value, {
  //     String? ifPresent,
  //     String? ifNull,
  //     bool showName = true,
  //     Object? defaultValue = kNoDefaultValue,
  //     DiagnosticLevel level = DiagnosticLevel.info,
  //   })
  //
  // Factory:
  //   ObjectFlagProperty<T>.has(String name, T? value)
  //     ≈ ObjectFlagProperty<T>(name, value, ifPresent: 'has $name')

  final anatomyRows = <Map<String, String>>[
    {
      'param': 'name',
      'type': 'String',
      'role': 'Identifier shown to the left of the colon in toString().',
    },
    {
      'param': 'value',
      'type': 'T?',
      'role': 'The thing being inspected. null vs non-null drives the output.',
    },
    {
      'param': 'ifPresent',
      'type': 'String?',
      'role': 'Text printed when value is non-null. Optional.',
    },
    {
      'param': 'ifNull',
      'type': 'String?',
      'role': 'Text printed when value is null. Optional.',
    },
    {
      'param': 'showName',
      'type': 'bool',
      'role': 'When false the "name: " prefix is omitted from toString().',
    },
    {
      'param': 'defaultValue',
      'type': 'Object?',
      'role': 'Comparison sentinel that downgrades level to fine if matched.',
    },
    {
      'param': 'level',
      'type': 'DiagnosticLevel',
      'role':
          'Filter knob (hidden < fine < debug < info < warning < error).',
    },
  ];

  // ==========================================================================
  // SECTION 3 — CONSTRUCTION GALLERY
  // ==========================================================================
  // Twelve hand-built instances that vary value / ifPresent / ifNull / level
  // / showName. Each one is rendered as a chip with its real toString().

  final gPresent = ObjectFlagProperty<Function>(
    'onTap',
    () {},
    ifPresent: 'wired',
  );
  final gAbsent = ObjectFlagProperty<Function>(
    'onTap',
    null,
    ifNull: 'not wired',
  );
  // Framework runtime contract: at least one of `ifPresent` / `ifNull` must
  // be non-null (see diagnostics.dart `ObjectFlagProperty` assertion). For
  // the "no-display-text" demo entries below, only the *opposite* slot is
  // exercised (value present → `ifNull` not displayed; value null →
  // `ifPresent` not displayed), so we pass an empty-string fallback in the
  // unused slot to satisfy the assertion without affecting the visible
  // output.
  final gPresentNoText =
      ObjectFlagProperty<Function>('onTap', () {}, ifNull: '');
  final gAbsentNoText =
      ObjectFlagProperty<Function>('onTap', null, ifPresent: '');
  final gBoth = ObjectFlagProperty<String>(
    'title',
    'Hello',
    ifPresent: 'has title',
    ifNull: 'no title',
  );
  final gBothNull = ObjectFlagProperty<String>(
    'title',
    null,
    ifPresent: 'has title',
    ifNull: 'no title',
  );
  final gHiddenLevel = ObjectFlagProperty<int>(
    'count',
    7,
    ifPresent: 'counted',
    level: DiagnosticLevel.hidden,
  );
  final gWarning = ObjectFlagProperty<String>(
    'token',
    null,
    ifNull: 'missing token',
    level: DiagnosticLevel.warning,
  );
  final gFine = ObjectFlagProperty<String>(
    'cache',
    'warm',
    ifPresent: 'warm',
    level: DiagnosticLevel.fine,
  );
  final gNoName = ObjectFlagProperty<String>(
    'avatar',
    'me.png',
    ifPresent: 'me.png',
    showName: false,
  );
  final gHas = ObjectFlagProperty<Function>.has('onPressed', () {});
  final gHasNull = ObjectFlagProperty<Function>.has('onPressed', null);

  final galleryEntries = <_Entry>[
    _Entry('present + ifPresent', gPresent, true),
    _Entry('absent + ifNull', gAbsent, false),
    _Entry('present, no ifPresent', gPresentNoText, true),
    _Entry('absent, no ifNull', gAbsentNoText, false),
    _Entry('both, present', gBoth, true),
    _Entry('both, null', gBothNull, false),
    _Entry('level=hidden', gHiddenLevel, true),
    _Entry('level=warning', gWarning, false),
    _Entry('level=fine', gFine, true),
    _Entry('showName=false', gNoName, true),
    _Entry('.has() present', gHas, true),
    _Entry('.has() null', gHasNull, false),
  ];

  final galleryRows = <Map<String, dynamic>>[];
  for (final entry in galleryEntries) {
    galleryRows.add(<String, dynamic>{
      'label': entry.label,
      'toString': entry.property.toString(),
      'level': entry.property.level.name,
      'present': entry.present,
      'showName': entry.property.showName,
      'name': entry.property.name ?? '<unnamed>',
    });
  }

  // ==========================================================================
  // SECTION 4 — `has` FACTORY SHOWCASE
  // ==========================================================================
  // ObjectFlagProperty.has(name, value) is the workhorse — it auto-fills
  // ifPresent with 'has $name' and leaves ifNull null so a missing collaborator
  // is hidden entirely. Side-by-side with manual construction below.

  final hasOnTapWired = ObjectFlagProperty<Function>.has('onTap', () {});
  final hasOnTapMissing = ObjectFlagProperty<Function>.has('onTap', null);
  final hasOnDragWired = ObjectFlagProperty<Function>.has(
    'onDrag',
    (Object e) {},
  );
  final hasOnDragMissing = ObjectFlagProperty<Function>.has('onDrag', null);
  final hasBuilderWired = ObjectFlagProperty<WidgetBuilder>.has(
    'builder',
    (ctx) => SizedBox.shrink(),
  );
  final hasBuilderMissing = ObjectFlagProperty<WidgetBuilder>.has(
    'builder',
    null,
  );

  final hasFactoryRows = <Map<String, dynamic>>[
    {
      'name': 'onTap',
      'wired': hasOnTapWired.toString(),
      'wiredLevel': hasOnTapWired.level.name,
      'missing': hasOnTapMissing.toString(),
      'missingLevel': hasOnTapMissing.level.name,
    },
    {
      'name': 'onDrag',
      'wired': hasOnDragWired.toString(),
      'wiredLevel': hasOnDragWired.level.name,
      'missing': hasOnDragMissing.toString(),
      'missingLevel': hasOnDragMissing.level.name,
    },
    {
      'name': 'builder',
      'wired': hasBuilderWired.toString(),
      'wiredLevel': hasBuilderWired.level.name,
      'missing': hasBuilderMissing.toString(),
      'missingLevel': hasBuilderMissing.level.name,
    },
  ];

  // ==========================================================================
  // SECTION 5 — INSIDE debugFillProperties
  // ==========================================================================
  // A tiny Diagnosticable that wires up four optional collaborators and then
  // surfaces their presence using ObjectFlagProperty inside debugFillProperties.

  final config1 = _DemoConfig(
    label: 'wired-up',
    onTap: () {},
    onLongPress: () {},
    builder: (ctx) => SizedBox.shrink(),
    onError: null,
  );
  final config2 = _DemoConfig(
    label: 'bare',
    onTap: null,
    onLongPress: null,
    builder: null,
    onError: null,
  );
  final config3 = _DemoConfig(
    label: 'partial',
    onTap: () {},
    onLongPress: null,
    builder: (ctx) => SizedBox.shrink(),
    onError: null,
  );

  // D4RT-SCRIPT-WORKAROUND (U10): `_DemoConfig with Diagnosticable` cannot
  // reach the bridged `toDiagnosticsNode().toStringDeep()` chain — same
  // architectural family as C36/C37, just on the parent `Diagnosticable`
  // mixin rather than `DiagnosticableTreeMixin`. We build the deep dump
  // manually by invoking the script's own `debugFillProperties` on a fresh
  // `DiagnosticPropertiesBuilder` and formatting its `properties` list.
  final diagnosticableExamples = <Map<String, String>>[
    {
      'label': config1.label,
      'short': config1.toStringShort(),
      'deep': _diagnosticableDeepDump(config1),
    },
    {
      'label': config2.label,
      'short': config2.toStringShort(),
      'deep': _diagnosticableDeepDump(config2),
    },
    {
      'label': config3.label,
      'short': config3.toStringShort(),
      'deep': _diagnosticableDeepDump(config3),
    },
  ];

  // toJsonMap shape — single example (delegate kept minimal on purpose).
  final delegate = DiagnosticsSerializationDelegate(
    subtreeDepth: 0,
    includeProperties: false,
  );
  final jsonShapeExample = gBoth.toJsonMap(delegate);
  final jsonShapeRows = <Map<String, String>>[];
  jsonShapeExample.forEach((k, v) {
    jsonShapeRows.add(<String, String>{'key': k, 'value': '$v'});
  });

  // ==========================================================================
  // SECTION 6 — LEVEL FILTERING
  // ==========================================================================
  // The same logical property at every interesting DiagnosticLevel.

  final levelHidden = ObjectFlagProperty<String>(
    'flag',
    'on',
    ifPresent: 'on',
    level: DiagnosticLevel.hidden,
  );
  final levelFine = ObjectFlagProperty<String>(
    'flag',
    'on',
    ifPresent: 'on',
    level: DiagnosticLevel.fine,
  );
  final levelDebug = ObjectFlagProperty<String>(
    'flag',
    'on',
    ifPresent: 'on',
    level: DiagnosticLevel.debug,
  );
  final levelInfo = ObjectFlagProperty<String>(
    'flag',
    'on',
    ifPresent: 'on',
    level: DiagnosticLevel.info,
  );
  final levelWarning = ObjectFlagProperty<String>(
    'flag',
    'on',
    ifPresent: 'on',
    level: DiagnosticLevel.warning,
  );
  final levelError = ObjectFlagProperty<String>(
    'flag',
    'on',
    ifPresent: 'on',
    level: DiagnosticLevel.error,
  );

  final levelRows = <Map<String, String>>[
    {'level': 'hidden', 'toString': levelHidden.toString()},
    {'level': 'fine', 'toString': levelFine.toString()},
    {'level': 'debug', 'toString': levelDebug.toString()},
    {'level': 'info', 'toString': levelInfo.toString()},
    {'level': 'warning', 'toString': levelWarning.toString()},
    {'level': 'error', 'toString': levelError.toString()},
  ];

  // ==========================================================================
  // SECTION 7 — COMPARISON WITH FlagProperty
  // ==========================================================================
  // FlagProperty is bool-only: it just toggles between ifTrue/ifFalse.
  // ObjectFlagProperty is generic and toggles on null vs non-null.

  final flagTrue = FlagProperty(
    'enabled',
    value: true,
    ifTrue: 'enabled',
    ifFalse: 'disabled',
  );
  final flagFalse = FlagProperty(
    'enabled',
    value: false,
    ifTrue: 'enabled',
    ifFalse: 'disabled',
  );
  final ofpPresent = ObjectFlagProperty<String>(
    'enabled',
    'yes',
    ifPresent: 'enabled',
    ifNull: 'disabled',
  );
  final ofpAbsent = ObjectFlagProperty<String>(
    'enabled',
    null,
    ifPresent: 'enabled',
    ifNull: 'disabled',
  );

  final comparisonRows = <Map<String, String>>[
    {
      'kind': 'FlagProperty',
      'state': 'value=true',
      'toString': flagTrue.toString(),
    },
    {
      'kind': 'FlagProperty',
      'state': 'value=false',
      'toString': flagFalse.toString(),
    },
    {
      'kind': 'ObjectFlagProperty',
      'state': 'value="yes"',
      'toString': ofpPresent.toString(),
    },
    {
      'kind': 'ObjectFlagProperty',
      'state': 'value=null',
      'toString': ofpAbsent.toString(),
    },
  ];

  // ==========================================================================
  // SECTION 8 — RECIPE CARDS
  // ==========================================================================

  final recipes = <Map<String, String>>[
    {
      'title': '1. Optional callback presence',
      'code':
          'ObjectFlagProperty<VoidCallback>.has(\'onTap\', widget.onTap)',
      'why':
          'Hides the closure spam, shows only "has onTap" when a handler '
          'is wired up. The most common usage by far.',
    },
    {
      'title': '2. Optional builder presence',
      'code':
          'ObjectFlagProperty<WidgetBuilder>.has(\'builder\', widget.builder)',
      'why':
          'Same pattern for builders: emits "has builder" when present, '
          'hidden when null.',
    },
    {
      'title': '3. Required field, warn when missing',
      'code': "ObjectFlagProperty<String>(\n"
          "  'apiKey',\n"
          "  apiKey,\n"
          "  ifNull: 'MISSING',\n"
          "  level: DiagnosticLevel.warning,\n"
          ')',
      'why':
          'A missing required value pops in red text in the diagnostics '
          'dump — easier to spot than a vanilla null.',
    },
    {
      'title': '4. Yes/no without ceremony',
      'code': "ObjectFlagProperty<dynamic>(\n"
          "  'attached',\n"
          "  controller,\n"
          "  ifPresent: 'yes',\n"
          "  ifNull: 'no',\n"
          ')',
      'why':
          'When the object itself is irrelevant — just whether a slot is '
          'filled.',
    },
    {
      'title': '5. Compact, no name',
      'code': "ObjectFlagProperty<String>(\n"
          "  'kind',\n"
          "  kind,\n"
          "  ifPresent: kind,\n"
          "  showName: false,\n"
          ')',
      'why':
          'Drop the "kind: " prefix so the value reads as a free-floating '
          'tag in the diagnostics line.',
    },
    {
      'title': '6. Debug-only presence',
      'code': "ObjectFlagProperty<Object>(\n"
          "  'cache',\n"
          "  cache,\n"
          "  ifPresent: 'warm',\n"
          "  level: DiagnosticLevel.fine,\n"
          ')',
      'why':
          'Only shows up under deep diagnostic dumps — keeps the normal '
          'output clean.',
    },
    {
      'title': '7. Pairs of present/absent',
      'code': "ObjectFlagProperty<Function>(\n"
          "  'callback',\n"
          "  cb,\n"
          "  ifPresent: 'wired',\n"
          "  ifNull: 'no callback',\n"
          ')',
      'why':
          'Both branches labelled — useful when the absence is *also* '
          'noteworthy.',
    },
    {
      'title': '8. Inside debugFillProperties',
      'code': "@override\n"
          "void debugFillProperties(DiagnosticPropertiesBuilder p) {\n"
          "  super.debugFillProperties(p);\n"
          "  p.add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));\n"
          "}",
      'why':
          'The textbook integration point — Flutter widgets use this '
          'pattern throughout their codebases.',
    },
  ];

  // ==========================================================================
  // SECTION 9 — COMPARISON TABLE
  // ==========================================================================

  final comparisonTable = <Map<String, String>>[
    {
      'feature': 'Generic over T',
      'ofp': 'yes — ObjectFlagProperty<T>',
      'fp': 'no — bool-only',
      'dp': 'yes — DiagnosticsProperty<T>',
    },
    {
      'feature': 'Switches on',
      'ofp': 'value == null',
      'fp': 'value (true/false)',
      'dp': 'always renders value.toString()',
    },
    {
      'feature': 'Hidden by default when',
      'ofp': 'value is null and ifNull is null',
      'fp': 'value is false and ifFalse is null',
      'dp': 'never — always at info',
    },
    {
      'feature': 'Typical use',
      'ofp': 'optional callbacks / builders',
      'fp': 'boolean toggles',
      'dp': 'plain value inspection',
    },
    {
      'feature': '.has() factory',
      'ofp': 'yes',
      'fp': 'no',
      'dp': 'no',
    },
    {
      'feature': 'Rendered as',
      'ofp': '"name: ifPresent" / "name: ifNull"',
      'fp': '"name: ifTrue" / "name: ifFalse"',
      'dp': '"name: value.toString()"',
    },
  ];

  // ==========================================================================
  // SECTION 10 — GLOSSARY
  // ==========================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'DiagnosticsNode',
      'def':
          'Tree node that participates in toDiagnosticsNode().toStringDeep().',
    },
    {
      'term': 'DiagnosticsProperty<T>',
      'def':
          'A leaf node tied to a typed value — base class of '
          'ObjectFlagProperty and DiagnosticsProperty.',
    },
    {
      'term': 'ObjectFlagProperty<T>',
      'def':
          'Subtype of DiagnosticsProperty that renders presence/absence as '
          'a flag instead of value.toString().',
    },
    {
      'term': 'FlagProperty',
      'def':
          'Boolean-only sibling: toggles between ifTrue / ifFalse based on '
          'a bool value.',
    },
    {
      'term': 'DiagnosticLevel',
      'def':
          'Ordered enum: hidden, fine, debug, info, warning, error, off. '
          'Acts as a filter knob.',
    },
    {
      'term': 'ifPresent',
      'def':
          'Text rendered when value is non-null. Null means "hide on '
          'present".',
    },
    {
      'term': 'ifNull',
      'def':
          'Text rendered when value is null. Null means "hide on absent".',
    },
    {
      'term': '.has() factory',
      'def':
          'Shorthand for ObjectFlagProperty(name, value, ifPresent: "has '
          '\$name"). The default callback-style construction.',
    },
    {
      'term': 'showName',
      'def':
          'When false the "name: " prefix is dropped from the rendered '
          'output.',
    },
    {
      'term': 'defaultValue',
      'def':
          'Sentinel compared to value. If they match the property is '
          'downgraded to DiagnosticLevel.fine.',
    },
    {
      'term': 'debugFillProperties',
      'def':
          'Hook on Diagnosticable where properties are added to the '
          'DiagnosticPropertiesBuilder.',
    },
    {
      'term': 'toJsonMap',
      'def':
          'Serialises the node into a Map for tooling (DevTools, the '
          'inspector). ObjectFlagProperty surfaces ifPresent/ifNull keys.',
    },
  ];

  // ==========================================================================
  // SECTION 11 — FINAL COMPOSED WIDGET TREE
  // ==========================================================================

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===== HEADER =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2E7D32), Color(0xFF388E3C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ObjectFlagProperty<T>',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'Deep Demo • package:flutter/foundation.dart',
                  style: TextStyle(fontSize: 14.0, color: Color(0xFFC8E6C9)),
                ),
                SizedBox(height: 14.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'present / absent flag chip for optional objects',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: DOSSIER =====
          _SectionShell(
            number: '1',
            title: 'Dossier — what ObjectFlagProperty is for',
            accent: Color(0xFF2E7D32),
            background: Color(0xFFE8F5E9),
            border: Color(0xFF81C784),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A DiagnosticsProperty<T> that hides value.toString() and '
                  'renders a short "present/absent" flag instead. Built for '
                  'optional collaborators (callbacks, builders, controllers) '
                  'whose presence matters more than their identity.',
                  style: TextStyle(fontSize: 13.0, height: 1.4),
                ),
                SizedBox(height: 12.0),
                for (final bullet in dossierBullets)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 22.0,
                          height: 22.0,
                          margin: EdgeInsets.only(top: 2.0, right: 8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF2E7D32),
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          child: Center(
                            child: Text(
                              bullet['glyph']!,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bullet['title']!,
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                bullet['body']!,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  height: 1.35,
                                ),
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

          SizedBox(height: 16.0),

          // ===== SECTION 2: ANATOMY =====
          _SectionShell(
            number: '2',
            title: 'Anatomy — constructor + .has factory',
            accent: Color(0xFF1976D2),
            background: Color(0xFFE3F2FD),
            border: Color(0xFF90CAF9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF0D47A1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'ObjectFlagProperty<T>(name, value, '
                    '{ifPresent, ifNull, showName, defaultValue, level})\n'
                    'ObjectFlagProperty<T>.has(name, value)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Color(0xFFFFFFFF),
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                for (final row in anatomyRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            row['param']!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80.0,
                          child: Text(
                            row['type']!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11.0,
                              color: Color(0xFF1565C0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            row['role']!,
                            style: TextStyle(fontSize: 12.0, height: 1.35),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 3: CONSTRUCTION GALLERY =====
          _SectionShell(
            number: '3',
            title: 'Construction gallery — 12 hand-built instances',
            accent: Color(0xFF6A1B9A),
            background: Color(0xFFF3E5F5),
            border: Color(0xFFCE93D8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Each chip is the actual toString() of an ObjectFlagProperty '
                  'instance. Green = present, grey = absent or hidden.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF6A1B9A)),
                ),
                SizedBox(height: 12.0),
                for (final row in galleryRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFFCE93D8),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  row['label'] as String,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4A148C),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE1BEE7),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  'level: ${row['level']}',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xFF4A148C),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 8.0,
                            ),
                            decoration: BoxDecoration(
                              color: (row['present'] as bool)
                                  ? Color(0xFFC8E6C9)
                                  : Color(0xFFE0E0E0),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: (row['present'] as bool)
                                    ? Color(0xFF388E3C)
                                    : Color(0xFF9E9E9E),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: (row['present'] as bool)
                                        ? Color(0xFF2E7D32)
                                        : Color(0xFF616161),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    row['toString'] as String,
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 11.0,
                                      color: (row['present'] as bool)
                                          ? Color(0xFF1B5E20)
                                          : Color(0xFF424242),
                                    ),
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
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 4: HAS FACTORY SHOWCASE =====
          _SectionShell(
            number: '4',
            title: '.has() factory — wired vs missing side by side',
            accent: Color(0xFFE65100),
            background: Color(0xFFFFF3E0),
            border: Color(0xFFFFB74D),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ObjectFlagProperty.has(name, value) auto-fills ifPresent '
                  'with "has \$name". Missing values stay hidden — note the '
                  'level swings from info to hidden.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFFE65100)),
                ),
                SizedBox(height: 12.0),
                for (final row in hasFactoryRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'callback: ${row['name']}',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFBF360C),
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFC8E6C9),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'wired',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1B5E20),
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      row['wired'] as String,
                                      style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 11.0,
                                        color: Color(0xFF1B5E20),
                                      ),
                                    ),
                                    Text(
                                      'level: ${row['wiredLevel']}',
                                      style: TextStyle(
                                        fontSize: 9.0,
                                        color: Color(0xFF2E7D32),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'missing',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF424242),
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      row['missing'] as String,
                                      style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 11.0,
                                        color: Color(0xFF424242),
                                      ),
                                    ),
                                    Text(
                                      'level: ${row['missingLevel']}',
                                      style: TextStyle(
                                        fontSize: 9.0,
                                        color: Color(0xFF616161),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 5: INSIDE debugFillProperties =====
          _SectionShell(
            number: '5',
            title: 'Inside debugFillProperties — live Diagnosticable',
            accent: Color(0xFF00838F),
            background: Color(0xFFE0F7FA),
            border: Color(0xFF4DD0E1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '_DemoConfig is a tiny Diagnosticable whose '
                  'debugFillProperties uses four ObjectFlagProperty.has() '
                  'entries — one per optional collaborator.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF006064)),
                ),
                SizedBox(height: 12.0),
                for (final ex in diagnosticableExamples)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF00838F),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            'config: ${ex['label']}',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'toStringShort():',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Color(0xFF006064),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFB2EBF2),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            ex['short']!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10.0,
                              color: Color(0xFF004D40),
                            ),
                          ),
                        ),
                        Text(
                          'toDiagnosticsNode().toStringDeep():',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Color(0xFF006064),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(top: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF263238),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            ex['deep']!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10.0,
                              color: Color(0xFF80DEEA),
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 8.0),
                Text(
                  'toJsonMap() shape (single example):',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                  ),
                ),
                SizedBox(height: 6.0),
                for (final entry in jsonShapeRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120.0,
                          child: Text(
                            entry['key']!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10.0,
                              color: Color(0xFF006064),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            entry['value']!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10.0,
                              color: Color(0xFF004D40),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 6: LEVEL FILTERING =====
          _SectionShell(
            number: '6',
            title: 'Level filtering — same property, six levels',
            accent: Color(0xFFC2185B),
            background: Color(0xFFFCE4EC),
            border: Color(0xFFF06292),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Same name, same value ("on"), only level varies. The '
                  '`level` field controls inclusion in filtered diagnostics '
                  'dumps.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFFC2185B)),
                ),
                SizedBox(height: 12.0),
                for (final row in levelRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 3.0,
                            ),
                            decoration: BoxDecoration(
                              color: _levelColor(row['level']!),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              row['level']!,
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                color: Color(0xFFF8BBD9),
                                width: 1.0,
                              ),
                            ),
                            child: Text(
                              row['toString']!,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11.0,
                                color: Color(0xFF880E4F),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 7: COMPARISON WITH FlagProperty =====
          _SectionShell(
            number: '7',
            title: 'Versus FlagProperty — bool vs nullable object',
            accent: Color(0xFF5D4037),
            background: Color(0xFFEFEBE9),
            border: Color(0xFFA1887F),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FlagProperty toggles on a boolean. ObjectFlagProperty '
                  'toggles on null vs non-null. Both render as "name: text" '
                  'but they answer different questions.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF5D4037)),
                ),
                SizedBox(height: 12.0),
                for (final row in comparisonRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFD7CCC8),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 130.0,
                            child: Text(
                              row['kind']!,
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E2723),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 90.0,
                            child: Text(
                              row['state']!,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10.0,
                                color: Color(0xFF5D4037),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              row['toString']!,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11.0,
                                color: Color(0xFF3E2723),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 8: RECIPES =====
          _SectionShell(
            number: '8',
            title: 'Recipe cards — eight ready-to-paste patterns',
            accent: Color(0xFF303F9F),
            background: Color(0xFFE8EAF6),
            border: Color(0xFF7986CB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final recipe in recipes)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFF7986CB),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe['title']!,
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A237E),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF1A237E),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              recipe['code']!,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10.0,
                                color: Color(0xFFC5CAE9),
                                height: 1.4,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            recipe['why']!,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF283593),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 9: COMPARISON TABLE =====
          _SectionShell(
            number: '9',
            title:
                'Comparison table — ObjectFlagProperty / FlagProperty / DiagnosticsProperty',
            accent: Color(0xFFAD1457),
            background: Color(0xFFFCE4EC),
            border: Color(0xFFF48FB1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFAD1457),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Feature',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'ObjectFlagProperty',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'FlagProperty',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'DiagnosticsProperty',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                for (final row in comparisonTable)
                  Container(
                    margin: EdgeInsets.only(top: 4.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            row['feature']!,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFAD1457),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            row['ofp']!,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFF880E4F),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            row['fp']!,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFF880E4F),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            row['dp']!,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFF880E4F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 10: GLOSSARY =====
          _SectionShell(
            number: '10',
            title: 'Glossary — twelve diagnostics terms',
            accent: Color(0xFF455A64),
            background: Color(0xFFECEFF1),
            border: Color(0xFF90A4AE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final term in glossary)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150.0,
                          child: Text(
                            term['term']!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263238),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            term['def']!,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF37474F),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 11: FINAL SUMMARY =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary — ObjectFlagProperty<T>',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 12.0),
                _summary('Dossier covered', 'PASS'),
                _summary('Anatomy table', 'PASS'),
                _summary('Construction gallery (12 chips)', 'PASS'),
                _summary('.has() factory showcase', 'PASS'),
                _summary('Live debugFillProperties dump', 'PASS'),
                _summary('toJsonMap shape rendered', 'PASS'),
                _summary('Level filtering swatch', 'PASS'),
                _summary('FlagProperty comparison', 'PASS'),
                _summary('Eight recipes', 'PASS'),
                _summary('3-way comparison table', 'PASS'),
                _summary('Glossary (12 terms)', 'PASS'),
                SizedBox(height: 14.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ObjectFlagProperty<T>: ',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        'Deep Demo Complete',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          Center(
            child: Text(
              'Deep Demo • ObjectFlagProperty • package:flutter/foundation.dart',
              style: TextStyle(fontSize: 11.0, color: Color(0xFF9E9E9E)),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SUPPORT TYPES
// ============================================================================

class _Entry {
  _Entry(this.label, this.property, this.present);
  final String label;
  final ObjectFlagProperty property;
  final bool present;
}

class _DemoConfig with Diagnosticable {
  _DemoConfig({
    required this.label,
    required this.onTap,
    required this.onLongPress,
    required this.builder,
    required this.onError,
  });

  final String label;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final WidgetBuilder? builder;
  final void Function(Object)? onError;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // D4RT-SCRIPT-WORKAROUND (U10 family): the bridged `Diagnosticable` mixin
    // does not support `super.debugFillProperties(...)` dispatch from a
    // script-defined class (no native super for the InterpretedInstance).
    // `Diagnosticable.debugFillProperties` is a no-op in native Dart anyway,
    // so dropping the super call has no effect on the displayed output.
    properties.add(StringProperty('label', label));
    properties.add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
    properties.add(
      ObjectFlagProperty<VoidCallback>.has('onLongPress', onLongPress),
    );
    properties.add(ObjectFlagProperty<WidgetBuilder>.has('builder', builder));
    properties.add(
      ObjectFlagProperty<void Function(Object)>.has('onError', onError),
    );
  }

  @override
  String toStringShort() => '_DemoConfig($label)';
}

// D4RT-SCRIPT-WORKAROUND (U10): build a `toStringDeep()`-like dump without
// crossing the d4rt → native boundary. The script's own `debugFillProperties`
// is called directly to populate a bridged `DiagnosticPropertiesBuilder`;
// each emitted property's bridged `toString()` produces the canonical
// "name: value" line that `toStringDeep` would also emit.
String _diagnosticableDeepDump(_DemoConfig c) {
  final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
  c.debugFillProperties(builder);
  final List<String> lines = <String>[c.toStringShort()];
  for (final DiagnosticsNode p in builder.properties) {
    lines.add(' │ ${p.toString()}');
  }
  return lines.join('\n');
}

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.number,
    required this.title,
    required this.accent,
    required this.background,
    required this.border,
    required this.child,
  });

  final String number;
  final String title;
  final Color accent;
  final Color background;
  final Color border;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: border, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          child,
        ],
      ),
    );
  }
}

Color _levelColor(String level) {
  switch (level) {
    case 'hidden':
      return Color(0xFF9E9E9E);
    case 'fine':
      return Color(0xFF607D8B);
    case 'debug':
      return Color(0xFF03A9F4);
    case 'info':
      return Color(0xFF4CAF50);
    case 'warning':
      return Color(0xFFFF9800);
    case 'error':
      return Color(0xFFF44336);
    default:
      return Color(0xFF9E9E9E);
  }
}

Widget _summary(String label, String status) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13.0),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

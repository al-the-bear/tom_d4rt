// ignore_for_file: avoid_print, deprecated_member_use, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Selection Types from rendering / widgets
// Subjects: SelectionGeometry, SelectionStatus, SelectionPoint, SelectionEvent
//           and its subtypes, SelectionEventType, SelectionUtils.adjustDragOffset,
//           TextSelectionDelegate.selectAll, TextSelectionGranularity,
//           SelectionChangedCause.
//
// Note on imports: SelectionChangedCause (from package:flutter/services.dart)
// is re-exported transitively via material.dart -> widgets.dart, so we only
// list the higher-level imports here to keep the analyzer clean.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // SECTION 1 (data): Dossier strings
  // ===========================================================================

  final dossier = <Map<String, String>>[
    {
      'label': 'Family',
      'value':
          'SelectionGeometry, SelectionPoint, SelectionStatus, '
              'SelectionEvent and subtypes',
    },
    {
      'label': 'Lives in',
      'value': 'package:flutter/rendering.dart + package:flutter/widgets.dart',
    },
    {
      'label': 'Consumed by',
      'value':
          'SelectionArea, SelectableRegion, SelectionContainer, custom '
              'Selectable implementations',
    },
    {
      'label': 'Drives',
      'value':
          'Selection handles, toolbar position, contiguous multi-widget '
              'selection, screen-reader handoff',
    },
    {
      'label': 'Why it exists',
      'value':
          'A flexible model for selection that crosses widget boundaries '
              'and supports keyboard, mouse, touch, and accessibility input.',
    },
  ];

  // ===========================================================================
  // SECTION 2 (data): Anatomy table
  // ===========================================================================

  final anatomy = <Map<String, String>>[
    {
      'symbol': 'SelectionGeometry',
      'kind': 'class',
      'key':
          'startSelectionPoint, endSelectionPoint, status, '
              'hasContent, selectionRects',
      'role': 'Snapshot of the visual geometry of an active selection.',
    },
    {
      'symbol': 'SelectionPoint',
      'kind': 'class',
      'key': 'localPosition, lineHeight, handleType',
      'role': 'A single anchor (start or end) inside a Selectable.',
    },
    {
      'symbol': 'SelectionStatus',
      'kind': 'enum',
      'key': 'collapsed, uncollapsed, none',
      'role': 'Whether the selection currently covers content.',
    },
    {
      'symbol': 'SelectionEvent',
      'kind': 'abstract class',
      'key': 'type',
      'role': 'Base class for events dispatched into Selectable handlers.',
    },
    {
      'symbol': 'SelectAllSelectionEvent',
      'kind': 'class',
      'key': 'type = selectAll',
      'role': 'Request to select every selectable child.',
    },
    {
      'symbol': 'ClearSelectionEvent',
      'kind': 'class',
      'key': 'type = clear',
      'role': 'Request to discard the current selection.',
    },
    {
      'symbol': 'SelectWordSelectionEvent',
      'kind': 'class',
      'key': 'globalPosition',
      'role': 'Word-grained selection (double-tap / double-click).',
    },
    {
      'symbol': 'SelectParagraphSelectionEvent',
      'kind': 'class',
      'key': 'globalPosition',
      'role': 'Paragraph-grained selection (triple-click).',
    },
    {
      'symbol': 'GranularlyExtendSelectionEvent',
      'kind': 'class',
      'key': 'forward, isEnd, granularity',
      'role': 'Keyboard-style stepwise extension.',
    },
    {
      'symbol': 'DirectionallyExtendSelectionEvent',
      'kind': 'class',
      'key': 'dx, isEnd, direction',
      'role': 'Mouse-drag style directional extension.',
    },
    {
      'symbol': 'SelectionEventType',
      'kind': 'enum',
      'key':
          'startEdgeUpdate, endEdgeUpdate, clear, selectAll, selectWord, '
              'selectParagraph, granularlyExtendSelection, '
              'directionallyExtendSelection',
      'role': 'Classification tag carried by SelectionEvent.',
    },
    {
      'symbol': 'TextSelectionGranularity',
      'kind': 'enum',
      'key':
          'character, word, line, paragraph, document',
      'role': 'How far one step of GranularlyExtend moves.',
    },
    {
      'symbol': 'SelectionChangedCause',
      'kind': 'enum',
      'key':
          'tap, doubleTap, longPress, forcePress, keyboard, drag, '
              'scribble, toolbar, secondaryTap',
      'role': 'Origin of a TextSelectionDelegate change.',
    },
  ];

  // ===========================================================================
  // SECTION 3 (data): SelectionGeometry gallery
  // ===========================================================================

  final pointStart = SelectionPoint(
    localPosition: const Offset(12.0, 18.0),
    lineHeight: 18.0,
    handleType: TextSelectionHandleType.left,
  );
  final pointEnd = SelectionPoint(
    localPosition: const Offset(180.0, 18.0),
    lineHeight: 18.0,
    handleType: TextSelectionHandleType.right,
  );
  final pointCollapsed = SelectionPoint(
    localPosition: const Offset(96.0, 18.0),
    lineHeight: 18.0,
    handleType: TextSelectionHandleType.collapsed,
  );

  final geomUncollapsed = SelectionGeometry(
    startSelectionPoint: pointStart,
    endSelectionPoint: pointEnd,
    status: SelectionStatus.uncollapsed,
    hasContent: true,
  );

  final geomCollapsed = SelectionGeometry(
    startSelectionPoint: pointCollapsed,
    endSelectionPoint: pointCollapsed,
    status: SelectionStatus.collapsed,
    hasContent: true,
  );

  final geomNone = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: true,
  );

  final geomEmpty = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: false,
  );

  final geomMultiLine = SelectionGeometry(
    startSelectionPoint: SelectionPoint(
      localPosition: const Offset(4.0, 18.0),
      lineHeight: 18.0,
      handleType: TextSelectionHandleType.left,
    ),
    endSelectionPoint: SelectionPoint(
      localPosition: const Offset(220.0, 90.0),
      lineHeight: 18.0,
      handleType: TextSelectionHandleType.right,
    ),
    status: SelectionStatus.uncollapsed,
    hasContent: true,
  );

  final geometries = <Map<String, dynamic>>[
    {'name': 'uncollapsed (single line)', 'geometry': geomUncollapsed},
    {'name': 'collapsed (caret only)', 'geometry': geomCollapsed},
    {'name': 'none (no selection)', 'geometry': geomNone},
    {'name': 'empty (no content)', 'geometry': geomEmpty},
    {'name': 'multi-line uncollapsed', 'geometry': geomMultiLine},
  ];

  // ===========================================================================
  // SECTION 4 (data): SelectionStatus walk-through
  // ===========================================================================

  final statusRows = <Map<String, String>>[];
  for (final s in SelectionStatus.values) {
    final String meaning;
    final String example;
    if (s == SelectionStatus.collapsed) {
      meaning = 'A caret is present but no range is highlighted.';
      example = 'User tapped once inside a SelectableText.';
    } else if (s == SelectionStatus.uncollapsed) {
      meaning = 'A real range is selected: start and end differ.';
      example = 'User dragged across two words.';
    } else {
      meaning = 'There is no caret and no selected range.';
      example = 'Selectable contains text but has not been focused.';
    }
    statusRows.add(<String, String>{
      'name': s.name,
      'index': s.index.toString(),
      'meaning': meaning,
      'example': example,
    });
  }

  // ===========================================================================
  // SECTION 5 (data): SelectionEvent subtype gallery
  // ===========================================================================

  final evSelectAll = const SelectAllSelectionEvent();
  final evClear = const ClearSelectionEvent();
  final evSelectWord = SelectWordSelectionEvent(
    globalPosition: const Offset(120.0, 64.0),
  );
  final evSelectParagraph = SelectParagraphSelectionEvent(
    globalPosition: const Offset(120.0, 64.0),
  );
  final evGranularForward = const GranularlyExtendSelectionEvent(
    forward: true,
    isEnd: true,
    granularity: TextGranularity.word,
  );
  final evGranularBack = const GranularlyExtendSelectionEvent(
    forward: false,
    isEnd: true,
    granularity: TextGranularity.line,
  );
  final evDirectional = const DirectionallyExtendSelectionEvent(
    dx: 32.0,
    isEnd: true,
    direction: SelectionExtendDirection.nextLine,
  );

  final eventGallery = <Map<String, dynamic>>[
    {
      'event': evSelectAll,
      'desc': 'Select every selectable in the registrar tree.',
      'origin': 'Cmd/Ctrl+A or programmatic.',
    },
    {
      'event': evClear,
      'desc': 'Drop any current selection.',
      'origin': 'Escape, tap outside, or programmatic.',
    },
    {
      'event': evSelectWord,
      'desc': 'Select the word under globalPosition.',
      'origin': 'Double-tap / double-click.',
    },
    {
      'event': evSelectParagraph,
      'desc': 'Select the paragraph under globalPosition.',
      'origin': 'Triple-click on desktop.',
    },
    {
      'event': evGranularForward,
      'desc': 'Step the end-edge one word forward.',
      'origin': 'Shift+Option+Right (macOS).',
    },
    {
      'event': evGranularBack,
      'desc': 'Step the end-edge one line backward.',
      'origin': 'Shift+Up arrow.',
    },
    {
      'event': evDirectional,
      'desc': 'Extend end by 32 logical pixels to next line.',
      'origin': 'Mouse drag.',
    },
  ];

  // ===========================================================================
  // SECTION 6 (data): Enums - TextSelectionGranularity & SelectionChangedCause
  // ===========================================================================

  final granularityRows = <Map<String, String>>[];
  for (final g in TextGranularity.values) {
    final String hint;
    if (g == TextGranularity.character) {
      hint = 'One code unit at a time (arrow keys).';
    } else if (g == TextGranularity.word) {
      hint = 'Word boundaries (option/ctrl + arrow).';
    } else if (g == TextGranularity.line) {
      hint = 'Visual line in the laid-out text.';
    } else if (g == TextGranularity.paragraph) {
      hint = 'Paragraph boundary as defined by line breaks.';
    } else {
      hint = 'Entire document (cmd+up/down on macOS).';
    }
    granularityRows.add(<String, String>{
      'name': g.name,
      'index': g.index.toString(),
      'hint': hint,
    });
  }

  final causeRows = <Map<String, String>>[];
  for (final c in SelectionChangedCause.values) {
    final String hint;
    if (c == SelectionChangedCause.tap) {
      hint = 'Single tap; usually collapses selection.';
    } else if (c == SelectionChangedCause.doubleTap) {
      hint = 'Double tap; selects a word.';
    } else if (c == SelectionChangedCause.longPress) {
      hint = 'Long-press; usually shows toolbar.';
    } else if (c == SelectionChangedCause.forcePress) {
      hint = '3D Touch / force press input.';
    } else if (c == SelectionChangedCause.keyboard) {
      hint = 'Arrow-key driven movement or extension.';
    } else if (c == SelectionChangedCause.drag) {
      hint = 'Pointer drag across content.';
    } else if (c == SelectionChangedCause.scribble) {
      hint = 'Apple Pencil scribble (iPadOS).';
    } else if (c == SelectionChangedCause.toolbar) {
      hint = 'Selection toolbar action (Select All, Cut...).';
    } else {
      hint = 'Right-click / secondary tap to summon a menu.';
    }
    causeRows.add(<String, String>{
      'name': c.name,
      'index': c.index.toString(),
      'hint': hint,
    });
  }

  // ===========================================================================
  // SECTION 7 (data): SelectionUtils.adjustDragOffset demonstrations
  // ===========================================================================

  final dragRect = const Rect.fromLTWH(20.0, 40.0, 200.0, 80.0);
  final dragSamples = <Offset>[
    const Offset(10.0, 30.0),
    const Offset(120.0, 60.0),
    const Offset(260.0, 200.0),
    const Offset(20.0, 40.0),
    const Offset(220.0, 120.0),
  ];

  final dragRows = <Map<String, dynamic>>[];
  for (final raw in dragSamples) {
    final adjusted = SelectionUtils.adjustDragOffset(dragRect, raw);
    dragRows.add(<String, dynamic>{
      'raw': raw,
      'adjusted': adjusted,
      'inside': dragRect.contains(raw),
    });
  }

  // ===========================================================================
  // SECTION 8 (data): Recipes
  // ===========================================================================

  final recipes = <Map<String, String>>[
    {
      'title': 'Make a subtree selectable',
      'when': 'You have text spread across many widgets users want to copy.',
      'code': 'SelectionArea(child: MyArticleBody())',
    },
    {
      'title': 'Disable selection in a sub-region',
      'when': 'You want to opt out of an outer SelectionArea.',
      'code': 'SelectionContainer.disabled(child: SecretBadge())',
    },
    {
      'title': 'Programmatically select all',
      'when': 'You expose a "Select all" button or shortcut.',
      'code': 'controller.selectAll(SelectionChangedCause.toolbar);',
    },
    {
      'title': 'Compute a toolbar anchor from geometry',
      'when': 'You implement a custom selection toolbar.',
      'code':
          'geometry.startSelectionPoint?.localPosition '
              '?? geometry.endSelectionPoint?.localPosition',
    },
    {
      'title': 'Extend by word with the keyboard',
      'when': 'You implement keyboard handling for a custom Selectable.',
      'code':
          'handle(GranularlyExtendSelectionEvent(forward: true, '
              'isEnd: true, granularity: TextGranularity.word));',
    },
    {
      'title': 'React to selection changes by cause',
      'when': 'You want a different UX for keyboard vs. tap selection.',
      'code': 'onSelectionChanged: (sel, cause) { if (cause == '
          'SelectionChangedCause.keyboard) ... }',
    },
    {
      'title': 'Clear selection when navigating away',
      'when': 'You push a new route and want to drop the current selection.',
      'code': 'registrar.dispatchSelectionEvent(const ClearSelectionEvent());',
    },
    {
      'title': 'Clamp a drag to a selectable rect',
      'when': 'You are routing a drag inside a custom layer.',
      'code': 'SelectionUtils.adjustDragOffset(rect, rawOffset)',
    },
  ];

  // ===========================================================================
  // SECTION 9 (data): Comparison table
  // ===========================================================================

  final comparison = <Map<String, String>>[
    {
      'feature': 'Crosses widget boundaries',
      'selection': 'Yes (registrar tree)',
      'gesture': 'No (per detector)',
      'pointer': 'Yes, but raw',
    },
    {
      'feature': 'Has explicit "clear" event',
      'selection': 'ClearSelectionEvent',
      'gesture': 'No',
      'pointer': 'No',
    },
    {
      'feature': 'Carries granularity',
      'selection': 'Yes (TextGranularity)',
      'gesture': 'No',
      'pointer': 'No',
    },
    {
      'feature': 'Reports change cause',
      'selection': 'Yes (SelectionChangedCause)',
      'gesture': 'Implicit by callback',
      'pointer': 'Device + buttons',
    },
    {
      'feature': 'Cooperates with screen readers',
      'selection': 'Yes',
      'gesture': 'No',
      'pointer': 'No',
    },
    {
      'feature': 'Driven by keyboard',
      'selection': 'GranularlyExtendSelectionEvent',
      'gesture': 'Rarely',
      'pointer': 'No',
    },
    {
      'feature': 'Has visual geometry snapshot',
      'selection': 'SelectionGeometry',
      'gesture': 'No',
      'pointer': 'No',
    },
  ];

  // ===========================================================================
  // SECTION 10 (data): Glossary
  // ===========================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'Selectable',
      'def':
          'A widget / render object that participates in the selection '
              'system by registering with a SelectionRegistrar.',
    },
    {
      'term': 'SelectionRegistrar',
      'def':
          'An object that knows which Selectables exist in a subtree and '
              'routes SelectionEvents to them.',
    },
    {
      'term': 'SelectionArea',
      'def':
          'High-level widget that wraps SelectableRegion to make any '
              'subtree user-selectable with platform-native handles.',
    },
    {
      'term': 'SelectableRegion',
      'def':
          'Mid-level widget that hosts a SelectionContainer and '
              'translates input into SelectionEvents.',
    },
    {
      'term': 'Selection edge',
      'def':
          'One of the two ends of a selection: the start edge or the '
              'end edge. Carried by isEnd on extend events.',
    },
    {
      'term': 'Granularity',
      'def':
          'How far one logical step of selection moves: character, word, '
              'line, paragraph, or document.',
    },
    {
      'term': 'Geometry',
      'def':
          'The visual snapshot used to draw handles and toolbar: start '
              'point, end point, status, and selection rects.',
    },
    {
      'term': 'SelectionPoint',
      'def':
          'Geometric description of a single edge: position, line '
              'height, and which handle (left, right, collapsed) it is.',
    },
    {
      'term': 'Cause',
      'def':
          'The originating input device or surface that produced a '
              'selection change (tap, drag, keyboard, toolbar...).',
    },
    {
      'term': 'Adjust drag offset',
      'def':
          'SelectionUtils.adjustDragOffset clamps a global pointer '
              'position to the closest position inside a selectable rect.',
    },
  ];

  // ===========================================================================
  // UI BUILDERS
  // ===========================================================================

  Widget buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1A237E), Color(0xFF3949AB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Flutter Selection Types',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'SelectionGeometry / SelectionPoint / SelectionEvent / enums',
            style: TextStyle(fontSize: 14.0, color: Color(0xFFC5CAE9)),
          ),
        ],
      ),
    );
  }

  Widget sectionFrame({
    required String number,
    required String title,
    required Color accent,
    required Color background,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30.0,
                height: 30.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          child,
        ],
      ),
    );
  }

  Widget dossierBlock() {
    final tiles = <Widget>[];
    for (final row in dossier) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: const Color(0xFFC5CAE9)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  row['label']!,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF5C6BC0),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  row['value']!,
                  style: const TextStyle(fontSize: 13.0, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: tiles);
  }

  Widget anatomyBlock() {
    final headerRow = Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      decoration: const BoxDecoration(
        color: Color(0xFF512DA8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Symbol',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Kind',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'Key members',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Role',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              ),
            ),
          ),
        ],
      ),
    );
    final rows = <Widget>[headerRow];
    for (var i = 0; i < anatomy.length; i++) {
      final r = anatomy[i];
      rows.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: i.isEven
                ? const Color(0xFFEDE7F6)
                : const Color(0xFFFFFFFF),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Text(
                  r['symbol']!,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  r['kind']!,
                  style: const TextStyle(fontSize: 11.0),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  r['key']!,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF311B92),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  r['role']!,
                  style: const TextStyle(fontSize: 11.0),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(children: rows),
    );
  }

  Color statusColor(SelectionStatus s) {
    if (s == SelectionStatus.collapsed) {
      return const Color(0xFFFFB300);
    } else if (s == SelectionStatus.uncollapsed) {
      return const Color(0xFF43A047);
    }
    return const Color(0xFF757575);
  }

  String handleName(TextSelectionHandleType h) {
    if (h == TextSelectionHandleType.left) return 'left';
    if (h == TextSelectionHandleType.right) return 'right';
    return 'collapsed';
  }

  Widget pointBlock(SelectionPoint? p, String label) {
    if (p == null) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFECEFF1),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(fontSize: 10.0, color: Color(0xFF607D8B)),
            ),
            const SizedBox(height: 2.0),
            const Text(
              '(none)',
              style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontSize: 10.0, color: Color(0xFF2E7D32)),
          ),
          const SizedBox(height: 2.0),
          Text(
            'dx=${p.localPosition.dx.toStringAsFixed(1)}, '
            'dy=${p.localPosition.dy.toStringAsFixed(1)}',
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            'lineHeight=${p.lineHeight.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
          ),
          Text(
            'handle=${handleName(p.handleType)}',
            style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }

  Widget geometryCard(String name, SelectionGeometry g) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFB0BEC5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: statusColor(g.status),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  g.status.name,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: g.hasContent
                      ? const Color(0xFF1976D2)
                      : const Color(0xFF90A4AE),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  g.hasContent ? 'hasContent' : 'no content',
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 10.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: pointBlock(g.startSelectionPoint, 'startPoint')),
              const SizedBox(width: 8.0),
              Expanded(child: pointBlock(g.endSelectionPoint, 'endPoint')),
            ],
          ),
        ],
      ),
    );
  }

  Widget geometryGallery() {
    final tiles = <Widget>[];
    for (final entry in geometries) {
      tiles.add(
        geometryCard(
          entry['name'] as String,
          entry['geometry'] as SelectionGeometry,
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: tiles);
  }

  Widget statusBlock() {
    final cards = <Widget>[];
    for (final s in statusRows) {
      cards.add(
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFFFCC80)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF6C00),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'index ${s['index']}',
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    s['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                s['meaning']!,
                style: const TextStyle(fontSize: 12.0, height: 1.4),
              ),
              const SizedBox(height: 2.0),
              Text(
                'e.g. ${s['example']!}',
                style: const TextStyle(
                  fontSize: 11.0,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF8D6E63),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: cards);
  }

  String eventTypeName(SelectionEventType t) {
    return t.name;
  }

  String eventLabel(SelectionEvent e) {
    if (e is SelectAllSelectionEvent) return 'SelectAllSelectionEvent';
    if (e is ClearSelectionEvent) return 'ClearSelectionEvent';
    if (e is SelectWordSelectionEvent) return 'SelectWordSelectionEvent';
    if (e is SelectParagraphSelectionEvent) {
      return 'SelectParagraphSelectionEvent';
    }
    if (e is GranularlyExtendSelectionEvent) {
      return 'GranularlyExtendSelectionEvent';
    }
    if (e is DirectionallyExtendSelectionEvent) {
      return 'DirectionallyExtendSelectionEvent';
    }
    return 'SelectionEvent';
  }

  String eventDetails(SelectionEvent e) {
    if (e is SelectWordSelectionEvent) {
      return 'globalPosition=${e.globalPosition}';
    }
    if (e is SelectParagraphSelectionEvent) {
      return 'globalPosition=${e.globalPosition}';
    }
    if (e is GranularlyExtendSelectionEvent) {
      return 'forward=${e.forward}, isEnd=${e.isEnd}, '
          'granularity=${e.granularity.name}';
    }
    if (e is DirectionallyExtendSelectionEvent) {
      return 'dx=${e.dx}, isEnd=${e.isEnd}, '
          'direction=${e.direction.name}';
    }
    return '(no fields)';
  }

  Widget eventBlock() {
    final cards = <Widget>[];
    for (final entry in eventGallery) {
      final e = entry['event'] as SelectionEvent;
      cards.add(
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF263238),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00ACC1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'type: ${eventTypeName(e.type)}',
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      eventLabel(e),
                      style: const TextStyle(
                        color: Color(0xFF80DEEA),
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                eventDetails(e),
                style: const TextStyle(
                  color: Color(0xFFB0BEC5),
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                entry['desc'] as String,
                style: const TextStyle(
                  color: Color(0xFFECEFF1),
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                'origin: ${entry['origin']}',
                style: const TextStyle(
                  color: Color(0xFF90A4AE),
                  fontSize: 11.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: cards);
  }

  Widget enumDualBlock() {
    Widget enumList(
      String title,
      List<Map<String, String>> rows,
      Color accent,
    ) {
      final children = <Widget>[
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6.0),
      ];
      for (final r in rows) {
        children.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: accent.withOpacity(0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Text(
                          r['index']!,
                          style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 9.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        r['name']!,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    r['hint']!,
                    style: const TextStyle(fontSize: 11.0, height: 1.35),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        enumList(
          'TextSelectionGranularity (TextGranularity)',
          granularityRows,
          const Color(0xFF6A1B9A),
        ),
        const SizedBox(height: 12.0),
        enumList(
          'SelectionChangedCause',
          causeRows,
          const Color(0xFFAD1457),
        ),
      ],
    );
  }

  Widget dragBlock() {
    final rows = <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Color(0xFF00695C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        child: Row(
          children: const <Widget>[
            Expanded(
              flex: 3,
              child: Text(
                'raw',
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
                'adjusted',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'was inside?',
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
    ];
    for (var i = 0; i < dragRows.length; i++) {
      final r = dragRows[i];
      final raw = r['raw'] as Offset;
      final adj = r['adjusted'] as Offset;
      final inside = r['inside'] as bool;
      rows.add(
        Container(
          padding: const EdgeInsets.all(8.0),
          color: i.isEven
              ? const Color(0xFFE0F2F1)
              : const Color(0xFFFFFFFF),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Text(
                  '(${raw.dx.toStringAsFixed(1)}, '
                  '${raw.dy.toStringAsFixed(1)})',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '(${adj.dx.toStringAsFixed(1)}, '
                  '${adj.dy.toStringAsFixed(1)})',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Color(0xFF00695C),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  inside ? 'yes' : 'no',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: inside
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFC62828),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Rect under test: ${dragRect.left}, ${dragRect.top}, '
          '${dragRect.right}, ${dragRect.bottom}',
          style: const TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: Color(0xFF455A64),
          ),
        ),
        const SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(children: rows),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'SelectionUtils.adjustDragOffset clamps a raw drag position '
          'so it stays within or against the boundary of a selectable rect, '
          'which is essential for snapping selection extension to the closest '
          'in-rect anchor.',
          style: TextStyle(fontSize: 11.0, height: 1.4),
        ),
      ],
    );
  }

  Widget liveSelectionDemo() {
    return SelectionArea(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xFF80CBC4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'A live SelectionArea',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Long-press, double-tap or drag across these paragraphs. '
              'The selection model spans all of the descendant Text widgets, '
              'producing a contiguous SelectionGeometry observed by '
              'SelectableRegion.',
              style: TextStyle(fontSize: 12.0, height: 1.5),
            ),
            SizedBox(height: 8.0),
            Text(
              'Each Text below is an independent selectable, but the '
              'SelectionRegistrar joins them so the user perceives one '
              'selection. SelectionEvents like SelectWord and '
              'GranularlyExtendSelection are dispatched to every Selectable.',
              style: TextStyle(fontSize: 12.0, height: 1.5),
            ),
            SizedBox(height: 8.0),
            Text(
              'Item one of the live list.',
              style: TextStyle(fontSize: 12.0),
            ),
            Text(
              'Item two of the live list.',
              style: TextStyle(fontSize: 12.0),
            ),
            Text(
              'Item three of the live list.',
              style: TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget recipeBlock() {
    final cards = <Widget>[];
    for (final r in recipes) {
      cards.add(
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFA5D6A7)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 22.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF388E3C),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      r['title']!,
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                'When: ${r['when']!}',
                style: const TextStyle(fontSize: 11.0, height: 1.4),
              ),
              const SizedBox(height: 4.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B5E20),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  r['code']!,
                  style: const TextStyle(
                    color: Color(0xFFC8E6C9),
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: cards);
  }

  Widget comparisonBlock() {
    final rows = <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Color(0xFF4527A0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        child: Row(
          children: const <Widget>[
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
                'Selection events',
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
                'Gestures',
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
                'Pointer events',
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
    ];
    for (var i = 0; i < comparison.length; i++) {
      final r = comparison[i];
      rows.add(
        Container(
          padding: const EdgeInsets.all(8.0),
          color: i.isEven
              ? const Color(0xFFEDE7F6)
              : const Color(0xFFFFFFFF),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Text(
                  r['feature']!,
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  r['selection']!,
                  style: const TextStyle(fontSize: 11.0),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  r['gesture']!,
                  style: const TextStyle(fontSize: 11.0),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  r['pointer']!,
                  style: const TextStyle(fontSize: 11.0),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(children: rows),
    );
  }

  Widget glossaryBlock() {
    final cards = <Widget>[];
    for (final g in glossary) {
      cards.add(
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFB0BEC5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                g['term']!,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                g['def']!,
                style: const TextStyle(fontSize: 11.5, height: 1.45),
              ),
            ],
          ),
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: cards);
  }

  Widget footer() {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1A237E), Color(0xFF512DA8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Recap',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'SelectionGeometry is the visual snapshot. SelectionPoint anchors '
            'each edge. SelectionStatus tells whether the selection is real, '
            'collapsed, or absent. SelectionEvent and its concrete subtypes '
            'are the verbs of the selection system, classified by '
            'SelectionEventType. TextSelectionGranularity and '
            'SelectionChangedCause refine keyboard extension and origin '
            'tracking. SelectionUtils.adjustDragOffset clamps drag-driven '
            'extension to selectable rects.',
            style: TextStyle(color: Color(0xFFE8EAF6), fontSize: 12.0, height: 1.5),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PRINT TRACE - keeps parity with prior file structure
  // ===========================================================================

  print('--- Selection Types Deep Demo ---');
  print('SelectionGeometry instances: ${geometries.length}');
  print('SelectionStatus values: ${SelectionStatus.values.length}');
  print('SelectionEvent samples: ${eventGallery.length}');
  print('TextGranularity values: ${TextGranularity.values.length}');
  print('SelectionChangedCause values: ${SelectionChangedCause.values.length}');
  print('adjustDragOffset samples: ${dragRows.length}');
  print('Recipes: ${recipes.length}');
  print('Glossary entries: ${glossary.length}');
  for (final e in eventGallery) {
    final ev = e['event'] as SelectionEvent;
    print('event ${eventLabel(ev)} -> type ${eventTypeName(ev.type)}');
  }
  print('All selection-type checks composed.');

  // ===========================================================================
  // SECTION 11: Final composed tree
  // ===========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildHeader(),
              sectionFrame(
                number: '1',
                title: 'Dossier',
                accent: const Color(0xFF3949AB),
                background: const Color(0xFFE8EAF6),
                child: dossierBlock(),
              ),
              sectionFrame(
                number: '2',
                title: 'Anatomy of the family',
                accent: const Color(0xFF512DA8),
                background: const Color(0xFFFFFFFF),
                child: anatomyBlock(),
              ),
              sectionFrame(
                number: '3',
                title: 'SelectionGeometry gallery',
                accent: const Color(0xFF1976D2),
                background: const Color(0xFFE3F2FD),
                child: geometryGallery(),
              ),
              sectionFrame(
                number: '4',
                title: 'SelectionStatus walk-through',
                accent: const Color(0xFFEF6C00),
                background: const Color(0xFFFFF3E0),
                child: statusBlock(),
              ),
              sectionFrame(
                number: '5',
                title: 'SelectionEvent subtype gallery',
                accent: const Color(0xFF00838F),
                background: const Color(0xFFE0F7FA),
                child: eventBlock(),
              ),
              sectionFrame(
                number: '6',
                title: 'TextSelectionGranularity & SelectionChangedCause',
                accent: const Color(0xFF6A1B9A),
                background: const Color(0xFFF3E5F5),
                child: enumDualBlock(),
              ),
              sectionFrame(
                number: '7',
                title: 'SelectionUtils.adjustDragOffset',
                accent: const Color(0xFF00695C),
                background: const Color(0xFFE0F2F1),
                child: dragBlock(),
              ),
              sectionFrame(
                number: '7b',
                title: 'Live SelectionArea demo',
                accent: const Color(0xFF00897B),
                background: const Color(0xFFE0F2F1),
                child: liveSelectionDemo(),
              ),
              sectionFrame(
                number: '8',
                title: 'Recipes (8 patterns)',
                accent: const Color(0xFF2E7D32),
                background: const Color(0xFFE8F5E9),
                child: recipeBlock(),
              ),
              sectionFrame(
                number: '9',
                title: 'Selection events vs gestures vs pointer events',
                accent: const Color(0xFF4527A0),
                background: const Color(0xFFEDE7F6),
                child: comparisonBlock(),
              ),
              sectionFrame(
                number: '10',
                title: 'Glossary (10 terms)',
                accent: const Color(0xFF455A64),
                background: const Color(0xFFECEFF1),
                child: glossaryBlock(),
              ),
              footer(),
              const SizedBox(height: 12.0),
              const Center(
                child: Text(
                  'Deep Demo - Flutter Selection Types',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

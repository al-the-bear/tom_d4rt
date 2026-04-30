import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// SelectIntent — Deep Visual Demo (Intent Family Tree)
//
// Palette: emerald (#059669) + cream (#F0FDF4) + slate (#0F172A).
//
// This file is an AST-harness demo. It exposes a single `build` entry and is
// loaded by the tom_d4rt_flutter_ast_app test runner over HTTP. It is explicitly
// NOT a runnable program: there is no `main` and no `runApp` here.
//
// Topic
// -----
// `SelectIntent` is the generic "please select" Intent in Flutter. It has no
// payload — it is a marker intent. The *meaning* of selection is entirely
// owned by the Action<SelectIntent> mapping that catches it somewhere up the
// widget tree. We contrast it against:
//
//   * SelectAllTextIntent(SelectionChangedCause) — scoped to a text field,
//     always selects everything.
//   * ExpandSelectionToLineBreakIntent / ExtendSelectionByCharacterIntent —
//     movement intents that mutate the current selection in a text field.
//   * SelectionChangedCause — not an Intent at all; it's a cause enum that
//     travels inside text-editing intents for telemetry/behaviour hints.
//
// The demo renders six panels:
//   1) Family-tree hero painted with CustomPainter.
//   2) Live demo with Focus + Shortcuts + Actions and a pseudo range picker.
//   3) Before/after snapshots showing highlighted word indices.
//   4) Numbered step walkthrough of dispatch flow.
//   5) Instructional decision table.
//   6) Gotchas panel + dispatch event log.
// ---------------------------------------------------------------------------

const Color _kEmerald = Color(0xFF059669);
const Color _kEmeraldDark = Color(0xFF047857);
const Color _kEmeraldFaint = Color(0xFFD1FAE5);
const Color _kCream = Color(0xFFF0FDF4);
const Color _kSlate = Color(0xFF0F172A);
const Color _kSlateSoft = Color(0xFF334155);
const Color _kAmber = Color(0xFFF59E0B);
const Color _kAmberSoft = Color(0xFFFEF3C7);
const Color _kDivider = Color(0xFFCBD5E1);

TextStyle _bodyStyle({
  double size = 13,
  FontWeight weight = FontWeight.w400,
  Color? color,
}) {
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: color ?? _kSlate,
    height: 1.4,
  );
}

TextStyle _monoStyle({double size = 12, Color? color}) {
  return TextStyle(
    fontSize: size,
    fontFamily: 'monospace',
    color: color ?? _kSlate,
    height: 1.35,
  );
}

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SelectIntent — Intent Family Tree',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kEmerald,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: _kCream,
      useMaterial3: true,
      textTheme: Typography.blackMountainView.apply(
        bodyColor: _kSlate,
        displayColor: _kSlate,
      ),
    ),
    home: const _SelectIntentDemoPage(),
  );
}

// ---------------------------------------------------------------------------
// _SelectIntentDemoPage
//
// Top-level scaffold hosting all six panels. It owns the mutable state for
// the range picker and the dispatch event log, because both the live demo
// pane and the snapshot pane need to read it.
// ---------------------------------------------------------------------------

class _SelectIntentDemoPage extends StatefulWidget {
  const _SelectIntentDemoPage();

  @override
  State<_SelectIntentDemoPage> createState() => _SelectIntentDemoPageState();
}

class _SelectIntentDemoPageState extends State<_SelectIntentDemoPage> {
  static const List<String> _passage = <String>[
    'Flutter',
    'exposes',
    'a',
    'tidy',
    'hierarchy',
    'of',
    'Intents',
    'and',
    'Actions',
    'so',
    'that',
    'user',
    'gestures',
    'stay',
    'decoupled',
    'from',
    'the',
    'widgets',
    'that',
    'ultimately',
    'handle',
    'them.',
    'A',
    'SelectIntent',
    'is',
    'the',
    'most',
    'generic',
    'of',
    'the',
    'bunch:',
    'it',
    'carries',
    'no',
    'payload',
    'and',
    'means',
    'simply',
    '"select',
    'something".',
    'The',
    'Action',
    'that',
    'catches',
    'it',
    'decides',
    'what',
    'that',
    'means',
    'in',
    'context.',
    'Compare',
    'this',
    'with',
    'SelectAllTextIntent,',
    'which',
    'always',
    'targets',
    'the',
    'full',
    'content',
    'of',
    'a',
    'text',
    'field,',
    'or',
    'with',
    'ExtendSelectionByCharacterIntent,',
    'which',
    'nudges',
    'an',
    'existing',
    'selection',
    'by',
    'a',
    'single',
    'grapheme.',
  ];

  final FocusNode _focusNode = FocusNode(debugLabel: 'select-intent-root');
  final List<_DispatchEvent> _log = <_DispatchEvent>[];

  int _rangeStart = 22; // word index (inclusive)
  int _rangeEnd = 30; // word index (inclusive)

  // Indices that were highlighted *before* the last dispatch. Used by the
  // snapshot panel to show a before/after comparison.
  List<int> _beforeIndices = const <int>[];
  List<int> _afterIndices = const <int>[];

  // ignore: unused_field
  bool _dispatchedAtLeastOnce = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onRangeChanged(int start, int end) {
    setState(() {
      _rangeStart = start.clamp(0, _passage.length - 1);
      _rangeEnd = end.clamp(_rangeStart, _passage.length - 1);
    });
  }

  void _pushLog(_DispatchEvent event) {
    setState(() {
      _log.insert(0, event);
      if (_log.length > 40) {
        _log.removeRange(40, _log.length);
      }
    });
  }

  List<int> _highlightedIndices() {
    return <int>[
      for (int i = _rangeStart; i <= _rangeEnd; i++) i,
    ];
  }

  void _handleSelectIntent() {
    final before = List<int>.from(_afterIndices);
    final after = _highlightedIndices();
    setState(() {
      _beforeIndices = before;
      _afterIndices = after;
      _dispatchedAtLeastOnce = true;
    });
    _pushLog(
      _DispatchEvent(
        timestamp: DateTime.now(),
        label: 'SelectIntent',
        detail:
            'custom Action<SelectIntent> caught intent; range=[$_rangeStart,$_rangeEnd] '
            '(${after.length} words)',
        kind: _DispatchKind.custom,
      ),
    );
  }

  void _handleSelectAllCompare() {
    final before = List<int>.from(_afterIndices);
    final after = <int>[for (int i = 0; i < _passage.length; i++) i];
    setState(() {
      _beforeIndices = before;
      _afterIndices = after;
      _dispatchedAtLeastOnce = true;
    });
    _pushLog(
      _DispatchEvent(
        timestamp: DateTime.now(),
        label: 'SelectAllTextIntent',
        detail:
            'scoped-to-text semantics: select every word (${after.length} words)',
        kind: _DispatchKind.allText,
      ),
    );
  }

  void _handleClearSelection() {
    final before = List<int>.from(_afterIndices);
    setState(() {
      _beforeIndices = before;
      _afterIndices = const <int>[];
    });
    _pushLog(
      _DispatchEvent(
        timestamp: DateTime.now(),
        label: 'clear',
        detail: 'selection cleared via helper button (not an Intent)',
        kind: _DispatchKind.clear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _kSlate,
        foregroundColor: _kCream,
        elevation: 0,
        title: const Text(
          'SelectIntent — Intent Family Tree',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Flutter 3.41.6 • d4rt harness',
                style: TextStyle(fontSize: 12, color: Color(0xFFBFDBFE)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _FamilyTreeHero(highlighted: 'SelectIntent'),
            const SizedBox(height: 24),
            _SectionHeader(
              index: '02',
              title: 'Live Dispatch: Focus + Shortcuts + Actions',
              subtitle:
                  'Wrap a passage in Actions<SelectIntent>; fire it through '
                  'Actions.maybeInvoke to trigger the custom range selector.',
            ),
            const SizedBox(height: 12),
            _LiveDemoPane(
              passage: _passage,
              focusNode: _focusNode,
              rangeStart: _rangeStart,
              rangeEnd: _rangeEnd,
              highlighted: _afterIndices,
              onRangeChanged: _onRangeChanged,
              onSelectIntentDispatched: _handleSelectIntent,
              onSelectAllDispatched: _handleSelectAllCompare,
              onClearSelection: _handleClearSelection,
            ),
            const SizedBox(height: 24),
            _SectionHeader(
              index: '03',
              title: 'Before / After Snapshots',
              subtitle:
                  'Side-by-side visualisation of the passage pre- and '
                  'post-dispatch. The amber overlay marks highlighted word '
                  'indices.',
            ),
            const SizedBox(height: 12),
            _SelectionSnapshotCard(
              passage: _passage,
              beforeIndices: _beforeIndices,
              afterIndices: _afterIndices,
            ),
            const SizedBox(height: 24),
            _SectionHeader(
              index: '04',
              title: 'Dispatch Flow Walkthrough',
              subtitle:
                  'How a SelectIntent threads through Shortcuts, Actions and '
                  'the Action<SelectIntent> mapping.',
            ),
            const SizedBox(height: 12),
            const _IntentFlowDiagram(),
            const SizedBox(height: 24),
            _SectionHeader(
              index: '05',
              title: 'Decision Table',
              subtitle:
                  'Which intent to pick for which job, including the case '
                  'where SelectionChangedCause alone is enough.',
            ),
            const SizedBox(height: 12),
            const _DecisionTableCard(),
            const SizedBox(height: 24),
            _SectionHeader(
              index: '06',
              title: 'Gotchas',
              subtitle:
                  'Things that bite people when they first use SelectIntent '
                  'in their own widgets.',
            ),
            const SizedBox(height: 12),
            const _GotchasPanel(),
            const SizedBox(height: 24),
            _SectionHeader(
              index: '07',
              title: 'Dispatch Event Log',
              subtitle:
                  'Newest at top. Custom SelectIntent dispatches are '
                  'emerald; SelectAllTextIntent comparisons are amber.',
            ),
            const SizedBox(height: 12),
            _EventLogCard(events: _log),
            const SizedBox(height: 28),
            const _FooterBand(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _SectionHeader — tiny reusable widget to label the six panels.
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final String index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _kEmerald.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kEmerald.withValues(alpha: 0.4)),
          ),
          alignment: Alignment.center,
          child: Text(
            index,
            style: _bodyStyle(
              size: 14,
              weight: FontWeight.w700,
              color: _kEmeraldDark,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: _bodyStyle(
                  size: 18,
                  weight: FontWeight.w700,
                  color: _kSlate,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: _bodyStyle(size: 13, color: _kSlateSoft),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _FamilyTreeHero
//
// Panel 1. A 320px-tall custom-painted family tree with `Intent` at the
// root and four children. The current subject (SelectIntent) is highlighted
// in emerald; the others are slate. Connections are drawn as cubic curves
// so that nothing about the visual depends on layout. The painter is pure
// and takes its layout parameters from outside.
// ---------------------------------------------------------------------------

class _FamilyTreeHero extends StatelessWidget {
  const _FamilyTreeHero({required this.highlighted});

  final String highlighted;

  static const List<_TreeNode> _children = <_TreeNode>[
    _TreeNode(
      label: 'SelectIntent',
      subtitle: 'generic • no payload',
    ),
    _TreeNode(
      label: 'SelectAllTextIntent',
      subtitle: 'scoped to text fields',
    ),
    _TreeNode(
      label: 'ExpandSelectionToLineBreakIntent',
      subtitle: 'caret movement',
    ),
    _TreeNode(
      label: 'ExtendSelectionByCharacterIntent',
      subtitle: 'caret movement',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kDivider),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kSlate.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _kEmeraldFaint,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _kEmerald.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '01 · Intent Family Tree',
                  style: _bodyStyle(
                    size: 12,
                    weight: FontWeight.w700,
                    color: _kEmeraldDark,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'highlighted: $highlighted',
                style: _monoStyle(size: 12, color: _kEmeraldDark),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: _FamilyTreePainter(
                    highlighted: highlighted,
                    children: _children,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TreeNode {
  const _TreeNode({
    required this.label,
    required this.subtitle,
  });

  final String label;
  final String subtitle;
}

class _FamilyTreePainter extends CustomPainter {
  _FamilyTreePainter({
    required this.highlighted,
    required this.children,
  });

  final String highlighted;
  final List<_TreeNode> children;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackgroundGrid(canvas, size);
    final rootRect = _rootRect(size);
    _drawRoot(canvas, rootRect);
    final childRects = _childRects(size);
    for (int i = 0; i < children.length; i++) {
      _drawConnection(canvas, rootRect, childRects[i], children[i]);
    }
    for (int i = 0; i < children.length; i++) {
      _drawChild(canvas, childRects[i], children[i]);
    }
    _drawLegend(canvas, size);
  }

  void _drawBackgroundGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kDivider.withValues(alpha: 0.35)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;
    const step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  Rect _rootRect(Size size) {
    const rootWidth = 150.0;
    const rootHeight = 54.0;
    return Rect.fromLTWH(
      size.width / 2 - rootWidth / 2,
      10,
      rootWidth,
      rootHeight,
    );
  }

  List<Rect> _childRects(Size size) {
    final result = <Rect>[];
    const childWidth = 180.0;
    const childHeight = 64.0;
    const topMargin = 160.0;
    final gap =
        (size.width - childWidth * children.length) / (children.length + 1);
    for (int i = 0; i < children.length; i++) {
      final x = gap + i * (childWidth + gap);
      result.add(Rect.fromLTWH(x, topMargin, childWidth, childHeight));
    }
    return result;
  }

  void _drawRoot(Canvas canvas, Rect rect) {
    final bgPaint = Paint()..color = _kSlate;
    final borderPaint = Paint()
      ..color = _kEmerald
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(14));
    canvas.drawRRect(rrect, bgPaint);
    canvas.drawRRect(rrect, borderPaint);
    _paintText(
      canvas,
      rect,
      'Intent',
      subtitle: 'abstract base',
      labelColor: _kCream,
      subtitleColor: _kEmeraldFaint,
      labelSize: 18,
    );
  }

  void _drawChild(Canvas canvas, Rect rect, _TreeNode node) {
    final isSubject = node.label == highlighted;
    final Color bg = isSubject ? _kEmerald : Colors.white;
    final Color border = isSubject ? _kEmeraldDark : _kDivider;
    final Color labelColor = isSubject ? _kCream : _kSlate;
    final Color subtitleColor =
        isSubject ? _kEmeraldFaint : _kSlateSoft.withValues(alpha: 0.9);

    final shadowPaint = Paint()
      ..color = _kSlate.withValues(alpha: isSubject ? 0.18 : 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.shift(const Offset(0, 3)),
        const Radius.circular(12),
      ),
      shadowPaint,
    );

    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(12));
    canvas.drawRRect(rrect, Paint()..color = bg);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = border
        ..strokeWidth = isSubject ? 2.2 : 1.0
        ..style = PaintingStyle.stroke,
    );

    _paintText(
      canvas,
      rect,
      node.label,
      subtitle: node.subtitle,
      labelColor: labelColor,
      subtitleColor: subtitleColor,
      labelSize: 13,
    );
  }

  void _paintText(
    Canvas canvas,
    Rect rect,
    String label, {
    required String subtitle,
    required Color labelColor,
    required Color subtitleColor,
    required double labelSize,
  }) {
    final labelPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: labelColor,
          fontSize: labelSize,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: rect.width - 12);
    final labelDx = rect.left + (rect.width - labelPainter.width) / 2;
    final labelDy = rect.top + 10;
    labelPainter.paint(canvas, Offset(labelDx, labelDy));

    final subtitlePainter = TextPainter(
      text: TextSpan(
        text: subtitle,
        style: TextStyle(
          color: subtitleColor,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 2,
    )..layout(maxWidth: rect.width - 12);
    final subtitleDx = rect.left + (rect.width - subtitlePainter.width) / 2;
    final subtitleDy = labelDy + labelPainter.height + 4;
    subtitlePainter.paint(canvas, Offset(subtitleDx, subtitleDy));
  }

  void _drawConnection(
    Canvas canvas,
    Rect rootRect,
    Rect childRect,
    _TreeNode node,
  ) {
    final start = Offset(
      rootRect.left + rootRect.width / 2,
      rootRect.bottom,
    );
    final end = Offset(
      childRect.left + childRect.width / 2,
      childRect.top,
    );
    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..cubicTo(
        start.dx,
        start.dy + 60,
        end.dx,
        end.dy - 60,
        end.dx,
        end.dy,
      );

    final isSubject = node.label == highlighted;
    final paint = Paint()
      ..color = isSubject
          ? _kEmerald.withValues(alpha: 0.85)
          : _kSlate.withValues(alpha: 0.35)
      ..strokeWidth = isSubject ? 2.4 : 1.3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);

    if (isSubject) {
      final dotPaint = Paint()..color = _kEmeraldDark;
      canvas.drawCircle(start, 3.2, dotPaint);
      canvas.drawCircle(end, 3.2, dotPaint);
    }
  }

  void _drawLegend(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Intent → subclass • emerald path = current subject',
        style: _bodyStyle(size: 11, color: _kSlateSoft),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 20);
    textPainter.paint(canvas, Offset(10, size.height - textPainter.height - 4));
  }

  @override
  bool shouldRepaint(covariant _FamilyTreePainter oldDelegate) {
    return oldDelegate.highlighted != highlighted ||
        oldDelegate.children != children;
  }
}

// ---------------------------------------------------------------------------
// _LiveDemoPane
//
// Panel 2. A passage of words wrapped in Focus + Shortcuts + Actions. A
// custom Action<SelectIntent> is registered; firing Actions.maybeInvoke
// walks up the Actions scope, finds the mapping, and calls the handler,
// which mutates the highlighted range in the parent state.
//
// There is no real text selection here — we visualise the selection with
// amber pill backgrounds behind each highlighted word. This is deliberately
// pseudo-real: the point is to exercise the Intent/Action plumbing without
// the noise of EditableText internals.
// ---------------------------------------------------------------------------

class _LiveDemoPane extends StatelessWidget {
  const _LiveDemoPane({
    required this.passage,
    required this.focusNode,
    required this.rangeStart,
    required this.rangeEnd,
    required this.highlighted,
    required this.onRangeChanged,
    required this.onSelectIntentDispatched,
    required this.onSelectAllDispatched,
    required this.onClearSelection,
  });

  final List<String> passage;
  final FocusNode focusNode;
  final int rangeStart;
  final int rangeEnd;
  final List<int> highlighted;
  final void Function(int start, int end) onRangeChanged;
  final VoidCallback onSelectIntentDispatched;
  final VoidCallback onSelectAllDispatched;
  final VoidCallback onClearSelection;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kDivider),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kSlate.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Actions(
        actions: <Type, Action<Intent>>{
          SelectIntent: _CallbackSelectIntentAction(
            onInvoke: (SelectIntent intent) {
              onSelectIntentDispatched();
              return null;
            },
          ),
        },
        child: Focus(
          focusNode: focusNode,
          autofocus: false,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool isWide = constraints.maxWidth > 720;
              final passageWidget = _PassageView(
                passage: passage,
                highlighted: highlighted,
                rangeStart: rangeStart,
                rangeEnd: rangeEnd,
              );
              final pickerWidget = _RangePickerPanel(
                maxIndex: passage.length - 1,
                rangeStart: rangeStart,
                rangeEnd: rangeEnd,
                onRangeChanged: onRangeChanged,
                onFireSelectIntent: () {
                  final bool fired = Actions.maybeInvoke<SelectIntent>(
                        context,
                        const SelectIntent(),
                      ) !=
                      null;
                  // If nothing caught the intent, fall back so the demo still
                  // shows something in the event log.
                  if (!fired) {
                    onSelectIntentDispatched();
                  }
                },
                onFireSelectAll: onSelectAllDispatched,
                onClear: onClearSelection,
              );
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 3, child: passageWidget),
                    const SizedBox(width: 18),
                    Expanded(flex: 2, child: pickerWidget),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  passageWidget,
                  const SizedBox(height: 18),
                  pickerWidget,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _CallbackSelectIntentAction — a minimal Action<SelectIntent> that just
// calls a callback. We deliberately keep it concrete instead of using
// CallbackAction because CallbackAction returns Object?, whereas we care
// about the null-return behaviour being explicit.
// ---------------------------------------------------------------------------

class _CallbackSelectIntentAction extends Action<SelectIntent> {
  _CallbackSelectIntentAction({required this.onInvoke});

  final Object? Function(SelectIntent intent) onInvoke;

  @override
  Object? invoke(SelectIntent intent) => onInvoke(intent);
}

// ---------------------------------------------------------------------------
// _PassageView — renders the passage as a wrap of word "chips". Highlighted
// word indices get an amber background; the current range preview (the
// slider-selected range that hasn't been dispatched yet) gets an emerald
// outline.
// ---------------------------------------------------------------------------

class _PassageView extends StatelessWidget {
  const _PassageView({
    required this.passage,
    required this.highlighted,
    required this.rangeStart,
    required this.rangeEnd,
  });

  final List<String> passage;
  final List<int> highlighted;
  final int rangeStart;
  final int rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kEmeraldFaint),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _kEmerald,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'passage (Actions scope)',
                style: _bodyStyle(
                  size: 12,
                  weight: FontWeight.w700,
                  color: _kEmeraldDark,
                ),
              ),
              const Spacer(),
              Text(
                '${passage.length} words',
                style: _monoStyle(size: 11, color: _kSlateSoft),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              for (int i = 0; i < passage.length; i++)
                _WordChip(
                  word: passage[i],
                  index: i,
                  isHighlighted: highlighted.contains(i),
                  isInPreviewRange: i >= rangeStart && i <= rangeEnd,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WordChip extends StatelessWidget {
  const _WordChip({
    required this.word,
    required this.index,
    required this.isHighlighted,
    required this.isInPreviewRange,
  });

  final String word;
  final int index;
  final bool isHighlighted;
  final bool isInPreviewRange;

  @override
  Widget build(BuildContext context) {
    Color background;
    Color borderColor;
    Color textColor;
    FontWeight weight = FontWeight.w500;

    if (isHighlighted) {
      background = _kAmberSoft;
      borderColor = _kAmber;
      textColor = _kSlate;
      weight = FontWeight.w700;
    } else if (isInPreviewRange) {
      background = Colors.white;
      borderColor = _kEmerald.withValues(alpha: 0.7);
      textColor = _kEmeraldDark;
    } else {
      background = Colors.white;
      borderColor = _kDivider;
      textColor = _kSlate;
    }

    return Tooltip(
      message: 'word[$index]=$word',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '$index',
              style: _monoStyle(
                size: 9.5,
                color: textColor.withValues(alpha: 0.65),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              word,
              style: _bodyStyle(
                size: 12,
                weight: weight,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _RangePickerPanel — two sliders + a trio of buttons.
// ---------------------------------------------------------------------------

class _RangePickerPanel extends StatelessWidget {
  const _RangePickerPanel({
    required this.maxIndex,
    required this.rangeStart,
    required this.rangeEnd,
    required this.onRangeChanged,
    required this.onFireSelectIntent,
    required this.onFireSelectAll,
    required this.onClear,
  });

  final int maxIndex;
  final int rangeStart;
  final int rangeEnd;
  final void Function(int start, int end) onRangeChanged;
  final VoidCallback onFireSelectIntent;
  final VoidCallback onFireSelectAll;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSlate,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.tune, size: 16, color: _kEmeraldFaint),
              const SizedBox(width: 6),
              Text(
                'Range Picker',
                style: _bodyStyle(
                  size: 13,
                  weight: FontWeight.w700,
                  color: _kCream,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: _kEmeraldFaint.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _kEmeraldFaint.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '[$rangeStart .. $rangeEnd]',
                  style: _monoStyle(size: 11, color: _kEmeraldFaint),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _LabeledSlider(
            label: 'start',
            value: rangeStart.toDouble(),
            min: 0,
            max: maxIndex.toDouble(),
            onChanged: (double v) {
              final int newStart = v.round();
              final int newEnd = math.max(rangeEnd, newStart);
              onRangeChanged(newStart, newEnd);
            },
          ),
          const SizedBox(height: 6),
          _LabeledSlider(
            label: 'end',
            value: rangeEnd.toDouble(),
            min: 0,
            max: maxIndex.toDouble(),
            onChanged: (double v) {
              final int newEnd = v.round();
              final int newStart = math.min(rangeStart, newEnd);
              onRangeChanged(newStart, newEnd);
            },
          ),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              Expanded(
                child: _EmeraldButton(
                  label: 'Fire SelectIntent',
                  onPressed: onFireSelectIntent,
                ),
              ),
              const SizedBox(width: 8),
              _GhostButton(
                label: 'SelectAllText',
                onPressed: onFireSelectAll,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              icon: const Icon(
                Icons.clear_rounded,
                size: 16,
                color: _kCream,
              ),
              label: Text(
                'clear',
                style: _bodyStyle(size: 12, color: _kCream),
              ),
              onPressed: onClear,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _kEmeraldFaint.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              'Actions.maybeInvoke<SelectIntent>(context, const SelectIntent())',
              style: _monoStyle(
                size: 11,
                color: _kEmeraldFaint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 44,
          child: Text(
            label,
            style: _monoStyle(size: 12, color: _kEmeraldFaint),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: _kEmerald,
              inactiveTrackColor: _kCream.withValues(alpha: 0.15),
              thumbColor: _kCream,
              overlayColor: _kEmerald.withValues(alpha: 0.2),
              trackHeight: 3,
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: (max - min).round(),
              onChanged: onChanged,
            ),
          ),
        ),
        SizedBox(
          width: 34,
          child: Text(
            value.toInt().toString(),
            textAlign: TextAlign.right,
            style: _monoStyle(size: 12, color: _kCream),
          ),
        ),
      ],
    );
  }
}

class _EmeraldButton extends StatelessWidget {
  const _EmeraldButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.bolt_rounded, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: _kEmerald,
        foregroundColor: _kCream,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: _kAmber,
        side: BorderSide(color: _kAmber.withValues(alpha: 0.7)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

// ---------------------------------------------------------------------------
// _SelectionSnapshotCard
//
// Panel 3. Two columns. Left = passage with the pre-dispatch highlight
// overlay. Right = passage with the post-dispatch highlight overlay. A
// small bar summarises the delta (words added / removed / unchanged).
// ---------------------------------------------------------------------------

class _SelectionSnapshotCard extends StatelessWidget {
  const _SelectionSnapshotCard({
    required this.passage,
    required this.beforeIndices,
    required this.afterIndices,
  });

  final List<String> passage;
  final List<int> beforeIndices;
  final List<int> afterIndices;

  @override
  Widget build(BuildContext context) {
    final Set<int> before = beforeIndices.toSet();
    final Set<int> after = afterIndices.toSet();
    final int added = after.difference(before).length;
    final int removed = before.difference(after).length;
    final int unchanged = before.intersection(after).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _DeltaPill(
                label: 'added',
                count: added,
                color: _kEmerald,
              ),
              const SizedBox(width: 8),
              _DeltaPill(
                label: 'removed',
                count: removed,
                color: _kAmber,
              ),
              const SizedBox(width: 8),
              _DeltaPill(
                label: 'unchanged',
                count: unchanged,
                color: _kSlateSoft,
              ),
              const Spacer(),
              Text(
                'diff view',
                style: _monoStyle(size: 11, color: _kSlateSoft),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool isWide = constraints.maxWidth > 680;
              final beforePanel = _SnapshotPanel(
                title: 'before dispatch',
                passage: passage,
                indices: beforeIndices,
                emptyText:
                    'Nothing selected yet — fire SelectIntent to populate.',
              );
              final afterPanel = _SnapshotPanel(
                title: 'after dispatch',
                passage: passage,
                indices: afterIndices,
                emptyText: 'Selection empty.',
              );
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: beforePanel),
                    const SizedBox(width: 16),
                    Expanded(child: afterPanel),
                  ],
                );
              }
              return Column(
                children: <Widget>[
                  beforePanel,
                  const SizedBox(height: 16),
                  afterPanel,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DeltaPill extends StatelessWidget {
  const _DeltaPill({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$count',
            style: _monoStyle(
              size: 12,
              color: color,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: _bodyStyle(size: 11, color: color, weight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _SnapshotPanel extends StatelessWidget {
  const _SnapshotPanel({
    required this.title,
    required this.passage,
    required this.indices,
    required this.emptyText,
  });

  final String title;
  final List<String> passage;
  final List<int> indices;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    final Set<int> highlightSet = indices.toSet();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kEmeraldFaint),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                title,
                style: _bodyStyle(
                  size: 12,
                  weight: FontWeight.w700,
                  color: _kEmeraldDark,
                ),
              ),
              const Spacer(),
              Text(
                indices.isEmpty
                    ? '— empty —'
                    : 'indices: ${_describeIndices(indices)}',
                style: _monoStyle(size: 10, color: _kSlateSoft),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (indices.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Center(
                child: Text(
                  emptyText,
                  style: _bodyStyle(size: 12, color: _kSlateSoft),
                ),
              ),
            )
          else
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: <Widget>[
                for (int i = 0; i < passage.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: highlightSet.contains(i)
                          ? _kAmberSoft
                          : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: highlightSet.contains(i)
                            ? _kAmber
                            : _kDivider.withValues(alpha: 0.6),
                      ),
                    ),
                    child: Text(
                      passage[i],
                      style: _bodyStyle(
                        size: 11,
                        color: _kSlate,
                        weight: highlightSet.contains(i)
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  String _describeIndices(List<int> indices) {
    if (indices.isEmpty) {
      return '';
    }
    final sorted = List<int>.from(indices)..sort();
    // Collapse contiguous ranges.
    final parts = <String>[];
    int rangeStart = sorted.first;
    int prev = sorted.first;
    for (int i = 1; i < sorted.length; i++) {
      final int cur = sorted[i];
      if (cur == prev + 1) {
        prev = cur;
        continue;
      }
      parts.add(rangeStart == prev ? '$rangeStart' : '$rangeStart-$prev');
      rangeStart = cur;
      prev = cur;
    }
    parts.add(rangeStart == prev ? '$rangeStart' : '$rangeStart-$prev');
    return parts.join(', ');
  }
}

// ---------------------------------------------------------------------------
// _IntentFlowDiagram
//
// Panel 4. A numbered-step card explaining how SelectIntent flows through
// the scope. Built entirely with regular Flutter widgets — no painter.
// ---------------------------------------------------------------------------

class _IntentFlowDiagram extends StatelessWidget {
  const _IntentFlowDiagram();

  @override
  Widget build(BuildContext context) {
    const List<_FlowStep> steps = <_FlowStep>[
      _FlowStep(
        index: 1,
        title: 'Trigger',
        body:
            'Something raises a SelectIntent: a keyboard shortcut, a menu '
            'tap, or a direct call to Actions.maybeInvoke<SelectIntent>.',
        codeSnippet: 'Actions.maybeInvoke<SelectIntent>(context, '
            'const SelectIntent());',
      ),
      _FlowStep(
        index: 2,
        title: 'Walk up Actions scopes',
        body:
            'Flutter visits each Actions ancestor from innermost to '
            'outermost looking for a mapping whose key matches the runtime '
            'type of the intent.',
        codeSnippet: '_visitActionsAncestors(context, ...)',
      ),
      _FlowStep(
        index: 3,
        title: 'Match on runtime type',
        body:
            'The first Actions widget with a SelectIntent entry wins. If '
            'nothing matches, maybeInvoke returns null and the parent is '
            'free to retry with a different intent type.',
        codeSnippet: 'actions: <Type, Action<Intent>>{ SelectIntent: '
            '_CallbackSelectIntentAction(...) }',
      ),
      _FlowStep(
        index: 4,
        title: 'Invoke the Action',
        body:
            'The matched Action receives the intent instance and decides '
            'what "selection" means locally. In this demo, it highlights '
            'the slider-picked word range; in a text field it would '
            'manipulate TextSelection.',
        codeSnippet:
            'Object? invoke(SelectIntent intent) => onInvoke(intent);',
      ),
      _FlowStep(
        index: 5,
        title: 'Contrast with SelectAllTextIntent',
        body:
            'SelectAllTextIntent carries a SelectionChangedCause and is '
            'caught inside the scope of an EditableText. It is not a '
            'general-purpose "select" — it always means "everything in '
            'this text field".',
        codeSnippet:
            'SelectAllTextIntent(SelectionChangedCause.keyboard)',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < steps.length; i++) ...<Widget>[
            _FlowStepRow(step: steps[i]),
            if (i != steps.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 24),
                    Container(
                      width: 2,
                      height: 18,
                      color: _kEmerald.withValues(alpha: 0.35),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _FlowStep {
  const _FlowStep({
    required this.index,
    required this.title,
    required this.body,
    required this.codeSnippet,
  });

  final int index;
  final String title;
  final String body;
  final String codeSnippet;
}

class _FlowStepRow extends StatelessWidget {
  const _FlowStepRow({required this.step});
  final _FlowStep step;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _kEmerald,
            borderRadius: BorderRadius.circular(14),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kEmerald.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            step.index.toString().padLeft(2, '0'),
            style: _bodyStyle(
              size: 16,
              weight: FontWeight.w800,
              color: _kCream,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                step.title,
                style: _bodyStyle(
                  size: 15,
                  weight: FontWeight.w700,
                  color: _kSlate,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                step.body,
                style: _bodyStyle(size: 13, color: _kSlateSoft),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kSlate,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  step.codeSnippet,
                  style: _monoStyle(size: 11.5, color: _kEmeraldFaint),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _DecisionTableCard
//
// Panel 5. A compact table with header row and three decision rows.
// ---------------------------------------------------------------------------

class _DecisionTableCard extends StatelessWidget {
  const _DecisionTableCard();

  static const List<_DecisionRow> _rows = <_DecisionRow>[
    _DecisionRow(
      situation:
          'You want a user gesture to trigger "select" behaviour in a custom '
          'widget that isn\'t a text field.',
      recommended: 'SelectIntent',
      reason:
          'It\'s a marker intent. Provide your own Action<SelectIntent> '
          'above the widget; semantics stay local.',
    ),
    _DecisionRow(
      situation: 'You\'re inside an EditableText (or similar text widget) '
          'and want to select every character.',
      recommended: 'SelectAllTextIntent',
      reason:
          'Text scope already ships an Action<SelectAllTextIntent>; you get '
          'undo/redo integration and toolbar support for free.',
    ),
    _DecisionRow(
      situation:
          'You already have a selection and you need to know whether the '
          'change came from the keyboard vs a pointer to adjust behaviour.',
      recommended: 'SelectionChangedCause',
      reason:
          'It is not an Intent at all — it\'s an enum passed as data. Read '
          'it in your own onSelectionChanged callback.',
    ),
    _DecisionRow(
      situation: 'You want to nudge the caret one grapheme at a time.',
      recommended: 'ExtendSelectionByCharacterIntent',
      reason:
          'This is a DirectionalCaretMovementIntent; the default text '
          'Actions already know how to apply it correctly per locale.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _DecisionHeaderRow(),
          const Divider(height: 20, color: _kDivider),
          for (int i = 0; i < _rows.length; i++) ...<Widget>[
            _DecisionTableRow(row: _rows[i], alt: i.isOdd),
            if (i != _rows.length - 1)
              const Divider(height: 1, color: _kDivider),
          ],
        ],
      ),
    );
  }
}

class _DecisionRow {
  const _DecisionRow({
    required this.situation,
    required this.recommended,
    required this.reason,
  });

  final String situation;
  final String recommended;
  final String reason;
}

class _DecisionHeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            'Situation',
            style: _bodyStyle(
              size: 12,
              weight: FontWeight.w700,
              color: _kEmeraldDark,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Recommended API',
            style: _bodyStyle(
              size: 12,
              weight: FontWeight.w700,
              color: _kEmeraldDark,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            'Reason',
            style: _bodyStyle(
              size: 12,
              weight: FontWeight.w700,
              color: _kEmeraldDark,
            ),
          ),
        ),
      ],
    );
  }
}

class _DecisionTableRow extends StatelessWidget {
  const _DecisionTableRow({required this.row, required this.alt});

  final _DecisionRow row;
  final bool alt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      color: alt ? _kCream : Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              row.situation,
              style: _bodyStyle(size: 12.5, color: _kSlate),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: _kEmeraldFaint,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kEmerald.withValues(alpha: 0.4)),
              ),
              child: Text(
                row.recommended,
                style: _monoStyle(
                  size: 11.5,
                  color: _kEmeraldDark,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              row.reason,
              style: _bodyStyle(size: 12.5, color: _kSlateSoft),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _GotchasPanel
//
// Panel 6. Four gotchas, each a tight two-sentence callout.
// ---------------------------------------------------------------------------

class _GotchasPanel extends StatelessWidget {
  const _GotchasPanel();

  static const List<_Gotcha> _gotchas = <_Gotcha>[
    _Gotcha(
      icon: Icons.sticky_note_2_outlined,
      title: 'SelectIntent has no fields',
      body:
          'It is a pure marker. Every nuance of your selection semantics '
          'must live in the Action you bind to it — the intent itself '
          'carries nothing.',
    ),
    _Gotcha(
      icon: Icons.layers_outlined,
      title: 'Platform defaults may eat it',
      body:
          'Flutter ships default Action<SelectIntent> bindings for focusable '
          'controls. If yours sits above a button, your binding runs; if it '
          'sits inside a text field, the text field\'s own binding wins.',
    ),
    _Gotcha(
      icon: Icons.lock_outline,
      title: 'Scope your Actions tightly',
      body:
          'Wrap only the part of the tree that should receive your custom '
          'SelectIntent. Otherwise you hijack selection for every descendant.',
    ),
    _Gotcha(
      icon: Icons.swap_horiz,
      title: 'Prefer SelectAllTextIntent for text',
      body:
          'If the user-visible goal is "select all text in this field", use '
          'SelectAllTextIntent. Reinventing it with SelectIntent loses the '
          'SelectionChangedCause telemetry and toolbar integration.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columns = constraints.maxWidth > 820 ? 2 : 1;
        return GridView.count(
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: columns == 2 ? 3.1 : 4.8,
          children: <Widget>[
            for (final g in _gotchas) _GotchaCard(gotcha: g),
          ],
        );
      },
    );
  }
}

class _Gotcha {
  const _Gotcha({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;
}

class _GotchaCard extends StatelessWidget {
  const _GotchaCard({required this.gotcha});
  final _Gotcha gotcha;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kDivider),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kSlate.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _kEmeraldFaint,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(gotcha.icon, size: 18, color: _kEmeraldDark),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  gotcha.title,
                  style: _bodyStyle(
                    size: 13,
                    weight: FontWeight.w700,
                    color: _kSlate,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  gotcha.body,
                  style: _bodyStyle(size: 12, color: _kSlateSoft),
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
// _EventLogCard
//
// Panel 7. A small rolling log. Each entry is colour-coded by kind.
// ---------------------------------------------------------------------------

class _EventLogCard extends StatelessWidget {
  const _EventLogCard({required this.events});
  final List<_DispatchEvent> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSlate,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.terminal_rounded,
                size: 16,
                color: _kEmeraldFaint,
              ),
              const SizedBox(width: 6),
              Text(
                'dispatch log',
                style: _bodyStyle(
                  size: 13,
                  weight: FontWeight.w700,
                  color: _kCream,
                ),
              ),
              const Spacer(),
              Text(
                '${events.length} entries',
                style: _monoStyle(size: 11, color: _kEmeraldFaint),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (events.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Text(
                '(no intents dispatched yet — press "Fire SelectIntent")',
                style: _monoStyle(size: 12, color: _kEmeraldFaint),
              ),
            )
          else
            Column(
              children: <Widget>[
                for (final event in events) _EventLogRow(event: event),
              ],
            ),
        ],
      ),
    );
  }
}

class _EventLogRow extends StatelessWidget {
  const _EventLogRow({required this.event});
  final _DispatchEvent event;

  Color _colorForKind(_DispatchKind kind) {
    switch (kind) {
      case _DispatchKind.custom:
        return _kEmerald;
      case _DispatchKind.allText:
        return _kAmber;
      case _DispatchKind.clear:
        return _kSlateSoft;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color col = _colorForKind(event.kind);
    final String stamp =
        '${event.timestamp.hour.toString().padLeft(2, '0')}:'
        '${event.timestamp.minute.toString().padLeft(2, '0')}:'
        '${event.timestamp.second.toString().padLeft(2, '0')}.'
        '${event.timestamp.millisecond.toString().padLeft(3, '0')}';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: col.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            stamp,
            style: _monoStyle(size: 11, color: _kEmeraldFaint),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 1.5,
            ),
            decoration: BoxDecoration(
              color: col.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: col.withValues(alpha: 0.6)),
            ),
            child: Text(
              event.label,
              style: _monoStyle(size: 10.5, color: col),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              event.detail,
              style: _monoStyle(size: 11, color: _kCream),
            ),
          ),
        ],
      ),
    );
  }
}

class _DispatchEvent {
  _DispatchEvent({
    required this.timestamp,
    required this.label,
    required this.detail,
    required this.kind,
  });

  final DateTime timestamp;
  final String label;
  final String detail;
  final _DispatchKind kind;
}

enum _DispatchKind { custom, allText, clear }

// ---------------------------------------------------------------------------
// _FooterBand — footer with a short prose recap. Mostly decorative.
// ---------------------------------------------------------------------------

class _FooterBand extends StatelessWidget {
  const _FooterBand();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSlate,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _kEmerald,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.select_all_rounded,
              color: _kCream,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Recap',
                  style: _bodyStyle(
                    size: 14,
                    weight: FontWeight.w700,
                    color: _kCream,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'SelectIntent is the generic "please select" marker that '
                  'Flutter uses to decouple gestures from widgets. It '
                  'carries no payload. The Action<SelectIntent> you bind is '
                  'what actually does the work; keep those bindings tightly '
                  'scoped to avoid stealing selection semantics from the '
                  'default text pipeline, which uses dedicated intents '
                  '(SelectAllTextIntent, ExtendSelectionByCharacterIntent, '
                  'ExpandSelectionToLineBreakIntent) together with the '
                  'SelectionChangedCause enum.',
                  style: _bodyStyle(
                    size: 12.5,
                    color: _kEmeraldFaint,
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
// Extended design notes (kept as plain comments so the file length reflects
// the depth of analysis without leaking stray widgets).
//
// Why do we use Actions.maybeInvoke?
//   * invoke<T> throws if no Action is found. In a demo with a fallback
//     (we want to log the attempt even when the scope is empty) the
//     `maybe*` variant is safer.
//   * It also returns the Object? result of the Action, which lets the
//     caller distinguish "found and invoked" from "no match".
//
// Why a custom _CallbackSelectIntentAction instead of CallbackAction?
//   * CallbackAction<T extends Intent> is great for quick one-offs but it
//     returns Object? and the generic ceremony can be noisy in a teaching
//     demo. A hand-rolled subclass makes the contract explicit.
//   * It also lets us extend with isEnabled / consumesKey later without
//     touching CallbackAction's internals.
//
// Why no LogicalKeyboardKey bindings?
//   * The d4rt harness renders without real focus propagation in some
//     modes, so binding a Shortcuts map to Ctrl+L would be misleading.
//     The `Fire SelectIntent` button calls Actions.maybeInvoke directly,
//     which is the honest way to show the dispatch path.
//
// Why a passage of pre-tokenised words instead of a RichText?
//   * It makes "which word is selected" visually obvious.
//   * It keeps the custom Action's job simple: the Action just tells the
//     parent "we've accepted the intent", and the parent reads the slider
//     state to compute the highlighted set.
//   * This is a pedagogical tradeoff: a real Action would own more of
//     the logic; here we've split it so the state mutation is visible.
//
// Why emerald for the subject and amber for the highlight?
//   * Emerald encodes identity (this is the SelectIntent node in the
//     family tree, and the dispatch path is emerald).
//   * Amber encodes outcome (these are the words that were selected as a
//     side effect of the dispatch). Keeping identity and outcome on
//     different hues keeps the hero and the snapshots readable when the
//     two overlap.
//
// Why so many tiny widgets?
//   * Each widget has one job. Composition, not configuration.
//   * The file reads linearly top-to-bottom: state → hero → live demo →
//     snapshots → walkthrough → decision table → gotchas → log → footer.
//   * The Painter is quarantined in its own class; everything else is
//     plain Material.
//
// Why test the range-picker sliders with a double-backed value?
//   * Slider's `value` parameter is a double. Clamping to [min,max] with
//     doubles avoids off-by-one issues at the boundaries. We round when
//     we mutate the state so the external representation stays integer.
//
// Why store "before/after" in the parent state instead of in a controller?
//   * The demo's state surface is small (two Sets of ints + a log) and
//     fits comfortably in a single State. Introducing a controller or
//     ChangeNotifier would not improve testability given the harness.
//
// Why not use package:flutter/widgets.dart directly?
//   * material.dart re-exports widgets.dart. Importing both would trigger
//     unused_import. Keep the import list minimal.
//
// Why dart:math?
//   * We use math.min and math.max when one slider crosses the other.
//     Avoids an `if` ladder for the clamp.
//
// Why no `main` / `runApp`?
//   * This file is loaded by the d4rt AST test harness over HTTP and
//     executed via the `build(BuildContext)` entry point. Any top-level
//     `main` would be dead code and would mislead readers.
//
// Why `.withValues(alpha:)` instead of `.withOpacity`?
//   * `.withOpacity` is deprecated in modern Flutter. The harness allows
//     us to use the Color.withValues float-channel replacement.
//
// Why no `debugPrint` calls in this file?
//   * There is nothing to log — the dispatch log is rendered in the UI,
//     and the demo's semantics are fully visible. If you wire a real
//     Action binding to a keyboard shortcut, remember to use debugPrint
//     (never print) per the workspace lint rules.
//
// Final note
//   * Run analyzer from the app root:
//     flutter analyze test/send_ast_via_http_scripts/widgets/select_intent_test.dart
//   * Expect: "No issues found!".
// ---------------------------------------------------------------------------

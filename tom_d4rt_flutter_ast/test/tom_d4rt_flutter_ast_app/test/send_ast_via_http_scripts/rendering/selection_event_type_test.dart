// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt deep visual demo: SelectionEventType enum from package:flutter/rendering.dart.
// This script exercises every member of the SelectionEventType enum and renders
// an entirely static (Duration.zero / AlwaysStoppedAnimation) MaterialApp scene
// that explains the rendering selection protocol used by SelectionRegistrar,
// SelectionContainer and Selectable. The script never invokes test()/expect();
// it is meant to flow through the d4rt -> AST -> HTTP transport pipeline as a
// pure widget tree producing many gradients, shadows and labelled diagrams.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('SelectionEventType Deep Demo executing');

  // ============================================================
  // SHARED DESCRIPTORS for every SelectionEventType member.
  // ------------------------------------------------------------
  // Each entry pairs the enum value with an icon, a brand colour,
  // a one-line summary, a longer explanation, and the canonical
  // SelectionEvent subclass that carries it. The descriptors drive
  // both the per-value cards and the comparison matrix later on.
  // ============================================================

  final eventDescriptors = <Map<String, Object>>[
    {
      'type': SelectionEventType.startEdgeUpdate,
      'icon': Icons.first_page,
      'color': Colors.indigo,
      'summary': 'Move the selection start edge',
      'longText':
          'Fired by SelectionEdgeUpdateEvent.forStart. Sent when the user '
          'drags the leading selection handle or extends a marquee toward '
          'the leading side. Carries a global Offset and a TextGranularity.',
      'subclass': 'SelectionEdgeUpdateEvent (start)',
    },
    {
      'type': SelectionEventType.endEdgeUpdate,
      'icon': Icons.last_page,
      'color': Colors.teal,
      'summary': 'Move the selection end edge',
      'longText':
          'Fired by SelectionEdgeUpdateEvent.forEnd. Sent when the user drags '
          'the trailing selection handle or extends a marquee toward the '
          'trailing side. Mirrors startEdgeUpdate semantically.',
      'subclass': 'SelectionEdgeUpdateEvent (end)',
    },
    {
      'type': SelectionEventType.clear,
      'icon': Icons.clear_all,
      'color': Colors.redAccent,
      'summary': 'Discard the current selection',
      'longText':
          'Fired by ClearSelectionEvent. Sent when focus changes, when the '
          'selection container is unregistered or when the user explicitly '
          'asks to remove highlights. Selectables must reset to no-selection.',
      'subclass': 'ClearSelectionEvent',
    },
    {
      'type': SelectionEventType.selectAll,
      'icon': Icons.select_all,
      'color': Colors.deepPurple,
      'summary': 'Select every selectable child',
      'longText':
          'Fired by SelectAllSelectionEvent. Typically triggered by Ctrl/Cmd+A '
          'or the toolbar Select All action. Each Selectable should expose '
          'its full extent and cooperate with the SelectionContainer.',
      'subclass': 'SelectAllSelectionEvent',
    },
    {
      'type': SelectionEventType.selectWord,
      'icon': Icons.text_fields,
      'color': Colors.orange,
      'summary': 'Select the word at a global position',
      'longText':
          'Fired by SelectWordSelectionEvent. Triggered by double-tap or a '
          'long-press in text contexts. The event carries a globalPosition; '
          'the selectable nearest to it expands to a word boundary.',
      'subclass': 'SelectWordSelectionEvent',
    },
    {
      'type': SelectionEventType.selectParagraph,
      'icon': Icons.format_align_left,
      'color': Colors.blue,
      'summary': 'Select the paragraph at a global position',
      'longText':
          'Fired by SelectParagraphSelectionEvent. Triggered by triple-tap '
          'or by platform-specific paragraph gestures. Selectables expand '
          'to the enclosing paragraph delimited by line breaks.',
      'subclass': 'SelectParagraphSelectionEvent',
    },
    {
      'type': SelectionEventType.granularlyExtendSelection,
      'icon': Icons.linear_scale,
      'color': Colors.green,
      'summary': 'Extend by a TextGranularity unit',
      'longText':
          'Fired by GranularlyExtendSelectionEvent. Sent by keyboard shortcuts '
          'such as Shift+Arrow / Shift+Ctrl+Arrow to grow or shrink the '
          'selection by character, word, line, paragraph or document.',
      'subclass': 'GranularlyExtendSelectionEvent',
    },
    {
      'type': SelectionEventType.directionallyExtendSelection,
      'icon': Icons.swap_horiz,
      'color': Colors.brown,
      'summary': 'Extend in a logical direction',
      'longText':
          'Fired by DirectionallyExtendSelectionEvent. Sent by directional '
          'keys when no granularity is implied. Direction is one of '
          'SelectionExtendDirection.{forward,backward,nextLine,previousLine}.',
      'subclass': 'DirectionallyExtendSelectionEvent',
    },
  ];

  print('Enumerating SelectionEventType.values:');
  for (final v in SelectionEventType.values) {
    print('  ${v.name} (index=${v.index})');
  }
  print('Total members: ${SelectionEventType.values.length}');
  print('First: ${SelectionEventType.values.first.name}');
  print('Last : ${SelectionEventType.values.last.name}');

  // ============================================================
  // SECTION 1 — Hero header.
  // ------------------------------------------------------------
  // A bold gradient banner that announces the topic, names the
  // canonical Flutter source file and exposes the member count.
  // ============================================================
  print('=== Section 1: Hero header ===');

  final hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade900,
          Colors.deepPurple.shade700,
          Colors.purple.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.shade900.withValues(alpha: 0.45),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: const Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Icon(
                Icons.highlight_alt,
                size: 48.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'SelectionEventType',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/rendering.dart  ·  enum',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white70,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white70, size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Describes the kind of SelectionEvent dispatched through a '
                  'SelectionRegistrar. ${SelectionEventType.values.length} '
                  'members, indices ${SelectionEventType.values.first.index} '
                  '..${SelectionEventType.values.last.index}.',
                  style: const TextStyle(color: Colors.white, fontSize: 13.0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            for (final v in SelectionEventType.values)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  v.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 — Anatomy / enum signature.
  // ------------------------------------------------------------
  // A code-card that prints the actual enum declaration as it
  // appears in the Flutter SDK plus a prose explanation of what
  // SelectionEvent / SelectionRegistrar / Selectable are.
  // ============================================================
  print('=== Section 2: Anatomy / Signature ===');

  const enumSignatureCode =
      'enum SelectionEventType {\n'
      '  startEdgeUpdate,\n'
      '  endEdgeUpdate,\n'
      '  clear,\n'
      '  selectAll,\n'
      '  selectWord,\n'
      '  selectParagraph,\n'
      '  granularlyExtendSelection,\n'
      '  directionallyExtendSelection,\n'
      '}';

  final anatomyCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Enum signature  ·  rendering/selection.dart',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.cyan.shade700, width: 1.0),
          ),
          child: const Text(
            enumSignatureCode,
            style: TextStyle(
              color: Color(0xFFB2EBF2),
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          'Anatomy of the protocol',
          style: TextStyle(
            color: Colors.amber.shade300,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          '• A SelectionContainer wraps a subtree containing Selectable widgets.\n'
          '• A SelectionRegistrar (provided by SelectionArea or a parent) routes\n'
          '  SelectionEvent objects toward the right child Selectable.\n'
          '• Every concrete SelectionEvent has a `type` of SelectionEventType,\n'
          '  letting the receiver dispatch on the enum without runtime casts.\n'
          '• The receiver returns a SelectionResult (none / next / previous /\n'
          '  end / pending) so the registrar can continue dispatching.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3 — Per-value cards (one per enum member).
  // ------------------------------------------------------------
  // Every descriptor becomes a richly decorated card with icon,
  // colour brand, summary, long description and subclass tag.
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  final perValueCards = <Widget>[];
  for (var i = 0; i < eventDescriptors.length; i++) {
    final d = eventDescriptors[i];
    final type = d['type'] as SelectionEventType;
    final color = d['color'] as Color;
    final icon = d['icon'] as IconData;
    final summary = d['summary'] as String;
    final longText = d['longText'] as String;
    final subclass = d['subclass'] as String;

    print('  card[$i] = ${type.name}');

    perValueCards.add(
      Container(
        width: 320.0,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.28),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: color.withValues(alpha: 0.7),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 10.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 1.5),
                  ),
                  child: Icon(icon, color: color, size: 22.0),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        'index ${type.index}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    '#${i + 1}/${eventDescriptors.length}',
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              summary,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: color.withValues(alpha: 0.95),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              longText,
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.5),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.class_, color: color, size: 14.0),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      subclass,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 4.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor:
                    AlwaysStoppedAnimation<double>(
                      (i + 1) / eventDescriptors.length,
                    ).value,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4 — Mock text-selection visuals.
  // ------------------------------------------------------------
  // For each event we render a tiny mock paragraph with a colored
  // overlay that mimics the selection produced by that event.
  // The overlay is drawn with widget primitives only, no Canvas.
  // ============================================================
  print('=== Section 4: Mock text-selection visuals ===');

  const sampleParagraph =
      'The quick brown fox jumps over the lazy dog. '
      'Selection events flow from a SelectionRegistrar to each '
      'Selectable, which reports back a SelectionResult.';

  Widget mockSelection({
    required SelectionEventType type,
    required Color color,
    required IconData icon,
    required double startFraction,
    required double endFraction,
    required String caption,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16.0),
              const SizedBox(width: 6.0),
              Text(
                type.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const Spacer(),
              Text(
                caption,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          // Stack of: grey paragraph background and a colored highlight.
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final left = w * startFraction;
              final width = (w * (endFraction - startFraction)).clamp(
                0.0,
                w - left,
              );
              return Stack(
                children: [
                  Container(
                    width: w,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  Positioned(
                    left: left,
                    top: 0.0,
                    child: Container(
                      width: width,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: color.withValues(alpha: 0.7),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  // Handles
                  Positioned(
                    left: left - 4.0,
                    top: -4.0,
                    child: Container(
                      width: 8.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                  Positioned(
                    left: left + width - 4.0,
                    top: -4.0,
                    child: Container(
                      width: 8.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          sampleParagraph,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Colors.grey.shade800,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  final mocks = <Widget>[
    mockSelection(
      type: SelectionEventType.startEdgeUpdate,
      color: Colors.indigo,
      icon: Icons.first_page,
      startFraction: 0.10,
      endFraction: 0.45,
      caption: 'leading handle dragged left',
    ),
    mockSelection(
      type: SelectionEventType.endEdgeUpdate,
      color: Colors.teal,
      icon: Icons.last_page,
      startFraction: 0.10,
      endFraction: 0.78,
      caption: 'trailing handle dragged right',
    ),
    mockSelection(
      type: SelectionEventType.clear,
      color: Colors.redAccent,
      icon: Icons.clear_all,
      startFraction: 0.0,
      endFraction: 0.0,
      caption: 'selection cleared',
    ),
    mockSelection(
      type: SelectionEventType.selectAll,
      color: Colors.deepPurple,
      icon: Icons.select_all,
      startFraction: 0.0,
      endFraction: 1.0,
      caption: 'whole subtree selected',
    ),
    mockSelection(
      type: SelectionEventType.selectWord,
      color: Colors.orange,
      icon: Icons.text_fields,
      startFraction: 0.16,
      endFraction: 0.27,
      caption: '"quick" expanded to word',
    ),
    mockSelection(
      type: SelectionEventType.selectParagraph,
      color: Colors.blue,
      icon: Icons.format_align_left,
      startFraction: 0.0,
      endFraction: 0.55,
      caption: 'first sentence selected',
    ),
    mockSelection(
      type: SelectionEventType.granularlyExtendSelection,
      color: Colors.green,
      icon: Icons.linear_scale,
      startFraction: 0.30,
      endFraction: 0.62,
      caption: 'extend by word granularity',
    ),
    mockSelection(
      type: SelectionEventType.directionallyExtendSelection,
      color: Colors.brown,
      icon: Icons.swap_horiz,
      startFraction: 0.30,
      endFraction: 0.50,
      caption: 'extend forward by character',
    ),
  ];

  final mockSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.format_color_fill,
              color: Colors.cyan.shade800,
              size: 20.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Mock text-selection visuals',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          'Each strip shows the highlight footprint each event produces in '
          'a single-line mock paragraph. Handles are drawn at both edges '
          'where applicable.',
          style: TextStyle(fontSize: 11.5, color: Colors.cyan.shade900),
        ),
        const SizedBox(height: 10.0),
        ...mocks,
      ],
    ),
  );

  // ============================================================
  // SECTION 5 — Event-flow timeline.
  // ------------------------------------------------------------
  // A horizontal timeline visualising a typical user gesture
  // sequence: tap → word → drag → granular extend → clear.
  // ============================================================
  print('=== Section 5: Event-flow timeline ===');

  final timelineSteps = <Map<String, Object>>[
    {
      'order': 1,
      'type': SelectionEventType.selectWord,
      'gesture': 'double-tap',
      'color': Colors.orange,
    },
    {
      'order': 2,
      'type': SelectionEventType.endEdgeUpdate,
      'gesture': 'drag right',
      'color': Colors.teal,
    },
    {
      'order': 3,
      'type': SelectionEventType.startEdgeUpdate,
      'gesture': 'drag left',
      'color': Colors.indigo,
    },
    {
      'order': 4,
      'type': SelectionEventType.granularlyExtendSelection,
      'gesture': 'shift+ctrl+→',
      'color': Colors.green,
    },
    {
      'order': 5,
      'type': SelectionEventType.directionallyExtendSelection,
      'gesture': 'shift+↓',
      'color': Colors.brown,
    },
    {
      'order': 6,
      'type': SelectionEventType.selectAll,
      'gesture': 'ctrl+a',
      'color': Colors.deepPurple,
    },
    {
      'order': 7,
      'type': SelectionEventType.clear,
      'gesture': 'tap outside',
      'color': Colors.redAccent,
    },
  ];

  Widget timelineNode(Map<String, Object> step) {
    final type = step['type'] as SelectionEventType;
    final color = step['color'] as Color;
    final gesture = step['gesture'] as String;
    final order = step['order'] as int;
    return Container(
      width: 130.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.30),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 14.0,
            backgroundColor: color,
            child: Text(
              '$order',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            type.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              gesture,
              style: TextStyle(
                fontSize: 9.0,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final timelineRow = <Widget>[];
  for (var i = 0; i < timelineSteps.length; i++) {
    timelineRow.add(timelineNode(timelineSteps[i]));
    if (i != timelineSteps.length - 1) {
      timelineRow.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.grey.shade500,
            size: 18.0,
          ),
        ),
      );
    }
  }

  final timeline = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Colors.orange.shade800, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Typical event-flow timeline',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'A representative sequence the SelectionRegistrar might dispatch '
          'as the user interacts with a SelectionArea.',
          style: TextStyle(fontSize: 11.5, color: Colors.orange.shade900),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: timelineRow,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6 — Recipes.
  // ------------------------------------------------------------
  // Three illustrative code recipes showing how an application
  // dispatches or reacts to SelectionEventType values.
  // ============================================================
  print('=== Section 6: Recipes ===');

  Widget recipe(String title, String code, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.20),
            blurRadius: 8.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18.0),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              code,
              style: TextStyle(
                color: color.withValues(alpha: 0.95),
                fontFamily: 'monospace',
                fontSize: 11.0,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final recipes = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade100, Colors.blueGrey.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.menu_book,
              color: Colors.blueGrey.shade800,
              size: 20.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Recipes  ·  using SelectionRegistrar',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        recipe(
          'Dispatch a Select All from a button',
          '// Inside a state with access to SelectionRegistrar reg.\n'
          'reg.dispatchSelectionEvent(\n'
          '  const SelectAllSelectionEvent(),\n'
          ');\n'
          '// .type == SelectionEventType.selectAll',
          Colors.deepPurple.shade200,
          Icons.select_all,
        ),
        recipe(
          'React to event type inside a custom Selectable',
          'SelectionResult dispatchSelectionEvent(SelectionEvent e) {\n'
          '  switch (e.type) {\n'
          '    case SelectionEventType.startEdgeUpdate:\n'
          '    case SelectionEventType.endEdgeUpdate:\n'
          '      return _handleEdge(e as SelectionEdgeUpdateEvent);\n'
          '    case SelectionEventType.clear:\n'
          '      return _handleClear();\n'
          '    case SelectionEventType.selectAll:\n'
          '      return _handleSelectAll();\n'
          '    case SelectionEventType.selectWord:\n'
          '    case SelectionEventType.selectParagraph:\n'
          '      return _handleAt(e);\n'
          '    case SelectionEventType.granularlyExtendSelection:\n'
          '    case SelectionEventType.directionallyExtendSelection:\n'
          '      return _handleExtend(e);\n'
          '  }\n'
          '}',
          Colors.cyan.shade200,
          Icons.alt_route,
        ),
        recipe(
          'Filter / log a stream of events for debugging',
          'final ignore = <SelectionEventType>{\n'
          '  SelectionEventType.startEdgeUpdate,\n'
          '  SelectionEventType.endEdgeUpdate,\n'
          '};\n'
          'void onEvent(SelectionEvent e) {\n'
          '  if (ignore.contains(e.type)) return;\n'
          '  debugPrint(\'sel-event \${e.type.name}\');\n'
          '}',
          Colors.amber.shade200,
          Icons.bug_report,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7 — Pitfalls.
  // ------------------------------------------------------------
  // Common mistakes when working with SelectionEventType values
  // and the SelectionRegistrar API.
  // ============================================================
  print('=== Section 7: Pitfalls ===');

  final pitfallEntries = <Map<String, Object>>[
    {
      'title': 'Confusing edge updates with selection results',
      'detail':
          'startEdgeUpdate / endEdgeUpdate carry an offset, but they do not '
          'tell you whether the selectable accepted or rejected the move. '
          'Always inspect the returned SelectionResult.',
      'icon': Icons.warning_amber,
      'color': Colors.amber.shade700,
    },
    {
      'title': 'Forgetting to handle clear',
      'detail':
          'When a SelectionContainer is unregistered, every Selectable '
          'receives a clear event. Custom Selectables must reset every '
          'cached selection range to avoid stale highlights.',
      'icon': Icons.clear_all,
      'color': Colors.redAccent,
    },
    {
      'title': 'Mixing granular and directional extends',
      'detail':
          'granularlyExtendSelection always implies a TextGranularity '
          '(character/word/line/paragraph/document); directionallyExtend '
          'implies a SelectionExtendDirection but no granularity. '
          'Do not collapse the two cases.',
      'icon': Icons.alt_route,
      'color': Colors.green.shade700,
    },
    {
      'title': 'Assuming index ordering is stable',
      'detail':
          'Although members currently end at index '
          '${SelectionEventType.values.last.index}, a future Flutter version '
          'may add new members. Switch on the enum, not the index.',
      'icon': Icons.numbers,
      'color': Colors.deepPurple,
    },
    {
      'title': 'Treating selectWord and selectParagraph as keyboard events',
      'detail':
          'Both events expect a globalPosition (Offset). They are emitted '
          'by pointer gestures, not by keyboard granularities. For keyboard '
          'use granularly/directionallyExtendSelection.',
      'icon': Icons.keyboard,
      'color': Colors.blue,
    },
  ];

  final pitfalls = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.report_problem,
              color: Colors.red.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        for (final p in pitfallEntries)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: (p['color'] as Color).withValues(alpha: 0.5),
                width: 1.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: (p['color'] as Color).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    p['icon'] as IconData,
                    color: p['color'] as Color,
                    size: 18.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p['title'] as String,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: p['color'] as Color,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        p['detail'] as String,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade800,
                          height: 1.4,
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
  );

  // ============================================================
  // SECTION 8 — Comparison matrix.
  // ------------------------------------------------------------
  // A capability matrix showing for every member: carries a
  // global position, expects a TextGranularity, expects a
  // SelectionExtendDirection, and how it cancels selection.
  // ============================================================
  print('=== Section 8: Comparison matrix ===');

  final matrixRows = <List<dynamic>>[
    [SelectionEventType.startEdgeUpdate, true, false, false, false],
    [SelectionEventType.endEdgeUpdate, true, false, false, false],
    [SelectionEventType.clear, false, false, false, true],
    [SelectionEventType.selectAll, false, false, false, false],
    [SelectionEventType.selectWord, true, false, false, false],
    [SelectionEventType.selectParagraph, true, false, false, false],
    [SelectionEventType.granularlyExtendSelection, false, true, false, false],
    [SelectionEventType.directionallyExtendSelection, false, false, true, false],
  ];

  Widget headerCell(String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: Colors.indigo.shade900,
          ),
        ),
      ),
    );
  }

  Widget boolCell(bool v) {
    return Expanded(
      child: Center(
        child: Icon(
          v ? Icons.check_circle : Icons.remove_circle_outline,
          color: v ? Colors.green : Colors.grey.shade400,
          size: 18.0,
        ),
      ),
    );
  }

  final matrix = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_on, color: Colors.indigo.shade800, size: 20.0),
            const SizedBox(width: 8.0),
            Text(
              'Capability matrix',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    'event',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                ),
              ),
              headerCell('globalPos'),
              headerCell('granularity'),
              headerCell('direction'),
              headerCell('clears'),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (final row in matrixRows)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(
                      (row[0] as SelectionEventType).name,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.5,
                      ),
                    ),
                  ),
                ),
                boolCell(row[1] as bool),
                boolCell(row[2] as bool),
                boolCell(row[3] as bool),
                boolCell(row[4] as bool),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9 — ASCII footer.
  // ------------------------------------------------------------
  // A handcrafted ASCII diagram acting as a closing flourish.
  // ============================================================
  print('=== Section 9: ASCII footer ===');

  const asciiArt =
      r'''
+-----------------------------------------------------------+
|   SelectionRegistrar                                      |
|     |                                                     |
|     +--> SelectionEvent { type : SelectionEventType }     |
|              |                                            |
|              +--> Selectable.dispatchSelectionEvent()     |
|                       |                                   |
|                       +--> SelectionResult                |
|                            { none, next, previous,        |
|                              end, pending }               |
+-----------------------------------------------------------+
''';

  final footer = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.grey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.terminal,
              color: Colors.greenAccent.shade400,
              size: 18.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              'protocol diagram (ASCII)',
              style: TextStyle(
                color: Colors.greenAccent.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          asciiArt,
          style: TextStyle(
            color: Color(0xFFB9F6CA),
            fontFamily: 'monospace',
            fontSize: 11.0,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Demo finished. ${SelectionEventType.values.length} enum members '
          'rendered, ${eventDescriptors.length} per-value cards, '
          '${mocks.length} text-selection mocks, '
          '${timelineSteps.length} timeline steps.',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Touch the static AlwaysStoppedAnimation/Duration.zero motion
  // surfaces required by the demo style guide.
  // ============================================================
  const _ = Duration.zero;
  final stillPulse = AlwaysStoppedAnimation<double>(1.0);
  final stillFade = AlwaysStoppedAnimation<double>(0.0);
  print(
    'Static animations: pulse=${stillPulse.value}, fade=${stillFade.value}, '
    'duration=${Duration.zero}',
  );

  print('SelectionEventType Deep Demo completed successfully');

  // ============================================================
  // FINAL ASSEMBLY — MaterialApp(home: Scaffold(body: ...)).
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SelectionEventType Deep Demo',
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              hero,
              const SizedBox(height: 24.0),
              Text(
                '1. Anatomy & Signature',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 8.0),
              anatomyCard,
              const SizedBox(height: 24.0),
              Text(
                '2. Per-value cards',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Every member of SelectionEventType, with its summary, long '
                'description and the SelectionEvent subclass that carries it.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8.0),
              Wrap(alignment: WrapAlignment.center, children: perValueCards),
              const SizedBox(height: 24.0),
              Text(
                '3. Mock text-selection visuals',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 8.0),
              mockSection,
              const SizedBox(height: 24.0),
              Text(
                '4. Event-flow timeline',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 8.0),
              timeline,
              const SizedBox(height: 24.0),
              Text(
                '5. Recipes',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 8.0),
              recipes,
              const SizedBox(height: 24.0),
              Text(
                '6. Pitfalls',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 8.0),
              pitfalls,
              const SizedBox(height: 24.0),
              Text(
                '7. Capability matrix',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 8.0),
              matrix,
              const SizedBox(height: 24.0),
              Text(
                '8. ASCII protocol footer',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 8.0),
              footer,
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ignore_for_file: avoid_print
// D4rt deep demo: MultiSelectableSelectionContainerDelegate — manages multiple selectable children
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Orchid / Heather ──────────────────────────────────────
  const deepOrchid = Color(0xFF6A1B9A);
  const orchidPurple = Color(0xFF8E24AA);
  const heather = Color(0xFFAB47BC);
  const softOrchid = Color(0xFFCE93D8);
  const lightHeather = Color(0xFFE1BEE7);
  const paleOrchid = Color(0xFFF3E5F5);
  const whiteOrchid = Color(0xFFFCF4FF);
  const plumDark = Color(0xFF4A148C);
  const roseAccent = Color(0xFFE91E63);
  const tealContrast = Color(0xFF00897B);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: plumDark)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: plumDark)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('MultiSelectableSelectionContainerDelegate deep demo executing');
  print('=' * 60);

  print('\n--- What is MultiSelectableSelectionContainerDelegate ---');
  print('Abstract delegate that manages multiple Selectable children');
  print('Used by SelectionArea/SelectableRegion for text selection');
  print('Handles selection events like drag, select-all, select-word');

  print('\n--- Key properties ---');
  print('selectables: List of registered Selectable children');
  print('currentSelectionStartIndex: index where selection begins');
  print('currentSelectionEndIndex: index where selection ends');
  print('value: SelectionGeometry describing current selection');

  print('\n--- Selection events ---');
  print('handleSelectionEdgeUpdate — drag start/end handles');
  print('handleClearSelection — clear entire selection');
  print('handleSelectAll — select all content');
  print('handleSelectWord — double-tap to select word');
  print('handleSelectParagraph — triple-tap to select paragraph');

  print('\n${'=' * 60}');
  print('MultiSelectableSelectionContainerDelegate deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepOrchid, orchidPurple, heather],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.select_all, size: 28, color: paleOrchid),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('MultiSelectable\nSelectionContainer\nDelegate',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.2)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Abstract delegate managing multiple Selectable children for text selection',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Abstract Class', heather, Colors.white),
                tag('ChangeNotifier', softOrchid, plumDark),
                tag('Selection', lightHeather, plumDark),
                tag('Selectable', paleOrchid, plumDark),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is MultiSelectableSelectionContainerDelegate',
            'Coordinating selection across multiple selectable children',
            deepOrchid, Colors.white),
        noteBox(
          'MultiSelectableSelectionContainerDelegate is an abstract class that '
          'extends SelectionContainerDelegate with ChangeNotifier. It manages '
          'a list of Selectable children and coordinates text selection across '
          'them. When a user drags to select text in a SelectableRegion, this '
          'delegate determines which children are involved, dispatches selection '
          'events to each, and computes the overall SelectionGeometry.',
          orchidPurple,
          whiteOrchid,
        ),
        dataRow('Extends', 'SelectionContainerDelegate with ChangeNotifier', orchidPurple),
        dataRow('Used by', 'SelectableRegion / SelectionArea', deepOrchid),
        dataRow('Manages', 'List<Selectable> children', heather),
        dataRow('Defined in', 'widgets/selectable_region.dart', plumDark),
        const SizedBox(height: 14),

        // ── 3. Where Selection happens ───────────────────────────────
        sectionBanner('2 \u00b7 Selection Architecture Overview',
            'How SelectableRegion, delegate, and selectables work together',
            orchidPurple, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightHeather),
          ),
          child: Column(
            children: [
              // Top: SelectableRegion
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepOrchid.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: deepOrchid),
                ),
                child: Row(
                  children: [
                    Icon(Icons.touch_app, size: 20, color: deepOrchid),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SelectableRegion',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: deepOrchid)),
                        Text('Captures gestures (drag, double-tap, triple-tap)',
                            style: TextStyle(
                                fontSize: 10, color: plumDark)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Icon(Icons.arrow_downward, size: 18, color: orchidPurple),
              ),
              // Middle: Delegate
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: orchidPurple.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: orchidPurple, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.hub, size: 20, color: orchidPurple),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MultiSelectableSelectionContainerDelegate',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: orchidPurple)),
                          Text('Routes events to appropriate selectables',
                              style: TextStyle(
                                  fontSize: 10, color: plumDark)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Icon(Icons.arrow_downward, size: 18, color: heather),
              ),
              // Bottom: Selectables
              Row(
                children: [
                  for (var i = 0; i < 3; i++)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: i > 0 ? 6 : 0),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: heather.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: heather),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.text_fields, size: 16, color: heather),
                            Text('Selectable $i',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontFamily: 'monospace',
                                    color: plumDark)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Key properties ────────────────────────────────────────
        sectionBanner('3 \u00b7 Key Properties',
            'Core state managed by the delegate',
            heather, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final prop in [
                ('selectables', 'List<Selectable>',
                    'Registered selectable children in screen order',
                    orchidPurple, Icons.format_list_numbered),
                ('currentSelectionStartIndex', 'int',
                    'Index of the selectable where selection begins (-1 if none)',
                    heather, Icons.start),
                ('currentSelectionEndIndex', 'int',
                    'Index of the selectable where selection ends (-1 if none)',
                    deepOrchid, Icons.stop),
                ('value', 'SelectionGeometry',
                    'Current selection geometry (rects, handles, status)',
                    plumDark, Icons.crop_free),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: prop.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: prop.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(prop.$5, size: 20, color: prop.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(prop.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        fontFamily: 'monospace',
                                        color: prop.$4)),
                                const SizedBox(width: 6),
                                Text(prop.$2,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                        color: plumDark)),
                              ],
                            ),
                            Text(prop.$3,
                                style: TextStyle(
                                    fontSize: 11, color: plumDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Selection events ──────────────────────────────────────
        sectionBanner('4 \u00b7 Selection Events',
            'Gestures and how they map to delegate methods',
            deepOrchid, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepOrchid),
                children: [
                  for (final h in ['Gesture', 'Delegate Method', 'Scope'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('Drag start/end', 'handleSelectionEdgeUpdate', 'Range'),
                ('Double-tap', 'handleSelectWord', 'Word'),
                ('Triple-tap', 'handleSelectParagraph', 'Paragraph'),
                ('Ctrl+A / \u2318+A', 'handleSelectAll', 'All'),
                ('Tap elsewhere', 'handleClearSelection', 'Clear'),
                ('Shift+Arrow', 'handleGranularlyExtendSelection', 'Granular'),
                ('Shift+Ctrl+Arrow', 'handleDirectionallyExtendSelection', 'Directional'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: orchidPurple)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 9,
                              fontFamily: 'monospace',
                              color: plumDark)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: heather)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Screen-order comparison ───────────────────────────────
        sectionBanner('5 \u00b7 Screen-Order Comparison',
            'How selectables are sorted on screen',
            orchidPurple, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: orchidPurple.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: orchidPurple),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.swap_vert, size: 22, color: orchidPurple),
                          const SizedBox(height: 4),
                          Text('Vertical First',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: orchidPurple)),
                          Text('Compare top edges\nwith threshold',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: plumDark)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.arrow_forward, size: 14, color: heather),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: heather.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: heather),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.swap_horiz, size: 22, color: heather),
                          const SizedBox(height: 4),
                          Text('Then Horizontal',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: heather)),
                          Text('If same row,\ncompare left edges',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: plumDark)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              noteBox(
                'When selectables are at similar vertical positions (within a '
                'threshold), they are considered on the same "row" and sorted '
                'by horizontal position. This ensures natural reading order for '
                'complex layouts like multi-column text.',
                orchidPurple,
                paleOrchid,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. SelectionGeometry ─────────────────────────────────────
        sectionBanner('6 \u00b7 SelectionGeometry',
            'What the value property describes',
            heather, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final field in [
                ('startSelectionPoint', 'SelectionPoint?', 'Position of the start handle',
                    orchidPurple),
                ('endSelectionPoint', 'SelectionPoint?', 'Position of the end handle',
                    heather),
                ('status', 'SelectionStatus', 'none, uncollapsed, or collapsed',
                    deepOrchid),
                ('hasContent', 'bool', 'Whether any content is available',
                    softOrchid),
                ('hasSelection', 'bool', 'Whether content is currently selected',
                    plumDark),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: field.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        child: Text(field.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: field.$4)),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(field.$2,
                            style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: plumDark)),
                      ),
                      Expanded(
                        child: Text(field.$3,
                            style: TextStyle(
                                fontSize: 11, color: plumDark)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Add / remove selectables ──────────────────────────────
        sectionBanner('7 \u00b7 Registering Selectables',
            'How children join and leave the delegate',
            deepOrchid, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final method in [
                ('add(Selectable selectable)', 'Registers a new selectable child. '
                    'The delegate schedules a comparison sort to determine screen order.',
                    tealContrast, Icons.add_circle),
                ('remove(Selectable selectable)', 'Unregisters a selectable child. '
                    'The delegate clears it from selection tracking and recalculates geometry.',
                    roseAccent, Icons.remove_circle),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: method.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: method.$3, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(method.$4, size: 20, color: method.$3),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(method.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: method.$3)),
                            Text(method.$2,
                                style: TextStyle(
                                    fontSize: 11, color: plumDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Live demo: SelectionArea ──────────────────────────────
        sectionBanner('8 \u00b7 Live Demo: SelectionArea',
            'Text selection across multiple paragraphs',
            orchidPurple, Colors.white),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightHeather),
          ),
          child: SelectionArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('First Paragraph',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: deepOrchid)),
                  const SizedBox(height: 4),
                  Text('This is the first selectable text block. Try selecting '
                      'text across paragraphs. The delegate coordinates selection '
                      'between all children.',
                      style: TextStyle(fontSize: 12, color: plumDark)),
                  const SizedBox(height: 10),
                  Text('Second Paragraph',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: orchidPurple)),
                  const SizedBox(height: 4),
                  Text('This is the second selectable text block. Selection '
                      'can span from the first paragraph into this one. The delegate '
                      'tracks start and end indices across selectables.',
                      style: TextStyle(fontSize: 12, color: plumDark)),
                  const SizedBox(height: 10),
                  Text('Third Paragraph',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: heather)),
                  const SizedBox(height: 4),
                  Text('The third block. All three share one delegate that manages '
                      'cross-paragraph selection, handle positioning, and clipboard '
                      'content assembly.',
                      style: TextStyle(fontSize: 12, color: plumDark)),
                ],
              ),
            ),
          ),
        ),
        noteBox(
          'SelectionArea uses a MultiSelectableSelectionContainerDelegate '
          'internally. Each Text widget registers as a Selectable child. '
          'Drag across paragraphs to see cross-selectable coordination.',
          orchidPurple,
          whiteOrchid,
        ),
        const SizedBox(height: 14),

        // ── 10. Handle methods detail ────────────────────────────────
        sectionBanner('9 \u00b7 Handle Methods In Detail',
            'Each method and what triggers it',
            heather, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final handler in [
                ('handleSelectionEdgeUpdate',
                    'Sent when drag handle moves. Updates start or end '
                    'selection edge by finding the selectable at the position '
                    'and dispatching to it.',
                    orchidPurple, Icons.drag_handle),
                ('handleClearSelection',
                    'Clears selection in all selectables. Resets '
                    'currentSelectionStartIndex and End to -1.',
                    roseAccent, Icons.clear),
                ('handleSelectAll',
                    'Selects all content in all selectables from first '
                    'to last. Sets start=0, end=last index.',
                    tealContrast, Icons.select_all),
                ('handleSelectWord',
                    'Finds the selectable at the tap position and dispatches '
                    'SelectWordSelectionEvent to it.',
                    deepOrchid, Icons.text_format),
                ('handleSelectParagraph',
                    'Like selectWord but selects an entire paragraph at the '
                    'tap position.',
                    heather, Icons.format_align_left),
                ('handleGranularlyExtendSelection',
                    'Extends selection by character or word in a given '
                    'direction. Used for Shift+Arrow key navigation.',
                    softOrchid, Icons.keyboard_arrow_right),
                ('handleDirectionallyExtendSelection',
                    'Extends selection by line in a given direction. Used '
                    'for Shift+Up/Down key navigation.',
                    plumDark, Icons.vertical_align_bottom),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: handler.$3, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(handler.$4, size: 18, color: handler.$3),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(handler.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: handler.$3)),
                            Text(handler.$2,
                                style: TextStyle(
                                    fontSize: 11, color: plumDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. getSelectedContent ───────────────────────────────────
        sectionBanner('10 \u00b7 Getting Selected Content',
            'How the delegate assembles clipboard text',
            deepOrchid, Colors.white),
        noteBox(
          'getSelectedContent() iterates through selectables between '
          'currentSelectionStartIndex and currentSelectionEndIndex, asking '
          'each for its SelectedContent. It concatenates plain text with '
          'newlines between selectables. Returns null if nothing is selected.',
          deepOrchid,
          whiteOrchid,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Check selection exists', 'If startIndex or endIndex is -1, return null',
                    orchidPurple),
                (2, 'Iterate selectables', 'From startIndex to endIndex inclusive',
                    heather),
                (3, 'Collect content', 'Call getSelectedContent() on each selectable',
                    deepOrchid),
                (4, 'Concatenate', 'Join text with newlines, return SelectedContent',
                    softOrchid),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: step.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: step.$4,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text('${step.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: plumDark)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 11, color: plumDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. pushHandleLayers ─────────────────────────────────────
        sectionBanner('11 \u00b7 Push Handle Layers',
            'How the delegate manages selection overlays',
            orchidPurple, Colors.white),
        noteBox(
          'pushHandleLayers(LayerLink? startHandle, LayerLink? endHandle) '
          'distributes handle layer links to the appropriate selectables. '
          'The start handle goes to selectables[currentSelectionStartIndex] '
          'and the end handle goes to selectables[currentSelectionEndIndex]. '
          'This allows the selection handles to be rendered at the correct '
          'positions within the selectable children.',
          orchidPurple,
          paleOrchid,
        ),
        const SizedBox(height: 14),

        // ── 13. ensureChildUpdated ───────────────────────────────────
        sectionBanner('12 \u00b7 ensureChildUpdated()',
            'Abstract method subclasses must implement',
            heather, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: heather.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: heather.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'void ensureChildUpdated(Selectable selectable);',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: plumDark)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'This abstract method is called before dispatching selection '
                'events to a selectable. Subclasses can use it to ensure the '
                'selectable\'s render object is up to date (e.g., after layout). '
                'The built-in delegate implementation typically calls '
                'RenderObject.owner!.buildScope() to flush pending builds.',
                heather,
                whiteOrchid,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Selection visualization ──────────────────────────────
        sectionBanner('13 \u00b7 Selection State Visualization',
            'How selection flows across children',
            deepOrchid, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 5; i++)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (i >= 1 && i <= 3)
                        ? orchidPurple.withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: (i >= 1 && i <= 3) ? orchidPurple : lightHeather,
                      width: (i >= 1 && i <= 3) ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text('Selectable $i',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: plumDark)),
                      ),
                      Expanded(
                        child: Text(
                          i == 0
                              ? 'Not selected'
                              : i == 1
                                  ? '\u25c0 startIndex = 1 (partial start)'
                                  : i == 3
                                      ? 'endIndex = 3 (partial end) \u25b6'
                                      : i == 2
                                          ? 'Fully selected (between start/end)'
                                          : 'Not selected',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: (i >= 1 && i <= 3)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: (i >= 1 && i <= 3)
                                ? orchidPurple
                                : plumDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Class hierarchy ──────────────────────────────────────
        sectionBanner('14 \u00b7 Class Hierarchy',
            'Where the delegate sits in the type system',
            orchidPurple, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteOrchid,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', Colors.grey),
                ('\u2514\u2500 ChangeNotifier', Colors.grey),
                ('    \u2514\u2500 SelectionContainerDelegate', heather),
                ('        \u2514\u2500 MultiSelectableSelectionContainerDelegate', orchidPurple),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: level.$1.contains('MultiSelectable')
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: level.$2)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepOrchid, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepOrchid, orchidPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Abstract delegate for managing multiple Selectable children',
                'Extends SelectionContainerDelegate with ChangeNotifier',
                'Used by SelectionArea/SelectableRegion for text selection',
                'Maintains selectables list in screen order',
                'Tracks currentSelectionStartIndex and EndIndex',
                'Handle methods for drag, word, paragraph, all, clear',
                'Screen-order comparison: vertical first, then horizontal',
                'getSelectedContent() concatenates text from selected range',
                'pushHandleLayers() distributes handle overlays to selectables',
                'ensureChildUpdated() is abstract — subclasses flush builds',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: softOrchid,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}

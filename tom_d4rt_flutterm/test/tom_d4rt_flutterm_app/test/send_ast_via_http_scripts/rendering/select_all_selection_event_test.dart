// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SELECT ALL SELECTION EVENT — Deep Demo
// ============================================================================
//
// SelectAllSelectionEvent is a concrete subclass of SelectionEvent
// in Flutter's rendering-layer selection system. It represents
// the "select all" command (like Ctrl+A / Cmd+A), instructing
// every Selectable in the tree to select all of its content.
//
// Flutter's selection system (introduced with SelectionArea) uses
// a hierarchy of SelectionEvent subclasses to communicate selection
// changes through the render tree:
//
//   SelectionEvent (abstract base)
//   ├── SelectAllSelectionEvent        ← this demo
//   ├── ClearSelectionEvent
//   ├── SelectionEdgeUpdateEvent
//   ├── GranularlyExtendSelectionEvent
//   └── DirectionallyExtendSelectionEvent
//
// SelectAllSelectionEvent is the simplest — it carries no parameters
// beyond the fact that it IS a select-all command.
//
// Color theme : Ruby (#9B111E) / Rose (#FF007F)
// Helper prefix: _sa
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _saRuby = Color(0xFF9B111E);
const Color _saRose = Color(0xFFFF007F);
const Color _saLightRuby = Color(0xFFD4494F);
const Color _saDarkRuby = Color(0xFF6A0B14);
const Color _saCream = Color(0xFFFFF5F5);
const Color _saCharcoal = Color(0xFF3C2F2F);
const Color _saGold = Color(0xFFD4A030);
const Color _saTeal = Color(0xFF2AA198);
const Color _saLavender = Color(0xFF9B7FBB);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _saSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_saRuby, _saDarkRuby],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _saInfoCard(String heading, String body, {IconData? icon}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _saRose.withValues(alpha: 0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 2),
            child: Icon(icon, color: _saRuby, size: 22),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  color: _saDarkRuby,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: _saCharcoal,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _saCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF2A1518),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _saLightRuby,
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.6,
      ),
    ),
  );
}

Widget _saDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    height: 1,
    color: _saRose.withValues(alpha: 0.2),
  );
}

Widget _saBadge(String label, Color bg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: The Selection System Overview
// ---------------------------------------------------------------------------

Widget _saSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _saSectionHeader(
        '1. Flutter\'s Selection System',
        subtitle: 'How text and content selection works under the hood',
      ),
      const SizedBox(height: 12),
      _saInfoCard(
        'Selection Architecture',
        'Flutter\'s selection system (available since Flutter 3.3) '
            'provides a way to make non-editable text selectable. It '
            'works through three main components:\n\n'
            '• SelectionArea — a widget that enables selection for its subtree\n'
            '• SelectionHandler — dispatches SelectionEvents to children\n'
            '• Selectable — interface that render objects implement to handle selection',
        icon: Icons.select_all,
      ),
      const SizedBox(height: 8),
      // Architecture diagram
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF2A1518),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selection Architecture',
              style: TextStyle(
                color: _saGold,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            _saArchRow('User Action', 'Ctrl+A / Cmd+A / Long press + Select All', _saRose),
            _saArchArrow(),
            _saArchRow('SelectionArea', 'Detects gesture → creates event', _saLightRuby),
            _saArchArrow(),
            _saArchRow('SelectAllSelectionEvent', 'Event object dispatched', _saGold),
            _saArchArrow(),
            _saArchRow('SelectionHandler', 'Dispatches to all Selectables', _saTeal),
            _saArchArrow(),
            _saArchRow('Selectable (×N)', 'Each selects all its content', _saLavender),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _saArchRow(String label, String desc, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              color: color.withValues(alpha: 0.8),
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _saArchArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Icon(Icons.arrow_downward, color: _saLightRuby, size: 16),
  );
}

// ---------------------------------------------------------------------------
// Section 2: SelectionEvent Hierarchy
// ---------------------------------------------------------------------------

Widget _saSection2Hierarchy() {
  final List<Map<String, dynamic>> events = [
    {
      'name': 'SelectAllSelectionEvent',
      'desc': 'Select all content (Ctrl+A)',
      'color': _saRuby,
      'isThis': true,
    },
    {
      'name': 'ClearSelectionEvent',
      'desc': 'Clear existing selection',
      'color': _saTeal,
      'isThis': false,
    },
    {
      'name': 'SelectionEdgeUpdateEvent',
      'desc': 'Move start/end edge of selection',
      'color': const Color(0xFF5B9BD5),
      'isThis': false,
    },
    {
      'name': 'GranularlyExtendSelectionEvent',
      'desc': 'Extend by word/line/paragraph',
      'color': _saLavender,
      'isThis': false,
    },
    {
      'name': 'DirectionallyExtendSelectionEvent',
      'desc': 'Extend in a direction (arrow keys)',
      'color': _saGold,
      'isThis': false,
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _saSectionHeader(
        '2. SelectionEvent Hierarchy',
        subtitle: 'All the selection event types Flutter defines',
      ),
      const SizedBox(height: 12),
      _saInfoCard(
        'Event-Driven Selection',
        'All selection changes are communicated as events. '
            'SelectionEvent is the abstract base class. Each subclass '
            'represents a different kind of selection change. The '
            'Selectable interface has a single dispatchSelectionEvent() '
            'method that handles all types.',
        icon: Icons.account_tree,
      ),
      const SizedBox(height: 8),
      // Hierarchy tree
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _saCream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _saRose.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Base class
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _saCharcoal.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _saCharcoal.withValues(alpha: 0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.class_, color: _saCharcoal, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'SelectionEvent (abstract)',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: _saCharcoal,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Subclasses
            ...events.map((e) {
              final color = e['color'] as Color;
              final isThis = e['isThis'] as bool;
              return Container(
                margin: const EdgeInsets.only(left: 24, top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isThis ? color.withValues(alpha: 0.1) : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: color.withValues(alpha: isThis ? 0.6 : 0.3),
                    width: isThis ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 1,
                      color: _saCharcoal.withValues(alpha: 0.3),
                      margin: const EdgeInsets.only(right: 8),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  e['name'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: color,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              if (isThis) ...[
                                const SizedBox(width: 8),
                                _saBadge('THIS DEMO', _saRuby),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            e['desc'] as String,
                            style: const TextStyle(fontSize: 11, color: _saCharcoal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: SelectAllSelectionEvent Internals
// ---------------------------------------------------------------------------

Widget _saSection3Internals() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _saSectionHeader(
        '3. SelectAllSelectionEvent Internals',
        subtitle: 'The simplest selection event — no parameters',
      ),
      const SizedBox(height: 12),
      _saInfoCard(
        'Minimal by Design',
        'SelectAllSelectionEvent is the simplest SelectionEvent '
            'subclass. It has no constructor parameters — the class '
            'itself IS the message. When a Selectable receives it, '
            'the selectable selects all of its content unconditionally.',
        icon: Icons.code,
      ),
      const SizedBox(height: 8),
      _saCodeBlock(
        '// SelectAllSelectionEvent source (simplified):\n'
        'class SelectAllSelectionEvent extends SelectionEvent {\n'
        '  const SelectAllSelectionEvent();\n'
        '  // That\'s it — no fields, no parameters!\n'
        '  // The type itself is the command.\n'
        '}\n'
        '\n'
        '// Dispatching it:\n'
        'selectable.dispatchSelectionEvent(\n'
        '  const SelectAllSelectionEvent(),\n'
        ');\n'
        '\n'
        '// Handling it in a Selectable:\n'
        'SelectionResult dispatchSelectionEvent(\n'
        '  SelectionEvent event,\n'
        ') {\n'
        '  if (event is SelectAllSelectionEvent) {\n'
        '    _selectAll();  // Select all content\n'
        '    return SelectionResult.none;\n'
        '  }\n'
        '  // handle other event types...\n'
        '}',
      ),
      const SizedBox(height: 8),
      // Comparison with other events
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _saCream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _saRose.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Event Complexity Comparison',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: _saDarkRuby,
              ),
            ),
            const SizedBox(height: 10),
            _saComplexityRow('SelectAllSelectionEvent', 'No params', 1),
            _saComplexityRow('ClearSelectionEvent', 'No params', 1),
            _saComplexityRow('SelectionEdgeUpdateEvent', '3 params (type, offset, granularity)', 3),
            _saComplexityRow('GranularlyExtendSelectionEvent', '2 params (forward, granularity)', 2),
            _saComplexityRow('DirectionallyExtendSelectionEvent', '3 params (dx, dy, isEnd)', 3),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _saComplexityRow(String name, String params, int bars) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: _saCharcoal,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Row(
            children: List.generate(5, (i) => Container(
              width: 14,
              height: 14,
              margin: const EdgeInsets.only(right: 3),
              decoration: BoxDecoration(
                color: i < bars ? _saRuby : _saRuby.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(3),
              ),
            )),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: How It Flows Through the Tree
// ---------------------------------------------------------------------------

Widget _saSection4Flow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _saSectionHeader(
        '4. Event Flow Through the Tree',
        subtitle: 'How SelectAllSelectionEvent reaches every selectable',
      ),
      const SizedBox(height: 12),
      _saInfoCard(
        'Top-Down Dispatch',
        'When the user presses Ctrl+A inside a SelectionArea, the '
            'area\'s SelectionHandler creates a SelectAllSelectionEvent '
            'and dispatches it to all registered Selectable children. '
            'Each child (e.g., RenderParagraph for Text widgets) '
            'selects all of its content.',
        icon: Icons.account_tree,
      ),
      const SizedBox(height: 8),
      // Tree visual showing dispatch
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF2A1518),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dispatch Path',
              style: TextStyle(
                color: _saGold,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            _saTreeNode('SelectionArea', 0, _saRose, note: 'creates event'),
            _saTreeNode('SelectionHandler (registrar)', 1, _saLightRuby, note: 'dispatches'),
            _saTreeNode('Column', 2, Colors.grey, note: 'pass-through'),
            _saTreeNode('Text("Hello") → RenderParagraph', 3, _saTeal, note: 'selects all'),
            _saTreeNode('Text("World") → RenderParagraph', 3, _saTeal, note: 'selects all'),
            _saTreeNode('RichText(...) → RenderParagraph', 3, _saTeal, note: 'selects all'),
          ],
        ),
      ),
      const SizedBox(height: 8),
      _saInfoCard(
        'SelectionResult',
        'Each Selectable returns a SelectionResult after handling the '
            'event. For SelectAllSelectionEvent, the result is typically '
            'SelectionResult.none (meaning the event was fully consumed). '
            'Other events may return .next or .previous to indicate '
            'that the selection should continue to adjacent selectables.',
        icon: Icons.reply,
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _saTreeNode(String label, int depth, Color color, {String? note}) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 20.0, top: 4, bottom: 4),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                  ),
                ),
                if (note != null)
                  TextSpan(
                    text: '  // $note',
                    style: TextStyle(
                      color: color.withValues(alpha: 0.5),
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: Visual Demo — Selection Area
// ---------------------------------------------------------------------------

Widget _saSection5VisualDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _saSectionHeader(
        '5. Visual Demo — SelectionArea',
        subtitle: 'See text selection in action with SelectionArea',
      ),
      const SizedBox(height: 12),
      _saInfoCard(
        'Interactive Selection',
        'Below is a SelectionArea wrapping multiple Text widgets. '
            'You can interact with it using standard selection gestures. '
            'SelectAllSelectionEvent is dispatched when you use the '
            'Select All context menu or keyboard shortcut.',
        icon: Icons.touch_app,
      ),
      const SizedBox(height: 8),
      // SelectionArea demo
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _saRuby.withValues(alpha: 0.3), width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _saRuby.withValues(alpha: 0.08),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.select_all, color: _saRuby, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'SelectionArea',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _saRuby,
                    ),
                  ),
                  const Spacer(),
                  _saBadge('selectable', _saRuby),
                ],
              ),
            ),
            SelectionArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'The Quick Brown Fox',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _saDarkRuby,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'The quick brown fox jumps over the lazy dog. '
                      'This is a SelectionArea containing multiple Text '
                      'widgets. When SelectAllSelectionEvent is dispatched, '
                      'every paragraph below gets fully selected.',
                      style: TextStyle(
                        fontSize: 13,
                        color: _saCharcoal,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'A Second Paragraph',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _saRuby,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Each Text widget creates its own RenderParagraph. '
                      'The SelectionHandler dispatches the SelectAllSelectionEvent '
                      'to each RenderParagraph, which selects its entire '
                      'TextSpan content.',
                      style: TextStyle(
                        fontSize: 13,
                        color: _saCharcoal,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _saRuby.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Try selecting this text! On desktop, use Ctrl+A or '
                        'Cmd+A to trigger SelectAllSelectionEvent.',
                        style: TextStyle(
                          fontSize: 12,
                          color: _saCharcoal,
                          fontStyle: FontStyle.italic,
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
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: Comparison — Before and After Select All
// ---------------------------------------------------------------------------

Widget _saSection6BeforeAfter() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _saSectionHeader(
        '6. Before & After Select All',
        subtitle: 'Visual comparison of selection states',
      ),
      const SizedBox(height: 12),
      // Before
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Before panel
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.text_fields, color: Colors.grey, size: 14),
                        const SizedBox(width: 6),
                        _saBadge('BEFORE', Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Hello World\n\n'
                      'This is a paragraph\nof text content.',
                      style: TextStyle(fontSize: 12, color: _saCharcoal, height: 1.4),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'No selection active',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Arrow
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
              child: Icon(Icons.arrow_forward, color: _saRuby, size: 24),
            ),
            // After panel
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _saRuby.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _saRuby.withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.select_all, color: _saRuby, size: 14),
                        const SizedBox(width: 6),
                        _saBadge('AFTER Ctrl+A', _saRuby),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      color: const Color(0xFF338FFF).withValues(alpha: 0.25),
                      child: const Text(
                        'Hello World\n\n'
                        'This is a paragraph\nof text content.',
                        style: TextStyle(fontSize: 12, color: _saCharcoal, height: 1.4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'All text selected!',
                      style: TextStyle(
                        fontSize: 10,
                        color: _saRuby,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      _saInfoCard(
        'What Happens Internally',
        'When SelectAllSelectionEvent is dispatched:\n\n'
            '1. SelectionHandler iterates all registered Selectables\n'
            '2. Each Selectable receives dispatchSelectionEvent()\n'
            '3. RenderParagraph sets selection from index 0 to end\n'
            '4. Selection overlay paints the highlight (blue)\n'
            '5. Context menu appears with Copy option',
        icon: Icons.psychology,
      ),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: SelectionArea Patterns
// ---------------------------------------------------------------------------

Widget _saSection7Patterns() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _saSectionHeader(
        '7. SelectionArea Usage Patterns',
        subtitle: 'Common ways developers use text selection',
      ),
      const SizedBox(height: 12),
      _saPatternCard(
        'Wrap Entire Page',
        'SelectionArea(\n'
            '  child: ListView(\n'
            '    children: [...all text content...],\n'
            '  ),\n'
            ')',
        'Makes all text on the page selectable. Ctrl+A selects everything.',
        Icons.description,
        _saRuby,
      ),
      _saPatternCard(
        'Selective Wrapping',
        'Column(children: [\n'
            '  Text("Not selectable"),\n'
            '  SelectionArea(\n'
            '    child: Text("This IS selectable"),\n'
            '  ),\n'
            '  Text("Not selectable either"),\n'
            '])',
        'Only content inside SelectionArea responds to selection events.',
        Icons.highlight_alt,
        _saTeal,
      ),
      _saPatternCard(
        'Custom Context Menu',
        'SelectionArea(\n'
            '  contextMenuBuilder: (ctx, state) {\n'
            '    return MyCustomMenu(...);\n'
            '  },\n'
            '  child: Text("Custom menu"),\n'
            ')',
        'Override the default context menu (Copy, Select All) with custom actions.',
        Icons.menu,
        _saLavender,
      ),
      _saPatternCard(
        'Selection Change Callback',
        'SelectionArea(\n'
            '  onSelectionChanged: (value) {\n'
            '    print("Selected: \$value");\n'
            '  },\n'
            '  child: Text("Monitor selection"),\n'
            ')',
        'Get notified when selection changes — useful for analytics or UI updates.',
        Icons.notifications_active,
        _saGold,
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _saPatternCard(String title, String code, String explanation, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF2A1518),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            code,
            style: const TextStyle(
              color: _saLightRuby,
              fontFamily: 'monospace',
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            explanation,
            style: const TextStyle(fontSize: 12, color: _saCharcoal, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8: Summary
// ---------------------------------------------------------------------------

Widget _saSection8Summary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _saSectionHeader(
        '8. Summary',
        subtitle: 'SelectAllSelectionEvent at a glance',
      ),
      const SizedBox(height: 12),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _saCream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _saRose.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            _saSummaryRow('Type', 'Concrete SelectionEvent subclass'),
            _saSummaryRow('Purpose', 'Commands all selectables to select everything'),
            _saSummaryRow('Parameters', 'None — the type IS the command'),
            _saSummaryRow('Triggered by', 'Ctrl+A, Cmd+A, or context menu'),
            _saSummaryRow('Handled by', 'Any class implementing Selectable'),
            _saSummaryRow('Result', 'SelectionResult.none (fully consumed)'),
            _saSummaryRow('Used with', 'SelectionArea, SelectableRegion'),
          ],
        ),
      ),
      const SizedBox(height: 10),
      _saInfoCard(
        'Key Takeaway',
        'SelectAllSelectionEvent is Flutter\'s simplest selection event '
            '— a parameterless command that says "select everything." '
            'It demonstrates the elegance of the event-based selection '
            'architecture: complex behavior (selecting across multiple '
            'paragraphs) from a minimal data structure.',
        icon: Icons.school,
      ),
      const SizedBox(height: 8),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_saRuby, _saDarkRuby],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Icon(Icons.select_all, color: _saRose, size: 22),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'SelectAllSelectionEvent: zero parameters, maximum '
                    'selection. The simplest command in Flutter\'s selection '
                    'system.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}

Widget _saSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 95,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: _saDarkRuby,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, color: _saCharcoal),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// MAIN BUILD ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  print('=== SelectAllSelectionEvent Deep Demo ===');
  print('SelectAllSelectionEvent is a parameterless selection event.');
  print('It commands all selectables to select their entire content.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFFFFF8F8),
      appBarTheme: const AppBarTheme(
        backgroundColor: _saRuby,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectAllSelectionEvent'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'rendering',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_saDarkRuby, _saRuby, _saRose],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SelectAllSelectionEvent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'The "select all" command in Flutter\'s rendering-layer '
                        'selection system. Dispatched to every Selectable in '
                        'a SelectionArea when Ctrl+A / Cmd+A is pressed.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _saBadge('SelectionEvent', _saDarkRuby),
                      const SizedBox(width: 8),
                      _saBadge('parameterless', _saRose),
                      const SizedBox(width: 8),
                      _saBadge('Ctrl+A', _saGold),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _saSection1Overview(),
            _saDivider(),
            _saSection2Hierarchy(),
            _saDivider(),
            _saSection3Internals(),
            _saDivider(),
            _saSection4Flow(),
            _saDivider(),
            _saSection5VisualDemo(),
            _saDivider(),
            _saSection6BeforeAfter(),
            _saDivider(),
            _saSection7Patterns(),
            _saDivider(),
            _saSection8Summary(),
          ],
        ),
      ),
    ),
  );
}

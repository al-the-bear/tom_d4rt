// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SELECTION HANDLER — Deep Demo
// ============================================================================
//
// SelectionHandler is a mixin on RenderObject that gives any render object
// the ability to participate in Flutter's text-selection system.  It is the
// core contract between SelectableRegion and individual Selectables.
//
// The mixin specifies two fundamental methods every handler must implement:
//
//   1. dispatchSelectionEvent(SelectionEvent event) → SelectionResult
//      Receives selection events (select word, extend edge, clear, etc.)
//      and returns a result indicating what happened.
//
//   2. pushHandleLayers(LayerLink? start, LayerLink? end)
//      Called by SelectableRegion to install LeaderLayers for the
//      drag-handle overlays in the compositing tree.
//
// Plus the geometry property:
//   3. value → ValueListenable<SelectionGeometry>
//      Published geometry so the region can position handles / toolbar.
//
// This demo visualises the handler contract, the event flow, the
// result semantics, and how handle layers bridge render tree ↔ overlay.
//
// Color theme : Forest (#2E7D32) / Sage (#A5D6A7)
// Helper prefix: _sh
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _shForest = Color(0xFF2E7D32);
const Color _shSage = Color(0xFFA5D6A7);
const Color _shDeepForest = Color(0xFF1B5E20);
const Color _shLightSage = Color(0xFFE8F5E9);
const Color _shIvory = Color(0xFFF1F8E9);
const Color _shCharcoal = Color(0xFF212121);
const Color _shTeal = Color(0xFF00897B);
const Color _shAmber = Color(0xFFFF8F00);
const Color _shCoral = Color(0xFFE53935);
const Color _shSky = Color(0xFF1E88E5);
const Color _shGold = Color(0xFFFFD600);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _shSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_shForest, _shDeepForest],
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
            letterSpacing: 0.4,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.78),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _shNote(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _shLightSage,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _shSage, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _shForest, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _shCharcoal,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _shCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _shCharcoal,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _shSage,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _shSubtitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _shForest,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _shDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _shSage.withValues(alpha: 0.4),
  );
}

Widget _shTag(String label, Color bg, {Color textColor = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: textColor,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _shMethodCard(String name, String returnType, String desc, IconData icon, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.1),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 20),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                color: accent,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
            const Spacer(),
            _shTag(returnType, accent),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          desc,
          style: const TextStyle(
            color: _shCharcoal,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Overview
// ---------------------------------------------------------------------------
Widget _shBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionHeader(
        '1. What Is SelectionHandler?',
        subtitle: 'The mixin that makes render objects selectable',
      ),
      const SizedBox(height: 12),
      _shNote(
        'SelectionHandler is a mixin on RenderObject.  Any render object '
        'that mixes it in becomes a participant in the selection system — '
        'it can receive selection events, report its geometry, and host '
        'the drag-handle overlay layers.',
      ),
      _shNote(
        'The mixin is the bridge between the gesture-driven SelectableRegion '
        'widget and the layout-driven RenderObject tree.  Without it, a '
        'render object is invisible to the selection system.',
        icon: Icons.link,
      ),

      // Visual: the mixin contract card
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _shForest, width: 2),
          boxShadow: [
            BoxShadow(
              color: _shForest.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.extension, color: _shForest, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'mixin SelectionHandler',
                  style: TextStyle(
                    color: _shDeepForest,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                const Spacer(),
                _shTag('on RenderObject', _shForest),
              ],
            ),
            const SizedBox(height: 14),
            _shContractRow(
              'dispatchSelectionEvent()',
              'Handles incoming selection events',
              Icons.send,
            ),
            const SizedBox(height: 6),
            _shContractRow(
              'pushHandleLayers()',
              'Installs LeaderLayers for handle overlays',
              Icons.layers,
            ),
            const SizedBox(height: 6),
            _shContractRow(
              'value (getter)',
              'Publishes SelectionGeometry via ValueListenable',
              Icons.data_object,
            ),
          ],
        ),
      ),

      _shNote(
        'Key insight: SelectionHandler is NOT a widget or an element — it '
        'lives at the RenderObject level.  The widget-level counterpart is '
        'the Selectable interface (which extends SelectionHandler with '
        'additional registration).  Most developers interact with '
        'SelectionArea / SelectableRegion at the widget level and never '
        'touch SelectionHandler directly unless building custom render objects.',
        icon: Icons.lightbulb_outline,
      ),
    ],
  );
}

Widget _shContractRow(String method, String desc, IconData icon) {
  return Row(
    children: [
      Icon(icon, color: _shTeal, size: 18),
      const SizedBox(width: 10),
      SizedBox(
        width: 200,
        child: Text(
          method,
          style: const TextStyle(
            color: _shDeepForest,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
      ),
      Expanded(
        child: Text(
          desc,
          style: const TextStyle(
            color: _shCharcoal,
            fontSize: 11,
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2 — The Two Key Methods
// ---------------------------------------------------------------------------
Widget _shBuildMethods() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionHeader(
        '2. The Two Key Methods',
        subtitle: 'dispatchSelectionEvent and pushHandleLayers',
      ),
      const SizedBox(height: 12),
      _shMethodCard(
        'dispatchSelectionEvent',
        'SelectionResult',
        'Called by the SelectableRegion when a selection gesture occurs.  '
        'The handler processes the event (e.g. SelectWordSelectionEvent, '
        'SelectionEdgeUpdateEvent, ClearSelectionEvent) and returns a '
        'SelectionResult indicating what happened — whether the event was '
        'fully consumed, needs to propagate, or is still pending.',
        Icons.call_received,
        _shForest,
      ),
      _shCodeBlock(
        'SelectionResult dispatchSelectionEvent(\n'
        '    SelectionEvent event) {\n'
        '  switch (event.type) {\n'
        '    case SelectionEventType.startEdgeUpdate:\n'
        '    case SelectionEventType.endEdgeUpdate:\n'
        '      return _handleEdgeUpdate(event);\n'
        '    case SelectionEventType.clear:\n'
        '      _clearSelection();\n'
        '      return SelectionResult.none;\n'
        '    case SelectionEventType.selectAll:\n'
        '      _selectAll();\n'
        '      return SelectionResult.none;\n'
        '    case SelectionEventType.selectWord:\n'
        '      return _handleWordSelect(event);\n'
        '    case SelectionEventType.granularlyExtendSelection:\n'
        '    case SelectionEventType.directionallyExtendSelection:\n'
        '      return _handleExtend(event);\n'
        '  }\n'
        '}',
      ),
      const SizedBox(height: 8),
      _shMethodCard(
        'pushHandleLayers',
        'void',
        'Called by SelectableRegion to install or remove LayerLinks for '
        'the drag handle overlays.  A non-null startHandle means "this '
        'handler owns the start handle" — it should add a LeaderLayer '
        'during compositing at the start handle position.  Same for endHandle.',
        Icons.layers,
        _shTeal,
      ),
      _shCodeBlock(
        'void pushHandleLayers(\n'
        '    LayerLink? startHandle,\n'
        '    LayerLink? endHandle,\n'
        ') {\n'
        '  // Store the links, then mark\n'
        '  // needs compositing bits dirty\n'
        '  _startHandleLayerLink = startHandle;\n'
        '  _endHandleLayerLink = endHandle;\n'
        '  markNeedsCompositingBitsUpdate();\n'
        '}',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3 — SelectionResult Enum
// ---------------------------------------------------------------------------
Widget _shBuildSelectionResult() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionHeader(
        '3. SelectionResult — Return Values',
        subtitle: 'What the handler tells the region after processing an event',
      ),
      const SizedBox(height: 12),
      _shNote(
        'When dispatchSelectionEvent returns, the SelectableRegion uses '
        'the SelectionResult to decide what to do next — whether to move '
        'on to the next selectable, stop, or continue extending.',
      ),

      // Visual: Result enum cards
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _shResultCard(
              'SelectionResult.end',
              'The selection edge is within this handler.  Stop dispatching '
              'to subsequent selectables — the active endpoint is here.',
              _shForest,
              Icons.stop_circle_outlined,
            ),
            const SizedBox(height: 8),
            _shResultCard(
              'SelectionResult.next',
              'The selection edge has moved past this handler.  Continue '
              'dispatching to the next selectable in paint order.',
              _shSky,
              Icons.arrow_forward,
            ),
            const SizedBox(height: 8),
            _shResultCard(
              'SelectionResult.previous',
              'The selection edge is before this handler.  Dispatch to '
              'the previous selectable instead.',
              _shAmber,
              Icons.arrow_back,
            ),
            const SizedBox(height: 8),
            _shResultCard(
              'SelectionResult.none',
              'The event was processed without affecting direction logic '
              '(e.g. clear or select-all).  No further dispatch needed.',
              _shCharcoal,
              Icons.check,
            ),
            const SizedBox(height: 8),
            _shResultCard(
              'SelectionResult.pending',
              'The handler cannot determine the result yet (e.g. a lazy-loading '
              'list that hasn\'t materialised its children).  The region should '
              'retry after layout.',
              _shCoral,
              Icons.hourglass_bottom,
            ),
          ],
        ),
      ),

      // Visual: dispatch flow
      _shSubtitle('Dispatch Flow Diagram'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _shIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _shForest),
        ),
        child: Column(
          children: [
            _shFlowRow('SelectableRegion', 'sends event →', _shForest),
            _shFlowArrow(),
            _shFlowRow('Handler A', 'returns .next →', _shSky),
            _shFlowArrow(),
            _shFlowRow('Handler B', 'returns .next →', _shSky),
            _shFlowArrow(),
            _shFlowRow('Handler C', 'returns .end ■', _shForest),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _shLightSage,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Handler C owns the selection endpoint.\n'
                'D, E, F are not dispatched to.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _shDeepForest,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _shResultCard(String name, String desc, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(icon, color: Colors.white, size: 18)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  color: _shCharcoal,
                  fontSize: 11,
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

Widget _shFlowRow(String label, String action, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const Spacer(),
        Text(
          action,
          style: const TextStyle(
            color: _shCharcoal,
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _shFlowArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Icon(Icons.arrow_downward, color: _shSage, size: 16),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — How RenderParagraph Uses SelectionHandler
// ---------------------------------------------------------------------------
Widget _shBuildParagraphUsage() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionHeader(
        '4. RenderParagraph as a SelectionHandler',
        subtitle: 'The most common handler in every Flutter app',
      ),
      const SizedBox(height: 12),
      _shNote(
        'RenderParagraph (the render object behind the Text widget) '
        'implements SelectionHandler.  When placed inside a SelectionArea, '
        'each RenderParagraph automatically participates in the selection '
        'system.  This is the reason you can select text across multiple '
        'Text widgets — each one is its own SelectionHandler.',
        icon: Icons.text_fields,
      ),

      // Visual: Text widgets each with their own handler
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _shForest, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Each Text → RenderParagraph → SelectionHandler',
              style: TextStyle(
                color: _shDeepForest,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 14),
            _shParagraphRow('Text("First paragraph...")', 'Handler A', _shForest, true),
            const SizedBox(height: 6),
            _shParagraphRow('Text("Second paragraph...")', 'Handler B', _shTeal, false),
            const SizedBox(height: 6),
            _shParagraphRow('Text("Third paragraph...")', 'Handler C', _shSky, false),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _shIvory,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'When a drag selection crosses from Handler A to Handler C, '
                'A returns .next, B returns .next (fully selected), '
                'and C returns .end (drag stopped here).',
                style: TextStyle(
                  color: _shCharcoal,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),

      // Live demo: selectable paragraphs
      _shSubtitle('Live: SelectionHandler in Action'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _shForest, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: _shForest,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.touch_app, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Try selecting across paragraphs',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  _shTag('3 handlers', _shSage, textColor: _shDeepForest),
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
                      'First Handler — Paragraph A',
                      style: TextStyle(
                        color: _shDeepForest,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'This paragraph is backed by a RenderParagraph that mixes in '
                      'SelectionHandler.  When you start a selection here, the '
                      'handler processes SelectionEdgeUpdateEvents and reports '
                      'its geometry to the SelectableRegion.',
                      style: TextStyle(
                        color: _shCharcoal.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Second Handler — Paragraph B',
                      style: TextStyle(
                        color: _shTeal,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'When the selection extends into this paragraph, Handler A '
                      'returns SelectionResult.next and this handler takes over.  '
                      'The pushHandleLayers method transfers the end-handle '
                      'LeaderLayer to this render object.',
                      style: TextStyle(
                        color: _shCharcoal.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Third Handler — Paragraph C',
                      style: TextStyle(
                        color: _shSky,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'If the selection drag continues through B into C, the end '
                      'handle follows.  Each text paragraph is independent yet '
                      'coordinated — the selection appears seamless because all '
                      'handlers report consistent geometry.',
                      style: TextStyle(
                        color: _shCharcoal.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _shParagraphRow(String widget, String handler, Color color, bool isFirst) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Icon(Icons.text_snippet, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        _shTag(handler, color),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — Event Processing Detail
// ---------------------------------------------------------------------------
Widget _shBuildEventProcessing() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionHeader(
        '5. Event Processing in Detail',
        subtitle: 'What happens inside dispatchSelectionEvent',
      ),
      const SizedBox(height: 12),
      _shNote(
        'The handler receives different types of SelectionEvents.  Each '
        'type requires different processing logic.  Here is a breakdown '
        'of the most common events and what the handler does with them.',
        icon: Icons.event,
      ),

      // Visual: Event type breakdown
      _shEventTypeRow(
        'SelectWordSelectionEvent',
        'Long-press detected.  Handler checks if the tap offset is within '
        'its bounds, selects the word at that position, and returns .end '
        'if the point is within its layout, or .next otherwise.',
        Icons.touch_app,
        _shForest,
      ),
      _shEventTypeRow(
        'SelectionEdgeUpdateEvent',
        'End-edge drag.  Handler maps the global position to local coords, '
        'finds the nearest text position, updates its internal selection, '
        'and publishes new geometry.  Returns .end if the position is '
        'within bounds, .next/.previous if past the edges.',
        Icons.pan_tool,
        _shTeal,
      ),
      _shEventTypeRow(
        'ClearSelectionEvent',
        'Clear everything.  Handler resets its selection to none, publishes '
        'geometry with status .none, and returns .none.',
        Icons.clear,
        _shCoral,
      ),
      _shEventTypeRow(
        'SelectAllSelectionEvent',
        'Select all content.  Handler marks its entire text as selected '
        'and publishes geometry with status .uncollapsed.  Returns .none.',
        Icons.select_all,
        _shSky,
      ),
      _shEventTypeRow(
        'GranularlyExtendSelectionEvent',
        'Keyboard shift+arrow.  Handler extends the selection by the '
        'specified granularity (character, word, line, document) in the '
        'specified direction.',
        Icons.keyboard,
        _shAmber,
      ),

      _shCodeBlock(
        '// Handler pseudo-code for edge update:\n'
        'SelectionResult _handleEdgeUpdate(\n'
        '    SelectionEdgeUpdateEvent event) {\n'
        '  final localOffset =\n'
        '    globalToLocal(event.globalPosition);\n'
        '  \n'
        '  if (localOffset.dy < 0) {\n'
        '    // Above this handler\n'
        '    return event.type == \n'
        '      SelectionEventType.startEdgeUpdate\n'
        '      ? SelectionResult.previous\n'
        '      : SelectionResult.previous;\n'
        '  }\n'
        '  if (localOffset.dy > size.height) {\n'
        '    // Below this handler\n'
        '    return SelectionResult.next;\n'
        '  }\n'
        '  // Within bounds — update selection\n'
        '  _updateSelectionAt(localOffset);\n'
        '  return SelectionResult.end;\n'
        '}',
      ),
    ],
  );
}

Widget _shEventTypeRow(String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: color, width: 3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Icon(icon, color: color, size: 18)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  color: _shCharcoal,
                  fontSize: 11,
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

// ---------------------------------------------------------------------------
// Section 6 — Handle Layer Management
// ---------------------------------------------------------------------------
Widget _shBuildHandleLayers() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionHeader(
        '6. Handle Layer Management',
        subtitle: 'pushHandleLayers — connecting handles to the overlay',
      ),
      const SizedBox(height: 12),
      _shNote(
        'The pushHandleLayers method is the connection point between the '
        'render tree and the overlay.  When called with a non-null LayerLink, '
        'the handler must add a LeaderLayer at the handle\'s position during '
        'its compositing phase.  The overlay places FollowerLayers that '
        'track these leaders automatically.',
        icon: Icons.layers,
      ),

      // Visual: Layer architecture
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _shIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _shForest),
        ),
        child: Column(
          children: [
            const Text(
              'Layer Architecture',
              style: TextStyle(
                color: _shDeepForest,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Render tree side
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _shForest.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _shForest.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        _shTag('Render Tree', _shForest),
                        const SizedBox(height: 10),
                        _shLayerBox('Handler A', 'LeaderLayer (start)', _shForest),
                        const SizedBox(height: 4),
                        const Text(
                          '↕ LayerLink',
                          style: TextStyle(
                            color: _shAmber,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _shLayerBox('Handler C', 'LeaderLayer (end)', _shTeal),
                      ],
                    ),
                  ),
                ),
                // Arrow
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Icon(Icons.sync_alt, color: _shAmber, size: 30),
                      Text(
                        'LayerLink\nbinding',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _shAmber,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Overlay side
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _shAmber.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _shAmber.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        _shTag('Overlay', _shAmber),
                        const SizedBox(height: 10),
                        _shLayerBox('Start Handle', 'FollowerLayer', _shForest),
                        const SizedBox(height: 6),
                        _shLayerBox('End Handle', 'FollowerLayer', _shTeal),
                        const SizedBox(height: 6),
                        _shLayerBox('Toolbar', 'Positioned', _shSky),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _shLightSage,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'When selection changes, pushHandleLayers() is called:\n'
                '• Owner of start → receives startHandle LayerLink\n'
                '• Owner of end → receives endHandle LayerLink\n'
                '• Others → receive null, null (remove any layers)',
                style: TextStyle(
                  color: _shDeepForest,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
      _shCodeBlock(
        '// After geometry update:\n'
        'for (final handler in handlers) {\n'
        '  if (handler == startOwner) {\n'
        '    handler.pushHandleLayers(\n'
        '      startLayerLink, null);\n'
        '  } else if (handler == endOwner) {\n'
        '    handler.pushHandleLayers(\n'
        '      null, endLayerLink);\n'
        '  } else {\n'
        '    handler.pushHandleLayers(\n'
        '      null, null); // remove\n'
        '  }\n'
        '}',
      ),
    ],
  );
}

Widget _shLayerBox(String title, String desc, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        Text(
          desc,
          style: const TextStyle(
            color: _shCharcoal,
            fontSize: 9,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — Visual: Complete Selection Flow
// ---------------------------------------------------------------------------
Widget _shBuildCompleteFlow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionHeader(
        '7. Complete Selection Flow',
        subtitle: 'From user gesture to visible selection — through handlers',
      ),
      const SizedBox(height: 12),
      _shNote(
        'Here is the complete flow of a long-press-drag selection, '
        'showing how SelectionHandler participates at each stage.',
      ),

      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _shIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _shForest),
        ),
        child: Column(
          children: [
            _shFlowStep(1, 'User long-presses on text',
              'GestureRecognizer detects and notifies SelectableRegion',
              Icons.touch_app, _shForest),
            _shFlowConnector(),
            _shFlowStep(2, 'Region creates SelectWordSelectionEvent',
              'globalPosition = press location',
              Icons.event, _shTeal),
            _shFlowConnector(),
            _shFlowStep(3, 'Region iterates handlers in paint order',
              'Calls handler.dispatchSelectionEvent(wordEvent)',
              Icons.list, _shSky),
            _shFlowConnector(),
            _shFlowStep(4, 'Handler processes, returns .end',
              'Selects word, publishes new geometry, returns .end',
              Icons.check_circle, _shForest),
            _shFlowConnector(),
            _shFlowStep(5, 'Region reads geometry from handler',
              'Gets startSelectionPoint, endSelectionPoint',
              Icons.data_object, _shAmber),
            _shFlowConnector(),
            _shFlowStep(6, 'Region calls pushHandleLayers',
              'Gives start+end LayerLinks to the handler',
              Icons.layers, _shTeal),
            _shFlowConnector(),
            _shFlowStep(7, 'Handle overlays appear',
              'FollowerLayers track the LeaderLayers — handles visible!',
              Icons.visibility, _shSky),
            _shFlowConnector(),
            _shFlowStep(8, 'User drags to extend selection',
              'SelectionEdgeUpdateEvents dispatched continuously',
              Icons.pan_tool, _shCoral),
          ],
        ),
      ),
    ],
  );
}

Widget _shFlowStep(int num, String title, String desc, IconData icon, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$num',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              desc,
              style: const TextStyle(
                color: _shCharcoal,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _shFlowConnector() {
  return Row(
    children: [
      const SizedBox(width: 15),
      Container(width: 2, height: 10, color: _shSage),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Custom SelectionHandler
// ---------------------------------------------------------------------------
Widget _shBuildCustomHandler() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionHeader(
        '8. Implementing a Custom SelectionHandler',
        subtitle: 'Making your own render objects selectable',
      ),
      const SizedBox(height: 12),
      _shNote(
        'While most developers never need to implement SelectionHandler '
        'directly (since RenderParagraph already does it), custom render '
        'objects that display selectable non-text content (e.g. images '
        'with alt text, code blocks, or interactive data) may need to.',
        icon: Icons.build,
      ),

      _shSubtitle('Implementation Checklist'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _shForest),
        ),
        child: Column(
          children: [
            _shChecklistItem(1, 'Mix in SelectionHandler on your RenderObject'),
            _shChecklistItem(2, 'Create a ValueNotifier<SelectionGeometry>'),
            _shChecklistItem(3, 'Override value → return the notifier'),
            _shChecklistItem(4, 'Override dispatchSelectionEvent → handle events'),
            _shChecklistItem(5, 'Override pushHandleLayers → store LayerLinks'),
            _shChecklistItem(6, 'During compositing, add LeaderLayers at handle positions'),
            _shChecklistItem(7, 'Register with SelectionRegistrar (via getSelectable())'),
            _shChecklistItem(8, 'Publish geometry whenever selection state changes'),
          ],
        ),
      ),

      _shCodeBlock(
        'class RenderMySelectable extends RenderBox\n'
        '    with SelectionHandler {\n'
        '  final _geometryNotifier =\n'
        '    ValueNotifier(SelectionGeometry.empty);\n'
        '\n'
        '  @override\n'
        '  ValueListenable<SelectionGeometry>\n'
        '      get value => _geometryNotifier;\n'
        '\n'
        '  @override\n'
        '  SelectionResult dispatchSelectionEvent(\n'
        '      SelectionEvent event) {\n'
        '    // Process event, return result\n'
        '    return _processEvent(event);\n'
        '  }\n'
        '\n'
        '  @override\n'
        '  void pushHandleLayers(\n'
        '    LayerLink? start, LayerLink? end) {\n'
        '    _startLink = start;\n'
        '    _endLink = end;\n'
        '    markNeedsCompositingBitsUpdate();\n'
        '  }\n'
        '}',
      ),

      _shNote(
        'Important: The handler must also implement the Selectable interface '
        'if it wants to register with a SelectionRegistrar.  Selectable '
        'extends SelectionHandler and adds the registration protocol.',
        icon: Icons.warning_amber,
      ),
    ],
  );
}

Widget _shChecklistItem(int num, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: _shForest.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _shForest.withValues(alpha: 0.4)),
          ),
          child: Center(
            child: Text(
              '$num',
              style: const TextStyle(
                color: _shForest,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _shCharcoal,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Summary
// ---------------------------------------------------------------------------
Widget _shBuildSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionHeader(
        '9. Summary & Key Takeaways',
        subtitle: 'SelectionHandler in a nutshell',
      ),
      const SizedBox(height: 12),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_shForest, _shDeepForest],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: _shGold, size: 18),
                SizedBox(width: 8),
                Text(
                  'SelectionHandler — Key Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _shSummaryItem('Mixin', 'Lives on RenderObject — render-level participation.'),
            _shSummaryItem('Event Dispatch', 'Receives events, returns SelectionResult.'),
            _shSummaryItem('Handle Layers', 'Hosts LeaderLayers for handle overlay positioning.'),
            _shSummaryItem('Geometry', 'Publishes SelectionGeometry via ValueListenable.'),
            _shSummaryItem('RenderParagraph', 'Most common implementation — every Text widget.'),
            _shSummaryItem('Custom', 'Mix in for custom selectable render objects.'),
          ],
        ),
      ),

      // Relationship diagram
      _shSubtitle('Type Hierarchy'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _shIvory,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _shForest),
        ),
        child: Column(
          children: [
            _shHierarchyBox('SelectionHandler', 'mixin on RenderObject', _shForest),
            const Icon(Icons.arrow_downward, color: _shSage, size: 18),
            _shHierarchyBox('Selectable', 'extends SelectionHandler + registration', _shTeal),
            const Icon(Icons.arrow_downward, color: _shSage, size: 18),
            _shHierarchyBox('RenderParagraph', 'concrete implementation for text', _shSky),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _shSummaryItem(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6, height: 6,
          margin: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(color: _shGold, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: '$title — ',
                style: const TextStyle(
                  color: _shSage,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              TextSpan(
                text: desc,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ]),
          ),
        ),
      ],
    ),
  );
}

Widget _shHierarchyBox(String name, String desc, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 2),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Text(
          desc,
          style: const TextStyle(color: _shCharcoal, fontSize: 10),
        ),
      ],
    ),
  );
}

// ============================================================================
// Main build function
// ============================================================================
dynamic build(BuildContext context) {
  print('--- SelectionHandler Deep Demo ---');
  print('Demonstrates the SelectionHandler mixin that gives');
  print('render objects the ability to participate in selection.');
  print('');
  print('Sections:');
  print('  1.  What Is SelectionHandler?');
  print('  2.  The Two Key Methods');
  print('  3.  SelectionResult — Return Values');
  print('  4.  RenderParagraph as a SelectionHandler');
  print('  5.  Event Processing in Detail');
  print('  6.  Handle Layer Management');
  print('  7.  Complete Selection Flow');
  print('  8.  Implementing a Custom SelectionHandler');
  print('  9.  Summary & Key Takeaways');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _shForest,
      scaffoldBackgroundColor: _shIvory,
      appBarTheme: const AppBarTheme(
        backgroundColor: _shDeepForest,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionHandler — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _shSage.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.extension, size: 14),
                SizedBox(width: 4),
                Text('Rendering', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shBuildOverview(),
            _shDivider(),
            _shBuildMethods(),
            _shDivider(),
            _shBuildSelectionResult(),
            _shDivider(),
            _shBuildParagraphUsage(),
            _shDivider(),
            _shBuildEventProcessing(),
            _shDivider(),
            _shBuildHandleLayers(),
            _shDivider(),
            _shBuildCompleteFlow(),
            _shDivider(),
            _shBuildCustomHandler(),
            _shDivider(),
            _shBuildSummary(),
          ],
        ),
      ),
    ),
  );
}

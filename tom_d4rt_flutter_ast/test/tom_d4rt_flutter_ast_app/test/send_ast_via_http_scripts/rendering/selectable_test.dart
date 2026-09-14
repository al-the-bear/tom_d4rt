// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SELECTABLE — Deep Demo
// ============================================================================
//
// Selectable is the interface (mixin) in Flutter's rendering layer that
// render objects implement when they want to participate in text/content
// selection driven by SelectionArea or SelectableRegion.
//
// The selection architecture works like this:
//
//   SelectionArea (widget)
//   └── SelectableRegion (widget, owns SelectionOverlay)
//       └── SelectionRegistrar (InheritedWidget)
//           └── Selectable render objects register themselves
//
// Any RenderObject that mixes in Selectable can:
//   • Register with a SelectionRegistrar to join the selection tree
//   • Receive SelectionEvent dispatches (select-all, clear, edge-update…)
//   • Report its SelectionGeometry (start/end handles, selected status)
//   • Push handle layers for drag interaction
//
// The most common built-in Selectable is the render object behind
// SelectableText/Text inside a SelectionArea.  But the interface is
// generic enough that images, custom shapes, or any content could
// become selectable by implementing the contract.
//
// This demo showcases how selection works end-to-end using
// SelectionArea with various content types, visualises the
// selection geometry concepts, and illustrates patterns for
// building selectable content hierarchies.
//
// Color theme : Cobalt (#0047AB) / Sky (#87CEEB)
// Helper prefix: _sl
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _slCobalt = Color(0xFF0047AB);
const Color _slSky = Color(0xFF87CEEB);
const Color _slDarkCobalt = Color(0xFF002D6B);
const Color _slLightSky = Color(0xFFD4EFFF);
const Color _slNavy = Color(0xFF001F3F);
const Color _slIce = Color(0xFFF0F8FF);
const Color _slSteel = Color(0xFF4682B4);
const Color _slAmber = Color(0xFFFFBF00);
const Color _slCoral = Color(0xFFFF6F61);
const Color _slMint = Color(0xFF3EB489);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _slSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_slCobalt, _slDarkCobalt],
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

Widget _slInfoCard(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _slLightSky,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _slSky, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _slCobalt, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _slNavy,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _slCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _slNavy,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _slSky,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _slKeyValueRow(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 180,
          child: Text(
            key,
            style: const TextStyle(
              color: _slSteel,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _slNavy,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _slDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _slSky.withValues(alpha: 0.4),
  );
}

Widget _slBadge(String label, Color bgColor, {Color textColor = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bgColor,
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

Widget _slSubheading(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _slCobalt,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Overview: What is Selectable?
// ---------------------------------------------------------------------------
Widget _slBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '1. What Is Selectable?',
        subtitle: 'The interface for participating in content selection',
      ),
      const SizedBox(height: 12),
      _slInfoCard(
        'Selectable is a mixin that render objects implement to participate '
        'in Flutter\'s content selection system.  When a user long-presses '
        'or drags to select text (or other content), it is the Selectable '
        'interface that makes individual pieces of content "aware" of '
        'selection and able to respond to selection events.',
      ),
      _slSubheading('The Selection Architecture'),
      _slInfoCard(
        'Flutter\'s selection system has four layers:\n\n'
        '1. SelectionArea — the widget that wraps selectable content\n'
        '2. SelectableRegion — the state holder (gestures, overlay)\n'
        '3. SelectionRegistrar — the InheritedWidget that selectables\n'
        '   register with to join the selection tree\n'
        '4. Selectable — the interface each render object implements\n'
        '   to respond to selection events and report geometry',
        icon: Icons.layers,
      ),

      // Visual: Architecture diagram using containers
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _slIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slCobalt, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Selection Architecture',
              style: TextStyle(
                color: _slDarkCobalt,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Layer 1: SelectionArea
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _slCobalt,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'SelectionArea',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Layer 2: SelectableRegion
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _slSteel,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'SelectableRegion',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          'Owns gestures + overlay',
                          style: TextStyle(
                            color: _slLightSky,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Layer 3: Registrar
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _slSky,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'SelectionRegistrar',
                                style: TextStyle(
                                  color: _slNavy,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Layer 4: Selectable items
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _slSelectableBlock('Text A', _slAmber),
                                  _slSelectableBlock('Text B', _slCoral),
                                  _slSelectableBlock('Image', _slMint),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '↑ Each implements Selectable',
                                style: TextStyle(
                                  color: _slDarkCobalt,
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
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
          ],
        ),
      ),
      _slInfoCard(
        'When a SelectionArea is created, it provides a SelectionRegistrar '
        'via an InheritedWidget.  Every Selectable render object in the '
        'subtree finds that registrar and registers itself.  Then, when '
        'the user performs a selection gesture, SelectableRegion dispatches '
        'SelectionEvent objects to the registered selectables.',
        icon: Icons.gesture,
      ),
    ],
  );
}

Widget _slSelectableBlock(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _slNavy, width: 1),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — The Selectable Contract
// ---------------------------------------------------------------------------
Widget _slBuildContract() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '2. The Selectable Contract',
        subtitle: 'Methods and properties every Selectable must provide',
      ),
      const SizedBox(height: 12),
      _slInfoCard(
        'The Selectable mixin defines the full API that a render object needs '
        'to participate in selection.  Here are the key members:',
      ),
      _slCodeBlock(
        'mixin Selectable {\n'
        '  // Handle a selection event\n'
        '  SelectionResult dispatchSelectionEvent(\n'
        '    SelectionEvent event,\n'
        '  );\n'
        '\n'
        '  // Current selection geometry\n'
        '  // (handles, status, hasContent)\n'
        '  ValueListenable<SelectionGeometry> get value;\n'
        '\n'
        '  // Push handle layers for drag handles\n'
        '  void pushHandleLayers(\n'
        '    LayerLink? startHandle,\n'
        '    LayerLink? endHandle,\n'
        '  );\n'
        '}',
      ),
      _slSubheading('dispatchSelectionEvent()'),
      _slInfoCard(
        'This is the core method.  It receives a SelectionEvent—which may '
        'be a SelectAllSelectionEvent, ClearSelectionEvent, '
        'SelectionEdgeUpdateEvent, GranularlyExtendSelectionEvent, or '
        'DirectionallyExtendSelectionEvent—and must return a '
        'SelectionResult indicating what happened:\n\n'
        '• SelectionResult.next — event passed through, check next sibling\n'
        '• SelectionResult.end — event consumed, selection ended here\n'
        '• SelectionResult.pending — still processing (async)',
        icon: Icons.call_received,
      ),

      // Visual: dispatchSelectionEvent flow
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _slIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slSteel),
        ),
        child: Column(
          children: [
            const Text(
              'Event Dispatch Flow',
              style: TextStyle(
                color: _slDarkCobalt,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // The event box
            Container(
              width: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _slAmber,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'SelectionEvent',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _slNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const Icon(Icons.arrow_downward, color: _slCobalt, size: 24),
            // Dispatch
            Container(
              width: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _slCobalt,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'dispatchSelectionEvent()',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const Icon(Icons.arrow_downward, color: _slCobalt, size: 24),
            // Results
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _slResultChip('next', _slMint),
                _slResultChip('end', _slCoral),
                _slResultChip('pending', _slSteel),
              ],
            ),
          ],
        ),
      ),
      _slSubheading('SelectionGeometry (the value property)'),
      _slInfoCard(
        'The value property returns a ValueListenable<SelectionGeometry> '
        'so that the SelectableRegion can rebuild the selection overlay '
        'whenever selection changes.  SelectionGeometry contains:\n\n'
        '• status — none / uncollapsed / collapsed\n'
        '• hasContent — whether this selectable has any content\n'
        '• startSelectionPoint — position and direction of start handle\n'
        '• endSelectionPoint — position and direction of end handle',
        icon: Icons.crop_square,
      ),

      // Visual: SelectionGeometry fields
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _slCobalt),
        ),
        child: Column(
          children: [
            Row(
              children: [
                _slBadge('SelectionGeometry', _slCobalt),
              ],
            ),
            const SizedBox(height: 10),
            _slKeyValueRow('status', 'SelectionStatus (none | collapsed | uncollapsed)'),
            _slKeyValueRow('hasContent', 'bool — does this contain selectable content?'),
            _slKeyValueRow('startSelectionPoint', 'SelectionPoint? (offset + direction)'),
            _slKeyValueRow('endSelectionPoint', 'SelectionPoint? (offset + direction)'),
            _slDivider(),
            _slKeyValueRow('.hasSelection', 'true if status ≠ .none', valueColor: _slSteel),
          ],
        ),
      ),
      _slSubheading('pushHandleLayers()'),
      _slInfoCard(
        'After selection geometry changes, the SelectableRegion calls '
        'pushHandleLayers() on the selectable that owns each handle.  '
        'The selectable inserts LeaderLayers into the compositing tree '
        'so that the drag-handle overlays (FollowerLayers) track the '
        'correct positions.  If a handle moves to a different selectable, '
        'pushHandleLayers() is called with null to remove the old link.',
        icon: Icons.link,
      ),
    ],
  );
}

Widget _slResultChip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — SelectionEvent Hierarchy
// ---------------------------------------------------------------------------
Widget _slBuildEventHierarchy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '3. SelectionEvent Hierarchy',
        subtitle: 'The events a Selectable must be able to handle',
      ),
      const SizedBox(height: 12),
      _slInfoCard(
        'Every Selectable receives events through dispatchSelectionEvent().  '
        'The event hierarchy is the language the system uses to communicate '
        'selection intentions.',
      ),

      // Visual: Event tree
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _slIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slCobalt, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SelectionEvent (abstract)',
              style: TextStyle(
                color: _slDarkCobalt,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            _slEventTreeItem('SelectAllSelectionEvent', 'Ctrl+A / Cmd+A — select everything', _slAmber, 0),
            _slEventTreeItem('ClearSelectionEvent', 'Tap away — deselect everything', _slCoral, 0),
            _slEventTreeItem('SelectionEdgeUpdateEvent', 'Drag handle or initial tap — move an edge', _slMint, 0),
            _slEventTreeItem('GranularlyExtendSelectionEvent', 'Shift+Arrow — extend by word/line', _slSteel, 0),
            _slEventTreeItem('DirectionallyExtendSelectionEvent', 'Shift+Up/Down — extend across lines', _slCobalt, 0),
          ],
        ),
      ),

      _slSubheading('SelectionEdgeUpdateEvent'),
      _slInfoCard(
        'This is the most frequently dispatched event.  It carries:\n\n'
        '• globalPosition — where the user is pointing/dragging\n'
        '• type — SelectionEventType.startEdge or .endEdge\n'
        '• granularity — character, word, line, document\n\n'
        'The Selectable uses this position to determine which character '
        'the handle should snap to, then updates its SelectionGeometry.',
        icon: Icons.touch_app,
      ),

      _slSubheading('GranularlyExtendSelectionEvent'),
      _slInfoCard(
        'Extends the existing selection by a granularity unit (character, '
        'word, line, document) in a given direction.  This is what Shift+Arrow '
        'keys produce on desktop.  The Selectable adjusts its range and '
        'returns SelectionResult.end if the extension was consumed, or '
        '.next if it needs to spill to the next selectable.',
        icon: Icons.keyboard,
      ),

      _slSubheading('DirectionallyExtendSelectionEvent'),
      _slInfoCard(
        'Similar to granular extension but oriented spatially — extend up, '
        'down, left, right.  Used for Shift+Up/Down where the selection '
        'must cross logical lines and possibly cross into an adjacent Selectable.',
        icon: Icons.open_with,
      ),

      // Visual: Direction arrows
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slSteel),
        ),
        child: Column(
          children: [
            const Text(
              'Directional Extension',
              style: TextStyle(
                color: _slDarkCobalt,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 70),
                _slArrowButton(Icons.arrow_upward, 'Up'),
                const SizedBox(width: 70),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _slArrowButton(Icons.arrow_back, 'Left'),
                Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _slCobalt,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'Cursor',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
                _slArrowButton(Icons.arrow_forward, 'Right'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 70),
                _slArrowButton(Icons.arrow_downward, 'Down'),
                const SizedBox(width: 70),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _slEventTreeItem(String name, String desc, Color color, int indent) {
  return Padding(
    padding: EdgeInsets.only(left: 20.0 + indent * 16, top: 6, bottom: 6),
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
                  text: name,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
                TextSpan(
                  text: '  — $desc',
                  style: const TextStyle(
                    color: _slNavy,
                    fontSize: 11,
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

Widget _slArrowButton(IconData icon, String label) {
  return SizedBox(
    width: 70,
    height: 40,
    child: Container(
      decoration: BoxDecoration(
        color: _slSky,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: _slDarkCobalt, size: 16),
          Text(
            label,
            style: const TextStyle(color: _slDarkCobalt, fontSize: 9),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — Registration Lifecycle
// ---------------------------------------------------------------------------
Widget _slBuildRegistration() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '4. Registration Lifecycle',
        subtitle: 'How Selectables join and leave the selection tree',
      ),
      const SizedBox(height: 12),
      _slInfoCard(
        'A Selectable render object must register with a SelectionRegistrar '
        'to participate in selection.  The lifecycle is:\n\n'
        '1. attach() — find the registrar via SelectionContainer.maybeOf()\n'
        '2. registrar.add(this) — register as a selectable\n'
        '3. …receive events, report geometry…\n'
        '4. registrar.remove(this) — unregister when detaching\n'
        '5. detach()',
        icon: Icons.playlist_add_check,
      ),
      _slCodeBlock(
        '// Typical registration in a RenderObject:\n'
        '@override\n'
        'void attach(PipelineOwner owner) {\n'
        '  super.attach(owner);\n'
        '  _registrar = SelectionContainer\n'
        '      .maybeOf(context);\n'
        '  _registrar?.add(this);\n'
        '}\n'
        '\n'
        '@override\n'
        'void detach() {\n'
        '  _registrar?.remove(this);\n'
        '  _registrar = null;\n'
        '  super.detach();\n'
        '}',
      ),

      // Visual: Lifecycle timeline
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _slIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slCobalt),
        ),
        child: Column(
          children: [
            const Text(
              'Selectable Lifecycle',
              style: TextStyle(
                color: _slDarkCobalt,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            _slLifecycleStep(1, 'Created', 'RenderObject instantiated', _slSteel),
            _slLifecycleConnector(),
            _slLifecycleStep(2, 'Attached', 'Finds registrar, calls add()', _slCobalt),
            _slLifecycleConnector(),
            _slLifecycleStep(3, 'Active', 'Receives events, reports geometry', _slMint),
            _slLifecycleConnector(),
            _slLifecycleStep(4, 'Detaching', 'Calls remove(), nulls registrar', _slAmber),
            _slLifecycleConnector(),
            _slLifecycleStep(5, 'Detached', 'Fully removed from tree', _slCoral),
          ],
        ),
      ),
      _slInfoCard(
        'Important: The registrar is an InheritedWidget (SelectionRegistrarScope) '
        'that SelectableRegion places in the tree.  If there is no SelectionArea '
        'ancestor, the registrar is null and the render object is simply not '
        'selectable — no error, just silently non-participatory.',
        icon: Icons.warning_amber,
      ),
    ],
  );
}

Widget _slLifecycleStep(int step, String title, String desc, Color color) {
  return Row(
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
            '$step',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
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
                fontSize: 13,
              ),
            ),
            Text(
              desc,
              style: const TextStyle(
                color: _slNavy,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _slLifecycleConnector() {
  return Container(
    width: 2,
    height: 16,
    margin: const EdgeInsets.only(left: 15),
    color: _slSky,
  );
}

// ---------------------------------------------------------------------------
// Section 5 — SelectionArea in Practice
// ---------------------------------------------------------------------------
Widget _slBuildSelectionAreaDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '5. SelectionArea in Practice',
        subtitle: 'Using SelectionArea to make content selectable',
      ),
      const SizedBox(height: 12),
      _slInfoCard(
        'The easiest way to create Selectable content is to wrap a subtree '
        'in a SelectionArea widget. All Text widgets inside automatically '
        'become selectable through their render objects implementing the '
        'Selectable interface.',
        icon: Icons.select_all,
      ),
      _slCodeBlock(
        'SelectionArea(\n'
        '  child: Column(\n'
        '    children: [\n'
        '      Text(\'Paragraph one...\'),\n'
        '      Text(\'Paragraph two...\'),\n'
        '      Text(\'These are all selectable!\'),\n'
        '    ],\n'
        '  ),\n'
        ')',
      ),

      // Visual: SelectionArea demo
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slCobalt, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _slCobalt,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.select_all, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'SelectionArea Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  _slBadge('selectable', _slMint),
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
                      'The Selectable Interface',
                      style: TextStyle(
                        color: _slDarkCobalt,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This text is wrapped in a SelectionArea.  Every Text widget '
                      'below this point has its render object registered as a '
                      'Selectable with the SelectionRegistrar.',
                      style: TextStyle(
                        color: _slNavy.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Try selecting across these paragraphs.  The selection system '
                      'dispatches SelectionEdgeUpdateEvent as you drag, and each '
                      'Selectable\'s dispatchSelectionEvent() determines how many '
                      'characters fall within the selection range.',
                      style: TextStyle(
                        color: _slNavy.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _slLightSky,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Even this text inside a container is selectable, because '
                        'the SelectionRegistrar propagates through the entire subtree.',
                        style: TextStyle(
                          color: _slDarkCobalt,
                          fontSize: 13,
                          height: 1.5,
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
      _slInfoCard(
        'Behind the scenes, each Text widget\'s RenderParagraph (which mixes '
        'in Selectable) registered with the SelectionRegistrar.  When you '
        'drag, SelectableRegion computes which selectables are in range and '
        'dispatches events to each one in order.',
        icon: Icons.visibility,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Multiple SelectionAreas
// ---------------------------------------------------------------------------
Widget _slBuildMultipleAreas() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '6. Multiple Independent SelectionAreas',
        subtitle: 'Isolated selection contexts in the same screen',
      ),
      const SizedBox(height: 12),
      _slInfoCard(
        'Each SelectionArea creates its own SelectableRegion and registrar.  '
        'Selectables inside one area are isolated from another.  Selecting '
        'text in Area A does not affect Area B.',
      ),

      // Visual: Two independent selection areas side by side
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Area A
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _slCobalt, width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: _slCobalt,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Area A',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SelectionArea(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'This is selection area A.',
                              style: TextStyle(
                                color: _slNavy,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Content here is independently '
                              'selectable from area B. Each '
                              'area has its own registrar.',
                              style: TextStyle(
                                color: _slNavy.withValues(alpha: 0.85),
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Area B
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _slAmber, width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: _slAmber,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Area B',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _slNavy,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SelectionArea(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'This is selection area B.',
                              style: TextStyle(
                                color: _slNavy,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Selecting text here leaves area '
                              'A untouched. The isolation comes '
                              'from separate registrars.',
                              style: TextStyle(
                                color: _slNavy.withValues(alpha: 0.85),
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ],
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
      _slInfoCard(
        'This pattern is useful when you have a page with multiple content '
        'panels (chat messages, code blocks, article sections) where '
        'selection should be scoped to each panel independently.',
        icon: Icons.dashboard,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7 — SelectionArea Customization
// ---------------------------------------------------------------------------
Widget _slBuildCustomization() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '7. Customizing Selection Behavior',
        subtitle: 'Selection style, context menus, and callbacks',
      ),
      const SizedBox(height: 12),
      _slInfoCard(
        'SelectionArea exposes several properties to customize the selection '
        'experience.  While the Selectable interface handles the low-level '
        'mechanics, the SelectionArea widget provides the user-facing polish.',
      ),
      _slSubheading('Context Menu Builder'),
      _slInfoCard(
        'SelectionArea.contextMenuBuilder lets you replace the default '
        'copy/select-all context menu with a custom one.  The builder '
        'receives an EditableTextContextMenuBuilder context and the '
        'current selection.',
        icon: Icons.menu,
      ),
      _slCodeBlock(
        'SelectionArea(\n'
        '  contextMenuBuilder:\n'
        '      (context, selectableRegionState) {\n'
        '    return AdaptiveTextSelectionToolbar\n'
        '        .editableText(\n'
        '      editableTextState: selectableRegionState,\n'
        '    );\n'
        '  },\n'
        '  child: ...,\n'
        ')',
      ),

      // Visual: Custom context menu mockup
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _slIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slSteel),
        ),
        child: Column(
          children: [
            const Text(
              'Context Menu Options',
              style: TextStyle(
                color: _slDarkCobalt,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            // Mock context menu
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _slMenuEntry(Icons.copy, 'Copy', _slCobalt),
                  Container(height: 1, color: Colors.grey.withValues(alpha: 0.2)),
                  _slMenuEntry(Icons.select_all, 'Select All', _slSteel),
                  Container(height: 1, color: Colors.grey.withValues(alpha: 0.2)),
                  _slMenuEntry(Icons.share, 'Share', _slMint),
                  Container(height: 1, color: Colors.grey.withValues(alpha: 0.2)),
                  _slMenuEntry(Icons.translate, 'Translate', _slAmber),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Custom entries beyond default Copy/Select All',
              style: TextStyle(
                color: _slSteel,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),

      _slSubheading('Selection Controls Style'),
      _slInfoCard(
        'The appearance of selection handles and the highlight color can '
        'be customized through the SelectionArea\'s selectionControls '
        'property and the theme\'s TextSelectionThemeData.',
      ),

      // Visual: Different selection handle styles
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slCobalt),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selection Highlight Colors',
              style: TextStyle(
                color: _slDarkCobalt,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            _slHighlightSample('Default blue', const Color(0x663399FF), 'The standard highlight'),
            const SizedBox(height: 8),
            _slHighlightSample('Custom cobalt', _slCobalt.withValues(alpha: 0.3), 'Matches our theme'),
            const SizedBox(height: 8),
            _slHighlightSample('Amber accent', _slAmber.withValues(alpha: 0.35), 'Warm highlight style'),
            const SizedBox(height: 8),
            _slHighlightSample('Mint fresh', _slMint.withValues(alpha: 0.3), 'A unique green tint'),
          ],
        ),
      ),

      _slSubheading('onSelectionChanged Callback'),
      _slInfoCard(
        'SelectionArea.onSelectionChanged fires whenever the user\'s '
        'selection changes.  This lets you build features like word-count '
        'displays, selection-based search, or contextual toolbars.',
        icon: Icons.notifications_active,
      ),
      _slCodeBlock(
        'SelectionArea(\n'
        '  onSelectionChanged: (value) {\n'
        '    // value is a SelectedContent?\n'
        '    // containing the plain text\n'
        '    print(value?.plainText);\n'
        '  },\n'
        '  child: ...,\n'
        ')',
      ),
    ],
  );
}

Widget _slMenuEntry(IconData icon, String label, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _slHighlightSample(String label, Color bgColor, String desc) {
  return Row(
    children: [
      Container(
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          'Selected text',
          style: TextStyle(
            color: _slNavy,
            fontSize: 12,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: _slDarkCobalt,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              desc,
              style: const TextStyle(
                color: _slSteel,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Mixed Content Selection
// ---------------------------------------------------------------------------
Widget _slBuildMixedContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '8. Mixed Content Selection',
        subtitle: 'Selecting across text, rich text, and decorated blocks',
      ),
      const SizedBox(height: 12),
      _slInfoCard(
        'One of the powerful aspects of the Selectable system is that '
        'selection can span across multiple Text widgets of different '
        'styles, sizes, and decorations.  The SelectableRegion coordinates '
        'all registered selectables to provide a seamless cross-element '
        'selection experience.',
        icon: Icons.format_color_text,
      ),

      // Visual: Rich mixed-content selection area
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slCobalt, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: _slCobalt,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.article, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Article with Mixed Content',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  _slBadge('selectable', _slMint),
                ],
              ),
            ),
            SelectionArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'Understanding Flutter Selection',
                      style: TextStyle(
                        color: _slDarkCobalt,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Published April 2026  •  Technical Deep Dive',
                      style: TextStyle(
                        color: _slSteel.withValues(alpha: 0.8),
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Body paragraph
                    const Text(
                      'Flutter\'s selection system is built on the Selectable interface, '
                      'which each render object implements to join the selection tree.  '
                      'The beauty of this architecture is that selection flows seamlessly '
                      'across different text styles and even different widgets.',
                      style: TextStyle(
                        color: _slNavy,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Highlighted quote block
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _slAmber.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          left: BorderSide(
                            color: _slAmber,
                            width: 4,
                          ),
                        ),
                      ),
                      child: const Text(
                        '"The Selectable mixin transforms any render object into a '
                        'participant in the selection system, enabling rich document '
                        'experiences in Flutter."',
                        style: TextStyle(
                          color: _slNavy,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Another paragraph with bold/colored text
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: _slNavy,
                          fontSize: 13,
                          height: 1.6,
                        ),
                        children: [
                          const TextSpan(text: 'Each '),
                          TextSpan(
                            text: 'Selectable',
                            style: TextStyle(
                              color: _slCobalt,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ' reports its own ',
                          ),
                          TextSpan(
                            text: 'SelectionGeometry',
                            style: TextStyle(
                              color: _slMint,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ', and the ',
                          ),
                          TextSpan(
                            text: 'SelectableRegion',
                            style: TextStyle(
                              color: _slCoral,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ' merges them into a unified selection overlay.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Code-like block inside selection
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _slNavy,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'mixin Selectable {\n'
                        '  SelectionResult dispatchSelectionEvent(event);\n'
                        '  ValueListenable<SelectionGeometry> get value;\n'
                        '  void pushHandleLayers(start, end);\n'
                        '}',
                        style: TextStyle(
                          color: _slSky,
                          fontSize: 12,
                          fontFamily: 'monospace',
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'All the text above — the title, paragraphs, quote block, '
                      'rich text, and even the code block — is part of a single '
                      'SelectionArea.  Selection can flow across all of them.',
                      style: TextStyle(
                        color: _slSteel,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
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

// ---------------------------------------------------------------------------
// Section 9 — Selection with Scrollable Content
// ---------------------------------------------------------------------------
Widget _slBuildScrollableSelection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '9. Selection Inside Scrollable Content',
        subtitle: 'How Selectables work within scrolling containers',
      ),
      const SizedBox(height: 12),
      _slInfoCard(
        'When Selectable content is inside a scrollable (like ListView), '
        'the selection system must handle items scrolling in and out of '
        'view.  As items are recycled by the list\'s sliver protocol, '
        'their Selectable render objects detach and re-attach, updating '
        'the registrar each time.',
        icon: Icons.view_list,
      ),
      _slCodeBlock(
        'SelectionArea(\n'
        '  child: ListView.builder(\n'
        '    itemCount: 50,\n'
        '    itemBuilder: (context, index) {\n'
        '      return ListTile(\n'
        '        title: Text(\'Item \$index\'),\n'
        '        subtitle: Text(\'Selectable\'),\n'
        '      );\n'
        '    },\n'
        '  ),\n'
        ')',
      ),

      // Visual: Scrollable list with selection
      Container(
        margin: const EdgeInsets.all(16),
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slCobalt, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: _slCobalt,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Text(
                'Selectable Scrollable List',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: SelectionArea(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    final isEven = index.isEven;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isEven
                            ? _slLightSky
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _slSky.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isEven ? _slCobalt : _slSteel,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
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
                                  'Selectable item ${index + 1}',
                                  style: const TextStyle(
                                    color: _slNavy,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'This content participates in cross-item '
                                  'selection via the Selectable interface.',
                                  style: TextStyle(
                                    color: _slNavy.withValues(alpha: 0.7),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      _slInfoCard(
        'Key point: As items scroll out of view, their Selectable render '
        'objects call registrar.remove(this).  When they scroll back, they '
        'call registrar.add(this) again.  The SelectableRegion keeps track '
        'of the selection state even for currently-off-screen items, so that '
        'when they reappear they restore their selected highlighting.',
        icon: Icons.refresh,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 10 — Comparison Table: Sub-interfaces
// ---------------------------------------------------------------------------
Widget _slBuildComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '10. Selectable Sub-Interfaces & Related Types',
        subtitle: 'How Selectable connects to the broader selection API',
      ),
      const SizedBox(height: 12),
      _slInfoCard(
        'Selectable is the base, but the selection system has several related '
        'types that build on it or work alongside it.',
      ),

      // Visual: Comparison table
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _slCobalt),
        ),
        child: Column(
          children: [
            // Header row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: _slCobalt,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Type',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Role',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _slComparisonRow('Selectable', 'Base mixin — dispatchEvent, value, pushHandleLayers', false),
            _slComparisonRow('SelectionHandler', 'Extended Selectable that also manages child selectables', true),
            _slComparisonRow('SelectionRegistrar', 'InheritedWidget that selectables register with', false),
            _slComparisonRow('SelectableRegion', 'Widget/state that owns the full selection state', true),
            _slComparisonRow('SelectionArea', 'Convenience widget wrapping SelectableRegion', false),
            _slComparisonRow('SelectionContainer', 'Layout widget that groups child selectables', true),
            _slComparisonRow('SelectionGeometry', 'Data class: start/end handles, status, hasContent', false),
            _slComparisonRow('SelectionEvent', 'Abstract base for all selection commands', true),
            _slComparisonRow('SelectionResult', 'Enum: next / end / pending return from dispatch', false),
          ],
        ),
      ),

      _slSubheading('SelectionHandler vs Selectable'),
      _slInfoCard(
        'SelectionHandler extends Selectable with the ability to manage '
        'a collection of child Selectables.  A SelectionHandler receives '
        'events, decides which children are affected, and forwards the '
        'event to them — essentially acting as a selection router.  '
        'SelectionContainer.delegate is a SelectionHandler.',
        icon: Icons.account_tree,
      ),

      // Visual: Handler tree
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _slIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slCobalt),
        ),
        child: Column(
          children: [
            const Text(
              'SelectionHandler Tree',
              style: TextStyle(
                color: _slDarkCobalt,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            // Root handler
            Container(
              width: 220,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _slCobalt,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  Text(
                    'SelectionHandler',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'routes events to children',
                    style: TextStyle(
                      color: _slLightSky,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Connector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 1, height: 16, color: _slCobalt),
                const SizedBox(width: 60),
                Container(width: 1, height: 16, color: _slCobalt),
                const SizedBox(width: 60),
                Container(width: 1, height: 16, color: _slCobalt),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _slSelectableChip('Selectable A', _slMint),
                _slSelectableChip('Selectable B', _slAmber),
                _slSelectableChip('Selectable C', _slCoral),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _slComparisonRow(String type, String role, bool isAlt) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    color: isAlt ? _slLightSky.withValues(alpha: 0.4) : Colors.white,
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            type,
            style: const TextStyle(
              color: _slDarkCobalt,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            role,
            style: const TextStyle(
              color: _slNavy,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _slSelectableChip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 11 — Visual Gallery: Selection Patterns
// ---------------------------------------------------------------------------
Widget _slBuildPatternGallery() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '11. Selection Pattern Gallery',
        subtitle: 'Common selection scenarios visualized',
      ),
      const SizedBox(height: 12),

      // Pattern 1: Article layout
      _slSubheading('Pattern 1: Article Layout'),
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slSteel),
        ),
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'The Rise of Content Selection',
                  style: TextStyle(
                    color: _slDarkCobalt,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _slBadge('Flutter', _slCobalt),
                    const SizedBox(width: 6),
                    _slBadge('Selection', _slSteel),
                    const SizedBox(width: 6),
                    _slBadge('Rendering', _slMint),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'In Flutter 3.3, the SelectionArea widget was introduced, '
                  'bringing native-like text selection to Flutter apps.  '
                  'Before this, selecting text across multiple Text widgets '
                  'was extremely difficult.',
                  style: TextStyle(
                    color: _slNavy.withValues(alpha: 0.9),
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'The key innovation was the Selectable mixin — a standard '
                  'contract that any render object can implement.  This means '
                  'not just text, but images, charts, or custom content could '
                  'participate in the selection system.',
                  style: TextStyle(
                    color: _slNavy.withValues(alpha: 0.9),
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Pattern 2: Card-based content
      _slSubheading('Pattern 2: Selectable Card Grid'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SelectionArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _slContentCard(
                  'Selectable',
                  'The base interface for content selection participation',
                  _slCobalt,
                  Icons.touch_app,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _slContentCard(
                  'SelectionHandler',
                  'Routes events to child selectables in the tree',
                  _slSteel,
                  Icons.account_tree,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _slContentCard(
                  'SelectionArea',
                  'Widget wrapper that enables selection in a subtree',
                  _slMint,
                  Icons.select_all,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),

      // Pattern 3: Chat-like layout
      _slSubheading('Pattern 3: Chat Message Selection'),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _slIce,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slSteel),
        ),
        child: SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _slChatBubble(
                'Alice',
                'Have you used the Selectable interface yet?',
                _slCobalt,
                true,
              ),
              _slChatBubble(
                'Bob',
                'Yes! I wrapped my ListView in a SelectionArea and it just works.',
                _slMint,
                false,
              ),
              _slChatBubble(
                'Alice',
                'That\'s the beauty of it — RenderParagraph already implements '
                'Selectable, so all Text widgets are selection-ready.',
                _slCobalt,
                true,
              ),
              _slChatBubble(
                'Bob',
                'I heard you can also make custom render objects selectable '
                'by implementing the three methods.',
                _slMint,
                false,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _slContentCard(String title, String desc, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _slNavy,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _slChatBubble(String sender, String message, Color color, bool isLeft) {
  return Padding(
    padding: EdgeInsets.only(
      left: isLeft ? 0 : 40,
      right: isLeft ? 40 : 0,
      bottom: 8,
    ),
    child: Column(
      crossAxisAlignment:
          isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          sender,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: _slNavy,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 12 — When to Use and Best Practices
// ---------------------------------------------------------------------------
Widget _slBuildBestPractices() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slSectionHeader(
        '12. Best Practices & Summary',
        subtitle: 'Guidelines for working with Selectable content',
      ),
      const SizedBox(height: 12),

      _slSubheading('When to Use SelectionArea'),
      _slInfoCard(
        '✓  Article/blog content where users need to copy text\n'
        '✓  Chat interfaces where message text should be selectable\n'
        '✓  Documentation viewers and help pages\n'
        '✓  Any content-heavy screen where copy-paste is expected\n'
        '✗  Interactive forms (use TextField instead)\n'
        '✗  Navigation elements (buttons, tabs) — not useful\n'
        '✗  Canvas-based content (needs custom Selectable impl)',
        icon: Icons.checklist,
      ),

      _slSubheading('Performance Considerations'),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _slAmber.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _slAmber),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.speed, color: _slAmber, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Performance Notes',
                  style: TextStyle(
                    color: _slNavy,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '• Each Selectable registers a listener on the registrar — '
              'thousands of visible selectables may impact responsiveness.\n\n'
              '• Selection events are dispatched linearly through all '
              'registered selectables — large lists benefit from '
              'SelectionContainer to group and short-circuit.\n\n'
              '• pushHandleLayers() creates LeaderLayers in the compositing '
              'tree — keep the selectable count reasonable.\n\n'
              '• For very long scrollable lists, the natural recycling of '
              'slivers keeps the active selectable count bounded.',
              style: TextStyle(
                color: _slNavy,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),

      _slSubheading('Common Mistakes'),
      _slInfoCard(
        '1. Nesting SelectionAreas — inner area creates a separate '
        'registrar, preventing cross-area selection\n\n'
        '2. Forgetting SelectionArea around ListView — Text inside a '
        'ListView is NOT selectable by default\n\n'
        '3. Using SelectableText inside SelectionArea — SelectableText '
        'has its own selection mechanism, causing conflicts\n\n'
        '4. Not handling selection in custom RenderObjects — if your '
        'custom widget has text, implement Selectable or wrap in Text',
        icon: Icons.warning,
      ),

      _slSubheading('Summary'),
      // Visual: Summary card
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_slCobalt, _slDarkCobalt],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: _slAmber, size: 20),
                SizedBox(width: 8),
                Text(
                  'Selectable — Key Takeaways',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _slSummaryPoint(
              'Interface',
              'Selectable is a mixin with three core requirements: '
              'dispatchSelectionEvent(), value (SelectionGeometry), '
              'and pushHandleLayers().',
            ),
            _slSummaryPoint(
              'Registration',
              'Selectables register with a SelectionRegistrar provided '
              'by SelectableRegion (via SelectionArea).',
            ),
            _slSummaryPoint(
              'Events',
              'Five event types flow through: SelectAll, Clear, '
              'EdgeUpdate, GranularlyExtend, DirectionallyExtend.',
            ),
            _slSummaryPoint(
              'Built-in',
              'RenderParagraph already implements Selectable — just '
              'wrap your Text widgets in SelectionArea.',
            ),
            _slSummaryPoint(
              'Customizable',
              'Context menus, highlight colors, selection callbacks, '
              'and even custom Selectable implementations are supported.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _slSummaryPoint(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(
            color: _slAmber,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title — ',
                  style: const TextStyle(
                    color: _slSky,
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
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Main build function — entry point for d4rt interpreter
// ============================================================================
dynamic build(BuildContext context) {
  print('--- Selectable Deep Demo ---');
  print('Demonstrates the Selectable mixin/interface in Flutter\'s');
  print('rendering-layer selection system.');
  print('');
  print('Sections:');
  print('  1.  What Is Selectable?');
  print('  2.  The Selectable Contract');
  print('  3.  SelectionEvent Hierarchy');
  print('  4.  Registration Lifecycle');
  print('  5.  SelectionArea in Practice');
  print('  6.  Multiple Independent SelectionAreas');
  print('  7.  Customizing Selection Behavior');
  print('  8.  Mixed Content Selection');
  print('  9.  Selection Inside Scrollable Content');
  print(' 10.  Selectable Sub-Interfaces & Related Types');
  print(' 11.  Selection Pattern Gallery');
  print(' 12.  Best Practices & Summary');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _slCobalt,
      scaffoldBackgroundColor: _slIce,
      appBarTheme: const AppBarTheme(
        backgroundColor: _slDarkCobalt,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Selectable — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _slSky.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.touch_app, size: 14),
                SizedBox(width: 4),
                Text(
                  'Rendering',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1
            _slBuildOverview(),
            _slDivider(),

            // Section 2
            _slBuildContract(),
            _slDivider(),

            // Section 3
            _slBuildEventHierarchy(),
            _slDivider(),

            // Section 4
            _slBuildRegistration(),
            _slDivider(),

            // Section 5
            _slBuildSelectionAreaDemo(),
            _slDivider(),

            // Section 6
            _slBuildMultipleAreas(),
            _slDivider(),

            // Section 7
            _slBuildCustomization(),
            _slDivider(),

            // Section 8
            _slBuildMixedContent(),
            _slDivider(),

            // Section 9
            _slBuildScrollableSelection(),
            _slDivider(),

            // Section 10
            _slBuildComparison(),
            _slDivider(),

            // Section 11
            _slBuildPatternGallery(),
            _slDivider(),

            // Section 12
            _slBuildBestPractices(),
          ],
        ),
      ),
    ),
  );
}

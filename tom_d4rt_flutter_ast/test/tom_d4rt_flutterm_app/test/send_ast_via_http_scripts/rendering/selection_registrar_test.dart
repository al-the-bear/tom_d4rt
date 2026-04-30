// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SELECTION REGISTRAR — Deep Demo
// ============================================================================
//
// SelectionRegistrar is the server-side abstract class in the selection
// registration protocol.  While SelectionRegistrant is the client that
// registers, SelectionRegistrar is the registry that accepts and
// manages those registrations.
//
// Key responsibilities:
//   • Provides add(Selectable) to accept new registrants
//   • Provides remove(Selectable) to remove existing registrants
//   • Maintains an ordered collection of all registered selectables
//   • Dispatches selection events to registered selectables
//   • Is typically implemented by SelectableRegion's render object
//
// The concrete implementation (RenderSelectableRegion) also:
//   • Converts global gestures to local selection events
//   • Manages selection overlays (handles, toolbar)
//   • Computes merged selection geometry
//
// Color theme : Crimson (#B71C1C) / Coral (#EF9A9A)
// Helper prefix: _rg
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _rgCrimson = Color(0xFFB71C1C);
const Color _rgCoral = Color(0xFFEF9A9A);
const Color _rgDarkCrimson = Color(0xFF7F0000);
const Color _rgLightCoral = Color(0xFFFFEBEE);
const Color _rgFlame = Color(0xFFD32F2F);
const Color _rgCream = Color(0xFFFFF8E1);
const Color _rgCharcoal = Color(0xFF212121);
const Color _rgTeal = Color(0xFF00897B);
const Color _rgBlue = Color(0xFF1565C0);
const Color _rgViolet = Color(0xFF6A1B9A);
const Color _rgGold = Color(0xFFFFD600);
const Color _rgMint = Color(0xFF2E7D32);
const Color _rgSlate = Color(0xFF455A64);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _rgSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_rgCrimson, _rgDarkCrimson],
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

Widget _rgNote(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _rgLightCoral,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _rgCoral, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _rgCrimson, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _rgCharcoal,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _rgCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _rgCharcoal,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _rgCoral,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _rgSubtitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _rgCrimson,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _rgDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _rgCoral.withValues(alpha: 0.6),
  );
}

Widget _rgTag(String label, Color bg, {Color textColor = Colors.white}) {
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

// ---------------------------------------------------------------------------
// Section 1 — Overview
// ---------------------------------------------------------------------------
Widget _rgBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rgSectionHeader(
        '1. What Is SelectionRegistrar?',
        subtitle: 'The server-side registration interface',
      ),
      const SizedBox(height: 12),
      _rgNote(
        'SelectionRegistrar is an abstract class that defines the '
        'contract for a selection registry.  It has just two methods:\n\n'
        '• add(Selectable selectable) — register a new selectable\n'
        '• remove(Selectable selectable) — unregister a selectable\n\n'
        'The registrar is typically provided by SelectableRegion, which '
        'also handles gesture detection, overlay management, and event '
        'dispatching.',
      ),

      // Visual: Interface card
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _rgCrimson, width: 2),
          boxShadow: [
            BoxShadow(
              color: _rgCrimson.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.dns, color: _rgCrimson, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'SelectionRegistrar',
                  style: TextStyle(
                    color: _rgDarkCrimson,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                const Spacer(),
                _rgTag('abstract', _rgCrimson),
              ],
            ),
            const SizedBox(height: 14),
            _rgMethodRow('add()', 'Selectable → void', 'Register a selectable'),
            const SizedBox(height: 4),
            _rgMethodRow('remove()', 'Selectable → void', 'Unregister a selectable'),
          ],
        ),
      ),

      _rgCodeBlock(
        'abstract class SelectionRegistrar {\n'
        '  void add(Selectable selectable);\n'
        '  void remove(Selectable selectable);\n'
        '}\n'
        '\n'
        '// That\'s the entire interface!\n'
        '// The simplicity is intentional —\n'
        '// all complexity lives in the\n'
        '// concrete implementation.',
      ),

      _rgNote(
        'The minimalist interface means custom selection systems can '
        'easily implement a registrar.  The framework\'s concrete '
        'implementation (inside SelectableRegion) is far more complex, '
        'but the contract is just add() and remove().',
        icon: Icons.lightbulb_outline,
      ),
    ],
  );
}

Widget _rgMethodRow(String name, String sig, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Row(
      children: [
        Container(
          width: 6, height: 6,
          decoration: const BoxDecoration(
            color: _rgCrimson,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: const TextStyle(
              color: _rgDarkCrimson,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            sig,
            style: const TextStyle(
              color: _rgSlate,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              color: _rgCharcoal,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — Registrar vs Registrant
// ---------------------------------------------------------------------------
Widget _rgBuildComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rgSectionHeader(
        '2. Registrar vs. Registrant',
        subtitle: 'Two sides of the same protocol',
      ),
      const SizedBox(height: 12),
      _rgNote(
        'The registration protocol has exactly two roles.  The registrar '
        'is the central authority; the registrant is the participant.  '
        'Together they form a clean dependency-inversion pattern.',
      ),

      // Visual: Side-by-side comparison
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _rgCrimson.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _rgCrimson, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.dns, color: _rgCrimson, size: 20),
                        SizedBox(width: 6),
                        Text(
                          'SelectionRegistrar',
                          style: TextStyle(
                            color: _rgCrimson,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _rgCompareItem('Role', 'Server / Registry'),
                    _rgCompareItem('Type', 'Abstract class'),
                    _rgCompareItem('Location', 'Ancestor widget'),
                    _rgCompareItem('Owns', 'Collection of selectables'),
                    _rgCompareItem('Methods', 'add(), remove()'),
                    _rgCompareItem('Lifecycle', 'Lives in SelectableRegion'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _rgViolet.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _rgViolet, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.app_registration, color: _rgViolet, size: 20),
                        const SizedBox(width: 6),
                        const Text(
                          'SelectionRegistrant',
                          style: TextStyle(
                            color: _rgViolet,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _rgCompareItem('Role', 'Client / Participant'),
                    _rgCompareItem('Type', 'Mixin'),
                    _rgCompareItem('Location', 'Render object'),
                    _rgCompareItem('Owns', 'Single registrar ref'),
                    _rgCompareItem('Property', 'registrar setter'),
                    _rgCompareItem('Lifecycle', 'attach/detach hooks'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Visual: Analogy
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _rgCream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _rgGold),
        ),
        child: Row(
          children: [
            const Icon(Icons.emoji_objects, color: _rgGold, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Analogy: Hotel Check-In',
                    style: TextStyle(
                      color: _rgCharcoal,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Registrar = Front Desk (accepts guests)\n'
                    'Registrant = Guest (checks in/out)\n'
                    'add() = Check in\n'
                    'remove() = Check out',
                    style: TextStyle(
                      color: _rgCharcoal.withValues(alpha: 0.8),
                      fontSize: 11,
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
  );
}

Widget _rgCompareItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(
              color: _rgSlate,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: _rgCharcoal,
              fontSize: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — Concrete Implementation
// ---------------------------------------------------------------------------
Widget _rgBuildImplementation() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rgSectionHeader(
        '3. The Concrete Implementation',
        subtitle: 'Inside SelectableRegion\'s render object',
      ),
      const SizedBox(height: 12),
      _rgNote(
        'The framework\'s concrete SelectionRegistrar lives inside '
        'RenderSelectableRegion (the render object for SelectableRegion).  '
        'This class does far more than just track registrants — it orchestrates '
        'the entire selection lifecycle.',
      ),

      // Visual: Architecture layers
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _rgCrimson, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'RenderSelectableRegion Architecture',
              style: TextStyle(
                color: _rgDarkCrimson,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            _rgArchLayer(
              'Gesture Detection',
              'Interprets taps, drags, long-presses',
              _rgBlue,
              Icons.touch_app,
            ),
            const SizedBox(height: 6),
            _rgArchLayer(
              'Event Dispatching',
              'Converts gestures to SelectionEvents',
              _rgTeal,
              Icons.send,
            ),
            const SizedBox(height: 6),
            _rgArchLayer(
              'Registrar Interface ◀ you are here',
              'add() / remove() — tracks selectables',
              _rgCrimson,
              Icons.dns,
            ),
            const SizedBox(height: 6),
            _rgArchLayer(
              'Geometry Aggregation',
              'Merges individual geometries',
              _rgViolet,
              Icons.merge_type,
            ),
            const SizedBox(height: 6),
            _rgArchLayer(
              'Overlay Management',
              'Handles, toolbar, magnifier',
              _rgMint,
              Icons.layers,
            ),
          ],
        ),
      ),

      _rgCodeBlock(
        '// Simplified concrete implementation:\n'
        'class RenderSelectableRegion\n'
        '    extends RenderProxyBox\n'
        '    implements SelectionRegistrar {\n'
        '\n'
        '  final List<Selectable> _selectables = [];\n'
        '\n'
        '  @override\n'
        '  void add(Selectable s) {\n'
        '    _selectables.add(s);\n'
        '    s.addListener(_onGeometryChanged);\n'
        '    markNeedsPaint();\n'
        '  }\n'
        '\n'
        '  @override\n'
        '  void remove(Selectable s) {\n'
        '    s.removeListener(\n'
        '        _onGeometryChanged);\n'
        '    _selectables.remove(s);\n'
        '    markNeedsPaint();\n'
        '  }\n'
        '}',
      ),
    ],
  );
}

Widget _rgArchLayer(String title, String desc, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: _rgCharcoal,
                  fontSize: 10,
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
// Section 4 — Event Dispatching Flow
// ---------------------------------------------------------------------------
Widget _rgBuildEventFlow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rgSectionHeader(
        '4. Event Dispatching Flow',
        subtitle: 'From user gesture to selection update',
      ),
      const SizedBox(height: 12),
      _rgNote(
        'When a user drags to select text, the registrar receives the '
        'gesture and converts it into a series of SelectionEvents.  '
        'It dispatches these events to each registered selectable in order.',
        icon: Icons.timeline,
      ),

      // Visual: Event flow
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _rgCream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _rgCrimson),
        ),
        child: Column(
          children: [
            const Text(
              'Selection Event Flow',
              style: TextStyle(
                color: _rgDarkCrimson,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            _rgFlowStep(1, 'User drags finger/mouse', _rgBlue),
            _rgFlowArrow(),
            _rgFlowStep(2, 'GestureRecognizer fires onDragUpdate', _rgBlue),
            _rgFlowArrow(),
            _rgFlowStep(3, 'Registrar creates SelectionEdgeUpdateEvent', _rgCrimson),
            _rgFlowArrow(),
            _rgFlowStep(4, 'Dispatches to all registered selectables', _rgCrimson),
            _rgFlowArrow(),
            _rgFlowStep(5, 'Each selectable updates its geometry', _rgViolet),
            _rgFlowArrow(),
            _rgFlowStep(6, 'Registrar aggregates geometries', _rgCrimson),
            _rgFlowArrow(),
            _rgFlowStep(7, 'Selection handles + highlights update', _rgMint),
          ],
        ),
      ),

      _rgCodeBlock(
        '// When user drags (simplified):\n'
        'void _handleDragUpdate(DragUpdateDetails d) {\n'
        '  final event = SelectionEdgeUpdateEvent\n'
        '      .forEnd(\n'
        '    globalPosition: d.globalPosition,\n'
        '  );\n'
        '  // Dispatch to every registered\n'
        '  // selectable in paint order\n'
        '  for (final s in _selectables) {\n'
        '    s.dispatchSelectionEvent(event);\n'
        '  }\n'
        '  _updateSelectionOverlays();\n'
        '}',
      ),
    ],
  );
}

Widget _rgFlowStep(int num, String text, Color color) {
  return Row(
    children: [
      Container(
        width: 24, height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$num',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

Widget _rgFlowArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 11, top: 2, bottom: 2),
    child: Icon(Icons.arrow_downward, color: _rgCoral, size: 14),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — The Selectable Collection
// ---------------------------------------------------------------------------
Widget _rgBuildCollection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rgSectionHeader(
        '5. Managing the Selectable Collection',
        subtitle: 'Ordering, traversal, and geometry merging',
      ),
      const SizedBox(height: 12),
      _rgNote(
        'The registrar maintains selectables in an ordered list.  The '
        'order matters because it determines which selectable gets '
        'selection events first and how text flows logically across '
        'multiple selectable regions.',
      ),

      // Visual: Ordered list with operations
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _rgCrimson, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Selectable Collection Operations',
              style: TextStyle(
                color: _rgDarkCrimson,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            // Operation cards
            _rgOperationCard(
              'add(selectable)',
              'Appends to the list.  Order typically matches paint order '
              '(top-to-bottom, left-to-right in LTR).',
              Icons.add_circle,
              _rgMint,
            ),
            const SizedBox(height: 8),
            _rgOperationCard(
              'remove(selectable)',
              'Removes from the list.  Also removes the listener that '
              'tracked geometry changes.',
              Icons.remove_circle,
              _rgFlame,
            ),
            const SizedBox(height: 8),
            _rgOperationCard(
              'iterate for dispatch',
              'Events are dispatched in list order.  Each selectable '
              'reports back whether it handled the event.',
              Icons.loop,
              _rgBlue,
            ),
            const SizedBox(height: 8),
            _rgOperationCard(
              'geometry merge',
              'The registrar reads each selectable\'s geometry and '
              'computes the combined selection bounds.',
              Icons.merge_type,
              _rgViolet,
            ),
          ],
        ),
      ),

      _rgSubtitle('Visual: Collection State'),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _rgLightCoral,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _rgSelectableBox('P1', _rgCrimson, true),
            const SizedBox(width: 4),
            _rgSelectableBox('Img', _rgBlue, true),
            const SizedBox(width: 4),
            _rgSelectableBox('P2', _rgCrimson, true),
            const SizedBox(width: 4),
            _rgSelectableBox('P3', _rgCrimson, false),
            const SizedBox(width: 4),
            _rgSelectableBox('P4', _rgCrimson, false),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _rgTag('selected', _rgCrimson),
            const SizedBox(width: 8),
            _rgTag('not selected', _rgSlate),
          ],
        ),
      ),
    ],
  );
}

Widget _rgOperationCard(String title, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
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
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  color: _rgCharcoal,
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

Widget _rgSelectableBox(String label, Color color, bool isSelected) {
  return Container(
    width: 50, height: 40,
    decoration: BoxDecoration(
      color: isSelected ? color.withValues(alpha: 0.15) : _rgSlate.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: isSelected ? color : _rgSlate.withValues(alpha: 0.3),
        width: isSelected ? 2 : 1,
      ),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? color : _rgSlate,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — SelectionContainer.maybeOf
// ---------------------------------------------------------------------------
Widget _rgBuildMaybeOf() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rgSectionHeader(
        '6. Accessing the Registrar',
        subtitle: 'SelectionContainer.maybeOf — the inherited lookup',
      ),
      const SizedBox(height: 12),
      _rgNote(
        'Widgets don\'t create a SelectionRegistrar directly.  Instead, '
        'SelectionArea or SelectableRegion creates one and injects it '
        'into the widget tree via an InheritedWidget called '
        'SelectionContainer.  Descendants access it with:\n\n'
        'SelectionContainer.maybeOf(context)',
        icon: Icons.search,
      ),

      _rgCodeBlock(
        '// How widgets access the registrar:\n'
        'final registrar = SelectionContainer\n'
        '    .maybeOf(context);\n'
        '\n'
        '// Returns null if there is no ancestor\n'
        '// SelectionArea — this is safe and\n'
        '// expected for non-selectable contexts.\n'
        '\n'
        '// Non-null means a registrar exists\n'
        '// and the widget can register.',
      ),

      // Visual: Lookup chain
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _rgCrimson),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inherited Widget Lookup Chain',
              style: TextStyle(
                color: _rgDarkCrimson,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            _rgLookupLevel('SelectionArea', 'Creates registrar', _rgTeal, true),
            _rgLookupLevel('SelectionContainer', 'InheritedWidget', _rgBlue, false),
            _rgLookupLevel('Column / Padding / etc.', 'Passes through', _rgSlate, false),
            _rgLookupLevel('Text widget', 'Calls maybeOf()', _rgViolet, false),
            _rgLookupLevel('RenderParagraph', 'Sets registrar property', _rgCrimson, true),
          ],
        ),
      ),

      _rgNote(
        'SelectionContainer also supports disabling selection for a '
        'subtree.  Setting SelectionContainer.disabled wraps children '
        'with a null registrar, effectively preventing registration.',
        icon: Icons.block,
      ),

      _rgCodeBlock(
        '// Disable selection in a subtree:\n'
        'SelectionContainer.disabled(\n'
        '  child: Text(\'Not selectable\'),\n'
        ')\n'
        '// maybeOf() returns null inside this\n'
        '// subtree, so no registration occurs.',
      ),
    ],
  );
}

Widget _rgLookupLevel(String label, String desc, Color color, bool isKey) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 8, height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: isKey ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: isKey ? BorderRadius.circular(2) : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: isKey ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 8),
              Text(
                desc,
                style: const TextStyle(
                  color: _rgSlate,
                  fontSize: 10,
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
// Section 7 — Registrar Scope and Nesting
// ---------------------------------------------------------------------------
Widget _rgBuildScoping() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rgSectionHeader(
        '7. Registrar Scope & Nesting',
        subtitle: 'Each SelectionArea creates its own registrar scope',
      ),
      const SizedBox(height: 12),
      _rgNote(
        'Every SelectionArea widget creates a unique registrar instance.  '
        'This means nested SelectionAreas create separate, independent '
        'selection scopes.  Text in one scope cannot be selected together '
        'with text in another scope.',
      ),

      // Visual: Scoping
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _rgCrimson, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Scope Isolation',
              style: TextStyle(
                color: _rgDarkCrimson,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            // Two independent registrar scopes
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _rgCrimson.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _rgCrimson, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.dns, color: _rgCrimson, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Registrar A',
                              style: TextStyle(
                                color: _rgCrimson,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _rgMiniBox('T1', _rgCrimson),
                            _rgMiniBox('T2', _rgCrimson),
                            _rgMiniBox('T3', _rgCrimson),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      const Icon(Icons.block, color: _rgFlame, size: 16),
                      Text(
                        'isolated',
                        style: TextStyle(
                          color: _rgFlame.withValues(alpha: 0.7),
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _rgTeal.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _rgTeal, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.dns, color: _rgTeal, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Registrar B',
                              style: TextStyle(
                                color: _rgTeal,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _rgMiniBox('T4', _rgTeal),
                            _rgMiniBox('T5', _rgTeal),
                          ],
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

      // Live demo
      _rgSubtitle('Live: Two Independent Registrar Scopes'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _rgCrimson, width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: _rgCrimson,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Registrar A',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                    SelectionArea(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Text registered with scope A.  '
                          'Selection cannot leave this area.',
                          style: TextStyle(
                            color: _rgCharcoal.withValues(alpha: 0.9),
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _rgTeal, width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: _rgTeal,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Registrar B',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                    SelectionArea(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Text registered with scope B.  '
                          'Independent from scope A.',
                          style: TextStyle(
                            color: _rgCharcoal.withValues(alpha: 0.9),
                            fontSize: 12,
                            height: 1.5,
                          ),
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
    ],
  );
}

Widget _rgMiniBox(String label, Color color) {
  return Container(
    width: 28, height: 22,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Custom Registrar Implementations
// ---------------------------------------------------------------------------
Widget _rgBuildCustom() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rgSectionHeader(
        '8. Custom Registrar Implementations',
        subtitle: 'Extending SelectionRegistrar for special behaviors',
      ),
      const SizedBox(height: 12),
      _rgNote(
        'Because SelectionRegistrar is abstract, you can create your '
        'own implementation for specialized selection behaviors.  '
        'This is useful for features like:\n\n'
        '• Filtering which selectables participate\n'
        '• Logging selection events\n'
        '• Programmatic selection control',
        icon: Icons.build,
      ),

      _rgCodeBlock(
        '// A logging registrar wrapper:\n'
        'class LoggingRegistrar\n'
        '    implements SelectionRegistrar {\n'
        '  final SelectionRegistrar _delegate;\n'
        '  LoggingRegistrar(this._delegate);\n'
        '\n'
        '  @override\n'
        '  void add(Selectable s) {\n'
        '    debugPrint(\'Registered: \$s\');\n'
        '    _delegate.add(s);\n'
        '  }\n'
        '\n'
        '  @override\n'
        '  void remove(Selectable s) {\n'
        '    debugPrint(\'Unregistered: \$s\');\n'
        '    _delegate.remove(s);\n'
        '  }\n'
        '}',
      ),

      _rgSubtitle('Potential Custom Registrars'),
      // Visual: Use cases
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          children: [
            _rgUseCaseCard(
              'FilteredRegistrar',
              'Only registers selectables that match a predicate.  '
              'Useful for making certain elements non-selectable '
              'without removing them from the tree.',
              Icons.filter_list,
              _rgBlue,
            ),
            const SizedBox(height: 6),
            _rgUseCaseCard(
              'ReadOnlyRegistrar',
              'Prevents modification of the selection.  Accepts '
              'registrations but ignores update events.',
              Icons.lock,
              _rgViolet,
            ),
            const SizedBox(height: 6),
            _rgUseCaseCard(
              'AnalyticsRegistrar',
              'Tracks which content gets selected most often.  '
              'Useful for understanding user reading patterns.',
              Icons.analytics,
              _rgMint,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _rgUseCaseCard(String title, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 10),
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
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  color: _rgCharcoal,
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
// Section 9 — Summary
// ---------------------------------------------------------------------------
Widget _rgBuildSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rgSectionHeader(
        '9. Summary & Key Takeaways',
        subtitle: 'SelectionRegistrar in a nutshell',
      ),
      const SizedBox(height: 12),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_rgCrimson, _rgDarkCrimson],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: _rgGold, size: 18),
                SizedBox(width: 8),
                Text(
                  'SelectionRegistrar — Key Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _rgSummaryItem('Interface', 'Abstract class with just add() and remove().'),
            _rgSummaryItem('Role', 'Server side — manages registered selectables.'),
            _rgSummaryItem('Implementation', 'RenderSelectableRegion implements it.'),
            _rgSummaryItem('Collection', 'Ordered list of Selectable objects.'),
            _rgSummaryItem('Dispatching', 'Sends selection events to all registrants.'),
            _rgSummaryItem('Access', 'SelectionContainer.maybeOf(context).'),
            _rgSummaryItem('Scoping', 'Each SelectionArea has its own registrar.'),
            _rgSummaryItem('Extensible', 'Custom implementations for filtering, logging.'),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _rgSummaryItem(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6, height: 6,
          margin: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(color: _rgGold, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: '$title — ',
                style: const TextStyle(
                  color: _rgCoral,
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

// ============================================================================
// Main build function
// ============================================================================
dynamic build(BuildContext context) {
  print('--- SelectionRegistrar Deep Demo ---');
  print('Demonstrates the SelectionRegistrar abstract class that');
  print('manages registration of Selectable render objects.');
  print('');
  print('Sections:');
  print('  1.  What Is SelectionRegistrar?');
  print('  2.  Registrar vs. Registrant');
  print('  3.  The Concrete Implementation');
  print('  4.  Event Dispatching Flow');
  print('  5.  Managing the Selectable Collection');
  print('  6.  Accessing the Registrar');
  print('  7.  Registrar Scope & Nesting');
  print('  8.  Custom Registrar Implementations');
  print('  9.  Summary & Key Takeaways');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _rgCrimson,
      scaffoldBackgroundColor: _rgCream,
      appBarTheme: const AppBarTheme(
        backgroundColor: _rgDarkCrimson,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionRegistrar — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _rgCoral.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.dns, size: 14),
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
            _rgBuildOverview(),
            _rgDivider(),
            _rgBuildComparison(),
            _rgDivider(),
            _rgBuildImplementation(),
            _rgDivider(),
            _rgBuildEventFlow(),
            _rgDivider(),
            _rgBuildCollection(),
            _rgDivider(),
            _rgBuildMaybeOf(),
            _rgDivider(),
            _rgBuildScoping(),
            _rgDivider(),
            _rgBuildCustom(),
            _rgDivider(),
            _rgBuildSummary(),
          ],
        ),
      ),
    ),
  );
}

// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SELECTION REGISTRANT — Deep Demo
// ============================================================================
//
// SelectionRegistrant is a mixin applied to render objects that want
// to participate in the selection system.  It manages the lifecycle
// of registering and unregistering with a SelectionRegistrar.
//
// Key responsibilities:
//   • Stores a reference to the SelectionRegistrar (the registry)
//   • Automatically registers when the registrar is set
//   • Automatically unregisters when detached or registrar changes
//   • Ensures the render object is discoverable by SelectableRegion
//
// The registration protocol works like this:
//   1. A parent widget (usually SelectionArea) provides a registrar
//   2. The render object acquires the registrar via its parent
//   3. The registrant mixin calls registrar.add(this) to register
//   4. When the registrar changes or the object is disposed, it
//      calls registrar.remove(this)
//
// Color theme : Violet (#6A1B9A) / Lavender (#CE93D8)
// Helper prefix: _sr
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _srViolet = Color(0xFF6A1B9A);
const Color _srLavender = Color(0xFFCE93D8);
const Color _srDarkViolet = Color(0xFF38006B);
const Color _srLightLavender = Color(0xFFF3E5F5);
const Color _srPlum = Color(0xFF7B1FA2);
const Color _srCream = Color(0xFFFFF8E1);
const Color _srCharcoal = Color(0xFF212121);
const Color _srTeal = Color(0xFF00897B);
const Color _srBlue = Color(0xFF1565C0);
const Color _srOrange = Color(0xFFE65100);
const Color _srGold = Color(0xFFFFD600);
const Color _srSlate = Color(0xFF455A64);
const Color _srMint = Color(0xFF2E7D32);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _srSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_srViolet, _srDarkViolet],
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

Widget _srNote(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _srLightLavender,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _srLavender, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _srViolet, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _srCharcoal,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _srCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _srCharcoal,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _srLavender,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _srSubtitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _srViolet,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _srDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _srLavender.withValues(alpha: 0.6),
  );
}

Widget _srTag(String label, Color bg, {Color textColor = Colors.white}) {
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
// Section 1 — Overview: What Is SelectionRegistrant?
// ---------------------------------------------------------------------------
Widget _srBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _srSectionHeader(
        '1. What Is SelectionRegistrant?',
        subtitle: 'The mixin that auto-registers Selectables',
      ),
      const SizedBox(height: 12),
      _srNote(
        'SelectionRegistrant is a mixin on RenderObject that implements '
        'the "registrant" half of the selection registration protocol.\n\n'
        'When applied, it gives a render object automatic lifecycle '
        'management for registering with a SelectionRegistrar.  '
        'You set the registrar property, and the mixin handles the rest.',
      ),

      // Visual: registrant card
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _srViolet, width: 2),
          boxShadow: [
            BoxShadow(
              color: _srViolet.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.app_registration, color: _srViolet, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'SelectionRegistrant',
                  style: TextStyle(
                    color: _srDarkViolet,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                const Spacer(),
                _srTag('mixin', _srViolet),
              ],
            ),
            const SizedBox(height: 14),
            _srPropertyRow(
              'registrar',
              'SelectionRegistrar?',
              'The registry this object registers with',
            ),
            const SizedBox(height: 4),
            _srPropertyRow(
              'register()',
              'inherited',
              'Called when registrar is set (auto)',
            ),
            const SizedBox(height: 4),
            _srPropertyRow(
              'unregister()',
              'inherited',
              'Called when registrar changes/detaches (auto)',
            ),
          ],
        ),
      ),

      _srNote(
        'In practice, you rarely interact with SelectionRegistrant '
        'directly.  It works behind the scenes in RenderParagraph '
        'and other built-in selectable render objects.',
        icon: Icons.visibility_off,
      ),
    ],
  );
}

Widget _srPropertyRow(String name, String type, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Row(
      children: [
        Container(
          width: 6, height: 6,
          decoration: const BoxDecoration(
            color: _srViolet,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: Text(
            name,
            style: const TextStyle(
              color: _srDarkViolet,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: Text(
            type,
            style: const TextStyle(
              color: _srSlate,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              color: _srCharcoal,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — The Registration Protocol
// ---------------------------------------------------------------------------
Widget _srBuildProtocol() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _srSectionHeader(
        '2. The Registration Protocol',
        subtitle: 'How Selectables find their SelectionRegistrar',
      ),
      const SizedBox(height: 12),
      _srNote(
        'The registration protocol has two sides.  The SelectionRegistrar '
        '(server) is typically provided by SelectionArea or SelectableRegion.  '
        'The SelectionRegistrant (client) lives inside each selectable '
        'render object.\n\n'
        'Think of it like a pub/sub system:\n'
        '• The registrar says "I manage the selection for this subtree"\n'
        '• Each registrant says "Here I am, include me in selections"',
        icon: Icons.handshake,
      ),

      // Visual: Two-sided protocol diagram
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _srViolet, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Registration Protocol',
              style: TextStyle(
                color: _srDarkViolet,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                // Server side
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _srTeal.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _srTeal, width: 1.5),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.dns, color: _srTeal, size: 28),
                        const SizedBox(height: 6),
                        const Text(
                          'SelectionRegistrar',
                          style: TextStyle(
                            color: _srTeal,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 6),
                        _srTag('Server', _srTeal),
                        const SizedBox(height: 8),
                        const Text(
                          '• Accepts add()\n'
                          '• Accepts remove()\n'
                          '• Tracks all selectables\n'
                          '• Dispatches events',
                          style: TextStyle(
                            color: _srCharcoal,
                            fontSize: 10,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Arrow between
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      const Icon(Icons.arrow_forward, color: _srPlum, size: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _srPlum.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'add()',
                          style: TextStyle(
                            color: _srPlum,
                            fontSize: 9,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Icon(Icons.arrow_back, color: _srOrange, size: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _srOrange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'remove()',
                          style: TextStyle(
                            color: _srOrange,
                            fontSize: 9,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Client side
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _srViolet.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _srViolet, width: 1.5),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.app_registration, color: _srViolet, size: 28),
                        const SizedBox(height: 6),
                        const Text(
                          'SelectionRegistrant',
                          style: TextStyle(
                            color: _srViolet,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 6),
                        _srTag('Client', _srViolet),
                        const SizedBox(height: 8),
                        const Text(
                          '• Has registrar prop\n'
                          '• Auto-registers\n'
                          '• Auto-unregisters\n'
                          '• Provides geometry',
                          style: TextStyle(
                            color: _srCharcoal,
                            fontSize: 10,
                            height: 1.5,
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
  );
}

// ---------------------------------------------------------------------------
// Section 3 — Registrar Property Lifecycle
// ---------------------------------------------------------------------------
Widget _srBuildLifecycle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _srSectionHeader(
        '3. Registrar Property Lifecycle',
        subtitle: 'What happens when the registrar is set, changed, or removed',
      ),
      const SizedBox(height: 12),
      _srNote(
        'The registrar property is the central mechanism.  Setting it '
        'triggers registration; clearing it triggers unregistration.  '
        'The mixin handles all edge cases automatically.',
      ),

      // Visual: State machine
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _srCream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _srViolet),
        ),
        child: Column(
          children: [
            const Text(
              'State Transitions',
              style: TextStyle(
                color: _srDarkViolet,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            _srLifecycleStep(
              'Initial',
              'registrar = null',
              'Render object exists but is not registered with any registrar.',
              _srSlate,
              Icons.circle_outlined,
            ),
            _srLifecycleArrow('registrar = registrarA'),
            _srLifecycleStep(
              'Registered',
              'registrarA.add(this)',
              'Object is now part of the selection tree.  '
              'SelectableRegion can see it.',
              _srMint,
              Icons.check_circle,
            ),
            _srLifecycleArrow('registrar = registrarB'),
            _srLifecycleStep(
              'Re-registered',
              'registrarA.remove(this)\nregistrarB.add(this)',
              'Old registrar is cleaned up, new one takes over.  '
              'This can happen during reparenting.',
              _srBlue,
              Icons.swap_horiz,
            ),
            _srLifecycleArrow('registrar = null'),
            _srLifecycleStep(
              'Unregistered',
              'registrarB.remove(this)',
              'Object is removed from the selection tree.  '
              'No more selection events will reach it.',
              _srOrange,
              Icons.cancel,
            ),
          ],
        ),
      ),

      _srCodeBlock(
        '// Simplified from SelectionRegistrant mixin:\n'
        'set registrar(SelectionRegistrar? value) {\n'
        '  if (value == _registrar) return;\n'
        '  // Clean up old registration\n'
        '  if (value == null) {\n'
        '    _registrar!.remove(this);\n'
        '  } else if (_registrar != null) {\n'
        '    _registrar!.remove(this);\n'
        '    value.add(this);\n'
        '  } else {\n'
        '    value.add(this);\n'
        '  }\n'
        '  _registrar = value;\n'
        '}',
      ),
    ],
  );
}

Widget _srLifecycleStep(String state, String action, String desc, Color color, IconData icon) {
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
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    state,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _srTag(action, color),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  color: _srCharcoal,
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

Widget _srLifecycleArrow(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        const SizedBox(width: 10),
        const Icon(Icons.arrow_downward, color: _srPlum, size: 16),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: _srPlum,
            fontSize: 10,
            fontFamily: 'monospace',
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — Where the Registrar Comes From
// ---------------------------------------------------------------------------
Widget _srBuildRegistrarSource() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _srSectionHeader(
        '4. Where Does the Registrar Come From?',
        subtitle: 'The inherited widget chain from SelectionArea to render objects',
      ),
      const SizedBox(height: 12),
      _srNote(
        'The SelectionRegistrar is provided by a SelectionArea widget '
        '(or a raw SelectableRegion).  The widget injects the registrar '
        'into the tree via an inherited widget.  Render objects that use '
        'the SelectionRegistrant mixin look up this inherited value.',
        icon: Icons.account_tree,
      ),

      // Visual: Widget tree
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _srViolet, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Widget Tree: Registrar Propagation',
              style: TextStyle(
                color: _srDarkViolet,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            _srTreeNode('SelectionArea', _srTeal, 0, isRoot: true),
            _srTreeNode('SelectableRegion (creates registrar)', _srTeal, 1),
            _srTreeNode('InheritedWidget (provides registrar)', _srBlue, 2),
            _srTreeNode('Column', _srSlate, 3),
            _srTreeNode('Text → RenderParagraph', _srViolet, 4, isHighlight: true),
            _srTreeNode('Text → RenderParagraph', _srViolet, 4, isHighlight: true),
            _srTreeNode('Text → RenderParagraph', _srViolet, 4, isHighlight: true),
          ],
        ),
      ),

      _srNote(
        'Each RenderParagraph uses the SelectionRegistrant mixin.  When '
        'attached to the tree, it receives the registrar from the '
        'inherited context and registers itself.  When detached, it '
        'auto-unregisters.',
        icon: Icons.link,
      ),

      _srCodeBlock(
        '// In RenderParagraph (simplified):\n'
        'class RenderParagraph extends RenderBox\n'
        '    with SelectionHandlerMixin,\n'
        '         SelectionRegistrant {\n'
        '\n'
        '  @override\n'
        '  void attach(PipelineOwner owner) {\n'
        '    super.attach(owner);\n'
        '    registrar = SelectionContainer\n'
        '        .maybeOf(context);\n'
        '  }\n'
        '\n'
        '  @override\n'
        '  void detach() {\n'
        '    registrar = null; // auto-unregisters\n'
        '    super.detach();\n'
        '  }\n'
        '}',
      ),
    ],
  );
}

Widget _srTreeNode(String label, Color color, int depth, {bool isRoot = false, bool isHighlight = false}) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 20.0, top: 4, bottom: 4),
    child: Row(
      children: [
        if (!isRoot)
          Container(
            width: 12,
            height: 1,
            color: _srLavender,
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isHighlight ? color.withValues(alpha: 0.12) : color.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: color,
              width: isHighlight ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isHighlight)
                const Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Icon(Icons.app_registration, size: 12, color: _srViolet),
                ),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
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
// Section 5 — Multiple Registrants
// ---------------------------------------------------------------------------
Widget _srBuildMultipleRegistrants() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _srSectionHeader(
        '5. Multiple Registrants Under One Registrar',
        subtitle: 'How a registrar keeps track of all its selectables',
      ),
      const SizedBox(height: 12),
      _srNote(
        'A single SelectionRegistrar can manage many registrants.  Each '
        'paragraph, image, or custom selectable registers independently.  '
        'The registrar maintains an ordered list and dispatches selection '
        'events to each in the correct order.',
      ),

      // Visual: Multiple registrants
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _srCream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _srViolet),
        ),
        child: Column(
          children: [
            // Central registrar
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _srTeal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _srTeal, width: 2),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dns, color: _srTeal, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'SelectionRegistrar',
                    style: TextStyle(
                      color: _srTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Connection lines
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (_) {
                return Container(width: 2, height: 20, color: _srLavender);
              }),
            ),
            const SizedBox(height: 4),
            // Registrants
            Row(
              children: [
                Expanded(child: _srRegistrantCard('Text A', 0, _srViolet)),
                const SizedBox(width: 6),
                Expanded(child: _srRegistrantCard('Image', 1, _srBlue)),
                const SizedBox(width: 6),
                Expanded(child: _srRegistrantCard('Text B', 2, _srViolet)),
                const SizedBox(width: 6),
                Expanded(child: _srRegistrantCard('Text C', 3, _srViolet)),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _srViolet.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Selection events are dispatched in registration order.\n'
                'The registrar iterates: Text A → Image → Text B → Text C',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _srCharcoal,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),

      _srCodeBlock(
        '// The registrar maintains an ordered list:\n'
        '// [TextA, Image, TextB, TextC]\n'
        '//\n'
        '// When a selection event arrives, it\'s\n'
        '// dispatched to each registrant in order:\n'
        'for (final selectable in _selectables) {\n'
        '  selectable.dispatchSelectionEvent(event);\n'
        '}',
      ),
    ],
  );
}

Widget _srRegistrantCard(String label, int index, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Icon(Icons.app_registration, color: color, size: 16),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 2),
        _srTag('#$index', color),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Detaching and Reparenting
// ---------------------------------------------------------------------------
Widget _srBuildDetaching() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _srSectionHeader(
        '6. Detaching & Reparenting',
        subtitle: 'Automatic cleanup when render objects move or are removed',
      ),
      const SizedBox(height: 12),
      _srNote(
        'One of the key benefits of the mixin is automatic cleanup.  '
        'When a render object is detached from the tree (removed or '
        'reparented), the registrant automatically unregisters.  '
        'This prevents stale references and selection ghosts.',
        icon: Icons.cleaning_services,
      ),

      // Visual: Detach sequence
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _srViolet),
        ),
        child: Column(
          children: [
            _srSequenceStep(
              'Before Remove',
              'Registrar has [A, B, C] registered',
              [
                _srStatusDot('A', _srMint),
                _srStatusDot('B', _srMint),
                _srStatusDot('C', _srMint),
              ],
            ),
            const SizedBox(height: 10),
            const Icon(Icons.arrow_downward, color: _srPlum, size: 16),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _srOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _srOrange),
              ),
              child: const Text(
                'Widget B is removed from tree',
                style: TextStyle(
                  color: _srOrange,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Icon(Icons.arrow_downward, color: _srPlum, size: 16),
            const SizedBox(height: 10),
            _srSequenceStep(
              'After Detach',
              'Registrar now has [A, C] — B auto-removed',
              [
                _srStatusDot('A', _srMint),
                _srStatusDot('B', _srOrange),
                _srStatusDot('C', _srMint),
              ],
            ),
          ],
        ),
      ),

      _srSubtitle('Reparenting Scenario'),
      _srNote(
        'If a render object is reparented (moved to a different '
        'subtree), it detaches from the old parent — triggering '
        'unregister — then reattaches under the new parent, where '
        'it may register with a different registrar.',
        icon: Icons.swap_vert,
      ),

      _srCodeBlock(
        '// In the render object:\n'
        '@override\n'
        'void detach() {\n'
        '  // Setting registrar to null triggers\n'
        '  // automatic unregistration via mixin\n'
        '  registrar = null;\n'
        '  super.detach();\n'
        '}\n'
        '\n'
        '@override\n'
        'void attach(PipelineOwner owner) {\n'
        '  super.attach(owner);\n'
        '  // New registrar may be different\n'
        '  registrar = SelectionContainer\n'
        '      .maybeOf(context);\n'
        '}',
      ),
    ],
  );
}

Widget _srSequenceStep(String title, String desc, List<Widget> dots) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _srLightLavender,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _srDarkViolet,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          desc,
          style: const TextStyle(color: _srCharcoal, fontSize: 11),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dots,
        ),
      ],
    ),
  );
}

Widget _srStatusDot(String label, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6),
    child: Column(
      children: [
        Container(
          width: 24, height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          color == _srOrange ? 'removed' : 'active',
          style: TextStyle(
            color: color,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — Nested SelectionAreas
// ---------------------------------------------------------------------------
Widget _srBuildNestedAreas() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _srSectionHeader(
        '7. Nested Selection Areas',
        subtitle: 'When registrants serve different registrars',
      ),
      const SizedBox(height: 12),
      _srNote(
        'It\'s possible to nest selection areas.  When this happens, '
        'each subtree has its own registrar, and registrants only '
        'register with their nearest ancestor registrar.  This '
        'creates isolated selection scopes.',
      ),

      // Visual: Nested areas
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _srViolet, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Nested Selection Scopes',
              style: TextStyle(
                color: _srDarkViolet,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            // Outer area
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _srTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _srTeal, width: 2),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _srTag('Outer', _srTeal),
                      const SizedBox(width: 8),
                      const Text(
                        'Registrar A',
                        style: TextStyle(
                          color: _srTeal,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _srSmallRegistrant('P1', _srTeal),
                      const SizedBox(width: 6),
                      _srSmallRegistrant('P2', _srTeal),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Inner area
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _srViolet.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _srViolet, width: 2),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _srTag('Inner', _srViolet),
                            const SizedBox(width: 8),
                            const Text(
                              'Registrar B',
                              style: TextStyle(
                                color: _srViolet,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _srSmallRegistrant('P3', _srViolet),
                            const SizedBox(width: 6),
                            _srSmallRegistrant('P4', _srViolet),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _srSmallRegistrant('P5', _srTeal),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _srLightLavender,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'P1, P2, P5 → Registrar A (outer)\n'
                'P3, P4 → Registrar B (inner)\n'
                'Selecting in the inner area does NOT affect the outer area.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _srCharcoal,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),

      // Live demo: Two areas
      _srSubtitle('Live: Two Independent Selection Scopes'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _srTeal, width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: _srTeal,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Scope A',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    SelectionArea(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'These paragraphs are registered '
                          'with Registrar A.  Selection here '
                          'is independent.',
                          style: TextStyle(
                            color: _srCharcoal.withValues(alpha: 0.9),
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
                  border: Border.all(color: _srViolet, width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: _srViolet,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Scope B',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    SelectionArea(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'These paragraphs are registered '
                          'with Registrar B.  Selection here '
                          'cannot cross into Scope A.',
                          style: TextStyle(
                            color: _srCharcoal.withValues(alpha: 0.9),
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

Widget _srSmallRegistrant(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.text_fields, size: 12, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Common Patterns and Best Practices
// ---------------------------------------------------------------------------
Widget _srBuildPatterns() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _srSectionHeader(
        '8. Common Patterns & Best Practices',
        subtitle: 'Using the registrant mixin correctly in custom widgets',
      ),
      const SizedBox(height: 12),

      _srSubtitle('Pattern 1: Standard Registration'),
      _srCodeBlock(
        'class MyRenderSelectable extends RenderBox\n'
        '    with SelectionRegistrant {\n'
        '\n'
        '  @override\n'
        '  void attach(PipelineOwner owner) {\n'
        '    super.attach(owner);\n'
        '    // Acquire the nearest registrar\n'
        '    registrar = SelectionContainer\n'
        '        .maybeOf(context);\n'
        '  }\n'
        '\n'
        '  @override\n'
        '  void detach() {\n'
        '    registrar = null;\n'
        '    super.detach();\n'
        '  }\n'
        '}',
      ),

      _srSubtitle('Pattern 2: Conditional Registration'),
      _srNote(
        'Sometimes a widget should only be selectable in certain states.  '
        'You can control this by setting registrar to null when the widget '
        'should not participate in selection.',
        icon: Icons.toggle_on,
      ),
      _srCodeBlock(
        '// Only register when enabled:\n'
        'set selectable(bool value) {\n'
        '  if (value) {\n'
        '    registrar = _cachedRegistrar;\n'
        '  } else {\n'
        '    registrar = null;\n'
        '    // auto-unregisters!\n'
        '  }\n'
        '}',
      ),

      _srSubtitle('Pattern 3: Registration Verification'),
      _srNote(
        'In debug mode, you can verify registration state by checking '
        'whether the registrar property is non-null after attach(). '
        'A null registrar means there is no ancestor SelectionArea.',
        icon: Icons.bug_report,
      ),

      // Visual: Best practices checklist
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _srMint.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _srMint),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.checklist, color: _srMint, size: 18),
                SizedBox(width: 8),
                Text(
                  'Best Practices',
                  style: TextStyle(
                    color: _srMint,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _srCheckItem('Always set registrar = null in detach()'),
            _srCheckItem('Always set registrar in attach() after super'),
            _srCheckItem('Use maybeOf() — registrar can be null legally'),
            _srCheckItem('Never call add()/remove() directly — the mixin does this'),
            _srCheckItem('Handle re-registration when registrar changes'),
          ],
        ),
      ),
    ],
  );
}

Widget _srCheckItem(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: _srMint, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _srCharcoal,
              fontSize: 12,
              height: 1.3,
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
Widget _srBuildSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _srSectionHeader(
        '9. Summary & Key Takeaways',
        subtitle: 'SelectionRegistrant in a nutshell',
      ),
      const SizedBox(height: 12),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_srViolet, _srDarkViolet],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: _srGold, size: 18),
                SizedBox(width: 8),
                Text(
                  'SelectionRegistrant — Key Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _srSummaryItem('Role', 'Client mixin — registers with a SelectionRegistrar.'),
            _srSummaryItem('Key Property', 'registrar — set it to register, null to unregister.'),
            _srSummaryItem('Lifecycle', 'Set in attach(), cleared in detach().'),
            _srSummaryItem('Auto Management', 'Handles add() and remove() automatically.'),
            _srSummaryItem('Registrar Source', 'Inherited from SelectionArea or SelectableRegion.'),
            _srSummaryItem('Ordering', 'Registrants are ordered by registration time.'),
            _srSummaryItem('Nesting', 'Each nested scope has its own registrar.'),
            _srSummaryItem('Best Practice', 'Never call add()/remove() directly on the registrar.'),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _srSummaryItem(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6, height: 6,
          margin: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(color: _srGold, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: '$title — ',
                style: const TextStyle(
                  color: _srLavender,
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
  print('--- SelectionRegistrant Deep Demo ---');
  print('Demonstrates the SelectionRegistrant mixin that auto-registers');
  print('render objects with a SelectionRegistrar.');
  print('');
  print('Sections:');
  print('  1.  What Is SelectionRegistrant?');
  print('  2.  The Registration Protocol');
  print('  3.  Registrar Property Lifecycle');
  print('  4.  Where Does the Registrar Come From?');
  print('  5.  Multiple Registrants Under One Registrar');
  print('  6.  Detaching & Reparenting');
  print('  7.  Nested Selection Areas');
  print('  8.  Common Patterns & Best Practices');
  print('  9.  Summary & Key Takeaways');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _srViolet,
      scaffoldBackgroundColor: _srCream,
      appBarTheme: const AppBarTheme(
        backgroundColor: _srDarkViolet,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionRegistrant — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _srLavender.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.app_registration, size: 14),
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
            _srBuildOverview(),
            _srDivider(),
            _srBuildProtocol(),
            _srDivider(),
            _srBuildLifecycle(),
            _srDivider(),
            _srBuildRegistrarSource(),
            _srDivider(),
            _srBuildMultipleRegistrants(),
            _srDivider(),
            _srBuildDetaching(),
            _srDivider(),
            _srBuildNestedAreas(),
            _srDivider(),
            _srBuildPatterns(),
            _srDivider(),
            _srBuildSummary(),
          ],
        ),
      ),
    ),
  );
}

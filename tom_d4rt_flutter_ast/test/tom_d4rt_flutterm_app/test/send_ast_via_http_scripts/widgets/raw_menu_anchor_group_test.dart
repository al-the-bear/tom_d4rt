// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawMenuAnchorGroup
// Demonstrates the RawMenuAnchorGroup widget — a grouping container that
// coordinates multiple RawMenuAnchor children under a single MenuController.
// RawMenuAnchorGroup acts as the root node in a menu hierarchy, handling
// tap-outside dismissal and child lifecycle coordination without
// rendering its own overlay or popup.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawMenuAnchorGroup Deep Demo executing');

  // ============================================================
  // SECTION 1: What RawMenuAnchorGroup Is — Concept
  // ============================================================
  print('=== Section 1: RawMenuAnchorGroup Concept ===');

  // RawMenuAnchorGroup is a StatefulWidget that provides a shared
  // MenuController scope for a subtree of RawMenuAnchor widgets.
  //
  // It does NOT create an overlay or popup itself. Instead it acts
  // as a coordination layer:
  //   - Provides TapRegion grouping so taps outside any menu in the
  //     group close all open children
  //   - Manages a MenuController that tracks the "isOpen" state of
  //     the entire group (true when ANY child anchor is open)
  //   - Handles close() by cascading through all child anchors
  //   - The open() method is a no-op since the group itself has
  //     no overlay; only child RawMenuAnchors open menus
  //
  // Constructor:
  //   const RawMenuAnchorGroup({
  //     super.key,
  //     required this.child,
  //     required this.controller,
  //   })
  //
  // Typical use: wrapping a MenuBar-like row of menu triggers.

  final conceptCard = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF9C27B0), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RawMenuAnchorGroup',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A coordination container for a group of menu anchors. '
          'Provides shared TapRegion grouping and a unified '
          'MenuController scope for managing multiple menu triggers.',
          style: TextStyle(fontSize: 14, color: Color(0xFF4A148C)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildConceptChip('Coordination', Icons.hub),
            _buildConceptChip('TapRegion', Icons.touch_app),
            _buildConceptChip('MenuController', Icons.settings_remote),
            _buildConceptChip('No Overlay', Icons.layers_clear),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Constructor & Required Parameters
  // ============================================================
  print('=== Section 2: Constructor & Required Parameters ===');

  // RawMenuAnchorGroup has exactly two required parameters:
  //
  // 1. controller: MenuController
  //    - The shared controller for the entire group
  //    - isOpen returns true when ANY child anchor is open
  //    - close() cascades to close ALL child anchors
  //    - open() is a no-op (no overlay to open)
  //
  // 2. child: Widget
  //    - The widget subtree containing menu triggers (RawMenuAnchors)
  //    - Wrapped in a TapRegion keyed to the controller

  final paramCards = Row(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF3F51B5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.settings_remote, color: Color(0xFF283593), size: 20),
                  const SizedBox(width: 6),
                  const Text(
                    'controller',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF283593),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Type: MenuController\n'
                'Required: Yes\n\n'
                'The shared controller. isOpen reflects '
                'any child being open. close() cascades '
                'through all children.',
                style: TextStyle(fontSize: 12, color: Color(0xFF1A237E)),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF4CAF50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.widgets, color: Color(0xFF2E7D32), size: 20),
                  const SizedBox(width: 6),
                  const Text(
                    'child',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Type: Widget\n'
                'Required: Yes\n\n'
                'Subtree containing RawMenuAnchor widgets. '
                'Wrapped in a TapRegion for outside-tap '
                'dismissal.',
                style: TextStyle(fontSize: 12, color: Color(0xFF1B5E20)),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 3: Widget Tree Structure
  // ============================================================
  print('=== Section 3: Widget Tree Structure ===');

  // RawMenuAnchorGroup builds a TapRegion wrapper around the child.
  // The TapRegion groupId is the root MenuController, meaning all
  // child RawMenuAnchors that inherit this controller share the
  // same TapRegion group, so a tap outside ANY menu closes ALL.
  //
  // Internal build output:
  //
  //   TapRegion(
  //     groupId: root.menuController,
  //     onTapOutside: handleOutsideTap,
  //     child: widget.child,
  //   )
  //
  // The mixin (_RawMenuAnchorBaseMixin) manages a list of child
  // anchors. When close() is called on the group, it calls
  // closeChildren() which iterates each registered child and
  // closes it in turn.

  final treeStructure = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFF9800)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Internal Build Output',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 12),
        _buildTreeNode('RawMenuAnchorGroup', 0, const Color(0xFF6A1B9A)),
        _buildTreeNode('└─ TapRegion', 1, const Color(0xFF1565C0)),
        _buildTreeNode('   groupId: controller', 2, const Color(0xFF757575)),
        _buildTreeNode('   onTapOutside: handler', 2, const Color(0xFF757575)),
        _buildTreeNode('   └─ child (your widget)', 2, const Color(0xFF2E7D32)),
        const SizedBox(height: 16),
        const Text(
          'When a tap occurs outside any TapRegion member in this '
          'group, handleOutsideTap fires and closes all menus.',
          style: TextStyle(fontSize: 12, color: Color(0xFFF57F17)),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Lifecycle & Coordination
  // ============================================================
  print('=== Section 4: Lifecycle & Coordination ===');

  // Key lifecycle aspects:
  //
  // 1. Mounting: controller._attach(this) is called in initState.
  //    This binds the MenuController to this group node.
  //
  // 2. isOpen: Returns true if ANY registered child anchor is open.
  //    It checks: _anchorChildren.any((child) => child.isOpen)
  //
  // 3. close(): Calls closeChildren() which iterates all registered
  //    child anchors and calls close() on each. Then schedules a
  //    setState to rebuild.
  //
  // 4. open(): A no-op. The group itself has no overlay.
  //    Only child RawMenuAnchors can open.
  //
  // 5. didUpdateWidget: If the controller changes, detaches old
  //    controller and attaches new one.
  //
  // 6. Disposing: controller._detach(this) via the mixin's dispose.

  final lifecycleSteps = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF009688)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lifecycle Flow',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
          ),
        ),
        const SizedBox(height: 12),
        _buildLifecycleStep(1, 'initState', 'controller._attach(this)', const Color(0xFF00897B)),
        _buildLifecycleArrow(),
        _buildLifecycleStep(2, 'build', 'TapRegion(groupId: controller, ...)', const Color(0xFF00897B)),
        _buildLifecycleArrow(),
        _buildLifecycleStep(3, 'child opens', 'isOpen → true (any child open)', const Color(0xFFE65100)),
        _buildLifecycleArrow(),
        _buildLifecycleStep(4, 'tap outside', 'handleOutsideTap → close()', const Color(0xFFC62828)),
        _buildLifecycleArrow(),
        _buildLifecycleStep(5, 'close()', 'closeChildren() → setState()', const Color(0xFFC62828)),
        _buildLifecycleArrow(),
        _buildLifecycleStep(6, 'dispose', 'controller._detach(this)', const Color(0xFF37474F)),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Live RawMenuAnchorGroup Example
  // ============================================================
  print('=== Section 5: Live RawMenuAnchorGroup Example ===');

  // This section shows a live RawMenuAnchorGroup wrapping two
  // RawMenuAnchor children — a mini menu bar.

  final liveGroup = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF7E57C2), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Live: RawMenuAnchorGroup with Two Anchors',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4527A0),
          ),
        ),
        const SizedBox(height: 12),
        _LiveMenuBarDemo(),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFD1C4E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'The two menu buttons above share a single '
            'RawMenuAnchorGroup. Tapping outside any open '
            'menu closes all menus in the group. The group\'s '
            'controller.isOpen is true when either menu is open.',
            style: TextStyle(fontSize: 12, color: Color(0xFF311B92)),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: TapRegion Grouping Behavior
  // ============================================================
  print('=== Section 6: TapRegion Grouping Behavior ===');

  // The key behavior of RawMenuAnchorGroup is TapRegion coordination.
  //
  // 1. The group creates a TapRegion with groupId = controller
  // 2. Each child RawMenuAnchor also creates TapRegions with
  //    groupId = root.menuController (same controller!)
  // 3. This means a tap on any sibling anchor's TapRegion
  //    is NOT "outside" — so it doesn't dismiss
  // 4. A tap on a completely unrelated widget IS "outside"
  //    and triggers handleOutsideTap → close all

  final tapRegionCards = Column(
    children: [
      _buildBehaviorCard(
        'Same Group → Not Outside',
        'Tapping on another menu trigger within the same '
        'RawMenuAnchorGroup does NOT count as an outside tap. '
        'The open menu closes and the tapped menu opens seamlessly.',
        Icons.check_circle,
        const Color(0xFF4CAF50),
        const Color(0xFFE8F5E9),
      ),
      const SizedBox(height: 10),
      _buildBehaviorCard(
        'Different Widget → Outside',
        'Tapping anywhere outside the group\'s TapRegion '
        'triggers handleOutsideTap, which closes ALL open '
        'menus in the group via closeChildren().',
        Icons.cancel,
        const Color(0xFFF44336),
        const Color(0xFFFFEBEE),
      ),
      const SizedBox(height: 10),
      _buildBehaviorCard(
        'Nested Groups',
        'RawMenuAnchorGroup can be nested. A child group\'s '
        'TapRegion is within the parent group\'s region, so '
        'tapping on a nested menu doesn\'t dismiss the parent.',
        Icons.account_tree,
        const Color(0xFF2196F3),
        const Color(0xFFE3F2FD),
      ),
    ],
  );

  // ============================================================
  // SECTION 7: MenuController Integration
  // ============================================================
  print('=== Section 7: MenuController Integration ===');

  // The MenuController passed to RawMenuAnchorGroup exposes:
  //
  // - isOpen: true if any child anchor has an open menu
  // - close(): closes all menus in the subtree
  // - open(): no-op for groups (no overlay to open)
  //
  // MenuController.maybeOf(context): from a descendant,
  // retrieves the controller of the closest RawMenuAnchor
  // or RawMenuAnchorGroup ancestor.

  final controllerIntegration = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE91E63)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MenuController with Group',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        const SizedBox(height: 12),
        _buildControllerRow('isOpen', 'true if ANY child anchor is open', Icons.visibility),
        const SizedBox(height: 8),
        _buildControllerRow('close()', 'cascades close to ALL children', Icons.close),
        const SizedBox(height: 8),
        _buildControllerRow('open()', 'no-op — groups have no overlay', Icons.block),
        const SizedBox(height: 8),
        _buildControllerRow('maybeOf(ctx)', 'retrieves nearest ancestor controller', Icons.search),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8BBD0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Code pattern:\n'
            '  final ctrl = MenuController();\n'
            '  RawMenuAnchorGroup(\n'
            '    controller: ctrl,\n'
            '    child: Row(\n'
            '      children: [\n'
            '        RawMenuAnchor(controller: ..., ...),\n'
            '        RawMenuAnchor(controller: ..., ...),\n'
            '      ],\n'
            '    ),\n'
            '  )',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Color(0xFF880E4F),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Comparison — RawMenuAnchorGroup vs MenuBar
  // ============================================================
  print('=== Section 8: RawMenuAnchorGroup vs MenuBar ===');

  // RawMenuAnchorGroup is the low-level foundation.
  // MenuBar adds Material theming, focus management, and
  // standard keyboard navigation on top of it.

  final comparisonTable = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF9E9E9E)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RawMenuAnchorGroup vs MenuBar',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 12),
        _buildComparisonHeader(),
        _buildComparisonRow(
          'Layer',
          'widgets (low-level)',
          'material (high-level)',
        ),
        _buildComparisonRow(
          'Overlay',
          'None — groups only',
          'Full menu bar overlay',
        ),
        _buildComparisonRow(
          'Theming',
          'None — bring own',
          'Material MenuBarTheme',
        ),
        _buildComparisonRow(
          'Focus Mgmt',
          'Manual',
          'Built-in with shortcuts',
        ),
        _buildComparisonRow(
          'Keyboard Nav',
          'Not provided',
          'Arrow keys, Esc, Enter',
        ),
        _buildComparisonRow(
          'Semantics',
          'Minimal (TapRegion)',
          'Full menu semantics',
        ),
        _buildComparisonRow(
          'Use Case',
          'Custom menu systems',
          'Standard menu bars',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: API Property Reference
  // ============================================================
  print('=== Section 9: API Property Reference ===');

  final apiReference = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF3F51B5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'API Property Reference',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF283593),
          ),
        ),
        const SizedBox(height: 12),
        _buildApiCard(
          'controller',
          'MenuController',
          'Required',
          'The shared controller for the group. Tracks open state '
          'of all children. close() cascades to all child anchors.',
        ),
        const SizedBox(height: 10),
        _buildApiCard(
          'child',
          'Widget',
          'Required',
          'The widget subtree containing RawMenuAnchor widgets. '
          'Wrapped in a TapRegion for unified outside-tap handling.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Inherited from StatefulWidget',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5C6BC0),
          ),
        ),
        const SizedBox(height: 8),
        _buildApiCard(
          'key',
          'Key?',
          'Optional',
          'Standard widget key for identity and state preservation.',
        ),
      ],
    ),
  );

  // ============================================================
  // Assemble all sections
  // ============================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'RawMenuAnchorGroup — Deep Demo',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Coordination container for grouped menu anchors',
          style: TextStyle(fontSize: 14, color: Color(0xFF7B1FA2)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),

        // Section 1
        _buildSectionHeader(1, 'Concept'),
        const SizedBox(height: 8),
        conceptCard,
        const SizedBox(height: 24),

        // Section 2
        _buildSectionHeader(2, 'Constructor & Required Parameters'),
        const SizedBox(height: 8),
        paramCards,
        const SizedBox(height: 24),

        // Section 3
        _buildSectionHeader(3, 'Widget Tree Structure'),
        const SizedBox(height: 8),
        treeStructure,
        const SizedBox(height: 24),

        // Section 4
        _buildSectionHeader(4, 'Lifecycle & Coordination'),
        const SizedBox(height: 8),
        lifecycleSteps,
        const SizedBox(height: 24),

        // Section 5
        _buildSectionHeader(5, 'Live RawMenuAnchorGroup Example'),
        const SizedBox(height: 8),
        liveGroup,
        const SizedBox(height: 24),

        // Section 6
        _buildSectionHeader(6, 'TapRegion Grouping Behavior'),
        const SizedBox(height: 8),
        tapRegionCards,
        const SizedBox(height: 24),

        // Section 7
        _buildSectionHeader(7, 'MenuController Integration'),
        const SizedBox(height: 8),
        controllerIntegration,
        const SizedBox(height: 24),

        // Section 8
        _buildSectionHeader(8, 'RawMenuAnchorGroup vs MenuBar'),
        const SizedBox(height: 8),
        comparisonTable,
        const SizedBox(height: 24),

        // Section 9
        _buildSectionHeader(9, 'API Property Reference'),
        const SizedBox(height: 8),
        apiReference,
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ============================================================
// Helper: Section header
// ============================================================
Widget _buildSectionHeader(int number, String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF7E57C2), Color(0xFF9C27B0)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.white24,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Concept chip
// ============================================================
Widget _buildConceptChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0xFFCE93D8),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF4A148C)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A148C),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Tree node visualization
// ============================================================
Widget _buildTreeNode(String label, int depth, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 16.0, top: 4, bottom: 4),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontFamily: 'monospace',
        fontWeight: depth == 0 ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    ),
  );
}

// ============================================================
// Helper: Lifecycle step
// ============================================================
Widget _buildLifecycleStep(int step, String phase, String detail, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                phase,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: color.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Lifecycle arrow
// ============================================================
Widget _buildLifecycleArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 22),
    child: Icon(Icons.arrow_downward, size: 16, color: Color(0xFF80CBC4)),
  );
}

// ============================================================
// Helper: Behavior card
// ============================================================
Widget _buildBehaviorCard(
  String title,
  String description,
  IconData icon,
  Color accentColor,
  Color bgColor,
) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accentColor.withOpacity(0.5)),
    ),
    child: Row(
      children: [
        Icon(icon, color: accentColor, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: accentColor.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Controller method row
// ============================================================
Widget _buildControllerRow(String method, String description, IconData icon) {
  return Row(
    children: [
      Icon(icon, size: 18, color: const Color(0xFFAD1457)),
      const SizedBox(width: 8),
      Text(
        method,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
          color: Color(0xFF880E4F),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFAD1457),
          ),
        ),
      ),
    ],
  );
}

// ============================================================
// Helper: Comparison header
// ============================================================
Widget _buildComparisonHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: const BoxDecoration(
      color: Color(0xFF616161),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    child: const Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Aspect',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'RawMenuAnchorGroup',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'MenuBar',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Comparison row
// ============================================================
Widget _buildComparisonRow(String aspect, String groupVal, String menuBarVal) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            aspect,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            groupVal,
            style: const TextStyle(fontSize: 11, color: Color(0xFF616161)),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            menuBarVal,
            style: const TextStyle(fontSize: 11, color: Color(0xFF616161)),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: API card
// ============================================================
Widget _buildApiCard(
  String name,
  String type,
  String requiredStr,
  String description,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFC5CAE9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: Color(0xFF283593),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFC5CAE9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                type,
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: requiredStr == 'Required'
                    ? const Color(0xFFFFCDD2)
                    : const Color(0xFFC8E6C9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                requiredStr,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: requiredStr == 'Required'
                      ? const Color(0xFFC62828)
                      : const Color(0xFF2E7D32),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: Color(0xFF424242)),
        ),
      ],
    ),
  );
}

// ============================================================
// Live Demo: Menu bar with RawMenuAnchorGroup
// ============================================================
class _LiveMenuBarDemo extends StatefulWidget {
  @override
  State<_LiveMenuBarDemo> createState() => _LiveMenuBarDemoState();
}

class _LiveMenuBarDemoState extends State<_LiveMenuBarDemo> {
  final MenuController _groupController = MenuController();
  final MenuController _fileMenuController = MenuController();
  final MenuController _editMenuController = MenuController();
  String _statusText = 'No menu opened yet';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The actual RawMenuAnchorGroup wrapping two menu triggers
        RawMenuAnchorGroup(
          controller: _groupController,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFB39DDB)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // File menu anchor
                RawMenuAnchor(
                  controller: _fileMenuController,
                  overlayBuilder: (BuildContext ctx, RawMenuOverlayInfo info) {
                    return Positioned(
                      left: info.anchorRect.left,
                      top: info.anchorRect.bottom,
                      child: TapRegion(
                        groupId: info.tapRegionGroupId,
                        child: Container(
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildMenuItem('New File', Icons.insert_drive_file),
                              _buildMenuItem('Open...', Icons.folder_open),
                              _buildMenuItem('Save', Icons.save),
                              const Divider(height: 1),
                              _buildMenuItem('Exit', Icons.exit_to_app),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  builder: (BuildContext ctx, MenuController ctrl, Widget? child) {
                    return GestureDetector(
                      onTap: () {
                        if (ctrl.isOpen) {
                          ctrl.close();
                          setState(() => _statusText = 'File menu closed');
                        } else {
                          _editMenuController.close();
                          ctrl.open();
                          setState(() => _statusText = 'File menu opened');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: ctrl.isOpen
                              ? const Color(0xFFD1C4E9)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'File',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4527A0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 4),
                // Edit menu anchor
                RawMenuAnchor(
                  controller: _editMenuController,
                  overlayBuilder: (BuildContext ctx, RawMenuOverlayInfo info) {
                    return Positioned(
                      left: info.anchorRect.left,
                      top: info.anchorRect.bottom,
                      child: TapRegion(
                        groupId: info.tapRegionGroupId,
                        child: Container(
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildMenuItem('Undo', Icons.undo),
                              _buildMenuItem('Redo', Icons.redo),
                              const Divider(height: 1),
                              _buildMenuItem('Cut', Icons.content_cut),
                              _buildMenuItem('Copy', Icons.copy),
                              _buildMenuItem('Paste', Icons.paste),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  builder: (BuildContext ctx, MenuController ctrl, Widget? child) {
                    return GestureDetector(
                      onTap: () {
                        if (ctrl.isOpen) {
                          ctrl.close();
                          setState(() => _statusText = 'Edit menu closed');
                        } else {
                          _fileMenuController.close();
                          ctrl.open();
                          setState(() => _statusText = 'Edit menu opened');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: ctrl.isOpen
                              ? const Color(0xFFD1C4E9)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4527A0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Status display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.info_outline, size: 14, color: Color(0xFF7B1FA2)),
              const SizedBox(width: 6),
              Text(
                _statusText,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7B1FA2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(String label, IconData icon) {
    return InkWell(
      onTap: () {
        _groupController.close();
        setState(() => _statusText = 'Selected: $label');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF616161)),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 13, color: Color(0xFF424242)),
            ),
          ],
        ),
      ),
    );
  }
}

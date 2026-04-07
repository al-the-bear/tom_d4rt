// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawMenuAnchor
// Demonstrates the RawMenuAnchor widget — the low-level building block
// for anchored floating menu overlays. RawMenuAnchor attaches a menu
// overlay to a trigger widget, managing overlay lifecycle, positioning,
// TapRegion coordination, and MenuController integration without
// imposing any visual design or theming.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawMenuAnchor Deep Demo executing');

  // ============================================================
  // SECTION 1: What RawMenuAnchor Is — Concept
  // ============================================================
  print('=== Section 1: RawMenuAnchor Concept ===');

  // RawMenuAnchor is the foundation widget for anchored menus.
  //
  // It creates a region in the widget tree that, when opened via
  // a MenuController, builds a floating overlay positioned relative
  // to the anchor. The overlay is rendered in the nearest Overlay
  // (or root Overlay when useRootOverlay is true).
  //
  // Key responsibilities:
  //   - Manages overlay lifecycle (show/hide)
  //   - Calculates anchor rect relative to the Overlay
  //   - Coordinates TapRegion grouping (tap outside → close)
  //   - Integrates with MenuController for programmatic control
  //   - Supports open/close request interception for animations
  //
  // Constructor parameters:
  //   controller (required): MenuController
  //   overlayBuilder (required): builds the floating menu content
  //   builder: builds the anchor trigger widget
  //   child: optional child passed to builder
  //   childFocusNode: FocusNode for the trigger
  //   consumeOutsideTaps: whether outside taps are consumed
  //   onOpen / onClose: lifecycle callbacks
  //   onOpenRequested / onCloseRequested: interception callbacks
  //   useRootOverlay: overlay placement strategy

  final conceptCard = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF1976D2), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RawMenuAnchor',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'The low-level building block for anchored floating menus. '
          'Attaches an overlay to a trigger widget via MenuController, '
          'handles positioning, TapRegion coordination, and overlay '
          'lifecycle — all without imposing visual design.',
          style: TextStyle(fontSize: 14, color: Color(0xFF1565C0)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildConceptChip('Overlay', Icons.layers),
            _buildConceptChip('Anchor', Icons.push_pin),
            _buildConceptChip('TapRegion', Icons.touch_app),
            _buildConceptChip('MenuController', Icons.settings_remote),
            _buildConceptChip('No Theming', Icons.palette_outlined),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Constructor Parameters — Required
  // ============================================================
  print('=== Section 2: Required Constructor Parameters ===');

  final requiredParams = Column(
    children: [
      _buildParamCard(
        'controller',
        'MenuController',
        'Required',
        'The controller for opening/closing the menu programmatically. '
        'Tracks isOpen state. Must be provided — each anchor needs its own '
        'or shares a parent group controller.',
        const Color(0xFF1565C0),
        const Color(0xFFBBDEFB),
      ),
      const SizedBox(height: 10),
      _buildParamCard(
        'overlayBuilder',
        'RawMenuAnchorOverlayBuilder',
        'Required',
        'Widget Function(BuildContext, RawMenuOverlayInfo info)\n\n'
        'Called when the menu opens. Receives info with:\n'
        '  • anchorRect — position relative to Overlay\n'
        '  • overlaySize — available overlay dimensions\n'
        '  • tapRegionGroupId — for TapRegion coordination\n'
        '  • position — optional offset from MenuController.open()',
        const Color(0xFF1565C0),
        const Color(0xFFBBDEFB),
      ),
    ],
  );

  // ============================================================
  // SECTION 3: Constructor Parameters — Optional
  // ============================================================
  print('=== Section 3: Optional Constructor Parameters ===');

  final optionalParams = Column(
    children: [
      _buildParamCard(
        'builder',
        'RawMenuAnchorChildBuilder?',
        'Optional',
        'Widget Function(BuildContext, MenuController, Widget? child)\n\n'
        'Builds the trigger widget. Receives the controller for '
        'reading isOpen and calling open()/close(). The child parameter '
        'is the optional child widget for efficiency.',
        const Color(0xFF2E7D32),
        const Color(0xFFE8F5E9),
      ),
      const SizedBox(height: 10),
      _buildParamCard(
        'child',
        'Widget?',
        'Optional',
        'Static child passed through to the builder. Use this for '
        'portions that don\'t depend on controller state — avoids '
        'unnecessary rebuilds.',
        const Color(0xFF2E7D32),
        const Color(0xFFE8F5E9),
      ),
      const SizedBox(height: 10),
      _buildParamCard(
        'childFocusNode',
        'FocusNode?',
        'Optional',
        'Focus node for the trigger widget. If provided, focus '
        'returns to this node when the menu closes.',
        const Color(0xFF2E7D32),
        const Color(0xFFE8F5E9),
      ),
      const SizedBox(height: 10),
      _buildParamCard(
        'consumeOutsideTaps',
        'bool',
        'Default: false',
        'When true, taps outside the menu that close it are consumed '
        'and don\'t propagate to the gesture arena. When false, the '
        'closing tap also triggers other gesture recognizers.',
        const Color(0xFF2E7D32),
        const Color(0xFFE8F5E9),
      ),
      const SizedBox(height: 10),
      _buildParamCard(
        'useRootOverlay',
        'bool',
        'Default: false',
        'When true, mounts the menu in the root Overlay so it renders '
        'above all widgets. When false, uses the nearest ancestor '
        'Overlay. Submenus always use the same overlay as their root.',
        const Color(0xFF2E7D32),
        const Color(0xFFE8F5E9),
      ),
    ],
  );

  // ============================================================
  // SECTION 4: Lifecycle Callbacks
  // ============================================================
  print('=== Section 4: Lifecycle Callbacks ===');

  // RawMenuAnchor provides four callback hooks:
  //
  // 1. onOpen — called when the overlay is actually shown
  // 2. onClose — called when the overlay is actually hidden
  // 3. onOpenRequested — intercepts open requests (for animations)
  // 4. onCloseRequested — intercepts close requests (for animations)
  //
  // The request callbacks receive a showOverlay/hideOverlay function
  // that must be called to actually show/hide the overlay. This
  // allows inserting animations before the overlay appears/disappears.

  final lifecycleFlow = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFFB300)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Open/Close Flow',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 12),
        _buildFlowStep(1, 'MenuController.open()', 'User or code triggers open',
            const Color(0xFF1565C0)),
        _buildFlowArrow(),
        _buildFlowStep(2, 'onOpenRequested(pos, showOverlay)',
            'Intercept: delay, animate, then call showOverlay()', const Color(0xFFE65100)),
        _buildFlowArrow(),
        _buildFlowStep(
            3, 'showOverlay()', 'Overlay inserted, widget built', const Color(0xFF2E7D32)),
        _buildFlowArrow(),
        _buildFlowStep(4, 'onOpen', 'Notified: menu is now visible', const Color(0xFF2E7D32)),
        const SizedBox(height: 16),
        const Divider(color: Color(0xFFFFCC80)),
        const SizedBox(height: 12),
        _buildFlowStep(5, 'MenuController.close()', 'User tap outside or code triggers close',
            const Color(0xFF1565C0)),
        _buildFlowArrow(),
        _buildFlowStep(6, 'onCloseRequested(hideOverlay)',
            'Intercept: animate out, then call hideOverlay()', const Color(0xFFE65100)),
        _buildFlowArrow(),
        _buildFlowStep(
            7, 'hideOverlay()', 'Overlay removed from tree', const Color(0xFFC62828)),
        _buildFlowArrow(),
        _buildFlowStep(8, 'onClose', 'Notified: menu is now hidden', const Color(0xFFC62828)),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: RawMenuOverlayInfo
  // ============================================================
  print('=== Section 5: RawMenuOverlayInfo ===');

  // The overlayBuilder receives RawMenuOverlayInfo with:
  //
  // anchorRect: Rect — position of the anchor in overlay coordinates
  // overlaySize: Size — dimensions of the Overlay
  // tapRegionGroupId: Object — TapRegion grouping key
  // position: Offset? — custom position from MenuController.open()

  final overlayInfoCard = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF7E57C2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RawMenuOverlayInfo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4527A0),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Passed to overlayBuilder — contains everything needed '
          'to position and configure the menu overlay.',
          style: TextStyle(fontSize: 12, color: Color(0xFF5E35B1)),
        ),
        const SizedBox(height: 14),
        _buildInfoField(
          'anchorRect',
          'Rect',
          'Position and size of the anchor widget relative to the '
          'Overlay. Use anchorRect.bottom for the top of a dropdown, '
          'anchorRect.left for left alignment.',
          const Color(0xFF1565C0),
        ),
        const SizedBox(height: 8),
        _buildInfoField(
          'overlaySize',
          'Size',
          'Total size of the Overlay. Useful for clamping the menu '
          'position so it doesn\'t overflow the screen edges.',
          const Color(0xFF2E7D32),
        ),
        const SizedBox(height: 8),
        _buildInfoField(
          'tapRegionGroupId',
          'Object',
          'The TapRegion group ID. Pass this to a TapRegion wrapping '
          'the menu panel so taps on the menu don\'t count as "outside".',
          const Color(0xFFE65100),
        ),
        const SizedBox(height: 8),
        _buildInfoField(
          'position',
          'Offset?',
          'Custom offset passed to MenuController.open(position: ...). '
          'Used for context menus opened at a specific cursor position.',
          const Color(0xFF6A1B9A),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Live RawMenuAnchor Examples
  // ============================================================
  print('=== Section 6: Live RawMenuAnchor Examples ===');

  final liveExamples = Container(
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
          'Live: RawMenuAnchor in Action',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
        const SizedBox(height: 12),
        _LiveDropdownDemo(),
        const SizedBox(height: 16),
        _LiveContextMenuDemo(),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Overlay Positioning Patterns
  // ============================================================
  print('=== Section 7: Overlay Positioning Patterns ===');

  // Common positioning patterns using RawMenuOverlayInfo:
  //
  // 1. Dropdown: left = anchorRect.left, top = anchorRect.bottom
  // 2. Popover above: left = anchorRect.left, top = anchorRect.top - menuHeight
  // 3. Context menu: left = position.dx, top = position.dy
  // 4. Centered: left = anchorRect.center.dx - menuWidth/2

  final positionPatterns = Container(
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
          'Positioning Patterns',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
          ),
        ),
        const SizedBox(height: 12),
        _buildPositionPattern(
          'Dropdown (below anchor)',
          'left: anchorRect.left\ntop: anchorRect.bottom',
          Icons.arrow_drop_down,
          const Color(0xFF1565C0),
        ),
        const SizedBox(height: 8),
        _buildPositionPattern(
          'Popover (above anchor)',
          'left: anchorRect.left\ntop: anchorRect.top - menuHeight',
          Icons.arrow_drop_up,
          const Color(0xFF2E7D32),
        ),
        const SizedBox(height: 8),
        _buildPositionPattern(
          'Context Menu (at cursor)',
          'left: info.position?.dx\ntop: info.position?.dy',
          Icons.ads_click,
          const Color(0xFFE65100),
        ),
        const SizedBox(height: 8),
        _buildPositionPattern(
          'Centered on anchor',
          'left: anchorRect.center.dx - w/2\ntop: anchorRect.bottom',
          Icons.center_focus_strong,
          const Color(0xFF6A1B9A),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFB2DFDB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Tip: Always clamp menu position against overlaySize '
            'to prevent the menu from overflowing screen edges.\n\n'
            'final clampedLeft = left.clamp(0.0, info.overlaySize.width - menuWidth);\n'
            'final clampedTop = top.clamp(0.0, info.overlaySize.height - menuHeight);',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Color(0xFF004D40),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: consumeOutsideTaps Behavior
  // ============================================================
  print('=== Section 8: consumeOutsideTaps Behavior ===');

  final consumeTapsCards = Row(
    children: [
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
                  const Icon(Icons.touch_app, color: Color(0xFF2E7D32), size: 20),
                  const SizedBox(width: 6),
                  const Text(
                    'false (default)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Outside tap:\n'
                '1. Closes the menu\n'
                '2. Tap continues to gesture arena\n'
                '3. Button behind menu can be activated\n\n'
                'Best for: menus where the underlying '
                'content should remain interactive.',
                style: TextStyle(fontSize: 11, color: Color(0xFF1B5E20)),
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
            color: const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFF44336)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.block, color: Color(0xFFC62828), size: 20),
                  const SizedBox(width: 6),
                  const Text(
                    'true',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC62828),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Outside tap:\n'
                '1. Closes the menu\n'
                '2. Tap is consumed (swallowed)\n'
                '3. Nothing else receives the tap\n\n'
                'Best for: modal-like menus where '
                'dismissal should be the only action.',
                style: TextStyle(fontSize: 11, color: Color(0xFFB71C1C)),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 9: useRootOverlay Behavior
  // ============================================================
  print('=== Section 9: useRootOverlay Behavior ===');

  final overlayCards = Row(
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
                  const Icon(Icons.layers, color: Color(0xFF283593), size: 20),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      'false (default)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF283593),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Menu placed in nearest Overlay.\n\n'
                'May be clipped by ancestor widgets '
                'like ClipRect or constrained boxes.\n\n'
                'Good for: locally scoped menus.',
                style: TextStyle(fontSize: 11, color: Color(0xFF1A237E)),
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
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFFF9800)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.public, color: Color(0xFFE65100), size: 20),
                  const SizedBox(width: 6),
                  const Text(
                    'true',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Menu placed in root Overlay.\n\n'
                'Renders above all widgets — never '
                'clipped by ancestors.\n\n'
                'Good for: global menus, popups.',
                style: TextStyle(fontSize: 11, color: Color(0xFFBF360C)),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 10: Comparison — RawMenuAnchor vs MenuAnchor
  // ============================================================
  print('=== Section 10: RawMenuAnchor vs MenuAnchor ===');

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
          'RawMenuAnchor vs MenuAnchor',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 12),
        _buildComparisonHeader(),
        _buildComparisonRow('Layer', 'widgets', 'material'),
        _buildComparisonRow('Theming', 'None', 'MenuTheme integration'),
        _buildComparisonRow('Positioning', 'Manual via info', 'Auto with alignment'),
        _buildComparisonRow('Animation', 'Via callbacks', 'Built-in transitions'),
        _buildComparisonRow('Focus', 'Manual', 'Automatic management'),
        _buildComparisonRow('Semantics', 'TapRegion only', 'Full menu semantics'),
        _buildComparisonRow('Overlay', 'overlayBuilder', 'menuChildren list'),
        _buildComparisonRow('Use Case', 'Custom menus', 'Standard MD menus'),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: API Property Reference
  // ============================================================
  print('=== Section 11: API Property Reference ===');

  final apiReference = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF1976D2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complete API Reference',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 12),
        _buildApiRow('controller', 'MenuController', true),
        _buildApiRow('overlayBuilder', 'RawMenuAnchorOverlayBuilder', true),
        _buildApiRow('builder', 'RawMenuAnchorChildBuilder?', false),
        _buildApiRow('child', 'Widget?', false),
        _buildApiRow('childFocusNode', 'FocusNode?', false),
        _buildApiRow('consumeOutsideTaps', 'bool', false),
        _buildApiRow('useRootOverlay', 'bool', false),
        _buildApiRow('onOpen', 'VoidCallback?', false),
        _buildApiRow('onClose', 'VoidCallback?', false),
        _buildApiRow('onOpenRequested', 'RawMenuAnchorOpenRequestedCallback', false),
        _buildApiRow('onCloseRequested', 'RawMenuAnchorCloseRequestedCallback', false),
        const SizedBox(height: 14),
        const Text(
          'Typedef Signatures',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1565C0),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFBBDEFB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'RawMenuAnchorOverlayBuilder:\n'
            '  Widget Function(BuildContext, RawMenuOverlayInfo)\n\n'
            'RawMenuAnchorChildBuilder:\n'
            '  Widget Function(BuildContext, MenuController, Widget?)\n\n'
            'RawMenuAnchorOpenRequestedCallback:\n'
            '  void Function(Offset? position, VoidCallback showOverlay)\n\n'
            'RawMenuAnchorCloseRequestedCallback:\n'
            '  void Function(VoidCallback hideOverlay)',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Color(0xFF0D47A1),
            ),
          ),
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
          'RawMenuAnchor — Deep Demo',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Low-level anchored floating menu overlay',
          style: TextStyle(fontSize: 14, color: Color(0xFF1565C0)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),

        // Section 1
        _buildSectionHeader(1, 'Concept'),
        const SizedBox(height: 8),
        conceptCard,
        const SizedBox(height: 24),

        // Section 2
        _buildSectionHeader(2, 'Required Constructor Parameters'),
        const SizedBox(height: 8),
        requiredParams,
        const SizedBox(height: 24),

        // Section 3
        _buildSectionHeader(3, 'Optional Constructor Parameters'),
        const SizedBox(height: 8),
        optionalParams,
        const SizedBox(height: 24),

        // Section 4
        _buildSectionHeader(4, 'Lifecycle Callbacks'),
        const SizedBox(height: 8),
        lifecycleFlow,
        const SizedBox(height: 24),

        // Section 5
        _buildSectionHeader(5, 'RawMenuOverlayInfo'),
        const SizedBox(height: 8),
        overlayInfoCard,
        const SizedBox(height: 24),

        // Section 6
        _buildSectionHeader(6, 'Live RawMenuAnchor Examples'),
        const SizedBox(height: 8),
        liveExamples,
        const SizedBox(height: 24),

        // Section 7
        _buildSectionHeader(7, 'Overlay Positioning Patterns'),
        const SizedBox(height: 8),
        positionPatterns,
        const SizedBox(height: 24),

        // Section 8
        _buildSectionHeader(8, 'consumeOutsideTaps Behavior'),
        const SizedBox(height: 8),
        consumeTapsCards,
        const SizedBox(height: 24),

        // Section 9
        _buildSectionHeader(9, 'useRootOverlay Behavior'),
        const SizedBox(height: 8),
        overlayCards,
        const SizedBox(height: 24),

        // Section 10
        _buildSectionHeader(10, 'RawMenuAnchor vs MenuAnchor'),
        const SizedBox(height: 8),
        comparisonTable,
        const SizedBox(height: 24),

        // Section 11
        _buildSectionHeader(11, 'API Property Reference'),
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
        colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
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
      color: const Color(0xFF90CAF9),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF0D47A1)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0D47A1),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Parameter card
// ============================================================
Widget _buildParamCard(
  String name,
  String type,
  String requiredStr,
  String description,
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: accentColor,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: accentColor,
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
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: accentColor.withOpacity(0.85),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Flow step
// ============================================================
Widget _buildFlowStep(int step, String action, String detail, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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
                action,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
              Text(
                detail,
                style: TextStyle(fontSize: 11, color: color.withOpacity(0.75)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Flow arrow
// ============================================================
Widget _buildFlowArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 22),
    child: Icon(Icons.arrow_downward, size: 16, color: Color(0xFFFFCC80)),
  );
}

// ============================================================
// Helper: Overlay info field
// ============================================================
Widget _buildInfoField(String name, String type, String description, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: color.withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Position pattern card
// ============================================================
Widget _buildPositionPattern(String title, String code, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                code,
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
            'RawMenuAnchor',
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
            'MenuAnchor',
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
Widget _buildComparisonRow(String aspect, String rawVal, String matVal) {
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
            rawVal,
            style: const TextStyle(fontSize: 11, color: Color(0xFF616161)),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            matVal,
            style: const TextStyle(fontSize: 11, color: Color(0xFF616161)),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: API property row
// ============================================================
Widget _buildApiRow(String name, String type, bool required) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFBBDEFB))),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              color: Color(0xFF0D47A1),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            type,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Color(0xFF1565C0),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: required ? const Color(0xFFFFCDD2) : const Color(0xFFC8E6C9),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              required ? 'Required' : 'Optional',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: required ? const Color(0xFFC62828) : const Color(0xFF2E7D32),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Live Demo: Dropdown menu with RawMenuAnchor
// ============================================================
class _LiveDropdownDemo extends StatefulWidget {
  @override
  State<_LiveDropdownDemo> createState() => _LiveDropdownDemoState();
}

class _LiveDropdownDemoState extends State<_LiveDropdownDemo> {
  final MenuController _controller = MenuController();
  String _selected = 'None';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dropdown Menu',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6A1B9A),
          ),
        ),
        const SizedBox(height: 8),
        RawMenuAnchor(
          controller: _controller,
          overlayBuilder: (BuildContext ctx, RawMenuOverlayInfo info) {
            return Positioned(
              left: info.anchorRect.left,
              top: info.anchorRect.bottom + 4,
              child: TapRegion(
                groupId: info.tapRegionGroupId,
                child: Container(
                  width: 200,
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
                      _dropdownItem('Apple', Icons.energy_savings_leaf),
                      _dropdownItem('Banana', Icons.eco),
                      _dropdownItem('Cherry', Icons.favorite),
                      _dropdownItem('Date', Icons.calendar_today),
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
                } else {
                  ctrl.open();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ctrl.isOpen
                        ? const Color(0xFF7E57C2)
                        : const Color(0xFFB39DDB),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Fruit: $_selected',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4527A0),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      ctrl.isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: const Color(0xFF7E57C2),
                      size: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 6),
        Text(
          'Selected: $_selected',
          style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
        ),
      ],
    );
  }

  Widget _dropdownItem(String label, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() => _selected = label);
        _controller.close();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF616161)),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: label == _selected
                    ? const Color(0xFF7E57C2)
                    : const Color(0xFF424242),
                fontWeight:
                    label == _selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (label == _selected) ...[
              const Spacer(),
              const Icon(Icons.check, size: 16, color: Color(0xFF7E57C2)),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================
// Live Demo: Context menu with RawMenuAnchor
// ============================================================
class _LiveContextMenuDemo extends StatefulWidget {
  @override
  State<_LiveContextMenuDemo> createState() => _LiveContextMenuDemoState();
}

class _LiveContextMenuDemoState extends State<_LiveContextMenuDemo> {
  final MenuController _controller = MenuController();
  String _lastAction = 'Right-click the area below';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Context Menu (long-press / right-click)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6A1B9A),
          ),
        ),
        const SizedBox(height: 8),
        RawMenuAnchor(
          controller: _controller,
          overlayBuilder: (BuildContext ctx, RawMenuOverlayInfo info) {
            final double left = info.position?.dx ?? info.anchorRect.left;
            final double top = info.position?.dy ?? info.anchorRect.bottom;
            return Positioned(
              left: left,
              top: top,
              child: TapRegion(
                groupId: info.tapRegionGroupId,
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _contextItem('Copy', Icons.copy),
                      _contextItem('Paste', Icons.paste),
                      _contextItem('Delete', Icons.delete_outline),
                      const Divider(height: 1),
                      _contextItem('Select All', Icons.select_all),
                    ],
                  ),
                ),
              ),
            );
          },
          child: GestureDetector(
            onSecondaryTapDown: (TapDownDetails details) {
              _controller.open(position: details.localPosition);
            },
            onLongPressStart: (LongPressStartDetails details) {
              _controller.open(position: details.localPosition);
            },
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFCE93D8),
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.ads_click, color: Color(0xFF9C27B0), size: 24),
                    const SizedBox(height: 4),
                    Text(
                      _lastAction,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7B1FA2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contextItem(String label, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() => _lastAction = 'Action: $label');
        _controller.close();
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

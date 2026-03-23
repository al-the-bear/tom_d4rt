// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive demo for LeaderLayer
//
// LeaderLayer is a compositing layer that anchors a position in the layer
// tree so that FollowerLayer instances can track it. It works with LayerLink
// to provide the leader-follower pattern used for tooltips, dropdowns, and
// floating overlays. The LeaderLayer records its transform in the layer tree
// so followers can compute their own position relative to the leader.
//
// Key concepts:
//   - LeaderLayer: a ContainerLayer subclass that registers with a LayerLink
//   - LayerLink: the shared reference between leader and follower
//   - FollowerLayer: the layer that reads the leader's transform
//   - offset: positional offset applied to the leader's children
//   - Coordinate transforms: leader-local to screen coordinates
//   - Layer tree anchoring for overlay positioning
//
// This demo shows:
//   1. Role in the compositing layer tree
//   2. How it anchors follower layers via LayerLink
//   3. Relationship with LayerLink and FollowerLayer
//   4. Visual diagrams of leader-follower layer trees
//   5. How tooltip/dropdown overlays use leader layers
//   6. Offset and coordinate transforms
//   7. Lifecycle: attach, paint, detach
//   8. Advanced patterns and edge cases
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS — Violet/Emerald theme
// ═══════════════════════════════════════════════════════════════════════════

const _kViolet50 = Color(0xFFF5F3FF);
const _kViolet100 = Color(0xFFEDE9FE);
const _kViolet200 = Color(0xFFDDD6FE);
const _kViolet300 = Color(0xFFC4B5FD);
const _kViolet400 = Color(0xFFA78BFA);
const _kViolet500 = Color(0xFF8B5CF6);
const _kViolet600 = Color(0xFF7C3AED);
const _kViolet700 = Color(0xFF6D28D9);
const _kViolet800 = Color(0xFF5B21B6);
const _kViolet900 = Color(0xFF4C1D95);

const _kEmerald400 = Color(0xFF34D399);
const _kEmerald500 = Color(0xFF10B981);
const _kEmerald600 = Color(0xFF059669);

const _kNeutral100 = Color(0xFFF5F5F5);
const _kNeutral200 = Color(0xFFE5E5E5);
const _kNeutral600 = Color(0xFF525252);
const _kNeutral800 = Color(0xFF262626);
const _kWhite = Color(0xFFFFFFFF);
const _kRose500 = Color(0xFFF43F5E);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a section title with violet accent icon
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kViolet700, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _kViolet900,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds an info card with description
Widget _buildInfoCard(
  String title,
  String description,
  IconData icon, {
  Color accentColor = _kViolet500,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor.withAlpha(80)),
      boxShadow: [
        BoxShadow(
          color: accentColor.withAlpha(20),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accentColor.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: accentColor, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _kNeutral800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: _kNeutral600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a code snippet block
Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kNeutral800,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: _kViolet300,
        height: 1.5,
      ),
    ),
  );
}

/// Builds a compositing tree node for the visual diagram
Widget _buildTreeNode(
  String label,
  Color color, {
  int indent = 0,
  bool isLeader = false,
  bool isFollower = false,
}) {
  IconData nodeIcon;
  if (isLeader) {
    nodeIcon = Icons.flag;
  } else if (isFollower) {
    nodeIcon = Icons.gps_fixed;
  } else {
    nodeIcon = Icons.layers;
  }

  return Padding(
    padding: EdgeInsets.only(left: indent * 24.0, bottom: 6),
    child: Row(
      children: [
        if (indent > 0)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              '└─',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _kNeutral600,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: color.withAlpha(80),
              width: (isLeader || isFollower) ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(nodeIcon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a lifecycle step card
Widget _buildLifecycleStep(
  int step,
  String title,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            shape: BoxShape.circle,
            border: Border.all(color: color.withAlpha(80)),
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16, color: color),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: _kNeutral800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kNeutral600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a property row
Widget _buildPropertyRow(
  String name,
  String type,
  String description,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(10),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: _kNeutral800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(description, style: TextStyle(fontSize: 12, color: _kNeutral600)),
      ],
    ),
  );
}

/// Builds a visual topology diagram for leader anchoring
Widget _buildAnchoringDiagram() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kNeutral100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kNeutral200),
    ),
    child: Column(
      children: [
        const Text(
          'LeaderLayer Anchoring',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _kViolet800,
          ),
        ),
        const SizedBox(height: 16),
        // The leader widget
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kViolet500.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kViolet500.withAlpha(80), width: 2),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flag, color: _kViolet600, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    'LeaderLayer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _kViolet700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _kViolet100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Button Widget (child)',
                  style: TextStyle(fontSize: 12, color: _kViolet800),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'offset: Offset(20, 100)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _kViolet600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Connection arrows
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(width: 3, height: 24, color: _kViolet400),
                Icon(Icons.arrow_downward, color: _kViolet400, size: 18),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              children: [
                Container(width: 3, height: 24, color: _kEmerald400),
                Icon(Icons.arrow_downward, color: _kEmerald400, size: 18),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Followers
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kViolet500.withAlpha(15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kViolet400.withAlpha(60)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.gps_fixed, color: _kViolet500, size: 16),
                    const SizedBox(height: 4),
                    Text(
                      'FollowerLayer A',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _kViolet600,
                      ),
                    ),
                    Text(
                      'Tooltip overlay',
                      style: TextStyle(fontSize: 10, color: _kNeutral600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kEmerald500.withAlpha(15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kEmerald400.withAlpha(60)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.gps_fixed, color: _kEmerald500, size: 16),
                    const SizedBox(height: 4),
                    Text(
                      'FollowerLayer B',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _kEmerald600,
                      ),
                    ),
                    Text(
                      'Dropdown menu',
                      style: TextStyle(fontSize: 10, color: _kNeutral600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Builds a coordinate transform visualization item
Widget _buildCoordTransformRow(
  String from,
  String arrow,
  String to,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(10),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withAlpha(30)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            from,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _kNeutral800,
            ),
          ),
        ),
        Text(
          arrow,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Expanded(
          child: Text(
            to,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _kNeutral800,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds a use-case card
Widget _buildUseCaseCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kNeutral200),
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: _kNeutral800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kNeutral600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// BUILD — entry point
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // ── Data exploration prints ──────────────────────────────────────────
  print('=== LeaderLayer Deep Demo ===');
  print('LeaderLayer extends OffsetLayer (which extends ContainerLayer)');
  print('Purpose: anchors a position in the layer tree for followers');
  print('Constructor: LeaderLayer({required LayerLink link, Offset offset})');
  print('Key property: link → LayerLink (connects to followers)');
  print('Key property: offset → Offset (position in parent layer)');
  print('Lifecycle: attach → addToScene → detach');
  print('On attach: link.leader = this');
  print('On detach: link.leader = null');
  print('leaderSize stored on LayerLink for follower sizing');
  print('=== End exploration ===');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ───────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kViolet600, _kViolet800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _kViolet700.withAlpha(60),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.flag, color: _kViolet200, size: 28),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'LeaderLayer',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _kWhite,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'A compositing layer that anchors a position in the layer '
                'tree. FollowerLayers track the leader\'s transform to '
                'position overlays, tooltips, and dropdown menus.',
                style: TextStyle(fontSize: 14, color: _kViolet100, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ── Section 1: Role in the Compositing Tree ──────────────────
        _buildSectionTitle(
          '1. Role in the Compositing Tree',
          Icons.account_tree,
        ),
        _buildInfoCard(
          'Layer Hierarchy',
          'LeaderLayer extends OffsetLayer, which extends ContainerLayer, '
              'which extends Layer. This means a LeaderLayer can have child '
              'layers, applies an offset, and participates in compositing.',
          Icons.layers,
        ),
        _buildInfoCard(
          'Created by RenderLeaderLayer',
          'The LeaderLayer is created by RenderLeaderLayer (the render '
              'object behind CompositedTransformTarget). During paint, '
              'the render object pushes a LeaderLayer onto the layer tree.',
          Icons.brush,
          accentColor: _kEmerald500,
        ),
        _buildCodeBlock(
          '// Class hierarchy:\n'
          '// Layer\n'
          '//  └─ ContainerLayer\n'
          '//      └─ OffsetLayer\n'
          '//          └─ LeaderLayer\n'
          '//\n'
          '// Constructor:\n'
          'LeaderLayer(\n'
          '  link: layerLink,      // required: the LayerLink\n'
          '  offset: Offset.zero,  // optional: position offset\n'
          ')',
        ),
        const SizedBox(height: 20),

        // ── Section 2: Anchoring Follower Layers ─────────────────────
        _buildSectionTitle('2. Anchoring Follower Layers', Icons.anchor),
        _buildAnchoringDiagram(),
        const SizedBox(height: 12),
        _buildInfoCard(
          'Registration Mechanism',
          'When the LeaderLayer is attached to the layer tree, it sets '
              'link.leader = this. FollowerLayers read link.leader to find '
              'the leader\'s transform matrix, then apply it to position '
              'themselves relative to the leader.',
          Icons.link,
        ),
        const SizedBox(height: 20),

        // ── Section 3: Relationship with LayerLink ───────────────────
        _buildSectionTitle('3. Relationship with LayerLink', Icons.hub),
        _buildPropertyRow(
          'link',
          'LayerLink',
          'The shared LayerLink that connects this leader to its followers. '
              'Set in the constructor. When attached, this.link.leader = this.',
          _kViolet500,
        ),
        _buildPropertyRow(
          'offset',
          'Offset',
          'The position offset of this layer relative to its parent layer. '
              'Inherited from OffsetLayer. Followers incorporate this offset '
              'when computing their position.',
          _kViolet600,
        ),
        _buildPropertyRow(
          'link.leaderSize',
          'Size?',
          'The size of the leader\'s child widget, stored on the LayerLink '
              'during layout. Followers use this to align to specific edges.',
          _kEmerald500,
        ),
        _buildCodeBlock(
          '// How LeaderLayer registers with LayerLink\n'
          'class LeaderLayer extends OffsetLayer {\n'
          '  final LayerLink link;\n'
          '\n'
          '  @override\n'
          '  void attach(Object owner) {\n'
          '    super.attach(owner);\n'
          '    link._leader = this;  // register as leader\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  void detach() {\n'
          '    link._leader = null;  // unregister\n'
          '    super.detach();\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 20),

        // ── Section 4: Visual Layer Tree ─────────────────────────────
        _buildSectionTitle('4. Layer Tree with Leader', Icons.device_hub),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kNeutral100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kNeutral200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tooltip Overlay Layer Tree',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _kViolet800,
                ),
              ),
              const SizedBox(height: 12),
              _buildTreeNode('TransformLayer (root)', _kNeutral600),
              _buildTreeNode('OffsetLayer (app)', _kNeutral600, indent: 1),
              _buildTreeNode(
                'OffsetLayer (scaffold body)',
                _kNeutral600,
                indent: 2,
              ),
              _buildTreeNode(
                'LeaderLayer [link]',
                _kViolet500,
                indent: 3,
                isLeader: true,
              ),
              _buildTreeNode('PictureLayer (button)', _kViolet400, indent: 4),
              _buildTreeNode('OffsetLayer (overlay)', _kNeutral600, indent: 1),
              _buildTreeNode(
                'FollowerLayer [link]',
                _kEmerald500,
                indent: 2,
                isFollower: true,
              ),
              _buildTreeNode('PictureLayer (tooltip)', _kEmerald400, indent: 3),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kViolet50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: _kViolet600, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'The FollowerLayer reads the LeaderLayer\'s global '
                        'transform to position the tooltip, even though they '
                        'are in completely different branches of the layer tree.',
                        style: TextStyle(fontSize: 12, color: _kViolet800),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ── Section 5: Overlay Use Cases ─────────────────────────────
        _buildSectionTitle('5. Tooltip & Dropdown Overlays', Icons.chat),
        _buildUseCaseCard(
          'Tooltip Positioning',
          'A tooltip overlay uses LeaderLayer at the anchor widget and '
              'FollowerLayer in the Overlay. The tooltip follows the '
              'button even during scroll or animation.',
          Icons.chat_bubble_outline,
          _kViolet500,
        ),
        _buildUseCaseCard(
          'Dropdown Menu Anchoring',
          'DropdownButton uses CompositedTransformTarget (LeaderLayer) '
              'at the button and CompositedTransformFollower (FollowerLayer) '
              'for the expanded menu. The menu aligns below the button.',
          Icons.arrow_drop_down_circle,
          _kEmerald500,
        ),
        _buildUseCaseCard(
          'Popup Route Positioning',
          'showMenu() and PopupMenuButton use a leader-follower pair '
              'so the popup menu appears at the correct position relative '
              'to the button, even in scrollable contexts.',
          Icons.menu,
          _kViolet600,
        ),
        _buildUseCaseCard(
          'Autocomplete Overlays',
          'The Autocomplete widget wraps the TextField in a '
              'CompositedTransformTarget and the suggestions list in a '
              'CompositedTransformFollower, ensuring alignment.',
          Icons.auto_awesome,
          _kEmerald600,
        ),
        const SizedBox(height: 20),

        // ── Section 6: Offset and Coordinate Transforms ─────────────
        _buildSectionTitle(
          '6. Offset & Coordinate Transforms',
          Icons.transform,
        ),
        _buildInfoCard(
          'How Transforms Flow',
          'The LeaderLayer records its position in the compositing tree. '
              'When a FollowerLayer needs to paint, it asks the engine for '
              'the leader\'s accumulated transform (all offsets, rotations, '
              'and scales from root to leader).',
          Icons.straighten,
        ),
        _buildCoordTransformRow(
          'Leader local (0,0)',
          ' → ',
          'Parent offset (20,100)',
          _kViolet500,
        ),
        _buildCoordTransformRow(
          'Parent offset',
          ' → ',
          'Global transform',
          _kViolet600,
        ),
        _buildCoordTransformRow(
          'Global transform',
          ' → ',
          'Follower position',
          _kEmerald500,
        ),
        const SizedBox(height: 8),
        _buildCodeBlock(
          '// Coordinate transform chain:\n'
          '//\n'
          '// 1. LeaderLayer.offset = Offset(20, 100)\n'
          '//    → position relative to parent layer\n'
          '//\n'
          '// 2. Parent layers accumulate transforms:\n'
          '//    globalTransform = parent.transform * leader.offset\n'
          '//\n'
          '// 3. FollowerLayer reads globalTransform through LayerLink:\n'
          '//    followerPosition = leader.globalTransform\n'
          '//                     + followerOffset\n'
          '//                     + alignment adjustments\n'
          '//\n'
          '// This all happens at the compositing level,\n'
          '// NOT during layout or widget build.',
        ),
        const SizedBox(height: 20),

        // ── Section 7: Lifecycle ─────────────────────────────────────
        _buildSectionTitle('7. Lifecycle: Attach → Paint → Detach', Icons.loop),
        _buildLifecycleStep(
          1,
          'Layer Created',
          'RenderLeaderLayer creates LeaderLayer with a LayerLink during paint()',
          _kViolet500,
          Icons.add_circle_outline,
        ),
        _buildLifecycleStep(
          2,
          'Attach',
          'Leader is attached to the layer tree. Sets link.leader = this. '
              'FollowerLayers can now find the leader.',
          _kViolet600,
          Icons.link,
        ),
        _buildLifecycleStep(
          3,
          'Add to Scene',
          'addToScene() pushes the offset and children into the engine\'s '
              'SceneBuilder. The leader\'s transform is now recorded.',
          _kEmerald500,
          Icons.movie_creation,
        ),
        _buildLifecycleStep(
          4,
          'Followers Paint',
          'FollowerLayers read link.leader.transform to compute their '
              'position. Multiple followers can read simultaneously.',
          _kEmerald600,
          Icons.gps_fixed,
        ),
        _buildLifecycleStep(
          5,
          'Detach',
          'When the leader is removed from the tree, link.leader = null. '
              'Followers lose their anchor and fall back to unlinked position.',
          _kRose500,
          Icons.link_off,
        ),
        const SizedBox(height: 20),

        // ── Section 8: Advanced Patterns ─────────────────────────────
        _buildSectionTitle('8. Advanced Patterns', Icons.star),
        _buildInfoCard(
          'Nested Leaders',
          'A LeaderLayer can exist inside another LeaderLayer\'s subtree. '
              'The inner leader\'s global transform includes the outer '
              'leader\'s offset, creating nested anchor points.',
          Icons.account_tree,
          accentColor: _kViolet600,
        ),
        _buildInfoCard(
          'Dynamic Re-linking',
          'You can change LayerLink.leader at runtime by swapping which '
              'CompositedTransformTarget provides the link. Followers '
              'automatically track the new leader on the next frame.',
          Icons.swap_horiz,
          accentColor: _kEmerald500,
        ),
        _buildInfoCard(
          'Assertion: One Leader Per Link',
          'Flutter asserts that only one LeaderLayer can be attached to '
              'a LayerLink at a time. Attempting to attach a second leader '
              'without detaching the first triggers a framework error.',
          Icons.warning_amber,
          accentColor: _kRose500,
        ),
        _buildCodeBlock(
          '// Full CompositedTransformTarget → LeaderLayer flow\n'
          '//\n'
          '// Widget tree:\n'
          '//   CompositedTransformTarget(link: myLink)\n'
          '//     └─ MyButton()\n'
          '//\n'
          '// Render tree:\n'
          '//   RenderLeaderLayer\n'
          '//     └─ RenderBox (button)\n'
          '//\n'
          '// During paint:\n'
          '//   RenderLeaderLayer.paint() {\n'
          '//     layer = LeaderLayer(link: myLink, offset: offset);\n'
          '//     context.pushLayer(layer, super.paint, Offset.zero);\n'
          '//     myLink.leaderSize = size;\n'
          '//   }\n'
          '//\n'
          '// Layer tree result:\n'
          '//   ... → LeaderLayer[myLink] → PictureLayer (button)',
        ),
        const SizedBox(height: 24),

        // ── Footer ───────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kViolet50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kViolet200),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: _kViolet600, size: 32),
              const SizedBox(height: 8),
              const Text(
                'LeaderLayer Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: _kViolet800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'LeaderLayer is the anchor point that makes Flutter\'s '
                'leader-follower pattern work at the compositing level.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: _kNeutral600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

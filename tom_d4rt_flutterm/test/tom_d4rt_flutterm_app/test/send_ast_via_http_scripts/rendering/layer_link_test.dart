// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive demo for LayerLink
//
// LayerLink connects a LeaderLayer to one or more FollowerLayers so that
// followers can be positioned relative to the leader. This is the backbone
// of tooltips, dropdown menus, and floating overlays in Flutter.
//
// Key concepts:
//   - LayerLink: the link object shared between leader and followers
//   - LeaderLayer: the compositing layer that anchors the link
//   - FollowerLayer: the compositing layer that follows the leader's position
//   - CompositedTransformTarget: the widget that creates a LeaderLayer
//   - CompositedTransformFollower: the widget that creates a FollowerLayer
//   - leaderSize: the size of the leader, available on the link
//
// This demo shows:
//   1. What a LayerLink is and how it works
//   2. Leader-follower connection mechanism
//   3. CompositedTransformTarget / CompositedTransformFollower widgets
//   4. Visual diagrams of linked layers in the compositing tree
//   5. Practical tooltip/overlay/dropdown following their anchors
//   6. The leaderSize property and positional offsets
//   7. Multiple followers per leader
//   8. Common patterns and best practices
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS — Blue/Orange theme
// ═══════════════════════════════════════════════════════════════════════════

const _kBlue50 = Color(0xFFEFF6FF);
const _kBlue100 = Color(0xFFDBEAFE);
const _kBlue200 = Color(0xFFBFDBFE);
const _kBlue300 = Color(0xFF93C5FD);
const _kBlue400 = Color(0xFF60A5FA);
const _kBlue500 = Color(0xFF3B82F6);
const _kBlue600 = Color(0xFF2563EB);
const _kBlue700 = Color(0xFF1D4ED8);
const _kBlue800 = Color(0xFF1E40AF);
const _kBlue900 = Color(0xFF1E3A8A);

const _kOrange400 = Color(0xFFFB923C);
const _kOrange500 = Color(0xFFF97316);
const _kOrange600 = Color(0xFFEA580C);
const _kOrange700 = Color(0xFFC2410C);

const _kNeutral100 = Color(0xFFF5F5F5);
const _kNeutral200 = Color(0xFFE5E5E5);
const _kNeutral600 = Color(0xFF525252);
const _kNeutral800 = Color(0xFF262626);
const _kWhite = Color(0xFFFFFFFF);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a section title with blue accent icon
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kBlue700, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _kBlue900,
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
  Color accentColor = _kBlue500,
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
        color: _kBlue300,
        height: 1.5,
      ),
    ),
  );
}

/// Builds a visual diagram showing leader-follower connection
Widget _buildLeaderFollowerDiagram() {
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
          'Leader ↔ Follower Connection',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _kBlue800,
          ),
        ),
        const SizedBox(height: 16),
        // Leader box
        _buildDiagramBox(
          'LeaderLayer',
          _kBlue500,
          Icons.flag,
          subtitle: 'Anchor position',
        ),
        const SizedBox(height: 4),
        // Link line
        Container(
          width: 3,
          height: 30,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_kBlue500, _kOrange500],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: _kBlue500.withAlpha(20),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _kBlue300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.link, size: 14, color: _kBlue600),
              const SizedBox(width: 4),
              Text(
                'LayerLink',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kBlue700,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 3,
          height: 30,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_kOrange500, _kOrange600],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 4),
        // Follower box
        _buildDiagramBox(
          'FollowerLayer',
          _kOrange500,
          Icons.gps_fixed,
          subtitle: 'Tracks leader position',
        ),
      ],
    ),
  );
}

/// Builds a styled box for the diagram
Widget _buildDiagramBox(
  String label,
  Color color,
  IconData icon, {
  String? subtitle,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80), width: 2),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: color,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: TextStyle(fontSize: 11, color: _kNeutral600),
              ),
          ],
        ),
      ],
    ),
  );
}

/// Builds a compositing tree node
Widget _buildTreeNode(
  String label,
  Color color, {
  int indent = 0,
  bool isLinked = false,
}) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 24.0, bottom: 5),
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
              width: isLinked ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLinked) Icon(Icons.link, size: 14, color: color),
              if (!isLinked) Icon(Icons.layers, size: 14, color: color),
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

/// Builds a practical use-case card
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

/// Builds a property documentation row
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

// ═══════════════════════════════════════════════════════════════════════════
// BUILD — entry point
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // ── Data exploration prints ──────────────────────────────────────────
  print('=== LayerLink Deep Demo ===');
  print('LayerLink: connects LeaderLayer to FollowerLayer(s)');
  print('Widgets: CompositedTransformTarget ↔ CompositedTransformFollower');
  print('Key property: leaderSize → Size? of the leader widget');
  print('Leader stores: link.leaderSize = size during layout');
  print('Follower reads: link.leaderSize to position itself');
  print('Use cases: tooltips, dropdowns, popups, autocomplete overlays');
  print('Layer tree: LeaderLayer → LayerLink ← FollowerLayer');
  print('Multiple followers can share one LayerLink');
  print('Only one LeaderLayer per LayerLink at a time');
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
              colors: [_kBlue600, _kBlue800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _kBlue700.withAlpha(60),
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
                  Icon(Icons.link, color: _kBlue200, size: 28),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'LayerLink',
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
                'Connects a LeaderLayer and FollowerLayer for coordinated '
                'positioning. The bridge that makes tooltips, dropdowns, '
                'and overlays follow their anchor widgets.',
                style: TextStyle(fontSize: 14, color: _kBlue100, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ── Section 1: What Is a LayerLink? ──────────────────────────
        _buildSectionTitle('1. What Is a LayerLink?', Icons.link),
        _buildInfoCard(
          'Connection Object',
          'LayerLink is a simple object that acts as a bridge between '
              'a LeaderLayer and one or more FollowerLayers. It enables '
              'followers to know the leader\'s position in the compositing '
              'layer tree without widget-level coordinate math.',
          Icons.hub,
        ),
        _buildInfoCard(
          'Compositing-Level Positioning',
          'Unlike widget-level alignment, LayerLink works at the '
              'compositing layer level. This means follower positioning '
              'happens AFTER layout, during the compositing phase, which '
              'is critical for overlay accuracy.',
          Icons.layers,
          accentColor: _kOrange500,
        ),
        _buildCodeBlock(
          '// Creating and using a LayerLink\n'
          'final layerLink = LayerLink();\n'
          '\n'
          '// Pass to leader widget:\n'
          'CompositedTransformTarget(\n'
          '  link: layerLink,\n'
          '  child: myAnchorWidget,\n'
          ')\n'
          '\n'
          '// Pass to follower widget:\n'
          'CompositedTransformFollower(\n'
          '  link: layerLink,\n'
          '  offset: Offset(0, 40),\n'
          '  child: myOverlayWidget,\n'
          ')',
        ),
        const SizedBox(height: 20),

        // ── Section 2: Leader-Follower Mechanism ─────────────────────
        _buildSectionTitle('2. Leader-Follower Mechanism', Icons.swap_vert),
        _buildLeaderFollowerDiagram(),
        const SizedBox(height: 12),
        _buildInfoCard(
          'How It Works',
          '1) The LeaderLayer registers itself with the LayerLink.\n'
              '2) During layout, the leader stores its size on the link.\n'
              '3) The FollowerLayer reads the leader\'s transform from the link.\n'
              '4) The follower applies that transform plus any offset to position itself.',
          Icons.sync_alt,
        ),
        const SizedBox(height: 20),

        // ── Section 3: Widget-Level API ──────────────────────────────
        _buildSectionTitle('3. CompositedTransform Widgets', Icons.widgets),
        _buildInfoCard(
          'CompositedTransformTarget',
          'A widget that creates a LeaderLayer in the compositing tree. '
              'It takes a LayerLink and a child. The child\'s position in '
              'the layer tree becomes the anchor point.',
          Icons.flag,
          accentColor: _kBlue600,
        ),
        _buildInfoCard(
          'CompositedTransformFollower',
          'A widget that creates a FollowerLayer. It takes the same '
              'LayerLink plus an optional offset and targetAnchor/followerAnchor '
              'alignment to fine-tune positioning.',
          Icons.gps_fixed,
          accentColor: _kOrange500,
        ),
        _buildCodeBlock(
          '// Full tooltip-style example\n'
          'final _link = LayerLink();\n'
          '\n'
          '// In your widget tree — the button:\n'
          'CompositedTransformTarget(\n'
          '  link: _link,\n'
          '  child: ElevatedButton(\n'
          '    onPressed: _showTooltip,\n'
          '    child: Text("Hover me"),\n'
          '  ),\n'
          ')\n'
          '\n'
          '// In an Overlay — the tooltip:\n'
          'CompositedTransformFollower(\n'
          '  link: _link,\n'
          '  targetAnchor: Alignment.bottomCenter,\n'
          '  followerAnchor: Alignment.topCenter,\n'
          '  offset: Offset(0, 8), // 8px gap below button\n'
          '  child: Material(\n'
          '    elevation: 4,\n'
          '    child: Padding(\n'
          '      padding: EdgeInsets.all(12),\n'
          '      child: Text("Tooltip text"),\n'
          '    ),\n'
          '  ),\n'
          ')',
        ),
        const SizedBox(height: 20),

        // ── Section 4: Compositing Layer Tree Diagram ────────────────
        _buildSectionTitle('4. Layer Tree Diagram', Icons.account_tree),
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
                'Compositing Tree with Linked Layers',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _kBlue800,
                ),
              ),
              const SizedBox(height: 12),
              _buildTreeNode('TransformLayer (root)', _kNeutral600),
              _buildTreeNode('OffsetLayer (scaffold)', _kNeutral600, indent: 1),
              _buildTreeNode(
                'LeaderLayer [link]',
                _kBlue500,
                indent: 2,
                isLinked: true,
              ),
              _buildTreeNode('PictureLayer (button)', _kBlue400, indent: 3),
              _buildTreeNode('OffsetLayer (overlay)', _kNeutral600, indent: 1),
              _buildTreeNode(
                'FollowerLayer [link]',
                _kOrange500,
                indent: 2,
                isLinked: true,
              ),
              _buildTreeNode('PictureLayer (tooltip)', _kOrange400, indent: 3),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kBlue50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: _kBlue600, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'The FollowerLayer reads the LeaderLayer\'s transform '
                        'through the shared LayerLink to compute its position.',
                        style: TextStyle(fontSize: 12, color: _kBlue800),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ── Section 5: Practical Overlays ────────────────────────────
        _buildSectionTitle('5. Practical Use Cases', Icons.build_circle),
        _buildUseCaseCard(
          'Tooltip Overlays',
          'Tooltip follows the target widget even when the page scrolls. '
              'The LayerLink ensures pixel-perfect positioning at the '
              'compositing level.',
          Icons.chat_bubble_outline,
          _kBlue500,
        ),
        _buildUseCaseCard(
          'Dropdown Menus',
          'A dropdown menu anchored below a button. The follower tracks '
              'the button position even inside complex scrollable layouts.',
          Icons.arrow_drop_down_circle,
          _kOrange500,
        ),
        _buildUseCaseCard(
          'Autocomplete Suggestions',
          'A suggestion list floating below a TextField. CompositedTransform '
              'keeps it aligned even when the keyboard resizes the view.',
          Icons.auto_awesome,
          _kBlue600,
        ),
        _buildUseCaseCard(
          'Context Menus',
          'Right-click context menus positioned relative to the click target. '
              'The leader is at the click point, the follower is the menu.',
          Icons.menu_open,
          _kOrange600,
        ),
        _buildUseCaseCard(
          'Tour / Onboarding Highlights',
          'Spotlight overlays that highlight specific widgets during '
              'onboarding tutorials. Each spotlight follows its target widget.',
          Icons.highlight,
          _kBlue700,
        ),
        const SizedBox(height: 20),

        // ── Section 6: The leaderSize Property ───────────────────────
        _buildSectionTitle('6. The leaderSize Property', Icons.straighten),
        _buildPropertyRow(
          'leaderSize',
          'Size?',
          'The size of the leader widget, set during layout. Follower '
              'uses this to position relative to leader edges (e.g., '
              'bottomCenter = Offset(leaderSize.width / 2, leaderSize.height)).',
          _kBlue500,
        ),
        _buildPropertyRow(
          'leader',
          'LeaderLayer?',
          'The currently connected LeaderLayer instance. Set when the '
              'LeaderLayer is attached to the compositing tree.',
          _kBlue600,
        ),
        _buildCodeBlock(
          '// Using leaderSize for position calculation\n'
          'final link = LayerLink();\n'
          '\n'
          '// After layout, leaderSize is available:\n'
          'final leaderWidth = link.leaderSize?.width ?? 0;\n'
          'final leaderHeight = link.leaderSize?.height ?? 0;\n'
          '\n'
          '// Position follower at bottom-right of leader:\n'
          'CompositedTransformFollower(\n'
          '  link: link,\n'
          '  offset: Offset(leaderWidth, leaderHeight),\n'
          '  child: myFollowerWidget,\n'
          ')',
        ),
        const SizedBox(height: 20),

        // ── Section 7: Multiple Followers ────────────────────────────
        _buildSectionTitle('7. Multiple Followers', Icons.group_work),
        _buildInfoCard(
          'One Leader, Many Followers',
          'A single LayerLink can have multiple FollowerLayers. Each '
              'follower independently tracks the same leader position. '
              'This is useful for multi-part overlays (e.g., tooltip + '
              'highlight + arrow).',
          Icons.call_split,
        ),
        Container(
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
                'Multi-Follower Scenario',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _kBlue800,
                ),
              ),
              const SizedBox(height: 12),
              _buildDiagramBox('Leader: Button', _kBlue500, Icons.flag),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildDiagramBox(
                      'Follower 1:\nTooltip',
                      _kOrange500,
                      Icons.chat,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildDiagramBox(
                      'Follower 2:\nHighlight',
                      _kOrange600,
                      Icons.highlight,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildDiagramBox(
                      'Follower 3:\nArrow',
                      _kOrange700,
                      Icons.arrow_downward,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'All three followers share one LayerLink',
                style: TextStyle(fontSize: 12, color: _kNeutral600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ── Section 8: Best Practices ────────────────────────────────
        _buildSectionTitle('8. Best Practices', Icons.star),
        _buildInfoCard(
          'Create LayerLink in State',
          'Declare the LayerLink as a field in your State class so it '
              'persists across rebuilds. Do NOT create it in build().',
          Icons.save,
          accentColor: _kBlue600,
        ),
        _buildInfoCard(
          'Use Overlay for Followers',
          'Place CompositedTransformFollower inside an OverlayEntry. '
              'This ensures the follower renders above all other widgets.',
          Icons.layers,
          accentColor: _kOrange500,
        ),
        _buildInfoCard(
          'Alignment Parameters',
          'Use targetAnchor and followerAnchor on CompositedTransformFollower '
              'to control which corners/edges align between leader and follower.',
          Icons.format_align_left,
          accentColor: _kBlue500,
        ),
        _buildInfoCard(
          'Only One Leader Per Link',
          'A LayerLink can only be attached to one LeaderLayer at a time. '
              'Attaching a second leader triggers an assertion error.',
          Icons.warning_amber,
          accentColor: _kOrange600,
        ),
        const SizedBox(height: 24),

        // ── Footer ───────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kBlue50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBlue200),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: _kBlue600, size: 32),
              const SizedBox(height: 8),
              const Text(
                'LayerLink Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: _kBlue800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'LayerLink is the invisible bridge that makes Flutter\'s '
                'overlay system precise and performant.',
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

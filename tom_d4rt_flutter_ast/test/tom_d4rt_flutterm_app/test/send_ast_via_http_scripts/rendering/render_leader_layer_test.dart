// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: RenderLeaderLayer / CompositedTransformTarget & Follower
// Tests LayerLink, CompositedTransformTarget, CompositedTransformFollower
// with various anchor alignments, offsets, showWhenUnlinked, and
// practical patterns like tooltips, dropdowns, and contextual popups.

import 'package:flutter/material.dart';

Widget _buildHeader(String title, String subtitle) {
  print('Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF00897B), Color(0xFF26A69A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x4000695C),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Color(0xCCFFFFFF)),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(IconData icon, String title) {
  print('Building section: $title');
  return Padding(
    padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF00897B),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String label, String description) {
  print('Info card: $label');
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80CBC4), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: Color(0xFF00897B), size: 18),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF004D40),
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Color(0xFF37474F)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Build a target-follower pair demonstration
Widget _buildTargetFollowerDemo({
  required String label,
  required Alignment targetAnchor,
  required Alignment followerAnchor,
  required Offset followerOffset,
  required Color targetColor,
  required Color followerColor,
}) {
  LayerLink link = LayerLink();
  print('Building target-follower demo: $label');
  print('  targetAnchor: $targetAnchor');
  print('  followerAnchor: $followerAnchor');
  print('  followerOffset: $followerOffset');

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    height: 140,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB2DFDB), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Label at top
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
            ),
          ),
        ),
        // Target widget in center
        Positioned(
          top: 30,
          left: 60,
          child: CompositedTransformTarget(
            link: link,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: targetColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF004D40), width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                'TARGET',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // Follower widget linked to target
        Positioned(
          top: 30,
          left: 60,
          child: CompositedTransformFollower(
            link: link,
            targetAnchor: targetAnchor,
            followerAnchor: followerAnchor,
            offset: followerOffset,
            showWhenUnlinked: true,
            child: Container(
              width: 55,
              height: 35,
              decoration: BoxDecoration(
                color: followerColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'FOLLOW',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // Anchor info
        Positioned(
          bottom: 0,
          right: 0,
          child: Text(
            'tA: $targetAnchor\nfA: $followerAnchor',
            style: TextStyle(fontSize: 9, color: Color(0xFF78909C)),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

// Build a tooltip-style demo using the leader-follower pattern
Widget _buildTooltipDemo(String tooltipText, Color accentColor) {
  LayerLink tooltipLink = LayerLink();
  print('Building tooltip demo: $tooltipText');

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(16),
    height: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB2DFDB), width: 1),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // The target button
        Align(
          alignment: Alignment.centerLeft,
          child: CompositedTransformTarget(
            link: tooltipLink,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.touch_app, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Hover Target',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // The follower tooltip
        Align(
          alignment: Alignment.centerLeft,
          child: CompositedTransformFollower(
            link: tooltipLink,
            targetAnchor: Alignment.topCenter,
            followerAnchor: Alignment.bottomCenter,
            offset: Offset(0, -8),
            showWhenUnlinked: false,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF37474F),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                tooltipText,
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Build a dropdown menu demo using leader-follower
Widget _buildDropdownDemo() {
  LayerLink dropdownLink = LayerLink();
  print('Building dropdown menu demo with leader-follower pattern');

  List<String> menuItems = ['Edit', 'Duplicate', 'Archive', 'Delete'];

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(16),
    height: 200,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB2DFDB), width: 1),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // The dropdown trigger (target)
        Positioned(
          top: 0,
          left: 0,
          child: CompositedTransformTarget(
            link: dropdownLink,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF00897B), width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Actions',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00897B),
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xFF00897B),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        // The dropdown menu (follower)
        Positioned(
          top: 0,
          left: 0,
          child: CompositedTransformFollower(
            link: dropdownLink,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: Offset(0, 4),
            showWhenUnlinked: false,
            child: Container(
              width: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Color(0xFFE0E0E0), width: 1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: menuItems.map((item) {
                  print('  Dropdown menu item: $item');
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 13, color: Color(0xFF37474F)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        // Description label
        Positioned(
          bottom: 0,
          left: 0,
          child: Text(
            'Dropdown pattern: follower anchored to bottom-left of target',
            style: TextStyle(fontSize: 10, color: Color(0xFF78909C)),
          ),
        ),
      ],
    ),
  );
}

// Build a contextual popup demo
Widget _buildContextualPopup() {
  LayerLink popupLink = LayerLink();
  print('Building contextual popup demo');

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(16),
    height: 160,
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB2DFDB), width: 1),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Target: a small avatar or icon
        Positioned(
          top: 20,
          left: 30,
          child: CompositedTransformTarget(
            link: popupLink,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFF00897B),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x4000897B),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(Icons.person, color: Colors.white, size: 24),
            ),
          ),
        ),
        // Follower: popup card to the right
        Positioned(
          top: 20,
          left: 30,
          child: CompositedTransformFollower(
            link: popupLink,
            targetAnchor: Alignment.centerRight,
            followerAnchor: Alignment.centerLeft,
            offset: Offset(12, 0),
            showWhenUnlinked: true,
            child: Container(
              width: 180,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                border: Border.all(color: Color(0xFFE0E0E0), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF263238),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Senior Developer',
                    style: TextStyle(fontSize: 11, color: Color(0xFF78909C)),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email, size: 12, color: Color(0xFF00897B)),
                      SizedBox(width: 4),
                      Text(
                        'john@example.com',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF00897B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Label
        Positioned(
          bottom: 0,
          left: 0,
          child: Text(
            'Contextual popup: follower at centerRight of target avatar',
            style: TextStyle(fontSize: 10, color: Color(0xFF78909C)),
          ),
        ),
      ],
    ),
  );
}

// Show showWhenUnlinked behavior demo
Widget _buildShowWhenUnlinkedDemo() {
  LayerLink linkedLink = LayerLink();
  LayerLink unlinkedLink = LayerLink();
  print('Building showWhenUnlinked behavior demo');

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB2DFDB), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'showWhenUnlinked Behavior',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004D40),
          ),
        ),
        SizedBox(height: 10),
        // Linked pair
        SizedBox(
          height: 80,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: CompositedTransformTarget(
                  link: linkedLink,
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Linked\nTarget',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: CompositedTransformFollower(
                  link: linkedLink,
                  targetAnchor: Alignment.centerRight,
                  followerAnchor: Alignment.centerLeft,
                  offset: Offset(8, 0),
                  showWhenUnlinked: true,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF81C784),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'showWhenUnlinked: true',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(color: Color(0xFFE0E0E0)),
        // Unlinked pair - showWhenUnlinked false
        SizedBox(
          height: 80,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: CompositedTransformTarget(
                  link: unlinkedLink,
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFEF5350),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Another\nTarget',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: CompositedTransformFollower(
                  link: unlinkedLink,
                  targetAnchor: Alignment.centerRight,
                  followerAnchor: Alignment.centerLeft,
                  offset: Offset(8, 0),
                  showWhenUnlinked: false,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFEF9A9A),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'showWhenUnlinked: false',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(
          'When showWhenUnlinked is false, follower hides if link is detached',
          style: TextStyle(fontSize: 10, color: Color(0xFF78909C)),
        ),
      ],
    ),
  );
}

// Build multiple target-follower pairs in one layout
Widget _buildMultiPairLayout() {
  LayerLink link1 = LayerLink();
  LayerLink link2 = LayerLink();
  LayerLink link3 = LayerLink();
  print('Building multi-pair layout with 3 independent LayerLinks');

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    height: 200,
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB2DFDB), width: 1),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Pair 1 - top left
        Positioned(
          top: 10,
          left: 10,
          child: CompositedTransformTarget(
            link: link1,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFE91E63),
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: CompositedTransformFollower(
            link: link1,
            targetAnchor: Alignment.topRight,
            followerAnchor: Alignment.bottomLeft,
            offset: Offset(4, -4),
            showWhenUnlinked: true,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFF48FB1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Badge 1',
                style: TextStyle(fontSize: 9, color: Colors.white),
              ),
            ),
          ),
        ),
        // Pair 2 - center
        Positioned(
          top: 70,
          left: 120,
          child: CompositedTransformTarget(
            link: link2,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF3F51B5),
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 70,
          left: 120,
          child: CompositedTransformFollower(
            link: link2,
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            offset: Offset(0, 6),
            showWhenUnlinked: true,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF9FA8DA),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Badge 2',
                style: TextStyle(fontSize: 9, color: Colors.white),
              ),
            ),
          ),
        ),
        // Pair 3 - right
        Positioned(
          top: 20,
          left: 230,
          child: CompositedTransformTarget(
            link: link3,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFFF9800),
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 230,
          child: CompositedTransformFollower(
            link: link3,
            targetAnchor: Alignment.centerLeft,
            followerAnchor: Alignment.centerRight,
            offset: Offset(-8, 0),
            showWhenUnlinked: true,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFFFCC80),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Badge 3',
                style: TextStyle(fontSize: 9, color: Colors.white),
              ),
            ),
          ),
        ),
        // Description
        Positioned(
          bottom: 4,
          left: 0,
          right: 0,
          child: Text(
            '3 independent LayerLink pairs: each follower tracks its own target',
            style: TextStyle(fontSize: 10, color: Color(0xFF78909C)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== RenderLeaderLayer Deep Demo ===');
  print(
    'Demonstrating LayerLink, CompositedTransformTarget, CompositedTransformFollower',
  );
  print(
    'RenderLeaderLayer is the render object behind CompositedTransformTarget',
  );
  print(
    'RenderFollowerLayer is the render object behind CompositedTransformFollower',
  );

  // Create LayerLinks for demonstrations
  LayerLink demoLink1 = LayerLink();
  LayerLink demoLink2 = LayerLink();
  print('Created LayerLink instances for demos');
  print('LayerLink demoLink1: $demoLink1');
  print('LayerLink demoLink2: $demoLink2');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(
          'RenderLeaderLayer Demo',
          'LayerLink + CompositedTransformTarget/Follower patterns for tooltips, dropdowns, overlays',
        ),

        // Section 1: Basic target-follower link
        _buildSectionTitle(Icons.link, '1. Basic Target-Follower Link'),
        _buildInfoCard(
          'LayerLink',
          'A LayerLink object connects a CompositedTransformTarget (leader) to a CompositedTransformFollower. The follower positions itself relative to the target in the compositing layer.',
        ),
        _buildTargetFollowerDemo(
          label: 'Default: follower at topRight of target',
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.topLeft,
          followerOffset: Offset(8, 0),
          targetColor: Color(0xFF00897B),
          followerColor: Color(0xFF26A69A),
        ),

        // Section 2: Different targetAnchor values
        _buildSectionTitle(Icons.anchor, '2. Target Anchor Variations'),
        _buildInfoCard(
          'targetAnchor',
          'Controls which point on the target widget the follower attaches to. Common values: topLeft, topCenter, topRight, centerLeft, center, centerRight, bottomLeft, bottomCenter, bottomRight.',
        ),
        _buildTargetFollowerDemo(
          label: 'targetAnchor: topLeft',
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          followerOffset: Offset(0, -4),
          targetColor: Color(0xFF1565C0),
          followerColor: Color(0xFF42A5F5),
        ),
        _buildTargetFollowerDemo(
          label: 'targetAnchor: center',
          targetAnchor: Alignment.center,
          followerAnchor: Alignment.center,
          followerOffset: Offset(0, 0),
          targetColor: Color(0xFF6A1B9A),
          followerColor: Color(0xFFAB47BC),
        ),
        _buildTargetFollowerDemo(
          label: 'targetAnchor: bottomRight',
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topLeft,
          followerOffset: Offset(4, 4),
          targetColor: Color(0xFFE65100),
          followerColor: Color(0xFFFF9800),
        ),

        // Section 3: Follower anchor variations
        _buildSectionTitle(
          Icons.control_point,
          '3. Follower Anchor Variations',
        ),
        _buildInfoCard(
          'followerAnchor',
          'Controls which point on the follower widget aligns with the targetAnchor point. For example, followerAnchor: bottomCenter means the bottom-center of the follower sits at the targetAnchor point.',
        ),
        _buildTargetFollowerDemo(
          label: 'followerAnchor: bottomCenter (tooltip above)',
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          followerOffset: Offset(0, -6),
          targetColor: Color(0xFF2E7D32),
          followerColor: Color(0xFF66BB6A),
        ),
        _buildTargetFollowerDemo(
          label: 'followerAnchor: topRight (popup at bottomLeft)',
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topRight,
          followerOffset: Offset(-4, 4),
          targetColor: Color(0xFFC62828),
          followerColor: Color(0xFFEF5350),
        ),

        // Section 4: Offset values
        _buildSectionTitle(Icons.open_with, '4. Follower Offset Values'),
        _buildInfoCard(
          'offset',
          'Additional pixel offset applied after anchor alignment. Useful for adding spacing between target and follower (e.g., gap between button and dropdown).',
        ),
        _buildTargetFollowerDemo(
          label: 'offset: Offset(0, 0) - no gap',
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          followerOffset: Offset(0, 0),
          targetColor: Color(0xFF455A64),
          followerColor: Color(0xFF78909C),
        ),
        _buildTargetFollowerDemo(
          label: 'offset: Offset(20, 20) - diagonal gap',
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topLeft,
          followerOffset: Offset(20, 20),
          targetColor: Color(0xFF4E342E),
          followerColor: Color(0xFF8D6E63),
        ),
        _buildTargetFollowerDemo(
          label: 'offset: Offset(-10, 5) - negative X shift',
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          followerOffset: Offset(-10, 5),
          targetColor: Color(0xFF1A237E),
          followerColor: Color(0xFF5C6BC0),
        ),

        // Section 5: showWhenUnlinked behavior
        _buildSectionTitle(Icons.visibility, '5. showWhenUnlinked Behavior'),
        _buildInfoCard(
          'showWhenUnlinked',
          'When true (default), the follower is shown even if the LayerLink has no leader. When false, follower is hidden if the leader is not in the layer tree.',
        ),
        _buildShowWhenUnlinkedDemo(),

        // Section 6: Practical tooltip pattern
        _buildSectionTitle(
          Icons.chat_bubble,
          '6. Practical Pattern: Custom Tooltip',
        ),
        _buildInfoCard(
          'Tooltip Pattern',
          'Use targetAnchor: topCenter with followerAnchor: bottomCenter and a negative Y offset to position a tooltip above the target widget.',
        ),
        _buildTooltipDemo('Click to edit this item', Color(0xFF00897B)),
        _buildTooltipDemo('Save your progress', Color(0xFF1565C0)),

        // Section 7: Practical dropdown pattern
        _buildSectionTitle(
          Icons.arrow_drop_down_circle,
          '7. Practical Pattern: Dropdown Menu',
        ),
        _buildInfoCard(
          'Dropdown Pattern',
          'Use targetAnchor: bottomLeft with followerAnchor: topLeft to position a dropdown directly below the trigger button.',
        ),
        _buildDropdownDemo(),

        // Section 8: Contextual popup pattern
        _buildSectionTitle(
          Icons.web_asset,
          '8. Practical Pattern: Contextual Popup',
        ),
        _buildInfoCard(
          'Popup Pattern',
          'Use targetAnchor: centerRight with followerAnchor: centerLeft to show a popup card next to an avatar or icon button.',
        ),
        _buildContextualPopup(),

        // Section 9: Multiple pairs in one layout
        _buildSectionTitle(
          Icons.dashboard,
          '9. Multiple Target-Follower Pairs',
        ),
        _buildInfoCard(
          'Multiple LayerLinks',
          'Each target-follower pair uses its own LayerLink instance. Multiple pairs can coexist independently in the same widget tree.',
        ),
        _buildMultiPairLayout(),

        // Section 10: LayerLink configuration summary
        _buildSectionTitle(
          Icons.settings,
          '10. LayerLink Configuration Summary',
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFA5D6A7), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Reference',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
              SizedBox(height: 10),
              _buildConfigRow(
                'LayerLink',
                'Shared object connecting target and follower',
              ),
              _buildConfigRow(
                'CompositedTransformTarget',
                'Wraps the leader widget (creates RenderLeaderLayer)',
              ),
              _buildConfigRow(
                'CompositedTransformFollower',
                'Wraps the follower widget (creates RenderFollowerLayer)',
              ),
              _buildConfigRow(
                'targetAnchor',
                'Alignment point on the target widget',
              ),
              _buildConfigRow(
                'followerAnchor',
                'Alignment point on the follower widget',
              ),
              _buildConfigRow(
                'offset',
                'Additional pixel offset after anchor calculation',
              ),
              _buildConfigRow(
                'showWhenUnlinked',
                'Whether follower shows when leader is absent',
              ),
            ],
          ),
        ),

        // Footer summary
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF004D40), Color(0xFF00695C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RenderLeaderLayer Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'RenderLeaderLayer (via CompositedTransformTarget) creates a compositing '
                'layer anchor point. RenderFollowerLayer (via CompositedTransformFollower) '
                'positions itself relative to that anchor using targetAnchor, followerAnchor, '
                'and offset. This pattern enables tooltips, dropdown menus, context popups, '
                'and any overlay that must track another widget across frames.',
                style: TextStyle(fontSize: 12, color: Color(0xCCFFFFFF)),
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
      ],
    ),
  );
}

Widget _buildConfigRow(String key, String value) {
  print('Config: $key = $value');
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(top: 4, right: 8),
          decoration: BoxDecoration(
            color: Color(0xFF00897B),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 200,
          child: Text(
            key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Color(0xFF004D40),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 11, color: Color(0xFF37474F)),
          ),
        ),
      ],
    ),
  );
}

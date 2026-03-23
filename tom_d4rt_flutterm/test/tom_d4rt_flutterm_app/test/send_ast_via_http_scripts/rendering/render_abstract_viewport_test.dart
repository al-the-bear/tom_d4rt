// ignore_for_file: avoid_print
// D4rt test script: Deep demo for RenderAbstractViewport from rendering
//
// RenderAbstractViewport is the abstract base class for viewports that
// provide scrollable content. It defines the contract for how viewports
// calculate scroll offsets and reveal descendant render objects.
//
// Key subclasses:
//   RenderViewport - fixed-size viewport with slivers
//   RenderShrinkWrappingViewport - viewport that sizes to content
//
// Key methods:
//   getOffsetToReveal() - calculates scroll offset to reveal a RenderObject
//   showOnScreen() - scrolls viewport to make a child visible
//
// Architecture:
//   Viewport -> Slivers -> Content (RenderObjects)
//   ScrollPosition controls the offset
//   ViewportOffset provides the pixel offset
//
// This demo visualizes the RenderAbstractViewport class comprehensively.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════════

Color _kPrimary200 = Color(0xFF90CAF9);
Color _kPrimary300 = Color(0xFF64B5F6);
Color _kPrimary400 = Color(0xFF42A5F5);
Color _kPrimary500 = Color(0xFF2196F3);
Color _kPrimary600 = Color(0xFF1E88E5);
Color _kPrimary700 = Color(0xFF1976D2);
Color _kPrimary800 = Color(0xFF1565C0);

Color _kSecondary500 = Color(0xFF26A69A);
Color _kSecondary600 = Color(0xFF009688);
Color _kSecondary700 = Color(0xFF00897B);

Color _kAccent500 = Color(0xFFFF7043);
Color _kAccent600 = Color(0xFFF4511E);

Color _kSuccess500 = Color(0xFF66BB6A);
Color _kSuccess600 = Color(0xFF43A047);

Color _kWarning500 = Color(0xFFFFA726);
Color _kWarning600 = Color(0xFFFB8C00);

Color _kPurple500 = Color(0xFF7E57C2);
Color _kPurple600 = Color(0xFF673AB7);

Color _kSlate100 = Color(0xFFF1F5F9);
Color _kSlate200 = Color(0xFFE2E8F0);
Color _kSlate300 = Color(0xFFCBD5E1);
Color _kSlate500 = Color(0xFF64748B);
Color _kSlate600 = Color(0xFF475569);
Color _kSlate700 = Color(0xFF334155);
Color _kSlate800 = Color(0xFF1E293B);

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPrimary800, _kPrimary600, _kPrimary400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: _kPrimary800.withAlpha(120),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.view_agenda_outlined, color: Colors.white, size: 56),
        SizedBox(height: 16),
        Text(
          'RenderAbstractViewport',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Abstract base class for scrollable viewports',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withAlpha(220),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBadge('getOffsetToReveal', Icons.location_searching, _kSecondary500),
            SizedBox(width: 12),
            _buildBadge('showOnScreen', Icons.visibility, _kAccent500),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBadge('RenderViewport', Icons.crop_square, _kPurple500),
            SizedBox(width: 12),
            _buildBadge('ShrinkWrapping', Icons.compress, _kWarning500),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBadge(String label, IconData icon, Color bgColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: bgColor.withAlpha(180),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withAlpha(100), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 16),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon, Color color) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withAlpha(180)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(80),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String title, Widget content, {Color? accentColor}) {
  Color color = accentColor ?? _kPrimary500;
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withAlpha(60), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(16), child: content),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: _kSlate700,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _kSlate600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeSnippet(String code, {Color? bgColor}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: bgColor ?? _kSlate800,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFFE2E8F0),
        height: 1.5,
      ),
    ),
  );
}

Widget _buildDiagramBox(String label, Color color, {IconData? icon, double width = 90, double height = 70}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color.withAlpha(40),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) Icon(icon, color: color, size: 20),
        if (icon != null) SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildArrowDown(Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 2, height: 14, color: color),
      Icon(Icons.arrow_drop_down, color: color, size: 20),
    ],
  );
}



Widget _buildTableHeader(List<String> headers, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    child: Row(
      children: headers
          .map((h) => Expanded(
                child: Text(
                  h,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ))
          .toList(),
    ),
  );
}

Widget _buildTableRow(List<String> cells, {Color? bgColor}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    decoration: BoxDecoration(
      color: bgColor ?? Colors.transparent,
      border: Border(bottom: BorderSide(color: _kSlate200, width: 1)),
    ),
    child: Row(
      children: cells
          .map((c) => Expanded(
                child: Text(
                  c,
                  style: TextStyle(fontSize: 11, color: _kSlate700),
                  textAlign: TextAlign.center,
                ),
              ))
          .toList(),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: RENDER ABSTRACT VIEWPORT OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
  print('--- Section 1: RenderAbstractViewport Overview ---');
  print('RenderAbstractViewport: abstract base class for scroll viewports');
  print('Defines contract for getOffsetToReveal and showOnScreen');
  print('Subclasses: RenderViewport, RenderShrinkWrappingViewport');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(
        '1. RenderAbstractViewport Overview',
        Icons.info_outline,
        _kPrimary700,
      ),
      _buildInfoCard(
        'What is RenderAbstractViewport?',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Type', 'Abstract class (mixin on RenderObject)'),
            _buildInfoRow('Library', 'package:flutter/rendering.dart'),
            _buildInfoRow('Purpose', 'Base for viewports providing scrollable content'),
            _buildInfoRow('Subclasses', 'RenderViewport, RenderShrinkWrappingViewport'),
            _buildInfoRow('Static Method', 'RenderAbstractViewport.of(RenderObject)'),
            SizedBox(height: 12),
            Text(
              'RenderAbstractViewport establishes the interface that all '
              'viewport render objects must implement. It provides the '
              'mechanism for calculating how to scroll to reveal a '
              'specific descendant within the scrollable area.',
              style: TextStyle(fontSize: 13, color: _kSlate600, height: 1.5),
            ),
          ],
        ),
        accentColor: _kPrimary600,
      ),
      _buildInfoCard(
        'Role in Scroll Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('ScrollView', 'Creates the viewport widget'),
            _buildInfoRow('Viewport', 'Renders using RenderViewport'),
            _buildInfoRow('SliverList', 'Provides lazy child rendering'),
            _buildInfoRow('ScrollPosition', 'Tracks scroll offset'),
            _buildInfoRow('ViewportOffset', 'Pixel-level offset control'),
            SizedBox(height: 12),
            _buildCodeSnippet(
              '// Finding the viewport ancestor\n'
              'RenderAbstractViewport viewport =\n'
              '    RenderAbstractViewport.of(renderObject);\n'
              '\n'
              '// Get offset to reveal a child\n'
              'RevealedOffset offset =\n'
              '    viewport.getOffsetToReveal(\n'
              '      targetRenderObject,\n'
              '      0.0,  // alignment\n'
              '    );',
            ),
          ],
        ),
        accentColor: _kSecondary600,
      ),
      _buildInfoCard(
        'Type Hierarchy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeSnippet(
              'RenderObject\n'
              '  +-- RenderAbstractViewport (mixin)\n'
              '       |\n'
              '       +-- RenderViewport\n'
              '       |     Fixed-size, uses slivers\n'
              '       |     Most common viewport type\n'
              '       |\n'
              '       +-- RenderShrinkWrappingViewport\n'
              '             Sizes to content\n'
              '             Used with shrinkWrap: true',
            ),
          ],
        ),
        accentColor: _kPurple600,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: VIEWPORT ARCHITECTURE DIAGRAM
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildArchitectureDiagramSection() {
  print('--- Section 2: Viewport Architecture Diagram ---');
  print('Viewport -> Slivers -> Content relationship');
  print('ScrollController -> ScrollPosition -> ViewportOffset');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(
        '2. Viewport Architecture',
        Icons.account_tree,
        _kSecondary600,
      ),
      _buildInfoCard(
        'Scroll System Data Flow',
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiagramBox('ScrollController', _kPrimary600, icon: Icons.control_camera),
              ],
            ),
            _buildArrowDown(_kPrimary500),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiagramBox('ScrollPosition', _kPrimary500, icon: Icons.pin_drop),
              ],
            ),
            _buildArrowDown(_kPrimary400),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiagramBox('ViewportOffset', _kSecondary600, icon: Icons.swap_vert),
              ],
            ),
            _buildArrowDown(_kSecondary500),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiagramBox('Abstract\nViewport', _kAccent600, icon: Icons.view_agenda, width: 110, height: 80),
              ],
            ),
            _buildArrowDown(_kAccent500),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDiagramBox('Sliver A', _kPurple500, icon: Icons.list),
                _buildDiagramBox('Sliver B', _kPurple500, icon: Icons.grid_view),
                _buildDiagramBox('Sliver C', _kPurple500, icon: Icons.view_list),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildArrowDown(_kSuccess500),
                _buildArrowDown(_kSuccess500),
                _buildArrowDown(_kSuccess500),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDiagramBox('Content', _kSuccess500, icon: Icons.widgets, width: 80, height: 50),
                _buildDiagramBox('Content', _kSuccess500, icon: Icons.widgets, width: 80, height: 50),
                _buildDiagramBox('Content', _kSuccess500, icon: Icons.widgets, width: 80, height: 50),
              ],
            ),
          ],
        ),
        accentColor: _kSecondary600,
      ),
      _buildInfoCard(
        'Viewport Responsibilities',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Layout Slivers', 'Lays out slivers within constraints'),
            _buildInfoRow('Paint Content', 'Clips and paints visible portion'),
            _buildInfoRow('Hit Testing', 'Routes hit tests to visible slivers'),
            _buildInfoRow('Reveal Objects', 'Calculates offset to reveal descendants'),
            _buildInfoRow('Cache Extent', 'Pre-renders content beyond visible area'),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kSecondary500.withAlpha(15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kSecondary500.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cache Extent',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _kSecondary700,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'The viewport pre-renders content beyond the visible area '
                    '(default 250 logical pixels). This ensures smooth scrolling '
                    'by having content ready before it scrolls into view.',
                    style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
        accentColor: _kPrimary600,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: GET OFFSET TO REVEAL METHOD
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildGetOffsetToRevealSection() {
  print('--- Section 3: getOffsetToReveal Method ---');
  print('Calculates scroll offset to reveal a descendant RenderObject');
  print('Returns RevealedOffset with offset and rect');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(
        '3. getOffsetToReveal Method',
        Icons.location_searching,
        _kAccent600,
      ),
      _buildInfoCard(
        'Method Signature',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeSnippet(
              'RevealedOffset getOffsetToReveal(\n'
              '  RenderObject target,\n'
              '  double alignment, {\n'
              '  Rect? rect,\n'
              '})',
            ),
            SizedBox(height: 16),
            _buildInfoRow('target', 'The RenderObject to make visible'),
            _buildInfoRow('alignment', '0.0 = leading edge, 1.0 = trailing edge'),
            _buildInfoRow('rect', 'Sub-area of target to reveal (optional)'),
            _buildInfoRow('Returns', 'RevealedOffset with offset + rect'),
          ],
        ),
        accentColor: _kAccent600,
      ),
      _buildInfoCard(
        'Alignment Parameter Visual',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kSlate100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildAlignmentRow('0.0', 'Target at leading edge (top/left)', _kSuccess500),
                  SizedBox(height: 8),
                  _buildAlignmentRow('0.5', 'Target centered in viewport', _kWarning500),
                  SizedBox(height: 8),
                  _buildAlignmentRow('1.0', 'Target at trailing edge (bottom/right)', _kAccent500),
                ],
              ),
            ),
            SizedBox(height: 12),
            _buildCodeSnippet(
              '// Scroll to show item at top of viewport\n'
              'RevealedOffset result =\n'
              '    viewport.getOffsetToReveal(target, 0.0);\n'
              'print("Offset: " + result.offset.toString());\n'
              'print("Rect: " + result.rect.toString());\n'
              '\n'
              '// Scroll to center item in viewport\n'
              'RevealedOffset centered =\n'
              '    viewport.getOffsetToReveal(target, 0.5);',
            ),
          ],
        ),
        accentColor: _kWarning600,
      ),
      _buildInfoCard(
        'RevealedOffset Return Value',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('offset', 'ViewportOffset.pixels needed to reveal target'),
            _buildInfoRow('rect', 'Bounding rect of target in viewport coordinates'),
            SizedBox(height: 12),
            _buildCodeSnippet(
              'class RevealedOffset {\n'
              '  // The scroll offset to apply\n'
              '  final double offset;\n'
              '\n'
              '  // The visible rect in viewport coords\n'
              '  final Rect rect;\n'
              '}',
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kAccent500.withAlpha(15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kAccent500.withAlpha(40)),
              ),
              child: Text(
                'The offset value can be applied to a ScrollController to '
                'animate or jump to the position that reveals the target.',
                style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.4),
              ),
            ),
          ],
        ),
        accentColor: _kPurple600,
      ),
    ],
  );
}

Widget _buildAlignmentRow(String value, String description, Color color) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 28,
        decoration: BoxDecoration(
          color: color.withAlpha(40),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color, width: 1),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
          ),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(
          description,
          style: TextStyle(fontSize: 12, color: _kSlate600),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: SHOW ON SCREEN BEHAVIOR
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildShowOnScreenSection() {
  print('--- Section 4: showOnScreen Behavior ---');
  print('showOnScreen scrolls viewport to make child visible');
  print('Called automatically by focus system, Scrollable.ensureVisible, etc.');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(
        '4. showOnScreen Behavior',
        Icons.visibility,
        _kPurple600,
      ),
      _buildInfoCard(
        'showOnScreen Method',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeSnippet(
              'void showOnScreen({\n'
              '  RenderObject? descendant,\n'
              '  Rect? rect,\n'
              '  Duration duration = Duration.zero,\n'
              '  Curve curve = Curves.ease,\n'
              '})',
            ),
            SizedBox(height: 16),
            _buildInfoRow('descendant', 'Child render object to reveal'),
            _buildInfoRow('rect', 'Sub-area within descendant to show'),
            _buildInfoRow('duration', 'Animation duration (zero = instant)'),
            _buildInfoRow('curve', 'Animation curve for smooth scrolling'),
          ],
        ),
        accentColor: _kPurple600,
      ),
      _buildInfoCard(
        'How showOnScreen Works',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepRow(1, 'Viewport calls getOffsetToReveal for the descendant', _kPrimary500),
            SizedBox(height: 8),
            _buildStepRow(2, 'Gets RevealedOffset with target scroll position', _kSecondary500),
            SizedBox(height: 8),
            _buildStepRow(3, 'Animates or jumps ViewportOffset to new position', _kAccent500),
            SizedBox(height: 8),
            _buildStepRow(4, 'Layout re-runs with new offset, revealing child', _kSuccess500),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kPurple500.withAlpha(15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kPurple500.withAlpha(40)),
              ),
              child: Text(
                'showOnScreen is called automatically when a TextField receives '
                'focus, when Scrollable.ensureVisible is invoked, or when '
                'accessibility actions request scrolling to a child.',
                style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.4),
              ),
            ),
          ],
        ),
        accentColor: _kSecondary600,
      ),
      _buildInfoCard(
        'Triggers for showOnScreen',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTableHeader(['Trigger', 'Source', 'Scroll'], _kPurple600),
            _buildTableRow(['Focus gain', 'FocusNode', 'Animated']),
            _buildTableRow(['ensureVisible', 'Scrollable', 'Animated'], bgColor: _kSlate100),
            _buildTableRow(['Accessibility', 'Semantics', 'Animated']),
            _buildTableRow(['showInViewport', 'TextInput', 'Animated'], bgColor: _kSlate100),
            _buildTableRow(['ScrollPosition', 'jumpTo', 'Instant']),
            SizedBox(height: 12),
            _buildCodeSnippet(
              '// Scrollable.ensureVisible usage\n'
              'Scrollable.ensureVisible(\n'
              '  context,\n'
              '  alignment: 0.5,\n'
              '  duration: Duration(milliseconds: 300),\n'
              '  curve: Curves.easeInOut,\n'
              ');',
            ),
          ],
        ),
        accentColor: _kPrimary600,
      ),
    ],
  );
}

Widget _buildStepRow(int number, String description, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color.withAlpha(40),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            description,
            style: TextStyle(fontSize: 13, color: _kSlate700),
          ),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: VIEWPORT VS SHRINK WRAPPING VIEWPORT
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildViewportComparisonSection() {
  print('--- Section 5: Viewport vs ShrinkWrapping Viewport ---');
  print('RenderViewport: fixed size, expands to fill parent');
  print('RenderShrinkWrappingViewport: sizes to content, shrinkWrap mode');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(
        '5. Viewport vs ShrinkWrapping',
        Icons.compare_arrows,
        _kWarning600,
      ),
      _buildInfoCard(
        'RenderViewport (Standard)',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_kPrimary200, _kPrimary500],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kPrimary600, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.crop_square, color: Colors.white, size: 32),
                      SizedBox(height: 4),
                      Text('Fixed Size', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Size', 'Fills available space from parent'),
                      _buildInfoRow('Scrolling', 'Content scrolls within fixed bounds'),
                      _buildInfoRow('Performance', 'Excellent - lazy rendering'),
                      _buildInfoRow('shrinkWrap', 'false (default)'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        accentColor: _kPrimary600,
      ),
      _buildInfoCard(
        'RenderShrinkWrappingViewport',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_kWarning500.withAlpha(150), _kWarning600],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kWarning600, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.compress, color: Colors.white, size: 32),
                      SizedBox(height: 4),
                      Text('Shrink', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Size', 'Shrinks to fit content'),
                      _buildInfoRow('Scrolling', 'Only scrolls if content overflows'),
                      _buildInfoRow('Performance', 'Less efficient - measures all'),
                      _buildInfoRow('shrinkWrap', 'true'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        accentColor: _kWarning600,
      ),
      _buildInfoCard(
        'Comparison Table',
        Column(
          children: [
            _buildTableHeader(['Feature', 'Viewport', 'ShrinkWrap'], _kSlate700),
            _buildTableRow(['Size', 'Fills parent', 'Fits content']),
            _buildTableRow(['Performance', 'O(visible)', 'O(all)'], bgColor: _kSlate100),
            _buildTableRow(['Lazy loading', 'Yes', 'No']),
            _buildTableRow(['Nested scroll', 'No', 'Yes'], bgColor: _kSlate100),
            _buildTableRow(['Cache extent', 'Applies', 'Applies']),
            _buildTableRow(['Use case', 'Primary scroll', 'Inner list'], bgColor: _kSlate100),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kWarning500.withAlpha(15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kWarning500.withAlpha(40)),
              ),
              child: Text(
                'Avoid shrinkWrap: true for long lists. It forces layout of '
                'all children upfront, eliminating the performance benefit '
                'of lazy rendering that viewports provide.',
                style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.4),
              ),
            ),
          ],
        ),
        accentColor: _kSlate700,
      ),
      _buildInfoCard(
        'Code Comparison',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Standard Viewport (preferred):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: _kPrimary700,
              ),
            ),
            SizedBox(height: 8),
            _buildCodeSnippet(
              'ListView.builder(\n'
              '  // Uses RenderViewport internally\n'
              '  shrinkWrap: false,\n'
              '  itemCount: 1000,\n'
              '  itemBuilder: (context, index) {\n'
              '    return ListTile(\n'
              '      title: Text("Item " + index.toString()),\n'
              '    );\n'
              '  },\n'
              ')',
            ),
            SizedBox(height: 16),
            Text(
              'ShrinkWrapping Viewport:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: _kWarning600,
              ),
            ),
            SizedBox(height: 8),
            _buildCodeSnippet(
              'ListView.builder(\n'
              '  // Uses RenderShrinkWrappingViewport\n'
              '  shrinkWrap: true,\n'
              '  physics: NeverScrollableScrollPhysics(),\n'
              '  itemCount: 5,\n'
              '  itemBuilder: (context, index) {\n'
              '    return ListTile(\n'
              '      title: Text("Item " + index.toString()),\n'
              '    );\n'
              '  },\n'
              ')',
            ),
          ],
        ),
        accentColor: _kAccent600,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: COMMON PATTERNS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCommonPatternsSection() {
  print('--- Section 6: Common Patterns ---');
  print('Scrolling to item, ensuring visibility, scroll notifications');
  print('Using ScrollController, GlobalKey, and Scrollable.ensureVisible');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(
        '6. Common Patterns',
        Icons.pattern,
        _kSuccess600,
      ),
      _buildInfoCard(
        'Scrolling to a Specific Item',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeSnippet(
              '// Using ScrollController with known offset\n'
              'ScrollController controller =\n'
              '    ScrollController();\n'
              '\n'
              '// Jump to offset\n'
              'controller.jumpTo(300.0);\n'
              '\n'
              '// Animate to offset\n'
              'controller.animateTo(\n'
              '  300.0,\n'
              '  duration: Duration(milliseconds: 500),\n'
              '  curve: Curves.easeInOut,\n'
              ');',
            ),
            SizedBox(height: 12),
            Text(
              'For fixed-height items, calculate the offset directly: '
              'offset = index * itemHeight. For variable-height items, '
              'use GlobalKey + Scrollable.ensureVisible.',
              style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.4),
            ),
          ],
        ),
        accentColor: _kSuccess600,
      ),
      _buildInfoCard(
        'Ensuring Visibility with GlobalKey',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeSnippet(
              '// Attach a GlobalKey to the target widget\n'
              'GlobalKey targetKey = GlobalKey();\n'
              '\n'
              '// In the list:\n'
              'Container(\n'
              '  key: targetKey,\n'
              '  child: Text("Target item"),\n'
              ')\n'
              '\n'
              '// Scroll to reveal the widget:\n'
              'BuildContext? targetContext =\n'
              '    targetKey.currentContext;\n'
              'if (targetContext != null) {\n'
              '  Scrollable.ensureVisible(\n'
              '    targetContext,\n'
              '    alignment: 0.0,\n'
              '    duration: Duration(milliseconds: 300),\n'
              '  );\n'
              '}',
            ),
          ],
        ),
        accentColor: _kPrimary600,
      ),
      _buildInfoCard(
        'Scroll Notifications',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTableHeader(['Notification', 'When', 'Data'], _kSuccess600),
            _buildTableRow(['ScrollStart', 'Scroll begins', 'DragStartDetails']),
            _buildTableRow(['ScrollUpdate', 'Scroll moves', 'scrollDelta'], bgColor: _kSlate100),
            _buildTableRow(['ScrollEnd', 'Scroll stops', 'DragEndDetails']),
            _buildTableRow(['OverScroll', 'Past bounds', 'overscroll amount'], bgColor: _kSlate100),
            _buildTableRow(['UserScroll', 'User gesture', 'ScrollDirection']),
            SizedBox(height: 12),
            _buildCodeSnippet(
              '// Listen for scroll notifications\n'
              'NotificationListener<ScrollNotification>(\n'
              '  onNotification: (notification) {\n'
              '    if (notification\n'
              '        is ScrollUpdateNotification) {\n'
              '      print("Scrolled: "\n'
              '        + notification.metrics\n'
              '            .pixels.toString());\n'
              '    }\n'
              '    return false;\n'
              '  },\n'
              '  child: ListView( /* ... */ ),\n'
              ')',
            ),
          ],
        ),
        accentColor: _kSecondary600,
      ),
      _buildInfoCard(
        'Best Practices',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPracticeRow(Icons.check_circle, 'Use RenderViewport (shrinkWrap: false) for main scrolling lists', _kSuccess500),
            SizedBox(height: 8),
            _buildPracticeRow(Icons.check_circle, 'Keep ShrinkWrap for short lists inside other scrollables', _kSuccess500),
            SizedBox(height: 8),
            _buildPracticeRow(Icons.check_circle, 'Use Scrollable.ensureVisible for programmatic scrolling', _kSuccess500),
            SizedBox(height: 8),
            _buildPracticeRow(Icons.warning, 'Avoid shrinkWrap: true with large item counts', _kWarning500),
            SizedBox(height: 8),
            _buildPracticeRow(Icons.warning, 'Avoid nesting scrollables without proper physics', _kWarning500),
            SizedBox(height: 8),
            _buildPracticeRow(Icons.error, 'Never use unbounded viewport in unbounded parent', _kAccent500),
          ],
        ),
        accentColor: _kSlate700,
      ),
    ],
  );
}

Widget _buildPracticeRow(IconData icon, String text, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: color, size: 18),
      SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 12, color: _kSlate700, height: 1.3),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// FOOTER
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildFooter() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _kSlate800,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.view_agenda_outlined, color: _kPrimary300, size: 24),
            SizedBox(width: 10),
            Text(
              'RenderAbstractViewport Demo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Abstract base class for scrollable viewport render objects',
          style: TextStyle(color: _kSlate300, fontSize: 12),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFooterBadge('getOffsetToReveal', _kSecondary500),
            SizedBox(width: 10),
            _buildFooterBadge('showOnScreen', _kAccent500),
            SizedBox(width: 10),
            _buildFooterBadge('RenderViewport', _kPurple500),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: _kSlate600, thickness: 1),
        SizedBox(height: 12),
        Text(
          'Flutter Rendering Library | RenderAbstractViewport',
          style: TextStyle(color: _kSlate500, fontSize: 11),
        ),
      ],
    ),
  );
}

Widget _buildFooterBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withAlpha(50),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== RenderAbstractViewport Deep Demo ===');
  print('Abstract base class for scrollable viewports');
  print('Key methods: getOffsetToReveal, showOnScreen');
  print('Subclasses: RenderViewport, RenderShrinkWrappingViewport');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 24),
            _buildOverviewSection(),
            SizedBox(height: 24),
            _buildArchitectureDiagramSection(),
            SizedBox(height: 24),
            _buildGetOffsetToRevealSection(),
            SizedBox(height: 24),
            _buildShowOnScreenSection(),
            SizedBox(height: 24),
            _buildViewportComparisonSection(),
            SizedBox(height: 24),
            _buildCommonPatternsSection(),
            SizedBox(height: 24),
            _buildFooter(),
          ],
        ),
      ),
    ),
  );
}

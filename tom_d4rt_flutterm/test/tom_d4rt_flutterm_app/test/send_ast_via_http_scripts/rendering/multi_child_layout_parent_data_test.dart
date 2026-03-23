// ignore_for_file: avoid_print
// D4rt test script: Comprehensive deep demo for MultiChildLayoutParentData
//
// MultiChildLayoutParentData is the parent data class used by
// CustomMultiChildLayout. It stores the `id` that identifies each child
// in the layout, enabling the MultiChildLayoutDelegate to position and
// size children by name.
//
// This demo shows:
//   1. Header banner explaining CustomMultiChildLayout purpose
//   2. How LayoutId assigns ids to children (the key concept)
//   3. MultiChildLayoutDelegate lifecycle (hasChild, layoutChild, positionChild)
//   4. Dashboard panel layout (header / sidebar / content / footer)
//   5. Overlapping card stack layout
//   6. Profile layout (avatar / name / bio arranged by delegate)
//   7. Practical code snippets and patterns
//   8. Quick reference card
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS — Teal / Violet theme
// ═══════════════════════════════════════════════════════════════════════════

const _kTeal50 = Color(0xFFF0FDFA);
const _kTeal100 = Color(0xFFCCFBF1);
const _kTeal200 = Color(0xFF99F6E4);
const _kTeal500 = Color(0xFF14B8A6);
const _kTeal600 = Color(0xFF0D9488);
const _kTeal700 = Color(0xFF0F766E);
const _kTeal800 = Color(0xFF115E59);

const _kViolet100 = Color(0xFFEDE9FE);
const _kViolet300 = Color(0xFFC4B5FD);
const _kViolet500 = Color(0xFF8B5CF6);
const _kViolet700 = Color(0xFF6D28D9);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Section header with gradient bar, icon, and title.
Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kTeal700, _kTeal500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kTeal700.withAlpha(80),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
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

/// Themed card wrapper with optional accent colour.
Widget _buildCard(String title, Widget content, {Color? accentColor}) {
  final color = accentColor ?? _kTeal500;
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(50), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.all(16), child: content),
      ],
    ),
  );
}

/// Inline code-style text label.
Widget _buildCodeLabel(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: _kViolet100,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kViolet300, width: 1),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFF4C1D95),
      ),
    ),
  );
}

/// A small colour chip used in the colour swatch rows.
Widget _buildChip(String label, Color bg) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: bg.computeLuminance() > 0.45 ? Colors.black87 : Colors.white,
      ),
    ),
  );
}

/// Code snippet block with dark background.
Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kViolet500.withAlpha(60), width: 1),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.5,
        color: Color(0xFFCDD6F4),
      ),
    ),
  );
}

/// A simulated layout panel used in dashboard visualization.
Widget _buildPanelBox(String label, Color bg, {double? width, double? height}) {
  return Container(
    width: width,
    height: height,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: bg.withAlpha(35),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: bg, width: 2),
    ),
    child: Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: bg),
      ),
    ),
  );
}

/// A row showing a delegate method name and its description.
Widget _buildMethodRow(String method, String description, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _kViolet500.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kViolet500, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeLabel(method),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Overlapping card for section 5.
Widget _buildOverlapCard(
  int index,
  String label,
  Color color,
  double leftOffset,
) {
  return Positioned(
    left: leftOffset,
    top: index * 14.0,
    child: Container(
      width: 150,
      height: 90,
      decoration: BoxDecoration(
        color: color.withAlpha(220),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(80),
            blurRadius: 8,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

/// Quick reference row: property | type | description.
Widget _buildRefRow(String property, String type, String desc) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    margin: const EdgeInsets.only(bottom: 6),
    decoration: BoxDecoration(
      color: _kTeal50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kTeal200, width: 1),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            property,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF115E59),
            ),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _kViolet700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// BUILD ENTRY POINT
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== MultiChildLayoutParentData Deep Demo ===');
  print('CustomMultiChildLayout positions children via a delegate');
  print('MultiChildLayoutParentData stores the id that maps each child');
  print('LayoutId widget wraps each child and assigns the id');
  print('Demo: dashboard, card stack, profile, delegate methods');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ═════════════════════════════════════════════════════════════════
        // 1 — HERO BANNER
        // ═════════════════════════════════════════════════════════════════
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kTeal800, _kViolet700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _kTeal800.withAlpha(90),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.dashboard_customize,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MultiChildLayoutParentData',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Parent data for CustomMultiChildLayout',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xCCFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'MultiChildLayoutParentData holds the id that identifies '
                  'each child in a CustomMultiChildLayout. The delegate uses '
                  'these ids to query, size, and position every child — '
                  'enabling fully custom layouts that go beyond Row/Column/Stack.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ═════════════════════════════════════════════════════════════════
        // 2 — HOW LayoutId ASSIGNS IDS
        // ═════════════════════════════════════════════════════════════════
        _buildSectionHeader('LayoutId & Child Identification', Icons.label),
        _buildCard(
          'LayoutId wraps each child',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Each child of CustomMultiChildLayout must be wrapped in a '
                'LayoutId widget. LayoutId writes its id into the child\'s '
                'MultiChildLayoutParentData so the delegate can look it up.',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 14),
              _buildCodeBlock(
                'CustomMultiChildLayout(\n'
                '  delegate: _MyDelegate(),\n'
                '  children: [\n'
                '    LayoutId(\n'
                '      id: \'header\',   // stored in parentData.id\n'
                '      child: HeaderWidget(),\n'
                '    ),\n'
                '    LayoutId(\n'
                '      id: \'sidebar\',\n'
                '      child: SidebarWidget(),\n'
                '    ),\n'
                '    LayoutId(\n'
                '      id: \'content\',\n'
                '      child: ContentWidget(),\n'
                '    ),\n'
                '  ],\n'
                ')',
              ),
              const SizedBox(height: 14),
              Wrap(
                children: [
                  _buildChip('header', _kTeal500),
                  _buildChip('sidebar', _kViolet500),
                  _buildChip('content', _kTeal600),
                  _buildChip('footer', _kViolet700),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Ids can be strings, enums, or any Object — they just need '
                'to be compared with ==. Using an enum is recommended for '
                'type safety.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // ═════════════════════════════════════════════════════════════════
        // 3 — DELEGATE LIFECYCLE METHODS
        // ═════════════════════════════════════════════════════════════════
        _buildSectionHeader('Delegate Methods', Icons.account_tree),
        _buildCard(
          'MultiChildLayoutDelegate API',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'The delegate\'s performLayout() is the heart of the layout. '
                'It uses three key methods to query, size, and place children:',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 14),
              _buildMethodRow(
                'hasChild(id)',
                'Returns true if a child with this id exists. '
                    'Always guard optional children.',
                Icons.check_circle_outline,
              ),
              _buildMethodRow(
                'layoutChild(id, constraints)',
                'Lay out the child with the given BoxConstraints and '
                    'return its Size. Must be called exactly once per child.',
                Icons.aspect_ratio,
              ),
              _buildMethodRow(
                'positionChild(id, offset)',
                'Set the top-left position of the child via an Offset. '
                    'If not called the child defaults to Offset.zero.',
                Icons.open_with,
              ),
              const SizedBox(height: 10),
              _buildCodeBlock(
                'class _MyDelegate extends MultiChildLayoutDelegate {\n'
                '  @override\n'
                '  void performLayout(Size size) {\n'
                '    // 1. Layout header across full width\n'
                '    final headerSize = layoutChild(\n'
                '      \'header\',\n'
                '      BoxConstraints.tightFor(width: size.width),\n'
                '    );\n'
                '    positionChild(\'header\', Offset.zero);\n'
                '\n'
                '    // 2. Layout sidebar on the left\n'
                '    final sidebarSize = layoutChild(\n'
                '      \'sidebar\',\n'
                '      BoxConstraints(\n'
                '        maxWidth: size.width * 0.3,\n'
                '        maxHeight: size.height - headerSize.height,\n'
                '      ),\n'
                '    );\n'
                '    positionChild(\n'
                '      \'sidebar\',\n'
                '      Offset(0, headerSize.height),\n'
                '    );\n'
                '\n'
                '    // 3. Content fills remaining space\n'
                '    if (hasChild(\'content\')) {\n'
                '      layoutChild(\n'
                '        \'content\',\n'
                '        BoxConstraints.tightFor(\n'
                '          width: size.width - sidebarSize.width,\n'
                '          height: size.height - headerSize.height,\n'
                '        ),\n'
                '      );\n'
                '      positionChild(\n'
                '        \'content\',\n'
                '        Offset(sidebarSize.width, headerSize.height),\n'
                '      );\n'
                '    }\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  bool shouldRelayout(covariant _MyDelegate old) => false;\n'
                '}',
              ),
            ],
          ),
          accentColor: _kViolet500,
        ),
        const SizedBox(height: 8),

        // ═════════════════════════════════════════════════════════════════
        // 4 — DASHBOARD PANEL LAYOUT (visual)
        // ═════════════════════════════════════════════════════════════════
        _buildSectionHeader('Dashboard Panel Layout', Icons.grid_view),
        _buildCard(
          'Simulated Delegate Output',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Below is a simulated dashboard that a MultiChildLayoutDelegate '
                'could produce. Each panel is identified by a LayoutId:',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 14),
              // Simulated dashboard with nested rows/columns
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kTeal50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kTeal200, width: 2),
                ),
                child: Column(
                  children: [
                    // Header
                    _buildPanelBox(
                      'HEADER (id: header)',
                      _kTeal700,
                      width: double.infinity,
                      height: 50,
                    ),
                    const SizedBox(height: 8),
                    // Sidebar + Content
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildPanelBox(
                            'SIDEBAR\n(id: sidebar)',
                            _kViolet500,
                            height: 130,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 7,
                          child: _buildPanelBox(
                            'CONTENT\n(id: content)',
                            _kTeal500,
                            height: 130,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Footer
                    _buildPanelBox(
                      'FOOTER (id: footer)',
                      _kViolet700,
                      width: double.infinity,
                      height: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                children: [
                  _buildChip('id: header', _kTeal700),
                  _buildChip('id: sidebar', _kViolet500),
                  _buildChip('id: content', _kTeal500),
                  _buildChip('id: footer', _kViolet700),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'A delegate arranges these panels programmatically. '
                'The header fills the full width, the sidebar takes 30 %, '
                'content takes the rest, and the footer sits at the bottom.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // ═════════════════════════════════════════════════════════════════
        // 5 — OVERLAPPING CARD STACK
        // ═════════════════════════════════════════════════════════════════
        _buildSectionHeader('Overlapping Card Stack', Icons.layers),
        _buildCard(
          'Cards positioned by delegate with overlap',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'A delegate can position children to overlap — something '
                'Row and Column cannot do. Each card has a LayoutId, and '
                'positionChild offsets them to create a fanned stack.',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: _kViolet100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kViolet300, width: 1),
                ),
                child: Stack(
                  children: [
                    _buildOverlapCard(0, 'Card A', _kTeal600, 10),
                    _buildOverlapCard(1, 'Card B', _kViolet500, 60),
                    _buildOverlapCard(2, 'Card C', _kTeal700, 110),
                    _buildOverlapCard(3, 'Card D', _kViolet700, 160),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _buildCodeBlock(
                '// In delegate.performLayout:\n'
                'for (var i = 0; i < 4; i++) {\n'
                '  final id = \'card_\$i\';\n'
                '  if (hasChild(id)) {\n'
                '    layoutChild(id, BoxConstraints.loose(size));\n'
                '    positionChild(\n'
                '      id,\n'
                '      Offset(i * 50.0, i * 14.0),\n'
                '    );\n'
                '  }\n'
                '}',
              ),
            ],
          ),
          accentColor: _kViolet500,
        ),
        const SizedBox(height: 8),

        // ═════════════════════════════════════════════════════════════════
        // 6 — PROFILE LAYOUT
        // ═════════════════════════════════════════════════════════════════
        _buildSectionHeader('Profile Layout Example', Icons.person),
        _buildCard(
          'Avatar / Name / Bio — delegate-driven',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'A profile card where the delegate centres the avatar on top, '
                'then positions the name and bio below it based on the '
                'avatar\'s measured size.',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 14),
              // Simulated profile
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_kTeal100, _kViolet100],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kTeal200, width: 1),
                ),
                child: Column(
                  children: [
                    // Avatar circle
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [_kTeal500, _kViolet500],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _kTeal500.withAlpha(80),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'AB',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Alice Builder',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 6,
                      ),
                      child: const Text(
                        'Flutter engineer · Custom layout enthusiast',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _buildCodeBlock(
                '// Delegate centres avatar, then stacks name & bio below.\n'
                'void performLayout(Size size) {\n'
                '  final avatarSize = layoutChild(\n'
                '    \'avatar\',\n'
                '    BoxConstraints.loose(size),\n'
                '  );\n'
                '  positionChild(\n'
                '    \'avatar\',\n'
                '    Offset(\n'
                '      (size.width - avatarSize.width) / 2,\n'
                '       20,\n'
                '    ),\n'
                '  );\n'
                '\n'
                '  final nameSize = layoutChild(\n'
                '    \'name\',\n'
                '    BoxConstraints(maxWidth: size.width),\n'
                '  );\n'
                '  positionChild(\n'
                '    \'name\',\n'
                '    Offset(\n'
                '      (size.width - nameSize.width) / 2,\n'
                '      20 + avatarSize.height + 12,\n'
                '    ),\n'
                '  );\n'
                '\n'
                '  if (hasChild(\'bio\')) {\n'
                '    final bioSize = layoutChild(\n'
                '      \'bio\',\n'
                '      BoxConstraints(maxWidth: size.width - 40),\n'
                '    );\n'
                '    positionChild(\n'
                '      \'bio\',\n'
                '      Offset(\n'
                '        (size.width - bioSize.width) / 2,\n'
                '        20 + avatarSize.height + 12\n'
                '            + nameSize.height + 6,\n'
                '      ),\n'
                '    );\n'
                '  }\n'
                '}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // ═════════════════════════════════════════════════════════════════
        // 7 — PRACTICAL PATTERNS
        // ═════════════════════════════════════════════════════════════════
        _buildSectionHeader('Practical Patterns', Icons.build_circle),
        _buildCard(
          'Using enums for type-safe ids',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'String ids work but enums prevent typos and enable '
                'exhaustive checks in the delegate:',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 12),
              _buildCodeBlock(
                'enum PanelId { header, sidebar, content, footer }\n'
                '\n'
                'CustomMultiChildLayout(\n'
                '  delegate: DashboardDelegate(),\n'
                '  children: [\n'
                '    LayoutId(\n'
                '      id: PanelId.header,\n'
                '      child: AppBar(title: Text(\'Dashboard\')),\n'
                '    ),\n'
                '    LayoutId(\n'
                '      id: PanelId.sidebar,\n'
                '      child: NavMenu(),\n'
                '    ),\n'
                '    LayoutId(\n'
                '      id: PanelId.content,\n'
                '      child: DataGrid(),\n'
                '    ),\n'
                '    LayoutId(\n'
                '      id: PanelId.footer,\n'
                '      child: StatusBar(),\n'
                '    ),\n'
                '  ],\n'
                ')',
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        _buildCard(
          'Reactive relayout with Listenable',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pass a Listenable to the delegate constructor and call '
                'super(relayout: listenable). When the listenable notifies, '
                'the delegate\'s performLayout runs again:',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 12),
              _buildCodeBlock(
                'class AnimatedPanelDelegate\n'
                '    extends MultiChildLayoutDelegate {\n'
                '  final double splitRatio;\n'
                '\n'
                '  AnimatedPanelDelegate({\n'
                '    required this.splitRatio,\n'
                '    required Listenable relayout,\n'
                '  }) : super(relayout: relayout);\n'
                '\n'
                '  @override\n'
                '  void performLayout(Size size) {\n'
                '    final leftW = size.width * splitRatio;\n'
                '    layoutChild(\'left\',\n'
                '      BoxConstraints.tightFor(\n'
                '        width: leftW, height: size.height));\n'
                '    positionChild(\'left\', Offset.zero);\n'
                '\n'
                '    layoutChild(\'right\',\n'
                '      BoxConstraints.tightFor(\n'
                '        width: size.width - leftW,\n'
                '        height: size.height));\n'
                '    positionChild(\'right\',\n'
                '      Offset(leftW, 0));\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  bool shouldRelayout(\n'
                '      covariant AnimatedPanelDelegate old) =>\n'
                '    splitRatio != old.splitRatio;\n'
                '}',
              ),
            ],
          ),
          accentColor: _kViolet500,
        ),
        const SizedBox(height: 8),

        // ═════════════════════════════════════════════════════════════════
        // 8 — QUICK REFERENCE
        // ═════════════════════════════════════════════════════════════════
        _buildSectionHeader('Quick Reference', Icons.menu_book),
        _buildCard(
          'MultiChildLayoutParentData at a glance',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRefRow(
                'id',
                'Object',
                'Identifies the child in the delegate',
              ),
              _buildRefRow(
                'offset',
                'Offset',
                'Position set by positionChild()',
              ),
              _buildRefRow('LayoutId', 'Widget', 'Writes id into parentData'),
              _buildRefRow(
                'layoutChild',
                'Method',
                'Measures child, returns Size',
              ),
              _buildRefRow('positionChild', 'Method', 'Places child at Offset'),
              _buildRefRow('hasChild', 'Method', 'Checks if id exists'),
              _buildRefRow(
                'shouldRelayout',
                'Method',
                'Return true to re-run layout',
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _kTeal500.withAlpha(20),
                      _kViolet500.withAlpha(20),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kTeal200, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: _kTeal600, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Key Takeaways',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Every child MUST be wrapped in LayoutId\n'
                      '• Each id must be unique among siblings\n'
                      '• Call layoutChild exactly once per child\n'
                      '• positionChild defaults to Offset.zero if omitted\n'
                      '• Use hasChild to guard optional children\n'
                      '• Prefer enum ids over strings for type safety\n'
                      '• Pass a Listenable to super() for animated layouts',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.6,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ═════════════════════════════════════════════════════════════════
        // FOOTER BADGE
        // ═════════════════════════════════════════════════════════════════
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [_kTeal600, _kViolet500]),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: _kTeal600.withAlpha(60),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Text(
              'MultiChildLayoutParentData  ·  Deep Demo Complete',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}

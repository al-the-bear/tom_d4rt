// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SLIVER HIT TEST ENTRY — Deep Demo
// ============================================================================
//
// SliverHitTestEntry is a specialised HitTestEntry<RenderSliver> that adds
// two sliver-local coordinate fields:
//
//   • mainAxisPosition  – distance along the sliver's scroll axis from its
//                          zero scroll offset to the point where the hit
//                          occurred (in pixels).
//   • crossAxisPosition – distance along the sliver's cross axis from the
//                          zero cross-axis offset to the hit point (px).
//
// During hit testing, the RenderSliver.hitTest method first converts the
// global pointer position into sliver-local coordinates, then wraps the
// result in a SliverHitTestEntry and appends it to the HitTestResult.
//
// Slivers cannot use simple Rect-based hit testing because their visible
// region is determined by the scroll offset, paint origin, and geometry.
// SliverHitTestEntry provides the bridge between pointer events
// (in box coordinates or global coordinates) and sliver layout coordinates.
//
// This demo visualises the coordinate system, shows how entries propagate,
// illustrates use cases, and provides side-by-side comparisons.
//
// Color theme : Forest Green (#2E7D32) / Mint (#C8E6C9)
// Helper prefix: _he
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _heForest = Color(0xFF2E7D32);
const Color _heMint = Color(0xFFC8E6C9);
const Color _heDarkGreen = Color(0xFF1B5E20);
const Color _heLightMint = Color(0xFFE8F5E9);
const Color _heCharcoal = Color(0xFF263238);
const Color _heTeal = Color(0xFF00796B);
const Color _heAmber = Color(0xFFFFA000);
const Color _heCoral = Color(0xFFE53935);
const Color _heIndigo = Color(0xFF3949AB);
const Color _hePlum = Color(0xFF7B1FA2);
const Color _heSky = Color(0xFF0288D1);
const Color _heSlate = Color(0xFF546E7A);
const Color _heBrown = Color(0xFF5D4037);
const Color _heOrange = Color(0xFFEF6C00);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _heSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_heForest, _heDarkGreen],
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
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: const TextStyle(color: Color(0xCCFFFFFF), fontSize: 13),
            ),
          ),
      ],
    ),
  );
}

Widget _heCaption(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _heCharcoal,
        fontSize: 13,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

Widget _heParagraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Text(
      text,
      style: const TextStyle(color: _heCharcoal, fontSize: 14, height: 1.5),
    ),
  );
}

Widget _heLabelValue(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 190,
          child: Text(
            label,
            style: const TextStyle(
              color: _heSlate,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _heCharcoal,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _heCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1B2631),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Color(0xFFB9F6CA),
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _heBadge(String text, Color bg, {Color textColor = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _heDivider() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Divider(color: Color(0x33263238), height: 1),
  );
}

Widget _heInfoCard(String title, String body, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: accent, width: 4)),
      boxShadow: const [
        BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(color: _heCharcoal, fontSize: 13, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _hePropertyCard(
  String name,
  String type,
  String description,
  String example,
  Color accent,
  IconData icon,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [accent.withValues(alpha: 0.08), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 22),
            const SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(
                color: accent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
            const Spacer(),
            _heBadge(type, accent),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(color: _heCharcoal, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF1B2631),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            example,
            style: const TextStyle(
              color: Color(0xFFB9F6CA),
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// build
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== SliverHitTestEntry Deep Demo ===');

  // Create sample SliverHitTestEntry instances for demonstration
  // We simulate the data that RenderSliver.hitTest would produce
  final sampleEntries = <Map<String, double>>[
    {'mainAxis': 42.0, 'crossAxis': 150.0},
    {'mainAxis': 180.5, 'crossAxis': 75.3},
    {'mainAxis': 0.0, 'crossAxis': 0.0},
    {'mainAxis': 320.0, 'crossAxis': 199.9},
    {'mainAxis': 560.0, 'crossAxis': 100.0},
  ];

  for (final e in sampleEntries) {
    print(
      '  SliverHitTestEntry — mainAxisPosition: ${e['mainAxis']}, '
      'crossAxisPosition: ${e['crossAxis']}',
    );
  }

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================================================================
        // TITLE BANNER
        // ================================================================
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_heForest, _heDarkGreen, Color(0xFF004D40)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SliverHitTestEntry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'HitTestEntry<RenderSliver> with sliver-local coordinates',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _heBadge('rendering', _heTeal),
                  const SizedBox(width: 8),
                  _heBadge('hit-testing', _heAmber),
                  const SizedBox(width: 8),
                  _heBadge('sliver', _heIndigo),
                ],
              ),
            ],
          ),
        ),

        // ================================================================
        // 1 — What is SliverHitTestEntry?
        // ================================================================
        const SizedBox(height: 14),
        _heSectionHeader(
          '1 — What is SliverHitTestEntry?',
          subtitle: 'A hit-test entry carrying sliver-local coordinates',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'When a pointer event (tap, drag, hover) reaches a sliver, Flutter '
          'needs to record where in the sliver the hit occurred.  Unlike box '
          'widgets where hit testing uses a simple local-coordinate Offset, '
          'slivers use a pair of coordinates that make sense in the scrolling '
          'context: mainAxisPosition and crossAxisPosition.',
        ),
        _heParagraph(
          'SliverHitTestEntry wraps a RenderSliver target together with these '
          'two positions.  It extends HitTestEntry<RenderSliver>, so it plugs '
          'directly into the standard hit-test pipeline while carrying the '
          'extra sliver-specific data.',
        ),
        _heCodeBlock(
          'class SliverHitTestEntry extends HitTestEntry<RenderSliver> {\n'
          '  SliverHitTestEntry(\n'
          '    RenderSliver target, {\n'
          '    required this.mainAxisPosition,\n'
          '    required this.crossAxisPosition,\n'
          '  }) : super(target);\n'
          '\n'
          '  final double mainAxisPosition;\n'
          '  final double crossAxisPosition;\n'
          '\n'
          '  @override\n'
          '  String toString() =>\n'
          '      \'\${target.runtimeType}@(mainAxis: \$mainAxisPosition, '
          'crossAxis: \$crossAxisPosition)\';\n'
          '}',
        ),
        _heCaption(
          'The full source is minimal — just two final double fields on top '
          'of HitTestEntry.',
        ),

        _heDivider(),

        // ================================================================
        // 2 — mainAxisPosition property
        // ================================================================
        _heSectionHeader(
          '2 — mainAxisPosition',
          subtitle: 'How far along the scroll axis the hit occurred',
        ),
        const SizedBox(height: 10),
        _hePropertyCard(
          'mainAxisPosition',
          'double',
          'Distance in pixels from the sliver\'s zero scroll offset to the '
          'point where the hit occurred, measured along the main (scroll) axis. '
          'In a vertical list this is the Y distance from the top edge of the '
          'sliver to the pointer position. In a horizontal list it is the X '
          'distance from the leading edge.',
          'entry.mainAxisPosition  // e.g. 142.5',
          _heForest,
          Icons.swap_vert_rounded,
        ),
        const SizedBox(height: 4),

        // Visual: vertical bar showing hit at some offset
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          height: 240,
          decoration: BoxDecoration(
            color: _heLightMint,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _heForest.withValues(alpha: 0.3)),
          ),
          child: Stack(
            children: [
              // Axis label
              const Positioned(
                left: 12,
                top: 8,
                child: Text(
                  'Main axis ↓ (scroll direction)',
                  style: TextStyle(
                    color: _heSlate,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Sliver strip
              Positioned(
                left: 40,
                top: 36,
                bottom: 12,
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_heMint, _heForest],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'SLIVER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 0 label
              const Positioned(
                left: 130,
                top: 36,
                child: Text(
                  '0.0 px',
                  style: TextStyle(
                    color: _heCharcoal,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              // Hit marker
              Positioned(
                left: 40,
                top: 140,
                child: Container(
                  width: 80,
                  height: 3,
                  color: _heCoral,
                ),
              ),
              Positioned(
                left: 130,
                top: 133,
                child: Row(
                  children: [
                    const Icon(Icons.touch_app, color: _heCoral, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      'mainAxisPosition = 104.0',
                      style: TextStyle(
                        color: _heCoral,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow
              Positioned(
                left: 125,
                top: 48,
                child: Container(
                  width: 2,
                  height: 90,
                  color: _heCoral.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        _heCaption(
          'The red line marks the mainAxisPosition inside a vertical sliver.',
        ),

        _heDivider(),

        // ================================================================
        // 3 — crossAxisPosition property
        // ================================================================
        _heSectionHeader(
          '3 — crossAxisPosition',
          subtitle: 'Perpendicular placement within the sliver',
        ),
        const SizedBox(height: 10),
        _hePropertyCard(
          'crossAxisPosition',
          'double',
          'Distance in pixels from the sliver\'s zero cross-axis offset to '
          'the pointer position, measured perpendicular to the scroll axis. '
          'In a vertical list this is the X distance; in a horizontal list '
          'the Y distance. This is essential for slivers that lay out '
          'multiple children across the cross axis, such as SliverGrid.',
          'entry.crossAxisPosition  // e.g. 200.0',
          _heTeal,
          Icons.swap_horiz_rounded,
        ),
        const SizedBox(height: 4),

        // Visual: horizontal bar showing hit at some offset
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          height: 180,
          decoration: BoxDecoration(
            color: _heLightMint,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _heTeal.withValues(alpha: 0.3)),
          ),
          child: Stack(
            children: [
              // Axis label
              const Positioned(
                left: 12,
                top: 8,
                child: Text(
                  'Cross axis → (perpendicular)',
                  style: TextStyle(
                    color: _heSlate,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Sliver horizontal strip
              Positioned(
                left: 20,
                top: 40,
                right: 20,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_heMint, _heTeal],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'SLIVER (cross axis extent)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
              // 0 label
              const Positioned(
                left: 20,
                top: 118,
                child: Text(
                  '0.0',
                  style: TextStyle(
                    color: _heCharcoal,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              // Hit marker vertical line
              Positioned(
                left: 180,
                top: 40,
                child: Container(
                  width: 3,
                  height: 70,
                  color: _heIndigo,
                ),
              ),
              Positioned(
                left: 150,
                top: 120,
                child: Row(
                  children: [
                    const Icon(Icons.touch_app, color: _heIndigo, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      'crossAxisPosition = 160.0',
                      style: TextStyle(
                        color: _heIndigo,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              // Horizontal arrow
              Positioned(
                left: 22,
                top: 148,
                child: Container(
                  width: 158,
                  height: 2,
                  color: _heIndigo.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        _heCaption(
          'The indigo line marks crossAxisPosition in the same sliver.',
        ),

        _heDivider(),

        // ================================================================
        // 4 — Combined coordinate system visual
        // ================================================================
        _heSectionHeader(
          '4 — Combined Coordinate System',
          subtitle: 'Both axes on one sliver tile grid',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'Together, mainAxisPosition and crossAxisPosition define a point '
          'inside the sliver\'s layout rectangle — analogous to an Offset '
          'in box hit testing, but expressed in the sliver\'s own coordinate '
          'system that is independent of how much has been scrolled.',
        ),

        // 2D grid with crosshair
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _heForest.withValues(alpha: 0.25)),
          ),
          child: Stack(
            children: [
              // Grid background
              ...List.generate(4, (row) {
                return Positioned(
                  left: 50,
                  top: 40.0 + row * 55,
                  child: Row(
                    children: List.generate(5, (col) {
                      final isHit = row == 1 && col == 3;
                      return Container(
                        width: 52,
                        height: 50,
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: isHit
                              ? _heCoral.withValues(alpha: 0.25)
                              : _heLightMint,
                          border: Border.all(
                            color: isHit
                                ? _heCoral
                                : _heForest.withValues(alpha: 0.15),
                            width: isHit ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: isHit
                            ? const Center(
                                child: Icon(
                                  Icons.touch_app,
                                  color: _heCoral,
                                  size: 20,
                                ),
                              )
                            : null,
                      );
                    }),
                  ),
                );
              }),
              // Cross axis label
              const Positioned(
                left: 140,
                top: 16,
                child: Text(
                  'crossAxisPosition →',
                  style: TextStyle(
                    color: _heIndigo,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Main axis label
              const Positioned(
                left: 4,
                top: 120,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'mainAxisPosition →',
                    style: TextStyle(
                      color: _heForest,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Hit label
              Positioned(
                left: 52,
                top: 260,
                child: Text(
                  'Hit at mainAxis: 95.0, crossAxis: 162.0',
                  style: TextStyle(
                    color: _heCoral,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        _heCaption(
          'The red-bordered cell is where the pointer hit in sliver coordinates.',
        ),

        _heDivider(),

        // ================================================================
        // 5 — Inheritance diagram
        // ================================================================
        _heSectionHeader(
          '5 — Inheritance Hierarchy',
          subtitle: 'Where SliverHitTestEntry fits in the hit-test tree',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'SliverHitTestEntry inherits from HitTestEntry<RenderSliver>. '
          'This means it carries a reference to the RenderSliver target, '
          'plus a Matrix4 transform from global to local coordinates — and '
          'adds the two sliver-specific position fields on top.',
        ),

        // Inheritance boxes
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _heLightMint,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _heForest.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              _heHierarchyBox('HitTestEntry<T>', _heSlate,
                  'target: T, transform: Matrix4'),
              _heHierarchyArrow(),
              _heHierarchyBox('HitTestEntry<RenderSliver>', _heTeal,
                  'target: RenderSliver'),
              _heHierarchyArrow(),
              _heHierarchyBox('SliverHitTestEntry', _heForest,
                  '+ mainAxisPosition: double\n+ crossAxisPosition: double'),
            ],
          ),
        ),
        _heCaption(
          'SliverHitTestEntry is a concrete class — not abstract.',
        ),

        _heDivider(),

        // ================================================================
        // 6 — Box vs Sliver coordinates comparison
        // ================================================================
        _heSectionHeader(
          '6 — Box Coordinates vs Sliver Coordinates',
          subtitle: 'Why slivers need their own hit-test entry type',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'Standard RenderBox widgets use local Offset(dx, dy) coordinates '
          'for hit testing. This works because a box has a fixed size that '
          'doesn\'t depend on scroll state. Slivers, however, have a '
          'paintExtent and scrollExtent that change continuously as the '
          'user scrolls. Converting to mainAxis/crossAxis positions keeps '
          'hit testing consistent regardless of the current scroll offset.',
        ),

        // Side-by-side comparison cards
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _heIndigo.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _heIndigo.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.crop_square, color: _heIndigo, size: 18),
                          const SizedBox(width: 6),
                          const Text(
                            'BoxHitTestEntry',
                            style: TextStyle(
                              color: _heIndigo,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Uses Offset(dx, dy)\n'
                        '• Fixed coordinate space\n'
                        '• Size known at layout\n'
                        '• Simple rect containment',
                        style: TextStyle(
                          color: _heCharcoal,
                          fontSize: 11,
                          height: 1.6,
                        ),
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
                    color: _heForest.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _heForest.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.view_list, color: _heForest, size: 18),
                          const SizedBox(width: 6),
                          const Text(
                            'SliverHitTestEntry',
                            style: TextStyle(
                              color: _heForest,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Uses mainAxis/crossAxis\n'
                        '• Scroll-dependent space\n'
                        '• Extent changes on scroll\n'
                        '• Sliver geometry aware',
                        style: TextStyle(
                          color: _heCharcoal,
                          fontSize: 11,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        _heDivider(),

        // ================================================================
        // 7 — Hit zone grid with coordinates
        // ================================================================
        _heSectionHeader(
          '7 — Hit Zone Grid',
          subtitle: 'Mapping pointer position to sliver coordinates',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'A SliverGrid lays out children in a 2D tile pattern. When a '
          'pointer hits a sliver grid tile, the SliverHitTestEntry records '
          'the position within the sliver\'s own coordinate space. The '
          'rendering layer can then determine which child was hit by '
          'comparing mainAxisPosition and crossAxisPosition against each '
          'child\'s known offset and extent.',
        ),

        // Interactive-looking grid with coordinate labels
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _heForest.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              // Header row
              Row(
                children: [
                  const SizedBox(width: 60),
                  ...List.generate(4, (col) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'x: ${col * 90}',
                          style: const TextStyle(
                            color: _heIndigo,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 4),
              // Grid rows
              ...List.generate(3, (row) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          'y: ${row * 90}',
                          style: const TextStyle(
                            color: _heForest,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      ...List.generate(4, (col) {
                        final colors = [
                          _heForest,
                          _heTeal,
                          _heIndigo,
                          _hePlum,
                          _heSky,
                          _heAmber,
                          _heBrown,
                          _heCoral,
                          _heSlate,
                          _heOrange,
                          _heDarkGreen,
                          _heForest,
                        ];
                        final idx = row * 4 + col;
                        return Expanded(
                          child: Container(
                            height: 56,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: colors[idx].withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: colors[idx].withValues(alpha: 0.4),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'child $idx',
                                style: TextStyle(
                                  color: colors[idx],
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        _heCaption(
          'Each cell is a child widget; sliver coordinates map the pointer to the correct child.',
        ),

        _heDivider(),

        // ================================================================
        // 8 — CustomScrollView with tap detection path
        // ================================================================
        _heSectionHeader(
          '8 — Hit Test Flow in CustomScrollView',
          subtitle: 'From pointer event to SliverHitTestEntry',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'When the user taps inside a CustomScrollView:\n'
          '1. GestureBinding dispatches the PointerDownEvent.\n'
          '2. RenderView.hitTest walks the render tree.\n'
          '3. The Viewport\'s RenderSliver.hitTest is called.\n'
          '4. The sliver converts the global position to '
          'mainAxisPosition and crossAxisPosition.\n'
          '5. A SliverHitTestEntry is created and added to the HitTestResult.\n'
          '6. If the sliver has children (e.g. SliverList), it also tests '
          'each child as a regular box hit.',
        ),

        // Flow diagram
        _hePipelineStep('1', 'PointerDownEvent', 'Global position (dx, dy)',
            _heSky, Icons.touch_app),
        _hePipelineArrow(),
        _hePipelineStep('2', 'RenderView.hitTest', 'Walk render tree',
            _heSlate, Icons.account_tree),
        _hePipelineArrow(),
        _hePipelineStep('3', 'RenderSliver.hitTest',
            'Convert to sliver coordinates', _heForest, Icons.transform),
        _hePipelineArrow(),
        _hePipelineStep(
            '4',
            'SliverHitTestEntry created',
            'mainAxisPosition + crossAxisPosition',
            _heCoral,
            Icons.add_circle_outline),
        _hePipelineArrow(),
        _hePipelineStep('5', 'Added to HitTestResult',
            'Entry joins the result path', _hePlum, Icons.playlist_add_check),

        _heDivider(),

        // ================================================================
        // 9 — Multiple entries in one result
        // ================================================================
        _heSectionHeader(
          '9 — Multiple Entries in One Result',
          subtitle: 'Several slivers can add entries to the same result',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'A Viewport may contain many slivers. If the hit coordinates '
          'overlap multiple slivers (e.g. padding slivers, or overlapping '
          'paintExtents), each sliver adds its own SliverHitTestEntry to '
          'the result. The framework processes entries in reverse order '
          '(last added = first handled), so the topmost sliver wins.',
        ),

        // Stacked entry cards
        ...List.generate(3, (i) {
          final names = [
            'SliverAppBar',
            'SliverList (header)',
            'SliverGrid (content)',
          ];
          final mains = ['12.5', '0.0', '45.3'];
          final crosses = ['180.0', '200.0', '160.7'];
          final colors = [_heAmber, _heTeal, _heForest];
          return Container(
            margin: EdgeInsets.fromLTRB(20.0 + i * 8, 6, 20, 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors[i].withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colors[i].withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: colors[i],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
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
                        names[i],
                        style: TextStyle(
                          color: colors[i],
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'mainAxis: ${mains[i]}, crossAxis: ${crosses[i]}',
                        style: const TextStyle(
                          color: _heCharcoal,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),

        _heDivider(),

        // ================================================================
        // 10 — Vertical vs Horizontal scroll
        // ================================================================
        _heSectionHeader(
          '10 — Vertical vs Horizontal Scrolling',
          subtitle: 'How axis swap affects the entry coordinates',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'The naming "mainAxis" and "crossAxis" is relative to the scroll '
          'direction. In a vertical CustomScrollView, mainAxisPosition '
          'corresponds to the Y offset and crossAxisPosition to the X '
          'offset. Flip the scroll direction to horizontal and the mapping '
          'reverses: mainAxisPosition becomes X, crossAxisPosition becomes Y.',
        ),

        // Side-by-side vertical vs horizontal
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              // Vertical scroll
              Expanded(
                child: Container(
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _heForest.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _heForest.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.swap_vert, color: _heForest, size: 16),
                          const SizedBox(width: 4),
                          const Text(
                            'Vertical scroll',
                            style: TextStyle(
                              color: _heForest,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _heLabelValue('mainAxis', 'Y offset', valueColor: _heForest),
                      _heLabelValue('crossAxis', 'X offset', valueColor: _heIndigo),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          color: _heMint,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_downward, color: _heForest, size: 20),
                              Text(
                                'Scrolls ↓',
                                style: TextStyle(
                                  color: _heForest,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
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
              // Horizontal scroll
              Expanded(
                child: Container(
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _heSky.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _heSky.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.swap_horiz, color: _heSky, size: 16),
                          const SizedBox(width: 4),
                          const Text(
                            'Horizontal scroll',
                            style: TextStyle(
                              color: _heSky,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _heLabelValue('mainAxis', 'X offset', valueColor: _heSky),
                      _heLabelValue('crossAxis', 'Y offset', valueColor: _hePlum),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          color: _heSky.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_forward, color: _heSky, size: 20),
                              Text(
                                'Scrolls →',
                                style: TextStyle(
                                  color: _heSky,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
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

        _heDivider(),

        // ================================================================
        // 11 — Edge cases
        // ================================================================
        _heSectionHeader(
          '11 — Edge Cases & Boundary Conditions',
          subtitle: 'What happens at the extremes',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'SliverHitTestEntry stores raw double values without clamping. '
          'The calling code (RenderSliver subclasses) is responsible for '
          'validating that the hit falls within the sliver\'s visible '
          'region. Here are some noteworthy edge cases:',
        ),

        _heInfoCard(
          'Zero offset hit',
          'mainAxisPosition = 0.0, crossAxisPosition = 0.0 — the very '
          'top-left corner (vertical scroll) or leading edge of the sliver. '
          'This is a valid hit on the first pixel.',
          _heForest,
        ),
        _heInfoCard(
          'Hit at paintExtent boundary',
          'mainAxisPosition equals the sliver\'s paintExtent. This is '
          'technically just outside the visible region and should not '
          'normally produce a hit — but the entry itself allows it.',
          _heAmber,
        ),
        _heInfoCard(
          'Negative values',
          'A hit with mainAxisPosition < 0 means the pointer is before the '
          'sliver\'s scroll offset — possible during overscroll in '
          'BouncingScrollPhysics.',
          _heCoral,
        ),
        _heInfoCard(
          'Very large crossAxisPosition',
          'crossAxisPosition >= sliver cross-axis extent. This can happen '
          'if padding or margins push the sliver\'s size smaller than the '
          'viewport. The entry is still valid; the sliver\'s hitTest method '
          'handles the check.',
          _hePlum,
        ),
        _heInfoCard(
          'Fractional pixel values',
          'Both positions are doubles, so sub-pixel values like 142.37 are '
          'perfectly normal on high-DPI screens. No rounding is performed.',
          _heSky,
        ),

        _heDivider(),

        // ================================================================
        // 12 — Practical example: SliverList tap highlighting
        // ================================================================
        _heSectionHeader(
          '12 — Practical: SliverList Tap Highlight',
          subtitle: 'Using entry coordinates to highlight a tapped item',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'In a SliverList, each child is a box with a known paint offset '
          'along the main axis. When a hit is detected, the SliverHitTestEntry '
          'tells us exactly where along the sliver the user tapped. '
          'The list can compare mainAxisPosition against each child\'s '
          'paintOffset to determine which item was tapped.',
        ),

        // Simulated SliverList with highlighted item
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: _heLightMint,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _heForest.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: List.generate(6, (i) {
              final isHit = i == 3;
              final itemOffset = i * 56.0;
              return Container(
                width: double.infinity,
                height: 52,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isHit ? _heCoral.withValues(alpha: 0.15) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: isHit
                      ? Border.all(color: _heCoral, width: 2)
                      : Border.all(color: _heForest.withValues(alpha: 0.1)),
                ),
                child: Row(
                  children: [
                    Text(
                      'Item $i',
                      style: TextStyle(
                        color: isHit ? _heCoral : _heCharcoal,
                        fontSize: 14,
                        fontWeight: isHit ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'offset: ${itemOffset.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: isHit ? _heCoral : _heSlate,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                    if (isHit) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.touch_app, color: _heCoral, size: 16),
                    ],
                  ],
                ),
              );
            }),
          ),
        ),
        _heCaption(
          'mainAxisPosition ≈ 182 → falls in Item 3 (offset 168–224). '
          'The SliverHitTestEntry provides this value.',
        ),

        _heDivider(),

        // ================================================================
        // 13 — toString representation
        // ================================================================
        _heSectionHeader(
          '13 — toString & Debugging',
          subtitle: 'How SliverHitTestEntry describes itself',
        ),
        const SizedBox(height: 10),
        _heParagraph(
          'SliverHitTestEntry overrides toString() to include both '
          'coordinate values, making it straightforward to inspect hit-test '
          'results during debugging.',
        ),
        _heCodeBlock(
          '// Output examples:\n'
          'RenderSliverList@(mainAxis: 42.0, crossAxis: 150.0)\n'
          'RenderSliverGrid@(mainAxis: 180.5, crossAxis: 75.3)\n'
          'RenderSliverFixedExtentList@(mainAxis: 0.0, crossAxis: 0.0)',
        ),
        _heParagraph(
          'The target\'s runtimeType is printed, followed by the two '
          'position values. This is invaluable when examining the path '
          'property of a HitTestResult.',
        ),

        // Print verification
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _heForest.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _heForest.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sample entries created for this demo:',
                style: TextStyle(
                  color: _heForest,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...sampleEntries.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'mainAxis: ${e['mainAxis']!.toStringAsFixed(1)}, '
                    'crossAxis: ${e['crossAxis']!.toStringAsFixed(1)}',
                    style: const TextStyle(
                      color: _heCharcoal,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        _heDivider(),

        // ================================================================
        // 14 — Summary
        // ================================================================
        _heSectionHeader(
          '14 — Summary',
          subtitle: 'Key takeaways about SliverHitTestEntry',
        ),
        const SizedBox(height: 10),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_heForest.withValues(alpha: 0.08), _heLightMint],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _heForest.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _heSummaryBullet(
                Icons.check_circle,
                _heForest,
                'Extends HitTestEntry<RenderSliver> with two coordinate fields',
              ),
              _heSummaryBullet(
                Icons.swap_vert,
                _heTeal,
                'mainAxisPosition — distance along scroll axis to hit point',
              ),
              _heSummaryBullet(
                Icons.swap_horiz,
                _heIndigo,
                'crossAxisPosition — distance perpendicular to scroll axis',
              ),
              _heSummaryBullet(
                Icons.transform,
                _heAmber,
                'Coordinates are sliver-local — independent of scroll offset',
              ),
              _heSummaryBullet(
                Icons.layers,
                _hePlum,
                'Multiple entries can stack in a single HitTestResult path',
              ),
              _heSummaryBullet(
                Icons.swap_horizontal_circle,
                _heSky,
                'Axis mapping flips between vertical and horizontal scrolling',
              ),
              _heSummaryBullet(
                Icons.bug_report,
                _heBrown,
                'toString() output is designed for easy debugging',
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Additional helpers
// ---------------------------------------------------------------------------

Widget _heHierarchyBox(String name, Color color, String fields) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          fields,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color.withValues(alpha: 0.8),
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _heHierarchyArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Center(
      child: Icon(Icons.arrow_downward, color: _heSlate, size: 20),
    ),
  );
}

Widget _hePipelineStep(
    String step, String title, String detail, Color color, IconData icon) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              step,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                detail,
                style: const TextStyle(
                  color: _heCharcoal,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _hePipelineArrow() {
  return const Center(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Icon(Icons.keyboard_arrow_down, color: _heSlate, size: 20),
    ),
  );
}

Widget _heSummaryBullet(IconData icon, Color color, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _heCharcoal,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

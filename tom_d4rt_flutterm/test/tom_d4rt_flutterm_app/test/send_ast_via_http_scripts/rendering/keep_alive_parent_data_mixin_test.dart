// D4rt test script: Comprehensive demo for KeepAliveParentDataMixin
//
// KeepAliveParentDataMixin is used by lazy list widgets (ListView, GridView)
// to mark child elements that should remain alive even when scrolled off-screen.
// By default, lazy lists destroy off-screen children to save memory. This mixin
// allows specific children to opt out of that destruction.
//
// Key concepts:
//   - AutomaticKeepAliveClientMixin: the StatefulWidget mixin that requests keep-alive
//   - wantKeepAlive: the boolean getter that controls the behavior
//   - KeepAliveParentDataMixin: the parent data mixin that stores the keep-alive flag
//   - SliverWithKeepAliveWidget: the sliver that honors keep-alive requests
//
// This demo shows:
//   1. What KeepAliveParentDataMixin does and why it matters
//   2. How AutomaticKeepAliveClientMixin works in practice
//   3. The lazy list lifecycle with and without keep-alive
//   4. The wantKeepAlive flag and its effects
//   5. Visual comparison of keep-alive vs. default behavior
//   6. Practical use cases (forms, video, scroll position)
//   7. Performance implications and best practices
//   8. Relationship with SliverMultiBoxAdaptorParentData
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS — Green/Red theme
// ═══════════════════════════════════════════════════════════════════════════

const _kGreen50 = Color(0xFFF0FDF4);
const _kGreen100 = Color(0xFFDCFCE7);
const _kGreen200 = Color(0xFFBBF7D0);
const _kGreen300 = Color(0xFF86EFAC);
const _kGreen500 = Color(0xFF22C55E);
const _kGreen600 = Color(0xFF16A34A);
const _kGreen700 = Color(0xFF15803D);
const _kGreen800 = Color(0xFF166534);
const _kGreen900 = Color(0xFF14532D);

const _kRed50 = Color(0xFFFEF2F2);
const _kRed100 = Color(0xFFFEE2E2);
const _kRed500 = Color(0xFFEF4444);
const _kRed600 = Color(0xFFDC2626);

const _kNeutral100 = Color(0xFFF5F5F5);
const _kNeutral200 = Color(0xFFE5E5E5);
const _kNeutral600 = Color(0xFF525252);
const _kNeutral800 = Color(0xFF262626);
const _kWhite = Color(0xFFFFFFFF);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a section title with green accent icon
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kGreen700, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _kGreen900,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds an info card with icon and text
Widget _buildInfoCard(
  String title,
  String description,
  IconData icon, {
  Color accentColor = _kGreen500,
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
        color: _kGreen300,
        height: 1.5,
      ),
    ),
  );
}

/// Builds a list item tile showing lifecycle state
Widget _buildLifecycleItem(
  String label,
  String state,
  bool isAlive, {
  bool keepAlive = false,
}) {
  final color = isAlive ? _kGreen500 : _kRed500;
  final bgColor = isAlive ? _kGreen50 : _kRed50;
  final stateIcon = isAlive ? Icons.check_circle : Icons.cancel;
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Icon(stateIcon, color: color, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: _kNeutral800,
                ),
              ),
              Text(state, style: TextStyle(fontSize: 12, color: _kNeutral600)),
            ],
          ),
        ),
        if (keepAlive)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _kGreen500.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'KEEP ALIVE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: _kGreen700,
              ),
            ),
          ),
      ],
    ),
  );
}

/// Builds a comparison column for with/without keep-alive
Widget _buildComparisonColumn(
  String header,
  Color headerColor,
  List<String> items,
  IconData icon,
) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: headerColor.withAlpha(15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: headerColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: headerColor, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  header,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: headerColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(color: headerColor, fontSize: 13),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 12, color: _kNeutral600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Builds a use-case card with icon badge
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

/// Builds the lazy list viewport diagram
Widget _buildViewportDiagram() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kNeutral100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kNeutral200),
    ),
    child: Column(
      children: [
        const Text(
          'ListView Viewport',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: _kNeutral800,
          ),
        ),
        const SizedBox(height: 12),
        // Off-screen above
        _buildDiagramSlot('Item 0', _kRed100, _kRed500, 'disposed'),
        _buildDiagramSlot('Item 1', _kRed100, _kRed500, 'disposed'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 4),
          color: _kGreen500.withAlpha(30),
          child: const Center(
            child: Text(
              '─── viewport top ───',
              style: TextStyle(fontSize: 11, color: _kGreen700),
            ),
          ),
        ),
        _buildDiagramSlot('Item 2', _kGreen100, _kGreen600, 'visible'),
        _buildDiagramSlot('Item 3', _kGreen100, _kGreen600, 'visible'),
        _buildDiagramSlot('Item 4 ★', _kGreen200, _kGreen700, 'kept alive'),
        _buildDiagramSlot('Item 5', _kGreen100, _kGreen600, 'visible'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 4),
          color: _kGreen500.withAlpha(30),
          child: const Center(
            child: Text(
              '─── viewport bottom ───',
              style: TextStyle(fontSize: 11, color: _kGreen700),
            ),
          ),
        ),
        _buildDiagramSlot('Item 6', _kRed100, _kRed500, 'disposed'),
        _buildDiagramSlot('Item 7 ★', _kGreen200, _kGreen700, 'kept alive!'),
      ],
    ),
  );
}

/// Builds a single slot in the viewport diagram
Widget _buildDiagramSlot(
  String label,
  Color bgColor,
  Color textColor,
  String status,
) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 2),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        Text(status, style: TextStyle(fontSize: 11, color: textColor)),
      ],
    ),
  );
}

/// Builds a performance tip card
Widget _buildPerformanceTip(String tip, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kGreen50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kGreen200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _kGreen600, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            tip,
            style: const TextStyle(fontSize: 12, color: _kNeutral800),
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
  print('=== KeepAliveParentDataMixin Deep Demo ===');
  print('KeepAliveParentDataMixin: mixin on ParentData');
  print('Purpose: marks children to be kept alive in lazy lists');
  print('Key property: keepAlive (bool)');
  print('Used by: SliverMultiBoxAdaptorParentData');
  print('Client mixin: AutomaticKeepAliveClientMixin<T>');
  print('Key getter: wantKeepAlive → bool');
  print('Typical hosts: ListView, GridView, SliverList, SliverGrid');
  print('Default behavior: off-screen children ARE disposed');
  print('Keep-alive behavior: off-screen children stay in memory');
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
              colors: [_kGreen600, _kGreen800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _kGreen700.withAlpha(60),
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
                  Icon(Icons.favorite, color: _kGreen200, size: 28),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'KeepAliveParentDataMixin',
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
                'A mixin on ParentData that flags child widgets to survive '
                'off-screen disposal in lazy scrollable lists.',
                style: TextStyle(fontSize: 14, color: _kGreen100, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ── Section 1: What is KeepAliveParentDataMixin? ─────────────
        _buildSectionTitle(
          '1. What Is KeepAliveParentDataMixin?',
          Icons.info_outline,
        ),
        _buildInfoCard(
          'Core Concept',
          'A mixin applied to ParentData classes in Sliver-based layouts. '
              'It adds a single boolean field "keepAlive" that tells the '
              'sliver not to dispose the child when it scrolls out of view.',
          Icons.data_object,
        ),
        _buildInfoCard(
          'The Problem It Solves',
          'ListView and GridView only build children inside the viewport '
              '(plus cacheExtent). When a child scrolls off-screen it is '
              'destroyed and its State is lost. KeepAlive prevents that.',
          Icons.warning_amber,
          accentColor: _kRed500,
        ),
        _buildCodeBlock(
          '// The mixin definition (simplified)\n'
          'mixin KeepAliveParentDataMixin on ParentData {\n'
          '  bool keepAlive = false;\n'
          '}\n'
          '\n'
          '// SliverMultiBoxAdaptorParentData uses it:\n'
          'class SliverMultiBoxAdaptorParentData\n'
          '    extends SliverLogicalParentData\n'
          '    with KeepAliveParentDataMixin {\n'
          '  int? index;\n'
          '}',
        ),
        const SizedBox(height: 20),

        // ── Section 2: AutomaticKeepAliveClientMixin ─────────────────
        _buildSectionTitle('2. AutomaticKeepAliveClientMixin', Icons.sync_alt),
        _buildInfoCard(
          'The Client Side',
          'Widgets that want to stay alive mix in '
              'AutomaticKeepAliveClientMixin on their State class and '
              'override "wantKeepAlive" to return true.',
          Icons.widgets,
        ),
        _buildCodeBlock(
          'class _MyItemState extends State<MyItem>\n'
          '    with AutomaticKeepAliveClientMixin {\n'
          '\n'
          '  @override\n'
          '  bool get wantKeepAlive => true;\n'
          '\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    super.build(context); // MUST call super.build\n'
          '    return Text("I survive scrolling!");\n'
          '  }\n'
          '}',
        ),
        _buildInfoCard(
          'super.build(context)',
          'You MUST call super.build(context) inside build(). '
              'The mixin uses it to register a KeepAlive notification '
              'with the enclosing SliverMultiBoxAdaptor.',
          Icons.priority_high,
          accentColor: _kRed500,
        ),
        const SizedBox(height: 20),

        // ── Section 3: Lazy List Lifecycle Diagram ───────────────────
        _buildSectionTitle('3. Lazy List Lifecycle', Icons.view_list),
        _buildViewportDiagram(),
        const SizedBox(height: 12),
        _buildInfoCard(
          'Viewport Behavior',
          'Items inside the viewport (green) are built. Items outside '
              '(red) are disposed. Items marked with ★ keep-alive remain '
              'in memory even when scrolled out of view.',
          Icons.visibility,
        ),
        const SizedBox(height: 20),

        // ── Section 4: The wantKeepAlive Flag ────────────────────────
        _buildSectionTitle('4. The wantKeepAlive Flag', Icons.flag),
        _buildLifecycleItem(
          'wantKeepAlive = true',
          'State preserved, initState not called again on re-scroll',
          true,
          keepAlive: true,
        ),
        _buildLifecycleItem(
          'wantKeepAlive = false (default)',
          'State disposed when off-screen, initState called on re-entry',
          false,
        ),
        _buildLifecycleItem(
          'Dynamic toggle',
          'Call updateKeepAlive() after changing wantKeepAlive at runtime',
          true,
          keepAlive: true,
        ),
        _buildCodeBlock(
          '// Dynamic keep-alive example\n'
          'bool _shouldKeepAlive = false;\n'
          '\n'
          '@override\n'
          'bool get wantKeepAlive => _shouldKeepAlive;\n'
          '\n'
          'void _toggleKeepAlive() {\n'
          '  setState(() {\n'
          '    _shouldKeepAlive = !_shouldKeepAlive;\n'
          '    updateKeepAlive(); // notify the sliver\n'
          '  });\n'
          '}',
        ),
        const SizedBox(height: 20),

        // ── Section 5: With vs Without Keep Alive ────────────────────
        _buildSectionTitle(
          '5. With vs Without Keep-Alive',
          Icons.compare_arrows,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildComparisonColumn('Without Keep-Alive', _kRed500, [
              'State lost on scroll-away',
              'Lower memory usage',
              'initState() runs every time',
              'TextField content cleared',
              'Scroll position reset',
              'Animations restart',
            ], Icons.delete_sweep),
            const SizedBox(width: 12),
            _buildComparisonColumn('With Keep-Alive', _kGreen500, [
              'State preserved off-screen',
              'Higher memory usage',
              'initState() runs once only',
              'TextField content retained',
              'Scroll position preserved',
              'Animations continue',
            ], Icons.favorite),
          ],
        ),
        const SizedBox(height: 20),

        // ── Section 6: Practical Use Cases ───────────────────────────
        _buildSectionTitle('6. Practical Use Cases', Icons.build_circle),
        _buildUseCaseCard(
          'Form Fields in a Long List',
          'TextFields in a scrollable form retain user input when scrolled '
              'off-screen and back. Without keep-alive, all typed text is lost.',
          Icons.edit_note,
          _kGreen600,
        ),
        _buildUseCaseCard(
          'Video Players',
          'A video player in a feed continues playback state even when '
              'temporarily scrolled away, avoiding restart flicker.',
          Icons.play_circle_fill,
          _kRed500,
        ),
        _buildUseCaseCard(
          'Scroll Position in Nested Lists',
          'A horizontal carousel inside a vertical list remembers its '
              'scroll offset when the parent list scrolls it away.',
          Icons.swap_vert,
          _kGreen700,
        ),
        _buildUseCaseCard(
          'Tab Views with PageView',
          'PageView pages keep their state when switching tabs, so the '
              'user returns to the same scroll position and loaded data.',
          Icons.tab,
          _kRed600,
        ),
        _buildUseCaseCard(
          'Animation Controllers',
          'Widgets running animations preserve their animation controller '
              'state, avoiding visual jumps on re-entry.',
          Icons.animation,
          _kGreen500,
        ),
        const SizedBox(height: 20),

        // ── Section 7: Performance Implications ──────────────────────
        _buildSectionTitle('7. Performance Best Practices', Icons.speed),
        _buildPerformanceTip(
          'Only enable keep-alive for items that truly need state '
          'preservation. Every kept-alive item consumes memory.',
          Icons.memory,
        ),
        _buildPerformanceTip(
          'Use dynamic wantKeepAlive: return false when the critical '
          'state has been saved elsewhere (e.g., to a database).',
          Icons.toggle_on,
        ),
        _buildPerformanceTip(
          'Monitor memory: large numbers of kept-alive children can '
          'cause jank and excessive memory consumption.',
          Icons.monitor_heart,
        ),
        _buildPerformanceTip(
          'Prefer key-based restoration or state management over '
          'keep-alive for data that can be easily re-fetched.',
          Icons.cloud_sync,
        ),
        const SizedBox(height: 20),

        // ── Section 8: Internal Plumbing ─────────────────────────────
        _buildSectionTitle('8. How It Works Internally', Icons.engineering),
        _buildInfoCard(
          'KeepAliveNotification',
          'When super.build() is called, AutomaticKeepAliveClientMixin '
              'dispatches a KeepAliveNotification up the tree. The '
              'SliverMultiBoxAdaptor catches it and sets '
              'parentData.keepAlive = true.',
          Icons.notifications_active,
        ),
        _buildInfoCard(
          'Garbage Collection Protection',
          'Kept-alive children are moved to a special _keepAliveBucket '
              'inside the RenderSliverMultiBoxAdaptor. They remain '
              'attached to the render tree but are not painted.',
          Icons.inventory_2,
        ),
        _buildCodeBlock(
          '// Internal flow (simplified):\n'
          '//\n'
          '// 1. State.build() → super.build(context)\n'
          '// 2. KeepAliveNotification dispatched\n'
          '// 3. SliverMultiBoxAdaptor receives notification\n'
          '// 4. parentData.keepAlive = true;\n'
          '// 5. On scroll-out: child moved to _keepAliveBucket\n'
          '//    (NOT disposed)\n'
          '// 6. On scroll-back: child moved from bucket to\n'
          '//    active children list (no rebuild needed)',
        ),
        const SizedBox(height: 24),

        // ── Footer ───────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kGreen50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kGreen200),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: _kGreen600, size: 32),
              const SizedBox(height: 8),
              const Text(
                'KeepAliveParentDataMixin Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: _kGreen800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'The mixin bridges the gap between lazy list efficiency '
                'and stateful child preservation.',
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

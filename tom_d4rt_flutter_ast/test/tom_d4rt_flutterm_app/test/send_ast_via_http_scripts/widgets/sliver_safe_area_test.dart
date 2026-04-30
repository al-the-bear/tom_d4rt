// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverSafeArea
// Demonstrates SliverSafeArea — the sliver equivalent of SafeArea. It adds
// safe-area padding to a sliver child so content is not obscured by device
// features like notches, status bars, navigation bars, or camera cutouts.
// Unlike the regular SafeArea widget (which wraps box widgets), SliverSafeArea
// wraps slivers and works inside CustomScrollView.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverSafeArea Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.phone_iphone,
      'title': 'What Is SliverSafeArea?',
      'body': 'SliverSafeArea is the sliver version of SafeArea. It inserts '
          'safe-area padding around its sliver child so content is not '
          'hidden behind device hardware features like the notch, status '
          'bar, home indicator, or rounded screen corners.',
      'accent': Colors.blueGrey,
    },
    {
      'icon': Icons.view_in_ar,
      'title': 'Why a Sliver Version?',
      'body': 'Regular SafeArea wraps box widgets. But inside a '
          'CustomScrollView, you work with slivers. SliverSafeArea lets '
          'you apply safe-area insets directly to a sliver without wrapping '
          'the entire CustomScrollView in a SafeArea (which would add '
          'padding outside the scroll area).',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.padding,
      'title': 'How It Works',
      'body': 'SliverSafeArea reads the MediaQuery safe-area insets and '
          'converts them into SliverPadding around its child sliver. '
          'Each edge (top, bottom, left, right) can be individually '
          'toggled. This is functionally equivalent to wrapping a sliver '
          'in SliverPadding with the safe-area insets.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.devices,
      'title': 'When To Use',
      'body': 'Use SliverSafeArea when you have a CustomScrollView and '
          'want the last sliver to clear the bottom safe area (home '
          'indicator), or the first sliver to clear the top safe area '
          '(status bar / notch), without affecting the entire scroll view.',
      'accent': Colors.deepOrange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var idx = 0; idx < conceptItems.length; idx++) {
    final e = conceptItems[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.04)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(e['icon'] as IconData, color: accent, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorRows = <Map<String, String>>[
    {
      'param': 'sliver',
      'type': 'Widget',
      'desc': 'Required. The sliver child to which safe-area padding will '
          'be applied. Must be a sliver widget (e.g. SliverList, SliverGrid, '
          'SliverToBoxAdapter).',
    },
    {
      'param': 'left',
      'type': 'bool',
      'desc': 'Whether to apply left safe-area padding. Defaults to true. '
          'On phones held in landscape, this is the side with the notch.',
    },
    {
      'param': 'top',
      'type': 'bool',
      'desc': 'Whether to apply top safe-area padding. Defaults to true. '
          'Avoids the status bar and display notch in portrait mode.',
    },
    {
      'param': 'right',
      'type': 'bool',
      'desc': 'Whether to apply right safe-area padding. Defaults to true.',
    },
    {
      'param': 'bottom',
      'type': 'bool',
      'desc': 'Whether to apply bottom safe-area padding. Defaults to true. '
          'Avoids the home indicator on modern iPhones and similar devices.',
    },
    {
      'param': 'minimum',
      'type': 'EdgeInsets',
      'desc': 'The minimum padding to apply even if the device has smaller '
          'or no safe-area insets. If a safe-area inset is smaller than '
          'the minimum, the minimum wins. Defaults to EdgeInsets.zero.',
    },
  ];

  final constructorWidgets = <Widget>[];
  for (var i = 0; i < constructorRows.length; i++) {
    final row = constructorRows[i];
    print('Constructor ${i + 1}: ${row['param']}');
    constructorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.blueGrey.withOpacity(0.06)
              : Colors.grey.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    row['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              row['desc']!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Basic SliverSafeArea
  // ============================================================
  print('=== Section 3: Basic ===');

  final basicDemo = SizedBox(
    height: 440,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('Contacts'),
          backgroundColor: Colors.blueGrey.shade700,
          pinned: true,
        ),
        SliverSafeArea(
          top: false, // AppBar already handles top
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext ctx, int index) {
                final names = [
                  'Alice Johnson',
                  'Bob Martinez',
                  'Carol Chen',
                  'David Kim',
                  'Emma Wilson',
                  'Frank Lopez',
                  'Grace Taylor',
                  'Henry Davis',
                  'Iris Brown',
                  'Jack Thomas',
                ];
                final depts = [
                  'Engineering',
                  'Design',
                  'Marketing',
                  'Sales',
                  'HR',
                ];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey.shade200,
                    child: Text(
                      names[index % names.length][0],
                      style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(names[index % names.length]),
                  subtitle: Text(depts[index % depts.length]),
                  trailing: const Icon(Icons.phone, size: 18),
                );
              },
              childCount: 20,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Selective edges
  // ============================================================
  print('=== Section 4: Selective edges ===');

  final edgeConfigs = <Map<String, dynamic>>[
    {
      'name': 'All edges (default)',
      'top': true,
      'bottom': true,
      'left': true,
      'right': true,
      'desc': 'Padding on all sides. The safest option but may add '
          'unnecessary padding on edges already handled.',
      'color': Colors.blueGrey,
    },
    {
      'name': 'Bottom only',
      'top': false,
      'bottom': true,
      'left': false,
      'right': false,
      'desc': 'Only the last sliver needs bottom padding to clear the '
          'home indicator. Top/sides handled by other widgets.',
      'color': Colors.green,
    },
    {
      'name': 'Top only',
      'top': true,
      'bottom': false,
      'left': false,
      'right': false,
      'desc': 'First sliver in a headerless CustomScrollView. Clears '
          'the status bar / notch area.',
      'color': Colors.orange,
    },
    {
      'name': 'Horizontal only',
      'top': false,
      'bottom': false,
      'left': true,
      'right': true,
      'desc': 'Landscape mode: the notch can be on the left or right. '
          'Horizontal padding avoids it without adding vertical space.',
      'color': Colors.purple,
    },
  ];

  final edgeCards = <Widget>[];
  for (var i = 0; i < edgeConfigs.length; i++) {
    final cfg = edgeConfigs[i];
    final eColor = cfg['color'] as Color;
    print('Edge config ${i + 1}: ${cfg['name']}');

    // Visual representation of which edges are active
    final topActive = cfg['top'] as bool;
    final bottomActive = cfg['bottom'] as bool;
    final leftActive = cfg['left'] as bool;
    final rightActive = cfg['right'] as bool;

    edgeCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: eColor.withOpacity(0.04),
          border: Border.all(color: eColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mini phone diagram showing active edges
              Container(
                width: 56,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                    top: BorderSide(
                      color: topActive ? eColor : Colors.grey.shade300,
                      width: topActive ? 3 : 1,
                    ),
                    bottom: BorderSide(
                      color: bottomActive ? eColor : Colors.grey.shade300,
                      width: bottomActive ? 3 : 1,
                    ),
                    left: BorderSide(
                      color: leftActive ? eColor : Colors.grey.shade300,
                      width: leftActive ? 3 : 1,
                    ),
                    right: BorderSide(
                      color: rightActive ? eColor : Colors.grey.shade300,
                      width: rightActive ? 3 : 1,
                    ),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.phone_android,
                    color: eColor.withOpacity(0.4),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cfg['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: eColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cfg['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        _ssaEdgeBadge('T', topActive, eColor),
                        _ssaEdgeBadge('B', bottomActive, eColor),
                        _ssaEdgeBadge('L', leftActive, eColor),
                        _ssaEdgeBadge('R', rightActive, eColor),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Minimum insets
  // ============================================================
  print('=== Section 5: Minimum insets ===');

  final minimumNote = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.amber.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.amber.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: Colors.amber.shade700, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'The minimum parameter ensures a minimum padding even on '
            'devices with no safe-area insets. For each edge, the actual '
            'padding is max(safeAreaInset, minimumPadding). This is useful '
            'for ensuring a consistent visual appearance across all devices.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  final minimumExamples = <Map<String, dynamic>>[
    {
      'title': 'No Minimum (default)',
      'minimum': 'EdgeInsets.zero',
      'desc': 'Only device safe-area insets are applied. On devices without '
          'a notch or home indicator, no padding is added at all.',
      'color': Colors.grey,
    },
    {
      'title': 'Minimum 16px all sides',
      'minimum': 'EdgeInsets.all(16)',
      'desc': 'Ensures at least 16px padding on every edge, even on devices '
          'without safe-area insets. If the safe-area inset is larger, '
          'the safe-area value wins.',
      'color': Colors.blue,
    },
    {
      'title': 'Minimum bottom only',
      'minimum': 'EdgeInsets.only(bottom: 24)',
      'desc': 'Guarantees 24px bottom padding for the last item to breathe, '
          'even on devices without a home indicator.',
      'color': Colors.green,
    },
  ];

  final minimumWidgets = <Widget>[];
  for (var i = 0; i < minimumExamples.length; i++) {
    final ex = minimumExamples[i];
    final mColor = ex['color'] as Color;
    print('Minimum ${i + 1}: ${ex['title']}');
    minimumWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: mColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: mColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  ex['title'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: mColor,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: mColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ex['minimum'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: mColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ex['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Without vs With comparison
  // ============================================================
  print('=== Section 6: Without vs With ===');

  // Simulated device frames showing the difference

  Widget buildDeviceFrame(String title, bool withSafeArea, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade400, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Column(
              children: [
                // Simulated notch/status bar area
                Container(
                  height: 28,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      '12:00',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                // Content area
                Expanded(
                  child: Stack(
                    children: [
                      // The list content
                      ListView.builder(
                        padding: withSafeArea
                            ? const EdgeInsets.only(bottom: 24)
                            : EdgeInsets.zero,
                        itemCount: 8,
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: accent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    Icons.note,
                                    color: accent,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Note ${index + 1}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // Simulated home indicator at bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 24,
                          color: Colors.black.withOpacity(0.05),
                          alignment: Alignment.center,
                          child: Container(
                            width: 80,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade600,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Text(
            withSafeArea
                ? 'Content clears the home indicator area'
                : 'Content hidden behind home indicator',
            style: TextStyle(
              fontSize: 11,
              color: accent.withOpacity(0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION 7: Use cases
  // ============================================================
  print('=== Section 7: Use cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Last Sliver Bottom Padding',
      'body': 'The most common use: wrap the last sliver in your '
          'CustomScrollView with SliverSafeArea(top: false) so the last '
          'items are not hidden behind the home indicator.',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.blueGrey,
    },
    {
      'title': 'Headerless Scroll View',
      'body': 'When your CustomScrollView has no SliverAppBar, the first '
          'sliver content would start behind the status bar. Wrap it in '
          'SliverSafeArea(bottom: false) to push it below the status bar.',
      'icon': Icons.vertical_align_top,
      'color': Colors.indigo,
    },
    {
      'title': 'Landscape Mode',
      'body': 'In landscape, the notch can be on the left or right side. '
          'SliverSafeArea with left/right: true adds the correct horizontal '
          'padding so content does not overlap the notch.',
      'icon': Icons.screen_rotation,
      'color': Colors.orange,
    },
    {
      'title': 'Foldable Devices',
      'body': 'Foldable phones may have unusual safe-area shapes when '
          'partially folded. SliverSafeArea reads the MediaQuery insets '
          'which the platform updates for foldable form factors.',
      'icon': Icons.devices_fold,
      'color': Colors.teal,
    },
    {
      'title': 'Camera Cutouts',
      'body': 'Some Android devices have punch-hole cameras in the display. '
          'The safe-area insets account for these cutouts, and '
          'SliverSafeArea applies the padding correctly.',
      'icon': Icons.camera_alt,
      'color': Colors.purple,
    },
    {
      'title': 'Rounded Corners',
      'body': 'Modern phones have rounded screen corners. The safe-area '
          'insets on some devices include the rounded corner area to '
          'prevent content from being clipped.',
      'icon': Icons.rounded_corner,
      'color': Colors.red,
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    final uColor = uc['color'] as Color;
    print('Use case ${i + 1}: ${uc['title']}');
    useCaseWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: uColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: uColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: uColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(uc['icon'] as IconData, color: uColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uc['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: uColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    uc['body'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.phone_iphone,
      'text': 'SliverSafeArea is the sliver version of SafeArea. It adds '
          'safe-area padding to a sliver child inside a CustomScrollView.',
    },
    {
      'icon': Icons.toggle_on,
      'text': 'Each edge (top, bottom, left, right) can be individually '
          'enabled or disabled, defaulting to all true.',
    },
    {
      'icon': Icons.padding,
      'text': 'The minimum parameter sets a floor for the padding — '
          'padding is max(safeAreaInset, minimum) per edge.',
    },
    {
      'icon': Icons.vertical_align_bottom,
      'text': 'Most common use: wrapping the last sliver with '
          'SliverSafeArea(top: false) to clear the home indicator.',
    },
    {
      'icon': Icons.devices,
      'text': 'Handles notches, camera cutouts, rounded corners, home '
          'indicators, and foldable device form factors automatically.',
    },
    {
      'icon': Icons.compare,
      'text': 'Functionally equivalent to SliverPadding with the '
          'MediaQuery safe-area insets, but more convenient.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.blueGrey.shade700,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverSafeArea'),
        backgroundColor: Colors.blueGrey.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.construction), text: 'Constructor'),
            Tab(icon: Icon(Icons.list), text: 'Basic'),
            Tab(icon: Icon(Icons.toggle_on), text: 'Selective'),
            Tab(icon: Icon(Icons.padding), text: 'Minimum'),
            Tab(icon: Icon(Icons.compare), text: 'Without/With'),
            Tab(icon: Icon(Icons.lightbulb), text: 'Use Cases'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverSafeArea is the sliver equivalent of SafeArea. '
                  'It wraps a sliver child with safe-area padding so '
                  'content is not obscured by device hardware features.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: Constructor
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'One required parameter (sliver) and four boolean edge '
                  'toggles plus a minimum padding override.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...constructorWidgets,
            ],
          ),

          // Tab 3: Basic
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A contacts list wrapped in SliverSafeArea with top: false '
                  '(already handled by SliverAppBar). The bottom safe area '
                  'ensures the last item is not hidden.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: basicDemo,
                ),
              ),
            ],
          ),

          // Tab 4: Selective edges
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Each edge can be enabled or disabled independently. '
                  'The mini phone diagrams show which edges are active '
                  '(bold colored border) vs inactive (thin grey border).',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...edgeCards,
            ],
          ),

          // Tab 5: Minimum insets
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The minimum parameter ensures a baseline padding even '
                  'on devices without safe-area insets.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              minimumNote,
              ...minimumWidgets,
            ],
          ),

          // Tab 6: Without vs With
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Visual comparison of a sliver list on a device with a '
                  'home indicator — without and with SliverSafeArea.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              buildDeviceFrame('Without SliverSafeArea', false, Colors.red),
              const SizedBox(height: 12),
              buildDeviceFrame('With SliverSafeArea', true, Colors.green),
            ],
          ),

          // Tab 7: Use Cases
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common scenarios where SliverSafeArea is essential:',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...useCaseWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueGrey.withOpacity(0.12),
                      Colors.grey.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key points about SliverSafeArea.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPER: Edge badge for selective edges display
// ============================================================
Widget _ssaEdgeBadge(String label, bool active, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: active ? accent.withOpacity(0.15) : Colors.grey.withOpacity(0.08),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: active ? accent.withOpacity(0.4) : Colors.grey.withOpacity(0.2),
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: active ? accent : Colors.grey,
      ),
    ),
  );
}

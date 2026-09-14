// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverIgnorePointer
// Demonstrates SliverIgnorePointer — a sliver that makes its child sliver
// invisible to pointer events. Taps, drags, and other gestures pass through
// as if the sliver were not there. This is the sliver equivalent of the
// IgnorePointer widget for box-based layouts.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverIgnorePointer Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What Is SliverIgnorePointer?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptEntries = <Map<String, dynamic>>[
    {
      'icon': Icons.do_not_touch,
      'title': 'What Is SliverIgnorePointer?',
      'body': 'SliverIgnorePointer wraps a child sliver and makes it '
          'invisible to pointer events. When ignoring is true, taps, '
          'drags, and all pointer interactions simply pass through the '
          'sliver as if it did not exist. The content remains visible — '
          'only touch interaction is suppressed.',
      'accent': Colors.red,
    },
    {
      'icon': Icons.layers,
      'title': 'IgnorePointer vs AbsorbPointer',
      'body': 'IgnorePointer lets pointer events pass through to widgets '
          'behind it. AbsorbPointer catches those events but does not '
          'respond, preventing anything behind it from receiving them. '
          'SliverIgnorePointer follows the IgnorePointer model — events '
          'go through, not absorbed.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.accessibility_new,
      'title': 'Semantics Control',
      'body': 'The optional ignoringSemantics parameter controls whether '
          'the sliver is also hidden from accessibility services (screen '
          'readers). By default, semantics follows the ignoring flag, but '
          'you can decouple them for cases where the content should remain '
          'announced but not tappable.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.build_circle,
      'title': 'Typical Use Cases',
      'body': 'Disabling a sliver section while loading. Showing a '
          'decorative or informational sliver overlay that should not '
          'intercept gestures. Temporarily blocking input during animations. '
          'Creating non-interactive preview or read-only scroll regions.',
      'accent': Colors.teal,
    },
  ];

  final conceptWidgets = <Widget>[];
  for (var idx = 0; idx < conceptEntries.length; idx++) {
    final e = conceptEntries[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
    conceptWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: accent.withValues(alpha: 0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(e['icon'] as IconData, color: accent, size: 26.0),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.5,
                      color: accent,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    e['body'] as String,
                    style: TextStyle(
                      fontSize: 12.5,
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
  // SECTION 2: Constructor & Parameters
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorParams = <Map<String, dynamic>>[
    {
      'name': 'ignoring',
      'type': 'bool',
      'required': false,
      'defaultVal': 'true',
      'desc': 'Whether this sliver is ignored during hit testing. When true, '
          'pointer events pass through; when false, the sliver behaves '
          'normally and receives taps and gestures.',
    },
    {
      'name': 'ignoringSemantics',
      'type': 'bool?',
      'required': false,
      'defaultVal': 'null',
      'desc': 'Whether the semantics of this sliver should also be ignored. '
          'When null, the value follows the ignoring parameter. Set to '
          'false to keep the sliver accessible to screen readers even '
          'when pointer events are ignored.',
    },
    {
      'name': 'sliver',
      'type': 'Widget?',
      'required': false,
      'defaultVal': 'null',
      'desc': 'The child sliver whose pointer events will be controlled. '
          'Can be any sliver: SliverList, SliverGrid, SliverToBoxAdapter, etc.',
    },
    {
      'name': 'key',
      'type': 'Key?',
      'required': false,
      'defaultVal': 'null',
      'desc': 'An optional widget key for identity during rebuilds.',
    },
  ];

  final paramWidgets = <Widget>[];
  for (final cp in constructorParams) {
    final isReq = cp['required'] as bool;
    final defVal = cp['defaultVal'] as String;
    print('  param: ${cp['name']} (${cp['type']}) default=$defVal');
    paramWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.red.withValues(alpha: 0.1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: isReq
                    ? Colors.red.withValues(alpha: 0.1)
                    : Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                isReq ? 'REQUIRED' : 'OPTIONAL',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: isReq ? Colors.red : Colors.green.shade700,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        cp['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.red,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Text(
                          cp['type'] as String,
                          style: TextStyle(
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      if (defVal.isNotEmpty) ...[
                        const SizedBox(width: 6.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: Text(
                            '= $defVal',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    cp['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                      height: 1.35,
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

  // Code snippet
  final codeCard = Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.red.shade200, size: 16.0),
            const SizedBox(width: 8.0),
            Text(
              'Usage Pattern',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverIgnorePointer(\n'
          '      ignoring: true,\n'
          '      sliver: SliverList(\n'
          '        delegate: SliverChildListDelegate([\n'
          '          ListTile(title: Text(\'Can\\\'t tap me!\')),\n'
          '        ]),\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: Colors.green.shade300,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: ignoring=true Demo
  // ============================================================
  print('=== Section 3: ignoring=true ===');

  // Demo: A scrollview where the top section is ignored (grayed out)
  // and the bottom section is interactive
  final ignoringTrueDemo = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.red.withValues(alpha: 0.08),
          child: Row(
            children: [
              const Icon(Icons.do_not_touch, color: Colors.red, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'This section is wrapped in SliverIgnorePointer(ignoring: true). '
                  'Taps pass through — the InkWells below will not respond.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.red.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverIgnorePointer(
        ignoring: true,
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            _buildInteractiveCards(
              'Ignored',
              Colors.red,
              6,
              isDisabled: true,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.green.withValues(alpha: 0.08),
          child: Row(
            children: [
              const Icon(Icons.touch_app, color: Colors.green, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'This section has NO SliverIgnorePointer. The InkWells '
                  'below respond normally to taps.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.green.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          _buildInteractiveCards(
            'Active',
            Colors.green,
            6,
            isDisabled: false,
          ),
        ),
      ),
    ],
  );
  print('Built ignoring=true demo');

  // ============================================================
  // SECTION 4: ignoring=false (Normal) Demo
  // ============================================================
  print('=== Section 4: ignoring=false ===');

  final ignoringFalseDemo = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.blue.withValues(alpha: 0.08),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.blue, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'SliverIgnorePointer with ignoring: false acts exactly '
                  'like having no SliverIgnorePointer at all — the child '
                  'sliver receives events normally. This is useful for '
                  'dynamic toggling.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverIgnorePointer(
        ignoring: false,
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            _buildInteractiveCards(
              'Interactive (ignoring: false)',
              Colors.blue,
              8,
              isDisabled: false,
            ),
          ),
        ),
      ),
    ],
  );
  print('Built ignoring=false demo');

  // ============================================================
  // SECTION 5: Loading Overlay Pattern
  // ============================================================
  print('=== Section 5: Loading Overlay Pattern ===');

  // Real-world pattern: content list with a loading state overlay
  // The content becomes non-interactive during loading
  final loadingOverlayDemo = Stack(
    children: [
      CustomScrollView(
        slivers: [
          SliverIgnorePointer(
            ignoring: true, // simulating "loading" state
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final titles = [
                    'Order #1024 — Shipped',
                    'Order #1023 — Processing',
                    'Order #1022 — Delivered',
                    'Order #1021 — Pending',
                    'Order #1020 — Cancelled',
                    'Order #1019 — Refunded',
                    'Order #1018 — Delivered',
                    'Order #1017 — Shipped',
                    'Order #1016 — Processing',
                    'Order #1015 — Delivered',
                  ];
                  final statusColors = [
                    Colors.blue,
                    Colors.orange,
                    Colors.green,
                    Colors.amber,
                    Colors.red,
                    Colors.purple,
                    Colors.green,
                    Colors.blue,
                    Colors.orange,
                    Colors.green,
                  ];
                  final statusIcons = [
                    Icons.local_shipping,
                    Icons.hourglass_top,
                    Icons.check_circle,
                    Icons.pending,
                    Icons.cancel,
                    Icons.replay,
                    Icons.check_circle,
                    Icons.local_shipping,
                    Icons.hourglass_top,
                    Icons.check_circle,
                  ];
                  return Opacity(
                    opacity: 0.4,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 4.0,
                      ),
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38.0,
                            height: 38.0,
                            decoration: BoxDecoration(
                              color: statusColors[index]
                                  .withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              statusIcons[index],
                              color: statusColors[index],
                              size: 20.0,
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  titles[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  'Tap to view details (disabled during load)',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
      // Loading overlay
      Positioned.fill(
        child: Container(
          color: Colors.white.withValues(alpha: 0.3),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 3.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Refreshing orders...',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'SliverIgnorePointer blocks all input',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
  print('Built loading overlay pattern');

  // ============================================================
  // SECTION 6: Ignore vs Absorb Comparison
  // ============================================================
  print('=== Section 6: Ignore vs Absorb ===');

  Widget buildComparisonPanel(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    List<Map<String, String>> bullets,
    String codeSnippet,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24.0),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: color,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...bullets.map(
                  (b) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6.0,
                          height: 6.0,
                          margin: const EdgeInsets.only(top: 5.0),
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey.shade700,
                              ),
                              children: [
                                TextSpan(
                                  text: '${b['label']}: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: b['desc']),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    codeSnippet,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final comparisonWidgets = <Widget>[
    buildComparisonPanel(
      'SliverIgnorePointer',
      'Events pass THROUGH to widgets behind',
      Icons.do_not_touch,
      Colors.red,
      [
        {'label': 'Pointer events', 'desc': 'Pass through to layers beneath'},
        {'label': 'Sliver child', 'desc': 'Visible but completely non-interactive'},
        {'label': 'Widgets behind', 'desc': 'CAN receive the pass-through events'},
        {'label': 'Use when', 'desc': 'You want content behind to be tappable'},
      ],
      'SliverIgnorePointer(\n  ignoring: true,\n  sliver: mySliverList,\n)',
    ),
    buildComparisonPanel(
      'IgnorePointer (box equivalent)',
      'Same behavior but for box widgets',
      Icons.crop_square,
      Colors.orange,
      [
        {'label': 'Pointer events', 'desc': 'Pass through to the widget stack below'},
        {'label': 'Child', 'desc': 'Any box widget — also visible but non-interactive'},
        {'label': 'Difference', 'desc': 'Works in Column/Row/Stack, not in sliver contexts'},
        {'label': 'Use when', 'desc': 'Non-sliver layout needs pointer passthrough'},
      ],
      'IgnorePointer(\n  ignoring: true,\n  child: myBoxWidget,\n)',
    ),
    buildComparisonPanel(
      'AbsorbPointer (box only)',
      'Events are STOPPED — nothing beneath receives them',
      Icons.block,
      Colors.purple,
      [
        {'label': 'Pointer events', 'desc': 'Absorbed and discarded — no passthrough'},
        {'label': 'Child', 'desc': 'Visible but non-interactive, same as IgnorePointer'},
        {'label': 'Widgets behind', 'desc': 'CANNOT receive events — they are consumed'},
        {'label': 'Use when', 'desc': 'You want a modal-like block on events'},
      ],
      'AbsorbPointer(\n  absorbing: true,\n  child: myBoxWidget,\n)',
    ),
  ];
  print('Built ${comparisonWidgets.length} comparison panels');

  // ============================================================
  // SECTION 7: Semantics Control
  // ============================================================
  print('=== Section 7: Accessibility / ignoringSemantics ===');

  // Build visual cards showing semantics combinations
  final semanticsCombos = <Map<String, dynamic>>[
    {
      'ignoring': true,
      'ignoringSemantics': null,
      'label': 'ignoring:true, ignoringSemantics:null',
      'pointerResult': 'Pointer events blocked',
      'semanticsResult': 'Follows ignoring → hidden from screen readers',
      'icon': Icons.visibility_off,
      'color': Colors.red,
    },
    {
      'ignoring': true,
      'ignoringSemantics': false,
      'label': 'ignoring:true, ignoringSemantics:false',
      'pointerResult': 'Pointer events blocked',
      'semanticsResult': 'Still announced by screen readers',
      'icon': Icons.record_voice_over,
      'color': Colors.orange,
    },
    {
      'ignoring': false,
      'ignoringSemantics': null,
      'label': 'ignoring:false, ignoringSemantics:null',
      'pointerResult': 'Pointer events pass through normally',
      'semanticsResult': 'Follows ignoring → visible to screen readers',
      'icon': Icons.touch_app,
      'color': Colors.green,
    },
    {
      'ignoring': false,
      'ignoringSemantics': true,
      'label': 'ignoring:false, ignoringSemantics:true',
      'pointerResult': 'Pointer events pass through normally',
      'semanticsResult': 'Hidden from screen readers (unusual combo)',
      'icon': Icons.hearing_disabled,
      'color': Colors.deepPurple,
    },
  ];

  final semanticsCards = <Widget>[];
  for (final combo in semanticsCombos) {
    final color = combo['color'] as Color;
    semanticsCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(combo['icon'] as IconData, color: color, size: 22.0),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    combo['label'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    combo['pointerResult'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    combo['semanticsResult'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build live demo slivers showing semantics in action
  final semanticsDemo = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            'The sliver below has ignoring:true, ignoringSemantics:false.\n'
            'Screen readers still announce it but taps do not work.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      SliverIgnorePointer(
        ignoring: true,
        ignoringSemantics: false,
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 4.0,
              ),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.record_voice_over,
                    color: Colors.orange,
                    size: 24.0,
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Accessibility-visible item',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          'Screen reader: "Accessibility-visible item"\n'
                          'Touch: no response (ignoring: true)',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 4.0,
              ),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.accessibility,
                    color: Colors.orange,
                    size: 24.0,
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Another accessible, non-tappable item',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          'This content is read aloud by TalkBack/VoiceOver '
                          'but touching it triggers nothing.',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ],
  );
  print('Built semantics demo');

  // ============================================================
  // SECTION 8: Summary & Reference
  // ============================================================
  print('=== Section 8: Summary ===');

  final keyPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.check_circle,
      'text': 'SliverIgnorePointer blocks pointer events on a child sliver',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'Events pass through — widgets behind can receive them',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'Set ignoring:false to re-enable interactivity dynamically',
      'color': Colors.green,
    },
    {
      'icon': Icons.lightbulb_outline,
      'text': 'Use ignoringSemantics to decouple accessibility from pointer behavior',
      'color': Colors.amber,
    },
    {
      'icon': Icons.lightbulb_outline,
      'text': 'Great for loading states, read-only views, and overlays',
      'color': Colors.amber,
    },
    {
      'icon': Icons.warning_amber,
      'text': 'No AbsorbPointer equivalent for slivers — SliverIgnorePointer only ignores',
      'color': Colors.orange,
    },
    {
      'icon': Icons.warning_amber,
      'text': 'The child sliver is still painted and laid out normally',
      'color': Colors.orange,
    },
  ];

  final keyPointWidgets = <Widget>[];
  for (final kp in keyPoints) {
    final color = kp['color'] as Color;
    keyPointWidgets.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(kp['icon'] as IconData, color: color, size: 18.0),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                kp['text'] as String,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey.shade800,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final refTable = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sipRefRow('Widget', 'SliverIgnorePointer'),
      _sipRefRow('Library', 'package:flutter/widgets.dart'),
      _sipRefRow('Parent', 'CustomScrollView.slivers'),
      _sipRefRow('Key param', 'ignoring (bool, default true)'),
      _sipRefRow('Semantics', 'ignoringSemantics (bool?)'),
      _sipRefRow('Box equiv', 'IgnorePointer'),
      _sipRefRow('Use case', 'Non-interactive sliver overlay / loading'),
    ],
  );

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('=== Assembling tabbed layout ===');
  print('SliverIgnorePointer Deep Demo complete');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverIgnorePointer Deep Demo'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 11.0),
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Constructor'),
            Tab(text: 'Ignoring'),
            Tab(text: 'Not Ignoring'),
            Tab(text: 'Loading'),
            Tab(text: 'Comparison'),
            Tab(text: 'Semantics'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withValues(alpha: 0.1),
                        Colors.red.withValues(alpha: 0.03),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.do_not_touch,
                        size: 48.0,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'SliverIgnorePointer',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'A sliver that makes its child invisible to '
                        'pointer events while keeping it visually present.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...conceptWidgets,
              ],
            ),
          ),
          // Tab 2: Constructor
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Constructor Parameters',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'SliverIgnorePointer has three key parameters that control '
                  'pointer and semantics behavior.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...paramWidgets,
                codeCard,
              ],
            ),
          ),
          // Tab 3: ignoring=true
          ignoringTrueDemo,
          // Tab 4: ignoring=false
          ignoringFalseDemo,
          // Tab 5: Loading overlay
          loadingOverlayDemo,
          // Tab 6: Comparison
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ignore vs Absorb vs Sliver',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Flutter offers several ways to block pointer events. '
                  'Here is how they differ:',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...comparisonWidgets,
              ],
            ),
          ),
          // Tab 7: Semantics
          Column(
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ignoringSemantics Combinations',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      ...semanticsCards,
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: semanticsDemo,
              ),
            ],
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Key Takeaways',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...keyPointWidgets,
                const SizedBox(height: 24.0),
                Text(
                  'Quick Reference',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.1),
                    ),
                  ),
                  child: refTable,
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
// HELPER: Build interactive cards for ignore/active comparison
// ============================================================
List<Widget> _buildInteractiveCards(
  String prefix,
  Color accent,
  int count, {
  required bool isDisabled,
}) {
  final items = <Widget>[];
  for (var i = 0; i < count; i++) {
    items.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
        child: Material(
          color: isDisabled
              ? Colors.grey.shade100
              : accent.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              print('$prefix card ${i + 1} tapped');
            },
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: isDisabled
                      ? Colors.grey.shade300
                      : accent.withValues(alpha: 0.15),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: isDisabled
                          ? Colors.grey.shade200
                          : accent.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isDisabled ? Icons.block : Icons.touch_app,
                      color: isDisabled ? Colors.grey : accent,
                      size: 18.0,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$prefix item ${i + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: isDisabled
                                ? Colors.grey
                                : Colors.grey.shade800,
                          ),
                        ),
                        Text(
                          isDisabled
                              ? 'Tapping does nothing — pointer events ignored'
                              : 'Tap to see InkWell ripple effect',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isDisabled ? Icons.do_not_touch : Icons.chevron_right,
                    color: isDisabled ? Colors.grey.shade400 : accent,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  return items;
}

// ============================================================
// HELPER: Reference row
// ============================================================
Widget _sipRefRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}

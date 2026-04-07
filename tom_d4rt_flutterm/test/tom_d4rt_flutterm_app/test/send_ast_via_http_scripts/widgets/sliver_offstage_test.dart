// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverOffstage
// Demonstrates SliverOffstage — a sliver that can be completely hidden from
// layout and painting while remaining in the widget tree. When offstage is
// true the child sliver takes zero space and is invisible; when false it
// renders normally. This is the sliver equivalent of the Offstage widget.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverOffstage Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.visibility_off,
      'title': 'What Is SliverOffstage?',
      'body': 'SliverOffstage wraps a child sliver and can hide it from the '
          'layout entirely. When offstage is true, the child occupies zero '
          'scroll extent, is not painted, and does not participate in hit '
          'testing. But it remains in the widget tree — state is preserved.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.compare,
      'title': 'Offstage vs Removing from Tree',
      'body': 'If you conditionally omit a sliver from the slivers list, '
          'its State is destroyed. SliverOffstage keeps the child mounted '
          'so StatefulWidget state, animations, and controllers survive '
          'the hide/show cycle.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.visibility,
      'title': 'Offstage vs Visibility',
      'body': 'Visibility(visible: false) still takes space even though it '
          'is invisible. SliverOffstage(offstage: true) removes the sliver '
          'from layout — it takes no space at all. Similar to Offstage for '
          'box widgets, but operating in sliver coordinates.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.flag,
      'title': 'Typical Use Cases',
      'body': 'Feature flags — hide experimental sections without removing '
          'from tree. Admin-only sections that appear when toggled. '
          'Conditional content that maintains state between toggles. '
          'Progressive disclosure in complex scrolling views.',
      'accent': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var idx = 0; idx < conceptItems.length; idx++) {
    final e = conceptItems[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
    conceptCards.add(
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

  final ctorParams = <Map<String, dynamic>>[
    {
      'name': 'offstage',
      'type': 'bool',
      'required': false,
      'defaultVal': 'true',
      'desc': 'Whether the child sliver is hidden from layout and painting. '
          'When true, the sliver occupies zero extent and is invisible. '
          'When false, the sliver renders normally.',
    },
    {
      'name': 'sliver',
      'type': 'Widget?',
      'required': false,
      'defaultVal': 'null',
      'desc': 'The child sliver to show or hide. Can be any sliver widget: '
          'SliverList, SliverGrid, SliverToBoxAdapter, etc.',
    },
    {
      'name': 'key',
      'type': 'Key?',
      'required': false,
      'defaultVal': 'null',
      'desc': 'Optional widget key for identity during rebuilds.',
    },
  ];

  final paramWidgets = <Widget>[];
  for (final cp in ctorParams) {
    final isReq = cp['required'] as bool;
    final defVal = cp['defaultVal'] as String;
    paramWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.indigo.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.indigo.withValues(alpha: 0.1)),
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
                          color: Colors.indigo,
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

  final codeSnippet = Container(
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
            Icon(Icons.code, color: Colors.indigo.shade200, size: 16.0),
            const SizedBox(width: 8.0),
            Text(
              'Usage Pattern',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverOffstage(\n'
          '      offstage: isHidden,  // true = hidden\n'
          '      sliver: SliverList(\n'
          '        delegate: SliverChildListDelegate([\n'
          '          ListTile(title: Text(\'Hidden section\')),\n'
          '        ]),\n'
          '      ),\n'
          '    ),\n'
          '    SliverList(...), // Other visible content\n'
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
  // SECTION 3: offstage=true Demo
  // ============================================================
  print('=== Section 3: offstage=true ===');

  final offstageTrue = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.red.withValues(alpha: 0.06),
          child: Row(
            children: [
              const Icon(Icons.visibility_off, color: Colors.red, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The "Premium Content" section below is wrapped in '
                  'SliverOffstage(offstage: true). It takes zero space '
                  'and is invisible — scroll directly from "Standard" to '
                  '"Community".',
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
      // Visible section
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.all(14.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.star_border, color: Colors.green, size: 20.0),
                  const SizedBox(width: 8.0),
                  Text(
                    'Standard Content',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'This section is always visible.',
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          _sosBuildContentItems('Standard', Colors.green, 5),
        ),
      ),
      // Hidden (offstage) section
      SliverOffstage(
        offstage: true,
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.all(14.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.diamond, color: Colors.amber, size: 24.0),
                  const SizedBox(width: 10.0),
                  Text(
                    'Premium Content — HIDDEN (offstage: true)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.amber.shade700,
                    ),
                  ),
                ],
              ),
            ),
            ..._sosBuildContentItems('Premium', Colors.amber, 4),
          ]),
        ),
      ),
      // Another visible section
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.all(14.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.people, color: Colors.blue, size: 20.0),
                  const SizedBox(width: 8.0),
                  Text(
                    'Community Content',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'This section follows directly after Standard — the Premium '
                'section takes zero space.',
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          _sosBuildContentItems('Community', Colors.blue, 5),
        ),
      ),
    ],
  );
  print('Built offstage=true demo');

  // ============================================================
  // SECTION 4: offstage=false Demo
  // ============================================================
  print('=== Section 4: offstage=false ===');

  final offstageFalse = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.green.withValues(alpha: 0.06),
          child: Row(
            children: [
              const Icon(Icons.visibility, color: Colors.green, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Same layout, but SliverOffstage(offstage: false) — the '
                  'Premium section is now visible and takes its full space.',
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
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.all(14.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green.withValues(alpha: 0.15)),
          ),
          child: Row(
            children: [
              const Icon(Icons.star_border, color: Colors.green, size: 20.0),
              const SizedBox(width: 8.0),
              Text(
                'Standard Content',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          _sosBuildContentItems('Standard', Colors.green, 3),
        ),
      ),
      // Now visible (offstage: false)
      SliverOffstage(
        offstage: false,
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.all(14.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.diamond, color: Colors.amber, size: 24.0),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Premium Content — VISIBLE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.amber.shade700,
                          ),
                        ),
                        Text(
                          'offstage: false — renders normally',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ..._sosBuildContentItems('Premium', Colors.amber, 4),
          ]),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.all(14.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.15)),
          ),
          child: Row(
            children: [
              const Icon(Icons.people, color: Colors.blue, size: 20.0),
              const SizedBox(width: 8.0),
              Text(
                'Community Content',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          _sosBuildContentItems('Community', Colors.blue, 3),
        ),
      ),
    ],
  );
  print('Built offstage=false demo');

  // ============================================================
  // SECTION 5: Feature Flags Pattern
  // ============================================================
  print('=== Section 5: Feature Flags ===');

  // Simulate feature flags controlling section visibility
  final featureFlags = <Map<String, dynamic>>[
    {
      'name': 'AI Assistant',
      'flag': 'enable_ai_assistant',
      'enabled': true,
      'color': Colors.purple,
      'icon': Icons.auto_awesome,
      'desc': 'AI-powered writing suggestions and auto-complete',
    },
    {
      'name': 'Analytics Dashboard',
      'flag': 'enable_analytics',
      'enabled': false,
      'color': Colors.blue,
      'icon': Icons.analytics,
      'desc': 'Real-time usage analytics and performance metrics',
    },
    {
      'name': 'Collaboration',
      'flag': 'enable_collab',
      'enabled': true,
      'color': Colors.teal,
      'icon': Icons.group_work,
      'desc': 'Real-time collaboration with team members',
    },
    {
      'name': 'Dark Mode Preview',
      'flag': 'enable_dark_preview',
      'enabled': false,
      'color': Colors.grey,
      'icon': Icons.dark_mode,
      'desc': 'Preview upcoming dark mode theme refinements',
    },
    {
      'name': 'Export Center',
      'flag': 'enable_export',
      'enabled': true,
      'color': Colors.orange,
      'icon': Icons.file_download,
      'desc': 'Export to PDF, CSV, and custom formats',
    },
  ];

  final featureSlivers = <Widget>[
    SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.deepPurple.withValues(alpha: 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flag, color: Colors.deepPurple, size: 20.0),
                const SizedBox(width: 8.0),
                Text(
                  'Feature Flags Demo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              'Each feature section is wrapped in SliverOffstage. '
              'Enabled features (green badge) are visible; disabled '
              'features (red badge) are offstage.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    ),
    SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(14.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flag Status',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8.0),
            ...featureFlags.map((f) {
              final on = f['enabled'] as bool;
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  children: [
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: on ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '${f['flag']}: ${on ? 'ON' : 'OFF'}',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontFamily: 'monospace',
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      on ? 'visible' : 'offstage',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: on ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    ),
  ];
  for (final f in featureFlags) {
    final enabled = f['enabled'] as bool;
    final color = f['color'] as Color;
    featureSlivers.add(
      SliverOffstage(
        offstage: !enabled,
        sliver: SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 14.0, vertical: 4.0,
            ),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: color.withValues(alpha: 0.15)),
            ),
            child: Row(
              children: [
                Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    f['icon'] as IconData,
                    color: color,
                    size: 22.0,
                  ),
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        f['name'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        f['desc'] as String,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Text(
                    'ACTIVE',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final featureFlagsDemo = CustomScrollView(slivers: featureSlivers);
  print('Built feature flags demo');

  // ============================================================
  // SECTION 6: Comparison
  // ============================================================
  print('=== Section 6: Comparison ===');

  Widget buildCompPanel(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    List<Map<String, String>> bullets,
    String code,
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
                Icon(icon, color: color, size: 22.0),
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
                          fontSize: 11.0,
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
                    padding: const EdgeInsets.only(bottom: 5.0),
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
                const SizedBox(height: 6.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    code,
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

  final compPanels = <Widget>[
    buildCompPanel(
      'SliverOffstage',
      'Sliver context — hides completely',
      Icons.visibility_off,
      Colors.indigo,
      [
        {'label': 'Layout', 'desc': 'Zero extent when offstage — no space taken'},
        {'label': 'Painting', 'desc': 'Not painted when offstage'},
        {'label': 'State', 'desc': 'Preserved — widget tree stays mounted'},
        {'label': 'Context', 'desc': 'Sliver-only — use inside CustomScrollView'},
      ],
      'SliverOffstage(\n  offstage: true,\n  sliver: mySliverList,\n)',
    ),
    buildCompPanel(
      'Offstage',
      'Box context — hides completely',
      Icons.visibility_off,
      Colors.blue,
      [
        {'label': 'Layout', 'desc': 'Zero size when offstage — no space taken'},
        {'label': 'Painting', 'desc': 'Not painted when offstage'},
        {'label': 'State', 'desc': 'Preserved — widget tree stays mounted'},
        {'label': 'Context', 'desc': 'Box-only — Column, Row, Stack, etc.'},
      ],
      'Offstage(\n  offstage: true,\n  child: myBoxWidget,\n)',
    ),
    buildCompPanel(
      'Visibility',
      'Box context — invisible but occupies space',
      Icons.remove_red_eye,
      Colors.orange,
      [
        {'label': 'Layout', 'desc': 'Maintains size — takes space even when invisible'},
        {'label': 'Painting', 'desc': 'Optionally hidden via maintainSize/maintainAnimation'},
        {'label': 'State', 'desc': 'Preserved — tree stays mounted'},
        {'label': 'Context', 'desc': 'Box-only — more control than Offstage'},
      ],
      'Visibility(\n  visible: false,\n  maintainSize: true,\n  child: ...,\n)',
    ),
    buildCompPanel(
      'Conditional Removal',
      'Remove from tree entirely',
      Icons.delete_outline,
      Colors.red,
      [
        {'label': 'Layout', 'desc': 'Widget not in tree — zero space'},
        {'label': 'Painting', 'desc': 'Widget not in tree — nothing to paint'},
        {'label': 'State', 'desc': 'DESTROYED — State object disposed'},
        {'label': 'Context', 'desc': 'Works everywhere but loses state'},
      ],
      'if (showSection)\n  SliverList(...)\n// else: not in tree at all',
    ),
  ];

  // ============================================================
  // SECTION 7: Announcement Board
  // ============================================================
  print('=== Section 7: Announcement Board ===');

  final announcements = <Map<String, dynamic>>[
    {
      'title': 'System Maintenance',
      'body': 'Scheduled maintenance on July 15th from 2:00-4:00 AM UTC. '
          'All services will be temporarily unavailable.',
      'icon': Icons.build,
      'color': Colors.orange,
      'priority': 'high',
      'offstage': false,
    },
    {
      'title': 'New Feature: Dark Mode',
      'body': 'Dark mode is now available! Go to Settings → Appearance '
          'to try it out.',
      'icon': Icons.dark_mode,
      'color': Colors.purple,
      'priority': 'normal',
      'offstage': false,
    },
    {
      'title': 'Staff Only: Q3 Planning',
      'body': 'Internal planning session for Q3 roadmap. Check your calendar '
          'for the meeting invite.',
      'icon': Icons.lock,
      'color': Colors.red,
      'priority': 'internal',
      'offstage': true,
    },
    {
      'title': 'Holiday Hours',
      'body': 'Support hours will be reduced during the holiday period. '
          'Emergency support remains available 24/7.',
      'icon': Icons.event,
      'color': Colors.teal,
      'priority': 'normal',
      'offstage': false,
    },
    {
      'title': 'Beta Testers Wanted',
      'body': 'Join our beta program to preview upcoming features before '
          'they launch. Sign up in your account settings.',
      'icon': Icons.science,
      'color': Colors.blue,
      'priority': 'normal',
      'offstage': true,
    },
  ];

  final announceSlivers = <Widget>[
    SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.campaign,
                  color: Colors.deepOrange,
                  size: 24.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Announcements',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              'Some announcements are offstage (internal/beta). Only '
              'public announcements appear in the list.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    ),
  ];

  for (final ann in announcements) {
    final isHidden = ann['offstage'] as bool;
    final color = ann['color'] as Color;
    announceSlivers.add(
      SliverOffstage(
        offstage: isHidden,
        sliver: SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 14.0, vertical: 5.0,
            ),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: color.withValues(alpha: 0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        ann['icon'] as IconData,
                        color: color,
                        size: 20.0,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        ann['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        (ann['priority'] as String).toUpperCase(),
                        style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  ann['body'] as String,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Add a footer showing hidden count
  announceSlivers.add(
    SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(14.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, color: Colors.grey.shade400, size: 16.0),
            const SizedBox(width: 8.0),
            Text(
              '2 announcements are hidden (offstage) — '
              'Staff Only and Beta Testers',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  final announcementDemo = CustomScrollView(slivers: announceSlivers);
  print('Built announcement board demo');

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final keyPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.check_circle,
      'text': 'SliverOffstage hides a child sliver completely from layout',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'offstage:true = zero extent, no painting, no hit testing',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'Widget tree state is preserved across hide/show cycles',
      'color': Colors.green,
    },
    {
      'icon': Icons.lightbulb_outline,
      'text': 'Ideal for feature flags and conditional sections',
      'color': Colors.amber,
    },
    {
      'icon': Icons.lightbulb_outline,
      'text': 'Unlike Visibility, takes ZERO space when hidden',
      'color': Colors.amber,
    },
    {
      'icon': Icons.warning_amber,
      'text': 'Offstage children still mount and run build() — they cost memory',
      'color': Colors.orange,
    },
    {
      'icon': Icons.warning_amber,
      'text': 'For permanent removal, prefer removing from the slivers list',
      'color': Colors.orange,
    },
  ];

  final summaryPoints = <Widget>[];
  for (final kp in keyPoints) {
    final color = kp['color'] as Color;
    summaryPoints.add(
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
      _sosRefRow('Widget', 'SliverOffstage'),
      _sosRefRow('Library', 'package:flutter/widgets.dart'),
      _sosRefRow('Parent', 'CustomScrollView.slivers'),
      _sosRefRow('Key param', 'offstage (bool, default true)'),
      _sosRefRow('Hidden?', 'Zero extent, not painted, not hit-testable'),
      _sosRefRow('State?', 'Preserved — stays mounted in tree'),
      _sosRefRow('Box equiv', 'Offstage'),
    ],
  );

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('=== Assembling tabbed layout ===');
  print('SliverOffstage Deep Demo complete');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverOffstage Deep Demo'),
        backgroundColor: Colors.indigo.shade700,
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
            Tab(text: 'Offstage'),
            Tab(text: 'Visible'),
            Tab(text: 'Features'),
            Tab(text: 'Comparison'),
            Tab(text: 'Announce'),
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
                        Colors.indigo.withValues(alpha: 0.1),
                        Colors.indigo.withValues(alpha: 0.03),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.visibility_off,
                        size: 48.0,
                        color: Colors.indigo,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'SliverOffstage',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade700,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Hide a sliver completely from layout and painting '
                        'while preserving its state in the widget tree.',
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
                ...conceptCards,
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
                    color: Colors.indigo.shade700,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'SliverOffstage controls visibility with a single boolean.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...paramWidgets,
                codeSnippet,
              ],
            ),
          ),
          // Tab 3: offstage=true
          offstageTrue,
          // Tab 4: offstage=false
          offstageFalse,
          // Tab 5: Feature flags
          featureFlagsDemo,
          // Tab 6: Comparison
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hiding Widgets: Four Approaches',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Different strategies for hiding content, each with '
                  'different trade-offs.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...compPanels,
              ],
            ),
          ),
          // Tab 7: Announcements
          announcementDemo,
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
                    color: Colors.indigo.shade700,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...summaryPoints,
                const SizedBox(height: 24.0),
                Text(
                  'Quick Reference',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.indigo.withValues(alpha: 0.1),
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
// HELPER: Build content items for sections
// ============================================================
List<Widget> _sosBuildContentItems(
  String prefix,
  Color color,
  int count,
) {
  final items = <Widget>[];
  for (var i = 0; i < count; i++) {
    items.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 3.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              '$prefix item ${i + 1}',
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
  return items;
}

// ============================================================
// HELPER: Reference row
// ============================================================
Widget _sosRefRow(String label, String value) {
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

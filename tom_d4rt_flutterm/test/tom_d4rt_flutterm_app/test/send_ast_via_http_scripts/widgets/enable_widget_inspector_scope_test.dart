// ignore_for_file: avoid_print
// D4rt deep-demo script: EnableWidgetInspectorScope
// Visual demonstration of the InheritedWidget that controls whether the
// Flutter widget inspector is enabled for a subtree.
//
// EnableWidgetInspectorScope is part of Flutter's widget-inspection
// infrastructure.  It carries a boolean flag that DevTools and the
// WidgetInspector overlay read to decide whether they should highlight
// widgets below this point in the tree.  By wrapping a subtree with
// EnableWidgetInspectorScope(enable: false, …) you can hide specific
// parts of the UI from the inspector — useful when you have debug
// overlays, hidden admin panels, or framework-level scaffolding that
// should not appear in the DevTools widget tree.
//
// Theme : Crimson Wine (#880E4F) / Blush Rose (#FCE4EC)
// Prefix: _wi
import 'package:flutter/material.dart';

// ───────────────────────────── palette ──────────────────────────────
const Color _wiPrimary = Color(0xFF880E4F);
const Color _wiLight = Color(0xFFFCE4EC);
const Color _wiAccent = Color(0xFFC2185B);
const Color _wiMuted = Color(0xFFAD1457);
const Color _wiSurface = Color(0xFFF8BBD0);
const Color _wiDark = Color(0xFF560027);
const Color _wiHighlight = Color(0xFFFF80AB);

dynamic build(BuildContext context) {
  print('EnableWidgetInspectorScope  Deep Demo executing');

  // ================================================================
  // SECTION 1 — Banner & concept overview
  // ================================================================
  print('=== Section 1: Banner & concept overview ===');

  Widget wiBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_wiPrimary, _wiAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: _wiPrimary.withValues(alpha: 0.45),
            blurRadius: 18.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.remove_red_eye, color: Colors.white, size: 36.0),
              const SizedBox(width: 14.0),
              Expanded(
                child: Text(
                  'EnableWidgetInspectorScope',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            'An InheritedWidget that carries a boolean "enable" flag for '
            'the widget inspector.  Widgets below this scope check the '
            'flag via EnableWidgetInspectorScope.of(context) and decide '
            'whether to render selection highlights and overlays.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 15.0,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 7.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'package:flutter/widgets.dart  ·  InheritedWidget',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 13.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SECTION 2 — API surface
  // ================================================================
  print('=== Section 2: API surface ===');

  final apiItems = <Map<String, String>>[
    {
      'member': 'EnableWidgetInspectorScope({enable, child})',
      'kind': 'constructor',
      'detail':
          'The sole constructor.  "enable" is a bool that propagates '
          'down the tree.  Defaults conceptually to true at the root.',
    },
    {
      'member': 'enable → bool',
      'kind': 'property',
      'detail':
          'The flag that descendant widgets read.  When false, the '
          'inspector overlay skips this subtree.',
    },
    {
      'member': 'of(BuildContext) → bool',
      'kind': 'static method',
      'detail':
          'Convenience look-up.  Returns the nearest enable value found '
          'above the given context, or true when no scope exists.',
    },
    {
      'member': 'updateShouldNotify(…) → bool',
      'kind': 'override',
      'detail':
          'Returns true when the enable flag differs from the old '
          'widget, triggering dependent rebuilds.',
    },
  ];

  Widget wiApiCard(Map<String, String> item, int index) {
    final icons = <String, IconData>{
      'constructor': Icons.build_circle_outlined,
      'property': Icons.label_outlined,
      'static method': Icons.search,
      'override': Icons.sync_alt,
    };
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: index.isEven ? _wiLight : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: _wiPrimary.withValues(alpha: 0.25),
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icons[item['kind']] ?? Icons.code,
            color: _wiAccent,
            size: 28.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['member']!,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: _wiDark,
                  ),
                ),
                const SizedBox(height: 4.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: _wiSurface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    item['kind']!,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: _wiMuted,
                    ),
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  item['detail']!,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade700,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final apiSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (int i = 0; i < apiItems.length; i++)
        wiApiCard(apiItems[i], i),
    ],
  );

  // ================================================================
  // SECTION 3 — Inspector enabled vs disabled scoping
  // ================================================================
  print('=== Section 3: Inspector enabled vs disabled scoping ===');

  Widget wiScopeBox({
    required bool enabled,
    required String label,
    required String explanation,
    required IconData icon,
  }) {
    final borderColor = enabled ? _wiAccent : Colors.grey.shade400;
    final bg = enabled
        ? _wiLight.withValues(alpha: 0.7)
        : Colors.grey.shade100;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.2),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: enabled
                      ? _wiPrimary.withValues(alpha: 0.15)
                      : Colors.grey.shade200,
                ),
                child: Icon(
                  icon,
                  color: enabled ? _wiPrimary : Colors.grey,
                  size: 24.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: enabled ? _wiDark : Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      enabled ? 'Inspector ENABLED' : 'Inspector DISABLED',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: enabled ? _wiAccent : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: enabled ? _wiAccent : Colors.grey,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  enabled ? 'ON' : 'OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            explanation,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10.0),
          // Simulated child widgets that would be inspectable or not
          Row(
            children: [
              for (int i = 0; i < 4; i++)
                Expanded(
                  child: Container(
                    height: 36.0,
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(
                      color: enabled
                          ? _wiHighlight.withValues(alpha: 0.3 + i * 0.15)
                          : Colors.grey.withValues(alpha: 0.15 + i * 0.1),
                      borderRadius: BorderRadius.circular(6.0),
                      border: enabled
                          ? Border.all(
                              color: _wiAccent.withValues(alpha: 0.5),
                              width: 1.5,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        enabled ? '✓' : '—',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: enabled ? _wiPrimary : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  print('  Enabled scope: child widgets are inspectable');
  print('  Disabled scope: child widgets are hidden from inspector');

  final scopeSection = Column(
    children: [
      wiScopeBox(
        enabled: true,
        label: 'Application Content',
        explanation:
            'When enable=true (the default), all child widgets in this '
            'subtree are visible to the widget inspector.  Selection '
            'highlights, layout guides, and the widget tree show every '
            'element normally.',
        icon: Icons.visibility,
      ),
      wiScopeBox(
        enabled: false,
        label: 'Debug Overlay Panel',
        explanation:
            'Wrapping a debug overlay with enable=false hides it from '
            'the inspector.  This prevents the overlay from cluttering '
            'the DevTools widget tree or interfering with selection of '
            'the real UI underneath.',
        icon: Icons.visibility_off,
      ),
    ],
  );

  // ================================================================
  // SECTION 4 — Nested scope override patterns
  // ================================================================
  print('=== Section 4: Nested scope override patterns ===');

  Widget wiNestLevel({
    required int depth,
    required bool enabled,
    required String label,
    required List<Widget> children,
  }) {
    final hue = enabled ? _wiPrimary : Colors.grey.shade500;
    final indent = depth * 12.0;
    return Container(
      margin: EdgeInsets.only(left: indent, top: 8.0, bottom: 8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: enabled
            ? _wiLight.withValues(alpha: 0.5 + depth * 0.1)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(
            color: hue,
            width: 3.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: enabled ? _wiAccent : Colors.grey,
                ),
                child: Center(
                  child: Text(
                    '${depth + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  '$label  (enable: $enabled)',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: enabled ? _wiDark : Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          if (children.isNotEmpty) ...[
            const SizedBox(height: 6.0),
            ...children,
          ],
        ],
      ),
    );
  }

  print('  Nesting: root(true) → panel(false) → inner(true)');

  final nestingSection = wiNestLevel(
    depth: 0,
    enabled: true,
    label: 'MaterialApp',
    children: [
      wiNestLevel(
        depth: 1,
        enabled: true,
        label: 'Scaffold body',
        children: [
          wiNestLevel(
            depth: 2,
            enabled: false,
            label: 'Debug FPS overlay',
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(left: 36.0, top: 4.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'Hidden: FPS counter, memory bar, repaint rainbow',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          wiNestLevel(
            depth: 2,
            enabled: true,
            label: 'User content area',
            children: [
              wiNestLevel(
                depth: 3,
                enabled: true,
                label: 'Form widgets — inspectable',
                children: [],
              ),
            ],
          ),
        ],
      ),
      wiNestLevel(
        depth: 1,
        enabled: false,
        label: 'Admin diagnostics drawer',
        children: [
          wiNestLevel(
            depth: 2,
            enabled: true,
            label: 'Re-enabled subsection',
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(left: 36.0, top: 4.0),
                decoration: BoxDecoration(
                  color: _wiLight,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: _wiAccent.withValues(alpha: 0.3)),
                ),
                child: Text(
                  'Re-enabled: a child scope can override its parent \'s '
                  'disable, making this subsection inspectable again.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _wiDark,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  // ================================================================
  // SECTION 5 — Conditional inspector toggle use case
  // ================================================================
  print('=== Section 5: Conditional inspector toggle ===');

  final toggleScenarios = <Map<String, dynamic>>[
    {
      'scenario': 'Development builds',
      'enabled': true,
      'icon': Icons.developer_mode,
      'description':
          'In debug mode, the inspector scope is enabled so developers '
          'can freely explore the widget tree, check layouts, and '
          'diagnose rendering issues.',
      'code': 'EnableWidgetInspectorScope(\n'
          '  enable: kDebugMode,\n'
          '  child: MyApp(),\n'
          ')',
    },
    {
      'scenario': 'Profile builds',
      'enabled': false,
      'icon': Icons.speed,
      'description':
          'In profile mode, inspection may be partially disabled to '
          'reduce overhead from the DevTools protocol, while keeping '
          'performance overlays visible.',
      'code': 'EnableWidgetInspectorScope(\n'
          '  enable: false,\n'
          '  child: PerformanceDashboard(),\n'
          ')',
    },
    {
      'scenario': 'Sensitive content',
      'enabled': false,
      'icon': Icons.security,
      'description':
          'When displaying credentials, keys, or privacy-sensitive '
          'data you can wrap the subtree with enable=false to prevent '
          'the inspector from exposing text content.',
      'code': 'EnableWidgetInspectorScope(\n'
          '  enable: false,\n'
          '  child: PasswordField(),\n'
          ')',
    },
    {
      'scenario': 'Custom overlays',
      'enabled': false,
      'icon': Icons.layers_clear,
      'description':
          'Tooltip overlays, modals, and transient UI might clutter '
          'the widget tree in DevTools.  Disabling the scope for '
          'those keeps the inspector focused on stable content.',
      'code': 'EnableWidgetInspectorScope(\n'
          '  enable: false,\n'
          '  child: TooltipOverlay(),\n'
          ')',
    },
  ];

  Widget wiToggleCard(Map<String, dynamic> s) {
    final on = s['enabled'] as bool;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: on ? _wiLight : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: on
              ? _wiAccent.withValues(alpha: 0.4)
              : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                s['icon'] as IconData,
                color: on ? _wiPrimary : Colors.grey.shade600,
                size: 26.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  s['scenario'] as String,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: on ? _wiDark : Colors.grey.shade700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: on
                      ? _wiAccent.withValues(alpha: 0.15)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  on ? 'enable: true' : 'enable: false',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: on ? _wiAccent : Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            s['description'] as String,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey.shade700,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _wiDark.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              s['code'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: _wiDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  for (final s in toggleScenarios) {
    print('  Scenario: ${s['scenario']} → enable=${s['enabled']}');
  }

  final toggleSection = Column(
    children: [for (final s in toggleScenarios) wiToggleCard(s)],
  );

  // ================================================================
  // SECTION 6 — Widget tree inspection visualization
  // ================================================================
  print('=== Section 6: Widget tree inspection visualization ===');

  final treeNodes = <Map<String, dynamic>>[
    {'name': 'MaterialApp', 'depth': 0, 'inspectable': true},
    {'name': 'Scaffold', 'depth': 1, 'inspectable': true},
    {'name': 'AppBar', 'depth': 2, 'inspectable': true},
    {'name': 'Title Text', 'depth': 3, 'inspectable': true},
    {'name': 'Body Column', 'depth': 2, 'inspectable': true},
    {'name': 'EnableScope(false)', 'depth': 3, 'inspectable': false},
    {'name': '  FPS Overlay', 'depth': 4, 'inspectable': false},
    {'name': '  Memory Graph', 'depth': 4, 'inspectable': false},
    {'name': '  Repaint Rainbow', 'depth': 4, 'inspectable': false},
    {'name': 'User ListView', 'depth': 3, 'inspectable': true},
    {'name': '  Card A', 'depth': 4, 'inspectable': true},
    {'name': '  Card B', 'depth': 4, 'inspectable': true},
    {'name': '  Card C', 'depth': 4, 'inspectable': true},
    {'name': 'FloatingActionButton', 'depth': 2, 'inspectable': true},
  ];

  Widget wiTreeNode(Map<String, dynamic> node) {
    final vis = node['inspectable'] as bool;
    final d = node['depth'] as int;
    return Container(
      margin: EdgeInsets.only(left: d * 18.0, top: 3.0, bottom: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: vis
            ? _wiLight.withValues(alpha: 0.6)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6.0),
        border: Border(
          left: BorderSide(
            color: vis ? _wiAccent : Colors.grey.shade300,
            width: vis ? 3.0 : 1.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            vis ? Icons.check_box_outlined : Icons.disabled_by_default_outlined,
            size: 16.0,
            color: vis ? _wiPrimary : Colors.grey,
          ),
          const SizedBox(width: 8.0),
          Text(
            node['name'] as String,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: vis ? _wiDark : Colors.grey.shade500,
              decoration: vis ? null : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  final treeSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _wiPrimary.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DevTools Widget Tree Preview',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: _wiDark,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Nodes inside a disabled scope appear struck-through and grey '
          'in the inspector.  They are still rendered but the inspector '
          'will not select or highlight them.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10.0),
        for (final n in treeNodes) wiTreeNode(n),
      ],
    ),
  );

  // ================================================================
  // SECTION 7 — The `of` static look-up flow
  // ================================================================
  print('=== Section 7: of() static look-up flow ===');

  final lookupSteps = <Map<String, String>>[
    {
      'step': '1',
      'title': 'Caller invokes of(context)',
      'detail':
          'Any widget that needs to know whether the inspector is active '
          'calls EnableWidgetInspectorScope.of(context).',
    },
    {
      'step': '2',
      'title': 'Framework walks ancestors',
      'detail':
          'The InheritedWidget mechanism walks up the element tree '
          'until it finds the nearest EnableWidgetInspectorScope.',
    },
    {
      'step': '3',
      'title': 'enable flag returned',
      'detail':
          'The boolean value of the found scope is returned.  If no '
          'scope exists, the convention is to return true (inspect '
          'everything by default).',
    },
    {
      'step': '4',
      'title': 'Widget decides behavior',
      'detail':
          'Based on the returned value, the inspector overlay either '
          'renders selection rectangles and layout guides, or skips '
          'the subtree entirely.',
    },
  ];

  Widget wiStepRow(Map<String, String> s, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _wiPrimary,
              ),
              child: Center(
                child: Text(
                  s['step']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2.0,
                height: 40.0,
                color: _wiAccent.withValues(alpha: 0.3),
              ),
          ],
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _wiLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s['title']!,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: _wiDark,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  s['detail']!,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  final lookupSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _wiPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EnableWidgetInspectorScope.of(context) — look-up flow',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: _wiDark,
          ),
        ),
        const SizedBox(height: 12.0),
        for (int i = 0; i < lookupSteps.length; i++)
          wiStepRow(lookupSteps[i], i == lookupSteps.length - 1),
      ],
    ),
  );

  // ================================================================
  // SECTION 8 — Inspector overlay simulation
  // ================================================================
  print('=== Section 8: Inspector overlay simulation ===');

  Widget wiOverlayBox({
    required String widgetName,
    required bool highlighted,
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: highlighted
            ? _wiHighlight.withValues(alpha: 0.15)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: highlighted ? _wiAccent : Colors.grey.shade300,
          width: highlighted ? 2.5 : 1.0,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              widgetName,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w500,
                color: highlighted ? _wiPrimary : Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (highlighted)
            Positioned(
              top: 2.0,
              right: 4.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 1.0,
                ),
                decoration: BoxDecoration(
                  color: _wiAccent,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: const Text(
                  '🔍',
                  style: TextStyle(fontSize: 9.0),
                ),
              ),
            ),
        ],
      ),
    );
  }

  final overlaySection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _wiPrimary.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inspector overlay — enabled vs disabled region',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: _wiDark,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Blue-bordered widgets are selected by the inspector.  Grey '
          'widgets live inside a disabled scope and cannot be selected.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        // Top row: inspectable
        Row(
          children: [
            wiOverlayBox(
              widgetName: 'AppBar',
              highlighted: true,
              width: 80.0,
              height: 50.0,
            ),
            Expanded(
              child: wiOverlayBox(
                widgetName: 'Title',
                highlighted: true,
                width: double.infinity,
                height: 50.0,
              ),
            ),
            wiOverlayBox(
              widgetName: 'Actions',
              highlighted: true,
              width: 80.0,
              height: 50.0,
            ),
          ],
        ),
        // Middle: mixed
        Row(
          children: [
            Expanded(
              flex: 2,
              child: wiOverlayBox(
                widgetName: 'Content Card\n(inspectable)',
                highlighted: true,
                width: double.infinity,
                height: 70.0,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  wiOverlayBox(
                    widgetName: 'FPS\n(hidden)',
                    highlighted: false,
                    width: double.infinity,
                    height: 32.0,
                  ),
                  wiOverlayBox(
                    widgetName: 'Mem\n(hidden)',
                    highlighted: false,
                    width: double.infinity,
                    height: 32.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        // Bottom row: inspectable
        Row(
          children: [
            Expanded(
              child: wiOverlayBox(
                widgetName: 'BottomNavigationBar',
                highlighted: true,
                width: double.infinity,
                height: 44.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ================================================================
  // SECTION 9 — updateShouldNotify behavior
  // ================================================================
  print('=== Section 9: updateShouldNotify behavior ===');

  final notifyScenarios = <Map<String, dynamic>>[
    {
      'old': true,
      'new_val': true,
      'notifies': false,
      'explanation': 'Same value — no rebuild triggered.',
    },
    {
      'old': false,
      'new_val': false,
      'notifies': false,
      'explanation': 'Same value — no rebuild triggered.',
    },
    {
      'old': true,
      'new_val': false,
      'notifies': true,
      'explanation':
          'Changed from enabled to disabled — all dependent widgets '
          'rebuild so the inspector retracts from this subtree.',
    },
    {
      'old': false,
      'new_val': true,
      'notifies': true,
      'explanation':
          'Changed from disabled to enabled — dependents rebuild so '
          'the inspector starts covering this subtree again.',
    },
  ];

  Widget wiNotifyRow(Map<String, dynamic> s) {
    final triggers = s['notifies'] as bool;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: triggers ? _wiLight : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: triggers
              ? _wiAccent.withValues(alpha: 0.4)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          // Old value chip
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: (s['old'] as bool)
                  ? _wiAccent.withValues(alpha: 0.15)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              '${s['old']}',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: (s['old'] as bool) ? _wiAccent : Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.arrow_forward,
              size: 16.0,
              color: Colors.grey.shade500,
            ),
          ),
          // New value chip
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: (s['new_val'] as bool)
                  ? _wiAccent.withValues(alpha: 0.15)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              '${s['new_val']}',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: (s['new_val'] as bool) ? _wiAccent : Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Icon(
            triggers ? Icons.sync : Icons.block,
            size: 18.0,
            color: triggers ? _wiPrimary : Colors.grey,
          ),
          const SizedBox(width: 6.0),
          Expanded(
            child: Text(
              s['explanation'] as String,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final notifySection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _wiPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'updateShouldNotify(oldWidget) results',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: _wiDark,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Rebuilds only happen when the boolean enable flag actually '
          'changes.  This keeps the cost of the scope nearly zero '
          'during normal operation.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10.0),
        for (final s in notifyScenarios) wiNotifyRow(s),
      ],
    ),
  );

  // ================================================================
  // SECTION 10 — Performance characteristics
  // ================================================================
  print('=== Section 10: Performance characteristics ===');

  final perfPoints = <Map<String, String>>[
    {
      'metric': 'InheritedWidget look-up',
      'value': 'O(1) hash-map',
      'note':
          'The of() call is a constant-time look-up via the element\'s '
          'inherited widget map — not a tree walk.',
    },
    {
      'metric': 'Rebuild scope',
      'value': 'Subtree only',
      'note':
          'When enable changes, only widgets that called of() rebuild. '
          'Sibling branches and ancestors are unaffected.',
    },
    {
      'metric': 'Memory overhead',
      'value': '~24 bytes',
      'note':
          'One extra InheritedElement and Widget object in the element '
          'tree.  Negligible even with many scopes.',
    },
    {
      'metric': 'Release build impact',
      'value': 'None',
      'note':
          'The inspector is entirely compiled out in release mode, so '
          'the scope widget becomes a no-op pass-through.',
    },
  ];

  Widget wiPerfRow(Map<String, String> p) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: _wiLight.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: _wiPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              p['metric']!,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _wiDark,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: _wiAccent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              p['value']!,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: _wiAccent,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              p['note']!,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final perfSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _wiPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance characteristics',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: _wiDark,
          ),
        ),
        const SizedBox(height: 10.0),
        for (final p in perfPoints) wiPerfRow(p),
      ],
    ),
  );

  // ================================================================
  // SECTION 11 — Common patterns & best practices
  // ================================================================
  print('=== Section 11: Common patterns & best practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Wrap debug overlays at the overlay entry level',
      'icon': Icons.layers,
      'color': _wiAccent,
      'detail':
          'Place the disabled scope as high as possible — directly '
          'around the OverlayEntry widget for FPS counters, repaint '
          'rainbows, and memory graphs.  This ensures every child '
          'inside is excluded.',
    },
    {
      'title': 'Avoid disabling at the root',
      'icon': Icons.do_not_disturb_alt,
      'color': _wiMuted,
      'detail':
          'Disabling at the very root of the app makes the entire tree '
          'invisible to DevTools.  Use targeted scopes on specific '
          'subtrees instead.',
    },
    {
      'title': 'Re-enable for diagnostic subsections',
      'icon': Icons.refresh,
      'color': _wiPrimary,
      'detail':
          'If a disabled region contains one subsection you do want '
          'inspectable, wrap that subsection with enable=true.  The '
          'innermost scope wins.',
    },
    {
      'title': 'Document why a scope is disabled',
      'icon': Icons.note_alt_outlined,
      'color': _wiDark,
      'detail':
          'A disabled scope hides widgets.  Always add a comment '
          'explaining why — otherwise future developers may wonder '
          'why part of the UI is invisible in DevTools.',
    },
    {
      'title': 'Test with and without the scope',
      'icon': Icons.toggle_on,
      'color': Colors.teal,
      'detail':
          'In integration tests, temporarily remove the scope to '
          'confirm the underlying widgets are healthy.  The scope '
          'should only affect DevTools visibility, not rendering.',
    },
  ];

  Widget wiPracticeCard(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: (p['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(
          left: BorderSide(
            color: p['color'] as Color,
            width: 4.0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            p['icon'] as IconData,
            color: p['color'] as Color,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p['title'] as String,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: _wiDark,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  p['detail'] as String,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade700,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final practicesSection = Column(
    children: [for (final p in practices) wiPracticeCard(p)],
  );

  // ================================================================
  // SECTION 12 — Comparison: InheritedWidget vs other scope patterns
  // ================================================================
  print('=== Section 12: InheritedWidget comparison ===');

  final comparisons = <Map<String, String>>[
    {
      'pattern': 'EnableWidgetInspectorScope',
      'mechanism': 'InheritedWidget',
      'scope': 'Inspector visibility',
      'note': 'Single boolean, very lightweight',
    },
    {
      'pattern': 'MediaQuery',
      'mechanism': 'InheritedWidget',
      'scope': 'Screen metrics',
      'note': 'Carries MediaQueryData with many fields',
    },
    {
      'pattern': 'Theme',
      'mechanism': 'InheritedWidget',
      'scope': 'Visual styling',
      'note': 'Large ThemeData object',
    },
    {
      'pattern': 'Directionality',
      'mechanism': 'InheritedWidget',
      'scope': 'Text direction',
      'note': 'Single enum (LTR / RTL)',
    },
    {
      'pattern': 'DefaultTextStyle',
      'mechanism': 'InheritedWidget',
      'scope': 'Text defaults',
      'note': 'TextStyle + overflow + alignment',
    },
  ];

  Widget wiCompRow(Map<String, String> c, int index) {
    final highlight = c['pattern'] == 'EnableWidgetInspectorScope';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: highlight
            ? _wiLight
            : (index.isEven ? Colors.grey.shade50 : Colors.white),
        border: highlight
            ? Border.all(color: _wiAccent, width: 1.5)
            : null,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110.0,
            child: Text(
              c['pattern']!,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
                color: highlight ? _wiPrimary : _wiDark,
              ),
            ),
          ),
          SizedBox(
            width: 80.0,
            child: Text(
              c['scope']!,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
            ),
          ),
          Expanded(
            child: Text(
              c['note']!,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }

  final comparisonSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _wiPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'InheritedWidget scope patterns compared',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: _wiDark,
          ),
        ),
        const SizedBox(height: 10.0),
        for (int i = 0; i < comparisons.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: wiCompRow(comparisons[i], i),
          ),
      ],
    ),
  );

  // ================================================================
  // SECTION 13 — Summary
  // ================================================================
  print('=== Section 13: Summary ===');

  final summaryPoints = <String>[
    'EnableWidgetInspectorScope is a lightweight InheritedWidget carrying a single boolean.',
    'It controls whether the widget inspector highlights and lists child widgets.',
    'Wrapping debug overlays with enable=false keeps DevTools clean.',
    'A child scope can re-enable inspection inside a disabled parent scope.',
    'The of(context) static method is the standard way to query the flag.',
    'updateShouldNotify only fires when the boolean actually changes.',
    'In release mode the scope is a no-op — zero performance cost.',
    'Always document why a scope is disabled to avoid future confusion.',
  ];

  final summarySection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _wiPrimary.withValues(alpha: 0.08),
          _wiLight.withValues(alpha: 0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _wiPrimary.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: _wiPrimary, size: 24.0),
            const SizedBox(width: 10.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _wiDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        for (final pt in summaryPoints)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.only(top: 6.0, right: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _wiAccent,
                  ),
                ),
                Expanded(
                  child: Text(
                    pt,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: _wiDark,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  print('EnableWidgetInspectorScope deep demo complete');

  // ================================================================
  // FINAL ASSEMBLY
  // ================================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        wiBanner(),
        const SizedBox(height: 24.0),

        _wiSectionHeader('API Surface'),
        apiSection,
        const SizedBox(height: 24.0),

        _wiSectionHeader('Inspector Enabled vs Disabled'),
        scopeSection,
        const SizedBox(height: 24.0),

        _wiSectionHeader('Nested Scope Overrides'),
        nestingSection,
        const SizedBox(height: 24.0),

        _wiSectionHeader('Conditional Toggle Scenarios'),
        toggleSection,
        const SizedBox(height: 24.0),

        _wiSectionHeader('Widget Tree Inspection Preview'),
        treeSection,
        const SizedBox(height: 24.0),

        _wiSectionHeader('of(context) Look-up Flow'),
        lookupSection,
        const SizedBox(height: 24.0),

        _wiSectionHeader('Inspector Overlay Simulation'),
        overlaySection,
        const SizedBox(height: 24.0),

        _wiSectionHeader('updateShouldNotify Behavior'),
        notifySection,
        const SizedBox(height: 24.0),

        _wiSectionHeader('Performance Characteristics'),
        perfSection,
        const SizedBox(height: 24.0),

        _wiSectionHeader('Best Practices'),
        practicesSection,
        const SizedBox(height: 24.0),

        _wiSectionHeader('InheritedWidget Pattern Comparison'),
        comparisonSection,
        const SizedBox(height: 24.0),

        summarySection,
        const SizedBox(height: 32.0),
      ],
    ),
  );
}

// ─────────────────────── shared section header ────────────────────────
Widget _wiSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: _wiAccent,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: _wiDark,
          ),
        ),
      ],
    ),
  );
}

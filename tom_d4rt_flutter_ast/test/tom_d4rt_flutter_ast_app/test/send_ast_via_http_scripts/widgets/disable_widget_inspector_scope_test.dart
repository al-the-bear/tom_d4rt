// ignore_for_file: avoid_print
// Deep demo: DisableWidgetInspectorScope — an InheritedWidget that disables
// the widget inspector overlay for its descendant subtree, used to hide
// internal framework widgets from debug inspection tools.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Slate Graphite (#37474F) on Cool Gray (#ECEFF1)
// Prefix: _wi (widget inspector)
// ────────────────────────────────────────────────────────────

const Color _wiSlate = Color(0xFF37474F);
const Color _wiGray = Color(0xFFECEFF1);
const Color _wiDark = Color(0xFF263238);
const Color _wiLight = Color(0xFF546E7A);
const Color _wiMuted = Color(0xFF78909C);
const Color _wiAccent = Color(0xFF607D8B);
const Color _wiDivider = Color(0xFFB0BEC5);
const Color _wiWhite = Color(0xFFFFFFFF);
const Color _wiBlack = Color(0xFF212121);
const Color _wiError = Color(0xFFC62828);
const Color _wiSuccess = Color(0xFF2E7D32);
const Color _wiInfo = Color(0xFF0277BD);
const Color _wiWarning = Color(0xFFF57F17);

dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Banner ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_wiSlate, _wiDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _wiSlate.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility_off, color: _wiGray, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DisableWidgetInspectorScope',
                      style: TextStyle(
                        color: _wiGray,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'An InheritedWidget that tells the widget inspector to '
                'ignore its subtree — preventing internal framework '
                'widgets from appearing in DevTools inspection overlays.',
                style: TextStyle(
                  color: _wiGray.withValues(alpha: 0.9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _wiSection('1. What Is DisableWidgetInspectorScope?'),
        _wiBody(
          'The Flutter widget inspector (DevTools widget tree viewer) '
          'highlights widgets on screen when you hover them and shows '
          'their properties. However, some internal framework widgets '
          '(like default Material wrappers, theme containers, or overlay '
          'scaffolding) should not appear in inspection results because '
          'they add noise. DisableWidgetInspectorScope wraps a subtree '
          'to mark it as "not inspectable", hiding it from the overlay.',
        ),
        const SizedBox(height: 12),
        _wiInfoBox(
          'InheritedWidget Pattern',
          'DisableWidgetInspectorScope is an InheritedWidget, meaning '
          'descendant widgets can look up whether inspection is disabled '
          'by calling DisableWidgetInspectorScope.of(context). The scope '
          'propagates down the widget tree automatically.',
        ),
        const SizedBox(height: 24),

        // ── 2. Widget Inspector Overview ──
        _wiSection('2. Widget Inspector Overview'),
        _wiBody(
          'The Flutter widget inspector consists of several components '
          'that work together to enable interactive widget debugging:',
        ),
        const SizedBox(height: 12),
        _buildInspectorComponents(),
        const SizedBox(height: 24),

        // ── 3. How the Disable Scope Works ──
        _wiSection('3. How the Disable Scope Works'),
        _wiBody(
          'When enabled, the scope tells the inspector rendering '
          'layer to skip rendering highlight overlays on widgets '
          'within the scope\'s subtree:',
        ),
        const SizedBox(height: 12),
        _buildScopeWorkflow(),
        const SizedBox(height: 12),
        _wiCodeBlock(
          '// DisableWidgetInspectorScope usage\n'
          'class DisableWidgetInspectorScope\n'
          '    extends InheritedWidget {\n'
          '  const DisableWidgetInspectorScope({\n'
          '    super.key,\n'
          '    required this.disabled,\n'
          '    required super.child,\n'
          '  });\n'
          '\n'
          '  /// When true, inspector ignores this subtree\n'
          '  final bool disabled;\n'
          '\n'
          '  static bool shouldDisable(\n'
          '    BuildContext context,\n'
          '  ) {\n'
          '    final scope = context\n'
          '        .dependOnInheritedWidgetOfExactType<\n'
          '            DisableWidgetInspectorScope>();\n'
          '    return scope?.disabled ?? false;\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  bool updateShouldNotify(\n'
          '    DisableWidgetInspectorScope oldWidget,\n'
          '  ) => disabled != oldWidget.disabled;\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 4. Inspectable vs Non-Inspectable ──
        _wiSection('4. Inspectable vs Non-Inspectable Subtrees'),
        _wiBody(
          'A side-by-side comparison of how widgets appear in the '
          'inspector when the scope is enabled vs disabled:',
        ),
        const SizedBox(height: 12),
        _buildInspectableComparison(),
        const SizedBox(height: 24),

        // ── 5. Use Cases ──
        _wiSection('5. When to Use DisableWidgetInspectorScope'),
        _wiBody(
          'Several scenarios benefit from hiding widgets from the '
          'inspector:',
        ),
        const SizedBox(height: 12),
        _buildUseCases(),
        const SizedBox(height: 24),

        // ── 6. Widget Tree Filtering ──
        _wiSection('6. Widget Tree Depth Filtering'),
        _wiBody(
          'Without the disable scope, the widget tree can become very '
          'deep with internal wrappers. The scope cleans up the tree '
          'view for developers:',
        ),
        const SizedBox(height: 12),
        _buildTreeFilterDemo(),
        const SizedBox(height: 24),

        // ── 7. Nested Scopes ──
        _wiSection('7. Nested Scope Behavior'),
        _wiBody(
          'Scopes can be nested. An inner scope can re-enable '
          'inspection even if an outer scope has disabled it:',
        ),
        const SizedBox(height: 12),
        _buildNestedScopes(),
        const SizedBox(height: 24),

        // ── 8. Comparison with EnableWidgetInspectorScope ──
        _wiSection('8. Disable vs Enable Scope'),
        _wiBody(
          'Flutter provides both DisableWidgetInspectorScope and '
          'EnableWidgetInspectorScope as complementary tools:',
        ),
        const SizedBox(height: 12),
        _buildDisableVsEnable(),
        const SizedBox(height: 24),

        // ── 9. Build Mode Awareness ──
        _wiSection('9. Build Mode Awareness'),
        _wiBody(
          'The widget inspector only operates in debug mode. In '
          'profile and release builds, the scope is effectively a '
          'no-op since the inspector is not active:',
        ),
        const SizedBox(height: 12),
        _buildBuildModes(),
        const SizedBox(height: 24),

        // ── 10. DevTools Integration ──
        _wiSection('10. DevTools Integration'),
        _wiBody(
          'The scope affects how widgets appear in the Flutter '
          'DevTools widget tree panel, not just the on-screen '
          'overlay:',
        ),
        const SizedBox(height: 12),
        _buildDevToolsIntegration(),
        const SizedBox(height: 24),

        // ── 11. Framework Internals ──
        _wiSection('11. Framework Widgets That Use This'),
        _wiBody(
          'Several built-in Flutter widgets wrap their internal '
          'structure in DisableWidgetInspectorScope to keep the '
          'developer-facing tree clean:',
        ),
        const SizedBox(height: 12),
        _buildFrameworkUsers(),
        const SizedBox(height: 24),

        // ── 12. Screenshot Tool Scenario ──
        _wiSection('12. Screenshot Tool Scenario'),
        _wiBody(
          'Building a screenshot tool that needs to capture widgets '
          'without inspector overlays interfering:',
        ),
        const SizedBox(height: 12),
        _buildScreenshotScenario(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _wiSlate.withValues(alpha: 0.08),
                _wiGray,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _wiSlate.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _wiSlate, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _wiSlate,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _wiSummaryRow('Type', 'InheritedWidget'),
              _wiSummaryRow('Purpose', 'Hide subtree from widget inspector'),
              _wiSummaryRow('Property', 'disabled (bool)'),
              _wiSummaryRow('Nesting', 'Inner scopes override outer scopes'),
              _wiSummaryRow('Build Mode', 'Only effective in debug mode'),
              _wiSummaryRow('Counterpart', 'EnableWidgetInspectorScope'),
              _wiSummaryRow('Used By', 'Framework internals, custom widgets'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _wiSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _wiSlate,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _wiBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _wiBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _wiCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wiDark,
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFB0BEC5),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _wiInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wiInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wiInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _wiInfo, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _wiInfo,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: _wiBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _wiSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: TextStyle(
              color: _wiMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _wiBlack,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ─── Builder Functions ───────────────────────────────────────

Widget _buildInspectorComponents() {
  final components = <Map<String, dynamic>>[
    {
      'name': 'Select Widget Mode',
      'desc': 'Tap a widget on screen to select it in the tree',
      'icon': Icons.touch_app,
      'color': _wiSlate,
    },
    {
      'name': 'Highlight Overlay',
      'desc': 'Blue box around the selected widget\'s bounds',
      'icon': Icons.crop_square,
      'color': _wiInfo,
    },
    {
      'name': 'Widget Tree Panel',
      'desc': 'Hierarchical tree view in DevTools',
      'icon': Icons.account_tree,
      'color': _wiLight,
    },
    {
      'name': 'Detail Panel',
      'desc': 'Properties, render object, and constraints',
      'icon': Icons.list_alt,
      'color': _wiAccent,
    },
    {
      'name': 'Layout Explorer',
      'desc': 'Visual layout constraint visualization',
      'icon': Icons.grid_on,
      'color': _wiMuted,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < components.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (components[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (components[i]['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(components[i]['icon'] as IconData,
                  color: components[i]['color'] as Color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      components[i]['name'] as String,
                      style: TextStyle(
                        color: components[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      components[i]['desc'] as String,
                      style: TextStyle(
                        color: _wiBlack, fontSize: 12, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < components.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildScopeWorkflow() {
  final steps = <Map<String, String>>[
    {
      'step': 'Widget tree is built',
      'detail': 'Some widgets are wrapped in DisableWidgetInspectorScope',
    },
    {
      'step': 'Inspector activates (select mode)',
      'detail': 'User enables widget selection in DevTools',
    },
    {
      'step': 'Hit test at tap location',
      'detail': 'Inspector finds which render objects are at the tap point',
    },
    {
      'step': 'Walk up element tree',
      'detail': 'For each element, check for DisableWidgetInspectorScope ancestor',
    },
    {
      'step': 'Skip disabled subtrees',
      'detail': 'If scope.disabled is true, skip to next candidate outside scope',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wiGray,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wiDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _wiSlate,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _wiWhite,
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
                      steps[i]['step']!,
                      style: TextStyle(
                        color: _wiDark,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      steps[i]['detail']!,
                      style: TextStyle(color: _wiMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 4, bottom: 4),
              child: Container(width: 2, height: 10, color: _wiDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildInspectableComparison() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Inspectable side
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _wiSuccess.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _wiSuccess.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility, color: _wiSuccess, size: 18),
                  const SizedBox(width: 6),
                  Text('Inspectable (default)',
                      style: TextStyle(
                        color: _wiSuccess,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              const SizedBox(height: 10),
              _buildMiniWidgetTree([
                _TreeItem('MaterialApp', 0, true),
                _TreeItem('Scaffold', 1, true),
                _TreeItem('_BodyBuilder', 2, true),
                _TreeItem('SafeArea', 3, true),
                _TreeItem('Padding', 4, true),
                _TreeItem('Column', 5, true),
                _TreeItem('Text("Hello")', 6, true),
              ]),
              const SizedBox(height: 8),
              Text(
                'All widgets visible in inspector — '
                'includes internal wrappers',
                style: TextStyle(color: _wiMuted, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      // Non-inspectable side
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _wiSlate.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _wiSlate.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility_off, color: _wiSlate, size: 18),
                  const SizedBox(width: 6),
                  Text('With Disable Scope',
                      style: TextStyle(
                        color: _wiSlate,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              const SizedBox(height: 10),
              _buildMiniWidgetTree([
                _TreeItem('MaterialApp', 0, true),
                _TreeItem('Scaffold', 1, true),
                _TreeItem('_BodyBuilder', 2, false),
                _TreeItem('SafeArea', 3, false),
                _TreeItem('Padding', 4, false),
                _TreeItem('Column', 5, true),
                _TreeItem('Text("Hello")', 6, true),
              ]),
              const SizedBox(height: 8),
              Text(
                'Internal wrappers hidden — '
                'cleaner tree for debugging',
                style: TextStyle(color: _wiMuted, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildMiniWidgetTree(List<_TreeItem> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var item in items)
        Padding(
          padding: EdgeInsets.only(left: item.indent * 10.0, bottom: 2),
          child: Row(
            children: [
              Icon(
                item.visible ? Icons.widgets : Icons.visibility_off,
                size: 12,
                color: item.visible ? _wiSlate : _wiDivider,
              ),
              const SizedBox(width: 4),
              Text(
                item.name,
                style: TextStyle(
                  color: item.visible ? _wiBlack : _wiDivider,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: item.visible
                      ? FontWeight.normal
                      : FontWeight.w300,
                  decoration: item.visible
                      ? null
                      : TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildUseCases() {
  final cases = <Map<String, dynamic>>[
    {
      'title': 'Framework Internals',
      'desc': 'Material/Cupertino widget trees have internal wrappers '
          'that add noise to the inspector. Wrapping them in the '
          'disable scope keeps the tree view focused on user widgets.',
      'icon': Icons.build,
      'color': _wiSlate,
    },
    {
      'title': 'Screenshot & Testing Tools',
      'desc': 'Automated screenshot tools need clean renders without '
          'inspector overlays. The scope ensures captures are clean '
          'even when the inspector is accidentally active.',
      'icon': Icons.screenshot,
      'color': _wiInfo,
    },
    {
      'title': 'Custom Widget Libraries',
      'desc': 'Package authors wrap their internal implementation '
          'details so consumers only see the public widget API '
          'in the inspector tree.',
      'icon': Icons.library_books,
      'color': _wiAccent,
    },
    {
      'title': 'Overlay & Portal Widgets',
      'desc': 'Overlay entries and portal content use the scope '
          'to prevent confusing extra entries in the tree view '
          'that represent positioning scaffolding.',
      'icon': Icons.layers,
      'color': _wiLight,
    },
    {
      'title': 'Theming Infrastructure',
      'desc': 'Theme containers, DefaultTextStyle wrappers, and '
          'IconTheme providers are often hidden since they are '
          'implicit rather than explicitly placed by developers.',
      'icon': Icons.palette,
      'color': _wiMuted,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < cases.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: (cases[i]['color'] as Color).withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (cases[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(cases[i]['icon'] as IconData,
                  color: cases[i]['color'] as Color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cases[i]['title'] as String,
                      style: TextStyle(
                        color: cases[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      cases[i]['desc'] as String,
                      style: TextStyle(
                        color: _wiBlack, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < cases.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildTreeFilterDemo() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wiGray,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wiDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Widget Tree Depth Comparison',
          style: TextStyle(
            color: _wiSlate, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Without scope
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _wiError.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _wiError.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber, color: _wiError, size: 16),
                  const SizedBox(width: 6),
                  Text('Without scope: 14 levels deep',
                      style: TextStyle(color: _wiError, fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'ElevatedButton \u2192 _ElevatedButtonWithIconChild \u2192 '
                'AnimatedBuilder \u2192 _InkResponseStateWidget \u2192 '
                'Material \u2192 _MaterialInterior \u2192 PhysicalShape \u2192 '
                '_ShapeBorderPaint \u2192 CustomPaint \u2192 _RawMaterialButton \u2192 '
                'ConstrainedBox \u2192 Padding \u2192 Center \u2192 '
                'Row \u2192 Icon + Text',
                style: TextStyle(
                  color: _wiBlack,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // With scope
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _wiSuccess.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _wiSuccess.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: _wiSuccess, size: 16),
                  const SizedBox(width: 6),
                  Text('With scope: 3 levels deep',
                      style: TextStyle(color: _wiSuccess, fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'ElevatedButton \u2192 Row \u2192 Icon + Text',
                style: TextStyle(
                  color: _wiBlack,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '11 internal nodes hidden — developer sees only meaningful widgets',
          style: TextStyle(color: _wiMuted, fontSize: 11,
              fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _buildNestedScopes() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wiGray,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wiDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nested Scope Priority',
          style: TextStyle(
            color: _wiSlate, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Outer scope
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _wiError.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _wiError.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DisableWidgetInspectorScope(disabled: true)',
                  style: TextStyle(color: _wiError, fontSize: 11,
                      fontFamily: 'monospace', fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('\u2022 WidgetA — HIDDEN',
                  style: TextStyle(color: _wiMuted, fontSize: 12)),
              Text('\u2022 WidgetB — HIDDEN',
                  style: TextStyle(color: _wiMuted, fontSize: 12)),
              const SizedBox(height: 8),
              // Inner scope re-enables
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _wiSuccess.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _wiSuccess.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DisableWidgetInspectorScope(disabled: false)',
                      style: TextStyle(
                        color: _wiSuccess,
                        fontSize: 11,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('\u2022 WidgetC — VISIBLE (re-enabled)',
                        style: TextStyle(color: _wiSuccess, fontSize: 12)),
                    Text('\u2022 WidgetD — VISIBLE (re-enabled)',
                        style: TextStyle(color: _wiSuccess, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('\u2022 WidgetE — HIDDEN',
                  style: TextStyle(color: _wiMuted, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Inner scopes always take precedence — the nearest '
          'ancestor scope determines visibility.',
          style: TextStyle(color: _wiMuted, fontSize: 11,
              fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _buildDisableVsEnable() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _wiError.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _wiError.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility_off, color: _wiError, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text('Disable Scope',
                        style: TextStyle(color: _wiError, fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('\u2022 Hides subtree from inspector',
                  style: TextStyle(color: _wiBlack, fontSize: 12)),
              Text('\u2022 Used by framework internals',
                  style: TextStyle(color: _wiBlack, fontSize: 12)),
              Text('\u2022 disabled: true prevents inspection',
                  style: TextStyle(color: _wiBlack, fontSize: 12)),
              Text('\u2022 Can be overridden by inner scope',
                  style: TextStyle(color: _wiBlack, fontSize: 12)),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _wiSuccess.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _wiSuccess.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility, color: _wiSuccess, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text('Enable Scope',
                        style: TextStyle(color: _wiSuccess, fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('\u2022 Re-enables inspection in subtree',
                  style: TextStyle(color: _wiBlack, fontSize: 12)),
              Text('\u2022 Counterpart to disable scope',
                  style: TextStyle(color: _wiBlack, fontSize: 12)),
              Text('\u2022 Opt specific widgets back in',
                  style: TextStyle(color: _wiBlack, fontSize: 12)),
              Text('\u2022 Used inside disabled ancestors',
                  style: TextStyle(color: _wiBlack, fontSize: 12)),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildBuildModes() {
  final modes = <Map<String, dynamic>>[
    {
      'mode': 'Debug',
      'inspector': 'Active',
      'scope': 'Effective — controls visibility',
      'icon': Icons.bug_report,
      'color': _wiWarning,
    },
    {
      'mode': 'Profile',
      'inspector': 'Limited',
      'scope': 'No-op — inspector overlay disabled',
      'icon': Icons.speed,
      'color': _wiInfo,
    },
    {
      'mode': 'Release',
      'inspector': 'Disabled',
      'scope': 'No-op — inspector fully removed',
      'icon': Icons.rocket_launch,
      'color': _wiSuccess,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < modes.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (modes[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (modes[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(modes[i]['icon'] as IconData,
                  color: modes[i]['color'] as Color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        modes[i]['mode'] as String,
                        style: TextStyle(
                          color: modes[i]['color'] as Color,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Inspector: ${modes[i]['inspector']}',
                            style: TextStyle(
                              color: _wiBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            modes[i]['scope'] as String,
                            style: TextStyle(
                              color: _wiMuted, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < modes.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildDevToolsIntegration() {
  final panels = <Map<String, dynamic>>[
    {
      'panel': 'Widget Tree',
      'effect': 'Filtered nodes appear grayed or hidden in tree hierarchy',
      'icon': Icons.account_tree,
    },
    {
      'panel': 'Select Widget Mode',
      'effect': 'Disabled widgets cannot be tapped for selection on screen',
      'icon': Icons.touch_app,
    },
    {
      'panel': 'Widget Details',
      'effect': 'Properties panel skips disabled scope internal widgets',
      'icon': Icons.article,
    },
    {
      'panel': 'Performance Overlay',
      'effect': 'Not affected — performance metrics still include all widgets',
      'icon': Icons.timeline,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < panels.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _wiGray,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _wiDivider),
          ),
          child: Row(
            children: [
              Icon(panels[i]['icon'] as IconData,
                  color: _wiSlate, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      panels[i]['panel'] as String,
                      style: TextStyle(
                        color: _wiDark,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      panels[i]['effect'] as String,
                      style: TextStyle(
                        color: _wiBlack, fontSize: 12, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < panels.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildFrameworkUsers() {
  final users = <Map<String, String>>[
    {'widget': 'Scaffold', 'reason': 'Hides internal body builder and layout wrappers'},
    {'widget': 'AppBar', 'reason': 'Hides flexible space bar internals'},
    {'widget': 'Material', 'reason': 'Hides ink splash and shape painting layers'},
    {'widget': 'Tooltip', 'reason': 'Hides overlay entry and positioning widgets'},
    {'widget': 'DropdownButton', 'reason': 'Hides internal menu route and popup scaffolding'},
    {'widget': 'NavigationBar', 'reason': 'Hides animation containers and icon wrappers'},
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _wiDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _wiSlate.withValues(alpha: 0.06),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('Widget', style: TextStyle(
                  color: _wiSlate, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 5,
                child: Text('What It Hides', style: TextStyle(
                  color: _wiSlate, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var user in users)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _wiDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(user['widget']!,
                      style: TextStyle(
                        color: _wiDark, fontSize: 12,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 5,
                  child: Text(user['reason']!,
                      style: TextStyle(color: _wiBlack, fontSize: 12)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildScreenshotScenario() {
  final steps = <Map<String, String>>[
    {
      'step': 'Wrap screenshot target',
      'detail': 'Place DisableWidgetInspectorScope around the area to capture',
    },
    {
      'step': 'Set disabled: true',
      'detail': 'Ensures inspector overlays will not render on this subtree',
    },
    {
      'step': 'Render to image',
      'detail': 'Use RepaintBoundary.toImage() to capture clean pixels',
    },
    {
      'step': 'Save screenshot',
      'detail': 'Write image bytes to file or clipboard',
    },
    {
      'step': 'Restore normal inspection',
      'detail': 'Remove scope or set disabled: false after capture',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _wiGray,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _wiDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.screenshot, color: _wiSlate, size: 20),
            const SizedBox(width: 8),
            Text(
              'Clean Screenshot Capture',
              style: TextStyle(
                color: _wiSlate,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _wiSlate.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _wiSlate,
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
                      steps[i]['step']!,
                      style: TextStyle(
                        color: _wiDark,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      steps[i]['detail']!,
                      style: TextStyle(
                        color: _wiBlack,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1) const SizedBox(height: 10),
        ],
        const SizedBox(height: 14),
        _wiCodeBlock(
          '// Screenshot with disabled inspector\n'
          'DisableWidgetInspectorScope(\n'
          '  disabled: true,\n'
          '  child: RepaintBoundary(\n'
          '    key: screenshotKey,\n'
          '    child: YourWidget(),\n'
          '  ),\n'
          ')\n'
          '\n'
          '// Later: capture without inspector artifacts\n'
          'final boundary = screenshotKey.currentContext!\n'
          '    .findRenderObject() as RenderRepaintBoundary;\n'
          'final image = await boundary.toImage(\n'
          '  pixelRatio: 3.0,\n'
          ');\n'
          'final bytes = await image.toByteData(\n'
          '  format: ImageByteFormat.png,\n'
          ');',
        ),
      ],
    ),
  );
}

// ─── Support Classes ──────────────────────────────────────────

class _TreeItem {
  const _TreeItem(this.name, this.indent, this.visible);
  final String name;
  final int indent;
  final bool visible;
}

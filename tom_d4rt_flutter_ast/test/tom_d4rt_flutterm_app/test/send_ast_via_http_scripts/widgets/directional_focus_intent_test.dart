// ignore_for_file: avoid_print
// Deep demo: DirectionalFocusIntent — an intent that describes the desire to
// move focus to the nearest focusable widget in a specific direction (up, down,
// left, right) using spatial focus traversal within a focus scope.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Midnight Navy (#1A237E) on Silver Dawn (#ECEFF1)
// Prefix: _df (directional focus)
// ────────────────────────────────────────────────────────────

const Color _dfNavy = Color(0xFF1A237E);
const Color _dfSilver = Color(0xFFECEFF1);
const Color _dfDarkNavy = Color(0xFF0D1642);
const Color _dfLightNavy = Color(0xFF283593);
const Color _dfMuted = Color(0xFF78909C);
const Color _dfAccent = Color(0xFF5C6BC0);
const Color _dfSurface = Color(0xFFE8EAF6);
const Color _dfDivider = Color(0xFFC5CAE9);
const Color _dfWhite = Color(0xFFFFFFFF);
const Color _dfBlack = Color(0xFF212121);
const Color _dfError = Color(0xFFC62828);
const Color _dfSuccess = Color(0xFF2E7D32);
const Color _dfInfo = Color(0xFF0277BD);
const Color _dfWarning = Color(0xFFF57F17);

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
              colors: [_dfNavy, _dfDarkNavy],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _dfNavy.withValues(alpha: 0.35),
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
                  Icon(Icons.control_camera, color: _dfSilver, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DirectionalFocusIntent',
                      style: TextStyle(
                        color: _dfSilver,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'An intent for moving keyboard focus to the nearest focusable '
                'widget in a given direction — enabling arrow-key navigation '
                'through UI layouts with spatial focus traversal.',
                style: TextStyle(
                  color: _dfSilver.withValues(alpha: 0.88),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _dfSection('1. What Is DirectionalFocusIntent?'),
        _dfBody(
          'DirectionalFocusIntent is part of Flutter\'s focus traversal '
          'system. It represents the user\'s desire to move keyboard focus '
          'from the currently focused widget to the nearest focusable '
          'widget in a specific spatial direction (up, down, left, or '
          'right). This is distinct from tab-order focus traversal — '
          'instead of following a linear order, directional focus uses '
          'the physical positions of widgets on screen to determine which '
          'widget should receive focus next.',
        ),
        const SizedBox(height: 12),
        _dfInfoBox(
          'Directional vs Sequential',
          'Sequential focus (Tab/Shift+Tab) follows a predefined order. '
          'Directional focus (arrow keys) uses spatial proximity — the '
          'nearest widget in the arrow direction gets focus. This is '
          'critical for grid layouts, TV remotes, and game controllers.',
        ),
        const SizedBox(height: 24),

        // ── 2. Focus Direction Enumeration ──
        _dfSection('2. Focus Directions'),
        _dfBody(
          'The TraversalDirection enum defines the four spatial directions '
          'in which focus can move:',
        ),
        const SizedBox(height: 12),
        _buildFocusDirectionGrid(),
        const SizedBox(height: 12),
        _dfCodeBlock(
          '// DirectionalFocusIntent construction\n'
          'class DirectionalFocusIntent extends Intent {\n'
          '  const DirectionalFocusIntent(\n'
          '    this.direction, {\n'
          '    this.ignoreTextFields = true,\n'
          '  });\n'
          '\n'
          '  /// The direction to move focus\n'
          '  final TraversalDirection direction;\n'
          '\n'
          '  /// Whether to skip text fields\n'
          '  final bool ignoreTextFields;\n'
          '}\n'
          '\n'
          '// Usage in Shortcuts widget\n'
          'Shortcuts(\n'
          '  shortcuts: {\n'
          '    LogicalKeySet(LogicalKeyboardKey.arrowUp):\n'
          '        const DirectionalFocusIntent(\n'
          '      TraversalDirection.up,\n'
          '    ),\n'
          '    LogicalKeySet(LogicalKeyboardKey.arrowDown):\n'
          '        const DirectionalFocusIntent(\n'
          '      TraversalDirection.down,\n'
          '    ),\n'
          '  },\n'
          '  child: ...,\n'
          ')',
        ),
        const SizedBox(height: 24),

        // ── 3. Spatial Algorithm ──
        _dfSection('3. Spatial Navigation Algorithm'),
        _dfBody(
          'The focus traversal policy uses geometry to find the nearest '
          'focusable widget in the requested direction. The algorithm '
          'considers widget rectangles, distances, and alignment:',
        ),
        const SizedBox(height: 12),
        _buildSpatialAlgorithmSteps(),
        const SizedBox(height: 12),
        _dfCodeBlock(
          '// Simplified directional focus algorithm\n'
          'FocusNode? findFocus(\n'
          '  FocusNode current,\n'
          '  TraversalDirection direction,\n'
          '  Iterable<FocusNode> candidates,\n'
          ') {\n'
          '  final currentRect = _getRect(current);\n'
          '  final filtered = candidates.where((c) {\n'
          '    final cRect = _getRect(c);\n'
          '    switch (direction) {\n'
          '      case TraversalDirection.up:\n'
          '        return cRect.bottom <= currentRect.top;\n'
          '      case TraversalDirection.down:\n'
          '        return cRect.top >= currentRect.bottom;\n'
          '      case TraversalDirection.left:\n'
          '        return cRect.right <= currentRect.left;\n'
          '      case TraversalDirection.right:\n'
          '        return cRect.left >= currentRect.right;\n'
          '    }\n'
          '  });\n'
          '  return _findNearest(\n'
          '    currentRect,\n'
          '    filtered,\n'
          '    direction,\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 4. Focus Scope ──
        _dfSection('4. Focus Scope Boundaries'),
        _dfBody(
          'Directional focus traversal is constrained by FocusScope '
          'boundaries. Focus cannot escape a scope unless the scope '
          'is configured to allow it:',
        ),
        const SizedBox(height: 12),
        _buildFocusScopeDiagram(),
        const SizedBox(height: 24),

        // ── 5. Traversal Policies ──
        _dfSection('5. Focus Traversal Policies'),
        _dfBody(
          'Different traversal policies control how the "nearest" widget '
          'is determined. The policy can be customized per subtree:',
        ),
        const SizedBox(height: 12),
        _buildTraversalPolicyTable(),
        const SizedBox(height: 24),

        // ── 6. Text Field Interaction ──
        _dfSection('6. Text Field Interaction'),
        _dfBody(
          'The ignoreTextFields property controls whether arrow key '
          'navigation should skip text fields (which use arrows for '
          'cursor movement) or include them in traversal:',
        ),
        const SizedBox(height: 12),
        _buildTextFieldInteraction(),
        const SizedBox(height: 24),

        // ── 7. Grid Layout Navigation ──
        _dfSection('7. Grid Layout Navigation'),
        _dfBody(
          'Directional focus is especially useful for grid layouts '
          'where spatial navigation feels natural — like a TV app '
          'or a dashboard:',
        ),
        const SizedBox(height: 12),
        _buildGridNavigationDemo(),
        const SizedBox(height: 12),
        _dfCodeBlock(
          '// Grid with directional focus\n'
          'FocusTraversalGroup(\n'
          '  policy: WidgetOrderTraversalPolicy(),\n'
          '  child: GridView.builder(\n'
          '    gridDelegate:\n'
          '        const SliverGridDelegateWithFixedCrossAxisCount(\n'
          '      crossAxisCount: 3,\n'
          '      mainAxisSpacing: 8,\n'
          '      crossAxisSpacing: 8,\n'
          '    ),\n'
          '    itemCount: 9,\n'
          '    itemBuilder: (context, index) {\n'
          '      return Focus(\n'
          '        child: Builder(\n'
          '          builder: (ctx) {\n'
          '            final focused =\n'
          '                Focus.of(ctx).hasFocus;\n'
          '            return Container(\n'
          '              decoration: BoxDecoration(\n'
          '                border: focused\n'
          '                    ? Border.all(\n'
          '                        color: Colors.blue,\n'
          '                        width: 3,\n'
          '                      )\n'
          '                    : null,\n'
          '              ),\n'
          '              child: Center(\n'
          '                child: Text("Item \$index"),\n'
          '              ),\n'
          '            );\n'
          '          },\n'
          '        ),\n'
          '      );\n'
          '    },\n'
          '  ),\n'
          ')',
        ),
        const SizedBox(height: 24),

        // ── 8. Action Handler ──
        _dfSection('8. Action Handler Implementation'),
        _dfBody(
          'The DirectionalFocusAction processes the intent by querying '
          'the focus traversal policy and requesting focus on the result:',
        ),
        const SizedBox(height: 12),
        _dfCodeBlock(
          '// DirectionalFocusAction handler\n'
          'class DirectionalFocusAction\n'
          '    extends Action<DirectionalFocusIntent> {\n'
          '  @override\n'
          '  void invoke(DirectionalFocusIntent intent) {\n'
          '    final focusNode =\n'
          '        primaryFocus ?? FocusManager\n'
          '            .instance.rootScope;\n'
          '    if (intent.ignoreTextFields &&\n'
          '        focusNode.context?.widget\n'
          '            is EditableText) {\n'
          '      return; // Let text field handle arrows\n'
          '    }\n'
          '    final scope =\n'
          '        focusNode.nearestScope ?? focusNode;\n'
          '    final policy = FocusTraversalGroup\n'
          '        .maybeOf(scope.context!);\n'
          '    final moved = policy?.inDirection(\n'
          '      focusNode,\n'
          '      intent.direction,\n'
          '    );\n'
          '    if (moved != true) {\n'
          '      // Could not move — at boundary\n'
          '      // Optionally wrap around or beep\n'
          '    }\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 9. Edge Cases ──
        _dfSection('9. Edge Cases & Boundary Behavior'),
        _dfBody(
          'Several edge cases affect directional focus behavior:',
        ),
        const SizedBox(height: 12),
        _buildEdgeCasesGrid(),
        const SizedBox(height: 24),

        // ── 10. Platform Differences ──
        _dfSection('10. Platform-Specific Behavior'),
        _dfBody(
          'Different platforms have distinct default behaviors for '
          'directional focus:',
        ),
        const SizedBox(height: 12),
        _buildPlatformFocusTable(),
        const SizedBox(height: 24),

        // ── 11. Accessibility ──
        _dfSection('11. Accessibility Integration'),
        _dfBody(
          'Directional focus is critical for accessibility — it enables '
          'keyboard-only and switch-access users to navigate the UI '
          'spatially:',
        ),
        const SizedBox(height: 12),
        _buildAccessibilityIntegration(),
        const SizedBox(height: 24),

        // ── 12. Dashboard Scenario ──
        _dfSection('12. Dashboard Navigation Scenario'),
        _dfBody(
          'Building a TV-style dashboard where arrow keys navigate '
          'between cards in a 2D grid layout:',
        ),
        const SizedBox(height: 12),
        _buildDashboardScenario(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _dfNavy.withValues(alpha: 0.08),
                _dfSilver,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _dfNavy.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _dfNavy, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _dfNavy,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _dfSummaryRow('Type', 'Intent for spatial focus traversal'),
              _dfSummaryRow('Directions', 'Up, Down, Left, Right'),
              _dfSummaryRow('Algorithm', 'Geometry-based nearest-neighbor'),
              _dfSummaryRow('Scope', 'Constrained by FocusScope boundaries'),
              _dfSummaryRow('Policies', 'WidgetOrder, ReadingOrder, custom'),
              _dfSummaryRow('Text Fields', 'Optionally skipped (ignoreTextFields)'),
              _dfSummaryRow('Use Cases', 'Grids, TV apps, dashboards, games'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _dfSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _dfNavy,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _dfBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _dfBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _dfCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFE0E0E0),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _dfInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dfInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dfInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _dfInfo, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _dfInfo,
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
            color: _dfBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _dfSummaryRow(String label, String value) {
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
              color: _dfMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _dfBlack,
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

Widget _buildFocusDirectionGrid() {
  final directions = <Map<String, dynamic>>[
    {
      'dir': 'TraversalDirection.up',
      'key': '\u2191 Arrow',
      'desc': 'Focus moves to nearest widget above',
      'icon': Icons.arrow_upward,
      'color': _dfNavy,
    },
    {
      'dir': 'TraversalDirection.down',
      'key': '\u2193 Arrow',
      'desc': 'Focus moves to nearest widget below',
      'icon': Icons.arrow_downward,
      'color': _dfLightNavy,
    },
    {
      'dir': 'TraversalDirection.left',
      'key': '\u2190 Arrow',
      'desc': 'Focus moves to nearest widget left',
      'icon': Icons.arrow_back,
      'color': _dfAccent,
    },
    {
      'dir': 'TraversalDirection.right',
      'key': '\u2192 Arrow',
      'desc': 'Focus moves to nearest widget right',
      'icon': Icons.arrow_forward,
      'color': _dfInfo,
    },
  ];

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      for (var d in directions)
        Container(
          width: 170,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: (d['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (d['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(d['icon'] as IconData,
                  color: d['color'] as Color, size: 28),
              const SizedBox(height: 8),
              Text(
                d['dir'] as String,
                style: TextStyle(
                  color: d['color'] as Color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                d['key'] as String,
                style: TextStyle(
                  color: _dfMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                d['desc'] as String,
                style: TextStyle(color: _dfBlack, fontSize: 12),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildSpatialAlgorithmSteps() {
  final steps = <Map<String, String>>[
    {
      'step': 'Get current focus rect',
      'detail': 'Determine the bounding rectangle of the focused widget',
    },
    {
      'step': 'Collect candidates',
      'detail': 'Find all focusable nodes in the same scope',
    },
    {
      'step': 'Filter by direction',
      'detail': 'Keep only candidates that lie in the requested direction',
    },
    {
      'step': 'Calculate distances',
      'detail': 'Measure distance from current rect to each candidate rect',
    },
    {
      'step': 'Apply alignment bias',
      'detail': 'Prefer candidates aligned on the perpendicular axis',
    },
    {
      'step': 'Select nearest',
      'detail': 'Return the candidate with the smallest weighted distance',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dfSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dfDivider),
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
                  color: _dfNavy,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _dfWhite,
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
                        color: _dfDarkNavy,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      steps[i]['detail']!,
                      style: TextStyle(color: _dfMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 4, bottom: 4),
              child: Container(width: 2, height: 10, color: _dfDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildFocusScopeDiagram() {
  final scopes = <Map<String, dynamic>>[
    {
      'label': 'Root Scope',
      'children': ['AppBar', 'Sidebar', 'Content Area'],
      'color': _dfNavy,
    },
    {
      'label': 'Content Scope',
      'children': ['Card 1', 'Card 2', 'Card 3'],
      'color': _dfAccent,
    },
    {
      'label': 'Dialog Scope (traps focus)',
      'children': ['Input Field', 'OK Button', 'Cancel Button'],
      'color': _dfError,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < scopes.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: (scopes[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (scopes[i]['color'] as Color).withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                scopes[i]['label'] as String,
                style: TextStyle(
                  color: scopes[i]['color'] as Color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  for (var child
                      in (scopes[i]['children'] as List<String>))
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: (scopes[i]['color'] as Color)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        child,
                        style: TextStyle(
                          color: scopes[i]['color'] as Color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        if (i < scopes.length - 1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Icon(Icons.arrow_downward,
                color: _dfDivider, size: 18),
          ),
      ],
    ],
  );
}

Widget _buildTraversalPolicyTable() {
  final policies = <List<String>>[
    ['WidgetOrderTraversalPolicy', 'Follow widget tree order', 'Default for most layouts'],
    ['ReadingOrderTraversalPolicy', 'Follow reading direction', 'LTR/RTL aware ordering'],
    ['OrderedTraversalPolicy', 'Explicit numeric order', 'FocusOrder annotations'],
    ['DirectionalFocusTraversalPolicyMixin', 'Geometry-based', 'Base for custom spatial'],
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dfDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _dfNavy.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text('Policy', style: TextStyle(
                  color: _dfNavy, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 4,
                child: Text('Strategy', style: TextStyle(
                  color: _dfNavy, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 4,
                child: Text('Use Case', style: TextStyle(
                  color: _dfNavy, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var row in policies)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _dfDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(row[0], style: TextStyle(
                    color: _dfDarkNavy, fontSize: 11,
                    fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 4,
                  child: Text(row[1], style: TextStyle(
                    color: _dfBlack, fontSize: 12)),
                ),
                Expanded(
                  flex: 4,
                  child: Text(row[2], style: TextStyle(
                    color: _dfMuted, fontSize: 12)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildTextFieldInteraction() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dfSuccess.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dfSuccess.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: _dfSuccess, size: 16),
                  const SizedBox(width: 6),
                  Text('ignoreTextFields: true',
                      style: TextStyle(
                        color: _dfSuccess,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      )),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Arrow keys are consumed by the text field for '
                'cursor movement. Focus stays in the field. '
                'This is the default behavior.',
                style: TextStyle(
                  color: _dfBlack, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dfWarning.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dfWarning.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber, color: _dfWarning, size: 16),
                  const SizedBox(width: 6),
                  Text('ignoreTextFields: false',
                      style: TextStyle(
                        color: _dfWarning,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      )),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Arrow keys navigate focus away from text field. '
                'User cannot use arrows for text cursor. '
                'Rarely desired.',
                style: TextStyle(
                  color: _dfBlack, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildGridNavigationDemo() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dfSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dfDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '3x3 Grid Focus Navigation',
          style: TextStyle(
            color: _dfNavy,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        for (var row = 0; row < 3; row++) ...[
          Row(
            children: [
              for (var col = 0; col < 3; col++) ...[
                Expanded(
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(
                      right: col < 2 ? 6 : 0,
                    ),
                    decoration: BoxDecoration(
                      color: (row == 1 && col == 1)
                          ? _dfNavy.withValues(alpha: 0.15)
                          : _dfWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: (row == 1 && col == 1)
                            ? _dfNavy
                            : _dfDivider,
                        width: (row == 1 && col == 1) ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${row * 3 + col + 1}',
                        style: TextStyle(
                          color: (row == 1 && col == 1)
                              ? _dfNavy
                              : _dfMuted,
                          fontSize: 16,
                          fontWeight: (row == 1 && col == 1)
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (row < 2) const SizedBox(height: 6),
        ],
        const SizedBox(height: 10),
        Text(
          'Cell 5 is focused. Arrow keys move to adjacent cells. '
          'Up \u2192 2, Down \u2192 8, Left \u2192 4, Right \u2192 6.',
          style: TextStyle(
            color: _dfMuted,
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _buildEdgeCasesGrid() {
  final cases = <Map<String, dynamic>>[
    {
      'case': 'No candidate in direction',
      'behavior': 'Focus stays on current widget, no movement',
      'icon': Icons.block,
      'color': _dfError,
    },
    {
      'case': 'Overlapping widgets',
      'behavior': 'Nearest center-to-center distance wins',
      'icon': Icons.layers,
      'color': _dfWarning,
    },
    {
      'case': 'Off-screen candidates',
      'behavior': 'Included if focusable, even if not visible',
      'icon': Icons.visibility_off,
      'color': _dfMuted,
    },
    {
      'case': 'Empty focus scope',
      'behavior': 'No navigation occurs, intent consumed silently',
      'icon': Icons.do_not_disturb,
      'color': _dfAccent,
    },
    {
      'case': 'Wrapped layout (e.g., Wrap)',
      'behavior': 'Spatial distances may skip visual rows',
      'icon': Icons.wrap_text,
      'color': _dfInfo,
    },
    {
      'case': 'Animated positions',
      'behavior': 'Uses current frame position for distance calc',
      'icon': Icons.animation,
      'color': _dfNavy,
    },
  ];

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      for (var c in cases)
        Container(
          width: 170,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (c['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (c['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(c['icon'] as IconData,
                      color: c['color'] as Color, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      c['case'] as String,
                      style: TextStyle(
                        color: c['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                c['behavior'] as String,
                style: TextStyle(
                  color: _dfBlack,
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildPlatformFocusTable() {
  final platforms = <Map<String, dynamic>>[
    {
      'platform': 'Desktop (all)',
      'behavior': 'Arrow keys move focus directionally by default',
      'icon': Icons.desktop_mac,
      'color': _dfNavy,
    },
    {
      'platform': 'Android TV / Fire TV',
      'behavior': 'D-pad maps directly to directional focus intents',
      'icon': Icons.tv,
      'color': _dfAccent,
    },
    {
      'platform': 'iOS / Android (mobile)',
      'behavior': 'No directional focus by default — touch-first',
      'icon': Icons.phone_android,
      'color': _dfMuted,
    },
    {
      'platform': 'Web',
      'behavior': 'Arrow focus depends on browser and context',
      'icon': Icons.public,
      'color': _dfInfo,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < platforms.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (platforms[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (platforms[i]['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(platforms[i]['icon'] as IconData,
                  color: platforms[i]['color'] as Color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      platforms[i]['platform'] as String,
                      style: TextStyle(
                        color: platforms[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      platforms[i]['behavior'] as String,
                      style: TextStyle(
                        color: _dfBlack, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < platforms.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildAccessibilityIntegration() {
  final features = <Map<String, dynamic>>[
    {
      'feature': 'Keyboard Navigation',
      'desc': 'Users who cannot use a mouse rely on arrow keys for '
          'spatial navigation between interactive elements',
      'icon': Icons.keyboard,
    },
    {
      'feature': 'Switch Access',
      'desc': 'Assistive devices that emit directional signals '
          'map to DirectionalFocusIntent automatically',
      'icon': Icons.accessibility,
    },
    {
      'feature': 'Focus Indicators',
      'desc': 'Visible focus rings must update when focus moves '
          'directionally to show the user where they are',
      'icon': Icons.radio_button_checked,
    },
    {
      'feature': 'Screen Reader Announcements',
      'desc': 'Focus changes trigger semantics announcements '
          'for the newly focused widget',
      'icon': Icons.record_voice_over,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < features.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _dfSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _dfDivider),
          ),
          child: Row(
            children: [
              Icon(features[i]['icon'] as IconData,
                  color: _dfNavy, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      features[i]['feature'] as String,
                      style: TextStyle(
                        color: _dfDarkNavy,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      features[i]['desc'] as String,
                      style: TextStyle(
                        color: _dfBlack, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < features.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildDashboardScenario() {
  final steps = <Map<String, String>>[
    {
      'step': 'Wrap dashboard in FocusTraversalGroup',
      'detail': 'Establishes a scope for directional navigation',
    },
    {
      'step': 'Give each card a Focus widget',
      'detail': 'Makes cards focusable with visual focus indicator',
    },
    {
      'step': 'Arrange in Grid layout',
      'detail': 'Spatial positions enable directional navigation',
    },
    {
      'step': 'Arrow keys navigate between cards',
      'detail': 'DirectionalFocusIntent finds nearest card in direction',
    },
    {
      'step': 'Enter/Space activates focused card',
      'detail': 'Separate ActivateIntent handles selection',
    },
    {
      'step': 'Popup traps focus in dialog scope',
      'detail': 'Arrows navigate within dialog until dismissed',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dfSurface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dfDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dashboard, color: _dfNavy, size: 20),
            const SizedBox(width: 8),
            Text(
              'TV-Style Dashboard Navigation',
              style: TextStyle(
                color: _dfNavy,
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
                  color: _dfNavy.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _dfNavy,
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
                        color: _dfDarkNavy,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      steps[i]['detail']!,
                      style: TextStyle(
                        color: _dfBlack,
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
      ],
    ),
  );
}

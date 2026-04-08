// ignore_for_file: avoid_print
// Deep demo: DragBoundaryDelegate — an abstract delegate that defines spatial
// boundaries for drag operations, controlling where draggable widgets can be
// moved and how they behave at boundary edges.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Copper Bronze (#BF360C) on Warm Sand (#FBE9E7)
// Prefix: _db (drag boundary)
// ────────────────────────────────────────────────────────────

const Color _dbCopper = Color(0xFFBF360C);
const Color _dbSand = Color(0xFFFBE9E7);
const Color _dbDark = Color(0xFF870000);
const Color _dbLight = Color(0xFFE64A19);
const Color _dbMuted = Color(0xFFFF8A65);
const Color _dbAccent = Color(0xFFD84315);
const Color _dbDivider = Color(0xFFFFCCBC);
const Color _dbWhite = Color(0xFFFFFFFF);
const Color _dbBlack = Color(0xFF212121);
const Color _dbError = Color(0xFFC62828);
const Color _dbInfo = Color(0xFF01579B);
const Color _dbWarning = Color(0xFFF57F17);
const Color _dbSuccess = Color(0xFF2E7D32);

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
              colors: [_dbCopper, _dbDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _dbCopper.withValues(alpha: 0.35),
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
                  Icon(Icons.drag_indicator, color: _dbSand, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DragBoundaryDelegate',
                      style: TextStyle(
                        color: _dbSand,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'An abstract delegate that defines the spatial boundaries '
                'and edge behavior for drag operations. Subclasses can '
                'implement clamping, snapping, elastic resistance, or '
                'custom boundary shapes for draggable widgets.',
                style: TextStyle(
                  color: _dbSand.withValues(alpha: 0.9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _dbSection('1. What Is DragBoundaryDelegate?'),
        _dbBody(
          'DragBoundaryDelegate is an abstract class that acts as a '
          'strategy pattern for constraining drag operations. When a '
          'user drags a widget, the delegate receives the proposed '
          'position and returns the allowed position, enabling fine '
          'control over movement boundaries.',
        ),
        const SizedBox(height: 12),
        _dbInfoBox(
          'Strategy Pattern for Drag Constraints',
          'Instead of hardcoding drag boundaries into each draggable '
          'widget, the delegate pattern allows swapping constraint '
          'strategies at runtime. A widget can switch between free '
          'movement, clamped boundaries, or snapping.',
        ),
        const SizedBox(height: 24),

        // ── 2. API Surface ──
        _dbSection('2. API Surface'),
        _dbBody('The delegate defines these core methods:'),
        const SizedBox(height: 12),
        _buildAPISurface(),
        const SizedBox(height: 24),

        // ── 3. Boundary Types ──
        _dbSection('3. Common Boundary Types'),
        _dbBody(
          'Different strategies for constraining drag movement:',
        ),
        const SizedBox(height: 12),
        _buildBoundaryTypes(),
        const SizedBox(height: 24),

        // ── 4. Clamped Boundary ──
        _dbSection('4. Clamped Boundary Implementation'),
        _dbBody(
          'The simplest boundary: clamp the drag position within a '
          'rectangular region:',
        ),
        const SizedBox(height: 12),
        _dbCodeBlock(
          '// Clamped drag boundary delegate\n'
          'class ClampedDragBoundary\n'
          '    extends DragBoundaryDelegate {\n'
          '  final Rect bounds;\n'
          '\n'
          '  ClampedDragBoundary(this.bounds);\n'
          '\n'
          '  @override\n'
          '  Offset constrainDrag(\n'
          '    Offset proposedPosition,\n'
          '    Size childSize,\n'
          '  ) {\n'
          '    final dx = proposedPosition.dx.clamp(\n'
          '      bounds.left,\n'
          '      bounds.right - childSize.width,\n'
          '    );\n'
          '    final dy = proposedPosition.dy.clamp(\n'
          '      bounds.top,\n'
          '      bounds.bottom - childSize.height,\n'
          '    );\n'
          '    return Offset(dx, dy);\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 5. Position Lifecycle ──
        _dbSection('5. Drag Position Lifecycle'),
        _dbBody(
          'How a drag position flows through the delegate during a '
          'drag gesture:',
        ),
        const SizedBox(height: 12),
        _buildPositionLifecycle(),
        const SizedBox(height: 24),

        // ── 6. Snapping Boundary ──
        _dbSection('6. Snapping Boundary Pattern'),
        _dbBody(
          'Snap the drag position to the nearest grid point:',
        ),
        const SizedBox(height: 12),
        _dbCodeBlock(
          '// Grid-snapping drag boundary\n'
          'class GridSnapBoundary\n'
          '    extends DragBoundaryDelegate {\n'
          '  final double gridSize;\n'
          '  final Rect bounds;\n'
          '\n'
          '  GridSnapBoundary({\n'
          '    required this.gridSize,\n'
          '    required this.bounds,\n'
          '  });\n'
          '\n'
          '  @override\n'
          '  Offset constrainDrag(\n'
          '    Offset proposed,\n'
          '    Size childSize,\n'
          '  ) {\n'
          '    // Snap to grid first\n'
          '    final snappedX =\n'
          '        (proposed.dx / gridSize).round()\n'
          '            * gridSize;\n'
          '    final snappedY =\n'
          '        (proposed.dy / gridSize).round()\n'
          '            * gridSize;\n'
          '    // Then clamp to bounds\n'
          '    final dx = snappedX.clamp(\n'
          '      bounds.left,\n'
          '      bounds.right - childSize.width,\n'
          '    );\n'
          '    final dy = snappedY.clamp(\n'
          '      bounds.top,\n'
          '      bounds.bottom - childSize.height,\n'
          '    );\n'
          '    return Offset(dx, dy);\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 7. Elastic Boundary ──
        _dbSection('7. Elastic Edge Behavior'),
        _dbBody(
          'An elastic boundary allows slight over-drag with resistance, '
          'then springs back:',
        ),
        const SizedBox(height: 12),
        _buildElasticBehavior(),
        const SizedBox(height: 24),

        // ── 8. Circular Boundary ──
        _dbSection('8. Circular Boundary Constraint'),
        _dbBody(
          'Constrain drag to a circular area — useful for joystick or '
          'radial controls:',
        ),
        const SizedBox(height: 12),
        _dbCodeBlock(
          '// Circular drag boundary\n'
          'class CircularDragBoundary\n'
          '    extends DragBoundaryDelegate {\n'
          '  final Offset center;\n'
          '  final double radius;\n'
          '\n'
          '  CircularDragBoundary({\n'
          '    required this.center,\n'
          '    required this.radius,\n'
          '  });\n'
          '\n'
          '  @override\n'
          '  Offset constrainDrag(\n'
          '    Offset proposed,\n'
          '    Size childSize,\n'
          '  ) {\n'
          '    final offset = proposed - center;\n'
          '    final distance = offset.distance;\n'
          '    if (distance <= radius) return proposed;\n'
          '    // Clamp to circle edge\n'
          '    final normalized = offset / distance;\n'
          '    return center +\n'
          '        normalized * radius;\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 9. Multi-Zone Boundaries ──
        _dbSection('9. Multi-Zone Drag Boundaries'),
        _dbBody(
          'A delegate that defines different behavior for different '
          'regions of the drag area:',
        ),
        const SizedBox(height: 12),
        _buildMultiZone(),
        const SizedBox(height: 24),

        // ── 10. Delegate Composition ──
        _dbSection('10. Composing Multiple Delegates'),
        _dbBody(
          'Chain multiple boundary delegates to combine constraints:',
        ),
        const SizedBox(height: 12),
        _dbCodeBlock(
          '// Composed drag boundary\n'
          'class ComposedDragBoundary\n'
          '    extends DragBoundaryDelegate {\n'
          '  final List<DragBoundaryDelegate>\n'
          '      delegates;\n'
          '\n'
          '  ComposedDragBoundary(this.delegates);\n'
          '\n'
          '  @override\n'
          '  Offset constrainDrag(\n'
          '    Offset proposed,\n'
          '    Size childSize,\n'
          '  ) {\n'
          '    var result = proposed;\n'
          '    for (final delegate in delegates) {\n'
          '      result = delegate.constrainDrag(\n'
          '        result, childSize,\n'
          '      );\n'
          '    }\n'
          '    return result;\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 11. Performance Considerations ──
        _dbSection('11. Performance Considerations'),
        _dbBody(
          'Since constrainDrag is called on every frame during a drag '
          'gesture (potentially 60+ times per second), the delegate '
          'implementation must be efficient:',
        ),
        const SizedBox(height: 12),
        _buildPerformanceGrid(),
        const SizedBox(height: 24),

        // ── 12. Integration with Draggable ──
        _dbSection('12. Integration with Draggable Widgets'),
        _dbBody(
          'How the delegate integrates with the Draggable / '
          'GestureDetector ecosystem:',
        ),
        const SizedBox(height: 12),
        _buildIntegrationFlow(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _dbCopper.withValues(alpha: 0.08),
                _dbSand,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: _dbCopper.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _dbCopper, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _dbCopper,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _dbSummaryRow('Type', 'Abstract delegate class'),
              _dbSummaryRow('Pattern', 'Strategy pattern for drag bounds'),
              _dbSummaryRow('Core Method', 'constrainDrag(offset, size)'),
              _dbSummaryRow('Implementations',
                  'Clamped, snapping, elastic, circular'),
              _dbSummaryRow('Composable', 'Yes — delegates can be chained'),
              _dbSummaryRow('Performance', 'Called per drag frame (~60Hz)'),
              _dbSummaryRow('Use Cases',
                  'Bounded panels, joysticks, grid editors'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _dbSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _dbCopper,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _dbBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _dbBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _dbCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF3E2723),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFFFCCBC),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _dbInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dbInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dbInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _dbInfo, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: _dbInfo,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: _dbBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _dbSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: TextStyle(
              color: _dbAccent,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _dbBlack,
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

Widget _buildAPISurface() {
  final methods = <Map<String, dynamic>>[
    {
      'name': 'constrainDrag',
      'sig': 'Offset constrainDrag(\n  Offset proposed, Size size)',
      'desc': 'Returns the allowed position given the proposed one. '
          'Called on every drag update frame.',
      'icon': Icons.compress,
      'color': _dbCopper,
    },
    {
      'name': 'onDragStart',
      'sig': 'void onDragStart(\n  Offset startPosition)',
      'desc': 'Called when drag begins. Initialize boundary state here.',
      'icon': Icons.play_arrow,
      'color': _dbAccent,
    },
    {
      'name': 'onDragEnd',
      'sig': 'void onDragEnd(\n  Offset finalPosition)',
      'desc': 'Called when drag ends. Clean up boundary state.',
      'icon': Icons.stop,
      'color': _dbLight,
    },
    {
      'name': 'shouldAcceptDrag',
      'sig': 'bool shouldAcceptDrag(\n  Offset startPosition)',
      'desc': 'Whether to accept the drag at all from this position.',
      'icon': Icons.check_circle_outline,
      'color': _dbSuccess,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < methods.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (methods[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (methods[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: methods[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(methods[i]['icon'] as IconData,
                    color: _dbWhite, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      methods[i]['name'] as String,
                      style: TextStyle(
                        color: methods[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      methods[i]['sig'] as String,
                      style: TextStyle(
                        color: _dbBlack,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      methods[i]['desc'] as String,
                      style: TextStyle(
                          color: _dbBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < methods.length - 1) const SizedBox(height: 8),
      ],
    ],
  );
}

Widget _buildBoundaryTypes() {
  final types = <Map<String, dynamic>>[
    {
      'type': 'Clamped',
      'desc': 'Hard stop at boundary edges',
      'icon': Icons.crop_square,
      'color': _dbCopper,
      'visual': 'Rect(0, 0, w, h)',
    },
    {
      'type': 'Snapping',
      'desc': 'Jumps to grid or anchor points',
      'icon': Icons.grid_on,
      'color': _dbAccent,
      'visual': 'snap(x, gridSize)',
    },
    {
      'type': 'Elastic',
      'desc': 'Resists then springs back',
      'icon': Icons.settings_ethernet,
      'color': _dbLight,
      'visual': 'resistance * overshoot',
    },
    {
      'type': 'Circular',
      'desc': 'Constrained within a radius',
      'icon': Icons.circle_outlined,
      'color': _dbInfo,
      'visual': 'dist(p, center) <= r',
    },
    {
      'type': 'Path-based',
      'desc': 'Constrained along a path/curve',
      'icon': Icons.timeline,
      'color': _dbWarning,
      'visual': 'nearestPointOnPath(p)',
    },
    {
      'type': 'Composite',
      'desc': 'Multiple constraints combined',
      'icon': Icons.layers,
      'color': _dbSuccess,
      'visual': 'chain(d1, d2, d3)',
    },
  ];

  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (var t in types)
        Container(
          width: 155,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (t['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (t['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(t['icon'] as IconData,
                      color: t['color'] as Color, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    t['type'] as String,
                    style: TextStyle(
                      color: t['color'] as Color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(t['desc'] as String,
                  style: TextStyle(color: _dbBlack, fontSize: 10)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _dbBlack.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  t['visual'] as String,
                  style: TextStyle(
                    color: _dbMuted,
                    fontSize: 9,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildPositionLifecycle() {
  final steps = <Map<String, dynamic>>[
    {
      'step': 'Finger / pointer down',
      'detail': 'shouldAcceptDrag(startPos) called',
      'icon': Icons.touch_app,
      'color': _dbMuted,
    },
    {
      'step': 'Drag gesture recognized',
      'detail': 'onDragStart(startPos) initializes delegate',
      'icon': Icons.play_arrow,
      'color': _dbAccent,
    },
    {
      'step': 'Frame N: pointer moved',
      'detail': 'constrainDrag(rawDelta + currentPos, size)',
      'icon': Icons.open_with,
      'color': _dbCopper,
    },
    {
      'step': 'Delegate returns adjusted position',
      'detail': 'Widget renders at constrained location',
      'icon': Icons.check,
      'color': _dbSuccess,
    },
    {
      'step': 'Repeat for each frame...',
      'detail': 'constrainDrag called ~60 times/sec',
      'icon': Icons.replay,
      'color': _dbLight,
    },
    {
      'step': 'Finger / pointer up',
      'detail': 'onDragEnd(finalPos) cleans up state',
      'icon': Icons.stop,
      'color': _dbError,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dbSand,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dbDivider),
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
                  color: steps[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(steps[i]['icon'] as IconData,
                    color: _dbWhite, size: 14),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['step'] as String,
                      style: TextStyle(
                        color: steps[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      steps[i]['detail'] as String,
                      style: TextStyle(
                          color: _dbBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Container(
                  width: 2, height: 8, color: _dbDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildElasticBehavior() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dbSand,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dbDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Elastic Over-Drag Resistance',
          style: TextStyle(
            color: _dbCopper, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Within bounds
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _dbSuccess.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _dbSuccess.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle,
                        color: _dbSuccess, size: 20),
                    const SizedBox(height: 4),
                    Text('Within Bounds',
                        style: TextStyle(color: _dbSuccess, fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('1:1 movement\nNo resistance',
                        style: TextStyle(color: _dbBlack, fontSize: 10),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            // At edge
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _dbWarning.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _dbWarning.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.warning_amber,
                        color: _dbWarning, size: 20),
                    const SizedBox(height: 4),
                    Text('Elastic Zone',
                        style: TextStyle(color: _dbWarning, fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Reduced speed\nResistance grows',
                        style: TextStyle(color: _dbBlack, fontSize: 10),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Beyond limit
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _dbError.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _dbError.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.block, color: _dbError, size: 20),
                    const SizedBox(height: 4),
                    Text('Hard Limit',
                        style: TextStyle(color: _dbError, fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('No further\nmovement',
                        style: TextStyle(color: _dbBlack, fontSize: 10),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _dbCodeBlock(
          '// Elastic boundary formula:\n'
          '// overshoot = proposed - boundaryEdge\n'
          '// elastic = overshoot * (1 / (1 + |overshoot| * factor))\n'
          '// result = boundaryEdge + elastic\n'
          '//\n'
          '// factor=0.01 => soft resistance\n'
          '// factor=0.1  => medium resistance\n'
          '// factor=1.0  => near-hard clamp',
        ),
      ],
    ),
  );
}

Widget _buildMultiZone() {
  final zones = <Map<String, dynamic>>[
    {
      'zone': 'Free Zone',
      'behavior': 'No constraints, 1:1 movement tracking',
      'color': _dbSuccess,
      'icon': Icons.open_with,
    },
    {
      'zone': 'Snap Zone',
      'behavior': 'Pulls toward dock/slot anchor points',
      'color': _dbInfo,
      'icon': Icons.grid_on,
    },
    {
      'zone': 'Resist Zone',
      'behavior': 'Elastic resistance near boundaries',
      'color': _dbWarning,
      'icon': Icons.settings_ethernet,
    },
    {
      'zone': 'Forbidden Zone',
      'behavior': 'Cannot enter; position clamped at edge',
      'color': _dbError,
      'icon': Icons.block,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dbSand,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dbDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Zone-Based Drag Boundaries',
          style: TextStyle(
            color: _dbCopper, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < zones.length; i++) ...[
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: zones[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(zones[i]['icon'] as IconData,
                    color: _dbWhite, size: 14),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      zones[i]['zone'] as String,
                      style: TextStyle(
                        color: zones[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      zones[i]['behavior'] as String,
                      style: TextStyle(
                          color: _dbBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < zones.length - 1) const SizedBox(height: 6),
        ],
        const SizedBox(height: 10),
        Text(
          'The delegate checks which zone the proposed position falls '
          'into and applies the corresponding constraint strategy.',
          style: TextStyle(
            color: _dbMuted, fontSize: 11, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _buildPerformanceGrid() {
  final tips = <Map<String, dynamic>>[
    {
      'tip': 'Avoid allocations',
      'detail': 'Reuse Offset objects, avoid creating new lists/maps',
      'icon': Icons.memory,
      'color': _dbCopper,
    },
    {
      'tip': 'Precompute bounds',
      'detail': 'Calculate boundary rects in onDragStart, not per frame',
      'icon': Icons.speed,
      'color': _dbAccent,
    },
    {
      'tip': 'Simple math only',
      'detail': 'Use clamp, min/max; avoid complex path calculations',
      'icon': Icons.calculate,
      'color': _dbLight,
    },
    {
      'tip': 'Cache grid points',
      'detail': 'Pre-calculate snap targets, do not recompute every frame',
      'icon': Icons.grid_on,
      'color': _dbInfo,
    },
  ];

  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (var t in tips)
        Container(
          width: 160,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (t['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (t['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(t['icon'] as IconData,
                      color: t['color'] as Color, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      t['tip'] as String,
                      style: TextStyle(
                        color: t['color'] as Color,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                t['detail'] as String,
                style: TextStyle(color: _dbBlack, fontSize: 10, height: 1.3),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildIntegrationFlow() {
  final steps = <Map<String, dynamic>>[
    {
      'component': 'GestureDetector',
      'role': 'Captures pan/drag gestures from pointer events',
      'icon': Icons.touch_app,
      'color': _dbMuted,
    },
    {
      'component': 'DragBoundaryDelegate',
      'role': 'Constrains proposed position to valid bounds',
      'icon': Icons.crop_square,
      'color': _dbCopper,
    },
    {
      'component': 'Transform / Positioned',
      'role': 'Applies constrained offset to child widget',
      'icon': Icons.transform,
      'color': _dbAccent,
    },
    {
      'component': 'State Management',
      'role': 'Stores current position, triggers rebuild',
      'icon': Icons.data_object,
      'color': _dbInfo,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dbSand,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dbDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Drag → Delegate → Render Pipeline',
          style: TextStyle(
            color: _dbCopper, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: steps[i]['color'] as Color,
                  shape: BoxShape.circle,
                ),
                child: Icon(steps[i]['icon'] as IconData,
                    color: _dbWhite, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['component'] as String,
                      style: TextStyle(
                        color: steps[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      steps[i]['role'] as String,
                      style: TextStyle(
                          color: _dbBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Container(width: 2, height: 6, color: _dbDivider),
                  Icon(Icons.arrow_downward,
                      color: _dbDivider, size: 12),
                  Container(width: 2, height: 6, color: _dbDivider),
                ],
              ),
            ),
        ],
      ],
    ),
  );
}

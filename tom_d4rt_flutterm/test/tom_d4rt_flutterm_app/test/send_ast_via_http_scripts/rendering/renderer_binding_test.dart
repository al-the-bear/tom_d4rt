// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// RENDERER BINDING — Deep Demo
// ============================================================================
//
// RendererBinding is the singleton mixin-based binding that connects
// Flutter's rendering layer to the underlying engine. It is part of
// the binding hierarchy (ServicesBinding → GestureBinding →
// SchedulerBinding → PaintingBinding → SemanticsBinding →
// RendererBinding → WidgetsBinding) and is responsible for:
//
//   1. Creating and owning the root PipelineOwner and RenderView
//   2. Driving the rendering pipeline: layout → paint → compositing
//   3. Handling device metric changes (size, orientation, text scale)
//   4. Managing the semantics tree for accessibility
//   5. Providing the scheduleWarmUpFrame / drawFrame entry points
//
// In D4rt, scripts run inside an already-initialized binding, so we
// demonstrate RendererBinding's effects indirectly through the widgets
// and render objects it manages.
//
// Color theme : Steel (#71797E) / Pewter (#96A8A1)
// Helper prefix: _rb
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _rbSteel = Color(0xFF71797E);
const Color _rbPewter = Color(0xFF96A8A1);
const Color _rbLightSteel = Color(0xFFB0B7BC);
const Color _rbDarkSteel = Color(0xFF50565A);
const Color _rbOffWhite = Color(0xFFF5F5F0);
const Color _rbCharcoal = Color(0xFF3B3F42);
const Color _rbAccent = Color(0xFFD4A574);
const Color _rbMint = Color(0xFFA8D5BA);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _rbSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_rbSteel, _rbDarkSteel],
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
            letterSpacing: 0.5,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: const TextStyle(
                color: _rbLightSteel,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _rbInfoCard(String heading, String body, {IconData? icon}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _rbOffWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _rbPewter.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 2),
            child: Icon(icon, color: _rbSteel, size: 22),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  color: _rbDarkSteel,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: _rbCharcoal,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _rbCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _rbCharcoal,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _rbMint,
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.6,
      ),
    ),
  );
}

Widget _rbDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    height: 1,
    color: _rbPewter.withValues(alpha: 0.3),
  );
}

Widget _rbBadge(String label, Color bg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _rbPipelinePhaseBox(String phase, String description, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                phase,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: const TextStyle(
                  color: _rbCharcoal,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Binding Hierarchy Overview
// ---------------------------------------------------------------------------

Widget _rbSection1BindingHierarchy() {
  final List<Map<String, dynamic>> bindings = [
    {
      'name': 'GestureBinding',
      'role': 'Pointer event dispatch & hit testing',
      'icon': Icons.touch_app,
      'color': const Color(0xFF8E6DAF),
    },
    {
      'name': 'SchedulerBinding',
      'role': 'Frame scheduling, ticker management',
      'icon': Icons.schedule,
      'color': const Color(0xFF5B8FA8),
    },
    {
      'name': 'PaintingBinding',
      'role': 'Image caching, shader warm-up',
      'icon': Icons.brush,
      'color': const Color(0xFFA47551),
    },
    {
      'name': 'SemanticsBinding',
      'role': 'Accessibility tree management',
      'icon': Icons.accessibility_new,
      'color': const Color(0xFF6B9080),
    },
    {
      'name': 'RendererBinding',
      'role': 'Render tree, pipeline owner, drawFrame',
      'icon': Icons.layers,
      'color': _rbSteel,
    },
    {
      'name': 'WidgetsBinding',
      'role': 'Widget-to-element-to-render bridge',
      'icon': Icons.widgets,
      'color': const Color(0xFF7B8D6E),
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rbSectionHeader(
        '1. Binding Hierarchy',
        subtitle: 'Where RendererBinding fits in Flutter\'s initialization chain',
      ),
      const SizedBox(height: 12),
      _rbInfoCard(
        'The Binding Stack',
        'Flutter initializes bindings in a strict order via mixins on a '
            'single WidgetsFlutterBinding instance. RendererBinding sits near '
            'the top — it depends on SchedulerBinding (for frame callbacks) '
            'and PaintingBinding (for image decoding), and it provides the '
            'rendering pipeline that WidgetsBinding builds widgets upon.',
        icon: Icons.account_tree,
      ),
      const SizedBox(height: 8),
      ...bindings.map((b) {
        final bool isRenderer = b['name'] == 'RendererBinding';
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isRenderer ? _rbSteel.withValues(alpha: 0.1) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isRenderer ? _rbSteel : (b['color'] as Color).withValues(alpha: 0.3),
              width: isRenderer ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(b['icon'] as IconData, color: b['color'] as Color, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          b['name'] as String,
                          style: TextStyle(
                            fontWeight: isRenderer ? FontWeight.bold : FontWeight.w600,
                            fontSize: 13,
                            color: b['color'] as Color,
                          ),
                        ),
                        if (isRenderer) ...[
                          const SizedBox(width: 8),
                          _rbBadge('THIS DEMO', _rbSteel),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      b['role'] as String,
                      style: const TextStyle(fontSize: 11.5, color: _rbCharcoal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      const SizedBox(height: 8),
      _rbCodeBlock(
        '// Flutter creates one binding instance:\n'
        'class WidgetsFlutterBinding extends BindingBase\n'
        '    with GestureBinding, SchedulerBinding,\n'
        '         PaintingBinding, SemanticsBinding,\n'
        '         RendererBinding, WidgetsBinding {\n'
        '  // Each mixin calls initInstances() in order\n'
        '}',
      ),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Rendering Pipeline Phases
// ---------------------------------------------------------------------------

Widget _rbSection2RenderPipeline() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rbSectionHeader(
        '2. The Rendering Pipeline',
        subtitle: 'drawFrame() drives these phases every frame',
      ),
      const SizedBox(height: 12),
      _rbInfoCard(
        'Frame-by-Frame',
        'RendererBinding.drawFrame() is called from '
            'WidgetsBinding.drawFrame() (which first rebuilds dirty '
            'elements). It then executes the rendering pipeline in a '
            'strict sequence: layout → compositing bits update → '
            'paint → compositing → semantics update.',
        icon: Icons.repeat,
      ),
      const SizedBox(height: 8),
      _rbPipelinePhaseBox(
        'Phase 1: Layout',
        'Walks the render tree top-down. Each RenderObject that is '
            'marked dirty receives performLayout(). Parent passes '
            'constraints down, child reports size up.',
        Icons.straighten,
        const Color(0xFF4A90D9),
      ),
      // Arrow indicator
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: const Icon(Icons.arrow_downward, color: _rbLightSteel, size: 20),
        ),
      ),
      _rbPipelinePhaseBox(
        'Phase 2: Compositing Bits',
        'Marks whether each render object needs its own compositing '
            'layer. This determines the layer tree structure for GPU '
            'acceleration.',
        Icons.auto_awesome_mosaic,
        const Color(0xFF7B68AE),
      ),
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: const Icon(Icons.arrow_downward, color: _rbLightSteel, size: 20),
        ),
      ),
      _rbPipelinePhaseBox(
        'Phase 3: Paint',
        'Walks dirty render objects and calls paint(). Each object '
            'records painting commands into a Canvas within its layer.',
        Icons.format_paint,
        const Color(0xFFD4793A),
      ),
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: const Icon(Icons.arrow_downward, color: _rbLightSteel, size: 20),
        ),
      ),
      _rbPipelinePhaseBox(
        'Phase 4: Compositing',
        'Builds a Scene from the layer tree and submits it to the '
            'engine via FlutterView.render(). The GPU composites the '
            'layers.',
        Icons.view_in_ar,
        const Color(0xFF3D9970),
      ),
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: const Icon(Icons.arrow_downward, color: _rbLightSteel, size: 20),
        ),
      ),
      _rbPipelinePhaseBox(
        'Phase 5: Semantics',
        'Updates the semantics tree for screen readers and '
            'accessibility services. Runs only if semantics are '
            'enabled.',
        Icons.accessibility,
        const Color(0xFF8B6F47),
      ),
      const SizedBox(height: 12),
      _rbCodeBlock(
        '// Simplified drawFrame from RendererBinding:\n'
        'void drawFrame() {\n'
        '  pipelineOwner.flushLayout();\n'
        '  pipelineOwner.flushCompositingBits();\n'
        '  pipelineOwner.flushPaint();\n'
        '  renderView.compositeFrame();     // submit to engine\n'
        '  pipelineOwner.flushSemantics();  // if enabled\n'
        '}',
      ),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: PipelineOwner
// ---------------------------------------------------------------------------

Widget _rbSection3PipelineOwner() {
  final List<Map<String, String>> responsibilities = [
    {
      'title': 'Layout dirty list',
      'desc': 'Tracks render objects marked as needing layout. '
          'flushLayout() processes them in depth order.',
    },
    {
      'title': 'Paint dirty list',
      'desc': 'Tracks render objects marked as needing paint. '
          'flushPaint() processes them in reverse depth order.',
    },
    {
      'title': 'Semantics dirty list',
      'desc': 'Tracks render objects whose semantics changed. '
          'flushSemantics() processes them for accessibility.',
    },
    {
      'title': 'Compositing bits',
      'desc': 'Manages whether objects need their own layer. '
          'flushCompositingBits() resolves this.',
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rbSectionHeader(
        '3. PipelineOwner',
        subtitle: 'The conductor of the render pipeline',
      ),
      const SizedBox(height: 12),
      _rbInfoCard(
        'What is PipelineOwner?',
        'PipelineOwner manages the dirty lists for layout, paint, '
            'compositing bits, and semantics. RendererBinding creates '
            'the root PipelineOwner during initialization. Each '
            'RenderObject registers with the pipeline owner when it '
            'needs updating.',
        icon: Icons.hub,
      ),
      const SizedBox(height: 8),
      ...responsibilities.map((r) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _rbPewter.withValues(alpha: 0.4)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 5, right: 10),
              decoration: const BoxDecoration(
                color: _rbSteel,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: _rbDarkSteel,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    r['desc']!,
                    style: const TextStyle(fontSize: 12, color: _rbCharcoal, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
      const SizedBox(height: 8),
      _rbCodeBlock(
        '// When a RenderObject needs layout:\n'
        'void markNeedsLayout() {\n'
        '  _needsLayout = true;\n'
        '  // Adds self to PipelineOwner\'s dirty list\n'
        '  owner?._nodesNeedingLayout.add(this);\n'
        '  // Eventually triggers a new frame\n'
        '  owner?.requestVisualUpdate();\n'
        '}',
      ),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: RenderView — The Root Render Object
// ---------------------------------------------------------------------------

Widget _rbSection4RenderView() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rbSectionHeader(
        '4. RenderView — Root of the Render Tree',
        subtitle: 'RendererBinding creates and configures the RenderView',
      ),
      const SizedBox(height: 12),
      _rbInfoCard(
        'The Root',
        'RenderView is a special RenderObject that acts as the root '
            'of the entire render tree. RendererBinding creates it '
            'during initRenderView() and connects it to a FlutterView. '
            'RenderView has no parent — it receives the device pixel '
            'ratio and physical size directly from the engine.',
        icon: Icons.account_tree,
      ),
      const SizedBox(height: 8),
      // Visual: render tree structure
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _rbCharcoal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Render Tree Structure:',
              style: TextStyle(color: _rbAccent, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 10),
            _rbTreeNode('RenderView', 0, isRoot: true),
            _rbTreeNode('RenderSemanticsAnnotations', 1),
            _rbTreeNode('RenderRepaintBoundary', 2),
            _rbTreeNode('RenderCustomPaint', 3),
            _rbTreeNode('RenderDecoratedBox', 3),
            _rbTreeNode('RenderPositionedBox (Center)', 4),
            _rbTreeNode('RenderConstrainedBox', 5),
            _rbTreeNode('RenderParagraph', 6),
          ],
        ),
      ),
      const SizedBox(height: 10),
      _rbInfoCard(
        'RenderView responsibilities',
        '• Accepts tight constraints from the FlutterView (screen size)\n'
            '• Performs layout by passing constraints to its single child\n'
            '• Calls compositeFrame() to submit the final Scene\n'
            '• Stores the device pixel ratio for coordinate transforms',
        icon: Icons.checklist,
      ),
      const SizedBox(height: 8),
      _rbCodeBlock(
        '// RenderView setup inside RendererBinding:\n'
        'void initRenderView() {\n'
        '  renderView = RenderView(\n'
        '    view: platformDispatcher.implicitView!,\n'
        '  );\n'
        '  renderView.prepareInitialFrame();\n'
        '}',
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _rbTreeNode(String name, int depth, {bool isRoot = false}) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 18.0, top: 3, bottom: 3),
    child: Row(
      children: [
        if (depth > 0)
          Container(
            width: 12,
            height: 1,
            color: _rbPewter.withValues(alpha: 0.5),
            margin: const EdgeInsets.only(right: 6),
          ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isRoot ? _rbAccent : _rbMint,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(
            color: isRoot ? _rbAccent : _rbOffWhite,
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: isRoot ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: Device Metrics & handleMetricsChanged
// ---------------------------------------------------------------------------

Widget _rbSection5DeviceMetrics() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rbSectionHeader(
        '5. Device Metrics & handleMetricsChanged',
        subtitle: 'How RendererBinding responds to screen changes',
      ),
      const SizedBox(height: 12),
      _rbInfoCard(
        'Metric Callbacks',
        'When the device rotates, the window resizes, or the text '
            'scale factor changes, the engine notifies the binding. '
            'RendererBinding.handleMetricsChanged() marks the '
            'RenderView as needing layout, which triggers a full '
            'pipeline pass in the next frame.',
        icon: Icons.screen_rotation,
      ),
      const SizedBox(height: 8),
      // Visual: metric values display
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_rbSteel.withValues(alpha: 0.08), _rbPewter.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _rbPewter.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            const Text(
              'Device Metrics (example values)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: _rbDarkSteel,
              ),
            ),
            const SizedBox(height: 10),
            _rbMetricRow('Physical Size', '1080 × 2340 px'),
            _rbMetricRow('Logical Size', '360 × 780 dp'),
            _rbMetricRow('Device Pixel Ratio', '3.0'),
            _rbMetricRow('Text Scale Factor', '1.0'),
            _rbMetricRow('Padding (top)', '24.0'),
            _rbMetricRow('View Insets (bottom)', '0.0'),
          ],
        ),
      ),
      const SizedBox(height: 10),
      _rbCodeBlock(
        '// When metrics change:\n'
        'void handleMetricsChanged() {\n'
        '  // RenderView receives new configuration\n'
        '  for (final view in renderViews) {\n'
        '    view.configuration = createViewConfigurationFor(view);\n'
        '  }\n'
        '  // This marks RenderView as needing layout\n'
        '  // → triggers full pipeline on next frame\n'
        '}',
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _rbMetricRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: _rbCharcoal),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: _rbSteel.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _rbDarkSteel,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6: scheduleWarmUpFrame
// ---------------------------------------------------------------------------

Widget _rbSection6WarmUpFrame() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rbSectionHeader(
        '6. Warm-Up Frame',
        subtitle: 'scheduleWarmUpFrame() — rendering before vsync',
      ),
      const SizedBox(height: 12),
      _rbInfoCard(
        'First Frame Fast',
        'RendererBinding.scheduleWarmUpFrame() is called during app '
            'startup to produce the first frame immediately, without '
            'waiting for a vsync signal. This reduces the time to first '
            'paint. It runs the full build-layout-paint pipeline once '
            'synchronously.',
        icon: Icons.flash_on,
      ),
      const SizedBox(height: 8),
      // Visual timeline
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _rbPewter.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Startup Timeline',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: _rbDarkSteel,
              ),
            ),
            const SizedBox(height: 10),
            _rbTimelineEntry('t=0ms', 'main() called', _rbSteel),
            _rbTimelineEntry('t=2ms', 'runApp() → WidgetsFlutterBinding.ensureInitialized()', const Color(0xFF5B8FA8)),
            _rbTimelineEntry('t=3ms', 'RendererBinding.initInstances()', _rbSteel),
            _rbTimelineEntry('t=5ms', 'scheduleWarmUpFrame()', _rbAccent),
            _rbTimelineEntry('t=6ms', 'Build widgets → Element tree', const Color(0xFF7B8D6E)),
            _rbTimelineEntry('t=8ms', 'Layout → Paint → Composite', const Color(0xFFD4793A)),
            _rbTimelineEntry('t=10ms', 'First frame on screen!', const Color(0xFF3D9970)),
          ],
        ),
      ),
      const SizedBox(height: 8),
      _rbInfoCard(
        'Why Not Wait for Vsync?',
        'Normally, frames only render when the engine sends a vsync '
            'callback (typically 60 or 120 Hz). The warm-up frame '
            'bypasses this to avoid a potential 16ms wait on the very '
            'first frame.',
        icon: Icons.timer,
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _rbTimelineEntry(String time, String label, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 56,
          child: Text(
            time,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: _rbCharcoal),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: Frame Scheduling & requestVisualUpdate
// ---------------------------------------------------------------------------

Widget _rbSection7FrameScheduling() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rbSectionHeader(
        '7. Frame Scheduling',
        subtitle: 'How the binding requests and processes frames',
      ),
      const SizedBox(height: 12),
      _rbInfoCard(
        'requestVisualUpdate()',
        'When any render object is marked dirty, PipelineOwner calls '
            'onNeedVisualUpdate which delegates to '
            'RendererBinding.ensureVisualUpdate(). This schedules a '
            'frame through SchedulerBinding.scheduleFrame().',
        icon: Icons.update,
      ),
      const SizedBox(height: 8),
      // Flow diagram
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _rbCharcoal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text(
              'Frame Request Flow',
              style: TextStyle(
                color: _rbAccent,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            _rbFlowStep('setState() called', _rbMint),
            _rbFlowArrow(),
            _rbFlowStep('Element marked dirty', _rbMint),
            _rbFlowArrow(),
            _rbFlowStep('scheduleBuildFor() → scheduleFrame()', const Color(0xFF5B8FA8)),
            _rbFlowArrow(),
            _rbFlowStep('Engine sends vsync callback', _rbAccent),
            _rbFlowArrow(),
            _rbFlowStep('handleBeginFrame() — animations tick', const Color(0xFF8E6DAF)),
            _rbFlowArrow(),
            _rbFlowStep('handleDrawFrame() — build + render', _rbSteel),
            _rbFlowArrow(),
            _rbFlowStep('drawFrame() — layout/paint/composite', const Color(0xFF3D9970)),
          ],
        ),
      ),
      const SizedBox(height: 8),
      _rbCodeBlock(
        '// RendererBinding ensures the pipeline runs:\n'
        'void ensureVisualUpdate() {\n'
        '  switch (schedulerPhase) {\n'
        '    case SchedulerPhase.idle:\n'
        '    case SchedulerPhase.postFrameCallbacks:\n'
        '      scheduleFrame();\n'
        '      return;\n'
        '    case SchedulerPhase.transientCallbacks:\n'
        '    case SchedulerPhase.midFrameMicrotasks:\n'
        '    case SchedulerPhase.persistentCallbacks:\n'
        '      return; // already in a frame\n'
        '  }\n'
        '}',
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _rbFlowStep(String label, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      label,
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _rbFlowArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Icon(Icons.arrow_downward, color: _rbLightSteel, size: 16),
  );
}

// ---------------------------------------------------------------------------
// Section 8: Visual Demo — Pipeline Visualization
// ---------------------------------------------------------------------------

Widget _rbSection8VisualDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rbSectionHeader(
        '8. Visual Demo — Pipeline at Work',
        subtitle: 'A live widget tree showing the pipeline in action',
      ),
      const SizedBox(height: 12),
      _rbInfoCard(
        'What You See Below',
        'Every widget in this demo went through the full RendererBinding '
            'pipeline: each was laid out by its parent\'s constraints, '
            'painted into its layer, composited into the scene, and '
            'delivered to the screen by RenderView.',
        icon: Icons.visibility,
      ),
      const SizedBox(height: 10),
      // Pipeline phase cards with sample widgets
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _rbSteel.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _rbPewter.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            const Text(
              'Layout Phase Results',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: _rbDarkSteel,
              ),
            ),
            const SizedBox(height: 10),
            // Boxes showing different constraint solutions
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A90D9).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF4A90D9)),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.straighten, color: Color(0xFF4A90D9), size: 20),
                          SizedBox(height: 4),
                          Text(
                            'Tight\nConstraints',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10, color: Color(0xFF4A90D9)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7B68AE).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF7B68AE)),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.open_with, color: Color(0xFF7B68AE), size: 20),
                          SizedBox(height: 4),
                          Text(
                            'Loose\nConstraints',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10, color: Color(0xFF7B68AE)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D9970).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF3D9970)),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.aspect_ratio, color: Color(0xFF3D9970), size: 20),
                          SizedBox(height: 4),
                          Text(
                            'Bounded\nConstraints',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10, color: Color(0xFF3D9970)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Paint Phase Results',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: _rbDarkSteel,
              ),
            ),
            const SizedBox(height: 10),
            // Layered painting demo
            SizedBox(
              height: 120,
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      width: 180,
                      height: 90,
                      decoration: BoxDecoration(
                        color: _rbSteel.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _rbSteel),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Layer 0\n(background)',
                          style: TextStyle(fontSize: 11, color: _rbDarkSteel),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 20,
                    child: Container(
                      width: 180,
                      height: 90,
                      decoration: BoxDecoration(
                        color: _rbPewter.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _rbPewter),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Layer 1\n(content)',
                          style: TextStyle(fontSize: 11, color: _rbDarkSteel),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 70,
                    top: 30,
                    child: Container(
                      width: 180,
                      height: 90,
                      decoration: BoxDecoration(
                        color: _rbAccent.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _rbAccent),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Layer 2\n(overlay)',
                          style: TextStyle(fontSize: 11, color: _rbDarkSteel),
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
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Comparison & Summary
// ---------------------------------------------------------------------------

Widget _rbSection9Summary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rbSectionHeader(
        '9. Summary & Key Points',
        subtitle: 'RendererBinding at a glance',
      ),
      const SizedBox(height: 12),
      // Key-value summary cards
      _rbSummaryItem('Singleton?', 'Yes — accessed via RendererBinding.instance', Icons.looks_one),
      _rbSummaryItem('Creates', 'Root PipelineOwner + RenderView', Icons.create),
      _rbSummaryItem('Drives', 'drawFrame() → layout/paint/composite/semantics', Icons.play_circle),
      _rbSummaryItem('Reacts to', 'Device metrics, locale, semantics changes', Icons.sensors),
      _rbSummaryItem('First frame', 'scheduleWarmUpFrame() for instant rendering', Icons.flash_on),
      _rbSummaryItem('Accessibility', 'Manages SemanticsOwner and semantics tree', Icons.accessibility),
      const SizedBox(height: 10),
      _rbDivider(),
      _rbInfoCard(
        'When Do You Interact With RendererBinding?',
        'Most developers never call RendererBinding directly. It works '
            'behind the scenes. However, knowledge of the binding is '
            'essential for:\n'
            '• Understanding performance — the pipeline phases are what '
            'you see in DevTools timelines\n'
            '• Custom render objects — they interact with PipelineOwner\n'
            '• Testing — TestWidgetsFlutterBinding replaces the real '
            'binding\n'
            '• Embedding Flutter — custom bindings use RendererBinding '
            'as a mixin',
        icon: Icons.lightbulb_outline,
      ),
      const SizedBox(height: 8),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_rbSteel, _rbDarkSteel],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: _rbMint, size: 22),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'RendererBinding is the engine room of Flutter — it turns '
                    'your widget tree into pixels on screen, frame by frame.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}

Widget _rbSummaryItem(String label, String value, IconData icon) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _rbPewter.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Icon(icon, color: _rbSteel, size: 18),
        const SizedBox(width: 10),
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: _rbDarkSteel,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, color: _rbCharcoal),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// MAIN BUILD ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  print('=== RendererBinding Deep Demo ===');
  print('RendererBinding connects the render tree to the engine.');
  print('It owns the PipelineOwner and drives drawFrame().');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF0F0EC),
      appBarTheme: const AppBarTheme(
        backgroundColor: _rbSteel,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RendererBinding'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'rendering',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_rbDarkSteel, _rbSteel, _rbPewter],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RendererBinding',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'The singleton binding that connects Flutter\'s '
                        'rendering layer to the engine — driving layout, '
                        'paint, compositing, and semantics every frame.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _rbBadge('mixin', _rbAccent),
                      const SizedBox(width: 8),
                      _rbBadge('singleton', _rbDarkSteel),
                      const SizedBox(width: 8),
                      _rbBadge('rendering layer', _rbPewter),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _rbSection1BindingHierarchy(),
            _rbDivider(),
            _rbSection2RenderPipeline(),
            _rbDivider(),
            _rbSection3PipelineOwner(),
            _rbDivider(),
            _rbSection4RenderView(),
            _rbDivider(),
            _rbSection5DeviceMetrics(),
            _rbDivider(),
            _rbSection6WarmUpFrame(),
            _rbDivider(),
            _rbSection7FrameScheduling(),
            _rbDivider(),
            _rbSection8VisualDemo(),
            _rbDivider(),
            _rbSection9Summary(),
          ],
        ),
      ),
    ),
  );
}

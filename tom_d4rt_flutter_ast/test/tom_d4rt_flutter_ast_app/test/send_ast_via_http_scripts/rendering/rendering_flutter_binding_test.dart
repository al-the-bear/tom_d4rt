// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// RENDERING FLUTTER BINDING — Deep Demo
// ============================================================================
//
// RenderingFlutterBinding is the concrete binding class that assembles
// the minimal set of binding mixins needed for a rendering-only Flutter
// application. It includes:
//
//   BindingBase + GestureBinding + SchedulerBinding + ServicesBinding +
//   PaintingBinding + SemanticsBinding + RendererBinding
//
// Notably, it does NOT include WidgetsBinding. This means you can
// build a Flutter app entirely from RenderObjects without the widget
// layer. This is useful for:
//
//   - Ultra-low-level rendering experiments
//   - Custom engines that want Flutter's GPU pipeline without widgets
//   - Learning how the render tree works at its core
//   - Performance-critical situations where the widget layer overhead
//     is unacceptable (very rare in practice)
//
// In typical usage, developers use WidgetsFlutterBinding (via runApp).
// RenderingFlutterBinding is a teaching and experimentation tool.
//
// Color theme : Indigo (#4B0082) / Periwinkle (#CCCCFF)
// Helper prefix: _rf
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _rfIndigo = Color(0xFF4B0082);
const Color _rfPeriwinkle = Color(0xFFCCCCFF);
const Color _rfLightIndigo = Color(0xFF7A5FA0);
const Color _rfDarkIndigo = Color(0xFF2D004E);
const Color _rfSoftLavender = Color(0xFFF0E6FF);
const Color _rfSlate = Color(0xFF4A4A6A);
const Color _rfGold = Color(0xFFD4A030);
const Color _rfTeal = Color(0xFF2AA198);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _rfSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_rfIndigo, _rfDarkIndigo],
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
              style: TextStyle(
                color: _rfPeriwinkle.withValues(alpha: 0.9),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _rfInfoCard(String heading, String body, {IconData? icon}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _rfPeriwinkle.withValues(alpha: 0.6)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 2),
            child: Icon(icon, color: _rfIndigo, size: 22),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  color: _rfDarkIndigo,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: _rfSlate,
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

Widget _rfCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E3A),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _rfPeriwinkle,
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.6,
      ),
    ),
  );
}

Widget _rfDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    height: 1,
    color: _rfPeriwinkle.withValues(alpha: 0.4),
  );
}

Widget _rfBadge(String label, Color bg) {
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

// ---------------------------------------------------------------------------
// Section 1: What Is RenderingFlutterBinding?
// ---------------------------------------------------------------------------

Widget _rfSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rfSectionHeader(
        '1. What Is RenderingFlutterBinding?',
        subtitle: 'The minimal binding for rendering without widgets',
      ),
      const SizedBox(height: 12),
      _rfInfoCard(
        'Definition',
        'RenderingFlutterBinding is a concrete class that extends '
            'BindingBase and mixes in all the bindings needed for '
            'rendering — but NOT WidgetsBinding. It provides everything '
            'needed to create and display a render tree without ever '
            'constructing a Widget or Element.',
        icon: Icons.info_outline,
      ),
      const SizedBox(height: 8),
      _rfInfoCard(
        'Key Characteristic',
        'While WidgetsFlutterBinding (used by runApp) includes the '
            'widget layer that converts widgets → elements → render '
            'objects, RenderingFlutterBinding lets you work directly '
            'with render objects. You manage the render tree yourself.',
        icon: Icons.key,
      ),
      const SizedBox(height: 8),
      _rfCodeBlock(
        '// RenderingFlutterBinding definition:\n'
        'class RenderingFlutterBinding extends BindingBase\n'
        '    with GestureBinding,\n'
        '         SchedulerBinding,\n'
        '         ServicesBinding,\n'
        '         PaintingBinding,\n'
        '         SemanticsBinding,\n'
        '         RendererBinding {\n'
        '  // That\'s it — no WidgetsBinding!\n'
        '}',
      ),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Binding Comparison
// ---------------------------------------------------------------------------

Widget _rfSection2Comparison() {
  final List<Map<String, dynamic>> mixins = [
    {'name': 'GestureBinding', 'rendering': true, 'widgets': true, 'icon': Icons.touch_app},
    {'name': 'SchedulerBinding', 'rendering': true, 'widgets': true, 'icon': Icons.schedule},
    {'name': 'ServicesBinding', 'rendering': true, 'widgets': true, 'icon': Icons.miscellaneous_services},
    {'name': 'PaintingBinding', 'rendering': true, 'widgets': true, 'icon': Icons.brush},
    {'name': 'SemanticsBinding', 'rendering': true, 'widgets': true, 'icon': Icons.accessibility_new},
    {'name': 'RendererBinding', 'rendering': true, 'widgets': true, 'icon': Icons.layers},
    {'name': 'WidgetsBinding', 'rendering': false, 'widgets': true, 'icon': Icons.widgets},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rfSectionHeader(
        '2. Binding Comparison',
        subtitle: 'RenderingFlutterBinding vs WidgetsFlutterBinding',
      ),
      const SizedBox(height: 12),
      _rfInfoCard(
        'Side by Side',
        'The two binding classes include mostly the same mixins. '
            'The crucial difference is WidgetsBinding, which manages '
            'the build phase (Widget → Element → RenderObject). Without '
            'it, you must create RenderObjects directly.',
        icon: Icons.compare,
      ),
      const SizedBox(height: 8),
      // Comparison table header
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _rfPeriwinkle.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            // Header row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: _rfIndigo.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Mixin',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: _rfDarkIndigo,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Rendering\nBinding',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: _rfDarkIndigo),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Widgets\nBinding',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: _rfDarkIndigo),
                    ),
                  ),
                ],
              ),
            ),
            // Data rows
            ...mixins.asMap().entries.map((entry) {
              final m = entry.value;
              final isLast = entry.key == mixins.length - 1;
              final isWidgetsRow = m['name'] == 'WidgetsBinding';
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isWidgetsRow
                      ? _rfGold.withValues(alpha: 0.08)
                      : (entry.key.isEven ? Colors.white : _rfSoftLavender.withValues(alpha: 0.5)),
                  borderRadius: isLast
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(9),
                          bottomRight: Radius.circular(9),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Icon(m['icon'] as IconData,
                              size: 16,
                              color: isWidgetsRow ? _rfGold : _rfLightIndigo),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              m['name'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isWidgetsRow ? FontWeight.bold : FontWeight.normal,
                                color: isWidgetsRow ? _rfGold : _rfSlate,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Icon(
                          (m['rendering'] as bool) ? Icons.check_circle : Icons.cancel,
                          color: (m['rendering'] as bool) ? _rfTeal : Colors.red.shade300,
                          size: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Icon(
                          (m['widgets'] as bool) ? Icons.check_circle : Icons.cancel,
                          color: (m['widgets'] as bool) ? _rfTeal : Colors.red.shade300,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
      const SizedBox(height: 10),
      _rfInfoCard(
        'The Missing Piece',
        'Without WidgetsBinding, there is no BuildOwner, no Element '
            'tree, no setState(), no InheritedWidget, and no widget '
            'lifecycle. You work entirely at the render layer.',
        icon: Icons.warning_amber,
      ),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: Using RenderingFlutterBinding
// ---------------------------------------------------------------------------

Widget _rfSection3Usage() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rfSectionHeader(
        '3. Creating a Rendering-Only App',
        subtitle: 'How to set up a render tree without widgets',
      ),
      const SizedBox(height: 12),
      _rfInfoCard(
        'Step-by-Step Setup',
        'To use RenderingFlutterBinding, you (1) ensure the binding is '
            'initialized, (2) create a root RenderObject, (3) attach it '
            'to the RenderView, and (4) schedule a frame. The binding '
            'handles layout, paint, and compositing.',
        icon: Icons.list_alt,
      ),
      const SizedBox(height: 8),
      _rfCodeBlock(
        '// Using RenderingFlutterBinding directly:\n'
        'void main() {\n'
        '  final binding = RenderingFlutterBinding(\n'
        '    root: RenderDecoratedBox(\n'
        '      decoration: const BoxDecoration(\n'
        '        color: Colors.blue,\n'
        '      ),\n'
        '    ),\n'
        '  );\n'
        '  // The constructor takes a root RenderBox\n'
        '  // and attaches it to the RenderView.\n'
        '  // scheduleWarmUpFrame() is called automatically.\n'
        '}',
      ),
      const SizedBox(height: 8),
      // Visual: what happens during initialization
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _rfSoftLavender,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _rfPeriwinkle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Initialization Sequence',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: _rfDarkIndigo,
              ),
            ),
            const SizedBox(height: 10),
            _rfInitStep('1', 'BindingBase.initInstances()', 'Sets up platform channels'),
            _rfInitStep('2', 'GestureBinding.initInstances()', 'Creates gesture arena'),
            _rfInitStep('3', 'SchedulerBinding.initInstances()', 'Sets up frame callbacks'),
            _rfInitStep('4', 'ServicesBinding.initInstances()', 'Registers system services'),
            _rfInitStep('5', 'PaintingBinding.initInstances()', 'Creates image cache'),
            _rfInitStep('6', 'SemanticsBinding.initInstances()', 'Sets up semantics owner'),
            _rfInitStep('7', 'RendererBinding.initInstances()', 'Creates PipelineOwner + RenderView'),
            _rfInitStep('8', 'Root RenderBox attached', 'Your render tree is now live!'),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _rfInitStep(String number, String action, String detail) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: _rfIndigo,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                action,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: _rfDarkIndigo,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                detail,
                style: const TextStyle(fontSize: 11, color: _rfSlate),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: Building a Render Tree Manually
// ---------------------------------------------------------------------------

Widget _rfSection4ManualTree() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rfSectionHeader(
        '4. Building a Render Tree Manually',
        subtitle: 'RenderObjects without Widget.build()',
      ),
      const SizedBox(height: 12),
      _rfInfoCard(
        'Manual Construction',
        'Without widgets, you construct the render tree by creating '
            'RenderObject instances and setting parent-child relationships '
            'directly. This is what Flutter does behind the scenes when '
            'it converts widgets to render objects.',
        icon: Icons.construction,
      ),
      const SizedBox(height: 8),
      _rfCodeBlock(
        '// Manual render tree construction:\n'
        'final paragraph = RenderParagraph(\n'
        '  TextSpan(\n'
        '    text: "Hello from the render layer!",\n'
        '    style: TextStyle(fontSize: 24, color: Colors.white),\n'
        '  ),\n'
        '  textDirection: TextDirection.ltr,\n'
        ');\n'
        '\n'
        'final centered = RenderPositionedBox(\n'
        '  alignment: Alignment.center,\n'
        '  child: paragraph,  // Parent-child set directly\n'
        ');\n'
        '\n'
        'final decorated = RenderDecoratedBox(\n'
        '  decoration: BoxDecoration(color: Colors.indigo),\n'
        '  child: centered,\n'
        ');\n'
        '\n'
        '// Attach to the binding:\n'
        'RenderingFlutterBinding(root: decorated);',
      ),
      const SizedBox(height: 10),
      // Visual: render tree diagram
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E3A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Visual: Manual Render Tree',
              style: TextStyle(color: _rfGold, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 10),
            _rfTreeRow('RenderView', 0, Colors.white70),
            _rfTreeRow('└─ RenderDecoratedBox', 1, _rfPeriwinkle),
            _rfTreeRow('   └─ RenderPositionedBox', 2, _rfPeriwinkle),
            _rfTreeRow('      └─ RenderParagraph', 3, _rfGold),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _rfIndigo.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'No Widget, no Element — just RenderObjects!',
                style: TextStyle(
                  color: _rfPeriwinkle,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _rfTreeRow(String text, int depth, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontSize: 12,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: What You Lose Without Widgets
// ---------------------------------------------------------------------------

Widget _rfSection5WhatYouLose() {
  final List<Map<String, dynamic>> lostFeatures = [
    {
      'feature': 'setState()',
      'explanation': 'No Element means no state management via StatefulWidget',
      'icon': Icons.sync_disabled,
    },
    {
      'feature': 'InheritedWidget',
      'explanation': 'No widget tree means no of() lookups or dependency injection',
      'icon': Icons.link_off,
    },
    {
      'feature': 'Hot Reload',
      'explanation': 'Hot reload depends on reassembling the widget tree',
      'icon': Icons.refresh,
    },
    {
      'feature': 'BuildContext',
      'explanation': 'BuildContext IS the Element — no widgets, no context',
      'icon': Icons.block,
    },
    {
      'feature': 'Keys & Diffing',
      'explanation': 'Widget reconciliation (diffing) requires the widget layer',
      'icon': Icons.vpn_key_off,
    },
    {
      'feature': 'Navigator & Routes',
      'explanation': 'Navigation is a widget-layer concept built on Overlay',
      'icon': Icons.explore_off,
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rfSectionHeader(
        '5. What You Lose Without Widgets',
        subtitle: 'The trade-offs of rendering-only mode',
      ),
      const SizedBox(height: 12),
      _rfInfoCard(
        'No Free Lunch',
        'Skipping WidgetsBinding removes a huge amount of convenience. '
            'The widget layer provides declarative UI, efficient updates, '
            'state management, theming, navigation, and much more. '
            'RenderingFlutterBinding is raw, manual, and verbose.',
        icon: Icons.warning,
      ),
      const SizedBox(height: 8),
      ...lostFeatures.map((f) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade100),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                f['icon'] as IconData,
                color: Colors.red.shade400,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f['feature'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Colors.red.shade700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    f['explanation'] as String,
                    style: const TextStyle(fontSize: 12, color: _rfSlate, height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: When To Use It
// ---------------------------------------------------------------------------

Widget _rfSection6WhenToUse() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rfSectionHeader(
        '6. When To Use RenderingFlutterBinding',
        subtitle: 'Practical scenarios for rendering-only mode',
      ),
      const SizedBox(height: 12),
      // Good use cases
      _rfUseCaseCard(
        'Learning & Education',
        'Understanding how Flutter works at the render layer. Seeing '
            'exactly what happens without the widget abstraction helps '
            'developers build mental models of the framework.',
        Icons.school,
        _rfTeal,
        true,
      ),
      _rfUseCaseCard(
        'Custom Rendering Engines',
        'Building a custom game engine or data visualization that '
            'needs Flutter\'s GPU pipeline but not its widget system. '
            'Some game frameworks do this.',
        Icons.videogame_asset,
        _rfTeal,
        true,
      ),
      _rfUseCaseCard(
        'Framework Internals Testing',
        'Flutter\'s own test suite uses RenderingFlutterBinding to '
            'test render objects in isolation, without widget overhead.',
        Icons.bug_report,
        _rfTeal,
        true,
      ),
      _rfUseCaseCard(
        'Regular App Development',
        'For normal apps, always use WidgetsFlutterBinding (via '
            'runApp). The widget layer\'s benefits far outweigh any '
            'overhead.',
        Icons.apps,
        Colors.red.shade400,
        false,
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _rfUseCaseCard(String title, String desc, IconData icon, Color color, bool recommended) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: recommended ? _rfTeal.withValues(alpha: 0.4) : Colors.red.withValues(alpha: 0.3),
        width: 1.5,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: color,
                      ),
                    ),
                  ),
                  _rfBadge(
                    recommended ? 'GOOD USE' : 'NOT RECOMMENDED',
                    recommended ? _rfTeal : Colors.red.shade400,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(fontSize: 12, color: _rfSlate, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: Visual Demo — Render-Only Concepts
// ---------------------------------------------------------------------------

Widget _rfSection7VisualDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rfSectionHeader(
        '7. Visual Demo — Render Layer Concepts',
        subtitle: 'Seeing what RenderingFlutterBinding manages',
      ),
      const SizedBox(height: 12),
      _rfInfoCard(
        'Below: Simulated Render-Only Scene',
        'This section shows what a RenderingFlutterBinding app might '
            'display. Even though this demo uses widgets (because we need '
            'widgets in D4rt), we illustrate the concepts by showing '
            'what each render object does.',
        icon: Icons.visibility,
      ),
      const SizedBox(height: 8),
      // Simulated render-only scene
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 280,
        decoration: BoxDecoration(
          color: _rfDarkIndigo,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _rfPeriwinkle.withValues(alpha: 0.3), width: 2),
        ),
        child: Stack(
          children: [
            // Layer label
            Positioned(
              top: 8,
              left: 10,
              child: _rfBadge('RenderView (root)', _rfIndigo),
            ),
            // Background layer
            Positioned(
              top: 36,
              left: 12,
              right: 12,
              bottom: 12,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _rfIndigo.withValues(alpha: 0.6),
                      _rfLightIndigo.withValues(alpha: 0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 4,
                      left: 8,
                      child: Text(
                        'RenderDecoratedBox',
                        style: TextStyle(
                          color: _rfPeriwinkle.withValues(alpha: 0.7),
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    // Centered content
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _rfPeriwinkle.withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'RenderPositionedBox',
                              style: TextStyle(
                                color: _rfPeriwinkle.withValues(alpha: 0.7),
                                fontSize: 10,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Hello from the\nRender Layer!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'RenderParagraph',
                              style: TextStyle(
                                color: _rfGold.withValues(alpha: 0.7),
                                fontSize: 10,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Grid overlay to show layout
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: _rfTeal.withValues(alpha: 0.4)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: Text(
                                'Box A',
                                style: TextStyle(color: _rfTeal, fontSize: 9),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: _rfGold.withValues(alpha: 0.4)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: Text(
                                'Box B',
                                style: TextStyle(color: _rfGold, fontSize: 9),
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
          ],
        ),
      ),
      const SizedBox(height: 10),
      _rfInfoCard(
        'No Widget Layer Involved (Conceptually)',
        'In a real RenderingFlutterBinding app, every box, paragraph, '
            'and decoration above would be a RenderObject created manually '
            'in code. No build() method, no setState(), no lifecycle. '
            'Just raw render objects in a tree.',
        icon: Icons.code,
      ),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: Common RenderObjects for Manual Trees
// ---------------------------------------------------------------------------

Widget _rfSection8CommonRenderObjects() {
  final List<Map<String, String>> objects = [
    {
      'name': 'RenderDecoratedBox',
      'desc': 'Paints a BoxDecoration (color, gradient, border, shadow, shape)',
    },
    {
      'name': 'RenderPositionedBox',
      'desc': 'Positions a single child within itself (like Center/Align)',
    },
    {
      'name': 'RenderParagraph',
      'desc': 'Renders a TextSpan (the render-layer Text widget)',
    },
    {
      'name': 'RenderFlex',
      'desc': 'Lays out children in a row or column (Row/Column)',
    },
    {
      'name': 'RenderConstrainedBox',
      'desc': 'Imposes additional constraints on a child (SizedBox)',
    },
    {
      'name': 'RenderPadding',
      'desc': 'Adds padding around a child (Padding widget)',
    },
    {
      'name': 'RenderClipRRect',
      'desc': 'Clips a child to a rounded rectangle',
    },
    {
      'name': 'RenderImage',
      'desc': 'Displays an image (the render-layer Image widget)',
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rfSectionHeader(
        '8. Common RenderObjects for Manual Trees',
        subtitle: 'Building blocks when working without widgets',
      ),
      const SizedBox(height: 12),
      _rfInfoCard(
        'Pick Your Render Objects',
        'When using RenderingFlutterBinding, you work with the same '
            'render objects that widgets create internally. Every widget '
            'has a corresponding render object. Here are the most useful '
            'ones for manual tree construction.',
        icon: Icons.inventory_2,
      ),
      const SizedBox(height: 8),
      ...objects.asMap().entries.map((entry) {
        final o = entry.value;
        final hue = (entry.key * 35.0 + 240.0) % 360.0;
        final color = HSVColor.fromAHSV(1.0, hue, 0.35, 0.65).toColor();
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'R',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      o['name']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                        color: color,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      o['desc']!,
                      style: const TextStyle(fontSize: 11.5, color: _rfSlate),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Summary & Best Practices
// ---------------------------------------------------------------------------

Widget _rfSection9Summary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _rfSectionHeader(
        '9. Summary & Best Practices',
        subtitle: 'Key takeaways for RenderingFlutterBinding',
      ),
      const SizedBox(height: 12),
      _rfInfoCard(
        'Summary',
        'RenderingFlutterBinding is the minimal concrete binding class '
            'that gives you Flutter\'s GPU-backed rendering pipeline '
            'without the widget layer. It includes all binding mixins '
            'except WidgetsBinding, letting you work directly with '
            'render objects.',
        icon: Icons.summarize,
      ),
      const SizedBox(height: 8),
      // Best practices
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _rfSoftLavender,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _rfPeriwinkle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Best Practices',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: _rfDarkIndigo,
              ),
            ),
            const SizedBox(height: 10),
            _rfBestPractice('Use runApp() for apps',
                'WidgetsFlutterBinding is almost always the right choice'),
            _rfBestPractice('Use for learning',
                'Great way to understand Flutter\'s render pipeline'),
            _rfBestPractice('Use in tests',
                'Flutter uses it internally to test render objects'),
            _rfBestPractice('Mind the gap',
                'Without widgets, you lose hot reload, state management, themes'),
            _rfBestPractice('Pair with RenderObject knowledge',
                'You need to understand constraints, layout, and painting'),
          ],
        ),
      ),
      const SizedBox(height: 10),
      _rfDivider(),
      // Final summary badge
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_rfIndigo, _rfDarkIndigo],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Icon(Icons.lightbulb, color: _rfGold, size: 22),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'RenderingFlutterBinding is Flutter\'s rendering layer, '
                    'exposed. It\'s the answer to "What if I just want to '
                    'paint pixels without building widgets?"',
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

Widget _rfBestPractice(String title, String detail) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: _rfTeal, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title — ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: _rfDarkIndigo,
                  ),
                ),
                TextSpan(
                  text: detail,
                  style: const TextStyle(fontSize: 12, color: _rfSlate),
                ),
              ],
            ),
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
  print('=== RenderingFlutterBinding Deep Demo ===');
  print('RenderingFlutterBinding = rendering pipeline without widgets.');
  print('It combines all bindings except WidgetsBinding.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF5F0FF),
      appBarTheme: const AppBarTheme(
        backgroundColor: _rfIndigo,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RenderingFlutterBinding'),
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
            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_rfDarkIndigo, _rfIndigo, _rfLightIndigo],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RenderingFlutterBinding',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'The concrete binding for rendering-only Flutter apps. '
                        'All the GPU power, none of the widget layer. '
                        'Understanding this class reveals how Flutter works '
                        'beneath the widgets.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _rfBadge('concrete class', _rfLightIndigo),
                      const SizedBox(width: 8),
                      _rfBadge('no widgets', _rfGold),
                      const SizedBox(width: 8),
                      _rfBadge('render-only', _rfTeal),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _rfSection1Overview(),
            _rfDivider(),
            _rfSection2Comparison(),
            _rfDivider(),
            _rfSection3Usage(),
            _rfDivider(),
            _rfSection4ManualTree(),
            _rfDivider(),
            _rfSection5WhatYouLose(),
            _rfDivider(),
            _rfSection6WhenToUse(),
            _rfDivider(),
            _rfSection7VisualDemo(),
            _rfDivider(),
            _rfSection8CommonRenderObjects(),
            _rfDivider(),
            _rfSection9Summary(),
          ],
        ),
      ),
    ),
  );
}

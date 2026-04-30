import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// RegularWindowControllerDelegate – Deep Visual Demo
//
// RegularWindowControllerDelegate is part of Flutter's experimental windowing
// API (flutter/src/widgets/_window.dart). It is currently @internal and only
// available on the main channel behind the isWindowingEnabled feature flag.
// This demo provides a comprehensive, fully visual educational walkthrough of
// the delegate pattern, the surrounding controller hierarchy, platform-specific
// implementations and the full lifecycle, using a simulated window chrome so
// the demo runs safely in the D4rt sandbox.
// ---------------------------------------------------------------------------

// ── top-level ValueNotifiers (stateless rule: no StatefulWidget) ──────────

/// Simulated window state driven by the window-chrome section.
final ValueNotifier<_WindowState> _windowState =
    ValueNotifier<_WindowState>(_WindowState.normal);

/// Which platform delegate card is highlighted.
final ValueNotifier<String> _selectedPlatform =
    ValueNotifier<String>('macOS');

/// Whether the simulated "close dialog" is visible.
final ValueNotifier<bool> _closeDialogVisible =
    ValueNotifier<bool>(false);

/// Simulated lifecycle event log.
final ValueNotifier<List<_LifecycleEvent>> _lifecycleLog =
    ValueNotifier<List<_LifecycleEvent>>(<_LifecycleEvent>[]);

// ── enums & data classes ──────────────────────────────────────────────────

enum _WindowState { normal, minimized, maximized, fullscreen, closed }

class _LifecycleEvent {
  const _LifecycleEvent(this.label, this.timestamp, this.color);
  final String label;
  final String timestamp;
  final Color color;
}

class _PlatformCard {
  const _PlatformCard({
    required this.platform,
    required this.className,
    required this.icon,
    required this.color,
    required this.details,
    required this.notes,
  });
  final String platform;
  final String className;
  final IconData icon;
  final Color color;
  final List<String> details;
  final String notes;
}

class _ApiMethod {
  const _ApiMethod({
    required this.signature,
    required this.description,
    required this.isDelegate,
  });
  final String signature;
  final String description;
  final bool isDelegate;
}

class _UseCaseCard {
  const _UseCaseCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.delegateUsage,
  });
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final String delegateUsage;
}

// ── helpers ───────────────────────────────────────────────────────────────

String _nowTimestamp() {
  final now = DateTime.now();
  return '${now.hour.toString().padLeft(2, '0')}:'
      '${now.minute.toString().padLeft(2, '0')}:'
      '${now.second.toString().padLeft(2, '0')}';
}

void _addLifecycleEvent(String label, Color color) {
  final updated = List<_LifecycleEvent>.from(_lifecycleLog.value)
    ..add(_LifecycleEvent(label, _nowTimestamp(), color));
  if (updated.length > 12) {
    updated.removeAt(0);
  }
  _lifecycleLog.value = updated;
}

// ── entry point ───────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A6B4A)),
    ),
    home: const _DemoRoot(),
  );
}

// ── root scaffold ─────────────────────────────────────────────────────────

class _DemoRoot extends StatelessWidget {
  const _DemoRoot();

  static const List<_TabSpec> _tabs = <_TabSpec>[
    _TabSpec(Icons.star_border_rounded, 'Hero'),
    _TabSpec(Icons.account_tree_outlined, 'Architecture'),
    _TabSpec(Icons.extension_outlined, 'Delegate Pattern'),
    _TabSpec(Icons.desktop_windows_outlined, 'Simulated Window'),
    _TabSpec(Icons.dns_outlined, 'Platforms'),
    _TabSpec(Icons.timeline_outlined, 'Lifecycle'),
    _TabSpec(Icons.compare_arrows_rounded, 'Comparison'),
    _TabSpec(Icons.widgets_outlined, 'Use Cases'),
    _TabSpec(Icons.warning_amber_outlined, 'Pitfalls'),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          title: const Text(
            'RegularWindowControllerDelegate',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: cs.onPrimary,
            labelColor: cs.onPrimary,
            unselectedLabelColor: cs.onPrimary.withAlpha(160),
            tabAlignment: TabAlignment.start,
            tabs: _tabs
                .map(
                  (t) => Tab(
                    icon: Icon(t.icon, size: 18),
                    text: t.label,
                    iconMargin: const EdgeInsets.only(bottom: 2),
                  ),
                )
                .toList(),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _ArchitectureTab(),
            _DelegatePatternTab(),
            _SimulatedWindowTab(),
            _PlatformsTab(),
            _LifecycleTab(),
            _ComparisonTab(),
            _UseCasesTab(),
            _PitfallsTab(),
          ],
        ),
      ),
    );
  }
}

class _TabSpec {
  const _TabSpec(this.icon, this.label);
  final IconData icon;
  final String label;
}

// ── shared widgets ─────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {this.icon});
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Icon(icon, color: cs.primary, size: 22),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip(this.label, {this.color});
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = color ?? cs.primaryContainer;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: ThemeData.estimateBrightnessForColor(bg) == Brightness.dark
              ? Colors.white
              : Colors.black87,
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.6,
        ),
      ),
    );
  }
}

class _HighlightBox extends StatelessWidget {
  const _HighlightBox({required this.color, required this.child});
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(100)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withAlpha(20),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _DemoScroll extends StatelessWidget {
  const _DemoScroll({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — HERO BANNER
// ═══════════════════════════════════════════════════════════════════════════

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _DemoScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ── Hero banner ────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[cs.primary, cs.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: cs.onPrimary.withAlpha(30),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.desktop_windows_rounded,
                        size: 40,
                        color: cs.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'RegularWindowControllerDelegate',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: cs.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Flutter Experimental Desktop Windowing API',
                            style: TextStyle(
                              fontSize: 13,
                              color: cs.onPrimary.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'The delegate that separates window lifecycle decisions from '
                  'platform machinery — giving your app control over what '
                  'happens when a user closes, destroys, or transitions a '
                  'top-level desktop window.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: cs.onPrimary.withAlpha(230),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _HeroBadge(
                      Icons.science_outlined,
                      'Experimental API',
                      cs.onPrimary,
                    ),
                    _HeroBadge(
                      Icons.lock_outlined,
                      '@internal',
                      cs.onPrimary,
                    ),
                    _HeroBadge(
                      Icons.desktop_mac_outlined,
                      'Desktop only',
                      cs.onPrimary,
                    ),
                    _HeroBadge(
                      Icons.hub_outlined,
                      'mixin class',
                      cs.onPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // ── What is it ────────────────────────────────────────────────
          _SectionTitle('What is RegularWindowControllerDelegate?',
              icon: Icons.help_outline_rounded),
          const SizedBox(height: 12),
          Text(
            'RegularWindowControllerDelegate is a mixin class that lives inside '
            'flutter/src/widgets/_window.dart. It is the behavioral customisation '
            'point for RegularWindowController — the controller that manages a '
            'traditional top-level desktop window on macOS, Linux, and Windows.\n\n'
            'By default the delegate simply calls controller.destroy() when the '
            'user requests a close. You mix it in and override the two lifecycle '
            'methods to intercept that behavior — for example to show a "save '
            'unsaved work?" dialog before allowing the window to close.',
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: cs.onSurface.withAlpha(200),
            ),
          ),
          const SizedBox(height: 24),
          // ── Key facts grid ────────────────────────────────────────────
          _SectionTitle('Key Facts', icon: Icons.info_outline_rounded),
          const SizedBox(height: 12),
          _FactsGrid(),
          const SizedBox(height: 24),
          // ── Source location ───────────────────────────────────────────
          _SectionTitle('Source Location', icon: Icons.folder_open_outlined),
          const SizedBox(height: 12),
          _CodeBlock(
            'flutter/packages/flutter/lib/src/widgets/_window.dart\n'
            '\n'
            '// Line 102-144 (as of Flutter 3.41.6 / 2026-03-25)\n'
            '/// Delegate class for regular window controller.\n'
            '///\n'
            '/// {@macro flutter.widgets.windowing.experimental}\n'
            '@internal\n'
            'mixin class RegularWindowControllerDelegate {\n'
            '  @internal\n'
            '  void onWindowCloseRequested(RegularWindowController controller) {\n'
            '    // default: controller.destroy();\n'
            '  }\n'
            '\n'
            '  @internal\n'
            '  void onWindowDestroyed() {\n'
            '    // default: no-op (plus windowing guard)\n'
            '  }\n'
            '}',
          ),
          const SizedBox(height: 24),
          // ── Experimental warning ──────────────────────────────────────
          _HighlightBox(
            color: Colors.orange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.warning_amber_rounded,
                        color: Colors.orange),
                    const SizedBox(width: 8),
                    Text(
                      'Experimental API — Not Production Ready',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'This API is gated behind isWindowingEnabled and only '
                  'available on Flutter\'s main channel. All public members '
                  'carry @internal — Flutter may make breaking changes even '
                  'in patch releases. Do not ship this API to pub.dev.',
                  style: TextStyle(fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge(this.icon, this.label, this.onColor);
  final IconData icon;
  final String label;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: onColor.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: onColor.withAlpha(80)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: onColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: onColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FactsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const facts = <_Fact>[
      _Fact('Type', 'mixin class', Icons.code_rounded),
      _Fact('Package', 'flutter/widgets', Icons.inventory_2_outlined),
      _Fact('File', '_window.dart', Icons.insert_drive_file_outlined),
      _Fact('Status', 'Experimental / @internal', Icons.science_outlined),
      _Fact('Channel', 'main only', Icons.merge_type_outlined),
      _Fact('Platforms', 'macOS, Linux, Windows', Icons.devices_outlined),
      _Fact('Methods', '2 (onWindowCloseRequested, onWindowDestroyed)',
          Icons.functions_outlined),
      _Fact('Default close', 'controller.destroy()', Icons.close_rounded),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: facts.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 260,
        mainAxisExtent: 90,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, i) => _FactCard(fact: facts[i]),
    );
  }
}

class _Fact {
  const _Fact(this.label, this.value, this.icon);
  final String label;
  final String value;
  final IconData icon;
}

class _FactCard extends StatelessWidget {
  const _FactCard({required this.fact});
  final _Fact fact;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.secondaryContainer.withAlpha(80),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(fact.icon, size: 14, color: cs.secondary),
              const SizedBox(width: 6),
              Text(
                fact.label,
                style: TextStyle(
                  fontSize: 11,
                  color: cs.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              fact.value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — ARCHITECTURE DIAGRAM (CustomPainter)
// ═══════════════════════════════════════════════════════════════════════════

class _ArchitectureTab extends StatelessWidget {
  const _ArchitectureTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _DemoScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle('Architecture Diagram',
              icon: Icons.account_tree_outlined),
          const SizedBox(height: 8),
          Text(
            'How RegularWindowControllerDelegate fits into the Flutter '
            'windowing stack — from your Flutter app down to the native '
            'platform window.',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: cs.onSurface.withAlpha(180),
            ),
          ),
          const SizedBox(height: 20),
          // CustomPainter architecture diagram
          Container(
            width: double.infinity,
            height: 480,
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: CustomPaint(
              painter: _ArchDiagramPainter(cs),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 20),
          // Layer legend
          _SectionTitle('Layer Legend', icon: Icons.layers_outlined),
          const SizedBox(height: 12),
          _ArchLegend(),
          const SizedBox(height: 24),
          // Class hierarchy
          _SectionTitle('Class Hierarchy', icon: Icons.account_tree_rounded),
          const SizedBox(height: 12),
          _CodeBlock(
            'ChangeNotifier\n'
            '  └── BaseWindowController (sealed)\n'
            '        ├── RegularWindowController (abstract factory)\n'
            '        │     ├── RegularWindowControllerLinux\n'
            '        │     ├── RegularWindowControllerMacOS\n'
            '        │     └── RegularWindowControllerWin32\n'
            '        ├── DialogWindowController\n'
            '        ├── TooltipWindowController\n'
            '        └── PopupWindowController\n'
            '\n'
            'mixin class RegularWindowControllerDelegate   ← you override this\n'
            '  ├── onWindowCloseRequested(RegularWindowController)\n'
            '  └── onWindowDestroyed()',
          ),
          const SizedBox(height: 24),
          // WindowingOwner
          _SectionTitle('WindowingOwner', icon: Icons.hub_outlined),
          const SizedBox(height: 12),
          Text(
            'WindowingOwner is the abstract factory that lives inside '
            'WidgetsBinding. Platform-specific subclasses '
            '(_WindowingOwnerLinux, etc.) manufacture the correct '
            'controller type. If the platform does not support windowing, '
            '_WindowingOwnerUnsupported throws UnsupportedError.',
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: cs.onSurface.withAlpha(190),
            ),
          ),
          const SizedBox(height: 12),
          _CodeBlock(
            '// How RegularWindowController picks the right implementation:\n'
            'factory RegularWindowController({\n'
            '  Size? preferredSize,\n'
            '  BoxConstraints? preferredConstraints,\n'
            '  String? title,\n'
            '  RegularWindowControllerDelegate? delegate,\n'
            '}) {\n'
            '  final WindowingOwner owner =\n'
            '      WidgetsBinding.instance.windowingOwner;\n'
            '  return owner.createRegularWindowController(\n'
            '    delegate: delegate ?? RegularWindowControllerDelegate(),\n'
            '    preferredSize: preferredSize,\n'
            '    preferredConstraints: preferredConstraints,\n'
            '    title: title,\n'
            '  );\n'
            '}',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _ArchDiagramPainter extends CustomPainter {
  _ArchDiagramPainter(this.cs);
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;

    const double boxH = 48.0;
    const double boxW = 260.0;
    const double gap = 24.0;

    final List<_DiagramLayer> layers = <_DiagramLayer>[
      _DiagramLayer('Flutter App', 'Your Dart code + widgets',
          const Color(0xFF1A6B4A), false),
      _DiagramLayer('RegularWindow Widget',
          'StatelessWidget wrapping the FlutterView', const Color(0xFF2E7D9C),
          false),
      _DiagramLayer(
          'RegularWindowController',
          'abstract class extending BaseWindowController',
          const Color(0xFF5B3E8D),
          false),
      _DiagramLayer(
          'RegularWindowControllerDelegate ← YOU',
          'mixin class — override lifecycle callbacks',
          const Color(0xFFB8401A),
          true),
      _DiagramLayer(
          'WindowingOwner',
          'WidgetsBinding.instance.windowingOwner factory',
          const Color(0xFF395A7F),
          false),
      _DiagramLayer(
          'Platform Implementation',
          'Linux (Wayland/X11)  •  macOS (Cocoa)  •  Windows (Win32)',
          const Color(0xFF2F4F2F),
          false),
    ];

    double y = 28.0;
    final double x = (w - boxW) / 2;

    final Paint arrowPaint = Paint()
      ..color = cs.onSurface.withAlpha(120)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < layers.length; i++) {
      final layer = layers[i];
      final rect =
          RRect.fromRectAndRadius(Rect.fromLTWH(x, y, boxW, boxH), const Radius.circular(10));

      // Box fill
      final Paint fillPaint = Paint()
        ..color = layer.color.withAlpha(layer.isHighlighted ? 220 : 160)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(rect, fillPaint);

      if (layer.isHighlighted) {
        // Glowing border
        final Paint borderPaint = Paint()
          ..color = Colors.orangeAccent
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;
        canvas.drawRRect(rect, borderPaint);
      }

      // Title text
      final titlePainter = TextPainter(
        text: TextSpan(
          text: layer.title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxW - 16);
      titlePainter.paint(canvas, Offset(x + 10, y + 6));

      // Subtitle text
      final subPainter = TextPainter(
        text: TextSpan(
          text: layer.subtitle,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxW - 16);
      subPainter.paint(canvas, Offset(x + 10, y + 27));

      // Draw arrow to next layer
      if (i < layers.length - 1) {
        final double arrowX = w / 2;
        final double arrowY0 = y + boxH;
        final double arrowY1 = y + boxH + gap;
        canvas.drawLine(
            Offset(arrowX, arrowY0), Offset(arrowX, arrowY1 - 8), arrowPaint);
        // arrowhead
        final Paint arrowHead = Paint()
          ..color = cs.onSurface.withAlpha(120)
          ..style = PaintingStyle.fill;
        final Path path = Path()
          ..moveTo(arrowX, arrowY1)
          ..lineTo(arrowX - 6, arrowY1 - 10)
          ..lineTo(arrowX + 6, arrowY1 - 10)
          ..close();
        canvas.drawPath(path, arrowHead);
      }

      y += boxH + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DiagramLayer {
  const _DiagramLayer(
      this.title, this.subtitle, this.color, this.isHighlighted);
  final String title;
  final String subtitle;
  final Color color;
  final bool isHighlighted;
}

class _ArchLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const items = <_LegendItem>[
      _LegendItem(Color(0xFF1A6B4A), 'Flutter App layer'),
      _LegendItem(Color(0xFF2E7D9C), 'Widget layer'),
      _LegendItem(Color(0xFF5B3E8D), 'Controller layer'),
      _LegendItem(Color(0xFFB8401A), 'Delegate layer (your override point)'),
      _LegendItem(Color(0xFF395A7F), 'Binding/Owner layer'),
      _LegendItem(Color(0xFF2F4F2F), 'Platform implementation layer'),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: items
          .map(
            (item) => Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 6),
                Text(item.label,
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _LegendItem {
  const _LegendItem(this.color, this.label);
  final Color color;
  final String label;
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — DELEGATE PATTERN EXPLANATION
// ═══════════════════════════════════════════════════════════════════════════

class _DelegatePatternTab extends StatelessWidget {
  const _DelegatePatternTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _DemoScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle('The Delegate Pattern', icon: Icons.extension_outlined),
          const SizedBox(height: 12),
          Text(
            'The delegate pattern decouples the "what should happen" decision '
            'from the "how to execute it" machinery. '
            'RegularWindowController handles platform calls; '
            'RegularWindowControllerDelegate handles policy.',
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: cs.onSurface.withAlpha(200),
            ),
          ),
          const SizedBox(height: 24),
          // Decision flow
          _SectionTitle('Decision Flow on Close Request',
              icon: Icons.alt_route_outlined),
          const SizedBox(height: 12),
          _DecisionFlow(),
          const SizedBox(height: 24),
          // Two-method contract
          _SectionTitle('The Two-Method Contract',
              icon: Icons.handshake_outlined),
          const SizedBox(height: 12),
          _MethodContractCard(
            methodName: 'onWindowCloseRequested',
            signature:
                'void onWindowCloseRequested(RegularWindowController controller)',
            description:
                'Called when the user clicks the OS-level close button (the ×). '
                'The default implementation immediately calls controller.destroy(). '
                'Override to show confirmation dialogs, save dirty state, or '
                'cancel the close entirely.',
            example:
                'class MyDelegate extends RegularWindowControllerDelegate {\n'
                '  @override\n'
                '  void onWindowCloseRequested(\n'
                '      RegularWindowController controller) {\n'
                '    if (_hasUnsavedChanges) {\n'
                '      _showSaveDialog(controller);\n'
                '    } else {\n'
                '      controller.destroy();\n'
                '    }\n'
                '  }\n'
                '}',
            iconData: Icons.close_rounded,
            color: Colors.deepOrange,
          ),
          const SizedBox(height: 16),
          _MethodContractCard(
            methodName: 'onWindowDestroyed',
            signature: 'void onWindowDestroyed()',
            description:
                'Called after the window has been destroyed — either by calling '
                'controller.destroy() or by the platform itself. '
                'Use this to clean up resources, remove the controller from '
                'a list, or navigate the app to a different state.',
            example:
                'class MyDelegate extends RegularWindowControllerDelegate {\n'
                '  @override\n'
                '  void onWindowDestroyed() {\n'
                '    // Remove this window from the app state manager.\n'
                '    AppWindowManager.instance.remove(windowId);\n'
                '  }\n'
                '}',
            iconData: Icons.delete_forever_outlined,
            color: Colors.purple,
          ),
          const SizedBox(height: 24),
          // mixin class vs extends
          _SectionTitle('mixin class — Not extends',
              icon: Icons.merge_outlined),
          const SizedBox(height: 12),
          _HighlightBox(
            color: cs.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'RegularWindowControllerDelegate is declared as a mixin class, '
                  'not a plain abstract class. This means:\n\n'
                  '• You can use it as a mixin: class MyDelegate with RegularWindowControllerDelegate\n'
                  '• You can use it as a base class: class MyDelegate extends RegularWindowControllerDelegate\n'
                  '• You can use it standalone: RegularWindowControllerDelegate() creates a default instance\n\n'
                  'The factory default (RegularWindowControllerDelegate()) is used when no delegate is provided.',
                  style: TextStyle(fontSize: 13, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Usage examples
          _SectionTitle('Usage Examples', icon: Icons.code_rounded),
          const SizedBox(height: 12),
          _CodeBlock(
            '// ── Example 1: Default delegate (close = destroy) ────────────\n'
            'final controller = RegularWindowController(\n'
            '  preferredSize: const Size(800, 600),\n'
            '  title: \'My Window\',\n'
            '  // delegate omitted → uses RegularWindowControllerDelegate()\n'
            ');\n'
            '\n'
            '// ── Example 2: Custom close guard ────────────────────────────\n'
            'class _SaveGuardDelegate extends RegularWindowControllerDelegate {\n'
            '  _SaveGuardDelegate(this.onClose);\n'
            '  final VoidCallback onClose;\n'
            '\n'
            '  @override\n'
            '  void onWindowCloseRequested(RegularWindowController c) {\n'
            '    showDialog<bool>(\n'
            '      context: navigatorKey.currentContext!,\n'
            '      builder: (_) => const _UnsavedDialog(),\n'
            '    ).then((confirmed) {\n'
            '      if (confirmed == true) c.destroy();\n'
            '    });\n'
            '  }\n'
            '\n'
            '  @override\n'
            '  void onWindowDestroyed() => onClose();\n'
            '}\n'
            '\n'
            'final controller = RegularWindowController(\n'
            '  delegate: _SaveGuardDelegate(() => windowList.remove(this)),\n'
            ');',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _DecisionFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const steps = <_FlowStep>[
      _FlowStep('User clicks ×', 'OS close button or cmd+W', Icons.mouse_outlined,
          Color(0xFF455A64)),
      _FlowStep('Platform fires event',
          'Win32/Cocoa/Wayland window event', Icons.send_outlined,
          Color(0xFF00695C)),
      _FlowStep('Controller receives event',
          'RegularWindowControllerLinux/MacOS/Win32',
          Icons.settings_input_component_outlined, Color(0xFF4527A0)),
      _FlowStep('Delegate.onWindowCloseRequested() called',
          'Your policy code runs here', Icons.call_outlined,
          Color(0xFFB71C1C)),
      _FlowStep('controller.destroy() (if allowed)',
          'Platform destroys native window', Icons.delete_outlined,
          Color(0xFF1565C0)),
      _FlowStep('Delegate.onWindowDestroyed() called',
          'Cleanup — remove from window list', Icons.done_all_outlined,
          Color(0xFF2E7D32)),
    ];
    return Column(
      children: <Widget>[
        for (int i = 0; i < steps.length; i++) ...<Widget>[
          _FlowStepTile(step: steps[i]),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Icon(
                Icons.arrow_downward_rounded,
                color: cs.onSurface.withAlpha(100),
                size: 20,
              ),
            ),
        ],
      ],
    );
  }
}

class _FlowStep {
  const _FlowStep(this.title, this.subtitle, this.icon, this.color);
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}

class _FlowStepTile extends StatelessWidget {
  const _FlowStepTile({required this.step});
  final _FlowStep step;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: step.color.withAlpha(20),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: step.color.withAlpha(80)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: step.color.withAlpha(40),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(step.icon, color: step.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  step.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: step.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  step.subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MethodContractCard extends StatelessWidget {
  const _MethodContractCard({
    required this.methodName,
    required this.signature,
    required this.description,
    required this.example,
    required this.iconData,
    required this.color,
  });
  final String methodName;
  final String signature;
  final String description;
  final String example;
  final IconData iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(120)),
        color: color.withAlpha(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color.withAlpha(40),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: <Widget>[
                Icon(iconData, color: color, size: 20),
                const SizedBox(width: 10),
                Text(
                  methodName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: color,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  signature,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(description,
                    style:
                        const TextStyle(fontSize: 13, height: 1.6)),
                const SizedBox(height: 12),
                _CodeBlock(example),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 4 — SIMULATED WINDOW STATE
// ═══════════════════════════════════════════════════════════════════════════

class _SimulatedWindowTab extends StatelessWidget {
  const _SimulatedWindowTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _DemoScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle('Simulated Window Chrome',
              icon: Icons.desktop_windows_outlined),
          const SizedBox(height: 8),
          Text(
            'The buttons below simulate the window state transitions that '
            'RegularWindowController provides. The delegate\'s '
            'onWindowCloseRequested intercept point is shown in action.',
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: cs.onSurface.withAlpha(180),
            ),
          ),
          const SizedBox(height: 20),
          // Simulated window
          _SimulatedWindowFrame(),
          const SizedBox(height: 20),
          // State info
          _SectionTitle('Current Controller State',
              icon: Icons.info_outline_rounded),
          const SizedBox(height: 12),
          _WindowStateInfo(),
          const SizedBox(height: 20),
          // Controller API used
          _SectionTitle('Controller Methods Invoked',
              icon: Icons.functions_outlined),
          const SizedBox(height: 12),
          _CodeBlock(
            '// All of these are methods on RegularWindowController:\n'
            'controller.activate();            // restore / show\n'
            'controller.setMinimized(true);    // minimize\n'
            'controller.setMaximized(true);    // maximize\n'
            'controller.setMaximized(false);   // restore from maximized\n'
            'controller.setFullscreen(true);   // fullscreen\n'
            'controller.setFullscreen(false);  // exit fullscreen\n'
            'controller.destroy();             // called by delegate on close\n'
            '\n'
            '// Delegate intercept:\n'
            'delegate.onWindowCloseRequested(controller); // → close button\n'
            'delegate.onWindowDestroyed();                // → after destroy()',
          ),
          const SizedBox(height: 24),
          // Close dialog simulation
          _SectionTitle('Delegate Close Guard Demo',
              icon: Icons.shield_outlined),
          const SizedBox(height: 12),
          _CloseGuardDemo(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _SimulatedWindowFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<_WindowState>(
      valueListenable: _windowState,
      builder: (context, state, _) {
        return Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant, width: 2),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: cs.shadow.withAlpha(60),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              // Title bar
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: state == _WindowState.closed
                      ? Colors.grey.shade700
                      : cs.primary,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10)),
                ),
                child: Row(
                  children: <Widget>[
                    // macOS-style traffic lights
                    _TrafficLight(
                      Colors.red.shade400,
                      () {
                        _addLifecycleEvent(
                            'onWindowCloseRequested', Colors.red);
                        _closeDialogVisible.value = true;
                      },
                    ),
                    const SizedBox(width: 6),
                    _TrafficLight(Colors.orange.shade400, () {
                      _windowState.value = _WindowState.minimized;
                      _addLifecycleEvent('setMinimized(true)', Colors.orange);
                    }),
                    const SizedBox(width: 6),
                    _TrafficLight(Colors.green.shade400, () {
                      _windowState.value =
                          state == _WindowState.maximized
                              ? _WindowState.normal
                              : _WindowState.maximized;
                      _addLifecycleEvent(
                          state == _WindowState.maximized
                              ? 'setMaximized(false)'
                              : 'setMaximized(true)',
                          Colors.green);
                    }),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _windowTitleFor(state),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: cs.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              // Window content area
              AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeInOut,
                height: _heightFor(state),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: state == _WindowState.minimized
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.minimize_rounded,
                                size: 40,
                                color: cs.onSurface.withAlpha(120)),
                            const SizedBox(height: 8),
                            Text('Window minimized',
                                style: TextStyle(
                                    color: cs.onSurface.withAlpha(120))),
                          ],
                        ),
                      )
                    : state == _WindowState.closed
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.close_rounded,
                                    size: 40, color: Colors.red.shade300),
                                const SizedBox(height: 8),
                                const Text(
                                  'Window destroyed\ndestroy() called',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red),
                                ),
                                const SizedBox(height: 16),
                                FilledButton.tonal(
                                  onPressed: () {
                                    _windowState.value = _WindowState.normal;
                                    _addLifecycleEvent(
                                        'activate() — window recreated',
                                        Colors.green);
                                  },
                                  child: const Text('Recreate Window'),
                                ),
                              ],
                            ),
                          )
                        : _WindowContentDemo(state: state),
              ),
            ],
          ),
        );
      },
    );
  }

  String _windowTitleFor(_WindowState s) {
    return switch (s) {
      _WindowState.normal => 'My Desktop App — Normal',
      _WindowState.minimized => 'My Desktop App — Minimized',
      _WindowState.maximized => 'My Desktop App — Maximized',
      _WindowState.fullscreen => 'My Desktop App — Fullscreen',
      _WindowState.closed => 'My Desktop App — Closed',
    };
  }

  double _heightFor(_WindowState s) {
    return switch (s) {
      _WindowState.minimized => 80,
      _WindowState.maximized => 340,
      _WindowState.fullscreen => 340,
      _ => 200,
    };
  }
}

class _TrafficLight extends StatelessWidget {
  const _TrafficLight(this.color, this.onTap);
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12),
        ),
      ),
    );
  }
}

class _WindowContentDemo extends StatelessWidget {
  const _WindowContentDemo({required this.state});
  final _WindowState state;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Window Content Area',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'State: ${state.name.toUpperCase()}',
          style: TextStyle(
            color: cs.primary,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            FilledButton.icon(
              onPressed: () {
                _windowState.value = _WindowState.fullscreen;
                _addLifecycleEvent('setFullscreen(true)', Colors.blue);
              },
              icon: const Icon(Icons.fullscreen_rounded, size: 16),
              label: const Text('Fullscreen'),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {
                _windowState.value = _WindowState.normal;
                _addLifecycleEvent('activate()', Colors.green);
              },
              icon: const Icon(Icons.crop_square_rounded, size: 16),
              label: const Text('Restore'),
            ),
          ],
        ),
      ],
    );
  }
}

class _WindowStateInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<_WindowState>(
      valueListenable: _windowState,
      builder: (context, state, _) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.secondaryContainer.withAlpha(60),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.secondaryContainer),
          ),
          child: Column(
            children: <Widget>[
              _StateRow('isActivated',
                  state == _WindowState.normal ||
                      state == _WindowState.maximized ||
                      state == _WindowState.fullscreen),
              _StateRow('isMaximized', state == _WindowState.maximized),
              _StateRow('isMinimized', state == _WindowState.minimized),
              _StateRow('isFullscreen', state == _WindowState.fullscreen),
              _StateRow('isDestroyed', state == _WindowState.closed),
            ],
          ),
        );
      },
    );
  }
}

class _StateRow extends StatelessWidget {
  const _StateRow(this.name, this.value);
  final String name;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 13),
          ),
          const Spacer(),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: value
                  ? Colors.green.withAlpha(40)
                  : Colors.grey.withAlpha(40),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value ? 'true' : 'false',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: value ? Colors.green.shade700 : Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseGuardDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<bool>(
      valueListenable: _closeDialogVisible,
      builder: (context, visible, _) {
        return Column(
          children: <Widget>[
            if (visible) ...<Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cs.errorContainer.withAlpha(80),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: cs.error.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.shield_outlined, color: cs.error),
                        const SizedBox(width: 8),
                        Text(
                          'Delegate intercepted close request!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: cs.error,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'onWindowCloseRequested() was called. '
                      'The delegate is preventing immediate destruction. '
                      'In a real app this would show a native dialog.',
                      style: TextStyle(fontSize: 13, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        FilledButton(
                          onPressed: () {
                            _closeDialogVisible.value = false;
                            _windowState.value = _WindowState.closed;
                            _addLifecycleEvent(
                                'controller.destroy() confirmed',
                                Colors.red);
                            _addLifecycleEvent(
                                'onWindowDestroyed()', Colors.deepPurple);
                          },
                          style: FilledButton.styleFrom(
                              backgroundColor: cs.error),
                          child: const Text('Confirm Close'),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () {
                            _closeDialogVisible.value = false;
                            _addLifecycleEvent(
                                'Close cancelled by delegate',
                                Colors.green);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ] else ...<Widget>[
              _HighlightBox(
                color: cs.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Click the red traffic-light button on the window above '
                      'to trigger onWindowCloseRequested. The delegate will '
                      'intercept and show this panel.',
                      style: TextStyle(fontSize: 13, height: 1.5),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.tonal(
                      onPressed: () {
                        _closeDialogVisible.value = true;
                        _addLifecycleEvent(
                            'onWindowCloseRequested', Colors.red);
                      },
                      child:
                          const Text('Simulate Close Request'),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            // Lifecycle log
            _LifecycleLogPanel(),
          ],
        );
      },
    );
  }
}

class _LifecycleLogPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<List<_LifecycleEvent>>(
      valueListenable: _lifecycleLog,
      builder: (context, log, _) {
        if (log.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Lifecycle Event Log',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface.withAlpha(160),
                ),
              ),
              const SizedBox(height: 8),
              for (final event in log.reversed)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: event.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        event.timestamp,
                        style: TextStyle(
                          fontSize: 10,
                          color: cs.onSurface.withAlpha(120),
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        event.label,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 5 — PLATFORM-SPECIFIC DELEGATES
// ═══════════════════════════════════════════════════════════════════════════

class _PlatformsTab extends StatelessWidget {
  const _PlatformsTab();

  static const List<_PlatformCard> _cards = <_PlatformCard>[
    _PlatformCard(
      platform: 'macOS',
      className: 'RegularWindowControllerMacOS',
      icon: Icons.laptop_mac_outlined,
      color: Color(0xFF0D47A1),
      details: <String>[
        'Source: _window_macos.dart',
        'Backend: Cocoa (NSWindow)',
        'Close button: red traffic light',
        'Minimize button: yellow traffic light',
        'Zoom button: green traffic light',
        'Supports fullscreen (macOS native)',
        'Title bar: integrated macOS chrome',
      ],
      notes:
          'macOS windowing uses the Cocoa NSWindow API via Flutter\'s macOS '
          'embedding layer. The delegate fires when the user clicks the red '
          'button or presses Cmd+W.',
    ),
    _PlatformCard(
      platform: 'Linux',
      className: 'RegularWindowControllerLinux',
      icon: Icons.computer_outlined,
      color: Color(0xFF1B5E20),
      details: <String>[
        'Source: _window_linux.dart',
        'Backend: GTK / Wayland or X11',
        'Close: compositor-provided button',
        'Minimize/maximize: WM decorations',
        'Title bar: GTK header bar',
        'Varies per window manager',
        'Wayland & X11 both supported',
      ],
      notes:
          'Linux windowing is handled through GTK. Behavior depends on the '
          'window manager and compositor in use (GNOME, KDE, etc.). The '
          'delegate fires on the standard "delete-event".',
    ),
    _PlatformCard(
      platform: 'Windows',
      className: 'RegularWindowControllerWin32',
      icon: Icons.window_outlined,
      color: Color(0xFF37474F),
      details: <String>[
        'Source: _window_win32.dart',
        'Backend: Win32 API (HWND)',
        'Close button: ✕ in title bar',
        'Minimize: _ button',
        'Maximize: □ button',
        'Responds to WM_CLOSE message',
        'Standard Win32 chrome',
      ],
      notes:
          'Win32 uses standard HWND-based windows. The delegate fires on '
          'WM_CLOSE. Win32 DWM provides the standard title bar unless custom '
          'chrome is used.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _DemoScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle('Platform-Specific Delegates',
              icon: Icons.dns_outlined),
          const SizedBox(height: 12),
          const Text(
            'Each desktop platform has its own RegularWindowController '
            'implementation. The delegate API is identical across all three, '
            'but the underlying machinery differs significantly.',
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 20),
          // Platform selector
          ValueListenableBuilder<String>(
            valueListenable: _selectedPlatform,
            builder: (context, selected, _) {
              return Column(
                children: <Widget>[
                  Row(
                    children: _cards
                        .map(
                          (c) => Expanded(
                            child: GestureDetector(
                              onTap: () => _selectedPlatform.value = c.platform,
                              child: _PlatformTab(
                                card: c,
                                selected: c.platform == selected,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  _PlatformDetail(
                    card: _cards.firstWhere((c) => c.platform == selected),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          // Common interface
          _SectionTitle('Common Interface Across Platforms',
              icon: Icons.compare_outlined),
          const SizedBox(height: 12),
          _CodeBlock(
            '// These abstract methods are common to all three platforms:\n'
            'abstract class RegularWindowController\n'
            '    extends BaseWindowController {\n'
            '  String get title;\n'
            '  bool get isActivated;\n'
            '  bool get isMaximized;\n'
            '  bool get isMinimized;\n'
            '  bool get isFullscreen;\n'
            '  Size get contentSize;\n'
            '\n'
            '  void setSize(Size size);\n'
            '  void setConstraints(BoxConstraints constraints);\n'
            '  void setTitle(String title);\n'
            '  void activate();\n'
            '  void setMaximized(bool maximized);\n'
            '  void setMinimized(bool minimized);\n'
            '  void setFullscreen(bool fullscreen, {Display? display});\n'
            '  void destroy();\n'
            '}',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _PlatformTab extends StatelessWidget {
  const _PlatformTab({required this.card, required this.selected});
  final _PlatformCard card;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: selected ? card.color : card.color.withAlpha(30),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: card.color),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            card.icon,
            color: selected ? Colors.white : card.color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            card.platform,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : card.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformDetail extends StatelessWidget {
  const _PlatformDetail({required this.card});
  final _PlatformCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card.color.withAlpha(15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: card.color.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(card.icon, color: card.color),
              const SizedBox(width: 10),
              Text(
                card.className,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: card.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...card.details.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('• ', style: TextStyle(color: card.color)),
                  Expanded(
                    child: Text(d, style: const TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            card.notes,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 6 — WINDOW LIFECYCLE DIAGRAM
// ═══════════════════════════════════════════════════════════════════════════

class _LifecycleTab extends StatelessWidget {
  const _LifecycleTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _DemoScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle('Window Lifecycle', icon: Icons.timeline_outlined),
          const SizedBox(height: 8),
          Text(
            'The lifecycle of a RegularWindowController from construction '
            'to final destruction, showing where delegate callbacks fire.',
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: cs.onSurface.withAlpha(180),
            ),
          ),
          const SizedBox(height: 20),
          _LifecycleTimeline(),
          const SizedBox(height: 24),
          _SectionTitle('State Transition Diagram (CustomPainter)',
              icon: Icons.account_tree_outlined),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 320,
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: CustomPaint(
              painter: _StateDiagramPainter(cs),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('ChangeNotifier Integration',
              icon: Icons.notifications_outlined),
          const SizedBox(height: 12),
          Text(
            'BaseWindowController extends ChangeNotifier. This means '
            'RegularWindowController is itself a Listenable. Widgets can call '
            'controller.addListener() to be notified when any property changes '
            '(size, maximized, minimized, fullscreen, title, activated).',
            style: TextStyle(fontSize: 13, height: 1.6),
          ),
          const SizedBox(height: 12),
          _CodeBlock(
            '// Listen to controller state changes:\n'
            'controller.addListener(() {\n'
            '  if (controller.isMaximized) {\n'
            '    toolbarController.hideToolbar();\n'
            '  }\n'
            '  if (controller.isMinimized) {\n'
            '    animationController.pause();\n'
            '  }\n'
            '});\n'
            '\n'
            '// Or use ListenableBuilder in the widget tree:\n'
            'ListenableBuilder(\n'
            '  listenable: windowController,\n'
            '  builder: (context, child) => Text(\n'
            '    windowController.title,\n'
            '  ),\n'
            ');',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _LifecycleTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const events = <_TimelineEvent>[
      _TimelineEvent(
        phase: 'Construction',
        description:
            'RegularWindowController() factory called. Platform window is '
            'created immediately. WindowingOwner manufactures the platform '
            'implementation. Delegate stored internally.',
        delegateCall: null,
        color: Color(0xFF1565C0),
        icon: Icons.build_circle_outlined,
      ),
      _TimelineEvent(
        phase: 'Shown / Activated',
        description:
            'Window appears on screen. Controller fires ChangeNotifier. '
            'isActivated becomes true. RegularWindow widget renders content '
            'into this view.',
        delegateCall: null,
        color: Color(0xFF2E7D32),
        icon: Icons.visibility_outlined,
      ),
      _TimelineEvent(
        phase: 'Focus Changes',
        description:
            'User clicks on another window → isActivated becomes false. '
            'Returns to foreground → isActivated true. '
            'ChangeNotifier notifies all listeners on each change.',
        delegateCall: null,
        color: Color(0xFF558B2F),
        icon: Icons.filter_center_focus_outlined,
      ),
      _TimelineEvent(
        phase: 'Minimize / Restore',
        description:
            'setMinimized(true) → isMinimized true, contentSize may change. '
            'setMinimized(false) / activate() → window returns to prior size.',
        delegateCall: null,
        color: Color(0xFF6A1B9A),
        icon: Icons.minimize_rounded,
      ),
      _TimelineEvent(
        phase: 'Maximize / Fullscreen',
        description:
            'setMaximized(true) → fills screen. setFullscreen(true) → '
            'hides all chrome. Platform may ignore either request.',
        delegateCall: null,
        color: Color(0xFF00695C),
        icon: Icons.fullscreen_rounded,
      ),
      _TimelineEvent(
        phase: 'Close Requested',
        description:
            'User clicks close button or presses the OS close shortcut. '
            'Platform event propagates up to the controller which forwards '
            'to the delegate.',
        delegateCall: 'delegate.onWindowCloseRequested(controller)',
        color: Color(0xFFB71C1C),
        icon: Icons.close_rounded,
      ),
      _TimelineEvent(
        phase: 'Destruction',
        description:
            'controller.destroy() has been called (either by the delegate '
            'or programmatically). Platform destroys the native window. '
            'FlutterView is torn down. ChangeNotifier fires a final time.',
        delegateCall: 'delegate.onWindowDestroyed()',
        color: Color(0xFF4E342E),
        icon: Icons.delete_forever_outlined,
      ),
    ];

    return Column(
      children: <Widget>[
        for (int i = 0; i < events.length; i++) ...<Widget>[
          _TimelineTile(event: events[i], isLast: i == events.length - 1),
        ],
      ],
    );
  }
}

class _TimelineEvent {
  const _TimelineEvent({
    required this.phase,
    required this.description,
    this.delegateCall,
    required this.color,
    required this.icon,
  });
  final String phase;
  final String description;
  final String? delegateCall;
  final Color color;
  final IconData icon;
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({required this.event, required this.isLast});
  final _TimelineEvent event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Timeline spine
          SizedBox(
            width: 40,
            child: Column(
              children: <Widget>[
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: event.color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(event.icon, color: Colors.white, size: 16),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: event.color.withAlpha(60),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    event.phase,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: event.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.description,
                    style: const TextStyle(fontSize: 13, height: 1.5),
                  ),
                  if (event.delegateCall != null) ...<Widget>[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(30),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Colors.red.withAlpha(80)),
                      ),
                      child: Text(
                        '← ${event.delegateCall}',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StateDiagramPainter extends CustomPainter {
  _StateDiagramPainter(this.cs);
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    const List<_StateNode> nodes = <_StateNode>[
      _StateNode('normal', Offset(0, 0), Color(0xFF2E7D32)),
      _StateNode('minimized', Offset(-1.2, 1), Color(0xFF6A1B9A)),
      _StateNode('maximized', Offset(0, 1), Color(0xFF1565C0)),
      _StateNode('fullscreen', Offset(1.2, 1), Color(0xFF00695C)),
      _StateNode('closed', Offset(0, 2), Color(0xFFB71C1C)),
    ];
    const double scale = 70.0;
    const double offsetX = 0;
    const double offsetY = 50;

    final Map<String, Offset> positions = <String, Offset>{};
    for (final n in nodes) {
      positions[n.label] = Offset(
        cx + offsetX + n.rel.dx * scale,
        offsetY + n.rel.dy * scale,
      );
    }

    // Draw edges
    final Paint edgePaint = Paint()
      ..color = cs.onSurface.withAlpha(80)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final edges = <List<String>>[
      <String>['normal', 'minimized'],
      <String>['normal', 'maximized'],
      <String>['normal', 'fullscreen'],
      <String>['minimized', 'normal'],
      <String>['maximized', 'normal'],
      <String>['fullscreen', 'normal'],
      <String>['normal', 'closed'],
      <String>['minimized', 'closed'],
      <String>['maximized', 'closed'],
      <String>['fullscreen', 'closed'],
    ];

    for (final edge in edges) {
      final from = positions[edge[0]]!;
      final to = positions[edge[1]]!;
      canvas.drawLine(from, to, edgePaint);
    }

    // Draw nodes
    for (final n in nodes) {
      final pos = positions[n.label]!;
      final Paint fill = Paint()
        ..color = n.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos, 28, fill);

      final tp = TextPainter(
        text: TextSpan(
          text: n.label,
          style: const TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 56);
      tp.paint(
          canvas, pos - Offset(tp.width / 2, tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StateNode {
  const _StateNode(this.label, this.rel, this.color);
  final String label;
  final Offset rel;
  final Color color;
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 7 — COMPARISON
// ═══════════════════════════════════════════════════════════════════════════

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _DemoScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle('API Comparison', icon: Icons.compare_arrows_rounded),
          const SizedBox(height: 12),
          Text(
            'How RegularWindowController and its delegate compare to older '
            'and alternative approaches in Flutter desktop development.',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: cs.onSurface.withAlpha(180),
            ),
          ),
          const SizedBox(height: 24),
          // Main comparison table
          _ComparisonTable(),
          const SizedBox(height: 24),
          _SectionTitle('vs SingletonFlutterWindow',
              icon: Icons.compare_outlined),
          const SizedBox(height: 12),
          _ComparisonCard(
            left: _ComparisonSide(
              label: 'SingletonFlutterWindow\n(legacy)',
              color: Colors.grey.shade600,
              points: const <String>[
                'Global window via WidgetsBinding.window',
                'Single window only — deprecated',
                'No delegate pattern',
                'No multi-window support',
                'Accessed via ui.window',
                'Closing handled by platform channel',
              ],
            ),
            right: _ComparisonSide(
              label: 'RegularWindowController\n(new)',
              color: cs.primary,
              points: const <String>[
                'Per-window controller object',
                'Multi-window from the start',
                'Delegate pattern for lifecycle',
                'Programmatic size + constraints',
                'Integrated ChangeNotifier',
                'Platform-agnostic factory API',
              ],
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('vs platform_window (community package)',
              icon: Icons.compare_outlined),
          const SizedBox(height: 12),
          _ComparisonCard(
            left: _ComparisonSide(
              label: 'platform_window\n(pub.dev package)',
              color: Colors.brown.shade500,
              points: const <String>[
                'Community-maintained',
                'Stable API on pub.dev',
                'Win32 / macOS / Linux',
                'Plugin-channel architecture',
                'Close / minimize / maximize',
                'No built-in delegate pattern',
              ],
            ),
            right: _ComparisonSide(
              label: 'RegularWindowController\n(Flutter internal)',
              color: cs.primary,
              points: const <String>[
                'Flutter team maintained',
                'Experimental / @internal',
                'Main channel only',
                'Native embedding integration',
                'Full lifecycle delegate',
                'ChangeNotifier built-in',
              ],
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('vs DialogWindowController',
              icon: Icons.layers_outlined),
          const SizedBox(height: 12),
          _HighlightBox(
            color: cs.secondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'RegularWindowController is one of four controller types. '
                  'The others are:\n\n'
                  '• DialogWindowController — modal/sheet window, '
                  'attached to a parent (DialogWindowControllerDelegate)\n'
                  '• TooltipWindowController — tooltip overlay window '
                  '(TooltipWindowControllerDelegate)\n'
                  '• PopupWindowController — popup/menu window '
                  '(PopupWindowControllerDelegate)\n\n'
                  'All share the same delegate mixin class pattern. '
                  'RegularWindowController is for top-level, independently '
                  'managed app windows only.',
                  style: TextStyle(fontSize: 13, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const rows = <List<String>>[
      <String>['Feature', 'RegularWindowController', 'SingletonFlutterWindow'],
      <String>['Multi-window', 'Yes', 'No'],
      <String>['Delegate pattern', 'Yes', 'No'],
      <String>['ChangeNotifier', 'Yes', 'No'],
      <String>['Size constraints', 'Yes (BoxConstraints)', 'No'],
      <String>['Fullscreen API', 'Yes', 'Limited'],
      <String>['Status', '@internal / experimental', 'Deprecated'],
      <String>['Channel', 'main only', 'All (legacy)'],
    ];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            Container(
              decoration: BoxDecoration(
                color: i == 0
                    ? cs.primaryContainer.withAlpha(80)
                    : i.isOdd
                        ? cs.surfaceContainerHighest.withAlpha(60)
                        : null,
                borderRadius: i == 0
                    ? const BorderRadius.vertical(top: Radius.circular(10))
                    : i == rows.length - 1
                        ? const BorderRadius.vertical(
                            bottom: Radius.circular(10))
                        : null,
              ),
              child: Row(
                children: <Widget>[
                  for (int j = 0; j < rows[i].length; j++)
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: j < rows[i].length - 1
                            ? BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color: cs.outlineVariant),
                                ),
                              )
                            : null,
                        child: Text(
                          rows[i][j],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: i == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: i == 0
                                ? cs.onPrimaryContainer
                                : cs.onSurface,
                          ),
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
}

class _ComparisonSide {
  const _ComparisonSide(
      {required this.label, required this.color, required this.points});
  final String label;
  final Color color;
  final List<String> points;
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({required this.left, required this.right});
  final _ComparisonSide left;
  final _ComparisonSide right;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _SideCard(side: left)),
        const SizedBox(width: 12),
        Expanded(child: _SideCard(side: right)),
      ],
    );
  }
}

class _SideCard extends StatelessWidget {
  const _SideCard({required this.side});
  final _ComparisonSide side;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: side.color.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: side.color.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            side.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: side.color,
            ),
          ),
          const SizedBox(height: 10),
          ...side.points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('• ', style: TextStyle(color: side.color)),
                  Expanded(
                    child:
                        Text(p, style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 8 — USE CASES
// ═══════════════════════════════════════════════════════════════════════════

class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  static const List<_UseCaseCard> _cases = <_UseCaseCard>[
    _UseCaseCard(
      title: 'Multi-Window Document App',
      icon: Icons.article_outlined,
      color: Color(0xFF1565C0),
      description:
          'Open multiple document windows (like Xcode or VS Code). Each '
          'window gets its own RegularWindowController. The delegate tracks '
          'unsaved changes per-window and guards each close independently.',
      delegateUsage:
          'onWindowCloseRequested → check dirty state\n'
          'onWindowDestroyed → remove from window list',
    ),
    _UseCaseCard(
      title: 'Splash / Welcome Screen',
      icon: Icons.amp_stories_outlined,
      color: Color(0xFF6A1B9A),
      description:
          'Show a splash window at startup with no decorations. When the '
          'main app loads, destroy the splash window via its controller.',
      delegateUsage:
          'onWindowDestroyed → trigger main window show\n'
          'No close guard needed (auto-destroy on timer)',
    ),
    _UseCaseCard(
      title: 'Settings Window',
      icon: Icons.settings_outlined,
      color: Color(0xFF00695C),
      description:
          'Dedicated settings window that can be opened from the menu bar. '
          'Delegate saves pending settings on close and prevents close '
          'if validation fails.',
      delegateUsage:
          'onWindowCloseRequested → validate + save\n'
          'onWindowDestroyed → notify main window',
    ),
    _UseCaseCard(
      title: 'About / Info Window',
      icon: Icons.info_outline_rounded,
      color: Color(0xFF37474F),
      description:
          'Lightweight about window showing app version, licenses, and '
          'links. Uses default delegate (no close guard) — just destroy '
          'on close. Singleton pattern: only one instance at a time.',
      delegateUsage:
          'Default delegate (close = destroy)\n'
          'onWindowDestroyed → clear static reference',
    ),
    _UseCaseCard(
      title: 'Secondary Monitor Window',
      icon: Icons.monitor_outlined,
      color: Color(0xFFB71C1C),
      description:
          'Extend app content to a second display using setFullscreen '
          'with a specific Display. The delegate prevents accidental close '
          'and re-opens if the display disconnects and reconnects.',
      delegateUsage:
          'onWindowCloseRequested → ask user intent\n'
          'setFullscreen(true, display: secondMonitor)',
    ),
    _UseCaseCard(
      title: 'Preview / Inspector Window',
      icon: Icons.preview_outlined,
      color: Color(0xFF558B2F),
      description:
          'Live preview window that tracks the main window\'s content. '
          'ListenableBuilder on the controller keeps the preview in sync '
          'with maximize/restore/fullscreen state changes.',
      delegateUsage:
          'controller.addListener → sync layout\n'
          'onWindowDestroyed → hide preview icon',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _DemoScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle('Use Cases', icon: Icons.widgets_outlined),
          const SizedBox(height: 12),
          const Text(
            'Six practical scenarios where RegularWindowControllerDelegate '
            'adds real value to a desktop Flutter application.',
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _cases.length,
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 360,
              mainAxisExtent: 280,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, i) =>
                _UseCaseTile(useCase: _cases[i]),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _UseCaseTile extends StatelessWidget {
  const _UseCaseTile({required this.useCase});
  final _UseCaseCard useCase;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: useCase.color.withAlpha(15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: useCase.color.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: useCase.color.withAlpha(40),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(useCase.icon,
                    color: useCase.color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  useCase.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: useCase.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              useCase.description,
              style: const TextStyle(fontSize: 12, height: 1.5),
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: useCase.color.withAlpha(25),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              useCase.delegateUsage,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: useCase.color,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 9 — PITFALLS + API CHEAT SHEET
// ═══════════════════════════════════════════════════════════════════════════

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  static const List<_ApiMethod> _methods = <_ApiMethod>[
    // Controller methods
    _ApiMethod(
      signature: 'String get title',
      description: 'Current window title (may differ from requested title)',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'bool get isActivated',
      description: 'True if window is focused and receiving input',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'bool get isMaximized',
      description: 'True if window occupies maximum available space',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'bool get isMinimized',
      description: 'True if window is hidden to taskbar/dock',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'bool get isFullscreen',
      description: 'True if window hides all OS chrome',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'Size get contentSize',
      description: 'Current drawable content area size',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'void setSize(Size size)',
      description: 'Request new content size (platform may ignore)',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'void setConstraints(BoxConstraints c)',
      description: 'Set min/max size constraints on the window',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'void setTitle(String title)',
      description: 'Change the window title bar text',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'void activate()',
      description: 'Restore, focus and bring window to front',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'void setMaximized(bool maximized)',
      description: 'Maximize or restore from maximized',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'void setMinimized(bool minimized)',
      description: 'Minimize or restore from minimized',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'void setFullscreen(bool, {Display? display})',
      description: 'Enter or exit fullscreen, optionally on a specific display',
      isDelegate: false,
    ),
    _ApiMethod(
      signature: 'void destroy()',
      description: 'Destroy the native window and release resources',
      isDelegate: false,
    ),
    // Delegate methods
    _ApiMethod(
      signature: 'void onWindowCloseRequested(controller)',
      description:
          'User requested close. Default: controller.destroy(). Override to guard.',
      isDelegate: true,
    ),
    _ApiMethod(
      signature: 'void onWindowDestroyed()',
      description:
          'Window was destroyed. Override to clean up app state.',
      isDelegate: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const pitfalls = <_Pitfall>[
      _Pitfall(
        title: 'Desktop-Only — No Mobile Support',
        icon: Icons.phone_iphone_outlined,
        color: Colors.red,
        description:
            'RegularWindowController and its delegate are 100% desktop-only '
            'APIs. They do not exist on iOS, Android, or web. Any call to '
            'RegularWindowController() on a non-windowing platform throws '
            'UnsupportedError. Always gate with Platform.isDesktop or '
            'isWindowingEnabled.',
        code:
            '// Guard before use:\n'
            'if (isWindowingEnabled) {\n'
            '  final c = RegularWindowController(...);\n'
            '}',
      ),
      _Pitfall(
        title: 'Platform Lifecycle Differences',
        icon: Icons.warning_amber_outlined,
        color: Colors.orange,
        description:
            'The order and frequency of delegate callbacks can differ '
            'between macOS, Linux, and Windows. On macOS, Cmd+Q triggers '
            'onWindowCloseRequested for all windows. On Windows, Alt+F4 '
            'only fires for the foreground window. Always test on all '
            'target platforms.',
        code:
            '// macOS: Cmd+Q fires for all open windows\n'
            '// Windows: Alt+F4 fires for active window only\n'
            '// Linux: WM_DELETE_WINDOW per-window',
      ),
      _Pitfall(
        title: '@internal — Breaking Changes Guaranteed',
        icon: Icons.broken_image_outlined,
        color: Colors.purple,
        description:
            'Every public API in this file is marked @internal. Flutter '
            'will make breaking changes in minor and patch releases. '
            'Do not use this API in packages published to pub.dev. '
            'Even in private apps, pin your Flutter version and review '
            'the changelog on every update.',
        code:
            '// In pubspec.yaml, pin your Flutter SDK:\n'
            'environment:\n'
            '  flutter: "=3.41.6"  # pin, do not use ^',
      ),
      _Pitfall(
        title: 'Forgetting to Destroy',
        icon: Icons.memory_outlined,
        color: Colors.brown,
        description:
            'If you override onWindowCloseRequested and never call '
            'controller.destroy(), the native window handle leaks. '
            'The FlutterView and its rendering resources remain allocated. '
            'Always ensure every code path through onWindowCloseRequested '
            'eventually calls destroy().',
        code:
            '// BAD — no destroy on cancel path:\n'
            'void onWindowCloseRequested(c) {\n'
            '  showDialog(...).then((ok) {\n'
            '    if (ok == true) c.destroy();\n'
            '    // LEAK if ok == false and never retried\n'
            '  });\n'
            '}\n'
            '\n'
            '// GOOD — always clean up eventually:\n'
            '// Track dirty state; destroy on app quit too.',
      ),
      _Pitfall(
        title: 'isWindowingEnabled Feature Flag',
        icon: Icons.flag_outlined,
        color: Colors.teal,
        description:
            'Even on a desktop platform, the windowing APIs are disabled '
            'unless the isWindowingEnabled feature flag is set to true. '
            'This flag must be enabled in the Flutter embedding before '
            'any controller code runs. Calling the factory without the '
            'flag throws UnsupportedError at runtime.',
        code:
            '// Check at runtime:\n'
            'import \'package:flutter/src/foundation/_features.dart\';\n'
            '\n'
            'if (!isWindowingEnabled) {\n'
            '  throw UnsupportedError(\'Windowing not enabled\');\n'
            '}',
      ),
      _Pitfall(
        title: 'Main Channel Only',
        icon: Icons.merge_type_outlined,
        color: Colors.blueGrey,
        description:
            'This API is only present in Flutter\'s main (master) channel. '
            'It does not exist in stable, beta, or dev channels. Your CI '
            'must use the main channel. Production apps cannot use this API '
            'until it graduates from the experimental phase.',
        code:
            '# Switch to main channel:\n'
            'flutter channel main\n'
            'flutter upgrade',
      ),
    ];

    return _DemoScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle('Common Pitfalls', icon: Icons.warning_amber_outlined),
          const SizedBox(height: 12),
          const Text(
            'Critical issues to watch out for when working with '
            'RegularWindowControllerDelegate.',
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 20),
          for (final p in pitfalls) ...<Widget>[
            _PitfallCard(pitfall: p),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 24),
          // API cheat sheet
          _SectionTitle('API Cheat Sheet', icon: Icons.menu_book_outlined),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _InfoChip('Controller methods', color: cs.primaryContainer),
              const SizedBox(width: 8),
              _InfoChip('Delegate methods',
                  color: Colors.red.shade100),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: cs.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < _methods.length; i++)
                  _ApiMethodRow(
                    method: _methods[i],
                    isLast: i == _methods.length - 1,
                    isFirst: i == 0,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Full minimal example
          _SectionTitle('Minimal Working Example',
              icon: Icons.code_rounded),
          const SizedBox(height: 12),
          _CodeBlock(
            '// ignore_for_file: invalid_use_of_internal_member\n'
            '// (required until the API graduates from experimental)\n'
            '\n'
            'import \'package:flutter/material.dart\';\n'
            'import \'package:flutter/widgets.dart\';\n'
            '\n'
            'class _AppDelegate extends RegularWindowControllerDelegate {\n'
            '  _AppDelegate(this._onClose);\n'
            '  final VoidCallback _onClose;\n'
            '\n'
            '  @override\n'
            '  void onWindowCloseRequested(RegularWindowController c) {\n'
            '    // Show save dialog, then call c.destroy() if confirmed.\n'
            '    c.destroy();\n'
            '  }\n'
            '\n'
            '  @override\n'
            '  void onWindowDestroyed() {\n'
            '    _onClose();\n'
            '  }\n'
            '}\n'
            '\n'
            'void openDocumentWindow(Size size, String title) {\n'
            '  if (!isWindowingEnabled) return;\n'
            '  final controller = RegularWindowController(\n'
            '    preferredSize: size,\n'
            '    preferredConstraints: BoxConstraints(\n'
            '      minWidth: 400,\n'
            '      minHeight: 300,\n'
            '    ),\n'
            '    title: title,\n'
            '    delegate: _AppDelegate(\n'
            '      () => windowRegistry.remove(title),\n'
            '    ),\n'
            '  );\n'
            '  windowRegistry.add(title, controller);\n'
            '}',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _Pitfall {
  const _Pitfall({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.code,
  });
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final String code;
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({required this.pitfall});
  final _Pitfall pitfall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: pitfall.color.withAlpha(15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: pitfall.color.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: pitfall.color.withAlpha(40),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(pitfall.icon, color: pitfall.color, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  pitfall.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: pitfall.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            pitfall.description,
            style: const TextStyle(fontSize: 13, height: 1.6),
          ),
          const SizedBox(height: 10),
          _CodeBlock(pitfall.code),
        ],
      ),
    );
  }
}

class _ApiMethodRow extends StatelessWidget {
  const _ApiMethodRow({
    required this.method,
    required this.isLast,
    required this.isFirst,
  });
  final _ApiMethod method;
  final bool isLast;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: method.isDelegate
            ? Colors.red.withAlpha(15)
            : isFirst || !isFirst
                ? null
                : null,
        borderRadius: isLast
            ? const BorderRadius.vertical(bottom: Radius.circular(12))
            : isFirst
                ? const BorderRadius.vertical(top: Radius.circular(12))
                : null,
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: cs.outlineVariant)),
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: method.isDelegate ? Colors.red : cs.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              method.signature,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: method.isDelegate
                    ? Colors.red.shade700
                    : cs.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              method.description,
              style: TextStyle(
                fontSize: 12,
                color: cs.onSurface.withAlpha(180),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math' as math;

import 'package:flutter/material.dart';

const _bg = Color(0xFFEFF4FA);
const _ink = Color(0xFF173346);
const _navy = Color(0xFF2D5A88);
const _teal = Color(0xFF2E8C81);
const _amber = Color(0xFFBD8E45);
const _rose = Color(0xFF9D607F);
const _violet = Color(0xFF6A61B0);

const _idHeader = 'header';
const _idRail = 'rail';
const _idCanvas = 'canvas';
const _idInspector = 'inspector';
const _idFooter = 'footer';
const _idFloating = 'floating';

const _idTop = 'top';
const _idLeft = 'left';
const _idMain = 'main';
const _idRight = 'right';
const _idBottom = 'bottom';
const _idOverlay = 'overlay';

const _idMenu = 'menu';
const _idEditor = 'editor';
const _idPreview = 'preview';
const _idTools = 'tools';
const _idConsole = 'console';
const _idPalette = 'palette';

dynamic build(BuildContext context) {
  return const _LayoutIdDeepDemoApp();
}

class _LayoutIdDeepDemoApp extends StatelessWidget {
  const _LayoutIdDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _navy),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _LayoutIdDeepDemoPage(),
    );
  }
}

class _LayoutIdDeepDemoPage extends StatefulWidget {
  const _LayoutIdDeepDemoPage();

  @override
  State<_LayoutIdDeepDemoPage> createState() => _LayoutIdDeepDemoPageState();
}

class _LayoutIdDeepDemoPageState extends State<_LayoutIdDeepDemoPage> {
  bool _compact = false;
  bool _showGuide = true;
  bool _showTips = true;
  bool _rtl = false;
  double _visualScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 86,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('LayoutId Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'CustomMultiChildLayout orchestration | role-based child mapping | delegate-driven placement',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ControlDeck(
                compact: _compact,
                showGuide: _showGuide,
                showTips: _showTips,
                rtl: _rtl,
                visualScale: _visualScale,
                onCompactChanged: (v) => setState(() => _compact = v),
                onShowGuideChanged: (v) => setState(() => _showGuide = v),
                onShowTipsChanged: (v) => setState(() => _showTips = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onScaleChanged: (v) => setState(() => _visualScale = v),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 1,
                tone: _navy,
                title: 'LayoutId Fundamentals Studio',
                subtitle:
                    'Introduces role-based layout with LayoutId and one delegate. Modify dimensions to observe predictable role placement changes.',
                child: _FundamentalsScene(
                  compact: _compact,
                  showGuide: _showGuide,
                  showTips: _showTips,
                  visualScale: _visualScale,
                ),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _teal,
                title: 'Pattern Gallery with Delegate Switching',
                subtitle:
                    'Reuses one child set while switching delegates to produce dashboard, poster, split-workbench, and floating-tray compositions.',
                child: _PatternGalleryScene(
                  compact: _compact,
                  showGuide: _showGuide,
                  showTips: _showTips,
                  visualScale: _visualScale,
                ),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Constraint and Compression Lab',
                subtitle:
                    'Explores how delegates react under constrained sizes and demonstrates how LayoutId enables structured degradation.',
                child: _ConstraintLabScene(
                  compact: _compact,
                  showGuide: _showGuide,
                  showTips: _showTips,
                ),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Responsive Class Remapping',
                subtitle:
                    'Narrow, medium, and wide width classes remap region geometry while LayoutId identities stay stable across breakpoints.',
                child: _ResponsiveScene(
                  compact: _compact,
                  showGuide: _showGuide,
                  showTips: _showTips,
                ),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _violet,
                title: 'Practical Workspace Composition',
                subtitle:
                    'A realistic editor workspace where panel ratios and overlays are orchestrated by a dedicated delegate via LayoutId roles.',
                child: _PracticalWorkspaceScene(
                  compact: _compact,
                  showGuide: _showGuide,
                  showTips: _showTips,
                ),
              ),
              const SizedBox(height: 12),
              const _RecapPanel(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.showGuide,
    required this.showTips,
    required this.rtl,
    required this.visualScale,
    required this.onCompactChanged,
    required this.onShowGuideChanged,
    required this.onShowTipsChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool showGuide;
  final bool showTips;
  final bool rtl;
  final double visualScale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGuideChanged;
  final ValueChanged<bool> onShowTipsChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF17354A), Color(0xFF2B5C7B), Color(0xFF496C8E), Color(0xFF6E5EA6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LayoutId Command Deck',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'LayoutId assigns semantic roles to children in CustomMultiChildLayout. '
            'Delegates then look up those roles and compute exact geometry for each child.',
            style: TextStyle(color: Color(0xFFE1ECF8), height: 1.34),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact heights', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: showGuide,
                  onChanged: onShowGuideChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide overlays', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: showTips,
                  onChanged: onShowTipsChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show tips', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Visual scale: ${visualScale.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: visualScale,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onScaleChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({
    required this.index,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color tone;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 15, offset: const Offset(0, 7)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: tone,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 19)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF3A4F60), height: 1.34)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _FundamentalsScene extends StatefulWidget {
  const _FundamentalsScene({
    required this.compact,
    required this.showGuide,
    required this.showTips,
    required this.visualScale,
  });

  final bool compact;
  final bool showGuide;
  final bool showTips;
  final double visualScale;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> {
  double _header = 74;
  double _rail = 124;
  double _footer = 64;
  double _gap = 10;
  bool _inspector = true;
  bool _floating = true;

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 660.0 : 800.0;

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackPanel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Layout controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _SliderTile(label: 'Header height', value: _header, min: 56, max: 130, onChanged: (v) => setState(() => _header = v)),
                      _SliderTile(label: 'Rail width', value: _rail, min: 80, max: 220, onChanged: (v) => setState(() => _rail = v)),
                      _SliderTile(label: 'Footer height', value: _footer, min: 48, max: 120, onChanged: (v) => setState(() => _footer = v)),
                      _SliderTile(label: 'Gap', value: _gap, min: 4, max: 24, onChanged: (v) => setState(() => _gap = v)),
                      SwitchListTile(
                        value: _inspector,
                        onChanged: (v) => setState(() => _inspector = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show inspector region'),
                      ),
                      SwitchListTile(
                        value: _floating,
                        onChanged: (v) => setState(() => _floating = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show floating utility panel'),
                      ),
                      const SizedBox(height: 8),
                      _InfoTable(
                        rows: [
                          _InfoRow(label: 'header', value: '${_header.toStringAsFixed(1)} px'),
                          _InfoRow(label: 'rail', value: '${_rail.toStringAsFixed(1)} px'),
                          _InfoRow(label: 'footer', value: '${_footer.toStringAsFixed(1)} px'),
                          _InfoRow(label: 'gap', value: '${_gap.toStringAsFixed(1)} px'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showTips)
                        _TipCard(
                          lines: const [
                            'LayoutId tags each child role: header, rail, canvas, inspector, footer, floating.',
                            'The delegate computes rectangle geometry for each role and positions children accordingly.',
                            'Changing sliders updates delegate values and triggers relayout while child widgets stay unchanged.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackPanel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Transform.scale(
                  scale: widget.visualScale,
                  alignment: Alignment.topCenter,
                  child: CustomMultiChildLayout(
                    delegate: _BlueprintDelegate(
                      headerHeight: _header,
                      railWidth: _rail,
                      footerHeight: _footer,
                      gap: _gap,
                      showInspector: _inspector,
                      showFloating: _floating,
                    ),
                    children: [
                      LayoutId(id: _idHeader, child: _RegionTile(title: 'Header', tone: _navy, icon: Icons.view_headline_rounded, note: 'Top navigation and context actions.')),
                      LayoutId(id: _idRail, child: _RegionTile(title: 'Rail', tone: _teal, icon: Icons.space_dashboard_rounded, note: 'Persistent section selectors.')),
                      LayoutId(id: _idCanvas, child: _RegionTile(title: 'Canvas', tone: _amber, icon: Icons.grid_view_rounded, note: 'Main content workspace region.')),
                      LayoutId(id: _idInspector, child: _RegionTile(title: 'Inspector', tone: _rose, icon: Icons.tune_rounded, note: 'Contextual property panel.')),
                      LayoutId(id: _idFooter, child: _RegionTile(title: 'Footer', tone: _violet, icon: Icons.drag_handle_rounded, note: 'Status and telemetry summary.')),
                      LayoutId(id: _idFloating, child: _FloatingRegion()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlueprintDelegate extends MultiChildLayoutDelegate {
  _BlueprintDelegate({
    required this.headerHeight,
    required this.railWidth,
    required this.footerHeight,
    required this.gap,
    required this.showInspector,
    required this.showFloating,
  });

  final double headerHeight;
  final double railWidth;
  final double footerHeight;
  final double gap;
  final bool showInspector;
  final bool showFloating;

  @override
  void performLayout(Size size) {
    final headerH = headerHeight.clamp(48.0, size.height * 0.35).toDouble();
    final footerH = footerHeight.clamp(40.0, size.height * 0.30).toDouble();
    final railW = railWidth.clamp(70.0, size.width * 0.42).toDouble();
    const inspectorW = 180.0;
    final bodyTop = headerH + gap;
    final bodyBottom = size.height - footerH - gap;
    final bodyHeight = math.max(0, bodyBottom - bodyTop).toDouble();

    if (hasChild(_idHeader)) {
      layoutChild(_idHeader, BoxConstraints.tight(Size(size.width, headerH)));
      positionChild(_idHeader, Offset.zero);
    }

    if (hasChild(_idFooter)) {
      layoutChild(_idFooter, BoxConstraints.tight(Size(size.width, footerH)));
      positionChild(_idFooter, Offset(0, size.height - footerH));
    }

    if (hasChild(_idRail)) {
      layoutChild(_idRail, BoxConstraints.tight(Size(railW, bodyHeight)));
      positionChild(_idRail, Offset(0, bodyTop));
    }

    final rightReserved = showInspector ? (inspectorW + gap) : 0.0;
    final canvasLeft = railW + gap;
    final canvasWidth = math.max(0, size.width - canvasLeft - rightReserved).toDouble();
    if (hasChild(_idCanvas)) {
      layoutChild(_idCanvas, BoxConstraints.tight(Size(canvasWidth, bodyHeight)));
      positionChild(_idCanvas, Offset(canvasLeft, bodyTop));
    }

    if (showInspector && hasChild(_idInspector)) {
      layoutChild(_idInspector, BoxConstraints.tight(Size(inspectorW, bodyHeight)));
      positionChild(_idInspector, Offset(size.width - inspectorW, bodyTop));
    } else if (hasChild(_idInspector)) {
      layoutChild(_idInspector, const BoxConstraints.tightFor(width: 0, height: 0));
      positionChild(_idInspector, Offset.zero);
    }

    if (showFloating && hasChild(_idFloating)) {
      const floatingSize = Size(150, 94);
      layoutChild(_idFloating, BoxConstraints.tightFor(width: floatingSize.width, height: floatingSize.height));
      positionChild(_idFloating, Offset(size.width - floatingSize.width - 12, headerH + 14));
    } else if (hasChild(_idFloating)) {
      layoutChild(_idFloating, const BoxConstraints.tightFor(width: 0, height: 0));
      positionChild(_idFloating, Offset.zero);
    }
  }

  @override
  bool shouldRelayout(covariant _BlueprintDelegate oldDelegate) {
    return headerHeight != oldDelegate.headerHeight ||
        railWidth != oldDelegate.railWidth ||
        footerHeight != oldDelegate.footerHeight ||
        gap != oldDelegate.gap ||
        showInspector != oldDelegate.showInspector ||
        showFloating != oldDelegate.showFloating;
  }
}

class _PatternGalleryScene extends StatefulWidget {
  const _PatternGalleryScene({
    required this.compact,
    required this.showGuide,
    required this.showTips,
    required this.visualScale,
  });

  final bool compact;
  final bool showGuide;
  final bool showTips;
  final double visualScale;

  @override
  State<_PatternGalleryScene> createState() => _PatternGallerySceneState();
}

class _PatternGallerySceneState extends State<_PatternGalleryScene> {
  int _pattern = 0;
  double _density = 0.55;
  bool _overlay = true;

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 680.0 : 820.0;

    final delegate = switch (_pattern) {
      0 => _GalleryDashboardDelegate(density: _density, showOverlay: _overlay),
      1 => _GalleryPosterDelegate(density: _density, showOverlay: _overlay),
      2 => _GallerySplitDelegate(density: _density, showOverlay: _overlay),
      _ => _GalleryFloatingTrayDelegate(density: _density, showOverlay: _overlay),
    };

    final patternName = switch (_pattern) {
      0 => 'Dashboard Grid',
      1 => 'Poster Layout',
      2 => 'Split Workbench',
      _ => 'Floating Tray',
    };

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackPanel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pattern controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 0, label: Text('Dashboard')),
                          ButtonSegment(value: 1, label: Text('Poster')),
                          ButtonSegment(value: 2, label: Text('Split')),
                          ButtonSegment(value: 3, label: Text('Tray')),
                        ],
                        selected: {_pattern},
                        onSelectionChanged: (v) => setState(() => _pattern = v.first),
                      ),
                      const SizedBox(height: 8),
                      _SliderTile(label: 'Density', value: _density, min: 0.2, max: 1.0, onChanged: (v) => setState(() => _density = v)),
                      SwitchListTile(
                        value: _overlay,
                        onChanged: (v) => setState(() => _overlay = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show overlay region'),
                      ),
                      const SizedBox(height: 8),
                      _InfoTable(
                        rows: [
                          _InfoRow(label: 'pattern', value: patternName),
                          _InfoRow(label: 'density', value: _density.toStringAsFixed(2)),
                          _InfoRow(label: 'overlay', value: _overlay ? 'visible' : 'hidden'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showTips)
                        _TipCard(
                          lines: const [
                            'Same children are reused across all patterns using stable LayoutId keys.',
                            'Only the MultiChildLayoutDelegate changes to produce a different visual composition.',
                            'This is the core reason LayoutId scales well for panel-based apps and dashboards.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackPanel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Transform.scale(
                  scale: widget.visualScale,
                  alignment: Alignment.topCenter,
                  child: CustomMultiChildLayout(
                    delegate: delegate,
                    children: [
                      LayoutId(id: _idTop, child: _GalleryTile(title: 'Top', tone: _navy, icon: Icons.view_headline_rounded)),
                      LayoutId(id: _idLeft, child: _GalleryTile(title: 'Left', tone: _teal, icon: Icons.table_rows_rounded)),
                      LayoutId(id: _idMain, child: _GalleryTile(title: 'Main', tone: _amber, icon: Icons.apps_rounded)),
                      LayoutId(id: _idRight, child: _GalleryTile(title: 'Right', tone: _rose, icon: Icons.tune_rounded)),
                      LayoutId(id: _idBottom, child: _GalleryTile(title: 'Bottom', tone: _violet, icon: Icons.linear_scale_rounded)),
                      LayoutId(id: _idOverlay, child: _OverlayTile()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

abstract class _GalleryDelegateBase extends MultiChildLayoutDelegate {
  _GalleryDelegateBase({required this.density, required this.showOverlay});

  final double density;
  final bool showOverlay;

  void layoutOverlay(Size size, Rect reference) {
    if (hasChild(_idOverlay) && showOverlay) {
      final w = (reference.width * 0.38).clamp(120.0, 240.0).toDouble();
      final h = (reference.height * 0.32).clamp(80.0, 160.0).toDouble();
      layoutChild(_idOverlay, BoxConstraints.tight(Size(w, h)));
      positionChild(_idOverlay, Offset(reference.right - w - 10, reference.top + 10));
    } else if (hasChild(_idOverlay)) {
      layoutChild(_idOverlay, const BoxConstraints.tightFor(width: 0, height: 0));
      positionChild(_idOverlay, Offset.zero);
    }
  }

  @override
  bool shouldRelayout(covariant _GalleryDelegateBase oldDelegate) {
    return density != oldDelegate.density || showOverlay != oldDelegate.showOverlay;
  }
}

class _GalleryDashboardDelegate extends _GalleryDelegateBase {
  _GalleryDashboardDelegate({required super.density, required super.showOverlay});

  @override
  void performLayout(Size size) {
    final topH = (70 + (density * 30)).clamp(62.0, 120.0).toDouble();
    final bottomH = (60 + (density * 22)).clamp(54.0, 98.0).toDouble();
    final sideW = (120 + (density * 90)).clamp(110.0, 220.0).toDouble();
    const gap = 10.0;

    layoutChild(_idTop, BoxConstraints.tight(Size(size.width, topH)));
    positionChild(_idTop, Offset.zero);

    layoutChild(_idBottom, BoxConstraints.tight(Size(size.width, bottomH)));
    positionChild(_idBottom, Offset(0, size.height - bottomH));

    final bodyTop = topH + gap;
    final bodyHeight = size.height - topH - bottomH - (gap * 2);

    layoutChild(_idLeft, BoxConstraints.tight(Size(sideW, bodyHeight)));
    positionChild(_idLeft, Offset(0, bodyTop));

    layoutChild(_idRight, BoxConstraints.tight(Size(sideW, bodyHeight)));
    positionChild(_idRight, Offset(size.width - sideW, bodyTop));

    final mainW = size.width - (sideW * 2) - (gap * 2);
    layoutChild(_idMain, BoxConstraints.tight(Size(mainW, bodyHeight)));
    final mainRect = Rect.fromLTWH(sideW + gap, bodyTop, mainW, bodyHeight);
    positionChild(_idMain, mainRect.topLeft);

    layoutOverlay(size, mainRect);
  }
}

class _GalleryPosterDelegate extends _GalleryDelegateBase {
  _GalleryPosterDelegate({required super.density, required super.showOverlay});

  @override
  void performLayout(Size size) {
    final topH = (56 + (density * 26)).clamp(52.0, 90.0).toDouble();
    final bottomH = (74 + (density * 34)).clamp(64.0, 128.0).toDouble();
    final leftW = (size.width * (0.22 + (density * 0.12))).clamp(130.0, 300.0).toDouble();
    const gap = 10.0;

    layoutChild(_idTop, BoxConstraints.tight(Size(size.width, topH)));
    positionChild(_idTop, Offset.zero);

    layoutChild(_idBottom, BoxConstraints.tight(Size(size.width, bottomH)));
    positionChild(_idBottom, Offset(0, size.height - bottomH));

    final bodyTop = topH + gap;
    final bodyHeight = size.height - topH - bottomH - (gap * 2);
    layoutChild(_idLeft, BoxConstraints.tight(Size(leftW, bodyHeight)));
    positionChild(_idLeft, Offset(0, bodyTop));

    final mainW = size.width - leftW - gap;
    layoutChild(_idMain, BoxConstraints.tight(Size(mainW, bodyHeight * 0.67)));
    final mainRect = Rect.fromLTWH(leftW + gap, bodyTop, mainW, bodyHeight * 0.67);
    positionChild(_idMain, mainRect.topLeft);

    layoutChild(_idRight, BoxConstraints.tight(Size(mainW, bodyHeight - mainRect.height - gap)));
    positionChild(_idRight, Offset(leftW + gap, bodyTop + mainRect.height + gap));

    layoutOverlay(size, mainRect);
  }
}

class _GallerySplitDelegate extends _GalleryDelegateBase {
  _GallerySplitDelegate({required super.density, required super.showOverlay});

  @override
  void performLayout(Size size) {
    final topH = (64 + (density * 24)).clamp(56.0, 100.0).toDouble();
    final bottomH = (52 + (density * 20)).clamp(48.0, 90.0).toDouble();
    final leftW = (size.width * (0.42 + (density * 0.15))).clamp(220.0, size.width * 0.7).toDouble();
    const gap = 10.0;

    layoutChild(_idTop, BoxConstraints.tight(Size(size.width, topH)));
    positionChild(_idTop, Offset.zero);

    layoutChild(_idBottom, BoxConstraints.tight(Size(size.width, bottomH)));
    positionChild(_idBottom, Offset(0, size.height - bottomH));

    final bodyTop = topH + gap;
    final bodyHeight = size.height - topH - bottomH - (gap * 2);

    layoutChild(_idMain, BoxConstraints.tight(Size(leftW, bodyHeight)));
    final mainRect = Rect.fromLTWH(0, bodyTop, leftW, bodyHeight);
    positionChild(_idMain, mainRect.topLeft);

    final rightW = size.width - leftW - gap;
    layoutChild(_idLeft, BoxConstraints.tight(Size(rightW, bodyHeight * 0.5 - (gap * 0.5))));
    positionChild(_idLeft, Offset(leftW + gap, bodyTop));

    layoutChild(_idRight, BoxConstraints.tight(Size(rightW, bodyHeight * 0.5 - (gap * 0.5))));
    positionChild(_idRight, Offset(leftW + gap, bodyTop + (bodyHeight * 0.5) + (gap * 0.5)));

    layoutOverlay(size, mainRect);
  }
}

class _GalleryFloatingTrayDelegate extends _GalleryDelegateBase {
  _GalleryFloatingTrayDelegate({required super.density, required super.showOverlay});

  @override
  void performLayout(Size size) {
    final topH = (68 + (density * 30)).clamp(58.0, 120.0).toDouble();
    final bottomH = (58 + (density * 22)).clamp(50.0, 98.0).toDouble();
    const gap = 10.0;

    layoutChild(_idTop, BoxConstraints.tight(Size(size.width, topH)));
    positionChild(_idTop, Offset.zero);

    layoutChild(_idBottom, BoxConstraints.tight(Size(size.width, bottomH)));
    positionChild(_idBottom, Offset(0, size.height - bottomH));

    final bodyTop = topH + gap;
    final bodyHeight = size.height - topH - bottomH - (gap * 2);

    layoutChild(_idMain, BoxConstraints.tight(Size(size.width, bodyHeight)));
    final mainRect = Rect.fromLTWH(0, bodyTop, size.width, bodyHeight);
    positionChild(_idMain, mainRect.topLeft);

    final trayW = (220 + (density * 120)).clamp(210.0, 360.0).toDouble();
    final trayH = (bodyHeight * 0.42).clamp(120.0, 230.0).toDouble();
    layoutChild(_idLeft, BoxConstraints.tight(Size(trayW, trayH)));
    positionChild(_idLeft, Offset(14, bodyTop + 16));

    layoutChild(_idRight, BoxConstraints.tight(Size(trayW, trayH)));
    positionChild(_idRight, Offset(size.width - trayW - 14, bodyTop + bodyHeight - trayH - 16));

    layoutOverlay(size, mainRect);
  }
}

class _ConstraintLabScene extends StatefulWidget {
  const _ConstraintLabScene({required this.compact, required this.showGuide, required this.showTips});

  final bool compact;
  final bool showGuide;
  final bool showTips;

  @override
  State<_ConstraintLabScene> createState() => _ConstraintLabSceneState();
}

class _ConstraintLabSceneState extends State<_ConstraintLabScene> {
  double _canvasWidth = 860;
  double _canvasHeight = 460;
  bool _collapseInspector = true;
  bool _forceCompact = false;
  double _priority = 0.6;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 720.0 : 860.0;
    final measuredWidth = _forceCompact ? 560.0 : _canvasWidth;

    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackPanel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Constraint controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _SliderTile(label: 'Canvas width', value: _canvasWidth, min: 480, max: 980, onChanged: (v) => setState(() => _canvasWidth = v)),
                      _SliderTile(label: 'Canvas height', value: _canvasHeight, min: 320, max: 560, onChanged: (v) => setState(() => _canvasHeight = v)),
                      _SliderTile(label: 'Priority (main area)', value: _priority, min: 0.2, max: 1.0, onChanged: (v) => setState(() => _priority = v)),
                      SwitchListTile(
                        value: _collapseInspector,
                        onChanged: (v) => setState(() => _collapseInspector = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Collapse inspector when narrow'),
                      ),
                      SwitchListTile(
                        value: _forceCompact,
                        onChanged: (v) => setState(() => _forceCompact = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Force compact width class'),
                      ),
                      const SizedBox(height: 8),
                      _InfoTable(
                        rows: [
                          _InfoRow(label: 'effective width', value: '${measuredWidth.toStringAsFixed(1)} px'),
                          _InfoRow(label: 'effective height', value: '${_canvasHeight.toStringAsFixed(1)} px'),
                          _InfoRow(label: 'collapse inspector', value: _collapseInspector ? 'enabled' : 'disabled'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showTips)
                        _TipCard(
                          lines: const [
                            'Layout delegates should gracefully degrade under tight constraints.',
                            'LayoutId roles let delegates prioritize key regions and compress optional panels first.',
                            'This scene demonstrates predictable region fallbacks without changing child widgets.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackPanel(
              showGuide: widget.showGuide,
              child: Center(
                child: SizedBox(
                  width: measuredWidth,
                  height: _canvasHeight,
                  child: CustomMultiChildLayout(
                    delegate: _ConstraintAwareDelegate(
                      priority: _priority,
                      collapseInspectorWhenNarrow: _collapseInspector,
                    ),
                    children: [
                      LayoutId(id: _idHeader, child: _RegionTile(title: 'Toolbar', tone: _navy, icon: Icons.view_headline_rounded, note: 'Adaptive top controls')),
                      LayoutId(id: _idRail, child: _RegionTile(title: 'Sections', tone: _teal, icon: Icons.segment_rounded, note: 'Optional narrow rail')),
                      LayoutId(id: _idCanvas, child: _RegionTile(title: 'Main Surface', tone: _amber, icon: Icons.center_focus_strong_rounded, note: 'Priority region under compression')),
                      LayoutId(id: _idInspector, child: _RegionTile(title: 'Inspector', tone: _rose, icon: Icons.tune_rounded, note: 'Collapsible analysis panel')),
                      LayoutId(id: _idFooter, child: _RegionTile(title: 'Status Bar', tone: _violet, icon: Icons.density_small_rounded, note: 'Bottom diagnostics')),
                      LayoutId(id: _idFloating, child: _FloatingRegion()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConstraintAwareDelegate extends MultiChildLayoutDelegate {
  _ConstraintAwareDelegate({required this.priority, required this.collapseInspectorWhenNarrow});

  final double priority;
  final bool collapseInspectorWhenNarrow;

  @override
  void performLayout(Size size) {
    final narrow = size.width < 640;
    const gap = 10.0;
    final topH = narrow ? 58.0 : 74.0;
    final footerH = narrow ? 48.0 : 62.0;
    final railW = narrow ? 88.0 : 128.0;
    final inspectorW = narrow ? 0.0 : 180.0;

    if (hasChild(_idHeader)) {
      layoutChild(_idHeader, BoxConstraints.tight(Size(size.width, topH)));
      positionChild(_idHeader, Offset.zero);
    }

    if (hasChild(_idFooter)) {
      layoutChild(_idFooter, BoxConstraints.tight(Size(size.width, footerH)));
      positionChild(_idFooter, Offset(0, size.height - footerH));
    }

    final bodyTop = topH + gap;
    final bodyH = math.max(0, size.height - topH - footerH - (gap * 2)).toDouble();

    if (hasChild(_idRail)) {
      layoutChild(_idRail, BoxConstraints.tight(Size(railW, bodyH)));
      positionChild(_idRail, Offset.zero.translate(0, bodyTop));
    }

    final hideInspector = collapseInspectorWhenNarrow && narrow;
    final rightReserved = hideInspector ? 0.0 : inspectorW + gap;
    final canvasW = math.max(0, size.width - railW - gap - rightReserved).toDouble();
    final priorityHeight = bodyH * priority;

    if (hasChild(_idCanvas)) {
      layoutChild(_idCanvas, BoxConstraints.tight(Size(canvasW, bodyH)));
      positionChild(_idCanvas, Offset(railW + gap, bodyTop));
    }

    if (hasChild(_idInspector)) {
      if (hideInspector) {
        layoutChild(_idInspector, const BoxConstraints.tightFor(width: 0, height: 0));
        positionChild(_idInspector, Offset.zero);
      } else {
        layoutChild(_idInspector, BoxConstraints.tight(Size(inspectorW, bodyH)));
        positionChild(_idInspector, Offset(size.width - inspectorW, bodyTop));
      }
    }

    if (hasChild(_idFloating)) {
      final floatingW = 150.0;
      final floatingH = 90.0;
      layoutChild(_idFloating, BoxConstraints.tightFor(width: floatingW, height: floatingH));
      positionChild(_idFloating, Offset(railW + gap + 10, bodyTop + priorityHeight - (floatingH * 0.5)));
    }
  }

  @override
  bool shouldRelayout(covariant _ConstraintAwareDelegate oldDelegate) {
    return priority != oldDelegate.priority || collapseInspectorWhenNarrow != oldDelegate.collapseInspectorWhenNarrow;
  }
}

enum _WidthClass {
  narrow,
  medium,
  wide,
}

class _ResponsiveScene extends StatefulWidget {
  const _ResponsiveScene({required this.compact, required this.showGuide, required this.showTips});

  final bool compact;
  final bool showGuide;
  final bool showTips;

  @override
  State<_ResponsiveScene> createState() => _ResponsiveSceneState();
}

class _ResponsiveSceneState extends State<_ResponsiveScene> {
  _WidthClass _widthClass = _WidthClass.medium;
  bool _showMeta = true;
  bool _showOverlay = true;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 720.0 : 860.0;
    final width = switch (_widthClass) {
      _WidthClass.narrow => 560.0,
      _WidthClass.medium => 760.0,
      _WidthClass.wide => 980.0,
    };

    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackPanel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Responsive controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SegmentedButton<_WidthClass>(
                        segments: const [
                          ButtonSegment(value: _WidthClass.narrow, label: Text('Narrow')),
                          ButtonSegment(value: _WidthClass.medium, label: Text('Medium')),
                          ButtonSegment(value: _WidthClass.wide, label: Text('Wide')),
                        ],
                        selected: {_widthClass},
                        onSelectionChanged: (s) => setState(() => _widthClass = s.first),
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _showMeta,
                        onChanged: (v) => setState(() => _showMeta = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show metadata rail'),
                      ),
                      SwitchListTile(
                        value: _showOverlay,
                        onChanged: (v) => setState(() => _showOverlay = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show overlay helper'),
                      ),
                      const SizedBox(height: 8),
                      _InfoTable(
                        rows: [
                          _InfoRow(label: 'width class', value: _widthClass.name),
                          _InfoRow(label: 'canvas width', value: '${width.toStringAsFixed(0)} px'),
                          _InfoRow(label: 'meta rail', value: _showMeta ? 'visible' : 'hidden'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showTips)
                        _TipCard(
                          lines: const [
                            'LayoutId child identities are constant across all width classes.',
                            'Delegates can remap geometry without rebuilding a different subtree.',
                            'This keeps logic reusable while still achieving fully responsive compositions.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackPanel(
              showGuide: widget.showGuide,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOut,
                  width: width,
                  height: 470,
                  child: CustomMultiChildLayout(
                    delegate: _ResponsiveDelegate(
                      widthClass: _widthClass,
                      showMeta: _showMeta,
                      showOverlay: _showOverlay,
                    ),
                    children: [
                      LayoutId(id: _idTop, child: _GalleryTile(title: 'Top Nav', tone: _navy, icon: Icons.view_headline_rounded)),
                      LayoutId(id: _idLeft, child: _GalleryTile(title: 'Nav', tone: _teal, icon: Icons.view_sidebar_rounded)),
                      LayoutId(id: _idMain, child: _GalleryTile(title: 'Content', tone: _amber, icon: Icons.dashboard_rounded)),
                      LayoutId(id: _idRight, child: _GalleryTile(title: 'Detail', tone: _rose, icon: Icons.analytics_rounded)),
                      LayoutId(id: _idBottom, child: _GalleryTile(title: 'Footer', tone: _violet, icon: Icons.linear_scale_rounded)),
                      LayoutId(id: _idOverlay, child: _OverlayTile()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveDelegate extends MultiChildLayoutDelegate {
  _ResponsiveDelegate({
    required this.widthClass,
    required this.showMeta,
    required this.showOverlay,
  });

  final _WidthClass widthClass;
  final bool showMeta;
  final bool showOverlay;

  @override
  void performLayout(Size size) {
    const gap = 10.0;
    final topH = 66.0;
    final bottomH = 56.0;
    final leftW = switch (widthClass) {
      _WidthClass.narrow => 92.0,
      _WidthClass.medium => 130.0,
      _WidthClass.wide => 160.0,
    };
    final rightW = switch (widthClass) {
      _WidthClass.narrow => 0.0,
      _WidthClass.medium => 170.0,
      _WidthClass.wide => 220.0,
    };

    layoutChild(_idTop, BoxConstraints.tight(Size(size.width, topH)));
    positionChild(_idTop, Offset.zero);

    layoutChild(_idBottom, BoxConstraints.tight(Size(size.width, bottomH)));
    positionChild(_idBottom, Offset(0, size.height - bottomH));

    final bodyTop = topH + gap;
    final bodyH = size.height - topH - bottomH - (gap * 2);

    layoutChild(_idLeft, BoxConstraints.tight(Size(leftW, bodyH)));
    positionChild(_idLeft, Offset(0, bodyTop));

    if (rightW > 0) {
      layoutChild(_idRight, BoxConstraints.tight(Size(rightW, bodyH)));
      positionChild(_idRight, Offset(size.width - rightW, bodyTop));
    } else {
      layoutChild(_idRight, const BoxConstraints.tightFor(width: 0, height: 0));
      positionChild(_idRight, Offset.zero);
    }

    final middleRight = rightW > 0 ? rightW + gap : 0;
    final mainW = size.width - leftW - gap - middleRight;
    layoutChild(_idMain, BoxConstraints.tight(Size(mainW, bodyH)));
    final mainRect = Rect.fromLTWH(leftW + gap, bodyTop, mainW, bodyH);
    positionChild(_idMain, mainRect.topLeft);

    if (showOverlay) {
      final overlayW = showMeta ? 180.0 : 130.0;
      final overlayH = showMeta ? 92.0 : 72.0;
      layoutChild(_idOverlay, BoxConstraints.tight(Size(overlayW, overlayH)));
      positionChild(_idOverlay, Offset(mainRect.right - overlayW - 10, mainRect.top + 10));
    } else {
      layoutChild(_idOverlay, const BoxConstraints.tightFor(width: 0, height: 0));
      positionChild(_idOverlay, Offset.zero);
    }
  }

  @override
  bool shouldRelayout(covariant _ResponsiveDelegate oldDelegate) {
    return widthClass != oldDelegate.widthClass || showMeta != oldDelegate.showMeta || showOverlay != oldDelegate.showOverlay;
  }
}

class _PracticalWorkspaceScene extends StatefulWidget {
  const _PracticalWorkspaceScene({required this.compact, required this.showGuide, required this.showTips});

  final bool compact;
  final bool showGuide;
  final bool showTips;

  @override
  State<_PracticalWorkspaceScene> createState() => _PracticalWorkspaceSceneState();
}

class _PracticalWorkspaceSceneState extends State<_PracticalWorkspaceScene> {
  double _leftRatio = 0.24;
  double _consoleRatio = 0.26;
  bool _palette = true;
  bool _previewOverlay = true;
  final List<String> _events = <String>[];

  void _push(String text) {
    setState(() {
      _events.insert(0, '${_clock()} | $text');
      if (_events.length > 40) {
        _events.removeRange(40, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 920.0 : 1100.0;
    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _BackPanel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _leftRatio = 0.24;
                              _consoleRatio = 0.26;
                              _palette = true;
                              _previewOverlay = true;
                            });
                            _push('workspace reset to baseline');
                          },
                          child: const Text('Reset workspace'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() => _palette = !_palette);
                            _push('palette toggled -> ${_palette ? 'ON' : 'OFF'}');
                          },
                          child: const Text('Toggle palette'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() => _previewOverlay = !_previewOverlay);
                            _push('preview overlay -> ${_previewOverlay ? 'ON' : 'OFF'}');
                          },
                          child: const Text('Toggle preview overlay'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _SliderTile(label: 'Left menu ratio', value: _leftRatio, min: 0.16, max: 0.38, onChanged: (v) => setState(() => _leftRatio = v)),
                    _SliderTile(label: 'Console ratio', value: _consoleRatio, min: 0.18, max: 0.42, onChanged: (v) => setState(() => _consoleRatio = v)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: CustomMultiChildLayout(
                        delegate: _WorkspaceDelegate(
                          leftRatio: _leftRatio,
                          consoleRatio: _consoleRatio,
                          showPalette: _palette,
                          showOverlay: _previewOverlay,
                        ),
                        children: [
                          LayoutId(
                            id: _idMenu,
                            child: _RegionTile(
                              title: 'Menu',
                              tone: _teal,
                              icon: Icons.menu_open_rounded,
                              note: 'Navigation groups and workspace contexts.',
                            ),
                          ),
                          LayoutId(
                            id: _idEditor,
                            child: _RegionTile(
                              title: 'Editor',
                              tone: _amber,
                              icon: Icons.code_rounded,
                              note: 'Primary editing surface and document canvas.',
                            ),
                          ),
                          LayoutId(
                            id: _idPreview,
                            child: _RegionTile(
                              title: 'Preview',
                              tone: _rose,
                              icon: Icons.preview_rounded,
                              note: 'Rendered output and visual checks.',
                            ),
                          ),
                          LayoutId(
                            id: _idTools,
                            child: _RegionTile(
                              title: 'Tools',
                              tone: _violet,
                              icon: Icons.build_rounded,
                              note: 'Short actions and diagnostics.',
                            ),
                          ),
                          LayoutId(
                            id: _idConsole,
                            child: _RegionTile(
                              title: 'Console',
                              tone: _navy,
                              icon: Icons.terminal_rounded,
                              note: 'Logs and script output stream.',
                            ),
                          ),
                          LayoutId(id: _idPalette, child: _PaletteTile()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _BackPanel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Workspace notes', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _InfoTable(
                      rows: [
                        _InfoRow(label: 'left ratio', value: _leftRatio.toStringAsFixed(2)),
                        _InfoRow(label: 'console ratio', value: _consoleRatio.toStringAsFixed(2)),
                        _InfoRow(label: 'palette', value: _palette ? 'on' : 'off'),
                        _InfoRow(label: 'overlay', value: _previewOverlay ? 'on' : 'off'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (widget.showTips)
                      _TipCard(
                        lines: const [
                          'This scene models a realistic tool layout managed by one delegate.',
                          'LayoutId maps semantic roles (menu/editor/preview/tools/console/palette).',
                          'Changing ratios relayouts all regions coherently without manual pixel math in widgets.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Recent events', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(
                      child: _events.isEmpty
                          ? const Text('No workspace events yet.', style: TextStyle(color: Color(0xFF617587)))
                          : ListView.builder(
                              itemCount: _events.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(_events[index], style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkspaceDelegate extends MultiChildLayoutDelegate {
  _WorkspaceDelegate({
    required this.leftRatio,
    required this.consoleRatio,
    required this.showPalette,
    required this.showOverlay,
  });

  final double leftRatio;
  final double consoleRatio;
  final bool showPalette;
  final bool showOverlay;

  @override
  void performLayout(Size size) {
    const gap = 10.0;
    final leftW = (size.width * leftRatio).clamp(140.0, size.width * 0.42).toDouble();
    final consoleH = (size.height * consoleRatio).clamp(120.0, size.height * 0.46).toDouble();

    final topH = size.height - consoleH - gap;
    final mainW = size.width - leftW - gap;

    layoutChild(_idMenu, BoxConstraints.tight(Size(leftW, topH)));
    positionChild(_idMenu, Offset.zero);

    final editorW = mainW * 0.62;
    final sideW = mainW - editorW - gap;
    layoutChild(_idEditor, BoxConstraints.tight(Size(editorW, topH)));
    positionChild(_idEditor, Offset(leftW + gap, 0));

    final previewH = topH * 0.58;
    final toolsH = topH - previewH - gap;
    layoutChild(_idPreview, BoxConstraints.tight(Size(sideW, previewH)));
    positionChild(_idPreview, Offset(leftW + gap + editorW + gap, 0));

    layoutChild(_idTools, BoxConstraints.tight(Size(sideW, toolsH)));
    positionChild(_idTools, Offset(leftW + gap + editorW + gap, previewH + gap));

    layoutChild(_idConsole, BoxConstraints.tight(Size(size.width, consoleH)));
    positionChild(_idConsole, Offset(0, size.height - consoleH));

    if (showPalette) {
      const paletteW = 172.0;
      const paletteH = 94.0;
      layoutChild(_idPalette, const BoxConstraints.tightFor(width: paletteW, height: paletteH));
      final paletteX = showOverlay ? leftW + gap + 18 : size.width - paletteW - 14;
      final paletteY = showOverlay ? 16.0 : previewH + gap + 12;
      positionChild(_idPalette, Offset(paletteX, paletteY));
    } else {
      layoutChild(_idPalette, const BoxConstraints.tightFor(width: 0, height: 0));
      positionChild(_idPalette, Offset.zero);
    }
  }

  @override
  bool shouldRelayout(covariant _WorkspaceDelegate oldDelegate) {
    return leftRatio != oldDelegate.leftRatio ||
        consoleRatio != oldDelegate.consoleRatio ||
        showPalette != oldDelegate.showPalette ||
        showOverlay != oldDelegate.showOverlay;
  }
}

class _BackPanel extends StatelessWidget {
  const _BackPanel({required this.showGuide, required this.child});

  final bool showGuide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC6D7E8)),
        gradient: const LinearGradient(
          colors: [Color(0xFFF9FCFF), Color(0xFFEDF4FB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGuide) const CustomPaint(painter: _GuidePainter()),
          child,
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x0E000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RegionTile extends StatelessWidget {
  const _RegionTile({required this.title, required this.tone, required this.icon, required this.note});

  final String title;
  final Color tone;
  final IconData icon;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.42)),
        boxShadow: [
          BoxShadow(color: tone.withValues(alpha: 0.14), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: tone, size: 18),
              const SizedBox(width: 6),
              Expanded(child: Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800))),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(note, style: const TextStyle(color: Color(0xFF3F5669), height: 1.3)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingRegion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF173346),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF4F7495)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Floating', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
          SizedBox(height: 4),
          Text('Quick actions', style: TextStyle(color: Color(0xFFD7E5F4), fontSize: 11)),
        ],
      ),
    );
  }
}

class _GalleryTile extends StatelessWidget {
  const _GalleryTile({required this.title, required this.tone, required this.icon});

  final String title;
  final Color tone;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(icon, color: tone),
          const SizedBox(width: 8),
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _OverlayTile extends StatelessWidget {
  const _OverlayTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9E8F7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF7FA0BF)),
      ),
      padding: const EdgeInsets.all(8),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overlay helper', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF224661), fontSize: 12)),
          SizedBox(height: 4),
          Text('Positioned by delegate above main region', style: TextStyle(color: Color(0xFF30546E), fontSize: 11)),
        ],
      ),
    );
  }
}

class _PaletteTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C2B5F),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF706CB5)),
      ),
      padding: const EdgeInsets.all(8),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Palette', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
          SizedBox(height: 4),
          Text('Quick command layer', style: TextStyle(color: Color(0xFFD8D4FF), fontSize: 11)),
        ],
      ),
    );
  }
}

class _SliderTile extends StatelessWidget {
  const _SliderTile({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

class _InfoRow {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;
}

class _InfoTable extends StatelessWidget {
  const _InfoTable({required this.rows});

  final List<_InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F8FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD1E0EE)),
      ),
      child: Column(
        children: rows
            .map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(width: 120, child: Text(r.label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                    Expanded(child: Text(r.value, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF19374D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.circle, size: 7, color: Color(0xFF8DD5FF)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFD9EAF9), height: 1.33))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF15344D),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: LayoutId', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'LayoutId links each child to a semantic role consumed by MultiChildLayoutDelegate. '
            'This enables reusable child trees and flexible layout algorithms where geometry can change drastically across contexts '
            'without rewriting child widgets. It is especially valuable for dashboards, IDE-like shells, and responsive panel systems.',
            style: TextStyle(color: Color(0xFFD8E6F4), height: 1.36),
          ),
        ],
      ),
    );
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);

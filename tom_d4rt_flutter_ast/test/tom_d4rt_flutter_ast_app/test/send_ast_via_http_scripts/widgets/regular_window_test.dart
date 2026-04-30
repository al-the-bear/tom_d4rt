import 'package:flutter/material.dart';

// ============================================================================
// Deep Visual Demo — RegularWindow
//
// RegularWindow is a Flutter widget (desktop-only) that bridges the Flutter
// widget tree with a native platform window.  It wraps a RegularWindowController
// that owns the OS window handle and keeps widget-tree constraints in sync with
// the native window dimensions, position, and focus state.
//
// Because RegularWindow ships only in the flutter/src/widgets/windowing package
// (desktop channels), this file is an educational simulation: every concept is
// faithfully represented through carefully drawn Flutter widgets so the demo
// runs on any platform inside the d4rt harness.
// ============================================================================

// ---------------------------------------------------------------------------
// Palette — deep indigo + amber-gold, desktop-inspired.
// ---------------------------------------------------------------------------
const Color _kSeed = Color(0xFF3B3080);
const Color _kInk = Color(0xFF0E0C24);
const Color _kSurface = Color(0xFFF4F3FB);
const Color _kBorder = Color(0xFFCAC5E8);
const Color _kAccent = Color(0xFFD4860A);
const Color _kGreen = Color(0xFF2E7A4A);
const Color _kGreenSoft = Color(0xFFCFEDDA);
const Color _kRed = Color(0xFFB03030);
const Color _kRedSoft = Color(0xFFFAE0E0);
const Color _kYellow = Color(0xFFB28A00);
const Color _kYellowSoft = Color(0xFFFFF4CC);
const Color _kPurple = Color(0xFF6747B2);
const Color _kChrome = Color(0xFF3A3A3A);
const Color _kChromeDark = Color(0xFF1A1A2E);
const Color _kChromeLight = Color(0xFFD0CCEE);
const Color _kGlass = Color(0xFFE8E5F7);
const Color _kShadow = Color(0x22000000);

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — drive all reactive UI without StatefulWidget.
// ---------------------------------------------------------------------------

/// Primary simulated window title (multi-window demo uses per-card state).
final ValueNotifier<String> _primaryTitle =
    ValueNotifier<String>('Main Application');

/// Secondary simulated window title.
final ValueNotifier<String> _secondaryTitle =
    ValueNotifier<String>('Settings Panel');

/// Primary window focus state (true = focused).
final ValueNotifier<bool> _primaryFocused = ValueNotifier<bool>(true);

/// Secondary window focus state.
final ValueNotifier<bool> _secondaryFocused = ValueNotifier<bool>(false);

/// Lifecycle phase index for the animation diagram tab.
/// 0 = unmounted, 1 = mounting, 2 = window shown, 3 = active, 4 = unmounting.
final ValueNotifier<int> _lifecyclePhase = ValueNotifier<int>(0);

/// Simulated primary window size for the size/position tab.
final ValueNotifier<Size> _primarySize =
    ValueNotifier<Size>(const Size(900, 600));

/// Simulated primary window position (top-left).
final ValueNotifier<Offset> _primaryPos =
    ValueNotifier<Offset>(const Offset(120, 80));

/// Multi-window routing: which content the secondary window shows.
/// 0 = Inspector, 1 = Timeline, 2 = Console.
final ValueNotifier<int> _secondaryRoute = ValueNotifier<int>(0);

/// Operation log (bounded to last 14 entries).
final ValueNotifier<List<String>> _opLog =
    ValueNotifier<List<String>>(<String>[]);

void _log(String msg) {
  final List<String> next = List<String>.from(_opLog.value)..add(msg);
  if (next.length > 14) next.removeRange(0, next.length - 14);
  _opLog.value = next;
}

// ---------------------------------------------------------------------------
// Entry point — d4rt harness calls build(context) and mounts the result.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _RegularWindowDeepDemo();
}

// ===========================================================================
// Root widget — MaterialApp + M3 theme.
// ===========================================================================
class _RegularWindowDeepDemo extends StatelessWidget {
  const _RegularWindowDeepDemo();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _kSeed,
      brightness: Brightness.light,
    );
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _kSurface,
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: _kBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk, height: 1.45),
        titleLarge: TextStyle(
          color: _kInk,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          color: _kInk,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        labelSmall: TextStyle(
          color: _kSeed,
          fontWeight: FontWeight.w600,
          fontSize: 11,
          letterSpacing: 0.8,
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const _ShellScaffold(),
    );
  }
}

// ===========================================================================
// Shell scaffold — AppBar + 9-tab DefaultTabController.
// ===========================================================================
class _ShellScaffold extends StatelessWidget {
  const _ShellScaffold();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: _kSurface,
        appBar: AppBar(
          backgroundColor: _kChromeDark,
          foregroundColor: Colors.white,
          toolbarHeight: 100,
          elevation: 0,
          title: const _AppBarTitle(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: _TabBar(),
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _HeroBannerTab(),
            _ArchitectureDiagramTab(),
            _WidgetTreeTab(),
            _SimulatedDesktopAppTab(),
            _LifecycleTab(),
            _SizePositionTab(),
            _FocusHandlingTab(),
            _MultiWindowTab(),
            _PitfallsApiTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// AppBar title widget.
// ---------------------------------------------------------------------------
class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: _kPurple,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: _kShadow, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
          child: const Icon(Icons.desktop_windows, color: Colors.white, size: 30),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RegularWindow',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
            Text(
              'Desktop Window Widget — Deep Visual Demo',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _kChromeLight,
                    fontSize: 13,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab bar labels.
// ---------------------------------------------------------------------------
class _TabBar extends StatelessWidget {
  const _TabBar();

  static const List<String> _labels = <String>[
    'Hero',
    'Architecture',
    'Widget Tree',
    'Desktop App',
    'Lifecycle',
    'Size & Pos',
    'Focus',
    'Multi-Window',
    'Pitfalls & API',
  ];

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorColor: _kAccent,
      indicatorWeight: 3,
      labelColor: Colors.white,
      unselectedLabelColor: _kChromeLight,
      tabs: _labels.map((String l) => Tab(text: l)).toList(),
    );
  }
}

// ===========================================================================
// Tab 1 — Hero Banner
// ===========================================================================
class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero gradient banner.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[_kSeed, Color(0xFF1A1040)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: _kSeed.withValues(alpha: 0.4),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.desktop_windows, color: Colors.white, size: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'RegularWindow',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _kAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'DESKTOP ONLY',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'The widget bridge between the Flutter widget tree and a native desktop window.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 15,
                      ),
                ),
                const SizedBox(height: 24),
                // Three key-points row.
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: const <Widget>[
                    _HeroBadge(Icons.link, 'Wraps a native OS window'),
                    _HeroBadge(Icons.tune, 'Driven by RegularWindowController'),
                    _HeroBadge(Icons.view_quilt, 'Flutter tree ↔ FlutterView'),
                    _HeroBadge(Icons.computer, 'Linux / macOS / Windows only'),
                    _HeroBadge(Icons.layers, 'Composable inside widget tree'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),
          _SectionTitle('What is RegularWindow?'),
          const SizedBox(height: 12),
          _BodyText(
            'RegularWindow is a Flutter widget that creates (or reuses) a '
            'platform-provided top-level desktop window.  On Linux it maps to '
            'an X11/Wayland window; on macOS to an NSWindow; on Windows to an '
            'HWND.  It accepts a child widget tree and renders it inside that '
            'OS window through an independent FlutterView, completely separate '
            'from the root FlutterView.',
          ),
          const SizedBox(height: 16),
          _BodyText(
            'Because each RegularWindow owns its own FlutterView, it also owns '
            'its own rendering pipeline, compositing layer, and focus scope.  '
            'This makes it genuinely multi-window: two RegularWindows can '
            'display entirely different widget hierarchies simultaneously.',
          ),
          const SizedBox(height: 24),
          _SectionTitle('Key API surface'),
          const SizedBox(height: 12),
          _ApiCard(entries: const <_ApiEntry>[
            _ApiEntry(
              name: 'RegularWindow({Key? key, required RegularWindowController controller, required Widget child})',
              desc: 'Creates a regular desktop window.  The controller owns the native handle; child is the Flutter UI rendered inside.',
            ),
            _ApiEntry(
              name: 'RegularWindowController()',
              desc: 'Creates and manages the OS window handle.  Exposes size, position, title, visibility, and focus APIs.',
            ),
            _ApiEntry(
              name: 'controller.setTitle(String)',
              desc: 'Updates the OS window title bar text.',
            ),
            _ApiEntry(
              name: 'controller.setSize(Size)',
              desc: 'Requests a new client-area size from the OS.',
            ),
            _ApiEntry(
              name: 'controller.setPosition(Offset)',
              desc: 'Moves the window to (x, y) in screen coordinates.',
            ),
            _ApiEntry(
              name: 'controller.close()',
              desc: 'Requests the OS to close and destroy the window.',
            ),
          ]),
          const SizedBox(height: 24),
          _SectionTitle('Desktop-only note'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kYellowSoft,
              border: Border.all(color: _kYellow),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: _kYellow, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: _BodyText(
                    'RegularWindow is only available on desktop platforms '
                    '(Linux, macOS, Windows).  Importing or instantiating it on '
                    'Android, iOS, or Web will throw an assertion error at runtime.  '
                    'Always guard with kIsDesktop or a compile-time platform check.',
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

class _HeroBadge extends StatelessWidget {
  const _HeroBadge(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Tab 2 — Architecture Diagram (CustomPainter)
// ===========================================================================
class _ArchitectureDiagramTab extends StatelessWidget {
  const _ArchitectureDiagramTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Architecture Diagram'),
          const SizedBox(height: 8),
          _BodyText(
            'The diagram below shows the ownership chain from the Flutter widget '
            'tree all the way down to a FlutterView rendered inside an OS window.',
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 520,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder),
            ),
            child: const CustomPaint(
              painter: _ArchPainter(),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle('Ownership chain — step by step'),
          const SizedBox(height: 12),
          _StepList(steps: const <String>[
            '1. Your widget tree contains a RegularWindow widget.',
            '2. RegularWindow holds a reference to a RegularWindowController.',
            '3. The controller asks the platform embedding to create an OS window (NSWindow / HWND / GtkWindow).',
            '4. The OS window hosts a FlutterView, separate from the root FlutterView.',
            '5. The child widget tree is inflated inside that FlutterView.',
            '6. Rendering, compositing, and input events all flow through the secondary FlutterView pipeline.',
            '7. When RegularWindow is unmounted the controller disposes the OS window.',
          ]),
          const SizedBox(height: 24),
          _SectionTitle('Component roles'),
          const SizedBox(height: 12),
          _RoleTable(rows: const <List<String>>[
            ['RegularWindow', 'Widget', 'Declares that a desktop window should exist; owns lifecycle'],
            ['RegularWindowController', 'Controller', 'Wraps the OS handle; exposes imperative window API'],
            ['Platform window', 'OS concept', 'Actual NSWindow / HWND / GtkWindow managed by the embedder'],
            ['FlutterView', 'Engine concept', 'Secondary rendering surface inside the OS window'],
            ['child widget tree', 'Widget subtree', 'Application content rendered in the secondary FlutterView'],
          ]),
        ],
      ),
    );
  }
}

/// CustomPainter for the architecture diagram.
class _ArchPainter extends CustomPainter {
  const _ArchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF888888);

    const double boxW = 220;
    const double boxH = 52;

    final List<_ArchBox> boxes = <_ArchBox>[
      _ArchBox(
        label: 'Widget Tree (root FlutterView)',
        sublabel: 'Scaffold / Navigator / …',
        color: const Color(0xFFE8E4FB),
        border: _kSeed,
        y: 28,
      ),
      _ArchBox(
        label: 'RegularWindow',
        sublabel: 'Flutter widget',
        color: const Color(0xFFD4CFFE),
        border: _kPurple,
        y: 124,
      ),
      _ArchBox(
        label: 'RegularWindowController',
        sublabel: 'Manages OS handle',
        color: const Color(0xFFFDE8C6),
        border: _kAccent,
        y: 220,
      ),
      _ArchBox(
        label: 'Platform Window',
        sublabel: 'NSWindow / HWND / GtkWindow',
        color: const Color(0xFFCDE8D8),
        border: _kGreen,
        y: 316,
      ),
      _ArchBox(
        label: 'Secondary FlutterView',
        sublabel: 'Independent rendering pipeline',
        color: const Color(0xFFCCE2F5),
        border: const Color(0xFF1565C0),
        y: 412,
      ),
    ];

    final double centerX = size.width / 2;

    for (int i = 0; i < boxes.length; i++) {
      final _ArchBox b = boxes[i];
      final Rect rect = Rect.fromLTWH(
        centerX - boxW / 2,
        b.y.toDouble(),
        boxW,
        boxH,
      );

      // Fill.
      boxPaint.color = b.color;
      final RRect rrect =
          RRect.fromRectAndRadius(rect, const Radius.circular(10));
      canvas.drawRRect(rrect, boxPaint);

      // Border.
      borderPaint.color = b.border;
      canvas.drawRRect(rrect, borderPaint);

      // Label text.
      _drawText(
        canvas,
        b.label,
        Offset(centerX, b.y + 14.0),
        const TextStyle(
          color: Color(0xFF0E0C24),
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        size.width - 40,
      );

      // Sub-label.
      _drawText(
        canvas,
        b.sublabel,
        Offset(centerX, b.y + 32.0),
        const TextStyle(
          color: Color(0xFF555577),
          fontSize: 11,
        ),
        size.width - 40,
      );

      // Draw arrow from previous box to this box.
      if (i > 0) {
        final double arrowTopY = boxes[i - 1].y + boxH.toDouble();
        final double arrowBotY = b.y.toDouble();
        final Path arrowPath = Path()
          ..moveTo(centerX, arrowTopY + 2)
          ..lineTo(centerX, arrowBotY - 10);
        canvas.drawPath(arrowPath, arrowPaint);
        // Arrowhead.
        final Path head = Path()
          ..moveTo(centerX - 7, arrowBotY - 10)
          ..lineTo(centerX, arrowBotY - 2)
          ..lineTo(centerX + 7, arrowBotY - 10);
        canvas.drawPath(head, arrowPaint..style = PaintingStyle.stroke);
      }
    }

    // Legend box on the right side.
    _drawText(
      canvas,
      'owns ▸',
      Offset(centerX + boxW / 2 + 36, 170),
      const TextStyle(
        color: Color(0xFF888888),
        fontSize: 12,
        fontStyle: FontStyle.italic,
      ),
      100,
    );
  }

  void _drawText(
      Canvas canvas, String text, Offset center, TextStyle style, double maxW) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxW);
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ArchBox {
  const _ArchBox({
    required this.label,
    required this.sublabel,
    required this.color,
    required this.border,
    required this.y,
  });
  final String label;
  final String sublabel;
  final Color color;
  final Color border;
  final int y;
}

// ===========================================================================
// Tab 3 — Widget Tree Integration
// ===========================================================================
class _WidgetTreeTab extends StatelessWidget {
  const _WidgetTreeTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Widget Tree Integration'),
          const SizedBox(height: 8),
          _BodyText(
            'RegularWindow sits inside the normal widget tree.  The parent '
            'provides layout constraints; RegularWindow translates those into the '
            'initial OS window size.  Inside RegularWindow you place a full Scaffold '
            'just like any other Flutter screen.',
          ),
          const SizedBox(height: 20),

          // Visual tree diagram.
          const _TreeDiagram(),

          const SizedBox(height: 24),
          _SectionTitle('GlobalKey access'),
          const SizedBox(height: 12),
          _CodeBlock(code: '''
// Obtain a reference to the controller after mount:
final key = GlobalKey<RegularWindowState>();

RegularWindow(
  key: key,
  controller: myController,
  child: const MyWindowContent(),
);

// Later, retrieve the controller imperatively:
final ctrl = key.currentState?.controller;
ctrl?.setTitle('Updated Title');
'''),
          const SizedBox(height: 20),

          _SectionTitle('Scaffold inside a RegularWindow'),
          const SizedBox(height: 12),
          _BodyText(
            'RegularWindow renders its child in a secondary FlutterView.  '
            'That FlutterView has its own MediaQuery, so a Scaffold inside '
            'RegularWindow receives its own window metrics (width, height, '
            'padding) independent from the primary window.',
          ),
          const SizedBox(height: 12),
          _CodeBlock(code: '''
RegularWindow(
  controller: controller,
  child: MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Secondary Window')),
      body: const Center(child: Text('Hello from another window!')),
    ),
  ),
);
'''),
          const SizedBox(height: 20),

          _SectionTitle('InheritedWidget lookup boundary'),
          const SizedBox(height: 12),
          _BodyText(
            'Because RegularWindow inserts a FlutterView boundary, '
            'InheritedWidgets (Theme, MediaQuery, Localizations, etc.) from '
            'the primary tree do NOT automatically propagate into the '
            'secondary window.  You must re-provide them explicitly inside the '
            'child of RegularWindow — typically by wrapping with a MaterialApp '
            'or by repeating the InheritedWidget providers.',
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kRedSoft,
              border: Border.all(color: _kRed),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.error_outline, color: _kRed, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: _BodyText(
                    'Accessing Theme.of(context) inside the child of '
                    'RegularWindow without re-providing the theme will return '
                    'the fallback Material theme, not your app theme.  Always '
                    'wrap the child with MaterialApp or Theme.',
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

/// Simple ASCII-style tree diagram rendered as nested containers.
class _TreeDiagram extends StatelessWidget {
  const _TreeDiagram();

  final List<_TreeNode> _nodes = const <_TreeNode>[
    _TreeNode(depth: 0, label: 'MaterialApp', badge: 'root FlutterView'),
    _TreeNode(depth: 1, label: 'Scaffold', badge: ''),
    _TreeNode(depth: 2, label: 'Row', badge: ''),
    _TreeNode(depth: 3, label: 'LeftPanel', badge: 'widget'),
    _TreeNode(depth: 3, label: 'RegularWindow', badge: 'NEW window'),
    _TreeNode(depth: 4, label: 'RegularWindowController', badge: 'controller'),
    _TreeNode(depth: 4, label: 'MaterialApp (child)', badge: 'secondary FlutterView'),
    _TreeNode(depth: 5, label: 'Scaffold', badge: 'secondary window UI'),
    _TreeNode(depth: 6, label: 'AppBar + Body', badge: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF18142E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _nodes.map((n) => _TreeNodeRow(node: n)).toList(),
      ),
    );
  }
}

class _TreeNode {
  const _TreeNode({required this.depth, required this.label, required this.badge});
  final int depth;
  final String label;
  final String badge;
}

class _TreeNodeRow extends StatelessWidget {
  const _TreeNodeRow({required this.node});
  final _TreeNode node;

  @override
  Widget build(BuildContext context) {
    final bool isRegularWindow = node.label == 'RegularWindow';
    return Padding(
      padding: EdgeInsets.only(left: node.depth * 20.0, top: 4, bottom: 4),
      child: Row(
        children: [
          if (node.depth > 0)
            Text(
              '└─ ',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.35),
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isRegularWindow
                  ? _kPurple.withValues(alpha: 0.8)
                  : Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6),
              border: isRegularWindow
                  ? Border.all(color: _kChromeLight, width: 1)
                  : null,
            ),
            child: Text(
              node.label,
              style: TextStyle(
                color: isRegularWindow ? Colors.white : _kChromeLight,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight:
                    isRegularWindow ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (node.badge.isNotEmpty) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _kAccent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                node.badge,
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ===========================================================================
// Tab 4 — Simulated Desktop App
// ===========================================================================
class _SimulatedDesktopAppTab extends StatelessWidget {
  const _SimulatedDesktopAppTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Simulated Multi-Window Desktop App'),
          const SizedBox(height: 8),
          _BodyText(
            'The two cards below simulate how two RegularWindow instances appear '
            'on a desktop.  Each has its own window chrome (title bar + controls), '
            'independent content area, and focus state.  Tap the focus button to '
            'swap which window is "active".',
          ),
          const SizedBox(height: 20),

          // Virtual screen area.
          Container(
            width: double.infinity,
            height: 560,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFF1A1030), Color(0xFF0A0820)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder.withValues(alpha: 0.3)),
            ),
            child: Stack(
              children: [
                // Taskbar at the bottom.
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF16142A),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      border: Border(
                          top: BorderSide(
                              color: Colors.white.withValues(alpha: 0.1))),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Icon(Icons.apps, color: Colors.white54, size: 20),
                        const SizedBox(width: 16),
                        _TaskbarApp(icon: Icons.desktop_windows, label: 'Main'),
                        const SizedBox(width: 8),
                        _TaskbarApp(icon: Icons.settings, label: 'Settings'),
                      ],
                    ),
                  ),
                ),

                // Primary window card.
                Positioned(
                  top: 24,
                  left: 16,
                  width: 360,
                  height: 280,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _primaryFocused,
                    builder: (context, focused, _) {
                      return ValueListenableBuilder<String>(
                        valueListenable: _primaryTitle,
                        builder: (context, title, _) {
                          return _WindowCard(
                            title: title,
                            focused: focused,
                            accentColor: _kSeed,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _BodyText('RegularWindow #1 — Main Application'),
                                const SizedBox(height: 12),
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: _kGlass,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Primary window content\n(child widget tree)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: _kInk, fontSize: 13),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    _SmallButton(
                                      label: 'Focus',
                                      onTap: () {
                                        _primaryFocused.value = true;
                                        _secondaryFocused.value = false;
                                        _log('Primary window gained focus');
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    _SmallButton(
                                      label: 'Rename',
                                      onTap: () {
                                        _primaryTitle.value =
                                            _primaryTitle.value == 'Main Application'
                                                ? 'App — Modified'
                                                : 'Main Application';
                                        _log('Primary title changed to: ${_primaryTitle.value}');
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Secondary window card.
                Positioned(
                  top: 80,
                  left: 240,
                  width: 340,
                  height: 280,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _secondaryFocused,
                    builder: (context, focused, _) {
                      return ValueListenableBuilder<String>(
                        valueListenable: _secondaryTitle,
                        builder: (context, title, _) {
                          return _WindowCard(
                            title: title,
                            focused: focused,
                            accentColor: _kGreen,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _BodyText('RegularWindow #2 — Settings Panel'),
                                const SizedBox(height: 12),
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: _kGreenSoft,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Secondary window content\n(independent FlutterView)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: _kInk, fontSize: 13),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    _SmallButton(
                                      label: 'Focus',
                                      onTap: () {
                                        _secondaryFocused.value = true;
                                        _primaryFocused.value = false;
                                        _log('Secondary window gained focus');
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    _SmallButton(
                                      label: 'Rename',
                                      onTap: () {
                                        _secondaryTitle.value =
                                            _secondaryTitle.value == 'Settings Panel'
                                                ? 'Settings — Unsaved'
                                                : 'Settings Panel';
                                        _log('Secondary title changed to: ${_secondaryTitle.value}');
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Operation log.
          ValueListenableBuilder<List<String>>(
            valueListenable: _opLog,
            builder: (context, log, _) {
              return _LogBox(entries: log);
            },
          ),
        ],
      ),
    );
  }
}

class _TaskbarApp extends StatelessWidget {
  const _TaskbarApp({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white70),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

/// Simulated OS window chrome card.
class _WindowCard extends StatelessWidget {
  const _WindowCard({
    required this.title,
    required this.focused,
    required this.accentColor,
    required this.child,
  });
  final String title;
  final bool focused;
  final Color accentColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: focused ? accentColor : _kBorder,
          width: focused ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: focused
                ? accentColor.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.15),
            blurRadius: focused ? 16 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chrome title bar.
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: focused ? _kChromeDark : _kChrome,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                // Traffic lights.
                _TrafficLight(color: _kRed),
                const SizedBox(width: 6),
                _TrafficLight(color: _kYellow),
                const SizedBox(width: 6),
                _TrafficLight(color: _kGreen),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: focused
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (focused)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'FOCUSED',
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 9,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
              ],
            ),
          ),
          // Content area.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrafficLight extends StatelessWidget {
  const _TrafficLight({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

// ===========================================================================
// Tab 5 — Lifecycle
// ===========================================================================
class _LifecycleTab extends StatelessWidget {
  const _LifecycleTab();

  static const List<_PhaseInfo> _phases = <_PhaseInfo>[
    _PhaseInfo(
      index: 0,
      label: 'Unmounted',
      icon: Icons.power_off,
      color: Color(0xFF888888),
      description: 'RegularWindow is not in the widget tree.  '
          'No OS window exists.  Controller holds no native handle.',
    ),
    _PhaseInfo(
      index: 1,
      label: 'Mounting',
      icon: Icons.build_circle_outlined,
      color: _kYellow,
      description: 'RegularWindow.createElement() is called.  '
          'Controller requests the embedder to create an OS window.  '
          'A FlutterView is allocated and attached to the engine.',
    ),
    _PhaseInfo(
      index: 2,
      label: 'Window Shown',
      icon: Icons.visibility,
      color: _kGreen,
      description: 'The OS window becomes visible.  '
          'The child widget tree is inflated inside the secondary FlutterView.  '
          'First frame is rendered; window appears on screen.',
    ),
    _PhaseInfo(
      index: 3,
      label: 'Active',
      icon: Icons.check_circle,
      color: _kSeed,
      description: 'Window is live.  User can interact, resize, move, and '
          'focus.  Widget rebuilds propagate normally through the child tree.  '
          'Size and position changes may arrive as constraint updates.',
    ),
    _PhaseInfo(
      index: 4,
      label: 'Unmounting',
      icon: Icons.power_settings_new,
      color: _kRed,
      description: 'RegularWindow leaves the widget tree.  '
          'Controller.dispose() is called.  The embedder destroys the OS window '
          'and deallocates the FlutterView.  Child tree is unmounted.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Window Attachment / Detachment Lifecycle'),
          const SizedBox(height: 8),
          _BodyText(
            'Tap a phase below to highlight it and read the detailed description.',
          ),
          const SizedBox(height: 20),

          // Phase stepper.
          ValueListenableBuilder<int>(
            valueListenable: _lifecyclePhase,
            builder: (context, phase, _) {
              return Column(
                children: [
                  // Phase row.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _phases.asMap().entries.map((entry) {
                      final int i = entry.key;
                      final _PhaseInfo p = entry.value;
                      final bool active = i == phase;
                      final bool completed = i < phase;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _lifecyclePhase.value = i;
                              _log('Lifecycle: ${p.label}');
                            },
                            child: Column(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: active
                                        ? p.color
                                        : completed
                                            ? p.color.withValues(alpha: 0.5)
                                            : const Color(0xFFDDDDDD),
                                    boxShadow: active
                                        ? [
                                            BoxShadow(
                                              color: p.color
                                                  .withValues(alpha: 0.4),
                                              blurRadius: 10,
                                            )
                                          ]
                                        : null,
                                  ),
                                  child: Icon(
                                    p.icon,
                                    color: active || completed
                                        ? Colors.white
                                        : Colors.grey,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    p.label,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          active ? p.color : Colors.grey,
                                      fontWeight: active
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (i < _phases.length - 1)
                            Container(
                              width: 24,
                              height: 2,
                              color: i < phase
                                  ? _phases[i].color.withValues(alpha: 0.5)
                                  : const Color(0xFFDDDDDD),
                            ),
                        ],
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Phase description card.
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _phases[phase].color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: _phases[phase].color.withValues(alpha: 0.4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(_phases[phase].icon,
                                color: _phases[phase].color, size: 28),
                            const SizedBox(width: 12),
                            Text(
                              _phases[phase].label,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: _phases[phase].color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _phases[phase].description,
                          style: const TextStyle(
                              color: _kInk, fontSize: 14, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),
          _SectionTitle('Lifecycle code pattern'),
          const SizedBox(height: 12),
          _CodeBlock(code: '''
class _MyPage extends StatelessWidget {
  const _MyPage({required this.showSettings});
  final bool showSettings;

  @override
  Widget build(BuildContext context) {
    // RegularWindow is ONLY in the tree when showSettings == true.
    // When false, the OS window is destroyed automatically.
    if (!showSettings) return const SizedBox.shrink();
    return RegularWindow(
      controller: settingsController,
      child: const SettingsScreen(),
    );
  }
}
'''),
          const SizedBox(height: 24),
          _SectionTitle('AppLifecycleListener integration'),
          const SizedBox(height: 12),
          _BodyText(
            'Use AppLifecycleListener to react when the user activates or '
            'deactivates the desktop app.  Combine this with '
            'RegularWindowController.setVisible() to hide secondary windows '
            'when the app is backgrounded and restore them on resume.',
          ),
          const SizedBox(height: 12),
          _CodeBlock(code: '''
AppLifecycleListener(
  onHide: () => secondaryController.setVisible(false),
  onShow: () => secondaryController.setVisible(true),
  child: YourApp(),
);
'''),
        ],
      ),
    );
  }
}

class _PhaseInfo {
  const _PhaseInfo({
    required this.index,
    required this.label,
    required this.icon,
    required this.color,
    required this.description,
  });
  final int index;
  final String label;
  final IconData icon;
  final Color color;
  final String description;
}

// ===========================================================================
// Tab 6 — Size & Position
// ===========================================================================
class _SizePositionTab extends StatelessWidget {
  const _SizePositionTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Size & Position'),
          const SizedBox(height: 8),
          _BodyText(
            'RegularWindow translates Flutter BoxConstraints into OS-level window '
            'dimensions.  Adjust the sliders below to see how the simulated window '
            'card responds to size and position changes.',
          ),
          const SizedBox(height: 20),

          // Size sliders.
          _SectionTitle('Width'),
          ValueListenableBuilder<Size>(
            valueListenable: _primarySize,
            builder: (context, size, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Slider(
                    value: size.width,
                    min: 300,
                    max: 1400,
                    divisions: 22,
                    label: '${size.width.round()} px',
                    onChanged: (v) {
                      _primarySize.value = Size(v, _primarySize.value.height);
                      _log('Width → ${v.round()}');
                    },
                  ),
                  _SectionTitle('Height'),
                  Slider(
                    value: size.height,
                    min: 200,
                    max: 900,
                    divisions: 14,
                    label: '${size.height.round()} px',
                    onChanged: (v) {
                      _primarySize.value = Size(_primarySize.value.width, v);
                      _log('Height → ${v.round()}');
                    },
                  ),
                  const SizedBox(height: 16),
                  _SectionTitle('Position (screen coordinates)'),
                  ValueListenableBuilder<Offset>(
                    valueListenable: _primaryPos,
                    builder: (context, pos, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('X: ${pos.dx.round()} px',
                              style: const TextStyle(color: _kInk)),
                          Slider(
                            value: pos.dx,
                            min: 0,
                            max: 1920,
                            divisions: 48,
                            label: '${pos.dx.round()}',
                            onChanged: (v) {
                              _primaryPos.value =
                                  Offset(v, _primaryPos.value.dy);
                              _log('X → ${v.round()}');
                            },
                          ),
                          Text('Y: ${pos.dy.round()} px',
                              style: const TextStyle(color: _kInk)),
                          Slider(
                            value: pos.dy,
                            min: 0,
                            max: 1080,
                            divisions: 27,
                            label: '${pos.dy.round()}',
                            onChanged: (v) {
                              _primaryPos.value =
                                  Offset(_primaryPos.value.dx, v);
                              _log('Y → ${v.round()}');
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Simulated window preview.
                  Container(
                    width: double.infinity,
                    height: 260,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1030),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      children: [
                        // Grid lines.
                        CustomPaint(
                          size: const Size(double.infinity, 260),
                          painter: _GridPainter(),
                        ),
                        // Window preview (scaled down).
                        Positioned(
                          left: (_primaryPos.value.dx / 1920 * 480)
                              .clamp(0, 360),
                          top: (_primaryPos.value.dy / 1080 * 260)
                              .clamp(0, 180),
                          width:
                              (_primarySize.value.width / 1920 * 480).clamp(60, 320),
                          height: (_primarySize.value.height / 1080 * 260)
                              .clamp(40, 160),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: _kSeed, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: _kSeed.withValues(alpha: 0.4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: _kChromeDark,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Main Application',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 7),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '${size.width.round()}×${size.height.round()}',
                                      style: const TextStyle(
                                          fontSize: 9, color: _kInk),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Coordinates label.
                        Positioned(
                          bottom: 8,
                          right: 12,
                          child: Text(
                            '(${_primaryPos.value.dx.round()}, ${_primaryPos.value.dy.round()})',
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),
          _SectionTitle('How constraints become window dimensions'),
          const SizedBox(height: 12),
          _BodyText(
            'When RegularWindow is laid out, it reports the OS window\'s current '
            'client area size as its RenderBox size.  The OS window does NOT '
            'automatically resize to match parent constraints — RegularWindow\'s '
            'layout just reflects the window\'s actual size.  To programmatically '
            'resize, call controller.setSize(Size) which asynchronously requests '
            'the OS to resize and then delivers a new FlutterView metrics event.',
          ),
          const SizedBox(height: 12),
          _CodeBlock(code: '''
// Request resize:
await controller.setSize(const Size(1024, 768));

// Request move:
await controller.setPosition(const Offset(200, 100));

// Constraints are delivered back via MediaQuery in the child tree:
final size = MediaQuery.sizeOf(context); // reflects OS window size
'''),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ===========================================================================
// Tab 7 — Focus Handling
// ===========================================================================
class _FocusHandlingTab extends StatelessWidget {
  const _FocusHandlingTab();

  static const List<_FocusStage> _stages = <_FocusStage>[
    _FocusStage(
      label: 'User clicks OS window title bar',
      arrow: 'OS → Embedder',
      color: Color(0xFF1565C0),
      desc: 'The OS delivers a focus event to the Flutter embedder for this window.',
    ),
    _FocusStage(
      label: 'Embedder notifies FlutterView',
      arrow: 'Embedder → FlutterView',
      color: Color(0xFF4527A0),
      desc: 'The embedder calls FlutterView.updateSemantics / setFocus, marking the secondary FlutterView as active.',
    ),
    _FocusStage(
      label: 'Flutter FocusManager reactivates',
      arrow: 'FlutterView → FocusManager',
      color: _kPurple,
      desc: 'The FocusManager inside the secondary widget tree restores the last focused FocusNode.',
    ),
    _FocusStage(
      label: 'FocusNode.hasFocus == true',
      arrow: 'FocusManager → FocusNode',
      color: _kSeed,
      desc: 'Descendant widgets rebuild with the correct focus state; TextField cursors blink, buttons show focus rings.',
    ),
    _FocusStage(
      label: 'KeyEvent delivery resumes',
      arrow: 'OS → FocusNode',
      color: _kGreen,
      desc: 'Keyboard events are delivered to the focused FocusNode in the secondary tree via the HardwareKeyboard API.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Focus Event Flow'),
          const SizedBox(height: 8),
          _BodyText(
            'Each RegularWindow has its own independent Flutter focus scope.  '
            'Focus events from the OS are translated by the embedder into Flutter '
            'FocusManager calls on the secondary FlutterView.',
          ),
          const SizedBox(height: 20),

          // Focus pipeline diagram.
          Column(
            children: _stages.map((s) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      color: s.color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: s.color.withValues(alpha: 0.35)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: s.color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                s.arrow,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                s.label,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: _kInk,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          s.desc,
                          style: const TextStyle(
                              color: Color(0xFF444466), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  if (s != _stages.last)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Center(
                        child: Icon(Icons.arrow_downward,
                            size: 18, color: Color(0xFFAAAAAA)),
                      ),
                    ),
                ],
              );
            }).toList(),
          ),

          const SizedBox(height: 24),
          _SectionTitle('Focus isolation — two windows'),
          const SizedBox(height: 12),
          _BodyText(
            'The two simulated windows below illustrate focus isolation.  '
            'Each window maintains its own FocusScope.  Switching focus '
            'from one window to the other does NOT automatically move focus '
            'inside the other window — it restores the last active FocusNode '
            'in that window\'s scope.',
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: _primaryFocused,
                  builder: (context, focused, _) {
                    return _FocusWindowPreview(
                      label: 'Window 1 — Main',
                      focused: focused,
                      color: _kSeed,
                      focusNode: 'searchField',
                      onFocus: () {
                        _primaryFocused.value = true;
                        _secondaryFocused.value = false;
                        _log('Focus → Window 1');
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: _secondaryFocused,
                  builder: (context, focused, _) {
                    return _FocusWindowPreview(
                      label: 'Window 2 — Settings',
                      focused: focused,
                      color: _kGreen,
                      focusNode: 'apiKeyField',
                      onFocus: () {
                        _secondaryFocused.value = true;
                        _primaryFocused.value = false;
                        _log('Focus → Window 2');
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          _SectionTitle('WindowFocusAware pattern'),
          const SizedBox(height: 12),
          _CodeBlock(code: '''
// Listen to window focus changes inside the secondary window:
WindowFocusAware(
  onFocusGained: () {
    // Resume animations, refresh data, etc.
  },
  onFocusLost: () {
    // Pause animations, auto-save, etc.
  },
  child: MyWindowContent(),
);
'''),
        ],
      ),
    );
  }
}

class _FocusStage {
  const _FocusStage({
    required this.label,
    required this.arrow,
    required this.color,
    required this.desc,
  });
  final String label;
  final String arrow;
  final Color color;
  final String desc;
}

class _FocusWindowPreview extends StatelessWidget {
  const _FocusWindowPreview({
    required this.label,
    required this.focused,
    required this.color,
    required this.focusNode,
    required this.onFocus,
  });
  final String label;
  final bool focused;
  final Color color;
  final String focusNode;
  final VoidCallback onFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: focused ? color.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: focused ? color : _kBorder,
          width: focused ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                focused ? Icons.radio_button_checked : Icons.radio_button_off,
                color: focused ? color : Colors.grey,
                size: 16,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: focused ? color : _kInk,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: focused
                  ? color.withValues(alpha: 0.05)
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: focused ? color.withValues(alpha: 0.5) : _kBorder,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.text_fields,
                    size: 14,
                    color: focused ? color : Colors.grey),
                const SizedBox(width: 6),
                Text(
                  focusNode,
                  style: const TextStyle(
                      fontSize: 11, fontFamily: 'monospace'),
                ),
                if (focused) ...[
                  const Spacer(),
                  Container(
                    width: 2,
                    height: 14,
                    color: color,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onFocus,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Click to Focus',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Tab 8 — Multi-Window Demo
// ===========================================================================
class _MultiWindowTab extends StatelessWidget {
  const _MultiWindowTab();

  static const List<String> _routes = <String>[
    'Inspector',
    'Timeline',
    'Console',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Multi-Window Demo'),
          const SizedBox(height: 8),
          _BodyText(
            'Two RegularWindow instances running simultaneously, each showing '
            'different content.  The secondary window supports content routing: '
            'select a route below to change what the second window displays.',
          ),
          const SizedBox(height: 20),

          // Route selector.
          _SectionTitle('Secondary Window Route'),
          const SizedBox(height: 10),
          ValueListenableBuilder<int>(
            valueListenable: _secondaryRoute,
            builder: (context, route, _) {
              return Row(
                children: _routes.asMap().entries.map((e) {
                  final bool selected = e.key == route;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        _secondaryRoute.value = e.key;
                        _log('Route → ${e.value}');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected ? _kSeed : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selected ? _kSeed : _kBorder,
                          ),
                        ),
                        child: Text(
                          e.value,
                          style: TextStyle(
                            color: selected ? Colors.white : _kInk,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 20),

          // Two-window side-by-side layout.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _MultiWindowCard(
                  windowNumber: 1,
                  title: 'Main Application',
                  accentColor: _kSeed,
                  content: const _MainWindowContent(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ValueListenableBuilder<int>(
                  valueListenable: _secondaryRoute,
                  builder: (context, route, _) {
                    return _MultiWindowCard(
                      windowNumber: 2,
                      title: _routes[route],
                      accentColor: _kGreen,
                      content: _SecondaryWindowContent(route: route),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          _SectionTitle('Multi-window routing code pattern'),
          const SizedBox(height: 12),
          _CodeBlock(code: '''
// Router delegate that handles secondary window routes.
class SecondaryWindowRouter extends RouterDelegate {
  // ...
  @override
  Widget build(BuildContext context) {
    return switch (currentRoute) {
      'inspector' => const InspectorPanel(),
      'timeline'  => const TimelinePanel(),
      'console'   => const ConsolePanel(),
      _           => const SizedBox.shrink(),
    };
  }
}

// Wire up inside RegularWindow:
RegularWindow(
  controller: secondaryController,
  child: MaterialApp.router(
    routerDelegate: SecondaryWindowRouter(),
    routeInformationParser: SimpleRouteParser(),
  ),
);
'''),

          const SizedBox(height: 24),
          _SectionTitle('Communication between windows'),
          const SizedBox(height: 12),
          _BodyText(
            'Since both windows live in the same Dart isolate, you can share '
            'state using any standard Flutter state-management approach: '
            'ValueNotifier, ChangeNotifier, Riverpod, Bloc, etc.  The two '
            'FlutterViews are separated at the rendering layer but share the '
            'same heap and event loop.',
          ),
          const SizedBox(height: 12),
          _CodeBlock(code: '''
// Shared ValueNotifier visible to both windows:
final selectedItem = ValueNotifier<Item?>(null);

// Primary window updates it:
RegularWindow(
  controller: primaryCtrl,
  child: ItemListView(onSelect: (item) => selectedItem.value = item),
);

// Secondary window reacts:
RegularWindow(
  controller: secondaryCtrl,
  child: ValueListenableBuilder<Item?>(
    valueListenable: selectedItem,
    builder: (ctx, item, _) => ItemDetailView(item: item),
  ),
);
'''),
        ],
      ),
    );
  }
}

class _MultiWindowCard extends StatelessWidget {
  const _MultiWindowCard({
    required this.windowNumber,
    required this.title,
    required this.accentColor,
    required this.content,
  });
  final int windowNumber;
  final String title;
  final Color accentColor;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chrome.
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _kChromeDark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                _TrafficLight(color: _kRed),
                const SizedBox(width: 5),
                _TrafficLight(color: _kYellow),
                const SizedBox(width: 5),
                _TrafficLight(color: _kGreen),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'WIN $windowNumber',
                    style: TextStyle(
                        color: accentColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: content,
          ),
        ],
      ),
    );
  }
}

class _MainWindowContent extends StatelessWidget {
  const _MainWindowContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Primary Window',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 13, color: _kInk),
        ),
        const SizedBox(height: 8),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: _kGlass,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'Item list — tap an item\nto update secondary window',
              textAlign: TextAlign.center,
              style: TextStyle(color: _kInk, fontSize: 12),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ...List<Widget>.generate(3, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _kBorder),
              ),
              child: Text(
                'Item ${i + 1}',
                style:
                    const TextStyle(fontSize: 12, color: _kInk),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _SecondaryWindowContent extends StatelessWidget {
  const _SecondaryWindowContent({required this.route});
  final int route;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> contents = <Map<String, Object>>[
      {
        'icon': Icons.search,
        'label': 'Inspector',
        'desc': 'Widget tree inspector showing\nelement properties and state.',
        'color': _kSeed,
      },
      {
        'icon': Icons.timeline,
        'label': 'Timeline',
        'desc': 'Frame rendering timeline with\nraster and UI thread breakdown.',
        'color': _kGreen,
      },
      {
        'icon': Icons.terminal,
        'label': 'Console',
        'desc': 'Debug log output from\nthe running application.',
        'color': _kChrome,
      },
    ];
    final Map<String, Object> c = contents[route];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(c['icon'] as IconData,
                color: c['color'] as Color, size: 20),
            const SizedBox(width: 8),
            Text(
              c['label'] as String,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: _kInk),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: (c['color'] as Color).withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: (c['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Center(
            child: Text(
              c['desc'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: _kInk),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ...List<Widget>.generate(2, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _kBorder),
              ),
              child: Text(
                '${c['label']} row ${i + 1}',
                style:
                    const TextStyle(fontSize: 11, color: _kInk),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ===========================================================================
// Tab 9 — Pitfalls & API Cheat Sheet
// ===========================================================================
class _PitfallsApiTab extends StatelessWidget {
  const _PitfallsApiTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Common Pitfalls'),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 1,
            title: 'Desktop-only — no mobile or web',
            body: 'RegularWindow is guarded by a platform assertion.  '
                'On Android, iOS, or Web it will throw at runtime.  '
                'Always check the platform before constructing.',
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 2,
            title: 'RegularWindowController lifecycle management',
            body: 'You must create the controller in a widget that outlives '
                'the RegularWindow, and call controller.dispose() when done.  '
                'Failing to dispose leaks the OS window handle.',
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 3,
            title: 'Nested RegularWindows are not supported',
            body: 'Do not place a RegularWindow inside the child of another '
                'RegularWindow.  The embedder only supports one level of OS '
                'window nesting.  For hierarchical UI, use OverlayEntry or '
                'PopupWindow instead.',
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 4,
            title: 'InheritedWidget propagation across FlutterView boundary',
            body: 'Theme, MediaQuery, and other InheritedWidgets do not cross '
                'the FlutterView boundary.  Wrap RegularWindow\'s child with '
                'MaterialApp or manually re-provide all necessary InheritedWidgets.',
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 5,
            title: 'setSize / setPosition are asynchronous',
            body: 'These calls request the OS to resize/move the window.  '
                'The window does not resize synchronously — wait for the next '
                'MediaQuery update inside the child tree before reading the new size.',
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 6,
            title: 'HiDPI / device pixel ratio',
            body: 'The secondary FlutterView may have a different device pixel '
                'ratio than the primary window if the user has multi-monitor '
                'setups with different DPI screens.  Always read '
                'MediaQuery.devicePixelRatioOf(context) inside the child tree.',
          ),

          const SizedBox(height: 28),
          _SectionTitle('API Cheat Sheet'),
          const SizedBox(height: 12),
          _ApiCard(entries: const <_ApiEntry>[
            _ApiEntry(
              name: 'RegularWindow({Key? key, required RegularWindowController controller, required Widget child})',
              desc: 'Constructor. controller owns the OS handle; child renders inside the secondary FlutterView.',
            ),
            _ApiEntry(
              name: 'RegularWindowController()',
              desc: 'Default constructor. Creates a new OS window handle when first attached to a RegularWindow.',
            ),
            _ApiEntry(
              name: 'RegularWindowController.fromWindowId(int windowId)',
              desc: 'Attaches to an already-existing OS window by platform-specific window ID.',
            ),
            _ApiEntry(
              name: 'controller.setTitle(String title) → Future<void>',
              desc: 'Updates the OS window title bar.',
            ),
            _ApiEntry(
              name: 'controller.setSize(Size size) → Future<void>',
              desc: 'Requests a client-area resize.  Actual size confirmed via MediaQuery in the child tree.',
            ),
            _ApiEntry(
              name: 'controller.setPosition(Offset position) → Future<void>',
              desc: 'Moves the window to (x, y) in screen coordinates (logical pixels).',
            ),
            _ApiEntry(
              name: 'controller.setMinimumSize(Size? size) → Future<void>',
              desc: 'Sets the minimum allowed window size.  Pass null to remove the constraint.',
            ),
            _ApiEntry(
              name: 'controller.setMaximumSize(Size? size) → Future<void>',
              desc: 'Sets the maximum allowed window size.  Pass null to remove the constraint.',
            ),
            _ApiEntry(
              name: 'controller.setVisible(bool visible) → Future<void>',
              desc: 'Shows or hides the window without destroying it.  Use for background/restore.',
            ),
            _ApiEntry(
              name: 'controller.close() → Future<void>',
              desc: 'Requests the OS to close and destroy the window.  Triggers the RegularWindow unmount.',
            ),
            _ApiEntry(
              name: 'controller.dispose()',
              desc: 'Releases the controller.  Must be called when the owning widget is disposed.',
            ),
            _ApiEntry(
              name: 'controller.size → Size',
              desc: 'Current logical client-area size of the OS window.',
            ),
            _ApiEntry(
              name: 'controller.position → Offset',
              desc: 'Current top-left position of the window in screen coordinates.',
            ),
            _ApiEntry(
              name: 'controller.focused → bool',
              desc: 'True when this window is the frontmost OS window with keyboard focus.',
            ),
          ]),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.index,
    required this.title,
    required this.body,
  });
  final int index;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _kRed.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  color: _kRed,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                      color: Color(0xFF444466), fontSize: 12, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Shared helper widgets.
// ===========================================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF18142E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        code.trim(),
        style: const TextStyle(
          color: Color(0xFFCDD6F4),
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  const _SmallButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: _kSeed,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _LogBox extends StatelessWidget {
  const _LogBox({required this.entries});
  final List<String> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF18142E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Operation log — tap buttons to log events',
          style: TextStyle(color: Colors.white38, fontSize: 12),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF18142E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: entries.reversed
            .take(8)
            .toList()
            .asMap()
            .entries
            .map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              '▸ ${e.value}',
              style: TextStyle(
                color: e.key == 0
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.5),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ApiEntry {
  const _ApiEntry({required this.name, required this.desc});
  final String name;
  final String desc;
}

class _ApiCard extends StatelessWidget {
  const _ApiCard({required this.entries});
  final List<_ApiEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: entries.asMap().entries.map((e) {
          final bool last = e.key == entries.length - 1;
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: last
                  ? null
                  : const Border(
                      bottom: BorderSide(color: _kBorder),
                    ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.value.name,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: _kSeed,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  e.value.desc,
                  style: const TextStyle(
                      color: Color(0xFF444466), fontSize: 12, height: 1.4),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StepList extends StatelessWidget {
  const _StepList({required this.steps});
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.map((s) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_right, size: 18, color: _kSeed),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  s,
                  style: const TextStyle(
                      color: _kInk, fontSize: 13, height: 1.45),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _RoleTable extends StatelessWidget {
  const _RoleTable({required this.rows});
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: _kGlass,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: const [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Component',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: _kInk),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Type',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: _kInk),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'Role',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: _kInk),
                  ),
                ),
              ],
            ),
          ),
          ...rows.asMap().entries.map((e) {
            final bool last = e.key == rows.length - 1;
            final List<String> cols = e.value;
            return Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: e.key.isOdd
                    ? const Color(0xFFFAF9FF)
                    : Colors.white,
                border: last
                    ? null
                    : const Border(
                        bottom: BorderSide(color: _kBorder)),
                borderRadius: last
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      cols[0],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: _kSeed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _kGlass,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        cols[1],
                        style: const TextStyle(
                            fontSize: 11, color: _kInk),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        cols[2],
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF444466)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

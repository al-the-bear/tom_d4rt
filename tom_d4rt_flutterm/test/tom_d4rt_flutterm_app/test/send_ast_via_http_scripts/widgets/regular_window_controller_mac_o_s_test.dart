import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — STATELESS widgets read from these.
// ---------------------------------------------------------------------------

/// Tracks the simulated macOS window state.
/// 0 = normal, 1 = miniaturized, 2 = zoomed, 3 = fullscreen
final ValueNotifier<int> _windowState = ValueNotifier<int>(0);

/// Whether the simulated window traffic-light close button has been pressed.
final ValueNotifier<bool> _windowClosed = ValueNotifier<bool>(false);

/// Whether the window is miniaturized (traffic-light yellow button).
final ValueNotifier<bool> _windowMiniaturized = ValueNotifier<bool>(false);

/// Whether the window is zoomed / maximised (traffic-light green button).
final ValueNotifier<bool> _windowZoomed = ValueNotifier<bool>(false);

/// Active Cocoa window style-mask bitmask flags (subset).
final ValueNotifier<Set<int>> _activeStyleMasks = ValueNotifier<Set<int>>(
  <int>{1, 2, 4, 8}, // titled | closable | miniaturizable | resizable
);

/// Whether the simulated window is in dark mode.
final ValueNotifier<bool> _darkMode = ValueNotifier<bool>(false);

/// Current simulated window title.
final ValueNotifier<String> _windowTitle =
    ValueNotifier<String>('My Flutter App');

/// Whether titlebar area blending is active.
final ValueNotifier<bool> _titlebarBlend = ValueNotifier<bool>(false);

/// Selected multi-window count (1–4).
final ValueNotifier<int> _multiWindowCount = ValueNotifier<int>(1);

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const Color _macosRed = Color(0xFFFF5F57);
const Color _macosYellow = Color(0xFFFFBD2E);
const Color _macosGreen = Color(0xFF28CA41);
// _macosTrafficInactive is intentionally omitted (inactive state not rendered in this demo).
const Color _macosTitlebarLight = Color(0xFFECECEC);
const Color _macosTitlebarDark = Color(0xFF3A3A3A);
const Color _macosWindowBodyLight = Color(0xFFF5F5F5);
const Color _macosWindowBodyDark = Color(0xFF252525);

const List<String> _windowStateLabels = <String>[
  'Normal',
  'Miniaturized',
  'Zoomed',
  'Fullscreen',
];

const List<IconData> _windowStateIcons = <IconData>[
  Icons.crop_square_rounded,
  Icons.minimize_rounded,
  Icons.zoom_out_map_rounded,
  Icons.fullscreen_rounded,
];

// ---------------------------------------------------------------------------
// Entry point (d4rt sandbox)
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return ValueListenableBuilder<bool>(
    valueListenable: _darkMode,
    builder: (BuildContext ctx, bool dark, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0078D4),
            brightness: dark ? Brightness.dark : Brightness.light,
          ),
        ),
        home: const _RegularWindowControllerMacOSDemo(),
      );
    },
  );
}

// ---------------------------------------------------------------------------
// Root scaffold with DefaultTabController (9 tabs)
// ---------------------------------------------------------------------------

class _RegularWindowControllerMacOSDemo extends StatelessWidget {
  const _RegularWindowControllerMacOSDemo();

  static const List<Tab> _tabs = <Tab>[
    Tab(icon: Icon(Icons.info_outline), text: 'Hero'),
    Tab(icon: Icon(Icons.desktop_mac_outlined), text: 'Chrome'),
    Tab(icon: Icon(Icons.account_tree_outlined), text: 'Bridge'),
    Tab(icon: Icon(Icons.account_balance_outlined), text: 'States'),
    Tab(icon: Icon(Icons.view_compact_outlined), text: 'Titlebar'),
    Tab(icon: Icon(Icons.style_outlined), text: 'Styles'),
    Tab(icon: Icon(Icons.view_quilt_outlined), text: 'Tiling'),
    Tab(icon: Icon(Icons.grid_view_outlined), text: 'Multi'),
    Tab(icon: Icon(Icons.warning_amber_outlined), text: 'Pitfalls'),
  ];

  static const List<Widget> _pages = <Widget>[
    _Tab0HeroBanner(),
    _Tab1WindowChrome(),
    _Tab2BridgeDiagram(),
    _Tab3StateMachine(),
    _Tab4TitlebarArea(),
    _Tab5CocoaStyles(),
    _Tab6WindowTiling(),
    _Tab7MultiWindow(),
    _Tab8Pitfalls(),
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cs.primaryContainer,
          title: const Text('RegularWindowControllerMacOS — Deep Demo'),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: _tabs,
          ),
          actions: <Widget>[
            Tooltip(
              message: 'Toggle dark mode',
              child: ValueListenableBuilder<bool>(
                valueListenable: _darkMode,
                builder: (_, bool dark, Widget? child) => IconButton(
                  icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () => _darkMode.value = !_darkMode.value,
                ),
              ),
            ),
          ],
        ),
        body: TabBarView(children: _pages),
      ),
    );
  }
}

// ===========================================================================
// TAB 0 — Hero Banner
// ===========================================================================

class _Tab0HeroBanner extends StatelessWidget {
  const _Tab0HeroBanner();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ── Hero card ──────────────────────────────────────────────────
          Card(
            color: cs.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.desktop_mac, size: 48, color: cs.primary),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'RegularWindowControllerMacOS',
                          style: tt.headlineMedium?.copyWith(
                            color: cs.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'macOS Desktop Window Management in Flutter',
                    style: tt.titleLarge?.copyWith(
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'On macOS, every Flutter window lives inside an NSWindow managed '
                    "by AppKit. Flutter's engine provides a FlutterViewController "
                    'which bridges Dart rendering into a native Cocoa view hierarchy. '
                    'RegularWindowControllerMacOS is the Dart-side handle that lets '
                    'your application code read and write window properties - size, '
                    'position, title, appearance, fullscreen state - through a thin '
                    'platform-channel layer that proxies calls to NSWindow.',
                    style: tt.bodyLarge?.copyWith(
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // ── Key concepts ───────────────────────────────────────────────
          Text('Key Concepts', style: tt.titleLarge),
          const SizedBox(height: 12),
          _ConceptGrid(
            items: const <_ConceptItem>[
              _ConceptItem(
                icon: Icons.layers_outlined,
                title: 'NSWindow Bridge',
                body: 'Platform channels relay method calls between Dart and '
                    'Objective-C. Each call crosses the engine boundary via '
                    'MethodChannel or PlatformDispatcher.',
              ),
              _ConceptItem(
                icon: Icons.tune_outlined,
                title: 'Window Properties',
                body: 'Title, frame, appearance (aqua / vibrantDark), level, '
                    'styleMask, isMovableByWindowBackground — all writable from '
                    'Dart once the controller is initialised.',
              ),
              _ConceptItem(
                icon: Icons.notifications_outlined,
                title: 'NSNotificationCenter',
                body: 'AppKit posts notifications for window lifecycle events: '
                    'NSWindowDidBecomeKeyNotification, NSWindowDidMiniaturizeNotification, '
                    'NSWindowDidEnterFullScreenNotification, etc.',
              ),
              _ConceptItem(
                icon: Icons.memory_outlined,
                title: 'Memory Safety',
                body: 'NSWindow is reference-counted. Holding a strong Dart '
                    'reference past dealloc leads to dangling pointers. The '
                    'controller uses weak references internally.',
              ),
              _ConceptItem(
                icon: Icons.security_outlined,
                title: 'Sandboxing',
                body: 'Mac App Store apps run in a sandbox. Some window-level '
                    'operations (CGWindowLevel, screen recording) require '
                    'entitlements; others are simply forbidden.',
              ),
              _ConceptItem(
                icon: Icons.color_lens_outlined,
                title: 'Appearance API',
                body: 'NSAppearance lets you force aqua / vibrantDark '
                    'independently of the system preference, enabling per-window '
                    'theme overrides in multi-window apps.',
              ),
            ],
          ),
          const SizedBox(height: 24),
          // ── Historical context ─────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Historical context', style: tt.titleMedium),
                  const SizedBox(height: 10),
                  const _TimelineItem(
                    year: '2019',
                    event: 'Flutter macOS desktop preview ships. NSWindow '
                        'access requires direct Swift/ObjC plugin code.',
                  ),
                  const _TimelineItem(
                    year: '2022',
                    event: 'Flutter 3.0 stabilises macOS support. '
                        'window_manager community package provides NSWindow '
                        'property access via platform channels.',
                  ),
                  const _TimelineItem(
                    year: '2023',
                    event: 'Multi-view API (FlutterView) lands. NSWindow '
                        'references become per-view rather than global.',
                  ),
                  const _TimelineItem(
                    year: '2024',
                    event: 'RegularWindowController hierarchy formalised in '
                        'flutter_platform_widget packages; per-platform '
                        'subclasses (MacOS, Linux, Win32) introduced.',
                  ),
                  const _TimelineItem(
                    year: '2025+',
                    event: 'Sequoia tiling APIs, Stage Manager integration, '
                        'and multi-scene support expand the surface area of '
                        'the macOS window controller.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // ── Quick-start snippet ────────────────────────────────────────
          Text('Quick-Start (educational simulation)', style: tt.titleMedium),
          const SizedBox(height: 8),
          _CodeSnippet(
            code: '''
// Obtain the controller for the current window
final controller = RegularWindowControllerMacOS();

// Initialise (must be called before any property access)
await controller.init();

// Read window properties
final title = await controller.getTitle();
final frame = await controller.getFrame();

// Write window properties
await controller.setTitle('My Updated Title');
await controller.setFrame(
  const Rect.fromLTWH(100, 100, 800, 600),
);

// Enter fullscreen
await controller.setFullScreen(true);

// Listen for close events
controller.addListener(() {
  if (controller.isClosing) handleWindowClose();
});''',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 1 — Simulated macOS Window Chrome
// ===========================================================================

class _Tab1WindowChrome extends StatelessWidget {
  const _Tab1WindowChrome();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Simulated macOS Window Chrome', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'The widget below is a Flutter-drawn facsimile of a macOS window. '
            'Tap the traffic-light buttons and title-bar controls to see how '
            'RegularWindowControllerMacOS maps Dart calls to AppKit state.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),
          // Window chrome widget
          const _SimulatedMacOSWindow(),
          const SizedBox(height: 24),
          // State readout
          Text('Controller State Readout', style: tt.titleMedium),
          const SizedBox(height: 12),
          ValueListenableBuilder<int>(
            valueListenable: _windowState,
            builder: (_, int state, Widget? child) => ValueListenableBuilder<bool>(
              valueListenable: _windowClosed,
              builder: (_, bool closed, Widget? child) => Card(
                color: cs.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _StateRow(label: 'isVisible', value: '${!closed}'),
                      _StateRow(
                        label: 'windowState',
                        value: _windowStateLabels[state],
                      ),
                      _StateRow(
                        label: 'isMiniaturized',
                        value: '${state == 1}',
                      ),
                      _StateRow(label: 'isZoomed', value: '${state == 2}'),
                      _StateRow(
                        label: 'isFullScreen',
                        value: '${state == 3}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Traffic light legend
          Text('Traffic-Light Buttons — AppKit Mapping', style: tt.titleMedium),
          const SizedBox(height: 12),
          _TrafficLightLegend(),
          const SizedBox(height: 20),
          Text('Window Title Editing', style: tt.titleMedium),
          const SizedBox(height: 8),
          _WindowTitleEditor(),
        ],
      ),
    );
  }
}

class _SimulatedMacOSWindow extends StatelessWidget {
  const _SimulatedMacOSWindow();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (_, bool dark, Widget? child) => ValueListenableBuilder<bool>(
        valueListenable: _windowClosed,
        builder: (_, bool closed, Widget? child) => ValueListenableBuilder<int>(
          valueListenable: _windowState,
          builder: (_, int state, Widget? child) => ValueListenableBuilder<String>(
            valueListenable: _windowTitle,
            builder: (_, String title, Widget? child) => ValueListenableBuilder<bool>(
              valueListenable: _titlebarBlend,
              builder: (_, bool blend, Widget? child) {
                if (closed) {
                  return _ClosedWindowPlaceholder(dark: dark);
                }
                if (state == 1) {
                  return _MiniaturizedDock(dark: dark, title: title);
                }
                return _WindowFrame(
                  dark: dark,
                  title: title,
                  isFullscreen: state == 3,
                  isZoomed: state == 2,
                  titlebarBlend: blend,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _WindowFrame extends StatelessWidget {
  const _WindowFrame({
    required this.dark,
    required this.title,
    required this.isFullscreen,
    required this.isZoomed,
    required this.titlebarBlend,
  });

  final bool dark;
  final String title;
  final bool isFullscreen;
  final bool isZoomed;
  final bool titlebarBlend;

  @override
  Widget build(BuildContext context) {
    final Color titlebarColor =
        dark ? _macosTitlebarDark : _macosTitlebarLight;
    final Color bodyColor =
        dark ? _macosWindowBodyDark : _macosWindowBodyLight;
    final Color textColor = dark ? Colors.white : Colors.black87;

    return Container(
      height: isFullscreen ? 340 : 280,
      decoration: BoxDecoration(
        color: bodyColor,
        borderRadius:
            isFullscreen ? BorderRadius.zero : BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(60),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius:
            isFullscreen ? BorderRadius.zero : BorderRadius.circular(12),
        child: Column(
          children: <Widget>[
            // Title bar
            Container(
              height: titlebarBlend ? 52 : 38,
              color: titlebarColor,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: <Widget>[
                  // Traffic lights
                  _TrafficLight(
                    color: _macosRed,
                    tooltip: 'Close — [NSWindow close]',
                    onTap: () {
                      _windowClosed.value = true;
                      _windowState.value = 0;
                    },
                  ),
                  const SizedBox(width: 8),
                  _TrafficLight(
                    color: _macosYellow,
                    tooltip: 'Miniaturize — [NSWindow miniaturize:]',
                    onTap: () {
                      _windowMiniaturized.value = true;
                      _windowState.value = 1;
                    },
                  ),
                  const SizedBox(width: 8),
                  _TrafficLight(
                    color: _macosGreen,
                    tooltip: isZoomed
                        ? 'Restore — [NSWindow zoom:]'
                        : 'Zoom — [NSWindow zoom:] / Enter fullscreen',
                    onTap: () {
                      _windowZoomed.value = !_windowZoomed.value;
                      _windowState.value = _windowState.value == 2 ? 0 : 2;
                    },
                  ),
                  const Spacer(),
                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  const Spacer(),
                  // Toolbar area hint
                  if (titlebarBlend)
                    Icon(Icons.tune, size: 16, color: textColor),
                  const SizedBox(width: 4),
                  Icon(Icons.add_circle_outline, size: 16, color: textColor),
                ],
              ),
            ),
            // Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      isFullscreen
                          ? 'Window is in Full Screen mode'
                          : isZoomed
                              ? 'Window is Zoomed (maximised)'
                              : 'Window is in Normal state',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Flutter content renders into this area via '
                      'FlutterView → Metal layer → CALayer → NSView → NSWindow.',
                      style: TextStyle(color: textColor, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        _WindowActionButton(
                          label: 'Fullscreen',
                          icon: Icons.fullscreen,
                          onTap: () => _windowState.value =
                              _windowState.value == 3 ? 0 : 3,
                        ),
                        const SizedBox(width: 8),
                        _WindowActionButton(
                          label: 'Reset',
                          icon: Icons.refresh,
                          onTap: () {
                            _windowState.value = 0;
                            _windowClosed.value = false;
                            _windowMiniaturized.value = false;
                            _windowZoomed.value = false;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClosedWindowPlaceholder extends StatelessWidget {
  const _ClosedWindowPlaceholder({required this.dark});
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: dark ? _macosWindowBodyDark : _macosWindowBodyLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withAlpha(80)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.close_rounded, size: 36, color: _macosRed),
            const SizedBox(height: 8),
            Text(
              '[NSWindow close] called — window deallocated',
              style: TextStyle(
                color: dark ? Colors.white70 : Colors.black54,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Recreate Window'),
              onPressed: () {
                _windowClosed.value = false;
                _windowState.value = 0;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniaturizedDock extends StatelessWidget {
  const _MiniaturizedDock({required this.dark, required this.title});
  final bool dark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: dark ? _macosTitlebarDark : _macosTitlebarLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.desktop_mac, size: 28, color: _macosYellow),
            const SizedBox(height: 4),
            Text(
              '$title (miniaturized in Dock)',
              style: TextStyle(
                fontSize: 12,
                color: dark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _windowState.value = 0,
              child: const Text('Deminiaturize'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrafficLight extends StatelessWidget {
  const _TrafficLight({
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: color.withAlpha(180), width: 0.5),
          ),
        ),
      ),
    );
  }
}

class _WindowActionButton extends StatelessWidget {
  const _WindowActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      icon: Icon(icon, size: 14),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      onPressed: onTap,
    );
  }
}

class _TrafficLightLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _LegendRow(
          color: _macosRed,
          label: 'Red (Close)',
          objcCall: '[NSWindow close]',
          effect: 'Deallocates window; posts NSWindowWillCloseNotification',
        ),
        _LegendRow(
          color: _macosYellow,
          label: 'Yellow (Miniaturize)',
          objcCall: '[NSWindow miniaturize:]',
          effect:
              'Animates window into Dock tile; posts NSWindowDidMiniaturizeNotification',
        ),
        _LegendRow(
          color: _macosGreen,
          label: 'Green (Zoom / Fullscreen)',
          objcCall: '[NSWindow zoom:] or toggleFullScreen:',
          effect:
              'Zooms to ideal size or enters full-screen space via NSWindowStyleMaskFullScreen',
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.color,
    required this.label,
    required this.objcCall,
    required this.effect,
  });

  final Color color;
  final String label;
  final String objcCall;
  final String effect;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(label,
                    style: tt.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(
                  objcCall,
                  style: tt.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(effect, style: tt.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WindowTitleEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _windowTitle,
      builder: (_, String title, Widget? child) => Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              initialValue: title,
              decoration: const InputDecoration(
                labelText: 'Window Title',
                helperText: 'Maps to [NSWindow setTitle:]',
                border: OutlineInputBorder(),
              ),
              onChanged: (String v) => _windowTitle.value = v,
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Apply'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 2 — NSWindow Integration Diagram (CustomPainter)
// ===========================================================================

class _Tab2BridgeDiagram extends StatelessWidget {
  const _Tab2BridgeDiagram();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('NSWindow Integration Diagram', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'This CustomPainter diagram shows the full call path from Dart '
            'code through the Flutter engine into AppKit.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 380,
            child: CustomPaint(
              painter: _BridgeDiagramPainter(cs: cs),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 24),
          Text('Layer Descriptions', style: tt.titleMedium),
          const SizedBox(height: 12),
          _LayerDescriptions(),
          const SizedBox(height: 24),
          Text('Channel Protocol Detail', style: tt.titleMedium),
          const SizedBox(height: 12),
          _CodeSnippet(
            code: '''
// Dart side — RegularWindowControllerMacOS uses MethodChannel
static const MethodChannel _channel =
    MethodChannel('regular_window_controller_macos');

Future<String> getTitle() async {
  final result = await _channel.invokeMethod<String>('getTitle');
  return result ?? '';
}

Future<void> setTitle(String title) async {
  await _channel.invokeMethod<void>('setTitle', <String, dynamic>{
    'title': title,
  });
}

// Swift / Objective-C side
FlutterMethodChannel *channel =
    [FlutterMethodChannel methodChannelWithName:@"regular_window_controller_macos"
                                binaryMessenger:flutterEngine.binaryMessenger];

[channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
  if ([call.method isEqualToString:@"setTitle"]) {
    NSString *title = call.arguments[@"title"];
    [self.window setTitle:title];
    result(nil);
  } else if ([call.method isEqualToString:@"getTitle"]) {
    result(self.window.title);
  }
}];''',
          ),
        ],
      ),
    );
  }
}

class _BridgeDiagramPainter extends CustomPainter {
  const _BridgeDiagramPainter({required this.cs});
  final ColorScheme cs;

  static const List<String> _layers = <String>[
    'Dart — RegularWindowControllerMacOS',
    'MethodChannel (platform channel)',
    'Flutter Engine (C++)',
    'FlutterViewController (ObjC)',
    'NSView (CAMetalLayer)',
    'NSWindow (AppKit)',
    'macOS WindowServer / Quartz',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()..style = PaintingStyle.fill;
    final Paint arrowPaint = Paint()
      ..color = cs.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final Paint arrowHeadPaint = Paint()
      ..color = cs.primary
      ..style = PaintingStyle.fill;

    const double boxHeight = 38;
    const double boxSpacing = 12;
    const double boxWidth = 320;
    final double startX = (size.width - boxWidth) / 2;
    double y = 8;

    final List<Color> boxColors = <Color>[
      cs.primaryContainer,
      cs.secondaryContainer,
      cs.tertiaryContainer,
      cs.secondaryContainer,
      cs.surfaceContainerHighest,
      cs.errorContainer,
      cs.tertiaryContainer,
    ];

    for (int i = 0; i < _layers.length; i++) {
      boxPaint.color = boxColors[i % boxColors.length];
      final RRect rr = RRect.fromRectAndRadius(
        Rect.fromLTWH(startX, y, boxWidth, boxHeight),
        const Radius.circular(8),
      );
      canvas.drawRRect(rr, boxPaint);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: _layers[i],
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxWidth - 16);
      tp.paint(canvas, Offset(startX + 8, y + (boxHeight - tp.height) / 2));

      if (i < _layers.length - 1) {
        final double arrowX = startX + boxWidth / 2;
        final double arrowTop = y + boxHeight + 1;
        final double arrowBot = arrowTop + boxSpacing - 2;
        canvas.drawLine(Offset(arrowX, arrowTop), Offset(arrowX, arrowBot - 4),
            arrowPaint);
        final Path head = Path()
          ..moveTo(arrowX, arrowBot)
          ..lineTo(arrowX - 5, arrowBot - 7)
          ..lineTo(arrowX + 5, arrowBot - 7)
          ..close();
        canvas.drawPath(head, arrowHeadPaint);
      }
      y += boxHeight + boxSpacing;
    }

    // Bidirectional annotation
    final TextPainter notePainter = TextPainter(
      text: TextSpan(
        text: '↕  bidirectional via MethodChannel result/error callbacks',
        style: TextStyle(
          fontSize: 10,
          color: cs.secondary,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 32);
    notePainter.paint(canvas, Offset(16, size.height - 20));
  }

  @override
  bool shouldRepaint(_BridgeDiagramPainter old) => old.cs != cs;
}

class _LayerDescriptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _LayerDesc(
          layer: 'Dart (RegularWindowControllerMacOS)',
          desc: 'Public API surface. Exposes async methods '
              '(getTitle, setTitle, getFrame, setFrame, setFullScreen, …) '
              'and streams for lifecycle notifications.',
        ),
        _LayerDesc(
          layer: 'MethodChannel',
          desc: 'Named channel registered at engine start. Serialises '
              'Dart values to platform codecs (StandardMessageCodec) '
              'and dispatches on the platform thread.',
        ),
        _LayerDesc(
          layer: 'Flutter Engine (C++)',
          desc: 'Manages the binary messenger, task runners, and codec '
              'pipeline. Routes messages between Dart isolate and platform.',
        ),
        _LayerDesc(
          layer: 'FlutterViewController',
          desc: 'NSViewController subclass. Owns the Flutter view, '
              'handles resize / DPI changes, forwards method calls to '
              'the AppKit window object.',
        ),
        _LayerDesc(
          layer: 'NSView / CAMetalLayer',
          desc: 'The GPU-backed Metal surface where Flutter composites '
              'its layer tree each frame.',
        ),
        _LayerDesc(
          layer: 'NSWindow',
          desc: 'The Cocoa window object. Title bar, chrome, shadow, '
              'and event routing live here. Controlled via ObjC messages.',
        ),
        _LayerDesc(
          layer: 'WindowServer / Quartz',
          desc: 'System-level compositor. Composites all on-screen windows '
              'into the display framebuffer with GPU acceleration.',
        ),
      ],
    );
  }
}

class _LayerDesc extends StatelessWidget {
  const _LayerDesc({required this.layer, required this.desc});
  final String layer;
  final String desc;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 220,
            child: Text(layer,
                style:
                    tt.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(desc, style: tt.bodySmall)),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 3 — Window State Machine
// ===========================================================================

class _Tab3StateMachine extends StatelessWidget {
  const _Tab3StateMachine();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Window State Machine', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'macOS windows cycle through four primary states. '
            'RegularWindowControllerMacOS exposes each state as a '
            'readable/writable property backed by NSWindow queries.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),
          // Live SegmentedButton
          Text('Live State Selector', style: tt.titleMedium),
          const SizedBox(height: 12),
          ValueListenableBuilder<int>(
            valueListenable: _windowState,
            builder: (_, int state, Widget? child) => SegmentedButton<int>(
              segments: List<ButtonSegment<int>>.generate(
                _windowStateLabels.length,
                (int i) => ButtonSegment<int>(
                  value: i,
                  label: Text(_windowStateLabels[i]),
                  icon: Icon(_windowStateIcons[i]),
                ),
              ),
              selected: <int>{state},
              onSelectionChanged: (Set<int> s) {
                _windowState.value = s.first;
                _windowClosed.value = false;
              },
            ),
          ),
          const SizedBox(height: 24),
          // State detail cards
          ValueListenableBuilder<int>(
            valueListenable: _windowState,
            builder: (_, int state, Widget? child) =>
                _StateDetailCard(state: state, cs: cs),
          ),
          const SizedBox(height: 24),
          // State machine diagram
          Text('State Transition Diagram', style: tt.titleMedium),
          const SizedBox(height: 12),
          SizedBox(
            height: 260,
            child: CustomPaint(
              painter: _StateMachinePainter(cs: cs),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 24),
          // Notifications table
          Text('NSNotificationCenter Events', style: tt.titleMedium),
          const SizedBox(height: 12),
          _NotificationsTable(),
        ],
      ),
    );
  }
}

class _StateDetailCard extends StatelessWidget {
  const _StateDetailCard({required this.state, required this.cs});
  final int state;
  final ColorScheme cs;

  static const List<Map<String, String>> _details =
      <Map<String, String>>[
    <String, String>{
      'title': 'Normal',
      'desc':
          'The default window state. Frame is freely movable and resizable. '
              'Window is fully visible and responds to input.',
      'api':
          'isMinimized == false\nisZoomed == false\nisFullscreen == false',
      'transition': 'Can enter Miniaturized, Zoomed, or Fullscreen.',
    },
    <String, String>{
      'title': 'Miniaturized',
      'desc':
          'Window is collapsed into the Dock as an icon tile. '
              'The window is hidden from the screen but still allocated.',
      'api': 'isMinimized == true\n[window miniaturize:sender]',
      'transition':
          'Restored to Normal via double-click in Dock or deminiaturize:.',
    },
    <String, String>{
      'title': 'Zoomed',
      'desc':
          'Window expands to fill available screen area, leaving Dock and '
              'menu bar visible. Not the same as fullscreen.',
      'api': 'isZoomed == true\n[window zoom:sender]',
      'transition': 'Returns to Normal via [window zoom:sender] again.',
    },
    <String, String>{
      'title': 'Fullscreen',
      'desc':
          'Window occupies its own Space, hiding Dock and menu bar. '
              'Triggered by NSWindowStyleMaskFullScreen toggling via '
              'toggleFullScreen:.',
      'api':
          'styleMask contains NSWindowStyleMaskFullScreen\n[window toggleFullScreen:sender]',
      'transition': 'Exit fullscreen returns to Normal or Zoomed.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, String> d = _details[state];
    final TextTheme tt = Theme.of(context).textTheme;
    return Card(
      color: cs.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(_windowStateIcons[state], size: 28, color: cs.primary),
                const SizedBox(width: 12),
                Text(d['title']!,
                    style: tt.titleLarge
                        ?.copyWith(color: cs.onPrimaryContainer)),
              ],
            ),
            const SizedBox(height: 12),
            Text(d['desc']!,
                style: tt.bodyMedium
                    ?.copyWith(color: cs.onPrimaryContainer)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surface.withAlpha(160),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                d['api']!,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('Transitions: ${d['transition']}',
                style: tt.bodySmall
                    ?.copyWith(color: cs.onPrimaryContainer)),
          ],
        ),
      ),
    );
  }
}

class _StateMachinePainter extends CustomPainter {
  const _StateMachinePainter({required this.cs});
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = cs.primaryContainer
      ..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..color = cs.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint arrowPaint = Paint()
      ..color = cs.secondary
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final List<Offset> positions = <Offset>[
      Offset(size.width * 0.5, 40),       // Normal (top center)
      Offset(size.width * 0.15, 160),     // Miniaturized (left)
      Offset(size.width * 0.85, 160),     // Zoomed (right)
      Offset(size.width * 0.5, 220),      // Fullscreen (bottom center)
    ];

    // Draw arrows first
    for (int from = 0; from < positions.length; from++) {
      for (int to = 0; to < positions.length; to++) {
        if (from == to) continue;
        if (from == 0 || to == 0) {
          _drawArrow(canvas, positions[from], positions[to], arrowPaint);
        }
      }
    }

    // Draw state circles
    final List<String> labels = <String>[
      'Normal',
      'Mini',
      'Zoomed',
      'Fullscreen',
    ];
    for (int i = 0; i < positions.length; i++) {
      canvas.drawCircle(positions[i], 32, circlePaint);
      canvas.drawCircle(positions[i], 32, borderPaint);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(fontSize: 10, color: cs.onSurface),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 60);
      tp.paint(
        canvas,
        Offset(
          positions[i].dx - tp.width / 2,
          positions[i].dy - tp.height / 2,
        ),
      );
    }
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to, Paint paint) {
    final Offset dir = (to - from) / (to - from).distance;
    final Offset start = from + dir * 34;
    final Offset end = to - dir * 34;
    canvas.drawLine(start, end, paint);
    // arrowhead
    final Paint head = Paint()
      ..color = cs.secondary
      ..style = PaintingStyle.fill;
    final Offset perp = Offset(-dir.dy, dir.dx);
    final Path p = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(end.dx - dir.dx * 8 + perp.dx * 4,
          end.dy - dir.dy * 8 + perp.dy * 4)
      ..lineTo(end.dx - dir.dx * 8 - perp.dx * 4,
          end.dy - dir.dy * 8 - perp.dy * 4)
      ..close();
    canvas.drawPath(p, head);
  }

  @override
  bool shouldRepaint(_StateMachinePainter old) => old.cs != cs;
}

class _NotificationsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    const List<List<String>> rows = <List<String>>[
      <String>[
        'NSWindowDidBecomeKeyNotification',
        'Window gains keyboard focus',
        'Normal',
      ],
      <String>[
        'NSWindowDidResignKeyNotification',
        'Window loses keyboard focus',
        'Normal',
      ],
      <String>[
        'NSWindowDidMiniaturizeNotification',
        'Window enters Dock',
        'Miniaturized',
      ],
      <String>[
        'NSWindowDidDeminiaturizeNotification',
        'Window leaves Dock',
        'Normal',
      ],
      <String>[
        'NSWindowDidEnterFullScreenNotification',
        'Fullscreen animation done',
        'Fullscreen',
      ],
      <String>[
        'NSWindowDidExitFullScreenNotification',
        'Exit fullscreen done',
        'Normal',
      ],
      <String>[
        'NSWindowDidZoomNotification',
        'Window zoomed / unzoomed',
        'Zoomed / Normal',
      ],
      <String>[
        'NSWindowWillCloseNotification',
        'Window about to close',
        'Any',
      ],
    ];

    return Table(
      border: TableBorder.all(
        color: cs.outlineVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
      },
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: cs.primaryContainer),
          children: <Widget>[
            _tableHeader('Notification'),
            _tableHeader('Meaning'),
            _tableHeader('New State'),
          ],
        ),
        ...rows.map(
          (List<String> r) => TableRow(
            children: <Widget>[
              _tableData(r[0], mono: true),
              _tableData(r[1]),
              _tableData(r[2]),
            ],
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// TAB 4 — Toolbar + Titlebar Area
// ===========================================================================

class _Tab4TitlebarArea extends StatelessWidget {
  const _Tab4TitlebarArea();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Toolbar + Titlebar Area', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'macOS allows Flutter content to extend into the titlebar region '
            'using NSWindow.titlebarAppearsTransparent and '
            'NSWindow.styleMask including NSFullSizeContentViewWindowMask. '
            'RegularWindowControllerMacOS exposes this via titlebarStyle.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),
          // Toggle
          ValueListenableBuilder<bool>(
            valueListenable: _titlebarBlend,
            builder: (_, bool blend, Widget? child) => SwitchListTile(
              title: const Text('Enable Full-Size Content View'),
              subtitle: Text(
                blend
                    ? 'NSFullSizeContentViewWindowMask active — '
                        'Flutter renders behind title bar'
                    : 'Standard title bar — content starts below chrome',
              ),
              value: blend,
              onChanged: (bool v) => _titlebarBlend.value = v,
            ),
          ),
          const SizedBox(height: 16),
          // Preview
          _TitlebarPreview(),
          const SizedBox(height: 24),
          // Options detail
          Text('Titlebar Style Options', style: tt.titleMedium),
          const SizedBox(height: 12),
          _OptionsGrid(
            items: const <_OptionItem>[
              _OptionItem(
                title: 'normal',
                subtitle: 'Standard NSWindow title bar',
                code:
                    'controller.setTitlebarStyle(TitlebarStyle.normal)',
              ),
              _OptionItem(
                title: 'hidden',
                subtitle: 'No visible title bar; only close/min/zoom buttons',
                code:
                    'controller.setTitlebarStyle(TitlebarStyle.hidden)',
              ),
              _OptionItem(
                title: 'hiddenInset',
                subtitle: 'Buttons inset; full content view below',
                code:
                    'controller.setTitlebarStyle(TitlebarStyle.hiddenInset)',
              ),
              _OptionItem(
                title: 'expandedInset',
                subtitle: 'macOS 12+ expanded inset layout',
                code:
                    'controller.setTitlebarStyle(TitlebarStyle.expandedInset)',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Titlebar Padding in Flutter', style: tt.titleMedium),
          const SizedBox(height: 12),
          Card(
            color: cs.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'When content extends into the titlebar, add top padding '
                    'equal to the titlebar height (typically 28–52 pt) to '
                    'avoid interactive elements being obscured by traffic lights.',
                    style: tt.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  _CodeSnippet(
                    code: '''
// Query safe area inset from Flutter's MediaQuery
final topInset = MediaQuery.of(context).padding.top;

// Or use platform channel to get actual titlebar height
final titlebarHeight =
    await controller.getTitlebarHeight();

Padding(
  padding: EdgeInsets.only(top: titlebarHeight),
  child: YourContent(),
)''',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Background Material', style: tt.titleMedium),
          const SizedBox(height: 12),
          _BackgroundMaterialDemo(cs: cs),
        ],
      ),
    );
  }
}

class _TitlebarPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _titlebarBlend,
      builder: (_, bool blend, Widget? child) => ValueListenableBuilder<bool>(
        valueListenable: _darkMode,
        builder: (_, bool dark, Widget? child) {
          final Color bg =
              dark ? _macosWindowBodyDark : _macosWindowBodyLight;
          final Color titlebarColor =
              dark ? _macosTitlebarDark : _macosTitlebarLight;
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: <Widget>[
                  if (!blend)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 38,
                        color: titlebarColor,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.center,
                        child: Text(
                          'Standard Title Bar',
                          style: TextStyle(
                            fontSize: 13,
                            color: dark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: blend ? 0 : 38,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: blend
                          ? (dark
                              ? Colors.indigo.shade900
                              : Colors.indigo.shade50)
                          : bg,
                      padding: EdgeInsets.only(
                        top: blend ? 38 : 8,
                        left: 16,
                        right: 16,
                        bottom: 8,
                      ),
                      child: Text(
                        blend
                            ? 'Flutter content extends behind title bar\n'
                                '(NSFullSizeContentViewWindowMask active)'
                            : 'Flutter content starts below title bar',
                        style: TextStyle(
                          fontSize: 12,
                          color: dark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  if (blend)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Row(
                        children: const <Widget>[
                          _TrafficLight(
                              color: _macosRed,
                              tooltip: 'Close',
                              onTap: _noOp),
                          SizedBox(width: 7),
                          _TrafficLight(
                              color: _macosYellow,
                              tooltip: 'Miniaturize',
                              onTap: _noOp),
                          SizedBox(width: 7),
                          _TrafficLight(
                              color: _macosGreen,
                              tooltip: 'Zoom',
                              onTap: _noOp),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void _noOp() {}

class _BackgroundMaterialDemo extends StatelessWidget {
  const _BackgroundMaterialDemo({required this.cs});
  final ColorScheme cs;

  static const List<List<String>> _materials = <List<String>>[
    <String>['none', 'Opaque window background'],
    <String>['titlebar', 'Titlebar material (vibrancy)'],
    <String>['selection', 'Selection highlight material'],
    <String>['menu', 'Menu background material'],
    <String>['popover', 'Popover background material'],
    <String>['sidebar', 'Source-list sidebar material'],
    <String>['headerView', 'Header view background'],
    <String>['sheet', 'Sheet background material'],
    <String>['windowBackground', 'Default window background'],
    <String>['hudWindow', 'HUD window (dark translucent)'],
    <String>['fullScreenUI', 'Full-screen UI background'],
    <String>['toolTip', 'Tooltip background material'],
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _materials
          .map(
            (List<String> m) => Tooltip(
              message: m[1],
              child: Chip(
                label: Text(m[0]),
                backgroundColor: cs.surfaceContainerHighest,
              ),
            ),
          )
          .toList(),
    );
  }
}

// ===========================================================================
// TAB 5 — Cocoa Window Styles
// ===========================================================================

class _Tab5CocoaStyles extends StatelessWidget {
  const _Tab5CocoaStyles();

  static const List<_StyleMaskEntry> _masks = <_StyleMaskEntry>[
    _StyleMaskEntry(
      bit: 1,
      name: 'NSWindowStyleMaskTitled',
      hex: '0x0001',
      desc: 'Window has a title bar.',
    ),
    _StyleMaskEntry(
      bit: 2,
      name: 'NSWindowStyleMaskClosable',
      hex: '0x0002',
      desc: 'Window has a close button.',
    ),
    _StyleMaskEntry(
      bit: 4,
      name: 'NSWindowStyleMaskMiniaturizable',
      hex: '0x0004',
      desc: 'Window has a miniaturize button.',
    ),
    _StyleMaskEntry(
      bit: 8,
      name: 'NSWindowStyleMaskResizable',
      hex: '0x0008',
      desc: 'Window can be resized by the user.',
    ),
    _StyleMaskEntry(
      bit: 16,
      name: 'NSWindowStyleMaskTexturedBackground',
      hex: '0x0040',
      desc: 'Window uses textured background (deprecated in macOS 10.14).',
    ),
    _StyleMaskEntry(
      bit: 32,
      name: 'NSWindowStyleMaskUnifiedTitleAndToolbar',
      hex: '0x1000',
      desc: 'Title and toolbar appear unified.',
    ),
    _StyleMaskEntry(
      bit: 64,
      name: 'NSWindowStyleMaskFullScreen',
      hex: '0x4000',
      desc: 'Window is in full-screen mode.',
    ),
    _StyleMaskEntry(
      bit: 128,
      name: 'NSWindowStyleMaskFullSizeContentView',
      hex: '0x8000',
      desc: 'Content view uses full window frame including titlebar.',
    ),
    _StyleMaskEntry(
      bit: 256,
      name: 'NSWindowStyleMaskUtilityWindow',
      hex: '0x10',
      desc: 'Floating utility panel; smaller chrome.',
    ),
    _StyleMaskEntry(
      bit: 512,
      name: 'NSWindowStyleMaskDocModalWindow',
      hex: '0x40',
      desc: 'Document-modal window (sheets).',
    ),
    _StyleMaskEntry(
      bit: 1024,
      name: 'NSWindowStyleMaskNonactivatingPanel',
      hex: '0x80',
      desc: 'Window does not activate the owning app when clicked.',
    ),
    _StyleMaskEntry(
      bit: 2048,
      name: 'NSWindowStyleMaskHUDWindow',
      hex: '0x2000',
      desc: 'HUD-style panel; dark translucent background.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Cocoa Window Style Masks', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'NSWindow.styleMask is a bitmask of NSWindowStyleMask values. '
            'RegularWindowControllerMacOS reads and writes the full mask '
            'or individual flag toggles. Toggle flags below to see how the '
            'bitmask changes.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),
          // Bitmask readout
          ValueListenableBuilder<Set<int>>(
            valueListenable: _activeStyleMasks,
            builder: (_, Set<int> active, Widget? child) {
              final int combined =
                  active.fold(0, (int acc, int b) => acc | b);
              return Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Current styleMask value',
                          style: tt.labelLarge),
                      const SizedBox(height: 8),
                      Text(
                        'Decimal: $combined    Hex: 0x${combined.toRadixString(16).toUpperCase().padLeft(4, '0')}    Binary: ${combined.toRadixString(2).padLeft(12, '0')}',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // Flag chips
          ValueListenableBuilder<Set<int>>(
            valueListenable: _activeStyleMasks,
            builder: (_, Set<int> active, Widget? child) => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _masks
                  .map(
                    (_StyleMaskEntry m) => FilterChip(
                      label: Text(
                        m.name.replaceFirst('NSWindowStyleMask', ''),
                        style: const TextStyle(fontSize: 11),
                      ),
                      tooltip: '${m.name} (${m.hex})\n${m.desc}',
                      selected: active.contains(m.bit),
                      onSelected: (bool on) {
                        final Set<int> next = Set<int>.from(active);
                        if (on) {
                          next.add(m.bit);
                        } else {
                          next.remove(m.bit);
                        }
                        _activeStyleMasks.value = next;
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
          Text('Style Mask Reference', style: tt.titleMedium),
          const SizedBox(height: 12),
          _StyleMaskTable(masks: _masks),
          const SizedBox(height: 24),
          Text('Preset Configurations', style: tt.titleMedium),
          const SizedBox(height: 12),
          _PresetChips(),
        ],
      ),
    );
  }
}

class _StyleMaskEntry {
  const _StyleMaskEntry({
    required this.bit,
    required this.name,
    required this.hex,
    required this.desc,
  });
  final int bit;
  final String name;
  final String hex;
  final String desc;
}

class _StyleMaskTable extends StatelessWidget {
  const _StyleMaskTable({required this.masks});
  final List<_StyleMaskEntry> masks;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(3),
        1: FixedColumnWidth(70),
        2: FlexColumnWidth(2),
      },
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: cs.secondaryContainer),
          children: <Widget>[
            _tableHeader('Flag Name'),
            _tableHeader('Hex'),
            _tableHeader('Effect'),
          ],
        ),
        ...masks.map(
          (_StyleMaskEntry m) => TableRow(
            children: <Widget>[
              _tableData(m.name, mono: true),
              _tableData(m.hex, mono: true),
              _tableData(m.desc),
            ],
          ),
        ),
      ],
    );
  }
}

class _PresetChips extends StatelessWidget {
  static const List<Map<String, dynamic>> _presets =
      <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'Standard App Window',
      'bits': <int>[1, 2, 4, 8],
    },
    <String, dynamic>{
      'name': 'Borderless (Overlay)',
      'bits': <int>[],
    },
    <String, dynamic>{
      'name': 'HUD Panel',
      'bits': <int>[1, 2, 2048],
    },
    <String, dynamic>{
      'name': 'Utility Panel',
      'bits': <int>[1, 2, 4, 256],
    },
    <String, dynamic>{
      'name': 'Full Content View',
      'bits': <int>[1, 2, 4, 8, 128],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _presets
          .map(
            (Map<String, dynamic> p) => ActionChip(
              label: Text(p['name'] as String),
              onPressed: () {
                _activeStyleMasks.value =
                    Set<int>.from(p['bits'] as List<int>);
              },
            ),
          )
          .toList(),
    );
  }
}

// ===========================================================================
// TAB 6 — Window Tiling
// ===========================================================================

class _Tab6WindowTiling extends StatelessWidget {
  const _Tab6WindowTiling();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Window Tiling — macOS Sequoia+', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'macOS Sequoia (15.0) introduced automatic Window Tiling: '
            'windows snap into halves, quarters, or equal-height thirds when '
            'dragged near screen edges. Stage Manager and Spaces add further '
            'workspace management layers that affect window placement.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),
          // Tiling visualisation
          _TilingVisualisation(cs: cs),
          const SizedBox(height: 24),
          Text('Sequoia Tiling Zones', style: tt.titleMedium),
          const SizedBox(height: 12),
          _TilingZonesTable(),
          const SizedBox(height: 24),
          Text('Stage Manager Implications', style: tt.titleMedium),
          const SizedBox(height: 12),
          _StageManagerCard(cs: cs),
          const SizedBox(height: 24),
          Text('Spaces Integration', style: tt.titleMedium),
          const SizedBox(height: 12),
          _SpacesCard(cs: cs, tt: tt),
          const SizedBox(height: 24),
          Text('RegularWindowControllerMacOS Tiling API', style: tt.titleMedium),
          const SizedBox(height: 12),
          _CodeSnippet(
            code: '''
// Opt window into tiling (macOS Sequoia+)
await controller.setCollectionBehavior(
  CollectionBehavior.managed |
  CollectionBehavior.participatesInCycle,
);

// Tile to left half
await controller.setFrame(
  Rect.fromLTWH(
    0,
    menuBarHeight,
    screenWidth / 2,
    screenHeight - menuBarHeight - dockHeight,
  ),
  animate: true,
);

// Listen for user-initiated tiling
controller.onFrameChanged.listen((Rect newFrame) {
  // Adapt layout to new frame dimensions
  layoutController.setWindowSize(newFrame.size);
});''',
          ),
        ],
      ),
    );
  }
}

class _TilingVisualisation extends StatelessWidget {
  const _TilingVisualisation({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            // Left half
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: cs.primary, width: 2),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.desktop_mac, color: cs.primary),
                      const SizedBox(height: 4),
                      Text('Left Half',
                          style: TextStyle(
                              fontSize: 11, color: cs.onPrimaryContainer)),
                      Text('50% width',
                          style: TextStyle(
                              fontSize: 10,
                              color: cs.onPrimaryContainer
                                  .withAlpha(180))),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Right half — subdivided
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: cs.secondaryContainer,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        border:
                            Border.all(color: cs.secondary, width: 2),
                      ),
                      child: Center(
                        child: Text('Top Right Quarter',
                            style: TextStyle(
                                fontSize: 10,
                                color: cs.onSecondaryContainer)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: cs.tertiaryContainer,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        border:
                            Border.all(color: cs.tertiary, width: 2),
                      ),
                      child: Center(
                        child: Text('Bottom Right Quarter',
                            style: TextStyle(
                                fontSize: 10,
                                color: cs.onTertiaryContainer)),
                      ),
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
}

class _TilingZonesTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    const List<List<String>> rows = <List<String>>[
      <String>['Drag to left edge', 'Left Half (50% width)'],
      <String>['Drag to right edge', 'Right Half (50% width)'],
      <String>['Drag to top-left corner', 'Top-Left Quarter (25%)'],
      <String>['Drag to top-right corner', 'Top-Right Quarter (25%)'],
      <String>['Drag to bottom-left corner', 'Bottom-Left Quarter (25%)'],
      <String>['Drag to bottom-right corner', 'Bottom-Right Quarter (25%)'],
      <String>['Drag to top edge', 'Full Screen (100%)'],
      <String>['Option + drag to edge', 'Proportional third'],
    ];
    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
      },
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: cs.primaryContainer),
          children: <Widget>[_tableHeader('Gesture'), _tableHeader('Result')],
        ),
        ...rows.map(
          (List<String> r) => TableRow(
            children: <Widget>[_tableData(r[0]), _tableData(r[1])],
          ),
        ),
      ],
    );
  }
}

class _StageManagerCard extends StatelessWidget {
  const _StageManagerCard({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Card(
      color: cs.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.view_quilt, color: cs.primary),
                const SizedBox(width: 8),
                Text('Stage Manager', style: tt.titleSmall),
              ],
            ),
            const SizedBox(height: 10),
            const _BulletPoint(
              'Each Stage Manager group is one or more windows '
              'associated with an app or task.',
            ),
            const _BulletPoint(
              'Flutter multi-window apps should set '
              'collectionBehavior = .managed to participate correctly '
              'in Stage Manager grouping.',
            ),
            const _BulletPoint(
              'Windows with .stationary behavior stay visible in '
              'the background across Stage Manager switches.',
            ),
            const _BulletPoint(
              'RegularWindowControllerMacOS exposes '
              'setCollectionBehavior() to configure Stage Manager '
              'participation.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SpacesCard extends StatelessWidget {
  const _SpacesCard({required this.cs, required this.tt});
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cs.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.space_dashboard_outlined, color: cs.secondary),
                const SizedBox(width: 8),
                Text('Spaces (Virtual Desktops)', style: tt.titleSmall),
              ],
            ),
            const SizedBox(height: 10),
            const _BulletPoint(
              'NSWindowCollectionBehaviorCanJoinAllSpaces — '
              'window appears on every Space.',
            ),
            const _BulletPoint(
              'NSWindowCollectionBehaviorMoveToActiveSpace — '
              'window moves to the active Space when the app activates.',
            ),
            const _BulletPoint(
              'NSWindowCollectionBehaviorStationary — window stays '
              'put when switching Spaces.',
            ),
            const _BulletPoint(
              'Fullscreen windows occupy their own dedicated Space '
              'and cannot be moved to another Space.',
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 7 — Multi-Window Architecture
// ===========================================================================

class _Tab7MultiWindow extends StatelessWidget {
  const _Tab7MultiWindow();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Multi-Window Architecture', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'macOS document-based apps create one NSWindow per document. '
            'Flutter\'s multi-view API (FlutterView) lets a single Dart '
            'isolate render into multiple NSWindow instances simultaneously.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),
          // Window count selector
          Text('Simulate Window Count', style: tt.titleMedium),
          const SizedBox(height: 12),
          ValueListenableBuilder<int>(
            valueListenable: _multiWindowCount,
            builder: (_, int count, Widget? child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SegmentedButton<int>(
                  segments: const <ButtonSegment<int>>[
                    ButtonSegment<int>(value: 1, label: Text('1 Window')),
                    ButtonSegment<int>(value: 2, label: Text('2 Windows')),
                    ButtonSegment<int>(value: 3, label: Text('3 Windows')),
                    ButtonSegment<int>(value: 4, label: Text('4 Windows')),
                  ],
                  selected: <int>{count},
                  onSelectionChanged: (Set<int> s) =>
                      _multiWindowCount.value = s.first,
                ),
                const SizedBox(height: 16),
                _MultiWindowGrid(count: count, cs: cs),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Document-Based App Pattern', style: tt.titleMedium),
          const SizedBox(height: 12),
          _DocumentPatternCard(cs: cs),
          const SizedBox(height: 24),
          Text('Multi-Window Channel Architecture', style: tt.titleMedium),
          const SizedBox(height: 12),
          _CodeSnippet(
            code: '''
// Each window gets its own controller instance keyed by viewId
final controllers = <int, RegularWindowControllerMacOS>{};

void onNewFlutterView(int viewId) {
  final controller = RegularWindowControllerMacOS(viewId: viewId);
  controllers[viewId] = controller;
  controller.init().then((_) {
    controller.setTitle('Document \${controllers.length}');
  });
}

void closeWindow(int viewId) {
  controllers[viewId]?.close();
  controllers.remove(viewId);
}

// Listen for system-initiated close (red traffic light)
controller.onWindowClose.listen((_) {
  closeWindow(controller.viewId);
});''',
          ),
          const SizedBox(height: 24),
          Text('FlutterView Registration Flow', style: tt.titleMedium),
          const SizedBox(height: 12),
          _FlutterViewFlowCard(cs: cs, tt: tt),
        ],
      ),
    );
  }
}

class _MultiWindowGrid extends StatelessWidget {
  const _MultiWindowGrid({required this.count, required this.cs});
  final int count;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List<Widget>.generate(
        count,
        (int i) => Container(
          width: 160,
          height: 100,
          decoration: BoxDecoration(
            color: [
              cs.primaryContainer,
              cs.secondaryContainer,
              cs.tertiaryContainer,
              cs.errorContainer,
            ][i % 4],
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(20),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: _macosRed,
                            shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: _macosYellow,
                            shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: _macosGreen,
                            shape: BoxShape.circle)),
                    const Spacer(),
                    Text('Doc ${i + 1}',
                        style: const TextStyle(fontSize: 9)),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'viewId: $i\nNSWindow #${i + 1}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentPatternCard extends StatelessWidget {
  const _DocumentPatternCard({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Card(
      color: cs.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('NSDocumentController pattern', style: tt.titleSmall),
            const SizedBox(height: 10),
            const _BulletPoint(
              'NSDocument subclass manages a single document. '
              'NSDocumentController creates/finds documents.',
            ),
            const _BulletPoint(
              'Each NSDocument owns a window controller (NSWindowController). '
              'RegularWindowControllerMacOS wraps the Dart side of this.',
            ),
            const _BulletPoint(
              'File → New creates a new NSDocument, which triggers '
              'a new FlutterViewController and window.',
            ),
            const _BulletPoint(
              'Window → Merge All Windows collapses documents into '
              'tabs inside a single NSWindow.',
            ),
          ],
        ),
      ),
    );
  }
}

class _FlutterViewFlowCard extends StatelessWidget {
  const _FlutterViewFlowCard({required this.cs, required this.tt});
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    const List<String> steps = <String>[
      '1. User selects File → New (or OS creates window)',
      '2. AppDelegate.application(_:openURLs:) called',
      '3. New FlutterEngine spawned (shared or separate isolate)',
      '4. FlutterViewController created with engine',
      '5. NSWindow created and FlutterViewController.view added',
      '6. Flutter engine calls PlatformDispatcher.onViewCreated',
      '7. Dart side creates RegularWindowControllerMacOS(viewId: id)',
      '8. Window is shown: NSWindow.makeKeyAndOrderFront()',
    ];
    return Card(
      color: cs.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: steps
              .map(
                (String s) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(s, style: tt.bodySmall),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 8 — Pitfalls
// ===========================================================================

class _Tab8Pitfalls extends StatelessWidget {
  const _Tab8Pitfalls();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Common Pitfalls & API Cheat Sheet', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Working with RegularWindowControllerMacOS involves bridging '
            'two very different runtime environments. These pitfalls are '
            'common sources of bugs.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),
          // Pitfalls
          ..._pitfalls.map(
            (_PitfallEntry p) => _PitfallCard(entry: p, cs: cs),
          ),
          const SizedBox(height: 24),
          Text('API Cheat Sheet', style: tt.titleLarge),
          const SizedBox(height: 12),
          _ApiCheatSheet(),
          const SizedBox(height: 24),
          Text('Platform Guard Pattern', style: tt.titleMedium),
          const SizedBox(height: 12),
          _CodeSnippet(
            code: '''
import 'dart:io' show Platform;

Future<void> configureWindow() async {
  if (!Platform.isMacOS) return; // guard

  final controller = RegularWindowControllerMacOS();
  await controller.init();

  // Safe to call macOS-only APIs here
  await controller.setTitlebarStyle(TitlebarStyle.hiddenInset);
  await controller.setBackgroundColor(Colors.transparent);
}''',
          ),
          const SizedBox(height: 24),
          Text('Memory Management Rules', style: tt.titleMedium),
          const SizedBox(height: 12),
          Card(
            color: cs.errorContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.warning_amber,
                          color: cs.onErrorContainer),
                      const SizedBox(width: 8),
                      Text('Memory Safety Rules',
                          style: tt.titleSmall?.copyWith(
                              color: cs.onErrorContainer)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _ErrorBullet(
                    cs: cs,
                    text: 'Never hold a strong Dart reference to the '
                        'controller after NSWindowWillCloseNotification '
                        '— the underlying NSWindow is deallocated.',
                  ),
                  _ErrorBullet(
                    cs: cs,
                    text: 'Always call controller.dispose() in '
                        'WidgetsBindingObserver.didChangeAppLifecycleState '
                        'when state == AppLifecycleState.detached.',
                  ),
                  _ErrorBullet(
                    cs: cs,
                    text: 'Avoid caching the NSWindow pointer across '
                        'async gaps — the Autorelease pool may have '
                        'released it before your callback fires.',
                  ),
                  _ErrorBullet(
                    cs: cs,
                    text: 'If using shared FlutterEngine across windows, '
                        'ensure the engine outlives all its '
                        'FlutterViewControllers.',
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

const List<_PitfallEntry> _pitfalls = <_PitfallEntry>[
  _PitfallEntry(
    severity: 'Critical',
    title: 'macOS-only API called on other platforms',
    description:
        'RegularWindowControllerMacOS methods will throw PlatformException '
        'or return null on Linux/Windows/iOS. Always guard with '
        'Platform.isMacOS before calling any controller methods.',
    fix: 'Wrap all calls in if (Platform.isMacOS) { … } or abstract '
        'behind a platform-agnostic interface.',
  ),
  _PitfallEntry(
    severity: 'Critical',
    title: 'Calling controller before init()',
    description:
        'The platform channel is not registered until init() completes. '
        'Calling setTitle(), setFrame(), etc. before await controller.init() '
        'results in MissingPluginException.',
    fix: 'Always await controller.init() in initState() or app start '
        'before using any controller methods.',
  ),
  _PitfallEntry(
    severity: 'High',
    title: 'NotificationCenter leak',
    description:
        'Every addObserver call to NSNotificationCenter requires a '
        'matching removeObserver. Forgetting this causes callbacks to fire '
        'on a deallocated observer, triggering EXC_BAD_ACCESS.',
    fix: 'The controller\'s dispose() method must call removeObserver '
        'for all registered notifications. Call controller.dispose() '
        'in the Dart widget\'s dispose() lifecycle method.',
  ),
  _PitfallEntry(
    severity: 'High',
    title: 'Frame coordinates in flipped coordinate systems',
    description:
        'AppKit uses a lower-left origin coordinate system. Flutter and '
        'CoreGraphics use upper-left. NSWindow.setFrame() expects AppKit '
        'coordinates. Off-by-screen-height bugs are common.',
    fix: 'Use controller.getScreenFrame() to obtain the screen bounds '
        'and flip Y: adjustedY = screenHeight - dartY - windowHeight.',
  ),
  _PitfallEntry(
    severity: 'Medium',
    title: 'setFrame() called during fullscreen transition',
    description:
        'Calling setFrame() while the window is animating into or out of '
        'fullscreen causes AppKit to ignore or corrupt the frame, '
        'occasionally leaving the window in an unrecoverable state.',
    fix: 'Listen to onFullscreenTransitionComplete before calling '
        'setFrame(). Use controller.isInFullscreenTransition to guard.',
  ),
  _PitfallEntry(
    severity: 'Medium',
    title: 'Sandboxed app NSWindowLevel restrictions',
    description:
        'Mac App Store apps cannot set NSWindowLevel above '
        'NSNormalWindowLevel without the com.apple.security.temporary-exception.mach-lookup '
        'entitlement, which Apple rarely grants.',
    fix: 'Design your UI to work at normal window level. Use '
        'NSPanel or NSPopover for floating overlay patterns instead.',
  ),
  _PitfallEntry(
    severity: 'Low',
    title: 'Dark mode appearance racing with system preference',
    description:
        'Setting NSAppearance before the window is visible may be '
        'overridden when the window appears. The system posts '
        'NSApplicationDidChangeOcclusionStateNotification which can '
        'reset appearance.',
    fix: 'Set appearance in applicationDidFinishLaunching or in '
        'response to NSAppearanceCustomizationProtocol callbacks.',
  ),
];

class _PitfallEntry {
  const _PitfallEntry({
    required this.severity,
    required this.title,
    required this.description,
    required this.fix,
  });
  final String severity;
  final String title;
  final String description;
  final String fix;
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({required this.entry, required this.cs});
  final _PitfallEntry entry;
  final ColorScheme cs;

  Color get _severityColor {
    switch (entry.severity) {
      case 'Critical':
        return cs.errorContainer;
      case 'High':
        return cs.error.withAlpha(40);
      case 'Medium':
        return cs.tertiaryContainer;
      default:
        return cs.surfaceContainerHighest;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Card(
      color: _severityColor,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _SeverityBadge(severity: entry.severity, cs: cs),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(entry.title,
                      style: tt.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(entry.description, style: tt.bodySmall),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.lightbulb_outline,
                    size: 14, color: cs.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    entry.fix,
                    style: tt.bodySmall
                        ?.copyWith(color: cs.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SeverityBadge extends StatelessWidget {
  const _SeverityBadge({required this.severity, required this.cs});
  final String severity;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final Color bg = severity == 'Critical'
        ? cs.error
        : severity == 'High'
            ? cs.error.withAlpha(200)
            : severity == 'Medium'
                ? cs.tertiary
                : cs.secondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        severity,
        style: TextStyle(
          color: cs.surface,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ApiCheatSheet extends StatelessWidget {
  static const List<List<String>> _rows = <List<String>>[
    <String>['init()', 'Future<void>', 'Register platform channel; must be awaited first'],
    <String>['dispose()', 'void', 'Remove all notification observers; release channel'],
    <String>['getTitle()', 'Future<String>', 'Read NSWindow.title'],
    <String>['setTitle(String)', 'Future<void>', 'Set NSWindow.title'],
    <String>['getFrame()', 'Future<Rect>', 'Read NSWindow.frame (flipped to Flutter coords)'],
    <String>['setFrame(Rect, {bool animate})', 'Future<void>', 'Set NSWindow.frame with optional animation'],
    <String>['setMinimumSize(Size)', 'Future<void>', 'Set NSWindow.minSize'],
    <String>['setMaximumSize(Size)', 'Future<void>', 'Set NSWindow.maxSize'],
    <String>['setFullScreen(bool)', 'Future<void>', 'Call toggleFullScreen: or exit fullscreen'],
    <String>['isFullScreen()', 'Future<bool>', 'Check NSWindowStyleMaskFullScreen bit'],
    <String>['setTitlebarStyle(TitlebarStyle)', 'Future<void>', 'Set titlebarAppearsTransparent + styleMask'],
    <String>['setBackgroundColor(Color)', 'Future<void>', 'Set NSWindow.backgroundColor'],
    <String>['setMovable(bool)', 'Future<void>', 'Set NSWindow.isMovable'],
    <String>['setMovableByWindowBackground(bool)', 'Future<void>', 'Set isMovableByWindowBackground'],
    <String>['setAlphaValue(double)', 'Future<void>', 'Set NSWindow.alphaValue (window opacity)'],
    <String>['setLevel(WindowLevel)', 'Future<void>', 'Set NSWindow.level'],
    <String>['setCollectionBehavior(int)', 'Future<void>', 'Set NSWindowCollectionBehavior bitmask'],
    <String>['center()', 'Future<void>', 'Call NSWindow.center()'],
    <String>['close()', 'Future<void>', 'Call [NSWindow close]'],
    <String>['miniaturize()', 'Future<void>', 'Call [NSWindow miniaturize:]'],
    <String>['deminiaturize()', 'Future<void>', 'Call [NSWindow deminiaturize:]'],
    <String>['zoom()', 'Future<void>', 'Call [NSWindow zoom:]'],
    <String>['onWindowClose', 'Stream<void>', 'NSWindowWillCloseNotification stream'],
    <String>['onFrameChanged', 'Stream<Rect>', 'NSWindowDidResizeNotification + frame'],
    <String>['onFullscreenChanged', 'Stream<bool>', 'Enter/exit fullscreen notification stream'],
    <String>['onFocusChanged', 'Stream<bool>', 'BecomeKey / ResignKey notification stream'],
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(3),
      },
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: cs.primaryContainer),
          children: <Widget>[
            _tableHeader('Method / Property'),
            _tableHeader('Return Type'),
            _tableHeader('Description'),
          ],
        ),
        ..._rows.map(
          (List<String> r) => TableRow(
            children: <Widget>[
              _tableData(r[0], mono: true),
              _tableData(r[1], mono: true),
              _tableData(r[2]),
            ],
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// Shared helper widgets
// ===========================================================================

class _ConceptItem {
  const _ConceptItem({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;
}

class _ConceptGrid extends StatelessWidget {
  const _ConceptGrid({required this.items});
  final List<_ConceptItem> items;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items
          .map(
            (_ConceptItem item) => SizedBox(
              width: 280,
              child: Card(
                color: cs.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(item.icon, color: cs.primary, size: 22),
                      const SizedBox(height: 6),
                      Text(item.title,
                          style: tt.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(item.body, style: tt.bodySmall),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _OptionItem {
  const _OptionItem({
    required this.title,
    required this.subtitle,
    required this.code,
  });
  final String title;
  final String subtitle;
  final String code;
}

class _OptionsGrid extends StatelessWidget {
  const _OptionsGrid({required this.items});
  final List<_OptionItem> items;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items
          .map(
            (_OptionItem item) => SizedBox(
              width: 280,
              child: Card(
                color: cs.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.title,
                          style: tt.titleSmall
                              ?.copyWith(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(item.subtitle, style: tt.bodySmall),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: cs.surface,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item.code,
                          style: const TextStyle(
                              fontFamily: 'monospace', fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.year, required this.event});
  final String year;
  final String event;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 48,
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              year,
              style: TextStyle(
                  color: cs.onPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(event, style: tt.bodySmall)),
        ],
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  const _CodeSnippet({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
        ),
      ),
    );
  }
}

class _StateRow extends StatelessWidget {
  const _StateRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(label,
                style: tt.bodySmall
                    ?.copyWith(fontFamily: 'monospace')),
          ),
          Text(value,
              style: tt.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('• ', style: TextStyle(fontSize: 14)),
          Expanded(
              child: Text(text,
                  style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }
}

class _ErrorBullet extends StatelessWidget {
  const _ErrorBullet({required this.cs, required this.text});
  final ColorScheme cs;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.error_outline, size: 14, color: cs.onErrorContainer),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: cs.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _tableHeader(String text) => Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );

Widget _tableData(String text, {bool mono = false}) => Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontFamily: mono ? 'monospace' : null,
        ),
      ),
    );

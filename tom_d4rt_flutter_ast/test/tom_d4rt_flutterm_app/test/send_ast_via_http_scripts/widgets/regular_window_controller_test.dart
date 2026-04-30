import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — slate-blue + amber Material 3 seeds, desktop-inspired tone.
// ---------------------------------------------------------------------------
const Color _kSeed = Color(0xFF2C5F8A);
const Color _kInk = Color(0xFF0D1F2D);
const Color _kSurface = Color(0xFFF0F4F8);
const Color _kBorder = Color(0xFFB0C4D8);
const Color _kAccent = Color(0xFFD97B2F);
const Color _kGreen = Color(0xFF2E7A4A);
const Color _kGreenSoft = Color(0xFFD0EDDA);
const Color _kRed = Color(0xFFB03030);
const Color _kYellow = Color(0xFFB28A00);
const Color _kPurple = Color(0xFF6C4FA8);
const Color _kChrome = Color(0xFF3C3C3C);
const Color _kChromeDark = Color(0xFF1E1E1E);
const Color _kChromeLight = Color(0xFFD4D4D4);

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — drive the simulated window state reactively
// without any StatefulWidget (STATELESS only constraint).
// ---------------------------------------------------------------------------

/// Simulated active platform: 'macOS' | 'Windows' | 'Linux'
final ValueNotifier<String> _platform = ValueNotifier<String>('macOS');

/// Simulated window title
final ValueNotifier<String> _windowTitle =
    ValueNotifier<String>('My Desktop App');

/// Simulated window size
final ValueNotifier<Size> _windowSize = ValueNotifier<Size>(const Size(900, 600));

/// Simulated window position (top-left on the virtual screen)
final ValueNotifier<Offset> _windowPosition =
    ValueNotifier<Offset>(const Offset(100, 80));

/// Simulated window state: 'normal' | 'minimized' | 'maximized' | 'fullscreen'
final ValueNotifier<String> _windowState = ValueNotifier<String>('normal');

/// Simulated focus state
final ValueNotifier<bool> _windowFocused = ValueNotifier<bool>(true);

/// Simulated resize constraints
final ValueNotifier<double> _minW = ValueNotifier<double>(400);
final ValueNotifier<double> _maxW = ValueNotifier<double>(1600);
final ValueNotifier<bool> _resizable = ValueNotifier<bool>(true);

/// Operation log (bounded to last 12 entries)
final ValueNotifier<List<String>> _opLog =
    ValueNotifier<List<String>>(<String>[]);

void _log(String msg) {
  final List<String> next = List<String>.from(_opLog.value)..add(msg);
  if (next.length > 12) next.removeRange(0, next.length - 12);
  _opLog.value = next;
}

// ---------------------------------------------------------------------------
// Entry point — d4rt harness calls build(context) and mounts the result.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _RegularWindowControllerDeepDemo();
}

// ===========================================================================
// Root widget — MaterialApp + M3 theme + 9-tab scaffold
// ===========================================================================
class _RegularWindowControllerDeepDemo extends StatelessWidget {
  const _RegularWindowControllerDeepDemo();

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
        bodyMedium: TextStyle(color: _kInk, height: 1.4),
        titleLarge: TextStyle(
          color: _kInk,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          color: _kInk,
          fontWeight: FontWeight.w600,
          fontSize: 16,
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
// Shell scaffold — AppBar banner + 9 tabs
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
          toolbarHeight: 96,
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
            _PlatformMatrixTab(),
            _SimulatedWindowTab(),
            _WindowOperationsTab(),
            _RegularWindowWidgetTab(),
            _SizeConstraintsTab(),
            _WindowListenerTab(),
            _MultiWindowTab(),
            _PitfallsAndApiTab(),
          ],
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _kSeed,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.window_outlined, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'RegularWindowController',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                'Cross-platform desktop window management — deep visual demo',
                style: TextStyle(fontSize: 12, color: Color(0xFFB0C8E0)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelColor: Colors.white,
      unselectedLabelColor: Color(0xFF8AABCC),
      indicatorColor: Color(0xFFD97B2F),
      indicatorWeight: 3,
      labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      tabs: <Tab>[
        Tab(icon: Icon(Icons.info_outline, size: 16), text: 'Overview'),
        Tab(icon: Icon(Icons.table_chart_outlined, size: 16), text: 'Platform Matrix'),
        Tab(icon: Icon(Icons.desktop_windows_outlined, size: 16), text: 'Sim Window'),
        Tab(icon: Icon(Icons.settings_outlined, size: 16), text: 'Operations'),
        Tab(icon: Icon(Icons.widgets_outlined, size: 16), text: 'RegularWindow'),
        Tab(icon: Icon(Icons.aspect_ratio_outlined, size: 16), text: 'Size Constraints'),
        Tab(icon: Icon(Icons.notifications_outlined, size: 16), text: 'WindowListener'),
        Tab(icon: Icon(Icons.layers_outlined, size: 16), text: 'Multi-Window'),
        Tab(icon: Icon(Icons.warning_amber_outlined, size: 16), text: 'Pitfalls & API'),
      ],
    );
  }
}

// ===========================================================================
// Helpers
// ===========================================================================
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: <Widget>[
          Icon(icon, color: _kSeed, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.label, {this.color = _kSeed});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(24),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kChromeDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFFD4D4D4),
          height: 1.6,
        ),
      ),
    );
  }
}

class _YesNo extends StatelessWidget {
  const _YesNo(this.value, {this.partial = false});

  final bool value;
  final bool partial;

  @override
  Widget build(BuildContext context) {
    if (partial) {
      return const _Chip('Partial', color: _kYellow);
    }
    return _Chip(
      value ? 'Yes' : 'No',
      color: value ? _kGreen : _kRed,
    );
  }
}

// ===========================================================================
// TAB 1 — Hero Banner: Overview of RegularWindowController
// ===========================================================================
class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        // Hero banner card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFF1A3A5C), Color(0xFF2C5F8A)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.window_outlined,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'RegularWindowController',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'flutter/src/widgets/window.dart',
                          style: TextStyle(
                            color: Color(0xFFB0CCE8),
                            fontSize: 13,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'RegularWindowController is Flutter\'s cross-platform API for '
                'programmatically managing desktop application windows. It provides '
                'a unified interface over macOS NSWindow, Windows HWND, and Linux GDK '
                'window handles — abstracting platform differences into a single Dart API.',
                style: TextStyle(
                  color: Color(0xFFD0E4F4),
                  fontSize: 14,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 16),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _Chip('Desktop Only', color: _kAccent),
                  _Chip('Async API', color: _kPurple),
                  _Chip('M3 Compatible', color: _kGreen),
                  _Chip('Multi-Window', color: _kSeed),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // What it does
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.lightbulb_outline, 'What It Does'),
              const Text(
                'RegularWindowController exposes imperative window operations: '
                'setting the title, resizing, repositioning, minimizing, maximizing, '
                'restoring, toggling full-screen, and querying current state. It is '
                'obtained from the RegularWindow widget context or constructed directly '
                'for a specific FlutterView.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _CodeBlock(
                'import \'package:flutter/widgets.dart\';\n\n'
                '// Obtain from context\n'
                'final RegularWindowController ctrl =\n'
                '    RegularWindowController.of(context)!;\n\n'
                '// Or construct for a specific view\n'
                'final RegularWindowController ctrl =\n'
                '    RegularWindowController(view: flutterView);\n\n'
                '// Perform window operations\n'
                'await ctrl.setTitle(\'New Title\');\n'
                'await ctrl.setSize(const Size(1280, 720));\n'
                'await ctrl.maximize();\n'
                'await ctrl.setFullScreen(true);',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Architecture position
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.account_tree_outlined, 'Architecture Position'),
              const Text(
                'The controller sits between the Flutter engine\'s platform channel '
                'layer and the widget tree. Window operations are dispatched as platform '
                'messages and resolved asynchronously. State changes propagate back via '
                'the WindowListener callback mechanism.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              // Architecture diagram (drawn with containers)
              Row(
                children: <Widget>[
                  _ArchBox('Widget Tree\n(RegularWindow)', _kSeed),
                  const _Arrow(),
                  _ArchBox('Regular\nWindowController', _kAccent),
                  const _Arrow(),
                  _ArchBox('Platform\nChannels', _kPurple),
                  const _Arrow(),
                  _ArchBox('OS Window\n(NSWindow/HWND/GDK)', _kChrome),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Key properties
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.list_alt_outlined, 'Key Properties'),
              _PropRow('view', 'FlutterView',
                  'The FlutterView this controller manages.'),
              _PropRow('title', 'Future<String>',
                  'Current window title (async getter).'),
              _PropRow('size', 'Future<Size>',
                  'Current window frame size in logical pixels.'),
              _PropRow('position', 'Future<Offset>',
                  'Current window top-left position on screen.'),
              _PropRow('isFullScreen', 'Future<bool>',
                  'Whether the window is currently fullscreen.'),
              _PropRow('isMaximized', 'Future<bool>',
                  'Whether the window is maximized.'),
              _PropRow('isMinimized', 'Future<bool>',
                  'Whether the window is minimized.'),
              _PropRow('isResizable', 'Future<bool>',
                  'Whether the user can resize the window.'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ArchBox extends StatelessWidget {
  const _ArchBox(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.arrow_forward, size: 16, color: _kBorder),
    );
  }
}

class _PropRow extends StatelessWidget {
  const _PropRow(this.name, this.type, this.desc);

  final String name;
  final String type;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _kSeed,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: _kAccent,
              ),
            ),
          ),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(fontSize: 12, color: _kInk),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 2 — Platform Matrix
// ===========================================================================
class _PlatformMatrixTab extends StatelessWidget {
  const _PlatformMatrixTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.table_chart_outlined, 'Platform Support Matrix'),
              const Text(
                'RegularWindowController targets the three desktop platforms. '
                'Mobile platforms (iOS, Android) are not supported — the API will '
                'return null from RegularWindowController.of(context) on those targets.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _PlatformTable(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.compare_arrows_outlined, 'Platform Notes'),
              _PlatformNote(
                'macOS',
                Icons.laptop_mac,
                _kSeed,
                'Full support via NSWindow. setFullScreen uses native Spaces '
                    'integration. Position coordinates are from top-left of primary '
                    'screen in logical pixels. Minimize triggers the Dock animation.',
              ),
              _PlatformNote(
                'Windows',
                Icons.desktop_windows_outlined,
                _kPurple,
                'Full support via Win32 HWND SendMessage. setFullScreen uses '
                    'a borderless-maximize approach (WS_POPUP + ShowWindow SW_MAXIMIZE). '
                    'DPI awareness applies to size/position values. Windows 11 snap '
                    'layouts may override maximize behavior.',
              ),
              _PlatformNote(
                'Linux',
                Icons.computer_outlined,
                _kAccent,
                'Partial support via GDK/GTK. setFullScreen and maximize work '
                    'on most compositors. setPosition may be ignored by tiling '
                    'window managers (i3, Sway). Some operations are fire-and-forget '
                    'with no reliable completion callback.',
              ),
              _PlatformNote(
                'iOS',
                Icons.phone_iphone_outlined,
                _kRed,
                'Not supported. RegularWindowController.of(context) returns null. '
                    'iOS uses a single full-screen UIWindow model; Flutter on iOS '
                    'does not expose multi-window window management APIs.',
              ),
              _PlatformNote(
                'Android',
                Icons.phone_android_outlined,
                _kRed,
                'Not supported. Android\'s activity model does not provide the '
                    'same window frame control. Use platform channels directly if '
                    'you need to interact with the Activity window on Android.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.code_outlined, 'Platform Guard Pattern'),
              const Text(
                'Always guard usage with a null-check since the controller is only '
                'available on desktop.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 12),
              _CodeBlock(
                'final RegularWindowController? ctrl =\n'
                '    RegularWindowController.of(context);\n\n'
                'if (ctrl == null) {\n'
                '  // Running on iOS / Android — skip window ops\n'
                '  return;\n'
                '}\n\n'
                '// Safe on desktop\n'
                'await ctrl.setTitle(\'Ready\');',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlatformTable extends StatelessWidget {
  _PlatformTable();

  final List<_MatrixRow> _rows = <_MatrixRow>[
    _MatrixRow('setTitle',     true,  true,  true,  false, false),
    _MatrixRow('setSize',      true,  true,  true,  false, false),
    _MatrixRow('setPosition',  true,  true,  null,  false, false),
    _MatrixRow('minimize',     true,  true,  true,  false, false),
    _MatrixRow('maximize',     true,  true,  null,  false, false),
    _MatrixRow('restore',      true,  true,  true,  false, false),
    _MatrixRow('setFullScreen',true,  true,  null,  false, false),
    _MatrixRow('setMinSize',   true,  true,  null,  false, false),
    _MatrixRow('setMaxSize',   true,  true,  null,  false, false),
    _MatrixRow('setResizable', true,  true,  null,  false, false),
    _MatrixRow('isMaximized',  true,  true,  true,  false, false),
    _MatrixRow('isFullScreen', true,  true,  true,  false, false),
    _MatrixRow('isMinimized',  true,  true,  true,  false, false),
    _MatrixRow('WindowListener',true, true,  null,  false, false),
  ];

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      border: TableBorder.all(color: _kBorder, borderRadius: BorderRadius.circular(8)),
      children: <TableRow>[
        _headerRow(),
        ..._rows.map(_dataRow),
      ],
    );
  }

  TableRow _headerRow() {
    return TableRow(
      decoration: const BoxDecoration(color: _kChromeDark),
      children: <Widget>[
        _th('API'),
        _th('macOS'),
        _th('Windows'),
        _th('Linux'),
        _th('iOS'),
        _th('Android'),
      ],
    );
  }

  Widget _th(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  TableRow _dataRow(_MatrixRow row) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            row.name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _kSeed,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _td(row.macos),
        _td(row.windows),
        _td(row.linux),
        _td(row.ios),
        _td(row.android),
      ],
    );
  }

  Widget _td(bool? val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: _YesNo(val ?? false, partial: val == null),
    );
  }
}

class _MatrixRow {
  const _MatrixRow(
      this.name, this.macos, this.windows, this.linux, this.ios, this.android);

  final String name;
  final bool macos;
  final bool windows;
  final bool? linux; // null = partial
  final bool ios;
  final bool android;
}

class _PlatformNote extends StatelessWidget {
  const _PlatformNote(this.platform, this.icon, this.color, this.note);

  final String platform;
  final IconData icon;
  final Color color;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  platform,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(note, style: const TextStyle(fontSize: 13, height: 1.45)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 3 — Simulated Desktop Window
// ===========================================================================
class _SimulatedWindowTab extends StatelessWidget {
  const _SimulatedWindowTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.desktop_windows_outlined, 'Platform Selector'),
              const Text(
                'Switch the simulated platform to see how window chrome differs '
                'across macOS, Windows, and Linux.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<String>(
                valueListenable: _platform,
                builder: (BuildContext ctx, String current, _) {
                  return Wrap(
                    spacing: 10,
                    children: <Widget>[
                      for (final String p in <String>['macOS', 'Windows', 'Linux'])
                        ChoiceChip(
                          label: Text(p),
                          selected: current == p,
                          selectedColor: _kSeed.withAlpha(40),
                          onSelected: (_) {
                            _platform.value = p;
                            _log('Platform switched to $p');
                          },
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Simulated window drawing
        _InfoCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.preview_outlined, 'Window Chrome Preview'),
              const Text(
                'Platform-adaptive title bar drawn entirely in Flutter '
                '(no native code). The chrome style updates when you switch '
                'the platform above.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<String>(
                valueListenable: _platform,
                builder: (BuildContext ctx, String plat, _) {
                  return ValueListenableBuilder<String>(
                    valueListenable: _windowTitle,
                    builder: (BuildContext ctx2, String title, _) {
                      return ValueListenableBuilder<String>(
                        valueListenable: _windowState,
                        builder: (BuildContext ctx3, String state, _) {
                          return _SimulatedWindow(
                            platform: plat,
                            title: title,
                            state: state,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Window state panel
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.dashboard_outlined, 'Live Window State'),
              ValueListenableBuilder<String>(
                valueListenable: _windowTitle,
                builder: (BuildContext c0, String title, _) => _StateRow('title', '"$title"'),
              ),
              ValueListenableBuilder<Size>(
                valueListenable: _windowSize,
                builder: (BuildContext c1, Size s, _) =>
                    _StateRow('size', '${s.width.toInt()} × ${s.height.toInt()} px'),
              ),
              ValueListenableBuilder<Offset>(
                valueListenable: _windowPosition,
                builder: (BuildContext c2, Offset p, _) =>
                    _StateRow('position', '(${p.dx.toInt()}, ${p.dy.toInt()})'),
              ),
              ValueListenableBuilder<String>(
                valueListenable: _windowState,
                builder: (BuildContext c3, String st, _) => _StateRow('state', st),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _windowFocused,
                builder: (BuildContext c4, bool f, _) =>
                    _StateRow('focused', f ? 'true' : 'false'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SimulatedWindow extends StatelessWidget {
  const _SimulatedWindow({
    required this.platform,
    required this.title,
    required this.state,
  });

  final String platform;
  final String title;
  final String state;

  @override
  Widget build(BuildContext context) {
    final bool isMac = platform == 'macOS';
    final bool isWin = platform == 'Windows';
    final bool isLin = platform == 'Linux';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMac ? 12 : 4),
        border: Border.all(color: _kBorder, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Title bar
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: isMac
                  ? const Color(0xFFECECEC)
                  : isWin
                      ? const Color(0xFF202020)
                      : const Color(0xFF3C3C3C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isMac ? 12 : 4),
                topRight: Radius.circular(isMac ? 12 : 4),
              ),
            ),
            child: Row(
              children: <Widget>[
                if (isMac) ...<Widget>[
                  const SizedBox(width: 12),
                  _MacButton(const Color(0xFFFF5F57)),
                  const SizedBox(width: 6),
                  _MacButton(const Color(0xFFFFBD2E)),
                  const SizedBox(width: 6),
                  _MacButton(const Color(0xFF28C840)),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    state == 'minimized' ? '[$title — minimized]' : title,
                    textAlign: isMac ? TextAlign.center : TextAlign.left,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isMac ? _kInk : Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isWin) ...<Widget>[
                  const SizedBox(width: 8),
                  _Win32Button(Icons.minimize, const Color(0xFF505050)),
                  _Win32Button(
                    state == 'maximized'
                        ? Icons.crop_square_outlined
                        : Icons.crop_square,
                    const Color(0xFF505050),
                  ),
                  _Win32Button(Icons.close, const Color(0xFFE81123)),
                ],
                if (isLin) ...<Widget>[
                  const SizedBox(width: 8),
                  _LinuxButton(Icons.minimize),
                  _LinuxButton(Icons.crop_square),
                  _LinuxButton(Icons.close),
                ],
                const SizedBox(width: 8),
              ],
            ),
          ),
          // Window body
          Container(
            height: 160,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '[$platform] Window body — state: $state',
                  style: const TextStyle(
                    color: _kBorder,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 12),
                if (state == 'minimized')
                  const _Chip('Window is minimized — body hidden', color: _kYellow)
                else if (state == 'maximized')
                  const _Chip('Window occupies full screen bounds', color: _kGreen)
                else if (state == 'fullscreen')
                  const _Chip('Fullscreen — no chrome visible on real desktop', color: _kPurple)
                else
                  const _Chip('Normal — resizable window bounds', color: _kSeed),
              ],
            ),
          ),
          // Status bar
          Container(
            height: 24,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: const Color(0xFFF5F5F5),
            child: Row(
              children: <Widget>[
                const Icon(Icons.circle, color: _kGreen, size: 8),
                const SizedBox(width: 6),
                ValueListenableBuilder<Offset>(
                  valueListenable: _windowPosition,
                  builder: (BuildContext c5, Offset p, _) => Text(
                    '${p.dx.toInt()},${p.dy.toInt()}  ',
                    style: const TextStyle(fontSize: 10, color: _kBorder),
                  ),
                ),
                ValueListenableBuilder<Size>(
                  valueListenable: _windowSize,
                  builder: (BuildContext c6, Size s, _) => Text(
                    '${s.width.toInt()}×${s.height.toInt()}',
                    style: const TextStyle(fontSize: 10, color: _kBorder),
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

class _MacButton extends StatelessWidget {
  const _MacButton(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 13,
      height: 13,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Win32Button extends StatelessWidget {
  const _Win32Button(this.icon, this.bg);

  final IconData icon;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 38,
      color: bg,
      child: Icon(icon, color: Colors.white, size: 14),
    );
  }
}

class _LinuxButton extends StatelessWidget {
  const _LinuxButton(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: _kChromeLight.withAlpha(120)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, color: _kChromeLight, size: 13),
    );
  }
}

class _StateRow extends StatelessWidget {
  const _StateRow(this.key_, this.value);

  final String key_;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              key_,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _kSeed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _kInk,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 4 — Window Operations
// ===========================================================================
class _WindowOperationsTab extends StatelessWidget {
  const _WindowOperationsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.settings_outlined, 'Window Operations'),
              const Text(
                'Tap the buttons below to simulate window operations. Each '
                'operation updates the live window state panel and appends an '
                'entry to the operation log.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              const _OperationsGrid(),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.terminal_outlined, 'Operation Log'),
              ValueListenableBuilder<List<String>>(
                valueListenable: _opLog,
                builder: (BuildContext c7, List<String> log, _) {
                  if (log.isEmpty) {
                    return const Text(
                      'No operations yet. Tap the buttons above.',
                      style: TextStyle(color: _kBorder, fontSize: 13),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: log
                        .reversed
                        .map(
                          (String entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.chevron_right,
                                    size: 14, color: _kGreen),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    entry,
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 12,
                                      color: _kInk,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.code_outlined, 'Code: setTitle'),
              _CodeBlock(
                'final RegularWindowController ctrl =\n'
                '    RegularWindowController.of(context)!;\n\n'
                '// setTitle — changes the OS title bar text\n'
                'await ctrl.setTitle(\'My App — Document Saved\');\n\n'
                '// Retrieve current title\n'
                'final String current = await ctrl.title;',
              ),
              const SizedBox(height: 12),
              const _SectionHeader(Icons.code_outlined, 'Code: setSize / setPosition'),
              _CodeBlock(
                '// Resize to 1280 × 720 logical pixels\n'
                'await ctrl.setSize(const Size(1280, 720));\n\n'
                '// Move to (200, 150) from top-left of primary screen\n'
                'await ctrl.setPosition(const Offset(200, 150));\n\n'
                '// Center on screen (requires screen size query)\n'
                'final Size screen = View.of(context).display.size /\n'
                '    View.of(context).devicePixelRatio;\n'
                'final Size win = await ctrl.size;\n'
                'await ctrl.setPosition(Offset(\n'
                '  (screen.width - win.width) / 2,\n'
                '  (screen.height - win.height) / 2,\n'
                '));',
              ),
              const SizedBox(height: 12),
              const _SectionHeader(Icons.code_outlined, 'Code: State transitions'),
              _CodeBlock(
                '// Minimize to taskbar / Dock\n'
                'await ctrl.minimize();\n\n'
                '// Maximize to fill screen (not fullscreen)\n'
                'await ctrl.maximize();\n\n'
                '// Restore to last normal size and position\n'
                'await ctrl.restore();\n\n'
                '// Toggle true fullscreen (hides menu bar on macOS)\n'
                'await ctrl.setFullScreen(true);\n'
                'await ctrl.setFullScreen(false);',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OperationsGrid extends StatelessWidget {
  const _OperationsGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Title row
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Window Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onSubmitted: (String val) {
                  if (val.isNotEmpty) {
                    _windowTitle.value = val;
                    _log('setTitle("$val") called');
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () {
                _windowTitle.value = 'Untitled Window';
                _log('setTitle("Untitled Window") called');
              },
              icon: const Icon(Icons.title, size: 16),
              label: const Text('Reset Title'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _OpButton(
              label: 'setSize 1280×720',
              icon: Icons.aspect_ratio_outlined,
              color: _kSeed,
              onTap: () {
                _windowSize.value = const Size(1280, 720);
                _windowState.value = 'normal';
                _log('setSize(1280, 720) called');
              },
            ),
            _OpButton(
              label: 'setSize 800×600',
              icon: Icons.aspect_ratio_outlined,
              color: _kSeed,
              onTap: () {
                _windowSize.value = const Size(800, 600);
                _windowState.value = 'normal';
                _log('setSize(800, 600) called');
              },
            ),
            _OpButton(
              label: 'setPosition (100, 80)',
              icon: Icons.open_with_outlined,
              color: _kPurple,
              onTap: () {
                _windowPosition.value = const Offset(100, 80);
                _log('setPosition(100, 80) called');
              },
            ),
            _OpButton(
              label: 'setPosition (400, 200)',
              icon: Icons.open_with_outlined,
              color: _kPurple,
              onTap: () {
                _windowPosition.value = const Offset(400, 200);
                _log('setPosition(400, 200) called');
              },
            ),
            _OpButton(
              label: 'minimize()',
              icon: Icons.minimize_outlined,
              color: _kYellow,
              onTap: () {
                _windowState.value = 'minimized';
                _log('minimize() called — window sent to Dock/taskbar');
              },
            ),
            _OpButton(
              label: 'maximize()',
              icon: Icons.crop_square_outlined,
              color: _kGreen,
              onTap: () {
                _windowState.value = 'maximized';
                _log('maximize() called — window fills screen');
              },
            ),
            _OpButton(
              label: 'restore()',
              icon: Icons.restore_outlined,
              color: _kAccent,
              onTap: () {
                _windowState.value = 'normal';
                _windowSize.value = const Size(900, 600);
                _log('restore() called — window returned to normal state');
              },
            ),
            _OpButton(
              label: 'setFullScreen(true)',
              icon: Icons.fullscreen_outlined,
              color: _kRed,
              onTap: () {
                _windowState.value = 'fullscreen';
                _log('setFullScreen(true) called — enters OS fullscreen');
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _OpButton extends StatelessWidget {
  const _OpButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 15, color: color),
      label: Text(
        label,
        style: TextStyle(fontSize: 12, color: color),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color.withAlpha(100)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// ===========================================================================
// TAB 5 — RegularWindow Widget
// ===========================================================================
class _RegularWindowWidgetTab extends StatelessWidget {
  const _RegularWindowWidgetTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.widgets_outlined, 'RegularWindow Widget'),
              const Text(
                'RegularWindow is the widget counterpart to RegularWindowController. '
                'It wraps a FlutterView and makes the associated controller available '
                'to the subtree via RegularWindowController.of(context). '
                'Multi-window Flutter apps create one RegularWindow per view.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _CodeBlock(
                'class MyApp extends StatelessWidget {\n'
                '  const MyApp({required this.view, super.key});\n'
                '  final FlutterView view;\n\n'
                '  @override\n'
                '  Widget build(BuildContext context) {\n'
                '    return RegularWindow(\n'
                '      view: view,\n'
                '      child: MaterialApp(\n'
                '        home: const MyHomePage(),\n'
                '      ),\n'
                '    );\n'
                '  }\n'
                '}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Widget-to-controller connection diagram
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.account_tree_outlined, 'Widget ↔ Controller Connection'),
              const Text(
                'The diagram below shows how RegularWindow propagates the '
                'controller through the widget tree.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 20),
              _ConnectionDiagram(),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // InheritedWidget scope explanation
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.hub_outlined, 'How RegularWindow.of() Works'),
              const Text(
                'RegularWindow is an InheritedWidget that stores the '
                'RegularWindowController. Calling RegularWindowController.of(context) '
                'walks up the widget tree to find the nearest RegularWindow ancestor '
                'and returns its controller.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _CodeBlock(
                '// Inside any descendant of RegularWindow:\n'
                'class MyPage extends StatelessWidget {\n'
                '  const MyPage({super.key});\n\n'
                '  @override\n'
                '  Widget build(BuildContext context) {\n'
                '    // Returns null on non-desktop platforms\n'
                '    final RegularWindowController? ctrl =\n'
                '        RegularWindowController.of(context);\n\n'
                '    return ElevatedButton(\n'
                '      onPressed: () async {\n'
                '        await ctrl?.setTitle(\'Document Saved\');\n'
                '      },\n'
                '      child: const Text(\'Save\'),\n'
                '    );\n'
                '  }\n'
                '}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // viewOf pattern
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.visibility_outlined, 'View.of vs RegularWindowController.of'),
              _CompareRow(
                'View.of(context)',
                'Returns the FlutterView for layout/display info '
                    '(devicePixelRatio, display, physicalSize). '
                    'Does NOT give window management operations.',
              ),
              const SizedBox(height: 8),
              _CompareRow(
                'RegularWindowController.of(context)',
                'Returns the controller for imperative window '
                    'operations (setTitle, setSize, maximize, etc.). '
                    'Requires a RegularWindow ancestor.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConnectionDiagram extends StatelessWidget {
  _ConnectionDiagram();

  final List<_DiagramNode> _nodes = <_DiagramNode>[
    _DiagramNode('runApp()', 'Entry point for each FlutterView', _kChrome),
    _DiagramNode('RegularWindow', 'Wraps the view; creates & exposes controller', _kSeed),
    _DiagramNode('MaterialApp', 'Theme / router root', _kPurple),
    _DiagramNode('MyHomePage', 'Your content widget tree', _kAccent),
    _DiagramNode('RegularWindowController.of(context)', 'Lookup from any descendant', _kGreen),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < _nodes.length; i++) ...<Widget>[
          _DiagramNodeWidget(_nodes[i]),
          if (i < _nodes.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Icon(Icons.arrow_downward, size: 18, color: _kBorder),
            ),
        ],
      ],
    );
  }
}

class _DiagramNode {
  const _DiagramNode(this.name, this.desc, this.color);

  final String name;
  final String desc;
  final Color color;
}

class _DiagramNodeWidget extends StatelessWidget {
  const _DiagramNodeWidget(this.node);

  final _DiagramNode node;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: node.color.withAlpha(18),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: node.color.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            node.name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: node.color,
            ),
          ),
          Text(
            node.desc,
            style: const TextStyle(fontSize: 12, color: _kInk, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow(this.api, this.desc);

  final String api;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _kSeed.withAlpha(18),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            api,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _kSeed,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(desc, style: const TextStyle(fontSize: 13, height: 1.45)),
        ),
      ],
    );
  }
}

// ===========================================================================
// TAB 6 — Size Constraints
// ===========================================================================
class _SizeConstraintsTab extends StatelessWidget {
  const _SizeConstraintsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.aspect_ratio_outlined, 'Size Constraints API'),
              const Text(
                'RegularWindowController lets you constrain how the user can resize '
                'the window with setMinSize, setMaxSize, and setResizable.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _CodeBlock(
                '// Minimum window size — prevents the user shrinking below this\n'
                'await ctrl.setMinSize(const Size(400, 300));\n\n'
                '// Maximum window size — prevents growing above this\n'
                'await ctrl.setMaxSize(const Size(1600, 1200));\n\n'
                '// Disable resize entirely (fixed-size window)\n'
                'await ctrl.setResizable(false);\n\n'
                '// Re-enable resize\n'
                'await ctrl.setResizable(true);',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Interactive sliders
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.tune_outlined, 'Interactive Size Sliders'),
              ValueListenableBuilder<double>(
                valueListenable: _minW,
                builder: (BuildContext c8, double minW, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text('Min Width: ',
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 13,
                                  color: _kSeed,
                                  fontWeight: FontWeight.w600)),
                          Text('${minW.toInt()} px',
                              style: const TextStyle(
                                  fontFamily: 'monospace', fontSize: 13)),
                        ],
                      ),
                      Slider(
                        value: minW,
                        min: 200,
                        max: 800,
                        divisions: 12,
                        label: '${minW.toInt()} px',
                        activeColor: _kSeed,
                        onChanged: (double v) {
                          _minW.value = v;
                          _log('setMinSize(${v.toInt()}, …) called');
                        },
                      ),
                    ],
                  );
                },
              ),
              ValueListenableBuilder<double>(
                valueListenable: _maxW,
                builder: (BuildContext c9, double maxW, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text('Max Width: ',
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 13,
                                  color: _kAccent,
                                  fontWeight: FontWeight.w600)),
                          Text('${maxW.toInt()} px',
                              style: const TextStyle(
                                  fontFamily: 'monospace', fontSize: 13)),
                        ],
                      ),
                      Slider(
                        value: maxW,
                        min: 800,
                        max: 3000,
                        divisions: 22,
                        label: '${maxW.toInt()} px',
                        activeColor: _kAccent,
                        onChanged: (double v) {
                          _maxW.value = v;
                          _log('setMaxSize(${v.toInt()}, …) called');
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder<bool>(
                valueListenable: _resizable,
                builder: (BuildContext cA, bool r, _) {
                  return Row(
                    children: <Widget>[
                      Switch(
                        value: r,
                        activeThumbColor: _kGreen,
                        onChanged: (bool v) {
                          _resizable.value = v;
                          _log('setResizable($v) called');
                        },
                      ),
                      const SizedBox(width: 10),
                      Text(
                        r ? 'Resizable — user can drag edges' : 'Fixed size — resize disabled',
                        style: TextStyle(
                          fontSize: 13,
                          color: r ? _kGreen : _kRed,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Constraint visualization
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.bar_chart_outlined, 'Constraint Range Visualization'),
              ValueListenableBuilder<double>(
                valueListenable: _minW,
                builder: (BuildContext cB, double minW, _) {
                  return ValueListenableBuilder<double>(
                    valueListenable: _maxW,
                    builder: (BuildContext cC, double maxW, _) {
                      return ValueListenableBuilder<Size>(
                        valueListenable: _windowSize,
                        builder: (BuildContext cD, Size ws, _) {
                          return _ConstraintBar(
                            minW: minW,
                            maxW: maxW,
                            currentW: ws.width,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Platform behavior differences
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.compare_outlined, 'Platform Behavior Differences'),
              const _BulletItem(
                'macOS: setMinSize is enforced by the window server. Resize '
                    'handles disappear visually when setResizable(false) is set.',
              ),
              const _BulletItem(
                'Windows: Min/max constraints are enforced via WM_GETMINMAXINFO. '
                    'setResizable(false) removes the WS_THICKFRAME style.',
              ),
              const _BulletItem(
                'Linux: Depends on the window manager; constraints may be advisory '
                    'only and not always enforced by the compositor.',
              ),
              const _BulletItem(
                'Setting minSize larger than maxSize will throw an assertion error '
                    'in debug mode and produce undefined behavior in release mode.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConstraintBar extends StatelessWidget {
  const _ConstraintBar({
    required this.minW,
    required this.maxW,
    required this.currentW,
  });

  final double minW;
  final double maxW;
  final double currentW;

  @override
  Widget build(BuildContext context) {
    const double totalRange = 3000;
    final double minFrac = minW / totalRange;
    final double maxFrac = maxW / totalRange;
    final double curFrac = (currentW / totalRange).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '0 px                                            3000 px',
          style: TextStyle(fontSize: 10, color: _kBorder),
        ),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints bc) {
            final double totalW = bc.maxWidth;
            return Stack(
              children: <Widget>[
                // Background track
                Container(
                  width: totalW,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: _kBorder),
                  ),
                ),
                // Allowed range
                Positioned(
                  left: totalW * minFrac,
                  child: Container(
                    width: (totalW * (maxFrac - minFrac)).clamp(0, totalW),
                    height: 20,
                    color: _kSeed.withAlpha(40),
                  ),
                ),
                // Current position
                Positioned(
                  left: (totalW * curFrac - 2).clamp(0, totalW - 4),
                  child: Container(
                    width: 4,
                    height: 20,
                    color: _kAccent,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            _Chip('min: ${minW.toInt()} px', color: _kSeed),
            const SizedBox(width: 8),
            _Chip('current: ${currentW.toInt()} px', color: _kAccent),
            const SizedBox(width: 8),
            _Chip('max: ${maxW.toInt()} px', color: _kPurple),
          ],
        ),
      ],
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('• ', style: TextStyle(color: _kSeed, fontSize: 16)),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13, height: 1.45)),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 7 — WindowListener Pattern
// ===========================================================================
class _WindowListenerTab extends StatelessWidget {
  const _WindowListenerTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.notifications_outlined, 'WindowListener Pattern'),
              const Text(
                'To observe window events (focus changes, size changes, state '
                'transitions), mix WindowListener into a State class and add/remove '
                'it on the controller. This is the standard observer pattern for '
                'reactive window event handling.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _CodeBlock(
                'class _MyPageState extends State<MyPage>\n'
                '    with WindowListener {\n\n'
                '  RegularWindowController? _ctrl;\n\n'
                '  @override\n'
                '  void didChangeDependencies() {\n'
                '    super.didChangeDependencies();\n'
                '    final RegularWindowController? next =\n'
                '        RegularWindowController.of(context);\n'
                '    if (next != _ctrl) {\n'
                '      _ctrl?.removeListener(this);\n'
                '      _ctrl = next;\n'
                '      _ctrl?.addListener(this);\n'
                '    }\n'
                '  }\n\n'
                '  @override\n'
                '  void dispose() {\n'
                '    _ctrl?.removeListener(this);\n'
                '    super.dispose();\n'
                '  }\n\n'
                '  @override\n'
                '  void onWindowFocusChanged(bool focused) {\n'
                '    setState(() { /* update UI */ });\n'
                '  }\n\n'
                '  @override\n'
                '  void onWindowSizeChanged(Size size) {\n'
                '    // Called when the OS resizes the window\n'
                '  }\n\n'
                '  @override\n'
                '  void onWindowStateChanged(WindowState state) {\n'
                '    // state: normal | minimized | maximized | fullscreen\n'
                '  }\n'
                '}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Event reference
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.list_outlined, 'WindowListener Event Reference'),
              _EventRow('onWindowFocusChanged(bool focused)',
                  'Fired when the window gains or loses OS focus.'),
              _EventRow('onWindowSizeChanged(Size size)',
                  'Fired when the window is resized by the user or programmatically.'),
              _EventRow('onWindowPositionChanged(Offset position)',
                  'Fired when the window is moved to a new screen position.'),
              _EventRow('onWindowStateChanged(WindowState state)',
                  'Fired on minimize, maximize, restore, fullscreen transitions.'),
              _EventRow('onWindowClose()',
                  'Fired when the user clicks the close button. Return false to cancel.'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Focus simulation
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.center_focus_strong_outlined, 'Focus Demo'),
              ValueListenableBuilder<bool>(
                valueListenable: _windowFocused,
                builder: (BuildContext cE, bool focused, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: focused
                              ? _kGreenSoft
                              : const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: focused ? _kGreen : _kBorder,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              focused
                                  ? Icons.center_focus_strong
                                  : Icons.center_focus_weak_outlined,
                              color: focused ? _kGreen : _kBorder,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  focused ? 'Window Focused' : 'Window Unfocused',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: focused ? _kGreen : _kRed,
                                  ),
                                ),
                                Text(
                                  focused
                                      ? 'onWindowFocusChanged(true) fired'
                                      : 'onWindowFocusChanged(false) fired',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: _kInk,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: () {
                              _windowFocused.value = true;
                              _log('onWindowFocusChanged(true) — focus gained');
                            },
                            icon: const Icon(Icons.center_focus_strong, size: 16),
                            label: const Text('Gain Focus'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _kGreen,
                                foregroundColor: Colors.white),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              _windowFocused.value = false;
                              _log('onWindowFocusChanged(false) — focus lost');
                            },
                            icon: const Icon(Icons.center_focus_weak_outlined,
                                size: 16),
                            label: const Text('Lose Focus'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // didChangeMetrics note
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.info_outline, 'didChangeMetrics vs WindowListener'),
              const Text(
                'Before RegularWindowController, developers used '
                'WidgetsBindingObserver.didChangeMetrics() for window size changes. '
                'This is still functional but has limitations:',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 12),
              _CodeBlock(
                '// Legacy approach (still works, but coarser grained)\n'
                'class _State extends State<W> with WidgetsBindingObserver {\n'
                '  @override\n'
                '  void initState() {\n'
                '    super.initState();\n'
                '    WidgetsBinding.instance.addObserver(this);\n'
                '  }\n\n'
                '  @override\n'
                '  void didChangeMetrics() {\n'
                '    // Fires for ANY metric change including text scale,\n'
                '    // not just window resize — needs manual filtering.\n'
                '    final FlutterView view = View.of(context);\n'
                '    final Size size = view.physicalSize / view.devicePixelRatio;\n'
                '  }\n'
                '}',
              ),
              const SizedBox(height: 12),
              const Text(
                'WindowListener.onWindowSizeChanged is more precise: it fires '
                'only on actual window dimension changes, not text scale or '
                'display metric updates.',
                style: TextStyle(fontSize: 13, height: 1.45, color: _kInk),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EventRow extends StatelessWidget {
  const _EventRow(this.name, this.desc);

  final String name;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _kSeed,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            desc,
            style: const TextStyle(fontSize: 13, height: 1.4, color: _kInk),
          ),
          const Divider(height: 16, color: _kBorder),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 8 — Multi-Window
// ===========================================================================
class _MultiWindowTab extends StatelessWidget {
  const _MultiWindowTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.layers_outlined, 'Multi-Window Architecture'),
              const Text(
                'Flutter desktop apps can open multiple windows. Each window '
                'is a separate FlutterView in the engine. RegularWindowController '
                'is instantiated per view, allowing independent control of each window.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _CodeBlock(
                '// Creating a new window (engine-level)\n'
                'final FlutterView? newView =\n'
                '    await WidgetApp.of(context)!.openWindow();\n\n'
                '// Each view gets its own controller\n'
                'if (newView != null) {\n'
                '  final RegularWindowController ctrl =\n'
                '      RegularWindowController(view: newView);\n'
                '  await ctrl.setTitle(\'Secondary Window\');\n'
                '  await ctrl.setSize(const Size(640, 480));\n'
                '}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Multi-window diagram
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.account_tree_outlined, 'Multi-Window Diagram'),
              const Text(
                'One Flutter engine process manages all windows. Each RegularWindow '
                'widget roots a separate widget tree inside its FlutterView.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 20),
              const _MultiWindowDiagram(),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Coordination patterns
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.sync_outlined, 'Cross-Window Coordination'),
              const Text(
                'Controllers for different windows can be kept in a top-level '
                'store and used to coordinate window layouts.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _CodeBlock(
                '// Example: tile two windows side by side\n'
                'Future<void> tileWindows(\n'
                '  RegularWindowController main,\n'
                '  RegularWindowController secondary,\n'
                '  Size screenSize,\n'
                ') async {\n'
                '  final double halfW = screenSize.width / 2;\n'
                '  final double h = screenSize.height;\n\n'
                '  await Future.wait(<Future<void>>[\n'
                '    main.setSize(Size(halfW, h)),\n'
                '    main.setPosition(Offset.zero),\n'
                '    secondary.setSize(Size(halfW, h)),\n'
                '    secondary.setPosition(Offset(halfW, 0)),\n'
                '  ]);\n'
                '}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Window list simulation
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.list_alt_outlined, 'Simulated Window Registry'),
              _WindowRegistryItem(
                id: 'view_0',
                title: 'Main Application',
                size: const Size(1280, 800),
                state: 'normal',
                isMain: true,
              ),
              _WindowRegistryItem(
                id: 'view_1',
                title: 'Document Editor',
                size: const Size(900, 700),
                state: 'normal',
                isMain: false,
              ),
              _WindowRegistryItem(
                id: 'view_2',
                title: 'Inspector Panel',
                size: const Size(400, 800),
                state: 'minimized',
                isMain: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MultiWindowDiagram extends StatelessWidget {
  const _MultiWindowDiagram();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Engine row
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _kChromeDark,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Flutter Engine (single process)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  const Icon(Icons.arrow_downward, size: 16, color: _kBorder),
                  _MultiWindowBox('FlutterView 0', 'RegularWindowController(view_0)', _kSeed),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: <Widget>[
                  const Icon(Icons.arrow_downward, size: 16, color: _kBorder),
                  _MultiWindowBox('FlutterView 1', 'RegularWindowController(view_1)', _kPurple),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: <Widget>[
                  const Icon(Icons.arrow_downward, size: 16, color: _kBorder),
                  _MultiWindowBox('FlutterView 2', 'RegularWindowController(view_2)', _kAccent),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(child: _OsWindowBox('OS Window 0\n(main)', _kSeed)),
            const SizedBox(width: 8),
            Expanded(child: _OsWindowBox('OS Window 1\n(secondary)', _kPurple)),
            const SizedBox(width: 8),
            Expanded(child: _OsWindowBox('OS Window 2\n(panel)', _kAccent)),
          ],
        ),
      ],
    );
  }
}

class _MultiWindowBox extends StatelessWidget {
  const _MultiWindowBox(this.view, this.ctrl, this.color);

  final String view;
  final String ctrl;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            view,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ctrl,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: color.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }
}

class _OsWindowBox extends StatelessWidget {
  const _OsWindowBox(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kChrome.withAlpha(20),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kChrome.withAlpha(60)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color: _kChrome,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _WindowRegistryItem extends StatelessWidget {
  const _WindowRegistryItem({
    required this.id,
    required this.title,
    required this.size,
    required this.state,
    required this.isMain,
  });

  final String id;
  final String title;
  final Size size;
  final String state;
  final bool isMain;

  @override
  Widget build(BuildContext context) {
    final Color stateColor = state == 'minimized'
        ? _kYellow
        : state == 'maximized'
            ? _kGreen
            : _kSeed;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMain ? _kSeed.withAlpha(12) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isMain ? _kSeed.withAlpha(80) : _kBorder,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.window_outlined, color: _kSeed, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isMain) ...<Widget>[
                        const SizedBox(width: 8),
                        const _Chip('main', color: _kSeed),
                      ],
                    ],
                  ),
                  Text(
                    '$id  •  ${size.width.toInt()}×${size.height.toInt()} px',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: _kBorder,
                    ),
                  ),
                ],
              ),
            ),
            _Chip(state, color: stateColor),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 9 — Pitfalls & API Cheat Sheet
// ===========================================================================
class _PitfallsAndApiTab extends StatelessWidget {
  const _PitfallsAndApiTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.warning_amber_outlined, 'Common Pitfalls'),
              const _PitfallItem(
                title: '1. Desktop-Only API',
                body: 'RegularWindowController.of(context) returns null on iOS '
                    'and Android. Always null-check before calling any method. '
                    'Shipping without this guard causes null-pointer errors on mobile.',
                color: _kRed,
              ),
              const _PitfallItem(
                title: '2. All Methods Are Async',
                body: 'Every window operation returns a Future. Calling '
                    'ctrl.setTitle() without await does NOT guarantee the title '
                    'is updated before the next frame. Use await or chain properly.',
                color: _kYellow,
              ),
              const _PitfallItem(
                title: '3. Platform Inconsistencies',
                body: 'setPosition on Linux may be silently ignored by tiling '
                    'window managers. Always test on all target platforms. '
                    'Do not assume macOS behavior applies to Windows or Linux.',
                color: _kYellow,
              ),
              const _PitfallItem(
                title: '4. Size in Logical Pixels',
                body: 'All size and position values are in logical (device-independent) '
                    'pixels, NOT physical pixels. On a 2x display, a 900×600 logical '
                    'window is 1800×1200 physical pixels. Use View.devicePixelRatio '
                    'only when dealing with physical values.',
                color: _kSeed,
              ),
              const _PitfallItem(
                title: '5. Controller Lifetime',
                body: 'The controller is tied to a FlutterView. If the view is '
                    'destroyed (window closed), the controller becomes invalid. '
                    'Always remove WindowListener in dispose() to avoid memory leaks.',
                color: _kRed,
              ),
              const _PitfallItem(
                title: '6. setFullScreen vs maximize',
                body: 'setFullScreen(true) hides the OS menu bar and Dock on macOS '
                    'and enters a true fullscreen space. maximize() only fills the '
                    'visible screen area — chrome remains visible. These are different.',
                color: _kPurple,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // API cheat sheet
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(Icons.article_outlined, 'API Cheat Sheet'),
              const _ApiSection('Constructors & Lookup'),
              _ApiRow('RegularWindowController(view: v)', 'Direct construction for a FlutterView.'),
              _ApiRow('RegularWindowController.of(context)', 'Inherited lookup; null on non-desktop.'),
              const _ApiSection('Setters'),
              _ApiRow('setTitle(String title)', 'Updates the OS title bar text.'),
              _ApiRow('setSize(Size size)', 'Resizes the window in logical pixels.'),
              _ApiRow('setPosition(Offset pos)', 'Moves the window top-left to pos.'),
              _ApiRow('setMinSize(Size size)', 'Sets minimum resize constraint.'),
              _ApiRow('setMaxSize(Size size)', 'Sets maximum resize constraint.'),
              _ApiRow('setResizable(bool resizable)', 'Enables or disables user resize.'),
              _ApiRow('setFullScreen(bool full)', 'Enters or exits true fullscreen.'),
              const _ApiSection('State Transitions'),
              _ApiRow('minimize()', 'Sends window to taskbar/Dock.'),
              _ApiRow('maximize()', 'Expands to fill visible screen.'),
              _ApiRow('restore()', 'Returns to previous normal state.'),
              const _ApiSection('Getters (all async)'),
              _ApiRow('title → Future<String>', 'Current window title.'),
              _ApiRow('size → Future<Size>', 'Current logical window size.'),
              _ApiRow('position → Future<Offset>', 'Current window position.'),
              _ApiRow('isFullScreen → Future<bool>', 'Fullscreen state.'),
              _ApiRow('isMaximized → Future<bool>', 'Maximized state.'),
              _ApiRow('isMinimized → Future<bool>', 'Minimized state.'),
              _ApiRow('isResizable → Future<bool>', 'Resize enabled state.'),
              const _ApiSection('Event Listener'),
              _ApiRow('addListener(WindowListener l)', 'Subscribe to window events.'),
              _ApiRow('removeListener(WindowListener l)', 'Unsubscribe from events.'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Comparison with dart:ui FlutterView
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.compare_outlined, 'Comparison: dart:ui FlutterView vs RegularWindowController'),
              const Text(
                'Both APIs relate to the same window but serve different purposes:',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  border: TableBorder.all(
                    color: _kBorder,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  children: <TableRow>[
                    TableRow(
                      decoration: const BoxDecoration(color: _kChromeDark),
                      children: <Widget>[
                        _th2('Capability'),
                        _th2('FlutterView (dart:ui)'),
                        _th2('RegularWindowController'),
                      ],
                    ),
                    _compRow('Set window title', false, true),
                    _compRow('Set window size', false, true),
                    _compRow('Set window position', false, true),
                    _compRow('Minimize/maximize/restore', false, true),
                    _compRow('Toggle fullscreen', false, true),
                    _compRow('Physical pixel size', true, false),
                    _compRow('Device pixel ratio', true, false),
                    _compRow('Display info', true, false),
                    _compRow('Padding/insets', true, false),
                    _compRow('Semantics', true, false),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Best practices summary
        _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader(
                  Icons.check_circle_outline, 'Best Practices Summary'),
              const _BulletItem(
                'Guard all controller calls with a null-check: '
                    'final ctrl = RegularWindowController.of(context); '
                    'if (ctrl == null) return;',
              ),
              const _BulletItem(
                'Always await window operations before reading back state '
                    'to avoid race conditions.',
              ),
              const _BulletItem(
                'Use RegularWindow at the root of each window\'s widget tree '
                    'so descendants can reach the controller via .of(context).',
              ),
              const _BulletItem(
                'Remove WindowListener in dispose() to prevent memory leaks '
                    'when the observing widget is removed from the tree.',
              ),
              const _BulletItem(
                'Test on all three desktop platforms; do not assume macOS '
                    'behavior generalizes.',
              ),
              const _BulletItem(
                'Prefer logical pixels for all size/position computations; '
                    'multiply by devicePixelRatio only when the platform API '
                    'requires physical pixels.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PitfallItem extends StatelessWidget {
  const _PitfallItem({
    required this.title,
    required this.body,
    required this.color,
  });

  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 10),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(fontSize: 13, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiSection extends StatelessWidget {
  const _ApiSection(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: _kBorder,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow(this.signature, this.desc);

  final String signature;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 260,
            child: Text(
              signature,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: _kSeed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(fontSize: 12, color: _kInk),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _th2(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      ),
    ),
  );
}

TableRow _compRow(String cap, bool inView, bool inCtrl) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(cap, style: const TextStyle(fontSize: 12)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: _YesNo(inView),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: _YesNo(inCtrl),
      ),
    ],
  );
}

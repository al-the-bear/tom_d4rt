import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — slate + lime Linux/GTK-inspired Material 3 seeds.
// ---------------------------------------------------------------------------
const Color _kSeed = Color(0xFF3A6B35);
const Color _kInk = Color(0xFF1A2B1A);
const Color _kSurface = Color(0xFFF4F8F3);
const Color _kSurfaceAlt = Color(0xFFE8F0E7);
const Color _kBorder = Color(0xFFB3C8B1);
const Color _kAccentDark = Color(0xFF2D5A2A);
const Color _kRed = Color(0xFFCC4444);
const Color _kAmber = Color(0xFFCC8800);
const Color _kBlue = Color(0xFF3355AA);
const Color _kOk = Color(0xFF2F7A44);
const Color _kBad = Color(0xFFB23A3A);
const Color _kChrome = Color(0xFF404040);
const Color _kCode = Color(0xFF1E3A1E);

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — stateless demo, reactive via ValueListenableBuilder
// ---------------------------------------------------------------------------
final ValueNotifier<_WinState> _windowState =
    ValueNotifier<_WinState>(_WinState.normal);
final ValueNotifier<bool> _decorationsClientSide =
    ValueNotifier<bool>(true);
final ValueNotifier<int> _activeWindowIndex = ValueNotifier<int>(0);
final ValueNotifier<bool> _showDbusDetail = ValueNotifier<bool>(false);
final ValueNotifier<_WmType> _activeWm = ValueNotifier<_WmType>(_WmType.gnome);

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------
enum _WinState { normal, minimized, maximized, fullscreen }
enum _WmType { gnome, kde, weston }

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _LinuxWindowDemo();
}

// ===========================================================================
// Root app
// ===========================================================================
class _LinuxWindowDemo extends StatelessWidget {
  const _LinuxWindowDemo();

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
      cardTheme: const CardThemeData(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk, height: 1.4),
        titleLarge: TextStyle(
          color: _kInk,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
        titleMedium: TextStyle(
          color: _kInk,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        labelSmall: TextStyle(
          color: _kAccentDark,
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
// Shell scaffold with 9-tab layout
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
          backgroundColor: _kAccentDark,
          foregroundColor: Colors.white,
          toolbarHeight: 88,
          elevation: 0,
          title: const _AppBarTitle(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: _TabBar(),
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _HeroBannerTab(),
            _ChromeSimTab(),
            _ArchDiagramTab(),
            _StateMachineTab(),
            _DecorationsTab(),
            _DbusTab(),
            _MultiWindowTab(),
            _WmCompareTab(),
            _PitfallsApiTab(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text(
          'RegularWindowControllerLinux',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Linux desktop window management in Flutter — deep visual demo',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFFBFDFBF),
            fontWeight: FontWeight.w400,
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
    return TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: const Color(0xFFAACCAA),
      labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      tabs: const <Tab>[
        Tab(text: '1 · Hero'),
        Tab(text: '2 · Chrome'),
        Tab(text: '3 · Arch'),
        Tab(text: '4 · State Machine'),
        Tab(text: '5 · Decorations'),
        Tab(text: '6 · D-Bus'),
        Tab(text: '7 · Multi-Window'),
        Tab(text: '8 · WM Compare'),
        Tab(text: '9 · Pitfalls & API'),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (subtitle != null) ...<Widget>[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: const TextStyle(fontSize: 12, color: Color(0xFF556655)),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.all(14),
      child: child,
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
      decoration: BoxDecoration(
        color: _kCode,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF3A6A3A)),
      ),
      padding: const EdgeInsets.all(14),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFF9FFFAF),
          height: 1.55,
        ),
      ),
    );
  }
}

class _LabelBadge extends StatelessWidget {
  const _LabelBadge(this.text, {this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: (color ?? _kAccentDark).withAlpha(26),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: (color ?? _kAccentDark).withAlpha(80)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color ?? _kAccentDark,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 1 — Hero Banner
// ===========================================================================
class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _buildHeroCard(),
        const SizedBox(height: 20),
        _buildClassHierarchyCard(),
        const SizedBox(height: 20),
        _buildLinuxContextCard(),
        const SizedBox(height: 20),
        _buildArchSummary(),
        const SizedBox(height: 20),
        _buildFlutterDesktopTimeline(),
      ],
    );
  }

  Widget _buildHeroCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_kAccentDark, Color(0xFF1A4A17)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x44000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.desktop_windows, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'RegularWindowControllerLinux',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.1,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Linux-specific window controller interface',
                      style: TextStyle(color: Color(0xFFBFDFBF), fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Linux desktop window management in Flutter is handled through a platform-specific '
            'controller hierarchy. RegularWindowControllerLinux is the Linux implementation of '
            'the RegularWindowController abstraction, providing access to GTK window properties, '
            'X11/Wayland surface identifiers, and decoration controls specific to the Linux '
            'display server ecosystem.',
            style: TextStyle(
              color: Color(0xFFDDEEDD),
              fontSize: 13,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: const <Widget>[
              _HeroPill('GTK Integration'),
              _HeroPill('X11 / Wayland'),
              _HeroPill('D-Bus IPC'),
              _HeroPill('CSD / SSD'),
              _HeroPill('Multi-window'),
              _HeroPill('FlutterView bridge'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClassHierarchyCard() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            'Class Hierarchy',
            subtitle: 'Where RegularWindowControllerLinux fits',
          ),
          const SizedBox(height: 8),
          _HierarchyRow(depth: 0, name: 'RegularWindowControllerDelegate', role: 'abstract base'),
          _HierarchyRow(depth: 1, name: 'RegularWindowController', role: 'cross-platform contract'),
          _HierarchyRow(depth: 2, name: 'RegularWindowControllerLinux', role: 'Linux impl', highlight: true),
          _HierarchyRow(depth: 2, name: 'RegularWindowControllerMacOS', role: 'macOS impl'),
          _HierarchyRow(depth: 2, name: 'RegularWindowControllerWin32', role: 'Win32 impl'),
          const SizedBox(height: 12),
          const Text(
            'The Linux controller is instantiated by the Flutter engine on linux desktop targets. '
            'It is surfaced to Dart code as the platform view controller for a regular '
            '(non-dialog, non-fullscreen) window.',
            style: TextStyle(fontSize: 12, color: Color(0xFF445544), height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildLinuxContextCard() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Linux Display Architecture', subtitle: 'X11, Wayland, and GTK'),
          const SizedBox(height: 8),
          _buildDisplayTable(),
        ],
      ),
    );
  }

  Widget _buildDisplayTable() {
    final List<List<String>> rows = <List<String>>[
      <String>['X11', 'Xlib / XCB', 'DISPLAY', 'GDK_BACKEND=x11'],
      <String>['Wayland', 'libwayland-client', 'WAYLAND_DISPLAY', 'GDK_BACKEND=wayland'],
      <String>['GTK3/4', 'GDK abstraction', 'Both', 'Default on modern distros'],
      <String>['Mir', 'Mir client libs', 'MIR_SOCKET', 'Ubuntu Touch / Unity8'],
    ];
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: _kBorder, width: 0.5),
      children: <TableRow>[
        _tableHeaderRow(<String>['Backend', 'Protocol Library', 'Socket/Env', 'Activation']),
        ...rows.map(
          (List<String> r) => _tableDataRow(r),
        ),
      ],
    );
  }

  Widget _buildArchSummary() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            'How Flutter Talks to Linux Windows',
            subtitle: 'Simplified call stack',
          ),
          const SizedBox(height: 8),
          _buildCallStack(),
        ],
      ),
    );
  }

  Widget _buildCallStack() {
    final List<_CallStackItem> items = <_CallStackItem>[
      _CallStackItem('Dart / Flutter Framework', _kAccentDark, 'Your app code — uses RegularWindowController API'),
      _CallStackItem('Platform Channel (MethodChannel)', _kBlue, 'Serialises calls across the Dart/native boundary'),
      _CallStackItem('Flutter Engine (C++)', const Color(0xFF885500), 'flutter::FlutterWindow — owns GTK GtkWidget*'),
      _CallStackItem('GTK3 / GTK4', const Color(0xFF770077), 'GtkApplicationWindow → GdkSurface → native surface'),
      _CallStackItem('GDK Backend', const Color(0xFF007777), 'X11: GdkX11Window  |  Wayland: GdkWaylandWindow'),
      _CallStackItem('Compositor / WM', const Color(0xFF444444), 'Mutter (GNOME) · KWin (KDE) · Weston (reference)'),
    ];
    return Column(
      children: items.asMap().entries.map((MapEntry<int, _CallStackItem> e) {
        final bool last = e.key == items.length - 1;
        return Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: e.value.color.withAlpha(22),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: e.value.color.withAlpha(70)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    e.value.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: e.value.color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    e.value.detail,
                    style: const TextStyle(fontSize: 11, color: Color(0xFF556655)),
                  ),
                ],
              ),
            ),
            if (!last)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Icon(Icons.arrow_downward, size: 14, color: _kBorder),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildFlutterDesktopTimeline() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Flutter Linux Desktop Timeline'),
          const SizedBox(height: 8),
          _TimelineEntry('Flutter 2.0 (Mar 2021)', 'Linux desktop promoted to beta', _kAmber),
          _TimelineEntry('Flutter 2.5 (Sep 2021)', 'Input method improvements for GTK', _kAmber),
          _TimelineEntry('Flutter 3.0 (May 2022)', 'Linux desktop stable, Wayland preview', _kOk),
          _TimelineEntry('Flutter 3.7 (Jan 2023)', 'Improved Wayland clipboard + IME', _kOk),
          _TimelineEntry('Flutter 3.16 (Nov 2023)', 'Native GTK title bar option added', _kOk),
          _TimelineEntry('Flutter 3.22+ (2024)', 'Multi-view / multi-window Linux support', _kBlue),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(28),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withAlpha(60)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HierarchyRow extends StatelessWidget {
  const _HierarchyRow({
    required this.depth,
    required this.name,
    required this.role,
    this.highlight = false,
  });
  final int depth;
  final String name;
  final String role;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 20.0, bottom: 4),
      child: Row(
        children: <Widget>[
          if (depth > 0)
            const Text(
              '↳ ',
              style: TextStyle(fontSize: 12, color: _kAccentDark),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: highlight ? _kAccentDark.withAlpha(22) : _kSurfaceAlt,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: highlight ? _kAccentDark.withAlpha(100) : _kBorder,
                width: highlight ? 1.5 : 0.5,
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
                color: highlight ? _kAccentDark : _kInk,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            role,
            style: const TextStyle(fontSize: 11, color: Color(0xFF667766)),
          ),
        ],
      ),
    );
  }
}

class _CallStackItem {
  const _CallStackItem(this.label, this.color, this.detail);
  final String label;
  final Color color;
  final String detail;
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry(this.version, this.detail, this.color);
  final String version;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 3, right: 10),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12, color: _kInk),
                children: <TextSpan>[
                  TextSpan(
                    text: '$version  ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: detail),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TableRow _tableHeaderRow(List<String> cells) {
  return TableRow(
    decoration: const BoxDecoration(color: _kAccentDark),
    children: cells
        .map(
          (String c) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              c,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
        )
        .toList(),
  );
}

TableRow _tableDataRow(List<String> cells) {
  return TableRow(
    children: cells
        .map(
          (String c) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Text(c, style: const TextStyle(fontSize: 11, color: _kInk)),
          ),
        )
        .toList(),
  );
}

// ===========================================================================
// TAB 2 — GNOME-style Chrome Simulation
// ===========================================================================
class _ChromeSimTab extends StatelessWidget {
  const _ChromeSimTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          'Linux Window Chrome Simulation',
          subtitle: 'Flutter-drawn GNOME-style window with interactive controls',
        ),
        const SizedBox(height: 8),
        _buildExplanation(),
        const SizedBox(height: 16),
        _buildChromeWindow(),
        const SizedBox(height: 16),
        _buildChromeAnnotations(),
        const SizedBox(height: 16),
        _buildDecorationToggle(),
      ],
    );
  }

  Widget _buildExplanation() {
    return _InfoCard(
      child: const Text(
        'On Linux, window chrome (title bar, buttons, borders) can be drawn by either the '
        'window manager ("server-side decorations") or by the application itself ("client-side '
        'decorations", CSD). GTK 3+ defaults to CSD. Flutter supports both modes through '
        'the GtkHeaderBar integration and the --enable-impeller flag combinations.',
        style: TextStyle(fontSize: 12, color: _kInk, height: 1.5),
      ),
    );
  }

  Widget _buildChromeWindow() {
    return ValueListenableBuilder<_WinState>(
      valueListenable: _windowState,
      builder: (BuildContext ctx, _WinState state, Widget? _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildWindowFrame(state),
          ],
        );
      },
    );
  }

  Widget _buildWindowFrame(_WinState state) {
    final bool isMaximized = state == _WinState.maximized || state == _WinState.fullscreen;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isMaximized ? BorderRadius.zero : BorderRadius.circular(10),
        border: Border.all(color: _kChrome, width: 1.2),
        boxShadow: isMaximized
            ? null
            : const <BoxShadow>[
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTitleBar(state, isMaximized),
          _buildWindowBody(state),
          if (!isMaximized) _buildResizeHandle(),
        ],
      ),
    );
  }

  Widget _buildTitleBar(_WinState state, bool isMaximized) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: _kChrome,
        borderRadius: isMaximized
            ? BorderRadius.zero
            : const BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: <Widget>[
          _buildChromeButton(_kRed, Icons.close, () => _windowState.value = _WinState.minimized),
          const SizedBox(width: 8),
          _buildChromeButton(_kAmber, Icons.minimize, () => _windowState.value = _WinState.minimized),
          const SizedBox(width: 8),
          _buildChromeButton(_kOk, Icons.crop_square, () {
            _windowState.value = _windowState.value == _WinState.maximized
                ? _WinState.normal
                : _WinState.maximized;
          }),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Flutter Linux App — ${_winStateLabel(state)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.menu, color: Colors.white54, size: 16),
        ],
      ),
    );
  }

  Widget _buildChromeButton(Color color, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black.withAlpha(40), width: 0.5),
        ),
        child: Icon(icon, size: 8, color: Colors.black.withAlpha(120)),
      ),
    );
  }

  Widget _buildWindowBody(_WinState state) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFF9FFF9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildWindowMenuBar(),
          const SizedBox(height: 10),
          _buildMockContent(state),
        ],
      ),
    );
  }

  Widget _buildWindowMenuBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Row(
        children: <String>['File', 'Edit', 'View', 'Help']
            .map(
              (String item) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 12, color: _kInk),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildMockContent(_WinState state) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _kBorder),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.desktop_windows, size: 14, color: _kAccentDark),
                const SizedBox(width: 6),
                Text(
                  'Window state: ${_winStateLabel(state)}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kAccentDark),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Application content area — managed by Flutter rendering pipeline.\n'
              'The GtkWidget* is the container; FlutterView renders here.',
              style: TextStyle(fontSize: 11, color: Color(0xFF667766), height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResizeHandle() {
    return Container(
      height: 14,
      decoration: BoxDecoration(
        color: _kChrome.withAlpha(50),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(9),
          bottomRight: Radius.circular(9),
        ),
        border: const Border(top: BorderSide(color: _kBorder, width: 0.5)),
      ),
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(right: 4),
      child: Icon(Icons.open_in_full, size: 10, color: _kChrome.withAlpha(180)),
    );
  }

  Widget _buildChromeAnnotations() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Chrome Component Legend'),
          const SizedBox(height: 6),
          _AnnotationRow(_kRed, 'Close button', 'Calls gtk_window_close() → wl_surface destroy'),
          _AnnotationRow(_kAmber, 'Minimize button', 'gtk_window_iconify() → send_configure_request'),
          _AnnotationRow(_kOk, 'Maximize toggle', 'gtk_window_maximize/unmaximize()'),
          _AnnotationRow(_kChrome, 'Title bar (CSD)', 'GtkHeaderBar widget — drawn by app, not WM'),
          _AnnotationRow(_kBorder, 'Resize handle', 'gtk_window_resize_grip — GDK resize edges'),
        ],
      ),
    );
  }

  Widget _buildDecorationToggle() {
    return _InfoCard(
      child: ValueListenableBuilder<bool>(
        valueListenable: _decorationsClientSide,
        builder: (BuildContext ctx, bool csd, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionHeader('Decoration Mode Toggle'),
              Row(
                children: <Widget>[
                  const Text('Server-side (WM draws chrome)', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 10),
                  Switch(
                    value: csd,
                    onChanged: (bool v) => _decorationsClientSide.value = v,
                    activeThumbColor: _kAccentDark,
                  ),
                  const SizedBox(width: 10),
                  const Text('Client-side (App draws chrome)', style: TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: csd ? _kOk.withAlpha(18) : _kBlue.withAlpha(18),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: csd ? _kOk.withAlpha(80) : _kBlue.withAlpha(80)),
                ),
                child: Text(
                  csd
                      ? 'CSD active: GtkHeaderBar visible. gtk_window_set_titlebar() configured.\n'
                          'Flutter window rendered inside a headerbar-less GtkApplicationWindow.'
                      : 'SSD active: Window manager decorates the frame.\n'
                          'gtk_window_set_decorated(TRUE) — title bar drawn by Mutter/KWin/Weston.',
                  style: TextStyle(
                    fontSize: 11,
                    color: csd ? _kOk : _kBlue,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _winStateLabel(_WinState s) {
    switch (s) {
      case _WinState.normal:
        return 'Normal';
      case _WinState.minimized:
        return 'Minimized';
      case _WinState.maximized:
        return 'Maximized';
      case _WinState.fullscreen:
        return 'Fullscreen';
    }
  }
}

class _AnnotationRow extends StatelessWidget {
  const _AnnotationRow(this.color, this.label, this.desc);
  final Color color;
  final String label;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 2, right: 8),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _kInk)),
          ),
          Expanded(
            child: Text(desc, style: const TextStyle(fontSize: 11, color: Color(0xFF556655))),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 3 — Architecture Diagram (CustomPainter)
// ===========================================================================
class _ArchDiagramTab extends StatelessWidget {
  const _ArchDiagramTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          'Window Manager Integration Diagram',
          subtitle: 'Flutter app → FlutterView → Linux window manager',
        ),
        const SizedBox(height: 12),
        _InfoCard(
          child: SizedBox(
            height: 420,
            child: CustomPaint(
              painter: _ArchPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildLayerBreakdown(),
        const SizedBox(height: 16),
        _buildGdkBackendDiagram(),
      ],
    );
  }

  Widget _buildLayerBreakdown() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Layer Responsibilities'),
          const SizedBox(height: 8),
          _LayerCard('Flutter Framework (Dart)', _kAccentDark,
              'Widget tree, rendering pipeline, platform channels. '
              'window.setGeometry(), window.title etc. forwarded here.'),
          const SizedBox(height: 6),
          _LayerCard('Flutter Engine (C++)', const Color(0xFF885500),
              'flutter::FlutterWindowLinux — wraps GtkApplicationWindow. '
              'Manages GdkGLContext, vsync via GDK frame clocks.'),
          const SizedBox(height: 6),
          _LayerCard('GTK / GDK', const Color(0xFF660077),
              'GdkSurface (Wayland wl_surface or X11 Window). '
              'GtkWidget* hierarchy maps the app window to the display server.'),
          const SizedBox(height: 6),
          _LayerCard('Compositor (Mutter/KWin)', const Color(0xFF444444),
              'Receives xdg_toplevel configure events (Wayland) '
              'or MapNotify / ConfigureNotify (X11). Applies decoration + tiling.'),
        ],
      ),
    );
  }

  Widget _buildGdkBackendDiagram() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('GDK Backend Decision Tree'),
          const SizedBox(height: 8),
          SizedBox(
            height: 160,
            child: CustomPaint(
              painter: _GdkBackendPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LayerCard extends StatelessWidget {
  const _LayerCard(this.label, this.color, this.detail);
  final String label;
  final Color color;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withAlpha(18),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color),
          ),
          const SizedBox(height: 3),
          Text(detail, style: const TextStyle(fontSize: 11, color: _kInk, height: 1.4)),
        ],
      ),
    );
  }
}

class _ArchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final List<_BoxSpec> boxes = <_BoxSpec>[
      _BoxSpec('Dart App Code\n(Flutter Framework)', 0.1, 0.04, 0.8, 0.11, const Color(0xFF3A6B35)),
      _BoxSpec('RegularWindowControllerLinux', 0.15, 0.2, 0.7, 0.09, const Color(0xFF1A5A18)),
      _BoxSpec('Platform Channel\n(MethodChannel)', 0.2, 0.34, 0.6, 0.09, const Color(0xFF3355AA)),
      _BoxSpec('Flutter Engine (C++)\nflutter::FlutterWindowLinux', 0.1, 0.48, 0.8, 0.11, const Color(0xFF885500)),
      _BoxSpec('GTK / GDK\nGtkApplicationWindow → GdkSurface', 0.1, 0.64, 0.8, 0.11, const Color(0xFF660077)),
      _BoxSpec('Linux Compositor (Mutter / KWin / Weston)', 0.1, 0.80, 0.8, 0.11, const Color(0xFF444444)),
    ];

    for (final _BoxSpec b in boxes) {
      final Rect r = Rect.fromLTWH(b.x * w, b.y * h, b.width * w, b.height * h);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(8));
      canvas.drawRRect(
        rr,
        Paint()..color = b.color.withAlpha(28),
      );
      canvas.drawRRect(
        rr,
        Paint()
          ..color = b.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: b.label,
          style: TextStyle(
            color: b.color,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            height: 1.35,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout(maxWidth: b.width * w - 16);
      tp.paint(
        canvas,
        Offset(
          b.x * w + (b.width * w - tp.width) / 2,
          b.y * h + (b.height * h - tp.height) / 2,
        ),
      );
    }

    final Paint arrowPaint = Paint()
      ..color = _kBorder
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final List<double> arrowYStarts = <double>[0.15, 0.29, 0.43, 0.59, 0.75];
    for (final double yFrac in arrowYStarts) {
      final double y0 = yFrac * h;
      final double y1 = y0 + 0.05 * h;
      final Offset start = Offset(w / 2, y0);
      final Offset end = Offset(w / 2, y1);
      canvas.drawLine(start, end, arrowPaint);
      final Path arrow = Path()
        ..moveTo(end.dx - 5, end.dy - 7)
        ..lineTo(end.dx, end.dy)
        ..lineTo(end.dx + 5, end.dy - 7);
      canvas.drawPath(arrow, arrowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BoxSpec {
  const _BoxSpec(this.label, this.x, this.y, this.width, this.height, this.color);
  final String label;
  final double x;
  final double y;
  final double width;
  final double height;
  final Color color;
}

class _GdkBackendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Paint linePaint = Paint()
      ..color = _kBorder
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    void box(double x, double y, double bw, double bh, String text, Color col) {
      final Rect r = Rect.fromLTWH(x, y, bw, bh);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(6));
      canvas.drawRRect(rr, Paint()..color = col.withAlpha(22));
      canvas.drawRRect(rr, Paint()..color = col..style = PaintingStyle.stroke..strokeWidth = 1);
      final TextPainter tp = TextPainter(
        text: TextSpan(text: text, style: TextStyle(color: col, fontSize: 10, fontWeight: FontWeight.w700)),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout(maxWidth: bw - 8);
      tp.paint(canvas, Offset(x + (bw - tp.width) / 2, y + (bh - tp.height) / 2));
    }

    box(w * 0.3, 0, w * 0.4, h * 0.18, 'GDK Init', _kAccentDark);
    canvas.drawLine(Offset(w / 2, h * 0.18), Offset(w * 0.25, h * 0.4), linePaint);
    canvas.drawLine(Offset(w / 2, h * 0.18), Offset(w * 0.75, h * 0.4), linePaint);
    box(0, h * 0.4, w * 0.42, h * 0.2, 'WAYLAND_DISPLAY set?\nGdkWaylandDisplay', _kBlue);
    box(w * 0.55, h * 0.4, w * 0.42, h * 0.2, 'DISPLAY set?\nGdkX11Display', const Color(0xFF885500));
    canvas.drawLine(Offset(w * 0.21, h * 0.6), Offset(w * 0.21, h * 0.78), linePaint);
    canvas.drawLine(Offset(w * 0.76, h * 0.6), Offset(w * 0.76, h * 0.78), linePaint);
    box(0, h * 0.78, w * 0.42, h * 0.2, 'wl_surface\n(Wayland protocol)', _kBlue);
    box(w * 0.55, h * 0.78, w * 0.42, h * 0.2, 'X11 Window\n(Xlib / XCB)', const Color(0xFF885500));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ===========================================================================
// TAB 4 — Window State Machine
// ===========================================================================
class _StateMachineTab extends StatelessWidget {
  const _StateMachineTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          'Window State Machine',
          subtitle: 'Normal → Minimized → Maximized → Fullscreen',
        ),
        const SizedBox(height: 12),
        _buildStateDiagram(),
        const SizedBox(height: 16),
        _buildSegmentedControl(),
        const SizedBox(height: 16),
        _buildStateSummaryCard(),
        const SizedBox(height: 16),
        _buildTransitionTable(),
      ],
    );
  }

  Widget _buildStateDiagram() {
    return _InfoCard(
      child: SizedBox(
        height: 260,
        child: CustomPaint(
          painter: _StateMachinePainter(),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return ValueListenableBuilder<_WinState>(
      valueListenable: _windowState,
      builder: (BuildContext ctx, _WinState current, Widget? _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Live window state — tap to transition:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kInk),
            ),
            const SizedBox(height: 8),
            SegmentedButton<_WinState>(
              segments: const <ButtonSegment<_WinState>>[
                ButtonSegment<_WinState>(
                  value: _WinState.normal,
                  label: Text('Normal'),
                  icon: Icon(Icons.crop_free),
                ),
                ButtonSegment<_WinState>(
                  value: _WinState.minimized,
                  label: Text('Min'),
                  icon: Icon(Icons.minimize),
                ),
                ButtonSegment<_WinState>(
                  value: _WinState.maximized,
                  label: Text('Max'),
                  icon: Icon(Icons.crop_square),
                ),
                ButtonSegment<_WinState>(
                  value: _WinState.fullscreen,
                  label: Text('Full'),
                  icon: Icon(Icons.fullscreen),
                ),
              ],
              selected: <_WinState>{current},
              onSelectionChanged: (Set<_WinState> sel) {
                if (sel.isNotEmpty) _windowState.value = sel.first;
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) return _kAccentDark;
                  return null;
                }),
                foregroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) return Colors.white;
                  return null;
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStateSummaryCard() {
    return ValueListenableBuilder<_WinState>(
      valueListenable: _windowState,
      builder: (BuildContext ctx, _WinState state, Widget? _) {
        return _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _LabelBadge(_stateBadge(state), color: _stateColor(state)),
                  const SizedBox(width: 10),
                  Text(
                    'State: ${_stateLabel(state)}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kInk),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(_stateDesc(state), style: const TextStyle(fontSize: 12, color: _kInk, height: 1.5)),
              const SizedBox(height: 8),
              Text(
                'GTK call: ${_stateGtkCall(state)}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _kCode,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransitionTable() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('State Transition Reference'),
          const SizedBox(height: 8),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            border: TableBorder.all(color: _kBorder, width: 0.5),
            children: <TableRow>[
              _tableHeaderRow(<String>['From', 'To', 'GTK API', 'Wayland event']),
              _tableDataRow(<String>['normal', 'minimized', 'gtk_window_iconify()', 'xdg_toplevel.set_minimized']),
              _tableDataRow(<String>['normal', 'maximized', 'gtk_window_maximize()', 'xdg_toplevel.set_maximized']),
              _tableDataRow(<String>['normal', 'fullscreen', 'gtk_window_fullscreen()', 'xdg_toplevel.set_fullscreen']),
              _tableDataRow(<String>['maximized', 'normal', 'gtk_window_unmaximize()', 'xdg_toplevel.unset_maximized']),
              _tableDataRow(<String>['fullscreen', 'normal', 'gtk_window_unfullscreen()', 'xdg_toplevel.unset_fullscreen']),
              _tableDataRow(<String>['minimized', 'normal', 'gtk_window_present()', 'app-driven deiconify']),
            ],
          ),
        ],
      ),
    );
  }

  String _stateBadge(_WinState s) {
    switch (s) {
      case _WinState.normal: return 'NORMAL';
      case _WinState.minimized: return 'MIN';
      case _WinState.maximized: return 'MAX';
      case _WinState.fullscreen: return 'FULL';
    }
  }

  Color _stateColor(_WinState s) {
    switch (s) {
      case _WinState.normal: return _kOk;
      case _WinState.minimized: return _kAmber;
      case _WinState.maximized: return _kBlue;
      case _WinState.fullscreen: return _kBad;
    }
  }

  String _stateLabel(_WinState s) {
    switch (s) {
      case _WinState.normal: return 'Normal';
      case _WinState.minimized: return 'Minimized';
      case _WinState.maximized: return 'Maximized';
      case _WinState.fullscreen: return 'Fullscreen';
    }
  }

  String _stateDesc(_WinState s) {
    switch (s) {
      case _WinState.normal:
        return 'Window is at its natural size, positioned freely on the desktop. '
            'GdkWindowState has no special flags. Flutter renders at the user-set geometry.';
      case _WinState.minimized:
        return 'Window is iconified (hidden from the desktop, visible only in the taskbar). '
            'GdkWindowState: GDK_WINDOW_STATE_ICONIFIED. Flutter pauses rendering.';
      case _WinState.maximized:
        return 'Window fills the working area (excludes panels and docks). '
            'GdkWindowState: GDK_WINDOW_STATE_MAXIMIZED. Shadow and rounded corners removed by WM.';
      case _WinState.fullscreen:
        return 'Window covers the entire screen including panels. '
            'GdkWindowState: GDK_WINDOW_STATE_FULLSCREEN. Chrome hidden by compositor.';
    }
  }

  String _stateGtkCall(_WinState s) {
    switch (s) {
      case _WinState.normal: return 'gtk_window_present(window)';
      case _WinState.minimized: return 'gtk_window_iconify(window)';
      case _WinState.maximized: return 'gtk_window_maximize(window)';
      case _WinState.fullscreen: return 'gtk_window_fullscreen(window)';
    }
  }
}

class _StateMachinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Map<String, Offset> centers = <String, Offset>{
      'Normal': Offset(w * 0.5, h * 0.2),
      'Minimized': Offset(w * 0.15, h * 0.72),
      'Maximized': Offset(w * 0.5, h * 0.72),
      'Fullscreen': Offset(w * 0.85, h * 0.72),
    };
    final Map<String, Color> stateColors = <String, Color>{
      'Normal': _kOk,
      'Minimized': _kAmber,
      'Maximized': _kBlue,
      'Fullscreen': _kBad,
    };

    final List<List<String>> transitions = <List<String>>[
      <String>['Normal', 'Minimized'],
      <String>['Normal', 'Maximized'],
      <String>['Normal', 'Fullscreen'],
      <String>['Minimized', 'Normal'],
      <String>['Maximized', 'Normal'],
      <String>['Fullscreen', 'Normal'],
    ];

    for (final List<String> t in transitions) {
      final Offset from = centers[t[0]]!;
      final Offset to = centers[t[1]]!;
      final Offset dir = (to - from) / (to - from).distance;
      final Offset start = from + dir * 26;
      final Offset end = to - dir * 26;
      canvas.drawLine(
        start,
        end,
        Paint()
          ..color = _kBorder
          ..strokeWidth = 1.2,
      );
    }

    centers.forEach((String name, Offset center) {
      final Color col = stateColors[name]!;
      canvas.drawCircle(center, 26, Paint()..color = col.withAlpha(28));
      canvas.drawCircle(center, 26, Paint()..color = col..style = PaintingStyle.stroke..strokeWidth = 2);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: name,
          style: TextStyle(color: col, fontSize: 10, fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout(maxWidth: 50);
      tp.paint(canvas, center + Offset(-tp.width / 2, -tp.height / 2));
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ===========================================================================
// TAB 5 — Window Decorations
// ===========================================================================
class _DecorationsTab extends StatelessWidget {
  const _DecorationsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          'Window Decorations — CSD vs SSD',
          subtitle: 'Client-side vs server-side decoration strategies',
        ),
        const SizedBox(height: 12),
        _buildCompareRow(),
        const SizedBox(height: 16),
        _buildCsdDetail(),
        const SizedBox(height: 16),
        _buildSsdDetail(),
        const SizedBox(height: 16),
        _buildDecisionGuide(),
        const SizedBox(height: 16),
        _buildGtkHeaderBarCode(),
      ],
    );
  }

  Widget _buildCompareRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _DecorationCard(
          title: 'CSD (Client-Side)',
          color: _kAccentDark,
          icon: Icons.widgets_outlined,
          points: const <String>[
            'App draws its own title bar',
            'GtkHeaderBar widget',
            'Full visual control',
            'Shadows drawn in-process',
            'Default in GTK 3+',
            'GNOME standard',
          ],
        )),
        const SizedBox(width: 12),
        Expanded(child: _DecorationCard(
          title: 'SSD (Server-Side)',
          color: _kBlue,
          icon: Icons.window_outlined,
          points: const <String>[
            'WM draws frame + title bar',
            'gtk_window_set_decorated(TRUE)',
            'WM controls appearance',
            'Traditional X11 style',
            'More consistent on KDE',
            'Lower app complexity',
          ],
        )),
      ],
    );
  }

  Widget _buildCsdDetail() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('CSD in Flutter (GTK)'),
          _CodeBlock(
            '// Flutter Linux engine setup (C++ simplified)\n'
            'auto* window = gtk_application_window_new(app);\n'
            'auto* header = gtk_header_bar_new();\n'
            'gtk_header_bar_set_show_close_button(header, TRUE);\n'
            'gtk_window_set_titlebar(GTK_WINDOW(window),\n'
            '                        GTK_WIDGET(header));\n'
            '// Flutter GL view embedded below the header bar\n'
            'auto* gl_area = flutter::FlutterView::CreateGLArea();\n'
            'gtk_container_add(GTK_CONTAINER(window), gl_area);',
          ),
          const SizedBox(height: 8),
          const Text(
            'The Flutter engine embeds a GtkGLArea (or GtkFixed for Wayland surfaces) directly '
            'inside the GtkApplicationWindow. The header bar is a separate native widget, not '
            'rendered by Flutter — this creates the visual split between native chrome and '
            'Flutter content.',
            style: TextStyle(fontSize: 12, color: _kInk, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildSsdDetail() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('SSD Activation'),
          _CodeBlock(
            '// Disable CSD, let WM draw frame\n'
            'gtk_window_set_decorated(GTK_WINDOW(window), TRUE);\n'
            '// Remove any custom header bar\n'
            'gtk_window_set_titlebar(GTK_WINDOW(window), NULL);\n'
            '\n'
            '// From Dart via platform channel:\n'
            '// (no direct public API — set via launch flag or engine patch)\n'
            '// flutter run --dart-define=FLUTTER_LINUX_SSD=true',
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionGuide() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('When to Use Each'),
          const SizedBox(height: 6),
          _DecisionRow(Icons.check_circle_outline, _kOk, 'Use CSD',
              'Building a GNOME-targeted app, need custom title bar widgets, using libadwaita aesthetic'),
          const SizedBox(height: 6),
          _DecisionRow(Icons.check_circle_outline, _kBlue, 'Use SSD',
              'Cross-desktop app that must look native on KDE/XFCE/Cinnamon, or when targeting older GTK2 toolkits'),
          const SizedBox(height: 6),
          _DecisionRow(Icons.warning_amber_outlined, _kAmber, 'Mixed',
              'Wayland compositors may override; some window managers ignore gtk_window_set_titlebar on non-GNOME desktops'),
        ],
      ),
    );
  }

  Widget _buildGtkHeaderBarCode() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Flutter → RegularWindowControllerLinux API sketch'),
          _CodeBlock(
            '// Hypothetical Dart-side API (educational reference)\n'
            'final controller = RegularWindowControllerLinux.of(context);\n'
            '\n'
            '// Window title\n'
            'controller.setTitle("My Flutter App");\n'
            '\n'
            '// Decoration mode\n'
            'controller.setDecorated(true);   // SSD\n'
            'controller.setDecorated(false);  // CSD (app handles chrome)\n'
            '\n'
            '// Geometry\n'
            'controller.setGeometry(Rect.fromLTWH(100, 100, 1280, 720));\n'
            '\n'
            '// Window state\n'
            'controller.maximize();\n'
            'controller.unmaximize();\n'
            'controller.minimize();\n'
            'controller.setFullscreen(true);\n'
            '\n'
            '// Platform surface IDs\n'
            'final int? xid = controller.x11WindowId;    // X11 Window XID\n'
            'final String? wlSurface = controller.waylandSurfaceId;',
          ),
        ],
      ),
    );
  }
}

class _DecorationCard extends StatelessWidget {
  const _DecorationCard({
    required this.title,
    required this.color,
    required this.icon,
    required this.points,
  });
  final String title;
  final Color color;
  final IconData icon;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(70)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...points.map(
            (String p) => Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('• ', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
                  Expanded(
                    child: Text(p, style: const TextStyle(fontSize: 11, color: _kInk)),
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

class _DecisionRow extends StatelessWidget {
  const _DecisionRow(this.icon, this.color, this.label, this.desc);
  final IconData icon;
  final Color color;
  final String label;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
        ),
        Expanded(
          child: Text(desc, style: const TextStyle(fontSize: 11, color: _kInk, height: 1.4)),
        ),
      ],
    );
  }
}

// ===========================================================================
// TAB 6 — D-Bus Integration
// ===========================================================================
class _DbusTab extends StatelessWidget {
  const _DbusTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          'D-Bus Integration',
          subtitle: 'How Flutter communicates with Linux window managers via D-Bus and GTK',
        ),
        const SizedBox(height: 12),
        _buildDbusOverview(),
        const SizedBox(height: 16),
        _buildDbusSessionDiagram(),
        const SizedBox(height: 16),
        _buildDbusPortalSection(),
        const SizedBox(height: 16),
        _buildXdpSection(),
        const SizedBox(height: 16),
        _buildDbusToggle(),
      ],
    );
  }

  Widget _buildDbusOverview() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('D-Bus Architecture'),
          const Text(
            'D-Bus is the IPC backbone of the Linux desktop. Flutter Linux desktop apps communicate '
            'indirectly with the window manager through GTK, which itself uses D-Bus for certain '
            'operations. Direct D-Bus access from Flutter Dart code requires platform channels to the '
            'native side where libdbus or GDBus can be used.',
            style: TextStyle(fontSize: 12, color: _kInk, height: 1.5),
          ),
          const SizedBox(height: 10),
          Row(
            children: const <Widget>[
              _DbusChip('Session Bus'),
              SizedBox(width: 8),
              _DbusChip('org.freedesktop.portal.*'),
              SizedBox(width: 8),
              _DbusChip('GDBus (GTK)'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDbusSessionDiagram() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('D-Bus Message Flow (Dart → WM)'),
          _CodeBlock(
            '// Dart side (platform channel call)\n'
            'const _channel = MethodChannel("com.example/window");\n'
            'await _channel.invokeMethod("inhibitScreensaver", {\n'
            '  "reason": "Video playback in progress",\n'
            '});\n'
            '\n'
            '// C++ Flutter plugin side (GDBus)\n'
            'GDBusProxy* proxy = g_dbus_proxy_new_sync(\n'
            '  connection,\n'
            '  G_DBUS_PROXY_FLAGS_NONE, NULL,\n'
            '  "org.freedesktop.ScreenSaver",\n'
            '  "/org/freedesktop/ScreenSaver",\n'
            '  "org.freedesktop.ScreenSaver",\n'
            '  NULL, NULL);\n'
            'g_dbus_proxy_call_sync(proxy, "Inhibit",\n'
            '  g_variant_new("(ss)", "com.example.app", reason),\n'
            '  G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL);',
          ),
        ],
      ),
    );
  }

  Widget _buildDbusPortalSection() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('XDG Desktop Portals'),
          const Text(
            'Desktop portals (org.freedesktop.portal.*) are the modern, sandboxed interface '
            'for Flutter Linux apps to interact with the desktop environment. They work '
            'through D-Bus on the session bus and are mediated by xdg-desktop-portal.',
            style: TextStyle(fontSize: 12, color: _kInk, height: 1.5),
          ),
          const SizedBox(height: 10),
          _buildPortalTable(),
        ],
      ),
    );
  }

  Widget _buildPortalTable() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      border: TableBorder.all(color: _kBorder, width: 0.5),
      children: <TableRow>[
        _tableHeaderRow(<String>['Portal Interface', 'Purpose']),
        _tableDataRow(<String>['org.freedesktop.portal.FileChooser', 'Native open/save file dialogs']),
        _tableDataRow(<String>['org.freedesktop.portal.Screenshot', 'Screen capture with permission']),
        _tableDataRow(<String>['org.freedesktop.portal.Inhibit', 'Prevent screen saver / sleep']),
        _tableDataRow(<String>['org.freedesktop.portal.Notification', 'Desktop notifications']),
        _tableDataRow(<String>['org.freedesktop.portal.OpenURI', 'Open URLs / files externally']),
        _tableDataRow(<String>['org.freedesktop.portal.Settings', 'Read desktop theme/accent color']),
      ],
    );
  }

  Widget _buildXdpSection() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Window-Manager Specific D-Bus'),
          _CodeBlock(
            '// GNOME Shell extension bus name\n'
            '// org.gnome.Shell\n'
            '// Mutter window management:\n'
            '// org.gnome.Mutter.IdleMonitor\n'
            '// org.gnome.Mutter.DisplayConfig\n'
            '\n'
            '// KWin scripting:\n'
            '// org.kde.KWin\n'
            '// org.kde.KWin.Effect.*\n'
            '\n'
            '// Getting current theme (freedesktop portal):\n'
            'g_dbus_proxy_call_sync(settings_proxy, "Read",\n'
            '  g_variant_new("(ss)",\n'
            '    "org.freedesktop.appearance",\n'
            '    "color-scheme"),\n'
            '  G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL);\n'
            '// Returns: 0=no pref, 1=dark, 2=light',
          ),
        ],
      ),
    );
  }

  Widget _buildDbusToggle() {
    return ValueListenableBuilder<bool>(
      valueListenable: _showDbusDetail,
      builder: (BuildContext ctx, bool show, Widget? _) {
        return _InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Show full D-Bus message trace',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _kInk),
                    ),
                  ),
                  Switch(
                    value: show,
                    onChanged: (bool v) => _showDbusDetail.value = v,
                    activeThumbColor: _kAccentDark,
                  ),
                ],
              ),
              if (show) ...<Widget>[
                const SizedBox(height: 8),
                _CodeBlock(
                  'D-Bus message trace (Inhibit call):\n'
                  '────────────────────────────────────────\n'
                  'Type:        METHOD_CALL\n'
                  'Sender:      :1.842  (Flutter app)\n'
                  'Destination: org.freedesktop.ScreenSaver\n'
                  'Path:        /org/freedesktop/ScreenSaver\n'
                  'Interface:   org.freedesktop.ScreenSaver\n'
                  'Member:      Inhibit\n'
                  'Signature:   ss\n'
                  'Body:        ("com.example.FlutterApp",\n'
                  '              "Video playback")\n'
                  '────────────────────────────────────────\n'
                  'Reply:\n'
                  'Type:        METHOD_RETURN\n'
                  'Sender:      org.freedesktop.ScreenSaver\n'
                  'Body:        (uint32 cookie: 0x2F4A)\n'
                  '  → Store cookie to uninhibit later',
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _DbusChip extends StatelessWidget {
  const _DbusChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _kCode.withAlpha(18),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _kCode.withAlpha(60)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 10,
          color: _kCode,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 7 — Multi-Window
// ===========================================================================
class _MultiWindowTab extends StatelessWidget {
  const _MultiWindowTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          'Multi-Window on Linux',
          subtitle: 'Multiple FlutterView instances, one engine',
        ),
        const SizedBox(height: 12),
        _buildMultiWindowExplainer(),
        const SizedBox(height: 16),
        _buildWindowSelector(),
        const SizedBox(height: 16),
        _buildMultiWindowDiagram(),
        const SizedBox(height: 16),
        _buildMultiWindowCode(),
      ],
    );
  }

  Widget _buildMultiWindowExplainer() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Flutter Multi-View on Linux'),
          const Text(
            'Flutter 3.22+ supports multiple windows (FlutterViews) from a single engine instance '
            'on Linux desktop. Each window has its own RegularWindowControllerLinux, which wraps '
            'a separate GtkApplicationWindow. All views share the same Dart isolate and widget tree, '
            'but render to different native surfaces.',
            style: TextStyle(fontSize: 12, color: _kInk, height: 1.5),
          ),
          const SizedBox(height: 10),
          _buildViewPropertiesRow(),
        ],
      ),
    );
  }

  Widget _buildViewPropertiesRow() {
    return Row(
      children: <Widget>[
        _PropPill('Shared Dart isolate', _kAccentDark),
        const SizedBox(width: 8),
        _PropPill('Separate FlutterView', _kBlue),
        const SizedBox(width: 8),
        _PropPill('Own GtkWindow', const Color(0xFF660077)),
      ],
    );
  }

  Widget _buildWindowSelector() {
    return ValueListenableBuilder<int>(
      valueListenable: _activeWindowIndex,
      builder: (BuildContext ctx, int active, Widget? _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Simulated window switcher:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kInk),
            ),
            const SizedBox(height: 8),
            Row(
              children: List<Widget>.generate(3, (int i) {
                final bool sel = i == active;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => _activeWindowIndex.value = i,
                    child: Container(
                      width: 90,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: sel ? _kAccentDark : _kSurfaceAlt,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sel ? _kAccentDark : _kBorder),
                        boxShadow: sel
                            ? const <BoxShadow>[
                                BoxShadow(color: Color(0x331A5A18), blurRadius: 6, offset: Offset(0, 2)),
                              ]
                            : null,
                      ),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.window,
                            size: 18,
                            color: sel ? Colors.white : _kChrome,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Window ${i + 1}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: sel ? Colors.white : _kInk,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            _buildWindowDetail(active),
          ],
        );
      },
    );
  }

  Widget _buildWindowDetail(int index) {
    final List<Map<String, String>> windowData = <Map<String, String>>[
      <String, String>{
        'title': 'Main Window',
        'view': 'FlutterView(id: 0)',
        'gtk': 'GtkApplicationWindow(0x7f3a2c)',
        'xid': 'XID: 0x04200042',
        'size': '1280 × 720',
        'role': 'Primary window — navigator root',
      },
      <String, String>{
        'title': 'Secondary Panel',
        'view': 'FlutterView(id: 1)',
        'gtk': 'GtkApplicationWindow(0x7f3a44)',
        'xid': 'XID: 0x04200058',
        'size': '480 × 720',
        'role': 'Tool panel — shares same isolate',
      },
      <String, String>{
        'title': 'Floating Overlay',
        'view': 'FlutterView(id: 2)',
        'gtk': 'GtkApplicationWindow(0x7f3a60)',
        'xid': 'XID: 0x0420006C',
        'size': '320 × 200',
        'role': 'Notification overlay — always on top',
      },
    ];
    final Map<String, String> d = windowData[index];
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            d['title']!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kAccentDark),
          ),
          const SizedBox(height: 8),
          _KVRow('FlutterView', d['view']!),
          _KVRow('GTK handle', d['gtk']!),
          _KVRow('X11 identifier', d['xid']!),
          _KVRow('Size', d['size']!),
          _KVRow('Role', d['role']!),
        ],
      ),
    );
  }

  Widget _buildMultiWindowDiagram() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Multi-Window Architecture'),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: _MultiWindowPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiWindowCode() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Multi-Window Dart API (Flutter 3.22+)'),
          _CodeBlock(
            '// Open a new Flutter window on Linux\n'
            'final FlutterView secondView = await\n'
            '    WidgetsBinding.instance.createView(\n'
            '      const ViewConfiguration(\n'
            '        size: Size(800, 600),\n'
            '        devicePixelRatio: 1.0,\n'
            '      ),\n'
            '    );\n'
            '\n'
            '// Render a widget tree into the new view\n'
            'runWidget(\n'
            '  View(view: secondView, child: const MySecondWindow()),\n'
            ');\n'
            '\n'
            '// Access the Linux controller for the new view\n'
            'final ctrl = RegularWindowControllerLinux.of(secondView);\n'
            'ctrl?.setTitle("My Second Window");\n'
            'ctrl?.setGeometry(Rect.fromLTWH(200, 100, 800, 600));',
          ),
        ],
      ),
    );
  }
}

class _PropPill extends StatelessWidget {
  const _PropPill(this.label, this.color);
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(18),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withAlpha(70)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color),
      ),
    );
  }
}

class _KVRow extends StatelessWidget {
  const _KVRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _kAccentDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: _kInk),
            ),
          ),
        ],
      ),
    );
  }
}

class _MultiWindowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    void labeledBox(double x, double y, double bw, double bh, String label, Color col) {
      final Rect r = Rect.fromLTWH(x, y, bw, bh);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(6));
      canvas.drawRRect(rr, Paint()..color = col.withAlpha(22));
      canvas.drawRRect(rr, Paint()..color = col..style = PaintingStyle.stroke..strokeWidth = 1.2);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(color: col, fontSize: 9, fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout(maxWidth: bw - 8);
      tp.paint(canvas, Offset(x + (bw - tp.width) / 2, y + (bh - tp.height) / 2));
    }

    void line(Offset a, Offset b) {
      canvas.drawLine(a, b, Paint()..color = _kBorder..strokeWidth = 1);
    }

    // Dart isolate box
    labeledBox(w * 0.1, h * 0.05, w * 0.8, h * 0.2, 'Dart Isolate\n(Single Flutter Engine)', _kAccentDark);

    // Three controllers
    labeledBox(0, h * 0.45, w * 0.28, h * 0.18, 'RWC\nLinux #0', _kAccentDark);
    labeledBox(w * 0.36, h * 0.45, w * 0.28, h * 0.18, 'RWC\nLinux #1', _kAccentDark);
    labeledBox(w * 0.72, h * 0.45, w * 0.28, h * 0.18, 'RWC\nLinux #2', _kAccentDark);

    // GTK boxes
    labeledBox(0, h * 0.75, w * 0.28, h * 0.18, 'GtkWindow #0', const Color(0xFF660077));
    labeledBox(w * 0.36, h * 0.75, w * 0.28, h * 0.18, 'GtkWindow #1', const Color(0xFF660077));
    labeledBox(w * 0.72, h * 0.75, w * 0.28, h * 0.18, 'GtkWindow #2', const Color(0xFF660077));

    // Lines from isolate to controllers
    line(Offset(w * 0.14, h * 0.25), Offset(w * 0.14, h * 0.45));
    line(Offset(w * 0.5, h * 0.25), Offset(w * 0.5, h * 0.45));
    line(Offset(w * 0.86, h * 0.25), Offset(w * 0.86, h * 0.45));

    // Lines from controllers to GTK windows
    line(Offset(w * 0.14, h * 0.63), Offset(w * 0.14, h * 0.75));
    line(Offset(w * 0.5, h * 0.63), Offset(w * 0.5, h * 0.75));
    line(Offset(w * 0.86, h * 0.63), Offset(w * 0.86, h * 0.75));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ===========================================================================
// TAB 8 — WM Comparison
// ===========================================================================
class _WmCompareTab extends StatelessWidget {
  const _WmCompareTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          'GNOME vs KDE vs Weston',
          subtitle: 'Window manager behavior differences for Flutter apps',
        ),
        const SizedBox(height: 12),
        _buildWmSelector(),
        const SizedBox(height: 16),
        _buildWmDetailCard(),
        const SizedBox(height: 16),
        _buildComparisonTable(),
        const SizedBox(height: 16),
        _buildWmFeatureMatrix(),
      ],
    );
  }

  Widget _buildWmSelector() {
    return ValueListenableBuilder<_WmType>(
      valueListenable: _activeWm,
      builder: (BuildContext ctx, _WmType wm, Widget? _) {
        return Row(
          children: _WmType.values.map((_WmType type) {
            final bool sel = type == wm;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => _activeWm.value = type,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: sel ? _wmColor(type) : _kSurfaceAlt,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: sel ? _wmColor(type) : _kBorder),
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(_wmIcon(type), size: 22, color: sel ? Colors.white : _kChrome),
                        const SizedBox(height: 4),
                        Text(
                          _wmLabel(type),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: sel ? Colors.white : _kInk,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildWmDetailCard() {
    return ValueListenableBuilder<_WmType>(
      valueListenable: _activeWm,
      builder: (BuildContext ctx, _WmType wm, Widget? _) {
        final Color col = _wmColor(wm);
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: col.withAlpha(14),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: col.withAlpha(70)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(_wmIcon(wm), color: col, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    _wmFullName(wm),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: col),
                  ),
                  const Spacer(),
                  _LabelBadge(_wmProtocol(wm), color: col),
                ],
              ),
              const SizedBox(height: 10),
              Text(_wmDesc(wm), style: const TextStyle(fontSize: 12, color: _kInk, height: 1.5)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: _wmTraits(wm).map((String t) => _LabelBadge(t, color: col)).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildComparisonTable() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Side-by-Side Comparison'),
          const SizedBox(height: 8),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.5),
            },
            border: TableBorder.all(color: _kBorder, width: 0.5),
            children: <TableRow>[
              _tableHeaderRow(<String>['Feature', 'GNOME / Mutter', 'KDE / KWin', 'Weston']),
              _tableDataRow(<String>['Protocol', 'Wayland + XWayland', 'Wayland + X11', 'Wayland only']),
              _tableDataRow(<String>['Decoration', 'CSD preferred', 'SSD preferred', 'CSD only']),
              _tableDataRow(<String>['Tiling', 'Manual/extension', 'Built-in (KWin)', 'None']),
              _tableDataRow(<String>['HiDPI', 'Fractional (1.25×)', 'Fractional scaling', 'Integer only']),
              _tableDataRow(<String>['Animations', 'Mutter effects', 'KWin effects', 'Minimal']),
              _tableDataRow(<String>['D-Bus WM API', 'org.gnome.*', 'org.kde.*', 'Limited']),
              _tableDataRow(<String>['Snap/Flatpak', 'Full support', 'Full support', 'Partial']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWmFeatureMatrix() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Flutter App Behavior Matrix'),
          const SizedBox(height: 8),
          _FeatureMatrixRow('Window maximize', true, true, true),
          _FeatureMatrixRow('Window minimize', true, true, true),
          _FeatureMatrixRow('Fullscreen', true, true, true),
          _FeatureMatrixRow('Custom titlebar CSD', true, false, true),
          _FeatureMatrixRow('Native file chooser portal', true, true, false),
          _FeatureMatrixRow('Fractional HiDPI scaling', true, true, false),
          _FeatureMatrixRow('Window snapping shortcuts', true, true, false),
          _FeatureMatrixRow('Always-on-top hint', true, true, true),
          _FeatureMatrixRow('Minimize to tray', false, true, false),
        ],
      ),
    );
  }

  Color _wmColor(_WmType wm) {
    switch (wm) {
      case _WmType.gnome: return _kAccentDark;
      case _WmType.kde: return _kBlue;
      case _WmType.weston: return const Color(0xFF664400);
    }
  }

  IconData _wmIcon(_WmType wm) {
    switch (wm) {
      case _WmType.gnome: return Icons.desktop_mac_outlined;
      case _WmType.kde: return Icons.desktop_windows_outlined;
      case _WmType.weston: return Icons.computer_outlined;
    }
  }

  String _wmLabel(_WmType wm) {
    switch (wm) {
      case _WmType.gnome: return 'GNOME';
      case _WmType.kde: return 'KDE';
      case _WmType.weston: return 'Weston';
    }
  }

  String _wmFullName(_WmType wm) {
    switch (wm) {
      case _WmType.gnome: return 'GNOME Shell + Mutter';
      case _WmType.kde: return 'KDE Plasma + KWin';
      case _WmType.weston: return 'Weston (Reference Compositor)';
    }
  }

  String _wmProtocol(_WmType wm) {
    switch (wm) {
      case _WmType.gnome: return 'Wayland + XWayland';
      case _WmType.kde: return 'Wayland + X11';
      case _WmType.weston: return 'Wayland only';
    }
  }

  String _wmDesc(_WmType wm) {
    switch (wm) {
      case _WmType.gnome:
        return 'GNOME Shell uses Mutter as its compositing window manager. Flutter apps run well under GNOME '
            'on both X11 and Wayland. CSD (client-side decorations via GtkHeaderBar) is the GNOME default. '
            'Fractional scaling (e.g. 125%) is supported via xdg-output protocol.';
      case _WmType.kde:
        return 'KDE Plasma uses KWin, which supports both Wayland and X11. KWin prefers server-side decorations. '
            'Flutter\'s CSD headers may look inconsistent without explicit Breeze theming. '
            'KWin has powerful scripting via D-Bus (org.kde.KWin.*).';
      case _WmType.weston:
        return 'Weston is the Wayland reference compositor, used for testing and embedded systems. '
            'It only supports Wayland (no X11 XWayland by default). Flutter apps work but no '
            'SSD decoration support — apps must draw their own chrome. Minimal desktop integration.';
    }
  }

  List<String> _wmTraits(_WmType wm) {
    switch (wm) {
      case _WmType.gnome:
        return <String>['libadwaita', 'Mutter compositor', 'xdg-toplevel', 'GSD plugins', 'GNOME extensions'];
      case _WmType.kde:
        return <String>['Plasma widgets', 'KWin scripts', 'Breeze theme', 'KIO integration', 'systemd scope'];
      case _WmType.weston:
        return <String>['Reference impl', 'Minimal IPC', 'No XWayland', 'Embedded use', 'Libinput'];
    }
  }
}

class _FeatureMatrixRow extends StatelessWidget {
  const _FeatureMatrixRow(this.feature, this.gnome, this.kde, this.weston);
  final String feature;
  final bool gnome;
  final bool kde;
  final bool weston;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(feature, style: const TextStyle(fontSize: 11, color: _kInk)),
          ),
          _StatusDot(gnome),
          const SizedBox(width: 22),
          _StatusDot(kde),
          const SizedBox(width: 22),
          _StatusDot(weston),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot(this.ok);
  final bool ok;

  @override
  Widget build(BuildContext context) {
    return Icon(
      ok ? Icons.check_circle : Icons.cancel,
      size: 14,
      color: ok ? _kOk : _kBad,
    );
  }
}

// ===========================================================================
// TAB 9 — Pitfalls & API Cheat Sheet
// ===========================================================================
class _PitfallsApiTab extends StatelessWidget {
  const _PitfallsApiTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          'Pitfalls, Gotchas & API Reference',
          subtitle: 'Linux-specific issues and controller API cheat sheet',
        ),
        const SizedBox(height: 12),
        _buildPitfallsList(),
        const SizedBox(height: 16),
        _buildWaylandVsX11Pitfalls(),
        const SizedBox(height: 16),
        _buildSandboxPitfalls(),
        const SizedBox(height: 16),
        _buildApiCheatSheet(),
        const SizedBox(height: 16),
        _buildHiDpiSection(),
        const SizedBox(height: 16),
        _buildSummaryCard(),
      ],
    );
  }

  Widget _buildPitfallsList() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Common Linux Desktop Pitfalls'),
          const SizedBox(height: 6),
          _PitfallCard(
            icon: Icons.warning_amber,
            color: _kAmber,
            title: 'Linux-only APIs',
            body: 'RegularWindowControllerLinux is a Linux-only class. Always guard usage with '
                '`Platform.isLinux` or use the abstract RegularWindowController interface to keep '
                'code portable across macOS/Windows.',
          ),
          const SizedBox(height: 8),
          _PitfallCard(
            icon: Icons.bug_report_outlined,
            color: _kBad,
            title: 'X11 XID vs Wayland surface',
            body: 'x11WindowId returns null under Wayland. waylandSurfaceId returns null under X11. '
                'Always check which backend is active before using surface identifiers for native '
                'window operations (e.g., passing to external window embedding APIs).',
          ),
          const SizedBox(height: 8),
          _PitfallCard(
            icon: Icons.layers_outlined,
            color: _kBlue,
            title: 'Decoration flicker on GNOME',
            body: 'CSD decoration can flicker on first render if the GtkHeaderBar is configured after '
                'the window is shown. Always configure decorations before calling gtk_widget_show_all().',
          ),
          const SizedBox(height: 8),
          _PitfallCard(
            icon: Icons.zoom_out_map,
            color: _kRed,
            title: 'Fractional HiDPI and pixel snapping',
            body: 'At 125% scaling, flutter renders at logical scale but GTK rounds window geometry to '
                'physical pixels. This can cause 1px misalignments in window borders. Use '
                'GDK_SCALE + GDK_DPI_SCALE to control the rendering scale precisely.',
          ),
        ],
      ),
    );
  }

  Widget _buildWaylandVsX11Pitfalls() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Wayland vs X11 Differences'),
          const SizedBox(height: 8),
          _CodeBlock(
            '// Check which backend is active\n'
            'import "dart:io";\n'
            'final bool isWayland =\n'
            '    Platform.environment["WAYLAND_DISPLAY"] != null;\n'
            'final bool isX11 =\n'
            '    Platform.environment["DISPLAY"] != null && !isWayland;\n'
            '\n'
            '// Behavior differences:\n'
            '// X11:     window position is absolute screen coordinates\n'
            '// Wayland: compositor controls position (app requests only)\n'
            '//\n'
            '// X11:     global keyboard shortcuts always work\n'
            '// Wayland: shortcuts require compositor permission (xdg-portal)\n'
            '//\n'
            '// X11:     window.setPosition(x, y) reliable\n'
            '// Wayland: position hints may be ignored by compositor',
          ),
          const SizedBox(height: 10),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
            },
            border: TableBorder.all(color: _kBorder, width: 0.5),
            children: <TableRow>[
              _tableHeaderRow(<String>['Capability', 'X11', 'Wayland']),
              _tableDataRow(<String>['Window positioning', 'Exact (setPosition)', 'Hint only']),
              _tableDataRow(<String>['Global hotkeys', 'Always work', 'Portal required']),
              _tableDataRow(<String>['Screenshot', 'Direct capture', 'Portal mediated']),
              _tableDataRow(<String>['XID access', 'Always available', 'N/A (wl_surface)']),
              _tableDataRow(<String>['Popup placement', 'Explicit coords', 'xdg-positioner']),
              _tableDataRow(<String>['Clipboard access', 'Direct Xlib', 'wl-clipboard proto']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSandboxPitfalls() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Snap & Flatpak Restrictions'),
          const SizedBox(height: 6),
          _PitfallCard(
            icon: Icons.lock_outline,
            color: const Color(0xFF665500),
            title: 'Flatpak filesystem isolation',
            body: 'Flatpak sandboxes restrict file system access. Use the '
                'org.freedesktop.portal.FileChooser portal for file picking. '
                'Direct access to /home or /run/user is limited by the sandbox policy.',
          ),
          const SizedBox(height: 8),
          _PitfallCard(
            icon: Icons.security_outlined,
            color: const Color(0xFF665500),
            title: 'Snap confinement and D-Bus',
            body: 'Snap packages in strict confinement cannot send arbitrary D-Bus messages. '
                'The snap interface "desktop" provides limited access to xdg-desktop-portal. '
                'Window manager APIs via org.gnome.Shell or org.kde.KWin are typically blocked.',
          ),
          const SizedBox(height: 8),
          _PitfallCard(
            icon: Icons.devices_other_outlined,
            color: _kBlue,
            title: 'Wayland socket access in containers',
            body: 'If running Flutter in a container (Docker, systemd-nspawn), ensure '
                'WAYLAND_DISPLAY is set and the socket is bind-mounted. Without --device wayland, '
                'the GTK backend cannot connect and falls back to X11 (if available).',
          ),
        ],
      ),
    );
  }

  Widget _buildApiCheatSheet() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            'RegularWindowControllerLinux API Reference',
            subtitle: 'Educational reference — adapt to actual platform channel API',
          ),
          const SizedBox(height: 8),
          _CodeBlock(
            '// ─── Title and icon ────────────────────────────────────\n'
            'controller.setTitle(String title);\n'
            'controller.setIcon(Uint8List pngBytes);\n'
            '\n'
            '// ─── Window geometry ────────────────────────────────────\n'
            'controller.setGeometry(Rect rect);\n'
            'controller.setMinSize(Size min);\n'
            'controller.setMaxSize(Size max);\n'
            'controller.setResizable(bool resizable);\n'
            '\n'
            '// ─── Window state ────────────────────────────────────────\n'
            'controller.maximize();\n'
            'controller.unmaximize();\n'
            'controller.minimize();\n'
            'controller.restore();             // from minimized\n'
            'controller.setFullscreen(bool);\n'
            'Future<bool> controller.isMaximized();\n'
            'Future<bool> controller.isFullscreen();\n'
            '\n'
            '// ─── Decorations ─────────────────────────────────────────\n'
            'controller.setDecorated(bool);    // SSD on/off\n'
            'controller.setHeaderBarVisible(bool);   // CSD header\n'
            '\n'
            '// ─── Linux-specific ──────────────────────────────────────\n'
            'int? controller.x11WindowId;      // X11 XID (null on Wayland)\n'
            'String? controller.waylandSurfaceId;   // null on X11\n'
            'String controller.gdkBackend;     // "x11" | "wayland" | "mir"\n'
            'String controller.gtkVersion;     // e.g. "4.12.3"\n'
            '\n'
            '// ─── Focus and z-order ───────────────────────────────────\n'
            'controller.requestFocus();\n'
            'controller.setAlwaysOnTop(bool);\n'
            'controller.setAlwaysOnBottom(bool);\n'
            '\n'
            '// ─── Events ──────────────────────────────────────────────\n'
            'Stream<WindowStateChange> controller.onStateChanged;\n'
            'Stream<Rect> controller.onGeometryChanged;\n'
            'Stream<bool> controller.onFocusChanged;',
          ),
        ],
      ),
    );
  }

  Widget _buildHiDpiSection() {
    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('HiDPI and Scaling on Linux'),
          const SizedBox(height: 8),
          _buildScalingTable(),
          const SizedBox(height: 10),
          _CodeBlock(
            '// Query device pixel ratio from Flutter\n'
            'final double dpr =\n'
            '    View.of(context).devicePixelRatio;\n'
            '\n'
            '// Environment variables affecting GTK scaling\n'
            '// GDK_SCALE=2          → integer 2x scale\n'
            '// GDK_DPI_SCALE=1.25   → fractional 1.25x DPI\n'
            '// FLUTTER_DPI=192      → override Flutter logical DPI\n'
            '\n'
            '// Mutter fractional scaling (GNOME 40+)\n'
            '// gsettings set org.gnome.mutter\n'
            '//   experimental-features "["scale-monitor-framebuffer"]"\n'
            '// Then: display scale 125% works via xdg-output fractional',
          ),
        ],
      ),
    );
  }

  Widget _buildScalingTable() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: _kBorder, width: 0.5),
      children: <TableRow>[
        _tableHeaderRow(<String>['Scale', 'GDK_SCALE', 'Flutter devicePixelRatio']),
        _tableDataRow(<String>['100%', '1', '1.0']),
        _tableDataRow(<String>['125%', '1 + DPI', '1.25 (fractional)']),
        _tableDataRow(<String>['150%', '1 + DPI', '1.5 (fractional)']),
        _tableDataRow(<String>['200%', '2', '2.0']),
        _tableDataRow(<String>['300%', '3', '3.0']),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_kAccentDark, Color(0xFF1A4A17)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Key Takeaways',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          _SummaryBullet('RegularWindowControllerLinux wraps a GtkApplicationWindow per FlutterView'),
          _SummaryBullet('CSD (GtkHeaderBar) is the GNOME default; SSD needed for KDE parity'),
          _SummaryBullet('D-Bus portals are the safe cross-WM / cross-sandbox IPC path'),
          _SummaryBullet('Wayland restricts window positioning — design around compositor control'),
          _SummaryBullet('Multi-window (Flutter 3.22+) shares one Dart isolate across all views'),
          _SummaryBullet('Always guard Linux-specific code with Platform.isLinux checks'),
          _SummaryBullet('HiDPI fractional scaling requires GNOME experimental or integer GDK_SCALE'),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
                const SizedBox(height: 3),
                Text(body, style: const TextStyle(fontSize: 11, color: _kInk, height: 1.45)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryBullet extends StatelessWidget {
  const _SummaryBullet(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('→  ', style: TextStyle(color: Color(0xFF9FFFAF), fontSize: 12, fontWeight: FontWeight.w700)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFFDDEEDD), fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

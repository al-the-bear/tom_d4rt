import 'package:flutter/material.dart';

const Color _kSurface = Color(0xFF0E1420);
const Color _kPanel = Color(0xFF1A2437);
const Color _kPanelSoft = Color(0xFF212F47);
const Color _kInk = Color(0xFFE7ECFF);
const Color _kMuted = Color(0xFF9AAACF);
const Color _kAccent = Color(0xFF76C7FF);
const Color _kAccentAlt = Color(0xFF8EF2CF);
const Color _kWarn = Color(0xFFFFB86C);
const Color _kDanger = Color(0xFFFF7A90);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kSurface,
      colorScheme: const ColorScheme.dark(
        primary: _kAccent,
        secondary: _kAccentAlt,
        surface: _kPanel,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: _kInk,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    ),
    home: const _WindowingOwnerWin32Demo(),
  );
}

class _WindowingOwnerWin32Demo extends StatefulWidget {
  const _WindowingOwnerWin32Demo();

  @override
  State<_WindowingOwnerWin32Demo> createState() =>
      _WindowingOwnerWin32DemoState();
}

enum _WindowDisplayState {
  restored,
  minimized,
  maximized,
  snappedLeft,
  snappedRight,
  fullscreen,
}

class _Win32Message {
  const _Win32Message({
    required this.code,
    required this.title,
    required this.detail,
  });

  final String code;
  final String title;
  final String detail;
}

class _WindowingOwnerWin32DemoState extends State<_WindowingOwnerWin32Demo>
    with TickerProviderStateMixin {
  late final TabController _tabs;
  int _selectedUseCase = 0;

  bool _showShadow = true;
  bool _allowResize = true;
  bool _alwaysOnTop = false;
  bool _showInTaskbar = true;
  bool _titleBarDark = true;
  bool _snapAssist = true;

  double _dpiScale = 1.25;
  double _windowWidth = 920;
  double _windowHeight = 580;
  double _cornerRadius = 10;
  int _zOrder = 3;

  _WindowDisplayState _state = _WindowDisplayState.restored;
  final List<_Win32Message> _messages = <_Win32Message>[];
  String _focusPane = 'Editor';

  final List<String> _panes = <String>['Explorer', 'Editor', 'Console', 'Tools'];
  final List<String> _useCases = <String>[
    'Floating Tool Window',
    'Modal Preferences Dialog',
    'Docked Utility Panel',
    'Multi-Document Workspace',
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
    _seedMessageFlow();
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  void _seedMessageFlow() {
    _messages
      ..clear()
      ..addAll(const <_Win32Message>[
        _Win32Message(
          code: 'WM_CREATE',
          title: 'Create HWND',
          detail: 'WindowingOwnerWin32 provisions native handle and shell metadata.',
        ),
        _Win32Message(
          code: 'WM_DPICHANGED',
          title: 'DPI Negotiation',
          detail: 'Owner recalculates logical size when monitor scale changes.',
        ),
        _Win32Message(
          code: 'WM_SIZE',
          title: 'Client Resize',
          detail: 'Resize event updates viewport metrics and hit-test bounds.',
        ),
      ]);
  }

  void _pushMessage(String code, String title, String detail) {
    setState(() {
      _messages.insert(
        0,
        _Win32Message(code: code, title: title, detail: detail),
      );
      if (_messages.length > 12) {
        _messages.removeLast();
      }
    });
  }

  void _setDisplayState(_WindowDisplayState state) {
    setState(() {
      _state = state;
      switch (state) {
        case _WindowDisplayState.restored:
          _windowWidth = 920;
          _windowHeight = 580;
        case _WindowDisplayState.minimized:
          _windowWidth = 460;
          _windowHeight = 76;
        case _WindowDisplayState.maximized:
          _windowWidth = 1080;
          _windowHeight = 680;
        case _WindowDisplayState.snappedLeft:
        case _WindowDisplayState.snappedRight:
          _windowWidth = 620;
          _windowHeight = 680;
        case _WindowDisplayState.fullscreen:
          _windowWidth = 1180;
          _windowHeight = 720;
      }
      _pushMessage(
        'WM_WINDOWPOSCHANGED',
        'Window State: ${state.name}',
        'Simulates owner-managed transition to ${state.name} layout.',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _kPanel,
        title: const Text('WindowingOwnerWin32 Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          labelColor: _kInk,
          unselectedLabelColor: _kMuted,
          indicatorColor: _kAccent,
          tabs: const <Tab>[
            Tab(text: 'Overview'),
            Tab(text: 'Style Studio'),
            Tab(text: 'Message Pump'),
            Tab(text: 'Use Cases'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: <Widget>[
          _buildOverviewTab(),
          _buildStyleStudioTab(),
          _buildMessagePumpTab(),
          _buildUseCasesTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _headlineCard(
          title: 'What WindowingOwnerWin32 Represents',
          body:
              'WindowingOwnerWin32 is an internal bridge between Flutter window state '
              'and native Win32 behavior. In practice, it owns platform window lifecycle '
              'tasks: handle creation, resize transitions, DPI updates, focus routing, '
              'and shell integration.',
          accent: _kAccent,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const <Widget>[
            _CapabilityPill(label: 'HWND Lifecycle', color: _kAccent),
            _CapabilityPill(label: 'Taskbar Presence', color: _kAccentAlt),
            _CapabilityPill(label: 'Snap Layout Integration', color: _kWarn),
            _CapabilityPill(label: 'Per-Monitor DPI', color: _kDanger),
            _CapabilityPill(label: 'Window State Sync', color: _kAccent),
            _CapabilityPill(label: 'Z-Order Semantics', color: _kAccentAlt),
          ],
        ),
        const SizedBox(height: 16),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Ownership Timeline',
                style: TextStyle(
                  color: _kInk,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              _timelineEntry(
                label: '1. Bootstrap',
                detail: 'Owner requests native window creation and registers callbacks.',
                color: _kAccent,
              ),
              _timelineEntry(
                label: '2. Configuration',
                detail: 'Applies style flags: resize, taskbar visibility, shadow, topmost.',
                color: _kAccentAlt,
              ),
              _timelineEntry(
                label: '3. Runtime',
                detail: 'Processes Win32 messages and propagates metrics into Flutter view.',
                color: _kWarn,
              ),
              _timelineEntry(
                label: '4. Teardown',
                detail: 'Releases native resources and flushes message listeners safely.',
                color: _kDanger,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Cross-Platform Perspective',
                style: TextStyle(
                  color: _kInk,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: const <Widget>[
                  Expanded(
                    child: _PlatformCard(
                      title: 'Windows',
                      subtitle: 'WindowingOwnerWin32',
                      bullets: <String>[
                        'HWND + Win32 message pump',
                        'Snap and taskbar interactions',
                        'DWM visual behavior',
                      ],
                      tone: _kAccent,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _PlatformCard(
                      title: 'Linux',
                      subtitle: 'WindowingOwnerLinux',
                      bullets: <String>[
                        'X11/Wayland bridge concerns',
                        'Window manager conventions',
                        'Desktop environment variance',
                      ],
                      tone: _kAccentAlt,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _PlatformCard(
                      title: 'macOS',
                      subtitle: 'WindowingOwnerMacOS',
                      bullets: <String>[
                        'NSWindow ownership path',
                        'Traffic lights and titlebar style',
                        'Spaces and full-screen semantics',
                      ],
                      tone: _kWarn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Live Window Preview',
                style: TextStyle(
                  color: _kInk,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              _windowPreview(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStyleStudioTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _headlineCard(
          title: 'Win32 Style and Behavior Studio',
          body:
              'This panel demonstrates how a Win32 owner composes behavior. Toggle '
              'traits and observe the preview surface, event stream, and capability panel. '
              'It mirrors the practical thought process behind window ownership on desktop.',
          accent: _kAccentAlt,
        ),
        const SizedBox(height: 14),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Feature Switchboard',
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 14,
                runSpacing: 6,
                children: <Widget>[
                  _flagSwitch(
                    label: 'Drop Shadow',
                    value: _showShadow,
                    onChanged: (bool value) {
                      setState(() => _showShadow = value);
                      _pushMessage(
                        'WM_DWMCOMPOSITIONCHANGED',
                        'Shadow ${value ? 'enabled' : 'disabled'}',
                        'Controls DWM-like depth separation for the main window.',
                      );
                    },
                  ),
                  _flagSwitch(
                    label: 'Resizable',
                    value: _allowResize,
                    onChanged: (bool value) {
                      setState(() => _allowResize = value);
                      _pushMessage(
                        'WM_STYLECHANGED',
                        'Resize ${value ? 'enabled' : 'locked'}',
                        'Updates window style bits associated with sizing border.',
                      );
                    },
                  ),
                  _flagSwitch(
                    label: 'Always On Top',
                    value: _alwaysOnTop,
                    onChanged: (bool value) {
                      setState(() => _alwaysOnTop = value);
                      _pushMessage(
                        'WM_WINDOWPOSCHANGED',
                        'Topmost ${value ? 'on' : 'off'}',
                        'Represents HWND_TOPMOST z-order behavior.',
                      );
                    },
                  ),
                  _flagSwitch(
                    label: 'Show In Taskbar',
                    value: _showInTaskbar,
                    onChanged: (bool value) {
                      setState(() => _showInTaskbar = value);
                      _pushMessage(
                        'WM_APP',
                        'Taskbar visibility ${value ? 'on' : 'off'}',
                        'Controls shell presence and app switcher discoverability.',
                      );
                    },
                  ),
                  _flagSwitch(
                    label: 'Dark Title Bar',
                    value: _titleBarDark,
                    onChanged: (bool value) {
                      setState(() => _titleBarDark = value);
                      _pushMessage(
                        'WM_THEMECHANGED',
                        'Title bar ${value ? 'dark' : 'light'}',
                        'Represents non-client area theming updates.',
                      );
                    },
                  ),
                  _flagSwitch(
                    label: 'Snap Assist',
                    value: _snapAssist,
                    onChanged: (bool value) {
                      setState(() => _snapAssist = value);
                      _pushMessage(
                        'WM_NCLBUTTONDOWN',
                        'Snap assist ${value ? 'ready' : 'disabled'}',
                        'Influences drag-to-edge docking assistance.',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Metrics Playground',
                style: TextStyle(color: _kInk, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              _metricSlider(
                label: 'DPI Scale',
                value: _dpiScale,
                min: 1.0,
                max: 2.5,
                divisions: 15,
                trailing: '${(_dpiScale * 100).round()}%',
                onChanged: (double value) => setState(() => _dpiScale = value),
                onChangeEnd: (double value) {
                  _pushMessage(
                    'WM_DPICHANGED',
                    'Scale set to ${(value * 100).round()}%',
                    'Window owner recomputes logical viewport and caption metrics.',
                  );
                },
              ),
              _metricSlider(
                label: 'Window Width',
                value: _windowWidth,
                min: 420,
                max: 1180,
                divisions: 38,
                trailing: '${_windowWidth.round()} px',
                onChanged: (double value) => setState(() => _windowWidth = value),
                onChangeEnd: (double value) {
                  _pushMessage(
                    'WM_SIZE',
                    'Width changed to ${value.round()}',
                    'Demonstrates owner-adjusted client area width.',
                  );
                },
              ),
              _metricSlider(
                label: 'Window Height',
                value: _windowHeight,
                min: 280,
                max: 780,
                divisions: 25,
                trailing: '${_windowHeight.round()} px',
                onChanged: (double value) => setState(() => _windowHeight = value),
                onChangeEnd: (double value) {
                  _pushMessage(
                    'WM_SIZE',
                    'Height changed to ${value.round()}',
                    'Demonstrates owner-adjusted client area height.',
                  );
                },
              ),
              _metricSlider(
                label: 'Corner Radius',
                value: _cornerRadius,
                min: 0,
                max: 24,
                divisions: 12,
                trailing: '${_cornerRadius.round()} px',
                onChanged: (double value) => setState(() => _cornerRadius = value),
                onChangeEnd: (double value) {
                  _pushMessage(
                    'WM_NCPAINT',
                    'Corner style updated',
                    'Represents non-client painting style adjustments.',
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Display State Presets',
                style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _WindowDisplayState.values
                    .map(
                      (_WindowDisplayState value) => ChoiceChip(
                        label: Text(value.name),
                        selected: _state == value,
                        onSelected: (_) => _setDisplayState(value),
                        selectedColor: _kAccent.withValues(alpha: 0.22),
                        backgroundColor: _kPanelSoft,
                        labelStyle: TextStyle(
                          color: _state == value ? _kInk : _kMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
              _windowPreview(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessagePumpTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _headlineCard(
          title: 'Message Pump and Dispatch Simulation',
          body:
              'WindowingOwnerWin32 reacts to native events and reconciles them with '
              'Flutter-side window state. This section makes that flow visible through '
              'interactive dispatch actions and chronological event cards.',
          accent: _kWarn,
        ),
        const SizedBox(height: 14),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Dispatch Console',
                style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _actionButton(
                    icon: Icons.open_in_full,
                    label: 'Resize Burst',
                    onTap: () {
                      _pushMessage(
                        'WM_ENTERSIZEMOVE',
                        'Enter sizing loop',
                        'User starts resize drag from non-client edge.',
                      );
                      _pushMessage(
                        'WM_EXITSIZEMOVE',
                        'Exit sizing loop',
                        'Owner commits final geometry and frame metrics.',
                      );
                    },
                  ),
                  _actionButton(
                    icon: Icons.screen_rotation,
                    label: 'DPI Hop',
                    onTap: () {
                      final double next = _dpiScale < 1.5 ? 2.0 : 1.25;
                      setState(() => _dpiScale = next);
                      _pushMessage(
                        'WM_DPICHANGED',
                        'Monitor transition',
                        'Switched to ${(next * 100).round()}% scale monitor profile.',
                      );
                    },
                  ),
                  _actionButton(
                    icon: Icons.stacked_line_chart,
                    label: 'Z-Order Raise',
                    onTap: () {
                      setState(() => _zOrder += 1);
                      _pushMessage(
                        'WM_WINDOWPOSCHANGING',
                        'Raised z-order to $_zOrder',
                        'Simulates top-level ordering update in shell stack.',
                      );
                    },
                  ),
                  _actionButton(
                    icon: Icons.window,
                    label: 'Toggle Focus Pane',
                    onTap: () {
                      final int current = _panes.indexOf(_focusPane);
                      final int next = (current + 1) % _panes.length;
                      setState(() => _focusPane = _panes[next]);
                      _pushMessage(
                        'WM_SETFOCUS',
                        'Focus moved to $_focusPane',
                        'Owner updates active child region for key routing.',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Message Flow',
                style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 10),
              for (final _Win32Message message in _messages)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _messageCard(message),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Current Runtime Snapshot',
                style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  _kvTile('Display State', _state.name),
                  _kvTile('DPI Scale', '${(_dpiScale * 100).round()}%'),
                  _kvTile('Focus Pane', _focusPane),
                  _kvTile('Z-Order', _zOrder.toString()),
                  _kvTile('Taskbar', _showInTaskbar ? 'visible' : 'hidden'),
                  _kvTile('Topmost', _alwaysOnTop ? 'yes' : 'no'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUseCasesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _headlineCard(
          title: 'Applied Use Cases',
          body:
              'These practical scenes show when Win32 ownership concerns become important '
              'in real desktop tools: floating companions, modal flows, docked panes, and '
              'multi-document orchestration.',
          accent: _kDanger,
        ),
        const SizedBox(height: 14),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Scene Selector',
                style: TextStyle(color: _kInk, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List<Widget>.generate(
                  _useCases.length,
                  (int index) => ChoiceChip(
                    label: Text(_useCases[index]),
                    selected: _selectedUseCase == index,
                    onSelected: (_) {
                      setState(() => _selectedUseCase = index);
                      _pushMessage(
                        'WM_APP',
                        'Scenario switched',
                        _useCases[index],
                      );
                    },
                    selectedColor: _kAccentAlt.withValues(alpha: 0.24),
                    backgroundColor: _kPanelSoft,
                    labelStyle: TextStyle(
                      color: _selectedUseCase == index ? _kInk : _kMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _useCaseView(_selectedUseCase),
            ],
          ),
        ),
      ],
    );
  }

  Widget _useCaseView(int index) {
    switch (index) {
      case 0:
        return _floatingToolWindowScene();
      case 1:
        return _modalDialogScene();
      case 2:
        return _dockedPanelScene();
      case 3:
        return _multiDocumentScene();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _floatingToolWindowScene() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Floating inspector windows often use topmost and taskbar-hidden modes.',
          style: TextStyle(color: _kMuted),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: _miniWindow(
                title: 'Main Studio Window',
                active: true,
                body: 'Hosts the working canvas and timeline.',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: _miniWindow(
                title: 'Inspector (Topmost)',
                active: _alwaysOnTop,
                body: 'Tooling panel follows active selection.',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _modalDialogScene() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Modal flows require focus capture and ordered teardown.',
          style: TextStyle(color: _kMuted),
        ),
        const SizedBox(height: 10),
        _miniWindow(
          title: 'Preferences Dialog',
          active: true,
          body:
              'Window owner tracks parent relationship, blocks background focus, '
              'and returns control after close.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const <Widget>[
            _HintTag('Disable parent hit-testing'),
            _HintTag('Restore previous focused child'),
            _HintTag('Sync min/max constraints'),
          ],
        ),
      ],
    );
  }

  Widget _dockedPanelScene() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Docked utilities mirror snapped and constrained layouts.',
          style: TextStyle(color: _kMuted),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _miniWindow(
                title: 'Workspace',
                active: true,
                body: 'Primary editing surface.',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniWindow(
                title: 'Docked Console',
                active: false,
                body: 'Snapped-right utility panel.',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _multiDocumentScene() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'MDI-like workflows rely on predictable activation and z-order updates.',
          style: TextStyle(color: _kMuted),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.8,
          children: const <Widget>[
            _DocTile(name: 'invoice_editor.dart', status: 'active'),
            _DocTile(name: 'contract_preview.dart', status: 'background'),
            _DocTile(name: 'design_tokens.json', status: 'background'),
            _DocTile(name: 'build_log.txt', status: 'pinned'),
          ],
        ),
      ],
    );
  }

  Widget _windowPreview() {
    final Color bar = _titleBarDark ? const Color(0xFF111723) : const Color(0xFFE4E8F3);
    final Color barText = _titleBarDark ? _kInk : const Color(0xFF24314E);
    final BorderRadius radius = BorderRadius.circular(_cornerRadius);

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        width: _windowWidth * 0.62,
        height: _windowHeight * 0.48,
        decoration: BoxDecoration(
          color: _kPanelSoft,
          borderRadius: radius,
          boxShadow: _showShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.45),
                    blurRadius: 24,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
          border: Border.all(
            color: _alwaysOnTop ? _kWarn : _kAccent.withValues(alpha: 0.35),
            width: _alwaysOnTop ? 1.6 : 1,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 34,
              decoration: BoxDecoration(
                color: bar,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_cornerRadius),
                  topRight: Radius.circular(_cornerRadius),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: _kAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Win32 Host Window (${(_dpiScale * 100).round()}%)',
                    style: TextStyle(
                      color: barText,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.remove, color: barText, size: 16),
                  const SizedBox(width: 8),
                  Icon(Icons.crop_square, color: barText, size: 14),
                  const SizedBox(width: 8),
                  Icon(Icons.close, color: barText, size: 16),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Client Area',
                            style: TextStyle(
                              color: _kInk,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F1A2C),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: _kAccent.withValues(alpha: 0.3)),
                              ),
                              child: Center(
                                child: Text(
                                  'Focused pane: $_focusPane',
                                  style: const TextStyle(color: _kMuted),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 168,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Owner Flags',
                            style: TextStyle(
                              color: _kInk,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _previewFlag('Resizable', _allowResize),
                          _previewFlag('Taskbar', _showInTaskbar),
                          _previewFlag('Topmost', _alwaysOnTop),
                          _previewFlag('Snap Assist', _snapAssist),
                          _previewFlag('Shadow', _showShadow),
                          const Spacer(),
                          Text(
                            'State: ${_state.name}',
                            style: const TextStyle(color: _kWarn, fontSize: 11),
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
    );
  }

  Widget _previewFlag(String label, bool enabled) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: <Widget>[
          Icon(
            enabled ? Icons.check_circle : Icons.remove_circle_outline,
            color: enabled ? _kAccentAlt : _kMuted,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: _kMuted, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _flagSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SizedBox(
      width: 220,
      child: SwitchListTile.adaptive(
        dense: true,
        contentPadding: EdgeInsets.zero,
        value: value,
        onChanged: onChanged,
        title: Text(
          label,
          style: const TextStyle(color: _kInk, fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: _kPanelSoft,
        foregroundColor: _kInk,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }

  Widget _metricSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String trailing,
    required ValueChanged<double> onChanged,
    required ValueChanged<double> onChangeEnd,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                label,
                style: const TextStyle(color: _kInk, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(trailing, style: const TextStyle(color: _kMuted)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
            onChangeEnd: onChangeEnd,
          ),
        ],
      ),
    );
  }

  Widget _messageCard(_Win32Message message) {
    return Container(
      decoration: BoxDecoration(
        color: _kPanelSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kAccent.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: _kAccent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message.code,
              style: const TextStyle(
                color: _kInk,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.title,
                  style: const TextStyle(color: _kInk, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(message.detail, style: const TextStyle(color: _kMuted, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kvTile(String key, String value) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kPanelSoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(key, style: const TextStyle(color: _kMuted, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: _kInk, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _headlineCard({
    required String title,
    required String body,
    required Color accent,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[accent.withValues(alpha: 0.2), _kPanel],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 8),
          Text(body, style: const TextStyle(color: _kMuted, height: 1.4)),
        ],
      ),
    );
  }

  Widget _panel({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: _kPanel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccent.withValues(alpha: 0.15)),
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }

  Widget _timelineEntry({
    required String label,
    required String detail,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(color: _kInk, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(detail, style: const TextStyle(color: _kMuted, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniWindow({
    required String title,
    required bool active,
    required String body,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _kPanelSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: active ? _kAccent : _kAccent.withValues(alpha: 0.25),
          width: active ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: active ? _kAccent.withValues(alpha: 0.16) : _kPanel,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(active ? Icons.radio_button_checked : Icons.circle_outlined,
                    size: 13, color: active ? _kAccentAlt : _kMuted),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: const TextStyle(color: _kInk, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(body, style: const TextStyle(color: _kMuted, height: 1.35)),
          ),
        ],
      ),
    );
  }
}

class _CapabilityPill extends StatelessWidget {
  const _CapabilityPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: _kInk, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _PlatformCard extends StatelessWidget {
  const _PlatformCard({
    required this.title,
    required this.subtitle,
    required this.bullets,
    required this.tone,
  });

  final String title;
  final String subtitle;
  final List<String> bullets;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kPanelSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(color: _kInk, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: tone, fontSize: 12)),
          const SizedBox(height: 8),
          for (final String bullet in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('- ', style: TextStyle(color: _kMuted)),
                  Expanded(
                    child: Text(
                      bullet,
                      style: const TextStyle(color: _kMuted, fontSize: 12),
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

class _HintTag extends StatelessWidget {
  const _HintTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kPanelSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kAccent.withValues(alpha: 0.3)),
      ),
      child: Text(label, style: const TextStyle(color: _kMuted, fontSize: 12)),
    );
  }
}

class _DocTile extends StatelessWidget {
  const _DocTile({required this.name, required this.status});

  final String name;
  final String status;

  @override
  Widget build(BuildContext context) {
    final bool active = status == 'active';
    final bool pinned = status == 'pinned';
    return Container(
      decoration: BoxDecoration(
        color: _kPanelSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: active
              ? _kAccent
              : pinned
                  ? _kWarn
                  : _kAccent.withValues(alpha: 0.22),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                active
                    ? Icons.edit
                    : pinned
                        ? Icons.push_pin
                        : Icons.description,
                size: 15,
                color: active
                    ? _kAccentAlt
                    : pinned
                        ? _kWarn
                        : _kMuted,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _kInk, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'status: $status',
            style: const TextStyle(color: _kMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

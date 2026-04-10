// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RegularWindowControllerWin32  –  Deep Visual Demo
//
//  Palette : Deep Blue 900 / Lime 400
//  Tabs    : Theory · Win32 Simulator · Platform Comparison
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RegularWindowControllerWin32 demo building');
  return _Win32ControllerDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF0D47A1); // Blue 900
const _kAccent = Color(0xFFC0CA33); // Lime 400
const _kSurface = Color(0xFFF1F8E9); // LightGreen 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF1A237E); // Indigo 900
const _kCodeBg = Color(0xFFE8EAF6); // Indigo 50
const _kHighlight = Color(0xFFF0F4C3); // Lime 100
const _kHwndColor = Color(0xFF6A1B9A); // Purple 800
const _kMessageColor = Color(0xFFEF6C00); // Orange 800
const _kDpiColor = Color(0xFF00838F); // Cyan 800
const _kSnapColor = Color(0xFF2E7D32); // Green 800

class _Win32ControllerDemo extends StatefulWidget {
  @override
  State<_Win32ControllerDemo> createState() => _Win32ControllerDemoState();
}

class _Win32ControllerDemoState extends State<_Win32ControllerDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
    print('RegularWindowControllerWin32 demo initialised – 3 tabs');
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: Text('RegularWindowControllerWin32',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kAccent,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(text: 'Theory'),
            Tab(text: 'Win32 Simulator'),
            Tab(text: 'Platform Comparison'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _Win32SimulatorTab(),
          _PlatformComparisonTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 1  –  Theory
// ═══════════════════════════════════════════════════════════

class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverviewCard(),
          SizedBox(height: 14),
          _buildClassHierarchyCard(),
          SizedBox(height: 14),
          _buildWin32ApiCard(),
          SizedBox(height: 14),
          _buildHwndLifecycleCard(),
          SizedBox(height: 14),
          _buildDpiAwarenessCard(),
          SizedBox(height: 14),
          _buildMessageLoopCard(),
          SizedBox(height: 14),
          _buildExperimentalStatusCard(),
        ],
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(color: _kPrimary.withOpacity(0.08), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.window, color: _kPrimary, size: 22),
              SizedBox(width: 8),
              Text('What is RegularWindowControllerWin32?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'RegularWindowControllerWin32 is the Windows-specific implementation of '
            'RegularWindowController. It manages a native Win32 HWND window handle '
            'and translates Flutter window operations into Win32 API calls.',
            style: TextStyle(fontSize: 13, color: _kDarkText, height: 1.5),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: _kMessageColor, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This controller is automatically selected by the framework when '
                    'running on Windows. You never instantiate it directly.',
                    style: TextStyle(fontSize: 12, color: _kDarkText, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          _buildFeatureBullet(Icons.desktop_windows, 'Wraps a native HWND handle'),
          _buildFeatureBullet(Icons.message, 'Processes Win32 message loop'),
          _buildFeatureBullet(Icons.aspect_ratio, 'DPI-aware scaling support'),
          _buildFeatureBullet(Icons.grid_view, 'Aero Snap integration'),
          _buildFeatureBullet(Icons.palette, 'Windows theme integration'),
        ],
      ),
    );
  }

  Widget _buildFeatureBullet(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, color: _kAccent, size: 16),
          SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 12, color: _kDarkText)),
        ],
      ),
    );
  }

  Widget _buildClassHierarchyCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kHwndColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree, color: _kHwndColor, size: 22),
              SizedBox(width: 8),
              Text('Class Hierarchy',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          _buildHierarchyRow(0, 'ChangeNotifier', Colors.grey),
          _buildHierarchyRow(1, 'RegularWindowController', _kPrimary),
          _buildHierarchyRow(2, 'RegularWindowControllerWin32', _kHwndColor),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('// Platform selection in RegularWindowController',
                    style: TextStyle(fontSize: 11, color: Colors.green.shade800, fontFamily: 'monospace')),
                SizedBox(height: 4),
                Text('factory RegularWindowController({\n'
                    '  required WindowingOwner owner,\n'
                    '}) {\n'
                    '  if (Platform.isWindows) {\n'
                    '    return RegularWindowControllerWin32(owner: owner);\n'
                    '  }\n'
                    '  // ... other platforms\n'
                    '}',
                    style: TextStyle(fontSize: 11, color: _kDarkText, fontFamily: 'monospace', height: 1.6)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchyRow(int depth, String name, Color color) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 24.0, bottom: 8),
      child: Row(
        children: [
          if (depth > 0) ...[
            Icon(Icons.subdirectory_arrow_right, color: color.withOpacity(0.5), size: 16),
            SizedBox(width: 4),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color.withOpacity(0.4)),
            ),
            child: Text(name,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color, fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget _buildWin32ApiCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kMessageColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.api, color: _kMessageColor, size: 22),
              SizedBox(width: 8),
              Text('Win32 API Mapping',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          _buildApiRow('setTitle()', 'SetWindowTextW(hwnd, text)', _kPrimary),
          _buildApiRow('activate()', 'SetForegroundWindow(hwnd)', _kSnapColor),
          _buildApiRow('maximize()', 'ShowWindow(hwnd, SW_MAXIMIZE)', _kHwndColor),
          _buildApiRow('minimize()', 'ShowWindow(hwnd, SW_MINIMIZE)', _kDpiColor),
          _buildApiRow('restore()', 'ShowWindow(hwnd, SW_RESTORE)', _kMessageColor),
          _buildApiRow('destroy()', 'DestroyWindow(hwnd)', Colors.red.shade700),
          _buildApiRow('requestSize()', 'SetWindowPos(hwnd, ...)', _kAccent.withAlpha(200)),
        ],
      ),
    );
  }

  Widget _buildApiRow(String flutterApi, String win32Api, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 120,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(flutterApi,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color, fontFamily: 'monospace')),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward, size: 14, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: Text(win32Api,
                style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.8), fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget _buildHwndLifecycleCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kSnapColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: _kSnapColor, size: 22),
              SizedBox(width: 8),
              Text('HWND Lifecycle',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          _buildLifecycleStep(1, 'CreateWindowExW', 'Allocates HWND, registers class', _kSnapColor),
          _buildLifecycleStep(2, 'ShowWindow', 'Makes window visible', _kPrimary),
          _buildLifecycleStep(3, 'Message Loop', 'GetMessage / DispatchMessage cycle', _kMessageColor),
          _buildLifecycleStep(4, 'User Events', 'WM_SIZE, WM_MOVE, WM_ACTIVATE', _kDpiColor),
          _buildLifecycleStep(5, 'WM_CLOSE', 'Delegate decides to accept or reject', _kHwndColor),
          _buildLifecycleStep(6, 'DestroyWindow', 'Releases HWND and GDI resources', Colors.red.shade700),
        ],
      ),
    );
  }

  Widget _buildLifecycleStep(int step, String title, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text('$step',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color, fontFamily: 'monospace')),
                SizedBox(height: 2),
                Text(desc, style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDpiAwarenessCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDpiColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.photo_size_select_large, color: _kDpiColor, size: 22),
              SizedBox(width: 8),
              Text('DPI Awareness Levels',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          _buildDpiLevel('Unaware', '96 DPI always', Colors.red.shade400, 0.25),
          _buildDpiLevel('System DPI', 'Primary monitor only', Colors.orange.shade600, 0.5),
          _buildDpiLevel('Per-Monitor v1', 'Each monitor, no non-client', _kDpiColor, 0.75),
          _buildDpiLevel('Per-Monitor v2', 'Full scaling, recommended', _kSnapColor, 1.0),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Flutter uses Per-Monitor v2 DPI awareness.\n'
              'WM_DPICHANGED → controller updates device pixel ratio\n'
              'and resizes the FlutterView accordingly.',
              style: TextStyle(fontSize: 11, color: _kDarkText, fontFamily: 'monospace', height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDpiLevel(String name, String desc, Color color, double fill) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 130,
                child: Text(name,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
              ),
              Expanded(
                child: Text(desc, style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.7))),
              ),
            ],
          ),
          SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fill,
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageLoopCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.loop, color: _kPrimary, size: 22),
              SizedBox(width: 8),
              Text('Win32 Message Loop Integration',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '// Simplified message pump\n'
              'while (GetMessage(&msg, hwnd, 0, 0)) {\n'
              '  TranslateMessage(&msg);\n'
              '  DispatchMessage(&msg);  // → WndProc\n'
              '}\n\n'
              '// WndProc routes to controller\n'
              'LRESULT WndProc(HWND h, UINT msg, ...) {\n'
              '  switch (msg) {\n'
              '    case WM_SIZE:     updateSize();     break;\n'
              '    case WM_ACTIVATE: updateFocus();    break;\n'
              '    case WM_CLOSE:    askDelegate();    break;\n'
              '    case WM_DESTROY:  cleanup();        break;\n'
              '  }\n'
              '}',
              style: TextStyle(fontSize: 11, color: _kDarkText, fontFamily: 'monospace', height: 1.5),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'The Win32 controller receives window messages through the native '
            'message pump. Each message is translated to the corresponding '
            'RegularWindowController state change and notifies listeners.',
            style: TextStyle(fontSize: 12, color: _kDarkText.withOpacity(0.8), height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildExperimentalStatusCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary.withOpacity(0.06), _kAccent.withOpacity(0.06)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccent.withOpacity(0.4)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.science, color: _kMessageColor, size: 22),
              SizedBox(width: 8),
              Text('Experimental Status',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'RegularWindowControllerWin32 is part of Flutter\'s multi-window '
            'experiment. It is marked @internal and requires the windowing '
            'feature flag. The API may change in future releases.',
            style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.amber.shade800, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Enable with: --enable-windowing runtime flag',
                      style: TextStyle(fontSize: 11, color: Colors.amber.shade900, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Win32 Simulator
// ═══════════════════════════════════════════════════════════

class _Win32SimulatorTab extends StatefulWidget {
  @override
  State<_Win32SimulatorTab> createState() => _Win32SimulatorTabState();
}

class _Win32SimulatorTabState extends State<_Win32SimulatorTab> {
  String _windowTitle = 'My App';
  bool _isActivated = true;
  bool _isMaximized = false;
  bool _isMinimized = false;
  bool _isFullscreen = false;
  double _dpiScale = 1.0;
  final double _windowWidth = 320;
  final double _windowHeight = 200;
  String _snapState = 'none';
  final List<String> _messageLog = [];

  void _logMessage(String msg) {
    setState(() {
      _messageLog.insert(0, msg);
      if (_messageLog.length > 20) _messageLog.removeLast();
    });
    print('Win32 sim: $msg');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSimulatedWindow(),
          SizedBox(height: 14),
          _buildControlPanel(),
          SizedBox(height: 14),
          _buildDpiSlider(),
          SizedBox(height: 14),
          _buildAeroSnapPanel(),
          SizedBox(height: 14),
          _buildMessageLogPanel(),
        ],
      ),
    );
  }

  Widget _buildSimulatedWindow() {
    final double scaledW = _windowWidth * _dpiScale;
    final double scaledH = _windowHeight * _dpiScale;
    final bool visible = !_isMinimized;

    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(color: _kPrimary.withOpacity(0.1), blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.desktop_windows, color: _kPrimary, size: 20),
              SizedBox(width: 8),
              Text('Simulated HWND Window',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _isActivated ? _kSnapColor.withOpacity(0.15) : Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _isActivated ? 'ACTIVE' : 'INACTIVE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _isActivated ? _kSnapColor : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: visible ? 1.0 : 0.2,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                width: _isFullscreen ? 340 : (_isMaximized ? 320 : scaledW.clamp(100, 340)),
                height: _isFullscreen ? 220 : (_isMaximized ? 200 : scaledH.clamp(60, 220)),
                decoration: BoxDecoration(
                  color: _isActivated ? _kPrimary.withOpacity(0.08) : Colors.grey.shade100,
                  borderRadius: _isFullscreen
                      ? BorderRadius.zero
                      : BorderRadius.circular(4),
                  border: _isFullscreen
                      ? null
                      : Border.all(
                          color: _isActivated ? _kPrimary : Colors.grey.shade400,
                          width: 1.5,
                        ),
                ),
                child: Column(
                  children: [
                    // Title bar
                    Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: _isActivated ? _kPrimary : Colors.grey.shade500,
                        borderRadius: _isFullscreen
                            ? BorderRadius.zero
                            : BorderRadius.only(
                                topLeft: Radius.circular(3),
                                topRight: Radius.circular(3),
                              ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _windowTitle,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _buildTitleButton('─', Colors.white70),
                          SizedBox(width: 4),
                          _buildTitleButton('□', Colors.white70),
                          SizedBox(width: 4),
                          _buildTitleButton('×', Colors.red.shade300),
                        ],
                      ),
                    ),
                    // Client area
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isMinimized
                                  ? Icons.minimize
                                  : (_isFullscreen ? Icons.fullscreen : Icons.widgets),
                              color: _kPrimary.withOpacity(0.3),
                              size: 28,
                            ),
                            SizedBox(height: 4),
                            Text(
                              _snapState != 'none'
                                  ? 'Snapped: $_snapState'
                                  : '${scaledW.toInt()}×${scaledH.toInt()} @ ${_dpiScale}x',
                              style: TextStyle(fontSize: 9, color: _kDarkText.withOpacity(0.5)),
                            ),
                          ],
                        ),
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

  Widget _buildTitleButton(String label, Color color) {
    return Container(
      width: 14,
      height: 14,
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(fontSize: 10, color: color, height: 1)),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kSnapColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Window Controls',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
          SizedBox(height: 6),
          Text('Simulates controller.method() → Win32 API calls',
              style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.6))),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildActionChip('setTitle("Hello")', Icons.title, _kPrimary, () {
                setState(() => _windowTitle = 'Hello');
                _logMessage('WM_SETTEXT → "Hello"');
              }),
              _buildActionChip('setTitle("My App")', Icons.title, _kPrimary, () {
                setState(() => _windowTitle = 'My App');
                _logMessage('WM_SETTEXT → "My App"');
              }),
              _buildActionChip('activate()', Icons.flash_on, _kSnapColor, () {
                setState(() => _isActivated = true);
                _logMessage('SetForegroundWindow → focus gained');
              }),
              _buildActionChip('deactivate', Icons.flash_off, Colors.grey, () {
                setState(() => _isActivated = false);
                _logMessage('WM_ACTIVATE(INACTIVE)');
              }),
              _buildActionChip('maximize()', Icons.open_in_full, _kHwndColor, () {
                setState(() {
                  _isMaximized = true;
                  _isMinimized = false;
                  _isFullscreen = false;
                  _snapState = 'none';
                });
                _logMessage('ShowWindow(SW_MAXIMIZE)');
              }),
              _buildActionChip('minimize()', Icons.minimize, _kDpiColor, () {
                setState(() {
                  _isMinimized = true;
                  _isMaximized = false;
                  _isFullscreen = false;
                });
                _logMessage('ShowWindow(SW_MINIMIZE)');
              }),
              _buildActionChip('restore()', Icons.restore, _kMessageColor, () {
                setState(() {
                  _isMaximized = false;
                  _isMinimized = false;
                  _isFullscreen = false;
                  _snapState = 'none';
                });
                _logMessage('ShowWindow(SW_RESTORE)');
              }),
              _buildActionChip('enterFullscreen()', Icons.fullscreen, _kDarkText, () {
                setState(() {
                  _isFullscreen = true;
                  _isMaximized = false;
                  _isMinimized = false;
                  _snapState = 'none';
                });
                _logMessage('Borderless fullscreen mode');
              }),
              _buildActionChip('exitFullscreen()', Icons.fullscreen_exit, Colors.grey.shade600, () {
                setState(() => _isFullscreen = false);
                _logMessage('Restored window borders');
              }),
              _buildActionChip('destroy()', Icons.delete_forever, Colors.red.shade700, () {
                setState(() {
                  _isActivated = false;
                  _isMinimized = true;
                });
                _logMessage('DestroyWindow → HWND released');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            SizedBox(width: 4),
            Text(label,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color, fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }

  Widget _buildDpiSlider() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDpiColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.photo_size_select_large, color: _kDpiColor, size: 20),
              SizedBox(width: 8),
              Text('DPI Scale: ${_dpiScale.toStringAsFixed(1)}x',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
              Spacer(),
              Text('${(96 * _dpiScale).toInt()} DPI',
                  style: TextStyle(fontSize: 11, color: _kDpiColor, fontFamily: 'monospace')),
            ],
          ),
          SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: _kDpiColor,
              inactiveTrackColor: _kDpiColor.withOpacity(0.2),
              thumbColor: _kDpiColor,
              overlayColor: _kDpiColor.withOpacity(0.1),
            ),
            child: Slider(
              value: _dpiScale,
              min: 0.5,
              max: 3.0,
              divisions: 10,
              onChanged: (v) {
                setState(() => _dpiScale = v);
                _logMessage('WM_DPICHANGED → ${(96 * v).toInt()} DPI');
              },
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0.5x (48 DPI)', style: TextStyle(fontSize: 9, color: Colors.grey)),
              Text('1.0x (96 DPI)', style: TextStyle(fontSize: 9, color: Colors.grey)),
              Text('2.0x (192 DPI)', style: TextStyle(fontSize: 9, color: Colors.grey)),
              Text('3.0x (288 DPI)', style: TextStyle(fontSize: 9, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAeroSnapPanel() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kSnapColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.grid_view, color: _kSnapColor, size: 20),
              SizedBox(width: 8),
              Text('Aero Snap Simulation',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 6),
          Text('Windows Aero Snap positions the window via WM_SIZE + WM_MOVE messages.',
              style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.6))),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSnapButton('Left', 'left', Icons.align_horizontal_left)),
              SizedBox(width: 8),
              Expanded(child: _buildSnapButton('Right', 'right', Icons.align_horizontal_right)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildSnapButton('Top-Left', 'top-left', Icons.north_west)),
              SizedBox(width: 8),
              Expanded(child: _buildSnapButton('Top-Right', 'top-right', Icons.north_east)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildSnapButton('Bottom-Left', 'bottom-left', Icons.south_west)),
              SizedBox(width: 8),
              Expanded(child: _buildSnapButton('Bottom-Right', 'bottom-right', Icons.south_east)),
            ],
          ),
          SizedBox(height: 8),
          Center(
            child: _buildSnapButton('Restore (none)', 'none', Icons.fullscreen_exit),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Current snap: $_snapState — Aero Snap sends WM_SIZE with SC_MOVE '
              'to let the controller know the window geometry changed.',
              style: TextStyle(fontSize: 11, color: _kDarkText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSnapButton(String label, String state, IconData icon) {
    final bool selected = _snapState == state;
    return GestureDetector(
      onTap: () {
        setState(() {
          _snapState = state;
          _isMaximized = false;
          _isMinimized = false;
          _isFullscreen = false;
        });
        _logMessage('Aero Snap → $state');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? _kSnapColor.withOpacity(0.15) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? _kSnapColor : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: selected ? _kSnapColor : Colors.grey.shade600),
            SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? _kSnapColor : Colors.grey.shade700,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageLogPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.terminal, color: _kAccent, size: 18),
              SizedBox(width: 8),
              Text('Win32 Message Log',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _kAccent)),
              Spacer(),
              GestureDetector(
                onTap: () => setState(() => _messageLog.clear()),
                child: Text('Clear', style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
              ),
            ],
          ),
          SizedBox(height: 10),
          if (_messageLog.isEmpty)
            Text('No messages yet. Use controls above.',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontStyle: FontStyle.italic))
          else
            ..._messageLog.map((msg) => Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('► ', style: TextStyle(fontSize: 11, color: _kAccent)),
                      Expanded(
                        child: Text(msg,
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade300, fontFamily: 'monospace')),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Platform Comparison
// ═══════════════════════════════════════════════════════════

class _PlatformComparisonTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComparisonHeader(),
          SizedBox(height: 14),
          _buildApiComparisonTable(),
          SizedBox(height: 14),
          _buildWindowManagementComparison(),
          SizedBox(height: 14),
          _buildDpiComparisonCard(),
          SizedBox(height: 14),
          _buildFullscreenComparisonCard(),
          SizedBox(height: 14),
          _buildThemeIntegrationCard(),
          SizedBox(height: 14),
          _buildResourceCleanupCard(),
        ],
      ),
    );
  }

  Widget _buildComparisonHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kPrimary.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Platform Controller Comparison',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
          SizedBox(height: 8),
          Text(
            'Each platform implements RegularWindowController with native APIs. '
            'Win32 uses HWND + message loop, Linux uses GDK/GTK, macOS uses NSWindow.',
            style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildApiComparisonTable() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withOpacity(0.2)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Native API Mapping',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
          SizedBox(height: 12),
          _buildComparisonRow('Window Handle', 'HWND', 'GdkWindow*', 'NSWindow*'),
          _buildComparisonRow('Show Window', 'ShowWindow()', 'gtk_widget_show()', '[win makeKey...]'),
          _buildComparisonRow('Set Title', 'SetWindowTextW()', 'gtk_window_set_title()', '[win setTitle:]'),
          _buildComparisonRow('Resize', 'SetWindowPos()', 'gtk_window_resize()', '[win setFrame:]'),
          _buildComparisonRow('Close', 'DestroyWindow()', 'gtk_window_close()', '[win close]'),
          _buildComparisonRow('Focus', 'SetForeground...()', 'gtk_window_present()', '[win makeKey...]'),
          _buildComparisonRow('Fullscreen', 'Custom borderless', 'gtk_window_fullscreen()', '[win toggle...]'),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String operation, String win32, String linux, String macos) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(operation,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _kDarkText)),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              margin: EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: _kPrimary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(win32,
                  style: TextStyle(fontSize: 9, color: _kPrimary, fontFamily: 'monospace'),
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              margin: EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: _kSnapColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(linux,
                  style: TextStyle(fontSize: 9, color: _kSnapColor, fontFamily: 'monospace'),
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: _kHwndColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(macos,
                  style: TextStyle(fontSize: 9, color: _kHwndColor, fontFamily: 'monospace'),
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWindowManagementComparison() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kMessageColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.compare_arrows, color: _kMessageColor, size: 20),
              SizedBox(width: 8),
              Text('Window Management Models',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          _buildPlatformCard(
            'Win32',
            'Message-based: WndProc + message loop. '
                'RegisterClassW, CreateWindowExW, GetMessage/DispatchMessage cycle. '
                'Very explicit resource management.',
            _kPrimary,
            Icons.desktop_windows,
          ),
          SizedBox(height: 10),
          _buildPlatformCard(
            'Linux (GDK/GTK)',
            'Event-based: GtkWidget signals and GDK events. '
                'g_signal_connect for lifecycle events. GMainLoop drives everything. '
                'Automatic resource cleanup via GObject refcount.',
            _kSnapColor,
            Icons.computer,
          ),
          SizedBox(height: 10),
          _buildPlatformCard(
            'macOS (AppKit)',
            'Delegate-based: NSWindowDelegate protocol methods. '
                'Objective-C runtime, NSRunLoop for events. '
                'ARC handles memory management automatically.',
            _kHwndColor,
            Icons.laptop_mac,
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformCard(String title, String desc, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
                SizedBox(height: 4),
                Text(desc, style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.7), height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDpiComparisonCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDpiColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.display_settings, color: _kDpiColor, size: 20),
              SizedBox(width: 8),
              Text('DPI / Scale Factor Handling',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          _buildDpiPlatformRow('Win32', 'WM_DPICHANGED message',
              'SetProcessDpiAwarenessContext(PER_MONITOR_AWARE_V2)', _kPrimary),
          SizedBox(height: 8),
          _buildDpiPlatformRow('Linux', 'GDK scale-factor property',
              'gdk_monitor_get_scale_factor()', _kSnapColor),
          SizedBox(height: 8),
          _buildDpiPlatformRow('macOS', 'NSScreen backingScaleFactor',
              '[screen backingScaleFactor]', _kHwndColor),
        ],
      ),
    );
  }

  Widget _buildDpiPlatformRow(String platform, String mechanism, String api, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(platform, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
          SizedBox(height: 4),
          Text(mechanism, style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.7))),
          SizedBox(height: 2),
          Text(api,
              style: TextStyle(fontSize: 10, color: color.withOpacity(0.8), fontFamily: 'monospace')),
        ],
      ),
    );
  }

  Widget _buildFullscreenComparisonCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kHwndColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.fullscreen, color: _kHwndColor, size: 20),
              SizedBox(width: 8),
              Text('Fullscreen Implementation Differences',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          _buildFullscreenRow(
            'Win32',
            'Removes WS_OVERLAPPEDWINDOW style, sets borderless. '
                'Saves/restores window placement manually. No native API.',
            _kPrimary,
          ),
          SizedBox(height: 8),
          _buildFullscreenRow(
            'Linux',
            'gtk_window_fullscreen() / gtk_window_unfullscreen(). '
                'GTK handles all state management automatically.',
            _kSnapColor,
          ),
          SizedBox(height: 8),
          _buildFullscreenRow(
            'macOS',
            '[window toggleFullScreen:nil]. '
                'macOS provides native animation and separate Space.',
            _kHwndColor,
          ),
        ],
      ),
    );
  }

  Widget _buildFullscreenRow(String platform, String desc, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Text(platform,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(desc,
                style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.7), height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeIntegrationCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccent.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette, color: _kAccent.withAlpha(200), size: 20),
              SizedBox(width: 8),
              Text('System Theme Integration',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildThemeCard('Win32 Dark Mode',
                    'DwmSetWindowAttribute with\nDWMWA_USE_IMMERSIVE_DARK_MODE.\nTitle bar follows system pref.', _kPrimary),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildThemeCard('GTK Theme',
                    'gtk-theme-name property and\nprefer-dark-theme setting.\nCSS-based theming.', _kSnapColor),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildThemeCard('macOS Appearance',
                    'NSApp.effectiveAppearance.\nAutomatic dark/light with\nNSAppearance names.', _kHwndColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard(String title, String desc, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
          SizedBox(height: 6),
          Text(desc, style: TextStyle(fontSize: 10, color: _kDarkText.withOpacity(0.7), height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildResourceCleanupCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary.withOpacity(0.06), _kAccent.withOpacity(0.06)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withOpacity(0.2)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.cleaning_services, color: Colors.red.shade700, size: 20),
              SizedBox(width: 8),
              Text('Resource Cleanup on destroy()',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 12),
          _buildCleanupRow('Win32', [
            'DestroyWindow(hwnd)',
            'UnregisterClass()',
            'GDI objects released',
            'Message pump exits',
          ], _kPrimary),
          SizedBox(height: 10),
          _buildCleanupRow('Linux', [
            'gtk_widget_destroy()',
            'GObject unref',
            'Signal handlers disconnected',
            'X11/Wayland resources freed',
          ], _kSnapColor),
          SizedBox(height: 10),
          _buildCleanupRow('macOS', [
            '[window close]',
            'ARC releases NSWindow',
            'Delegate released',
            'NSView hierarchy torn down',
          ], _kHwndColor),
        ],
      ),
    );
  }

  Widget _buildCleanupRow(String platform, List<String> steps, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(platform, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
        SizedBox(height: 4),
        ...steps.map((step) => Padding(
              padding: EdgeInsets.only(left: 16, bottom: 3),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                  SizedBox(width: 8),
                  Text(step, style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.7))),
                ],
              ),
            )),
      ],
    );
  }
}

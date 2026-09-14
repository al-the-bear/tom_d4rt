// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RegularWindow  –  Deep Visual Demo
//
//  Palette : Amber 800 / Cyan 400
//  Tabs    : Theory · Multi-Window Lab · Lifecycle & Scoping
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RegularWindow demo building');
  return _RegularWindowDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFFFF8F00); // Amber 800
const _kAccent = Color(0xFF26C6DA); // Cyan 400
const _kSurface = Color(0xFFFFF8E1); // Amber 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF37474F); // BlueGrey 800
const _kCodeBg = Color(0xFFFFF3E0); // Orange 50
const _kHighlight = Color(0xFFE0F7FA); // Cyan 50
const _kViewColor = Color(0xFF1565C0); // Blue 800
const _kScopeColor = Color(0xFF6A1B9A); // Purple 800
const _kDelegateColor = Color(0xFF2E7D32); // Green 800
const _kDestroyColor = Color(0xFFC62828); // Red 800

class _RegularWindowDemo extends StatefulWidget {
  @override
  State<_RegularWindowDemo> createState() => _RegularWindowDemoState();
}

class _RegularWindowDemoState extends State<_RegularWindowDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
    print('RegularWindow demo initialised – 3 tabs');
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
        title: Text('RegularWindow',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
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
            Tab(text: 'Multi-Window Lab'),
            Tab(text: 'Lifecycle & Scoping'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _MultiWindowLabTab(),
          _LifecycleScopingTab(),
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
          _buildWidgetStructureCard(),
          SizedBox(height: 14),
          _buildConstructorCard(),
          SizedBox(height: 14),
          _buildBuildMethodCard(),
          SizedBox(height: 14),
          _buildViewIntegrationCard(),
          SizedBox(height: 14),
          _buildWindowScopeCard(),
          SizedBox(height: 14),
          _buildExperimentalCard(),
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
              Icon(Icons.web_asset, color: _kPrimary, size: 22),
              SizedBox(width: 8),
              Text('What is RegularWindow?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'RegularWindow is a StatelessWidget that renders its child widget tree '
            'into a native platform window managed by a RegularWindowController. '
            'Each RegularWindow instance represents one desktop window.',
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
                Icon(Icons.lightbulb_outline, color: _kAccent, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'RegularWindow is the widget-level entry point for Flutter\'s '
                    'experimental multi-window support on desktop platforms.',
                    style: TextStyle(fontSize: 12, color: _kDarkText, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          _buildBullet(Icons.window, 'One widget = one native window'),
          _buildBullet(Icons.account_tree, 'Child renders inside a platform View'),
          _buildBullet(Icons.control_camera, 'Controller manages window state'),
          _buildBullet(Icons.search, 'WindowScope provides context access'),
          _buildBullet(Icons.delete_outline, 'Removal does NOT destroy the window'),
        ],
      ),
    );
  }

  Widget _buildBullet(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, color: _kAccent, size: 16),
          SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(fontSize: 12, color: _kDarkText))),
        ],
      ),
    );
  }

  Widget _buildWidgetStructureCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kViewColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.layers, color: _kViewColor, size: 22),
              SizedBox(width: 8),
              Text('Widget Tree Structure',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          _buildTreeNode(0, 'RegularWindow', _kPrimary, 'Your entry point'),
          _buildTreeNode(1, 'ListenableBuilder', Colors.grey.shade600, 'Rebuilds on controller changes'),
          _buildTreeNode(2, 'WindowScope', _kScopeColor, 'Provides controller to subtree'),
          _buildTreeNode(3, 'View', _kViewColor, 'Renders into native FlutterView'),
          _buildTreeNode(4, 'child (your widget)', _kDelegateColor, 'Your app content'),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'RegularWindow uses ListenableBuilder to listen\n'
              'for controller state changes (title, size, focus)\n'
              'and rebuilds the subtree when they occur.',
              style: TextStyle(fontSize: 11, color: _kDarkText, fontFamily: 'monospace', height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreeNode(int depth, String label, Color color, String info) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 20.0, bottom: 8),
      child: Row(
        children: [
          if (depth > 0) ...[
            Icon(Icons.subdirectory_arrow_right, color: color.withOpacity(0.5), size: 14),
            SizedBox(width: 4),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Text(label,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color, fontFamily: 'monospace')),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(info, style: TextStyle(fontSize: 10, color: _kDarkText.withOpacity(0.6))),
          ),
        ],
      ),
    );
  }

  Widget _buildConstructorCard() {
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
              Icon(Icons.build, color: _kPrimary, size: 22),
              SizedBox(width: 8),
              Text('Constructor',
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
              'RegularWindow({\n'
              '  Key? key,\n'
              '  required RegularWindowController controller,\n'
              '  required Widget child,\n'
              '})',
              style: TextStyle(fontSize: 12, color: _kDarkText, fontFamily: 'monospace', height: 1.6),
            ),
          ),
          SizedBox(height: 12),
          _buildParamRow('controller', 'The window controller managing this window\'s native state', _kPrimary),
          _buildParamRow('child', 'The widget tree to render inside the window', _kDelegateColor),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kDestroyColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kDestroyColor.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: _kDestroyColor, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Throws UnsupportedError if the windowing feature is not enabled.',
                    style: TextStyle(fontSize: 11, color: _kDestroyColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParamRow(String name, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(name,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color, fontFamily: 'monospace')),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(desc, style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.7))),
          ),
        ],
      ),
    );
  }

  Widget _buildBuildMethodCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kScopeColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: _kScopeColor, size: 22),
              SizedBox(width: 8),
              Text('build() Implementation',
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
              '@override\n'
              'Widget build(BuildContext context) {\n'
              '  return ListenableBuilder(\n'
              '    listenable: controller,\n'
              '    builder: (context, child) => WindowScope(\n'
              '      controller: controller,\n'
              '      child: View(\n'
              '        view: controller.rootView,\n'
              '        child: child!,\n'
              '      ),\n'
              '    ),\n'
              '    child: child,   // cached, not rebuilt\n'
              '  );\n'
              '}',
              style: TextStyle(fontSize: 11, color: _kDarkText, fontFamily: 'monospace', height: 1.6),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Three key layers: ListenableBuilder watches for state changes, '
            'WindowScope provides the controller to descendants, and View '
            'routes rendering to the native window\'s FlutterView.',
            style: TextStyle(fontSize: 12, color: _kDarkText.withOpacity(0.8), height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildViewIntegrationCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kViewColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.visibility, color: _kViewColor, size: 22),
              SizedBox(width: 8),
              Text('View Integration',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildInfoBox('FlutterView', 'Low-level engine surface. Each\n'
                    'native window owns exactly one.\n'
                    'controller.rootView returns it.', _kViewColor),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildInfoBox('View Widget', 'Framework widget that binds\n'
                    'the widget tree to a FlutterView.\n'
                    'Handles pixel ratio and sizing.', _kAccent),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Each RegularWindow renders into its own View, which maps to a '
              'unique FlutterView. This enables independent rendering pipelines '
              'for each desktop window.',
              style: TextStyle(fontSize: 11, color: _kDarkText, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String desc, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
          SizedBox(height: 6),
          Text(desc, style: TextStyle(fontSize: 10, color: _kDarkText.withOpacity(0.7), height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildWindowScopeCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kScopeColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: _kScopeColor, size: 22),
              SizedBox(width: 8),
              Text('WindowScope',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'WindowScope is an InheritedWidget inserted by RegularWindow. It '
            'makes the RegularWindowController available to any descendant widget.',
            style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '// Access controller from any child widget\n'
              'final ctrl = WindowScope.of(context);\n'
              'ctrl.setTitle("Updated Title");\n'
              'print(ctrl.isActivated); // focus state\n'
              'print(ctrl.isMaximized); // window state',
              style: TextStyle(fontSize: 11, color: _kDarkText, fontFamily: 'monospace', height: 1.6),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kScopeColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: _kScopeColor, size: 18),
                      SizedBox(height: 4),
                      Text('of(context)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _kScopeColor)),
                      Text('Throws if missing', style: TextStyle(fontSize: 9, color: _kDarkText.withOpacity(0.6))),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kDelegateColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.help_outline, color: _kDelegateColor, size: 18),
                      SizedBox(height: 4),
                      Text('maybeOf(context)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _kDelegateColor)),
                      Text('Returns null', style: TextStyle(fontSize: 9, color: _kDarkText.withOpacity(0.6))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperimentalCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary.withOpacity(0.06), _kAccent.withOpacity(0.06)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.science, color: _kPrimary, size: 20),
              SizedBox(width: 8),
              Text('Experimental API',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'RegularWindow is part of Flutter\'s experimental multi-window support. '
            'It requires the --enable-windowing flag at runtime and is desktop-only.',
            style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
          ),
          SizedBox(height: 10),
          _buildBullet(Icons.desktop_mac, 'Desktop only: Windows, macOS, Linux'),
          _buildBullet(Icons.flag, 'Requires --enable-windowing flag'),
          _buildBullet(Icons.warning, 'API subject to breaking changes'),
          _buildBullet(Icons.build_circle, 'iOS/Android: not supported'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Multi-Window Lab
// ═══════════════════════════════════════════════════════════

class _MultiWindowLabTab extends StatefulWidget {
  @override
  State<_MultiWindowLabTab> createState() => _MultiWindowLabTabState();
}

class _WindowSim {
  String title;
  bool isActive;
  Color contentColor;

  _WindowSim({
    required this.title,
    this.isActive = false,
    required this.contentColor,
  });
}

class _MultiWindowLabTabState extends State<_MultiWindowLabTab> {
  final List<_WindowSim> _windows = [
    _WindowSim(title: 'Main Window', isActive: true, contentColor: Color(0xFF1565C0)),
  ];
  int _nextId = 2;

  void _addWindow() {
    final colors = [
      Color(0xFF2E7D32),
      Color(0xFF6A1B9A),
      Color(0xFFC62828),
      Color(0xFFEF6C00),
      Color(0xFF00838F),
    ];
    setState(() {
      _windows.add(_WindowSim(
        title: 'Window $_nextId',
        contentColor: colors[(_nextId - 1) % colors.length],
      ));
      _nextId++;
    });
    print('Added window: Window ${_nextId - 1}');
  }

  void _activateWindow(int index) {
    setState(() {
      for (int i = 0; i < _windows.length; i++) {
        _windows[i].isActive = (i == index);
      }
    });
    print('Activated: ${_windows[index].title}');
  }

  void _closeWindow(int index) {
    final name = _windows[index].title;
    setState(() => _windows.removeAt(index));
    print('Closed: $name');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabHeader(),
          SizedBox(height: 14),
          _buildWindowGrid(),
          SizedBox(height: 14),
          _buildMultiWindowCode(),
          SizedBox(height: 14),
          _buildControllerListPanel(),
          SizedBox(height: 14),
          _buildCommunicationPatternCard(),
        ],
      ),
    );
  }

  Widget _buildLabHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kPrimary.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Multi-Window Laboratory',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                SizedBox(height: 6),
                Text(
                  'Simulate creating and managing multiple RegularWindow instances. '
                  'Each entry represents one native window with its own controller.',
                  style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.4),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTap: _addWindow,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.white, size: 18),
                  SizedBox(width: 4),
                  Text('New Window', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWindowGrid() {
    if (_windows.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Text('No windows. Tap "New Window" to create one.',
              style: TextStyle(fontSize: 13, color: Colors.grey)),
        ),
      );
    }

    return Column(
      children: _windows.asMap().entries.map((entry) {
        final idx = entry.key;
        final win = entry.value;
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: _buildWindowCard(win, idx),
        );
      }).toList(),
    );
  }

  Widget _buildWindowCard(_WindowSim win, int index) {
    return GestureDetector(
      onTap: () => _activateWindow(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: win.isActive ? win.contentColor : Colors.grey.shade300,
            width: win.isActive ? 2 : 1,
          ),
          boxShadow: win.isActive
              ? [BoxShadow(color: win.contentColor.withOpacity(0.15), blurRadius: 8)]
              : [],
        ),
        child: Column(
          children: [
            // Title bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: win.isActive ? win.contentColor : Colors.grey.shade400,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.window, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(win.title,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                  if (win.isActive)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('ACTIVE', style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _closeWindow(index),
                    child: Icon(Icons.close, color: Colors.white70, size: 16),
                  ),
                ],
              ),
            ),
            // Content area
            Container(
              height: 60,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: win.contentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.widgets, color: win.contentColor, size: 20),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('RegularWindow(controller: ctrl_$index, child: ...)',
                            style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _kDarkText)),
                        SizedBox(height: 2),
                        Text(
                          win.isActive ? 'Active — receives input' : 'Inactive — tap to activate',
                          style: TextStyle(fontSize: 10, color: _kDarkText.withOpacity(0.5)),
                        ),
                      ],
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

  Widget _buildMultiWindowCode() {
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
              Icon(Icons.code, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Text('Multi-Window Pattern',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '// Create a new window\n'
              'final ctrl = RegularWindowController(\n'
              '  owner: WidgetsBinding.instance,\n'
              ');\n'
              'ctrl.setTitle("Document 2");\n\n'
              '// Add to widget tree\n'
              'RegularWindow(\n'
              '  controller: ctrl,\n'
              '  child: MyDocumentEditor(doc: doc2),\n'
              ')\n\n'
              '// Later, destroy the window\n'
              'ctrl.destroy();',
              style: TextStyle(fontSize: 11, color: _kDarkText, fontFamily: 'monospace', height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControllerListPanel() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kScopeColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list_alt, color: _kScopeColor, size: 20),
              SizedBox(width: 8),
              Text('Controller Registry',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 10),
          Text('Active controllers: ${_windows.length}',
              style: TextStyle(fontSize: 12, color: _kDarkText.withOpacity(0.7))),
          SizedBox(height: 8),
          ...List.generate(_windows.length, (i) {
            final win = _windows[i];
            return Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: win.isActive ? _kDelegateColor : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('ctrl_$i',
                      style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _kScopeColor)),
                  SizedBox(width: 8),
                  Text('→ "${win.title}"',
                      style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.6))),
                  Spacer(),
                  Text(win.isActive ? 'active' : 'background',
                      style: TextStyle(fontSize: 10, color: win.isActive ? _kDelegateColor : Colors.grey)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCommunicationPatternCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDelegateColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.swap_horiz, color: _kDelegateColor, size: 20),
              SizedBox(width: 8),
              Text('Cross-Window Communication',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'RegularWindow instances share the same Dart isolate. Communication '
            'between windows uses standard Dart patterns:',
            style: TextStyle(fontSize: 12, color: _kDarkText.withOpacity(0.8), height: 1.4),
          ),
          SizedBox(height: 10),
          _buildCommRow('Shared State', 'ChangeNotifier / ValueNotifier', Icons.share),
          _buildCommRow('Stream-based', 'StreamController.broadcast()', Icons.stream),
          _buildCommRow('Provider', 'InheritedWidget above all windows', Icons.account_tree),
          _buildCommRow('Direct', 'Reference controller from list', Icons.link),
        ],
      ),
    );
  }

  Widget _buildCommRow(String method, String detail, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: _kDelegateColor, size: 16),
          SizedBox(width: 8),
          SizedBox(
            width: 90,
            child: Text(method,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _kDelegateColor)),
          ),
          Expanded(
            child: Text(detail, style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.6))),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Lifecycle & Scoping
// ═══════════════════════════════════════════════════════════

class _LifecycleScopingTab extends StatefulWidget {
  @override
  State<_LifecycleScopingTab> createState() => _LifecycleScopingTabState();
}

class _LifecycleScopingTabState extends State<_LifecycleScopingTab> {
  final List<String> _lifecycleLog = [];
  String _windowState = 'created';
  bool _delegateBlocksClose = true;

  void _logEvent(String event) {
    setState(() {
      _lifecycleLog.insert(0, event);
      if (_lifecycleLog.length > 15) _lifecycleLog.removeLast();
    });
    print('Lifecycle: $event');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLifecycleFlowCard(),
          SizedBox(height: 14),
          _buildDelegateCard(),
          SizedBox(height: 14),
          _buildLifecycleSimulator(),
          SizedBox(height: 14),
          _buildDestroyBehaviorCard(),
          SizedBox(height: 14),
          _buildScopeAccessDemoCard(),
          SizedBox(height: 14),
          _buildLifecycleLogPanel(),
        ],
      ),
    );
  }

  Widget _buildLifecycleFlowCard() {
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
              Icon(Icons.timeline, color: _kPrimary, size: 22),
              SizedBox(width: 8),
              Text('Window Lifecycle Flow',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          _buildFlowStep(1, 'Controller Created', 'RegularWindowController() → native window', _kDelegateColor),
          _buildFlowStep(2, 'Widget Mounted', 'RegularWindow enters widget tree', _kPrimary),
          _buildFlowStep(3, 'View Bound', 'Child renders into controller.rootView', _kViewColor),
          _buildFlowStep(4, 'State Changes', 'Title, size, focus → notifyListeners()', _kAccent),
          _buildFlowStep(5, 'Close Request', 'Delegate.onCloseRequested() called', _kScopeColor),
          _buildFlowStep(6, 'Destroy', 'controller.destroy() releases native window', _kDestroyColor),
        ],
      ),
    );
  }

  Widget _buildFlowStep(int step, String title, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text('$step', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
                SizedBox(height: 2),
                Text(desc, style: TextStyle(fontSize: 11, color: _kDarkText.withOpacity(0.6))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDelegateCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kScopeColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.gavel, color: _kScopeColor, size: 22),
              SizedBox(width: 8),
              Text('Delegate Close Handling',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'When the user clicks the native close button, the delegate\u2019s '
            'onCloseRequested() is called. It can either allow or prevent closing.',
            style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'class MyDelegate extends RegularWindowControllerDelegate {\n'
              '  @override\n'
              '  bool onCloseRequested(RegularWindowController ctrl) {\n'
              '    if (hasUnsavedChanges) {\n'
              '      showSaveDialog();  // block close\n'
              '      return false;\n'
              '    }\n'
              '    ctrl.destroy();  // allow close\n'
              '    return true;\n'
              '  }\n'
              '}',
              style: TextStyle(fontSize: 11, color: _kDarkText, fontFamily: 'monospace', height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleSimulator() {
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
              Icon(Icons.play_circle_fill, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Text('Lifecycle Simulator',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 6),
          Text('Current state: $_windowState',
              style: TextStyle(fontSize: 12, color: _kDarkText.withOpacity(0.6))),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: _windowState == 'destroyed'
                  ? _kDestroyColor.withOpacity(0.08)
                  : _kDelegateColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _windowState == 'destroyed' ? _kDestroyColor.withOpacity(0.3) : _kDelegateColor.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  _windowState == 'destroyed' ? Icons.dangerous : Icons.window,
                  color: _windowState == 'destroyed' ? _kDestroyColor : _kDelegateColor,
                  size: 32,
                ),
                SizedBox(height: 6),
                Text(
                  _windowState == 'destroyed' ? 'Window Destroyed' : 'Window: $_windowState',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _windowState == 'destroyed' ? _kDestroyColor : _kDelegateColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildCheckOption()),
              SizedBox(width: 8),
            ],
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSimButton('Mount Widget', _kDelegateColor, () {
                setState(() => _windowState = 'mounted');
                _logEvent('Widget mounted → View bound');
              }),
              _buildSimButton('Activate', _kViewColor, () {
                setState(() => _windowState = 'active');
                _logEvent('Window activated → focus gained');
              }),
              _buildSimButton('Request Close', _kScopeColor, () {
                if (_delegateBlocksClose) {
                  _logEvent('Close blocked by delegate');
                } else {
                  setState(() => _windowState = 'closing');
                  _logEvent('Close allowed → destroying...');
                }
              }),
              _buildSimButton('Destroy', _kDestroyColor, () {
                setState(() => _windowState = 'destroyed');
                _logEvent('controller.destroy() → HWND released');
              }),
              _buildSimButton('Reset', Colors.grey, () {
                setState(() => _windowState = 'created');
                _logEvent('Reset to initial state');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckOption() {
    return GestureDetector(
      onTap: () => setState(() => _delegateBlocksClose = !_delegateBlocksClose),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: _delegateBlocksClose ? _kScopeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kScopeColor),
            ),
            child: _delegateBlocksClose
                ? Icon(Icons.check, color: Colors.white, size: 14)
                : null,
          ),
          SizedBox(width: 8),
          Text('Delegate blocks close',
              style: TextStyle(fontSize: 12, color: _kDarkText)),
        ],
      ),
    );
  }

  Widget _buildSimButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
      ),
    );
  }

  Widget _buildDestroyBehaviorCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDestroyColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: _kDestroyColor, size: 22),
              SizedBox(width: 8),
              Text('Important: Widget Removal ≠ Destroy',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kDelegateColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kDelegateColor.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.remove_circle_outline, color: _kDelegateColor, size: 24),
                      SizedBox(height: 6),
                      Text('Remove Widget', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _kDelegateColor)),
                      SizedBox(height: 4),
                      Text('Detaches widget tree\nbut window stays open.',
                          style: TextStyle(fontSize: 10, color: _kDarkText.withOpacity(0.6)), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.compare_arrows, color: Colors.grey, size: 20),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kDestroyColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kDestroyColor.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.delete_forever, color: _kDestroyColor, size: 24),
                      SizedBox(height: 6),
                      Text('controller.destroy()', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _kDestroyColor)),
                      SizedBox(height: 4),
                      Text('Releases native window\nand all resources.',
                          style: TextStyle(fontSize: 10, color: _kDarkText.withOpacity(0.6)), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScopeAccessDemoCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kViewColor.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree, color: _kViewColor, size: 22),
              SizedBox(width: 8),
              Text('WindowScope Access Patterns',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 14),
          _buildScopePattern(
            'Read Window Title',
            'final title = WindowScope.of(context).title;',
            Icons.title,
          ),
          _buildScopePattern(
            'Check Focus',
            'final focused = WindowScope.of(context).isActivated;',
            Icons.center_focus_strong,
          ),
          _buildScopePattern(
            'Set Title',
            'WindowScope.of(context).setTitle("New Title");',
            Icons.edit,
          ),
          _buildScopePattern(
            'Request Size',
            'WindowScope.of(context).requestSize(Size(800, 600));',
            Icons.aspect_ratio,
          ),
          _buildScopePattern(
            'Enter Fullscreen',
            'WindowScope.of(context).enterFullscreen();',
            Icons.fullscreen,
          ),
        ],
      ),
    );
  }

  Widget _buildScopePattern(String label, String code, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _kViewColor, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _kDarkText)),
                SizedBox(height: 3),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _kCodeBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(code,
                      style: TextStyle(fontSize: 10, color: _kViewColor, fontFamily: 'monospace')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleLogPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF263238),
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
              Text('Lifecycle Event Log',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _kAccent)),
              Spacer(),
              GestureDetector(
                onTap: () => setState(() => _lifecycleLog.clear()),
                child: Text('Clear', style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
              ),
            ],
          ),
          SizedBox(height: 10),
          if (_lifecycleLog.isEmpty)
            Text('No events yet. Use simulator controls above.',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontStyle: FontStyle.italic))
          else
            ..._lifecycleLog.map((event) => Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('● ', style: TextStyle(fontSize: 11, color: _kAccent)),
                      Expanded(
                        child: Text(event,
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

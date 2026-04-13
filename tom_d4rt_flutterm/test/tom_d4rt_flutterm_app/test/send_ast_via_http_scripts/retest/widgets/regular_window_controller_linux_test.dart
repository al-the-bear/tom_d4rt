// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RegularWindowControllerLinux  –  Deep Visual Demo
//
//  Palette : Forest Green 800 / Amber 500
//  Tabs    : Theory · GTK Explorer · Platform Comparison
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RegularWindowControllerLinux demo building');
  return _LinuxControllerDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF2E7D32); // Green 800
const _kAccent = Color(0xFFFFC107); // Amber 500
const _kSurface = Color(0xFFE8F5E9); // Green 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF1B5E20); // Green 900
const _kMuted = Color(0xFFA5D6A7); // Green 200
const _kCodeBg = Color(0xFFF1F8E9); // LightGreen 50
const _kHighlight = Color(0xFFFFF8E1); // Amber 50
const _kGtkColor = Color(0xFF5C6BC0); // Indigo 400
const _kPropertyColor = Color(0xFF00838F); // Cyan 800
const _kMethodColor = Color(0xFFAD1457); // Pink 800
const _kLinuxColor = Color(0xFFF4511E); // DeepOrange 600

class _LinuxControllerDemo extends StatefulWidget {
  @override
  State<_LinuxControllerDemo> createState() => _LinuxControllerDemoState();
}

class _LinuxControllerDemoState extends State<_LinuxControllerDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
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
        title: Text('RegularWindowControllerLinux',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
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
            Tab(text: 'GTK Explorer'),
            Tab(text: 'Comparison'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _GtkExplorerTab(),
          _ComparisonTab(),
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
          _buildConstructorCard(),
          SizedBox(height: 14),
          _buildPropertiesCard(),
          SizedBox(height: 14),
          _buildMethodsCard(),
          SizedBox(height: 14),
          _buildGtkIntegrationCard(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kLinuxColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.desktop_windows,
                    color: _kLinuxColor, size: 28),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RegularWindowControllerLinux',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _kDarkText)),
                    SizedBox(height: 3),
                    Text('Linux-specific window controller using GTK',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'RegularWindowControllerLinux is the Linux platform-specific '
              'implementation of RegularWindowController. It manages GTK '
              'windows (GtkWindow) through the Flutter engine\'s Linux '
              'embedding layer. It translates Flutter\'s windowing API into '
              'GTK function calls for window management, sizing, and state '
              'transitions.',
              style: TextStyle(
                  fontSize: 12.5, color: _kDarkText, height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _infoBadge('Linux Only', _kLinuxColor),
              SizedBox(width: 6),
              _infoBadge('GTK Backend', _kGtkColor),
              SizedBox(width: 6),
              _infoBadge('Experimental', Color(0xFFE65100)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClassHierarchyCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Class Hierarchy',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          _hierarchyNode('ChangeNotifier', 0, Colors.grey[600]!,
              'Foundation mixin'),
          _hierarchyNode('BaseWindowController', 1, Color(0xFF5D4037),
              'Window lifecycle base'),
          _hierarchyNode('RegularWindowController', 2, _kGtkColor,
              'Abstract regular window'),
          _hierarchyNode('RegularWindowControllerLinux', 3, _kLinuxColor,
              'GTK implementation'),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'The controller is a ChangeNotifier, so it can notify listeners '
              'when window state changes (activated, maximized, etc.).',
              style: TextStyle(
                  fontSize: 11.5, color: Colors.grey[700], height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hierarchyNode(String name, int depth, Color color, String desc) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 22.0, bottom: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 8),
          Text(name,
              style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                  color: color)),
          SizedBox(width: 8),
          Text(desc,
              style: TextStyle(fontSize: 10.5, color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildConstructorCard() {
    final params = <Map<String, String>>[
      {
        'name': 'owner',
        'type': 'WindowingOwnerLinux',
        'desc': 'The Linux windowing owner that manages '
            'this controller\'s lifecycle'
      },
      {
        'name': 'delegate',
        'type': 'RegularWindowControllerDelegate?',
        'desc': 'Optional delegate for lifecycle callbacks '
            '(close request, destroyed)'
      },
      {
        'name': 'preferredSize',
        'type': 'Size?',
        'desc': 'Initial content size for the GTK window'
      },
      {
        'name': 'preferredConstraints',
        'type': 'BoxConstraints?',
        'desc': 'Min/max size constraints for the window'
      },
      {
        'name': 'title',
        'type': 'String?',
        'desc': 'Initial window title shown in the title bar and taskbar'
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Constructor Parameters',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          ...params.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 96,
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: _kPropertyColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(p['name']!,
                          style: TextStyle(
                              fontSize: 10.5,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                              color: _kPropertyColor)),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['type']!,
                              style: TextStyle(
                                  fontSize: 10.5,
                                  fontFamily: 'monospace',
                                  color: _kMethodColor)),
                          SizedBox(height: 2),
                          Text(p['desc']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                  height: 1.3)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPropertiesCard() {
    final props = <Map<String, dynamic>>[
      {
        'name': 'contentSize',
        'type': 'Size',
        'desc': 'Current content area size (from GTK)',
        'icon': Icons.aspect_ratio,
        'color': _kPropertyColor,
      },
      {
        'name': 'title',
        'type': 'String',
        'desc': 'Current window title',
        'icon': Icons.title,
        'color': _kPropertyColor,
      },
      {
        'name': 'isActivated',
        'type': 'bool',
        'desc': 'Whether window has keyboard focus',
        'icon': Icons.flash_on,
        'color': Color(0xFF1565C0),
      },
      {
        'name': 'isMaximized',
        'type': 'bool',
        'desc': 'Whether window fills the screen',
        'icon': Icons.fullscreen,
        'color': _kPrimary,
      },
      {
        'name': 'isMinimized',
        'type': 'bool',
        'desc': 'Whether window is iconified',
        'icon': Icons.minimize,
        'color': Color(0xFFE65100),
      },
      {
        'name': 'isFullscreen',
        'type': 'bool',
        'desc': 'Whether window is in fullscreen mode',
        'icon': Icons.fullscreen_exit,
        'color': _kMethodColor,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Properties',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 4),
          Text('Reactive — changes trigger listener notifications',
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 12),
          ...props.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(p['icon'] as IconData,
                          size: 15, color: p['color'] as Color),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['name'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w600,
                                  color: p['color'] as Color)),
                          Text(p['type'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: Colors.grey[500])),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(p['desc'] as String,
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey[600])),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildMethodsCard() {
    final methods = <Map<String, String>>[
      {
        'name': 'setSize(Size)',
        'desc': 'Resize the GTK window content area',
        'gtk': 'gtk_window_set_default_size()',
      },
      {
        'name': 'setConstraints(BoxConstraints)',
        'desc': 'Set min/max window size limits',
        'gtk': 'gtk_window_set_geometry_hints()',
      },
      {
        'name': 'setTitle(String)',
        'desc': 'Update the window title bar text',
        'gtk': 'gtk_window_set_title()',
      },
      {
        'name': 'activate()',
        'desc': 'Bring window to front and give focus',
        'gtk': 'gtk_window_present()',
      },
      {
        'name': 'maximize()',
        'desc': 'Maximize the window',
        'gtk': 'gtk_window_maximize()',
      },
      {
        'name': 'unmaximize()',
        'desc': 'Restore from maximized state',
        'gtk': 'gtk_window_unmaximize()',
      },
      {
        'name': 'minimize()',
        'desc': 'Minimize / iconify the window',
        'gtk': 'gtk_window_iconify()',
      },
      {
        'name': 'restore()',
        'desc': 'Restore from minimized state',
        'gtk': 'gtk_window_deiconify()',
      },
      {
        'name': 'destroy()',
        'desc': 'Destroy the window and its GTK resources',
        'gtk': 'gtk_widget_destroy()',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Methods → GTK Mapping',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 4),
          Text('Each Flutter method translates to a GTK function call',
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 12),
          ...methods.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kCodeBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(m['name']!,
                            style: TextStyle(
                                fontSize: 10.5,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w600,
                                color: _kMethodColor)),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m['desc']!,
                                style: TextStyle(
                                    fontSize: 10.5,
                                    color: Colors.grey[700])),
                            Text(m['gtk']!,
                                style: TextStyle(
                                    fontSize: 9.5,
                                    fontFamily: 'monospace',
                                    color: _kGtkColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildGtkIntegrationCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kGtkColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.integration_instructions,
                  size: 20, color: _kGtkColor),
              SizedBox(width: 8),
              Text('GTK Integration Layer',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 12),
          _gtkLayerRow('Flutter Widget Tree', 'Your app UI',
              Color(0xFF1565C0)),
          _gtkArrow(),
          _gtkLayerRow(
              'RegularWindowControllerLinux',
              'Dart-side controller',
              _kLinuxColor),
          _gtkArrow(),
          _gtkLayerRow('Flutter Engine (C)', 'Platform channel / FFI',
              Color(0xFF5D4037)),
          _gtkArrow(),
          _gtkLayerRow('FlFlutterView (GTK3)', 'GtkWindow + GL surface',
              _kGtkColor),
          _gtkArrow(),
          _gtkLayerRow('X11 / Wayland', 'Linux display server',
              Colors.grey[600]!),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline,
                    size: 16, color: Color(0xFFE65100)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'The Linux implementation uses GTK3 with '
                    'FlFlutterView for rendering. Each window gets '
                    'its own GtkWindow with an embedded OpenGL surface '
                    'for Flutter rendering.',
                    style: TextStyle(
                        fontSize: 11.5,
                        color: _kDarkText,
                        height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _gtkLayerRow(String name, String note, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(note,
                  style: TextStyle(
                      fontSize: 10.5, color: Colors.grey[500])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _gtkArrow() {
    return Padding(
      padding: EdgeInsets.only(left: 2, top: 1, bottom: 1),
      child: Icon(Icons.arrow_downward, size: 14, color: Colors.grey[400]),
    );
  }
}

Widget _infoBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      border: Border.all(color: color.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color)),
  );
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  GTK Explorer
// ═══════════════════════════════════════════════════════════

class _GtkExplorerTab extends StatefulWidget {
  @override
  State<_GtkExplorerTab> createState() => _GtkExplorerTabState();
}

class _GtkExplorerTabState extends State<_GtkExplorerTab> {
  String _windowTitle = 'My GTK Window';
  double _windowWidth = 280;
  double _windowHeight = 180;
  bool _isActivated = true;
  bool _isMaximized = false;
  bool _isMinimized = false;
  bool _isFullscreen = false;
  final List<String> _commandLog = [];

  void _addLog(String cmd) {
    setState(() {
      _commandLog.insert(0, cmd);
      if (_commandLog.length > 20) _commandLog.removeLast();
    });
    print('GTK: $cmd');
  }

  void _toggleMaximize() {
    setState(() {
      _isMaximized = !_isMaximized;
      if (_isMaximized) {
        _isMinimized = false;
        _isFullscreen = false;
      }
    });
    _addLog(_isMaximized
        ? 'gtk_window_maximize()'
        : 'gtk_window_unmaximize()');
  }

  void _toggleMinimize() {
    setState(() {
      _isMinimized = !_isMinimized;
      if (_isMinimized) {
        _isMaximized = false;
        _isFullscreen = false;
      }
    });
    _addLog(_isMinimized
        ? 'gtk_window_iconify()'
        : 'gtk_window_deiconify()');
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
      if (_isFullscreen) {
        _isMaximized = false;
        _isMinimized = false;
      }
    });
    _addLog(_isFullscreen
        ? 'gtk_window_fullscreen()'
        : 'gtk_window_unfullscreen()');
  }

  void _setSize(double w, double h) {
    setState(() {
      _windowWidth = w;
      _windowHeight = h;
    });
    _addLog(
        'gtk_window_set_default_size(${w.toInt()}, ${h.toInt()})');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWindowPreview(),
          SizedBox(height: 14),
          _buildControlsCard(),
          SizedBox(height: 14),
          _buildSizeControlCard(),
          SizedBox(height: 14),
          _buildTitleControlCard(),
          SizedBox(height: 14),
          _buildPropertyInspector(),
          SizedBox(height: 14),
          _buildGtkCommandLog(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildWindowPreview() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Window Preview',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText)),
          SizedBox(height: 12),
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _isMaximized || _isFullscreen
                  ? MediaQuery.of(context).size.width - 64
                  : _isMinimized
                      ? 120
                      : _windowWidth.clamp(120.0, 350.0),
              height: _isMinimized ? 32 : _windowHeight.clamp(80.0, 250.0),
              decoration: BoxDecoration(
                color: _isActivated
                    ? Color(0xFF37474F)
                    : Color(0xFF78909C),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  if (_isActivated && !_isMinimized)
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                ],
              ),
              child: Column(
                children: [
                  // Title bar
                  Container(
                    height: 28,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: _isActivated
                          ? Color(0xFF263238)
                          : Color(0xFF546E7A),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(6)),
                    ),
                    child: Row(
                      children: [
                        // GTK traffic lights (close, minimize, maximize)
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Color(0xFFE53935),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Color(0xFFFDD835),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Color(0xFF43A047),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _windowTitle,
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content area
                  if (!_isMinimized)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(4)),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.desktop_windows,
                                  size: 24,
                                  color: Colors.grey[400]),
                              SizedBox(height: 4),
                              Text(
                                '${_windowWidth.toInt()} × '
                                '${_windowHeight.toInt()}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: Colors.grey[500]),
                              ),
                              if (_isFullscreen)
                                Text('FULLSCREEN',
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: _kGtkColor)),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlsCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kAccent.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Window State Controls',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText)),
          SizedBox(height: 12),
          Row(
            children: [
              _stateButton(
                'Activate',
                Icons.flash_on,
                _isActivated,
                Color(0xFF1565C0),
                () {
                  setState(() => _isActivated = !_isActivated);
                  _addLog(_isActivated
                      ? 'gtk_window_present()'
                      : 'window deactivated');
                },
              ),
              SizedBox(width: 6),
              _stateButton(
                'Maximize',
                Icons.fullscreen,
                _isMaximized,
                _kPrimary,
                _toggleMaximize,
              ),
              SizedBox(width: 6),
              _stateButton(
                'Minimize',
                Icons.minimize,
                _isMinimized,
                Color(0xFFE65100),
                _toggleMinimize,
              ),
              SizedBox(width: 6),
              _stateButton(
                'Fullscreen',
                Icons.fullscreen_exit,
                _isFullscreen,
                _kMethodColor,
                _toggleFullscreen,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stateButton(String label, IconData icon, bool active,
      Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: active ? color.withOpacity(0.12) : Colors.grey[100],
            border: Border.all(
              color: active ? color.withOpacity(0.4) : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Icon(icon,
                  size: 18,
                  color: active ? color : Colors.grey[400]),
              SizedBox(height: 2),
              Text(label,
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: active ? color : Colors.grey[400])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSizeControlCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Size Control',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText)),
          SizedBox(height: 12),
          Row(
            children: [
              Text('Width:', style: TextStyle(fontSize: 11, color: Colors.grey[700])),
              Expanded(
                child: Slider(
                  value: _windowWidth,
                  min: 120,
                  max: 350,
                  activeColor: _kPrimary,
                  onChanged: (v) => _setSize(v, _windowHeight),
                ),
              ),
              SizedBox(
                width: 40,
                child: Text('${_windowWidth.toInt()}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: _kDarkText)),
              ),
            ],
          ),
          Row(
            children: [
              Text('Height:', style: TextStyle(fontSize: 11, color: Colors.grey[700])),
              Expanded(
                child: Slider(
                  value: _windowHeight,
                  min: 80,
                  max: 250,
                  activeColor: _kAccent,
                  onChanged: (v) => _setSize(_windowWidth, v),
                ),
              ),
              SizedBox(
                width: 40,
                child: Text('${_windowHeight.toInt()}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: _kDarkText)),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _presetButton('Small', 200, 120),
              _presetButton('Medium', 280, 180),
              _presetButton('Large', 350, 250),
            ],
          ),
        ],
      ),
    );
  }

  Widget _presetButton(String label, double w, double h) {
    return GestureDetector(
      onTap: () => _setSize(w, h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _kPrimary)),
      ),
    );
  }

  Widget _buildTitleControlCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title Control',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText)),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Window Title',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _kPrimary, width: 2),
              ),
              filled: true,
              fillColor: _kSurface,
              isDense: true,
            ),
            onChanged: (v) {
              setState(() => _windowTitle = v.isNotEmpty ? v : 'Untitled');
              _addLog('gtk_window_set_title("$_windowTitle")');
            },
          ),
          SizedBox(height: 6),
          Text(
            'Maps to gtk_window_set_title() — updates the title bar and '
            'the taskbar/dock entry.',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyInspector() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kPropertyColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.search, size: 18, color: _kPropertyColor),
              SizedBox(width: 8),
              Text('Property Inspector',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
            ],
          ),
          SizedBox(height: 12),
          _propRow('title', '"$_windowTitle"'),
          _propRow('contentSize',
              'Size(${_windowWidth.toInt()}, ${_windowHeight.toInt()})'),
          _propRow('isActivated', '$_isActivated'),
          _propRow('isMaximized', '$_isMaximized'),
          _propRow('isMinimized', '$_isMinimized'),
          _propRow('isFullscreen', '$_isFullscreen'),
        ],
      ),
    );
  }

  Widget _propRow(String name, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(name,
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    color: _kPropertyColor)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: _kDarkText)),
          ),
        ],
      ),
    );
  }

  Widget _buildGtkCommandLog() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.terminal, size: 18, color: _kGtkColor),
              SizedBox(width: 8),
              Text('GTK Command Log',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
              Spacer(),
              GestureDetector(
                onTap: () => setState(() => _commandLog.clear()),
                child: Text('Clear',
                    style: TextStyle(
                        fontSize: 10, color: Colors.grey[500])),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: _commandLog.isEmpty
                ? Center(
                    child: Text('Use the controls above to generate GTK calls',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600])),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: _commandLog.length,
                    itemBuilder: (_, i) => Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Row(
                        children: [
                          Text('\$ ',
                              style: TextStyle(
                                  fontSize: 10.5,
                                  fontFamily: 'monospace',
                                  color: _kAccent)),
                          Expanded(
                            child: Text(
                              _commandLog[i],
                              style: TextStyle(
                                  fontSize: 10.5,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF4FC3F7)),
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

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Platform Comparison
// ═══════════════════════════════════════════════════════════

class _ComparisonTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverviewComparisonCard(),
          SizedBox(height: 14),
          _buildFeatureMatrixCard(),
          SizedBox(height: 14),
          _buildNativeApiMappingCard(),
          SizedBox(height: 14),
          _buildLinuxSpecificsCard(),
          SizedBox(height: 14),
          _buildDisplayServerCard(),
          SizedBox(height: 14),
          _buildLimitationsCard(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOverviewComparisonCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Platform Controller Comparison',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          Row(
            children: [
              _platformCard('Linux', Icons.desktop_windows,
                  _kLinuxColor, 'GTK3 / X11 / Wayland'),
              SizedBox(width: 8),
              _platformCard('macOS', Icons.laptop_mac,
                  Color(0xFF616161), 'Cocoa / NSWindow'),
              SizedBox(width: 8),
              _platformCard('Windows', Icons.desktop_windows,
                  Color(0xFF1565C0), 'Win32 / HWND'),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'All three platform implementations extend '
              'RegularWindowController and provide the same API. The '
              'differences are in the native backend and some '
              'platform-specific behaviors.',
              style: TextStyle(
                  fontSize: 11.5, color: Colors.grey[700], height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _platformCard(
      String name, IconData icon, Color color, String tech) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: color),
            SizedBox(height: 4),
            Text(name,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: color)),
            Text(tech,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 9, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureMatrixCard() {
    final features = <Map<String, dynamic>>[
      {'feature': 'Resize', 'linux': true, 'macos': true, 'win32': true},
      {'feature': 'Maximize', 'linux': true, 'macos': true, 'win32': true},
      {'feature': 'Minimize', 'linux': true, 'macos': true, 'win32': true},
      {'feature': 'Fullscreen', 'linux': true, 'macos': true, 'win32': true},
      {'feature': 'Title', 'linux': true, 'macos': true, 'win32': true},
      {'feature': 'Activate', 'linux': true, 'macos': true, 'win32': true},
      {'feature': 'Constraints', 'linux': true, 'macos': true, 'win32': true},
      {'feature': 'Close guard', 'linux': true, 'macos': true, 'win32': true},
      {'feature': 'Window style', 'linux': false, 'macos': true, 'win32': true},
      {'feature': 'Transparency', 'linux': false, 'macos': true, 'win32': false},
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Feature Parity Matrix',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          // Header
          Row(
            children: [
              SizedBox(width: 100),
              _matrixHeader('Linux', _kLinuxColor),
              _matrixHeader('macOS', Colors.grey[700]!),
              _matrixHeader('Win32', Color(0xFF1565C0)),
            ],
          ),
          Divider(height: 12),
          ...features.map((f) => Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(f['feature'] as String,
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey[700])),
                    ),
                    _matrixCell(f['linux'] as bool),
                    _matrixCell(f['macos'] as bool),
                    _matrixCell(f['win32'] as bool),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _matrixHeader(String text, Color color) {
    return Expanded(
      child: Center(
        child: Text(text,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color)),
      ),
    );
  }

  Widget _matrixCell(bool supported) {
    return Expanded(
      child: Center(
        child: Icon(
          supported ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: supported ? _kPrimary : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildNativeApiMappingCard() {
    final mappings = <Map<String, String>>[
      {
        'method': 'setSize()',
        'linux': 'gtk_window_resize()',
        'macos': 'setContentSize:',
        'win32': 'SetWindowPos()',
      },
      {
        'method': 'maximize()',
        'linux': 'gtk_window_maximize()',
        'macos': 'zoom:',
        'win32': 'ShowWindow(SW_MAXIMIZE)',
      },
      {
        'method': 'minimize()',
        'linux': 'gtk_window_iconify()',
        'macos': 'miniaturize:',
        'win32': 'ShowWindow(SW_MINIMIZE)',
      },
      {
        'method': 'activate()',
        'linux': 'gtk_window_present()',
        'macos': 'makeKeyAndOrderFront:',
        'win32': 'SetForegroundWindow()',
      },
      {
        'method': 'destroy()',
        'linux': 'gtk_widget_destroy()',
        'macos': 'close / orderOut:',
        'win32': 'DestroyWindow()',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Native API Mapping',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 4),
          Text('How each Flutter method maps to native calls',
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 12),
          ...mappings.map((m) => Container(
                margin: EdgeInsets.only(bottom: 6),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kCodeBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m['method']!,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'monospace',
                            color: _kMethodColor)),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        _nativeChip('Linux', m['linux']!, _kLinuxColor),
                        SizedBox(width: 4),
                        _nativeChip(
                            'macOS', m['macos']!, Colors.grey[700]!),
                        SizedBox(width: 4),
                        _nativeChip(
                            'Win32', m['win32']!, Color(0xFF1565C0)),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _nativeChip(String platform, String api, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          children: [
            Text(platform,
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: color)),
            Text(api,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 8,
                    fontFamily: 'monospace',
                    color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildLinuxSpecificsCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kLinuxColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.desktop_windows, size: 20, color: _kLinuxColor),
              SizedBox(width: 8),
              Text('Linux-Specific Details',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 12),
          _detailRow('Toolkit', 'GTK 3.x (Gimp Toolkit)', _kGtkColor),
          SizedBox(height: 6),
          _detailRow('Rendering', 'OpenGL via FlFlutterView',
              _kPropertyColor),
          SizedBox(height: 6),
          _detailRow('Display', 'X11 or Wayland (via GDK)',
              _kLinuxColor),
          SizedBox(height: 6),
          _detailRow('Events', 'GdkEvent → Flutter engine',
              _kMethodColor),
          SizedBox(height: 6),
          _detailRow('Close signal', 'delete-event GSignal',
              Color(0xFFE65100)),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'The Linux implementation uses GdkWindow under GTK3. '
              'Window decorations are handled by the window manager '
              '(GNOME Shell, KDE, etc.), not by the app itself. '
              'This means the title bar style depends on the user\'s '
              'desktop environment.',
              style: TextStyle(
                  fontSize: 11.5, color: _kDarkText, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 90,
          child: Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _kDarkText)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ),
      ],
    );
  }

  Widget _buildDisplayServerCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Display Server Compatibility',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kPrimary.withOpacity(0.08),
                    border: Border.all(color: _kPrimary.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text('X11',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _kPrimary)),
                      SizedBox(height: 4),
                      Text('Traditional',
                          style: TextStyle(
                              fontSize: 10, color: Colors.grey[600])),
                      SizedBox(height: 8),
                      Icon(Icons.check_circle,
                          size: 20, color: _kPrimary),
                      SizedBox(height: 4),
                      Text('Full support',
                          style: TextStyle(
                              fontSize: 10, color: _kPrimary)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kGtkColor.withOpacity(0.08),
                    border: Border.all(color: _kGtkColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text('Wayland',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _kGtkColor)),
                      SizedBox(height: 4),
                      Text('Modern',
                          style: TextStyle(
                              fontSize: 10, color: Colors.grey[600])),
                      SizedBox(height: 8),
                      Icon(Icons.warning,
                          size: 20, color: Color(0xFFE65100)),
                      SizedBox(height: 4),
                      Text('Via XWayland',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFFE65100))),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Wayland has additional restrictions: window positioning '
            'is controlled by the compositor, and some window state '
            'queries may not be available.',
            style: TextStyle(
                fontSize: 11.5, color: Colors.grey[700], height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildLimitationsCard() {
    final limitations = <Map<String, String>>[
      {
        'title': 'GTK3 only',
        'detail': 'Flutter Linux uses GTK3, not GTK4. GTK4 migration '
            'is a separate effort.',
      },
      {
        'title': 'Window manager dependent decorations',
        'detail': 'Title bar, borders, and shadows are drawn by the '
            'window manager, not the app.',
      },
      {
        'title': 'Wayland positioning limitations',
        'detail': 'On Wayland, absolute window positioning is not available. '
            'The compositor decides where windows appear.',
      },
      {
        'title': 'Experimental API stability',
        'detail': 'The multi-window API may change in future Flutter releases. '
            'Not recommended for production yet.',
      },
      {
        'title': 'Single GL context per window',
        'detail': 'Each window has its own OpenGL context. Sharing textures '
            'between windows requires additional work.',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.report_problem, size: 18, color: Color(0xFFE65100)),
              SizedBox(width: 8),
              Text('Linux Limitations & Notes',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 12),
          ...limitations.asMap().entries.map((e) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _kAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text('${e.key + 1}',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: _kDarkText)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.value['title']!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _kDarkText)),
                          SizedBox(height: 2),
                          Text(e.value['detail']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                  height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RegularWindowControllerMacOS  –  Deep Visual Demo
//
//  Palette : Purple 800 / LightGreen 400
//  Tabs    : Theory · Cocoa Simulator · AppKit Patterns
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RegularWindowControllerMacOS demo building');
  return _MacOSControllerDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF6A1B9A); // Purple 800
const _kAccent = Color(0xFF9CCC65); // LightGreen 400
const _kSurface = Color(0xFFF3E5F5); // Purple 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF4A148C); // Purple 900
const _kMuted = Color(0xFFCE93D8); // Purple 200
const _kCodeBg = Color(0xFFF9FBE7); // LightGreen 50
const _kHighlight = Color(0xFFFFF9C4); // Yellow 100
const _kCocoaColor = Color(0xFF00838F); // Cyan 800
const _kPropertyColor = Color(0xFF2E7D32); // Green 800
const _kMethodColor = Color(0xFFC62828); // Red 800
const _kMacColor = Color(0xFF37474F); // BlueGrey 800

class _MacOSControllerDemo extends StatefulWidget {
  @override
  State<_MacOSControllerDemo> createState() => _MacOSControllerDemoState();
}

class _MacOSControllerDemoState extends State<_MacOSControllerDemo>
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
        title: Text('RegularWindowControllerMacOS',
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
            Tab(text: 'Cocoa Simulator'),
            Tab(text: 'AppKit Patterns'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _CocoaSimulatorTab(),
          _AppKitPatternsTab(),
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
          _buildCocoaArchitectureCard(),
          SizedBox(height: 14),
          _buildPropertiesCard(),
          SizedBox(height: 14),
          _buildMethodsCard(),
          SizedBox(height: 14),
          _buildNSWindowStyleCard(),
          SizedBox(height: 14),
          _buildLifecycleCard(),
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
                  color: _kMacColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.laptop_mac, color: _kMacColor, size: 28),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RegularWindowControllerMacOS',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _kDarkText)),
                    SizedBox(height: 3),
                    Text('macOS-specific window controller using Cocoa',
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
              'RegularWindowControllerMacOS is the macOS platform implementation '
              'of RegularWindowController. It wraps Cocoa\'s NSWindow and '
              'NSWindowController to provide native window management on macOS. '
              'It translates Flutter\'s windowing API into Objective-C / Swift '
              'calls through the macOS embedding layer.',
              style: TextStyle(
                  fontSize: 12.5, color: _kDarkText, height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _infoBadge('macOS Only', _kMacColor),
              SizedBox(width: 6),
              _infoBadge('Cocoa/AppKit', _kCocoaColor),
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
          _hierarchyRow('ChangeNotifier', 0, Colors.grey[600]!,
              'Foundation mixin'),
          _hierarchyRow('BaseWindowController', 1, Color(0xFF5D4037),
              'Window lifecycle base'),
          _hierarchyRow('RegularWindowController', 2, Color(0xFF1565C0),
              'Abstract regular window'),
          _hierarchyRow('RegularWindowControllerMacOS', 3, _kMacColor,
              'Cocoa / NSWindow implementation'),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.link, size: 14, color: _kCocoaColor),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'On macOS the controller also conforms to '
                    'NSWindowDelegate for receiving native Cocoa '
                    'notifications about window lifecycle events.',
                    style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey[700],
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

  Widget _hierarchyRow(String name, int depth, Color color, String desc) {
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
          Flexible(
            child: Text(desc,
                style: TextStyle(fontSize: 10.5, color: Colors.grey[500])),
          ),
        ],
      ),
    );
  }

  Widget _buildCocoaArchitectureCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kCocoaColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.architecture, size: 20, color: _kCocoaColor),
              SizedBox(width: 8),
              Text('Cocoa Architecture',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 14),
          _cocoaLayer('Flutter Widget Tree', 'Your app UI',
              Color(0xFF1565C0)),
          _cocoaArrow(),
          _cocoaLayer('RegularWindowControllerMacOS',
              'Dart-side controller', _kPrimary),
          _cocoaArrow(),
          _cocoaLayer('FlutterViewController',
              'macOS embedding layer (ObjC/Swift)', Color(0xFF5D4037)),
          _cocoaArrow(),
          _cocoaLayer('NSWindowController + NSWindow',
              'Cocoa window management', _kCocoaColor),
          _cocoaArrow(),
          _cocoaLayer('Core Animation + Metal',
              'Rendering pipeline', Color(0xFFBF360C)),
          _cocoaArrow(),
          _cocoaLayer('WindowServer',
              'macOS display compositor', Colors.grey[600]!),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'macOS uses an NSWindowController as the primary coordinator '
              'between the Flutter engine and the Cocoa window system. Each '
              'Flutter view is backed by an FlutterView (NSView subclass) '
              'with Metal rendering.',
              style: TextStyle(
                  fontSize: 11.5, color: _kDarkText, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cocoaLayer(String name, String desc, Color color) {
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
              Text(desc,
                  style: TextStyle(
                      fontSize: 10.5, color: Colors.grey[500])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cocoaArrow() {
    return Padding(
      padding: EdgeInsets.only(left: 2, top: 1, bottom: 1),
      child: Icon(Icons.arrow_downward, size: 14, color: Colors.grey[400]),
    );
  }

  Widget _buildPropertiesCard() {
    final props = <Map<String, dynamic>>[
      {
        'name': 'contentSize',
        'type': 'Size',
        'desc': 'Current content area rect (NSView frame)',
        'icon': Icons.aspect_ratio,
      },
      {
        'name': 'title',
        'type': 'String',
        'desc': 'NSWindow.title — shown in title bar and Dock',
        'icon': Icons.title,
      },
      {
        'name': 'isActivated',
        'type': 'bool',
        'desc': 'NSWindow.isKeyWindow — has keyboard focus',
        'icon': Icons.flash_on,
      },
      {
        'name': 'isMaximized',
        'type': 'bool',
        'desc': 'NSWindow.isZoomed — zoomed to fill screen',
        'icon': Icons.fullscreen,
      },
      {
        'name': 'isMinimized',
        'type': 'bool',
        'desc': 'NSWindow.isMiniaturized — in the Dock',
        'icon': Icons.minimize,
      },
      {
        'name': 'isFullscreen',
        'type': 'bool',
        'desc': 'fullScreenContentFrame — in full-screen Space',
        'icon': Icons.fullscreen_exit,
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
          Text('Mapped to NSWindow properties',
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
                        color: _kPropertyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(p['icon'] as IconData,
                          size: 15, color: _kPropertyColor),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 86,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['name'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w600,
                                  color: _kPropertyColor)),
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
        'method': 'setSize(Size)',
        'cocoa': '[window setContentSize:]',
        'note': 'Sets the NSView content frame',
      },
      {
        'method': 'setConstraints(BoxConstraints)',
        'cocoa': 'minSize / maxSize',
        'note': 'NSWindow min/max size limits',
      },
      {
        'method': 'setTitle(String)',
        'cocoa': '[window setTitle:]',
        'note': 'Updates title bar and Dock tooltip',
      },
      {
        'method': 'activate()',
        'cocoa': '[window makeKeyAndOrderFront:]',
        'note': 'Brings window to front, makes key',
      },
      {
        'method': 'maximize()',
        'cocoa': '[window zoom:]',
        'note': 'Toggles zoom state (fills screen)',
      },
      {
        'method': 'minimize()',
        'cocoa': '[window miniaturize:]',
        'note': 'Miniaturize to Dock',
      },
      {
        'method': 'restore()',
        'cocoa': '[window deminiaturize:]',
        'note': 'Restore from Dock miniature',
      },
      {
        'method': 'destroy()',
        'cocoa': '[window close] / [window orderOut:]',
        'note': 'Close and release the window',
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
          Text('Methods \u2192 Cocoa Mapping',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          ...methods.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kCodeBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(m['method']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w600,
                                  color: _kMethodColor)),
                          Spacer(),
                          Text(m['cocoa']!,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: _kCocoaColor)),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(m['note']!,
                          style: TextStyle(
                              fontSize: 10.5,
                              color: Colors.grey[600])),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildNSWindowStyleCard() {
    final styles = <Map<String, String>>[
      {
        'name': 'titled',
        'mask': 'NSWindowStyleMask.titled',
        'desc': 'Window has a title bar',
      },
      {
        'name': 'closable',
        'mask': 'NSWindowStyleMask.closable',
        'desc': 'Red close button is enabled',
      },
      {
        'name': 'miniaturizable',
        'mask': 'NSWindowStyleMask.miniaturizable',
        'desc': 'Yellow minimize button is enabled',
      },
      {
        'name': 'resizable',
        'mask': 'NSWindowStyleMask.resizable',
        'desc': 'Window can be resized by dragging edges',
      },
      {
        'name': 'fullSizeContentView',
        'mask': 'NSWindowStyleMask.fullSizeContentView',
        'desc': 'Content extends behind title bar',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kCocoaColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.style, size: 18, color: _kCocoaColor),
              SizedBox(width: 8),
              Text('NSWindowStyleMask',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 4),
          Text('Bitmask that defines window chrome features',
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 12),
          ...styles.map((s) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: _kCocoaColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s['mask']!,
                              style: TextStyle(
                                  fontSize: 10.5,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w600,
                                  color: _kCocoaColor)),
                          SizedBox(height: 1),
                          Text(s['desc']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600])),
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

  Widget _buildLifecycleCard() {
    final phases = <Map<String, dynamic>>[
      {
        'phase': 'Allocated',
        'native': 'alloc/init',
        'color': Colors.grey[600],
      },
      {
        'phase': 'Ordered Front',
        'native': 'makeKeyAndOrderFront:',
        'color': _kPrimary,
      },
      {
        'phase': 'Became Key',
        'native': 'windowDidBecomeKey:',
        'color': _kPropertyColor,
      },
      {
        'phase': 'Active',
        'native': '(user interaction)',
        'color': _kAccent,
      },
      {
        'phase': 'Should Close',
        'native': 'windowShouldClose:',
        'color': Color(0xFFE65100),
      },
      {
        'phase': 'Will Close',
        'native': 'windowWillClose:',
        'color': _kMethodColor,
      },
      {
        'phase': 'Released',
        'native': 'dealloc',
        'color': Colors.grey[800],
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
          Text('NSWindow Lifecycle',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          ...phases.asMap().entries.map((e) {
            final isLast = e.key == phases.length - 1;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: (e.value['color'] as Color?)
                                ?.withOpacity(0.15) ??
                            Colors.grey[200],
                        border: Border.all(
                            color: e.value['color'] as Color? ??
                                Colors.grey),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text('${e.key + 1}',
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: e.value['color'] as Color?)),
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.value['phase'] as String,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: e.value['color'] as Color?)),
                        Text(e.value['native'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: Colors.grey[500])),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
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
            fontSize: 10, fontWeight: FontWeight.w600, color: color)),
  );
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Cocoa Simulator
// ═══════════════════════════════════════════════════════════

class _CocoaSimulatorTab extends StatefulWidget {
  @override
  State<_CocoaSimulatorTab> createState() => _CocoaSimulatorTabState();
}

class _CocoaSimulatorTabState extends State<_CocoaSimulatorTab> {
  String _windowTitle = 'My App Window';
  double _windowWidth = 260;
  double _windowHeight = 170;
  bool _isKey = true;
  bool _isZoomed = false;
  bool _isMiniaturized = false;
  bool _isFullScreen = false;
  String _selectedAppearance = 'Aqua';
  final List<String> _cocoaLog = [];

  void _log(String msg) {
    setState(() {
      _cocoaLog.insert(0, msg);
      if (_cocoaLog.length > 25) _cocoaLog.removeLast();
    });
    print('Cocoa: $msg');
  }

  void _toggleZoom() {
    setState(() {
      _isZoomed = !_isZoomed;
      if (_isZoomed) {
        _isMiniaturized = false;
        _isFullScreen = false;
      }
    });
    _log(_isZoomed
        ? '[window zoom:self]'
        : '[window zoom:self] // unzoom');
  }

  void _toggleMiniaturize() {
    setState(() {
      _isMiniaturized = !_isMiniaturized;
      if (_isMiniaturized) {
        _isZoomed = false;
        _isFullScreen = false;
      }
    });
    _log(_isMiniaturized
        ? '[window miniaturize:self]'
        : '[window deminiaturize:self]');
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        _isZoomed = false;
        _isMiniaturized = false;
      }
    });
    _log('[window toggleFullScreen:self]');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMacWindowPreview(),
          SizedBox(height: 14),
          _buildStateControlsCard(),
          SizedBox(height: 14),
          _buildSizeControlCard(),
          SizedBox(height: 14),
          _buildTitleCard(),
          SizedBox(height: 14),
          _buildAppearanceCard(),
          SizedBox(height: 14),
          _buildNSWindowInspector(),
          SizedBox(height: 14),
          _buildCocoaLogCard(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMacWindowPreview() {
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
          Text('NSWindow Preview',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText)),
          SizedBox(height: 12),
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _isZoomed || _isFullScreen
                  ? MediaQuery.of(context).size.width - 64
                  : _isMiniaturized
                      ? 80
                      : _windowWidth.clamp(140.0, 340.0),
              height: _isMiniaturized ? 24 : _windowHeight.clamp(80.0, 240.0),
              decoration: BoxDecoration(
                color: _selectedAppearance == 'Aqua'
                    ? Color(0xFFECEFF1)
                    : Color(0xFF303030),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  if (_isKey && !_isMiniaturized)
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                children: [
                  // macOS title bar with traffic lights
                  Container(
                    height: 24,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _selectedAppearance == 'Aqua'
                            ? [Color(0xFFE8E8E8), Color(0xFFD0D0D0)]
                            : [Color(0xFF3D3D3D), Color(0xFF2D2D2D)],
                      ),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        // Traffic lights
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _isKey
                                ? Color(0xFFFF5F57)
                                : Colors.grey[400],
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color(0xFFE0443E).withOpacity(0.5),
                                width: 0.5),
                          ),
                        ),
                        SizedBox(width: 6),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _isKey
                                ? Color(0xFFFEBC2E)
                                : Colors.grey[400],
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color(0xFFDEA123).withOpacity(0.5),
                                width: 0.5),
                          ),
                        ),
                        SizedBox(width: 6),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _isKey
                                ? Color(0xFF28C840)
                                : Colors.grey[400],
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color(0xFF1DAD2B).withOpacity(0.5),
                                width: 0.5),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _windowTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: _selectedAppearance == 'Aqua'
                                  ? Colors.black87
                                  : Colors.white70,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  if (!_isMiniaturized)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedAppearance == 'Aqua'
                              ? Colors.white
                              : Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(8)),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.laptop_mac,
                                size: 22,
                                color: _selectedAppearance == 'Aqua'
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                              SizedBox(height: 3),
                              Text(
                                '${_windowWidth.toInt()} \u00D7 '
                                '${_windowHeight.toInt()}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: Colors.grey[500]),
                              ),
                              if (_isFullScreen)
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Text('FULL SCREEN',
                                      style: TextStyle(
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w700,
                                          color: _kCocoaColor)),
                                ),
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

  Widget _buildStateControlsCard() {
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
          Text('Window State',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText)),
          SizedBox(height: 12),
          Row(
            children: [
              _macStateBtn('Key', Icons.flash_on, _isKey,
                  Color(0xFF1565C0), () {
                setState(() => _isKey = !_isKey);
                _log(_isKey
                    ? '[window makeKeyAndOrderFront:self]'
                    : 'windowDidResignKey:');
              }),
              SizedBox(width: 6),
              _macStateBtn('Zoom', Icons.fullscreen, _isZoomed,
                  _kPrimary, _toggleZoom),
              SizedBox(width: 6),
              _macStateBtn('Mini', Icons.minimize, _isMiniaturized,
                  Color(0xFFE65100), _toggleMiniaturize),
              SizedBox(width: 6),
              _macStateBtn('Full', Icons.fullscreen_exit, _isFullScreen,
                  _kMethodColor, _toggleFullScreen),
            ],
          ),
        ],
      ),
    );
  }

  Widget _macStateBtn(String label, IconData icon, bool active,
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
          Text('setContentSize:',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  color: _kDarkText)),
          SizedBox(height: 10),
          Row(
            children: [
              Text('W:', style: TextStyle(fontSize: 11, color: Colors.grey[700])),
              Expanded(
                child: Slider(
                  value: _windowWidth,
                  min: 140,
                  max: 340,
                  activeColor: _kPrimary,
                  onChanged: (v) {
                    setState(() => _windowWidth = v);
                    _log('[window setContentSize:NSMakeSize'
                        '(${v.toInt()}, ${_windowHeight.toInt()})]');
                  },
                ),
              ),
              SizedBox(
                width: 36,
                child: Text('${_windowWidth.toInt()}',
                    style: TextStyle(
                        fontSize: 11, fontFamily: 'monospace')),
              ),
            ],
          ),
          Row(
            children: [
              Text('H:', style: TextStyle(fontSize: 11, color: Colors.grey[700])),
              Expanded(
                child: Slider(
                  value: _windowHeight,
                  min: 80,
                  max: 240,
                  activeColor: _kAccent,
                  onChanged: (v) {
                    setState(() => _windowHeight = v);
                    _log('[window setContentSize:NSMakeSize'
                        '(${_windowWidth.toInt()}, ${v.toInt()})]');
                  },
                ),
              ),
              SizedBox(
                width: 36,
                child: Text('${_windowHeight.toInt()}',
                    style: TextStyle(
                        fontSize: 11, fontFamily: 'monospace')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleCard() {
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
          Text('setTitle:',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  color: _kDarkText)),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'NSWindow Title',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _kPrimary, width: 2),
              ),
              filled: true,
              fillColor: _kSurface,
              isDense: true,
            ),
            onChanged: (v) {
              setState(
                  () => _windowTitle = v.isNotEmpty ? v : 'Untitled');
              _log('[window setTitle:@"$_windowTitle"]');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kCocoaColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NSAppearance',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText)),
          SizedBox(height: 4),
          Text('macOS appearance affects window chrome rendering',
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 10),
          Row(
            children: [
              _appearanceChip('Aqua'),
              SizedBox(width: 8),
              _appearanceChip('DarkAqua'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appearanceChip(String name) {
    final isSelected = _selectedAppearance == name;
    final isDark = name == 'DarkAqua';
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedAppearance = name);
          _log(
              '[window setAppearance:[NSAppearance '
              'appearanceNamed:NSAppearanceName$name]]');
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? Color(0xFF2D2D2D) : Color(0xFFF5F5F5),
            border: Border.all(
              color: isSelected ? _kPrimary : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF5F57),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 3),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color(0xFFFEBC2E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 3),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color(0xFF28C840),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(name,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNSWindowInspector() {
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
              Text('NSWindow Inspector',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
            ],
          ),
          SizedBox(height: 12),
          _inspectorRow('title', '@"$_windowTitle"'),
          _inspectorRow('contentSize',
              'NSMakeSize(${_windowWidth.toInt()}, ${_windowHeight.toInt()})'),
          _inspectorRow('isKeyWindow', '$_isKey'),
          _inspectorRow('isZoomed', '$_isZoomed'),
          _inspectorRow('isMiniaturized', '$_isMiniaturized'),
          _inspectorRow('isFullScreen', '$_isFullScreen'),
          _inspectorRow('appearance', 'NSAppearanceName$_selectedAppearance'),
        ],
      ),
    );
  }

  Widget _inspectorRow(String name, String value) {
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

  Widget _buildCocoaLogCard() {
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
              Icon(Icons.terminal, size: 18, color: _kCocoaColor),
              SizedBox(width: 8),
              Text('Objective-C Message Log',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
              Spacer(),
              GestureDetector(
                onTap: () => setState(() => _cocoaLog.clear()),
                child: Text('Clear',
                    style: TextStyle(
                        fontSize: 10, color: Colors.grey[500])),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: _cocoaLog.isEmpty
                ? Center(
                    child: Text(
                        'Interact with controls to emit Cocoa messages',
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey[600])),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: _cocoaLog.length,
                    itemBuilder: (_, i) => Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\u25B8 ',
                              style: TextStyle(
                                  fontSize: 10.5,
                                  color: _kAccent)),
                          Expanded(
                            child: Text(
                              _cocoaLog[i],
                              style: TextStyle(
                                  fontSize: 10.5,
                                  fontFamily: 'monospace',
                                  color: Color(0xFFCE93D8)),
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
//  TAB 3  –  AppKit Patterns
// ═══════════════════════════════════════════════════════════

class _AppKitPatternsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDelegateMethodsCard(),
          SizedBox(height: 14),
          _buildNotificationsCard(),
          SizedBox(height: 14),
          _buildFullScreenTransitionCard(),
          SizedBox(height: 14),
          _buildToolbarIntegrationCard(),
          SizedBox(height: 14),
          _buildMultiWindowPatternCard(),
          SizedBox(height: 14),
          _buildBestPracticesCard(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDelegateMethodsCard() {
    final methods = <Map<String, String>>[
      {
        'method': 'windowShouldClose:',
        'returns': 'BOOL',
        'purpose': 'Veto close — show unsaved changes dialog',
      },
      {
        'method': 'windowWillClose:',
        'returns': 'void',
        'purpose': 'Clean up resources before window deallocates',
      },
      {
        'method': 'windowDidBecomeKey:',
        'returns': 'void',
        'purpose': 'Window gained keyboard focus',
      },
      {
        'method': 'windowDidResignKey:',
        'returns': 'void',
        'purpose': 'Window lost keyboard focus',
      },
      {
        'method': 'windowDidResize:',
        'returns': 'void',
        'purpose': 'Window frame changed — update layout',
      },
      {
        'method': 'windowDidMiniaturize:',
        'returns': 'void',
        'purpose': 'Window was sent to the Dock',
      },
      {
        'method': 'windowDidDeminiaturize:',
        'returns': 'void',
        'purpose': 'Window was restored from the Dock',
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
          Text('NSWindowDelegate Methods',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 4),
          Text(
              'Cocoa callbacks forwarded to '
              'RegularWindowControllerDelegate',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '- (${m['returns']!})${m['method']!}',
                              style: TextStyle(
                                  fontSize: 10.5,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w600,
                                  color: _kCocoaColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(m['purpose']!,
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey[600])),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildNotificationsCard() {
    final notifications = <Map<String, String>>[
      {
        'name': 'NSWindowDidBecomeKeyNotification',
        'desc': 'Posted when window becomes the key (focused) window',
      },
      {
        'name': 'NSWindowDidResignKeyNotification',
        'desc': 'Posted when window is no longer the key window',
      },
      {
        'name': 'NSWindowDidResizeNotification',
        'desc': 'Posted when the window frame size changes',
      },
      {
        'name': 'NSWindowWillCloseNotification',
        'desc': 'Posted just before the window closes',
      },
      {
        'name': 'NSWindowDidMoveNotification',
        'desc': 'Posted when the window origin changes',
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
          Row(
            children: [
              Icon(Icons.notifications_active,
                  size: 18, color: _kPrimary),
              SizedBox(width: 8),
              Text('NSNotification Center',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 4),
          Text('macOS uses NSNotificationCenter for window events',
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 12),
          ...notifications.map((n) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: _kAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(n['name']!,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w600,
                                  color: _kCocoaColor)),
                          Text(n['desc']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600])),
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

  Widget _buildFullScreenTransitionCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kCocoaColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.aspect_ratio, size: 18, color: _kCocoaColor),
              SizedBox(width: 8),
              Text('Full-Screen Transition',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 12),
          _transitionStep(1, 'toggleFullScreen: sent',
              'User clicks green button or ^^F', Color(0xFF1565C0)),
          _transitionStep(2, 'windowWillEnterFullScreen:',
              'Delegate notified, prepare animation', _kPrimary),
          _transitionStep(3, 'Cocoa animation plays',
              'System slides window into dedicated Space',
              _kCocoaColor),
          _transitionStep(4, 'windowDidEnterFullScreen:',
              'Transition complete, update Flutter state',
              _kPropertyColor),
          _transitionStep(5, 'notifyListeners()',
              'ChangeNotifier fires, UI rebuilds', _kAccent),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'macOS full-screen transitions create a new Space and include '
              'a slide animation. This is different from Linux/Windows '
              'fullscreen which just resizes the window in-place.',
              style: TextStyle(
                  fontSize: 11.5, color: _kDarkText, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transitionStep(
      int step, String title, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              border: Border.all(color: color.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text('$step',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color)),
                Text(desc,
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarIntegrationCard() {
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
          Row(
            children: [
              Icon(Icons.view_headline, size: 18, color: _kPrimary),
              SizedBox(width: 8),
              Text('NSToolbar Integration',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('macOS windows can integrate with NSToolbar:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _kDarkText)),
                SizedBox(height: 8),
                _toolbarItem('Unified title + toolbar',
                    'titlebarAppearsTransparent = YES'),
                _toolbarItem('Title visibility',
                    'titleVisibility = .hidden'),
                _toolbarItem('Toolbar style',
                    'toolbarStyle = .unified / .unifiedCompact'),
                _toolbarItem('Full-size content view',
                    'styleMask |= .fullSizeContentView'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Flutter on macOS typically uses fullSizeContentView to '
            'render Flutter content behind the title bar for a '
            'modern macOS look.',
            style: TextStyle(
                fontSize: 11.5, color: Colors.grey[700], height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _toolbarItem(String title, String code) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.chevron_right, size: 14, color: _kCocoaColor),
          SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _kDarkText)),
                Text(code,
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: _kCocoaColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiWindowPatternCard() {
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
          Text('Multi-Window Pattern on macOS',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('// Create a secondary window',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: Colors.grey[500])),
                SizedBox(height: 2),
                Text('final controller = RegularWindowController(',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: _kDarkText)),
                Text('  preferredSize: Size(800, 600),',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: _kDarkText)),
                Text('  title: "Settings",',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: _kDarkText)),
                Text('  delegate: myDelegate,',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: _kDarkText)),
                Text(');',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: _kDarkText)),
                SizedBox(height: 6),
                Text('// On macOS this creates an NSWindowController',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: Colors.grey[500])),
                Text('// with an associated NSWindow and',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: Colors.grey[500])),
                Text('// FlutterViewController for rendering.',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: Colors.grey[500])),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kPrimary.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.window,
                          size: 20, color: _kPrimary),
                      SizedBox(height: 4),
                      Text('Main Window',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _kPrimary)),
                      Text('AppDelegate',
                          style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey[500])),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(Icons.arrow_forward,
                    size: 16, color: Colors.grey[400]),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kCocoaColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.window,
                          size: 20, color: _kCocoaColor),
                      SizedBox(height: 4),
                      Text('Child Window',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _kCocoaColor)),
                      Text('WindowController',
                          style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey[500])),
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

  Widget _buildBestPracticesCard() {
    final practices = <Map<String, String>>[
      {
        'title': 'Respect Appearances',
        'detail': 'Use NSAppearance-aware colors. Don\'t hard-code '
            'light or dark theme values — let the system handle '
            'appearance changes.',
      },
      {
        'title': 'Handle Full-Screen Spaces',
        'detail': 'macOS full-screen creates a dedicated Space. Ensure '
            'your UI adapts to both windowed and full-screen layouts.',
      },
      {
        'title': 'Save/Restore Frames',
        'detail': 'Use setFrameAutosaveName: to let macOS remember '
            'window position and size across launches.',
      },
      {
        'title': 'Close Confirmation',
        'detail': 'Implement windowShouldClose: via the delegate to '
            'prompt for unsaved changes before allowing close.',
      },
      {
        'title': 'Avoid Blocking the Main Thread',
        'detail': 'Cocoa window operations happen on the main thread. '
            'Heavy computation should be dispatched elsewhere.',
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
              Icon(Icons.star, size: 18, color: _kAccent),
              SizedBox(width: 8),
              Text('macOS Best Practices',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 12),
          ...practices.asMap().entries.map((e) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _kAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
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
